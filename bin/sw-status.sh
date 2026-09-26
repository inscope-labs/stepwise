#!/usr/bin/env bash
set -euo pipefail

# StepWise session / governance status.
# Usage:
#   sw-status.sh [--session <id>] [--json]
#
# Displays current session, objective, authorization, policy, risk and
# context state. Read-only; never executes actions.

die() { printf 'SW-STATUS: ERROR: %s\n' "$*" >&2; exit 1; }

# Phase-1 scaffold: no live session store is connected.
printf '%s\n' \
  "StepWise status (scaffold)" \
  "No active session store is connected." \
  "No authorization, policy or risk state is available." \
  "This command is read-only and performs no execution."
exit 0
