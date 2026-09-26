# StepWise Client Protocol

**Document:** Local Client Protocol  
**Status:** Draft — Phase 1  
**Framework:** StepWise Agentic Governance Framework v0.1  
**Prompt version:** 0.1.2  

## 1. Purpose

This document defines the interaction protocol between the AI agent, the human operator, and the local StepWise client (`sw-client.sh` and supporting tools).

## 2. High-Level Flow

```
AI proposal
    ↓
proposal validation (envelope + schema)
    ↓
policy evaluation
    ↓
risk evaluation
    ↓
authorization requirement determination
    ↓
human authorization (when required)
    ↓
authorization / action-hash binding
    ↓
local enforcement (sw-client.sh)
    ↓
execution (sw-exec.sh)
    ↓
evidence capture
    ↓
verification (sw-verify.sh)
    ↓
audit record (sw-audit.sh)
    ↓
session state update
```

No stage may be silently bypassed.

## 3. Proposal Envelope

The AI (or a higher-level orchestrator) MUST present a proposal envelope that contains at minimum the fields defined in `schemas/proposal.schema.json` and `schemas/command-envelope.schema.json`.

## 4. Client Responsibilities

`sw-client.sh` MUST:

1. Accept only a well-formed envelope.
2. Recompute the command hash locally.
3. Invoke policy evaluation.
4. Enforce authorization binding when required.
5. Refuse execution on any failure (fail-closed).
6. Hand a validated, authorized command to the execution boundary.
7. Ensure evidence and audit hooks are available.

## 5. Human Authorization

When policy returns `REQUIRE_APPROVAL`, the client (or a calling layer) MUST obtain an explicit human authorization event that produces a token conforming to `authorization/authorization-token.md`. Conversational acknowledgment is never sufficient.

## 6. Execution Boundary

Only `sw-exec.sh` (invoked from `sw-client.sh`) may cause a command to run. Direct execution of arbitrary commands through the client tools is prohibited.

## 7. Verification and Audit

After execution, `sw-verify.sh` consumes observed evidence. `sw-audit.sh` records the full governance trail. Both MUST fail closed if their required inputs are missing.

## 8. Status and Revocation

- `sw-status.sh` provides a read-only view of session/authorization/policy state.
- `sw-revoke.sh` immediately invalidates a previously issued authorization.

## 9. Fail-Closed Default

Any missing, malformed, or unverifiable artifact results in `BLOCKED` / non-execution.
