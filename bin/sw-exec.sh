#!/usr/bin/env bash
set -euo pipefail

# StepWise execution wrapper.
# This file deliberately exposes no generic "execute arbitrary command" CLI.
# Production execution must receive a validated, authorization-bound command
# envelope from sw-client.sh.

if [[ "${1:-}" == "--library" ]]; then
  # Sourced by sw-client.sh only to make the execution boundary explicit.
  return 0 2>/dev/null || exit 0
fi

printf '%s\n' \
  "SW-EXEC: BLOCKED" \
  "Direct execution is not available in the Phase 2 scaffold." \
  "Use sw-client.sh with a canonical, validated, authorized envelope."
exit 1
