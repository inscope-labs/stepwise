# StepWise Conformance Status

**Status:** Draft — Phase 1 (Governance Foundation), partial Phase 2
**Framework:** StepWise Agentic Governance Framework
**SDK Version:** 0.1.2
**As of:** this release

## 1. Purpose

This document defines what it currently means for `sw-sdk` v0.1.2 to be
StepWise-governance compliant, and states plainly where it is not yet
compliant. A conformance document that overstates status is worse than
none — it undermines the exact invariants it exists to establish. This
release is **not** fully conformant. It is an honest snapshot of a
framework under active construction.

## 2. Scope of this release

v0.1.2 operates under the human-controlled execution model described in
`prompt.md`: the AI never holds execution capability. It proposes a
functional step; a human reviews and runs it via `sw-client.sh`. See
`docs/sw-client-v0.1.2-scope.md` for the explicit in-scope/out-of-scope
boundary. Autonomous/agentic execution — the model the fuller governance
layer below is ultimately built for — is not part of this release.

## 3. Status by conformance dimension

| Dimension | Status | Notes |
|---|---|---|
| Authority separation | Documented, not machine-enforced | `AUTHORITY.md`/`GOVERNANCE.md` define human/AI/governance/client/shell roles. At v0.1.2 the human's own act of running `sw-client.sh` is the authorization event; there is no machine-verified separation beyond that. |
| Policy enforcement | Scaffolded, not active | `policy/` contains model/schema/engine docs. `sw-client.sh`'s `POLICY_SCRIPT` hook is a documented no-op pass-through at this scope. |
| Authorization binding | Not implemented | `authorization/` is documentation only. No token issuance, lifecycle, or hash-binding between an authorization event and an execution exists yet. |
| Command integrity | Partially implemented | `sw-client.sh` computes and records a SHA-256 hash of the exact command text before execution, verified end-to-end. No envelope-schema validation (`schemas/command-envelope.schema.json`) is wired into the scripts yet. |
| Context bounds | Documented, not enforced | `context/` defines tiers, budgets, and loading rules. Nothing currently loads or bounds context programmatically. |
| Provenance | Not implemented | `provenance/` is a reserved, empty directory. |
| Evidence | Minimal, real | Each executed step produces a ledger record (session id, step id, timestamp, command, hash, exit status), verified in testing. This is far short of the full `evidence-model.md` design but is genuine, non-fabricated evidence. |
| Auditability | Partial | The JSONL ledger is a real, append-only audit trail for v0.1.2 steps. `sw-audit.sh` exists as a scaffold but is not yet wired to it. No `audit.schema.json` exists to validate entries against. |
| Credential protection | Not implemented | `security/` is a reserved, empty directory. No redaction or credential-detection exists. |
| Injection resistance | Not implemented | No instruction-trust or prompt-injection-policy documents exist yet. |
| Release integrity | Partial, real as of this release | `MANIFEST.sha256` and `release-manifest.json` now contain real checksums and metadata rather than placeholders (see below). No automated release-validation scripts exist yet. |
| Fail-closed behavior | Partial, real where implemented | `sw-client.sh`/`sw-exec.sh` fail closed on empty command, missing execution boundary, or unwritable ledger — tested. The broader governance chain (policy/risk/authorization) has nothing to fail closed on yet, since it isn't wired in. |

## 4. Reserved, unimplemented directories

The following directories exist as placeholders for governance
components that have not been built: `audit/`, `evidence/`,
`provenance/`, `release/`, `security/`, `session/`. Their presence marks
intended scope, not completed work.

## 5. What "complete" requires

Per this framework's own definition, completeness requires:
documented + machine-represented + locally enforced + tested + auditable
+ versioned + release-validated + conformance-verified. This release
satisfies "documented" broadly, "versioned" and "release-validated" for
the SDK package itself (this release), and "tested" narrowly for the
v0.1.2 human-controlled execution path only. It does not yet satisfy
"locally enforced," "auditable" in the full schema-validated sense, or
"conformance-verified" against a machine-checkable conformance suite —
no `conformance.schema.json`, `conformance-tests/`, or
`reference-implementation/` exist yet.

## 6. Revision

This document should be updated at every SDK release to reflect actual,
verified status — not aspirational status. Claims here should be
traceable to a test or a reviewed artifact, not to a document's mere
existence.
