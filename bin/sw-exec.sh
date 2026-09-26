#!/usr/bin/env bash
set -euo pipefail

# StepWise execution boundary.
#
# v0.1.2 (human-controlled prompt): sw-client.sh is the sole caller of this
# script. The command text it receives has already been reviewed and run
# by a human via sw-client.sh; this script executes it and reports the
# real exit status back to the caller. No envelope/authorization binding
# exists yet at this scope — that is Phase 2 (autonomous/agentic) work,
# see docs/sw-client-v0.1.2-scope.md.

if [[ "${1:-}" == "--library" ]]; then
  # Sourced form kept for compatibility with earlier Phase-2 scaffolding.
  return 0 2>/dev/null || exit 0
fi

COMMAND_TEXT="${1:-}"
[[ -n "$COMMAND_TEXT" ]] || { printf 'sw-exec: empty command\n' >&2; exit 1; }

bash -c "$COMMAND_TEXT"
