#!/usr/bin/env bash
set -euo pipefail

# StepWise local policy evaluation helper.
# Usage:
#   sw-client-policy.sh <proposal-envelope>
#
# Evaluates the proposal against the active policy set and emits a
# decision (ALLOW | REQUIRE_APPROVAL | DENY | BLOCKED). Fail-closed.

die() { printf 'SW-POLICY: BLOCKED: %s\n' "$*" >&2; exit 1; }

ENVELOPE="${1:-}"
[[ -n "$ENVELOPE" ]] || die "proposal envelope is required"
[[ -f "$ENVELOPE" ]] || die "proposal envelope not found: $ENVELOPE"

# Phase-1 scaffold: policy engine not yet wired to policy-defaults.yaml.
die "scaffold only: policy engine implementation required (see policy/policy-engine.md)"
