#!/usr/bin/env bash
set -euo pipefail

# StepWise local enforcement boundary.
# Usage:
#   sw-client.sh <proposal-envelope>
#
# The envelope is expected to contain, at minimum:
#   proposal_id
#   session_id
#   action
#   command
#   command_hash
#   policy_decision
#   authorization_state
#   authorization_hash
#
# This scaffold intentionally fails closed until the canonical schema/policy
# implementation is connected.

die() { printf 'SW-CLIENT: BLOCKED: %s\n' "$*" >&2; exit 1; }
require_cmd() { command -v "$1" >/dev/null 2>&1 || die "required command not found: $1"; }

SELF_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
H="${STEPWISE_HOME:-$(CDPATH= cd -- "$SELF_DIR/.." && pwd)}"

require_cmd bash
require_cmd sha256sum

ENVELOPE="${1:-}"
[[ -n "$ENVELOPE" ]] || die "proposal envelope is required"
[[ -f "$ENVELOPE" ]] || die "proposal envelope not found: $ENVELOPE"

# shellcheck source=/dev/null
source "$SELF_DIR/sw-exec.sh" --library || die "failed to load execution wrapper"

# Canonical integration points. These commands are expected to fail closed
# until their concrete repository implementations are present.
POLICY_SCRIPT="${STEPWISE_POLICY_SCRIPT:-$SELF_DIR/sw-policy.sh}"
AUTHORIZE_SCRIPT="${STEPWISE_AUTHORIZE_SCRIPT:-$SELF_DIR/sw-authorize.sh}"
VERIFY_SCRIPT="${STEPWISE_VERIFY_SCRIPT:-$SELF_DIR/sw-verify.sh}"

[[ -x "$POLICY_SCRIPT" ]] || die "policy enforcement component is not installed"
[[ -x "$AUTHORIZE_SCRIPT" ]] || die "authorization component is not installed"
[[ -x "$VERIFY_SCRIPT" ]] || die "verification component is not installed"

# JSON parsing is intentionally not implemented with ad-hoc text extraction.
# Production integration must use the canonical command-envelope schema.
die "scaffold only: connect canonical envelope parser/schema before execution"
