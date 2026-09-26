#!/usr/bin/env bash
set -euo pipefail

# StepWise human authorization gate.
# Usage:
#   sw-authorize.sh <proposal-envelope>
#
# Authorization must bind to the exact canonical action/command hash.
# AI output is never accepted as authorization.

die() { printf 'SW-AUTHORIZE: BLOCKED: %s\n' "$*" >&2; exit 1; }

MODE="${1:-}"
if [[ "$MODE" == "--library" ]]; then
  return 0 2>/dev/null || exit 0
fi

ENVELOPE="${MODE:-}"
[[ -n "$ENVELOPE" ]] || die "proposal envelope is required"
[[ -f "$ENVELOPE" ]] || die "proposal envelope not found: $ENVELOPE"

printf '%s\n' \
  "StepWise authorization gate" \
  "Authorization is not implemented in this scaffold." \
  "No command has been authorized." \
  "No execution may proceed."

exit 1
