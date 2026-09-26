# StepWise Authorization Token

**Document:** Authorization Token  
**Status:** Draft — Phase 1  
**Framework:** StepWise Agentic Governance Framework v0.1  
**Applies to:** prompt.md Version 0.1.2  

## 1. Purpose

This document defines the machine-verifiable authorization artifact (the “authorization token”) that binds human approval to an exact proposed action.

The token is the sole artifact that may be presented to the local enforcement client as evidence of authorization.

## 2. Required Fields

A conforming authorization token MUST contain the following fields:

| Field | Description |
|-------|-------------|
| `authorization_id` | Globally unique identifier for this authorization grant |
| `session_id` | Identifier of the StepWise session |
| `objective_id` | Reference to the confirmed Objective |
| `step_id` | Identifier of the functional step |
| `proposal_id` | Identifier of the specific proposal that was authorized |
| `action_hash` | Canonical hash of the exact action/command (see command-hashing.md) |
| `canonicalization_version` | Version of the canonicalization rules used to produce the hash |
| `risk` | Risk labels that applied at the time of authorization |
| `policy_decision` | Policy decision that was in force (`ALLOW` after approval, etc.) |
| `policy_version` | Version or identifier of the policy set evaluated |
| `authorizer` | Identity or reference of the human who authorized |
| `created_at` | ISO-8601 timestamp of authorization |
| `expires_at` | ISO-8601 expiry timestamp (or null for one-time / step-scoped) |
| `scope` | Explicit scope restrictions (paths, resources, operations) |
| `restrictions` | Additional constraints (e.g., one-time, no-delegation) |
| `state` | Current state (`AUTHORIZED`, `CONSUMED`, `REVOKED`, `EXPIRED`, …) |
| `signature` / `integrity` | Integrity protection appropriate to the local client (HMAC, signature, or equivalent) |

## 3. Binding Invariant

```
authorized_action_hash == execution_action_hash
```

If the hashes differ, the token MUST be treated as invalid for the attempted execution and the client MUST block.

## 4. Token Lifecycle States

The token’s `state` field follows the states defined in authorization-model.md:

- `AUTHORIZED` — valid for execution (subject to expiry and scope)
- `CONSUMED` — used for a one-time execution; no longer valid
- `REVOKED` — explicitly invalidated
- `EXPIRED` — past `expires_at`
- `INVALID` — failed integrity or binding checks

## 5. Issuance

Only a human authorization event that satisfies the rules in authorization-model.md may cause a token to be issued. The AI agent MUST NOT issue, forge, or extend tokens.

## 6. Presentation to Local Client

Before execution the local client (`sw-authorize.sh` / `sw-verify.sh`) MUST:

1. Receive the token.
2. Verify integrity.
3. Confirm state is `AUTHORIZED`.
4. Confirm the token has not expired.
5. Recompute the action hash from the command about to be executed and compare it to `action_hash`.
6. Confirm session, objective, and policy context still match.
7. Only then permit execution.

## 7. Non-Goals

This document does not define the concrete cryptographic algorithm, storage format, or transport. Those are implementation choices of the local client provided the binding and verification invariants are preserved.
