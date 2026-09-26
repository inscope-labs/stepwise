#!/usr/bin/env bash
# sw-client.sh — StepWise v0.1.2 human-controlled execution wrapper.
#
# Scope: docs/sw-client-v0.1.2-scope.md
#   * Wrap the AI-proposed command in one canonical local surface.
#   * Hash the exact command text before anything executes.
#   * Execute through sw-exec.sh (the internal boundary).
#   * Append one local record per step to a JSONL ledger.
#   * Fail closed on empty command, missing boundary, unwritable ledger.
#
# Out of scope at v0.1.2 (scaffolded elsewhere, not wired here):
#   authorization tokens, revocation, policy ALLOW/REQUIRE_APPROVAL/DENY,
#   verify-binding, credential redaction, delegation, context tiers.
#   POLICY_SCRIPT exists only as a reserved no-op hook for Phase 2.

set -euo pipefail

readonly SW_VERSION="0.1.2"

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
SW_EXEC="${SW_EXEC:-$SCRIPT_DIR/sw-exec.sh}"
POLICY_SCRIPT="${POLICY_SCRIPT:-}"

STEPWISE_HOME="${STEPWISE_HOME:-$HOME/.stepwise}"
LEDGER_DIR="$STEPWISE_HOME/ledger"
SESSION_FILE="$STEPWISE_HOME/session.id"

fail() { printf 'sw-client: %s\n' "$*" >&2; exit 1; }

json_escape() {
  local s=$1
  s=${s//\\/\\\\}
  s=${s//\"/\\\"}
  s=${s//$'\n'/\\n}
  s=${s//$'\r'/\\r}
  s=${s//$'\t'/\\t}
  printf '%s' "$s"
}

hash_command() {
  printf '%s' "$1" | sha256sum | awk '{print $1}'
}

resolve_session_id() {
  if [[ -n "${STEPWISE_SESSION_ID:-}" ]]; then
    printf '%s' "$STEPWISE_SESSION_ID"; return 0
  fi
  if [[ -r "$SESSION_FILE" ]]; then
    local id; id=$(<"$SESSION_FILE")
    [[ -n "$id" ]] && { printf '%s' "$id"; return 0; }
  fi
  mkdir -p -- "$STEPWISE_HOME" || return 1
  local new_id; new_id="s-$(date -u +%Y%m%dT%H%M%SZ)-$$"
  printf '%s' "$new_id" > "$SESSION_FILE" || return 1
  printf '%s' "$new_id"
}

next_step_id() {
  local ledger_file=$1 n
  if [[ -f "$ledger_file" ]]; then
    n=$(grep -c . "$ledger_file" 2>/dev/null) || n=0
  else
    n=0
  fi
  printf '%d' "$((n + 1))"
}

write_ledger() {
  local ledger_file=$1 session_id=$2 step_id=$3 ts=$4 cmd=$5 hash=$6 status=$7
  local esc_cmd esc_session record
  esc_cmd=$(json_escape "$cmd")
  esc_session=$(json_escape "$session_id")
  record=$(printf '{"session_id":"%s","step_id":%s,"timestamp":"%s","command":"%s","hash":"%s","exit_status":%s}\n' \
    "$esc_session" "$step_id" "$ts" "$esc_cmd" "$hash" "$status")

  if command -v flock >/dev/null 2>&1; then
    { flock 9; printf '%s\n' "$record" >&9; } 9>>"$ledger_file" || return 1
  else
    printf '%s\n' "$record" >>"$ledger_file" || return 1
  fi
  return 0
}

print_version() { printf 'sw-client %s\n' "$SW_VERSION"; }

self_check() {
  local ok=1
  # Bootstrap the home/ledger dirs if absent. Creating empty directories
  # has no observable side effect worth gating on, so this stays
  # consistent with --check being read-only in every way that matters.
  mkdir -p -- "$STEPWISE_HOME" "$LEDGER_DIR" 2>/dev/null || true
  printf 'sw-client %s self-check\n' "$SW_VERSION"
  printf '  script dir      : %s\n' "$SCRIPT_DIR"
  printf '  sw-exec.sh      : %s\n' "$SW_EXEC"
  if [[ -x "$SW_EXEC" ]]; then
    printf '    status        : present and executable\n'
  else
    printf '    status        : MISSING or not executable\n'; ok=0
  fi
  printf '  sha256sum       : '
  if command -v sha256sum >/dev/null 2>&1; then printf 'present\n'
  else printf 'MISSING\n'; ok=0; fi
  printf '  stepwise home   : %s\n' "$STEPWISE_HOME"
  printf '  ledger dir      : %s\n' "$LEDGER_DIR"
  if [[ -w "$LEDGER_DIR" ]] || [[ -w "$(dirname -- "$LEDGER_DIR")" ]]; then
    printf '    status        : writable\n'
  else
    printf '    status        : not writable\n'; ok=0
  fi
  if [[ -n "$POLICY_SCRIPT" ]]; then
    printf '  policy script   : %s\n' "$POLICY_SCRIPT"
    [[ -x "$POLICY_SCRIPT" ]] || { printf '    status        : not executable\n'; ok=0; }
  else
    printf '  policy script   : <unset — no-op pass-through>\n'
  fi
  if [[ $ok -eq 1 ]]; then printf 'result: OK\n'; return 0
  else printf 'result: FAIL\n'; return 1; fi
}

usage() {
  cat <<'EOF'
sw-client.sh — StepWise human-controlled execution wrapper.
EOF
}

main() {
  local mode=${1:-}
  case "$mode" in
    "" ) fail "no command provided" ;;
    --version|-V ) print_version; exit 0 ;;
    --check|-c ) if self_check; then exit 0; else exit 1; fi ;;
    --help|-h ) usage; exit 0 ;;
    --* ) fail "unknown option: $mode" ;;
  esac

  local command_text=${1:-}
  [[ -n "$command_text" ]] || fail "empty command — refusing to run"

  [[ -x "$SW_EXEC" ]] || fail "internal boundary '$SW_EXEC' is missing or not executable"
  command -v sha256sum >/dev/null 2>&1 || fail "sha256sum not available"

  if [[ -n "$POLICY_SCRIPT" ]]; then
    [[ -x "$POLICY_SCRIPT" ]] || fail "POLICY_SCRIPT set but not executable: $POLICY_SCRIPT"
    "$POLICY_SCRIPT" "$command_text" || fail "policy hook rejected command"
  fi

  local session_id ts hash ledger_file step_id
  session_id=$(resolve_session_id) || fail "cannot resolve session id"
  mkdir -p -- "$LEDGER_DIR" || fail "cannot create ledger dir $LEDGER_DIR"
  ledger_file="$LEDGER_DIR/${session_id}.jsonl"
  : >> "$ledger_file" 2>/dev/null || fail "ledger not writable: $ledger_file"

  ts=$(date -u +%Y-%m-%dT%H:%M:%SZ)
  hash=$(hash_command "$command_text") || fail "hashing failed"
  step_id=$(next_step_id "$ledger_file") || fail "cannot compute step id"

  local exit_status=0
  "$SW_EXEC" "$command_text" || exit_status=$?

  write_ledger "$ledger_file" "$session_id" "$step_id" "$ts" \
               "$command_text" "$hash" "$exit_status" \
    || fail "could not write ledger entry"

  return "$exit_status"
}

main "$@"
