#!/usr/bin/env bash
set -euo pipefail

# StepWise authorization revocation.
# Usage:
#   sw-revoke.sh <authorization-id-or-token>
#
# Immediately invalidates the referenced authorization. Subsequent
# execution attempts that present the revoked token must be blocked.

die() { printf 'SW-REVOKE: BLOCKED: %s\n' "$*" >&2; exit 1; }

TARGET="${1:-}"
[[ -n "$TARGET" ]] || die "authorization id or token is required"

# Phase-1 scaffold: no persistent authorization store is yet connected.
die "scaffold only: authorization store and revocation implementation required"
