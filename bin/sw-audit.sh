#!/usr/bin/env bash
set -euo pipefail

# StepWise audit record writer.
# Usage:
#   sw-audit.sh <event-record>
#
# Appends a governance/audit event. Fail-closed if the record is missing
# or cannot be written.

die() { printf 'SW-AUDIT: BLOCKED: %s\n' "$*" >&2; exit 1; }

RECORD="${1:-}"
[[ -n "$RECORD" ]] || die "event record is required"
[[ -f "$RECORD" ]] || die "event record not found: $RECORD"

# Phase-1 scaffold: refuse to write until the canonical audit schema
# and ledger backend are connected.
die "scaffold only: canonical audit/ledger implementation is required"
