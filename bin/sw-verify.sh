#!/usr/bin/env bash
set -euo pipefail

# StepWise post-execution verification gate.
# Usage:
#   sw-verify.sh <execution-record>

die() { printf 'SW-VERIFY: FAILED: %s\n' "$*" >&2; exit 1; }

RECORD="${1:-}"
[[ -n "$RECORD" ]] || die "execution record is required"
[[ -f "$RECORD" ]] || die "execution record not found: $RECORD"

# Verification must consume observed evidence, not merely trust an exit code.
# The canonical evidence schema and verification predicates are connected later.
die "scaffold only: canonical evidence/verification implementation is required"
