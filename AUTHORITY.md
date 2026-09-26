# StepWise Authority Model

**Status:** Draft — Phase 1  
**Framework:** StepWise Agentic Governance Framework v0.1

## 1. Purpose

This document defines who may observe, reason, propose, authorize, execute, verify, and record actions.

## 2. Authority Classes

### A0 — Observe

Read or receive information without changing state.

### A1 — Analyze

Interpret available information and derive conclusions or hypotheses.

### A2 — Recommend

Propose an action or decision for human consideration.

### A3 — Prepare

Construct a command, script, patch, plan, or other executable artifact.

Preparation does not authorize execution.

### A4 — Request Authorization

Ask the appropriate authority to authorize a defined action.

### A5 — Authorize

Grant permission for a defined action within the authority holder's scope.

### A6 — Execute

Cause the defined action to be performed.

### A7 — Verify

Determine whether the defined completion/evidence criteria were satisfied.

### A8 — Record

Create or update an attributable governance/audit record.

## 3. Default Actor Mapping

| Actor | Default authority |
|---|---|
| AI agent | A0–A4, A7 subject to evidence |
| Human operator | A0–A8 within human scope |
| StepWise governance | Defines constraints; does not become human authority |
| `sw-client.sh` | Enforcement/control boundary; executes only within authorized scope |
| Shell/tool | Performs the operation; does not decide authorization |
| Audit system | A8 |

The exact implementation MAY narrow these defaults.

## 4. Non-Delegation

An actor MUST NOT infer authority from capability.

For example, the fact that an AI can generate a shell command does not mean it can execute that command.

## 5. Human Authorization

Human authorization MUST be explicit for actions designated by policy as requiring approval.

Conversational acknowledgment is not automatically authorization.

The implementation MUST define the authorization event and its scope.

## 6. Authority Scope

Every authorization SHOULD identify:

- actor;
- target;
- objective;
- operation;
- resource;
- restrictions;
- duration;
- applicable policy;
- risk;
- authorization identifier.

## 7. Authority Non-Expansion

Authorization for action A MUST NOT be interpreted as authorization for action B merely because B appears related.

## 8. Delegation

Delegation MUST preserve the following invariant:

`delegate_scope ⊆ delegator_scope`

Further delegation MUST be explicitly permitted.

## 9. Revocation

An authority grant MAY be revoked.

Revocation MUST take effect before subsequent execution that depends on the revoked grant.

## 10. Separation of Duties

Where practical, policy enforcement and execution SHOULD be independently distinguishable from AI reasoning.

The AI should not be the sole authority for determining whether its own proposal is permitted.

## 11. Authority Conflict

If two authority sources conflict, the higher-priority governance rule applies.

Lower-priority content MUST NOT weaken a higher-priority rule.

## 12. Authority Failure

If required authority cannot be established, the operation MUST NOT proceed.

## 13. Auditability

Every consequential authorization SHOULD be attributable to:

- authorization ID;
- session ID;
- action/proposal ID;
- authorizing actor;
- timestamp;
- scope;
- action binding.
