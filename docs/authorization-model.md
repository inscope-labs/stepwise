# StepWise Authorization Model

**Status:** Draft — Phase 1  
**Framework:** StepWise Agentic Governance Framework v0.1

## 1. Purpose

Authorization is the explicit grant of permission to perform a defined action.

Authorization is distinct from:

- suggestion;
- recommendation;
- acknowledgment;
- confirmation of understanding;
- execution;
- verification.

## 2. Authorization States

```text
NOT_REQUIRED
REQUIRED
REQUESTED
AUTHORIZED
REJECTED
EXPIRED
REVOKED
INVALID
CONSUMED
```

## 3. Authorization Requirements

An action MUST require authorization when policy or risk rules designate it as requiring approval.

Examples commonly include:

- destructive actions;
- irreversible actions;
- privileged actions;
- protected-resource changes;
- credential-sensitive operations;
- production/release-impacting operations.

## 4. Authorization Scope

An authorization SHOULD identify:

```text
authorization_id
session_id
objective_id
step_id
proposal_id
actor
target
operation
risk
policy_decision
action_binding
created_at
expires_at
restrictions
```

## 5. Exact-Action Binding

Authorization MUST bind to the action being executed.

For command-based execution, the implementation SHOULD calculate a canonical action representation and integrity value.

Conceptually:

```text
authorized_action_hash == execution_action_hash
```

If false:

```text
EXECUTION = BLOCKED
```

## 6. Material Change

The following SHOULD be treated as material changes unless explicitly covered by the original authorization:

- command text;
- target resource;
- working directory where it changes scope;
- privilege level;
- network destination;
- affected resource set;
- risk classification;
- objective;
- policy context.

Material change requires reauthorization.

## 7. Bounded Authorization

Authorization SHOULD be as narrow as practical.

Prefer:

```text
authorize this exact command
```

over:

```text
authorize whatever the agent needs
```

## 8. Duration

Authorization MAY be:

- one-time;
- step-scoped;
- session-scoped;
- time-limited.

Broad or long-lived authorization SHOULD require explicit policy support.

## 9. Revocation

A human or governance component MAY revoke authorization.

Revoked authorization MUST NOT authorize subsequent execution.

## 10. Expiration

Expired authorization MUST be treated as invalid.

## 11. Policy Interaction

Authorization does not override policy.

A policy `DENY` or `BLOCKED` result remains blocking even if a human attempts to authorize the action.

## 12. Human Interaction

The implementation MUST distinguish:

- "I understand";
- "continue";
- "I approve this exact action";
- "cancel".

Only the defined authorization event can create authorization.

## 13. Authorization Failure

Missing, malformed, ambiguous, stale, revoked, or unverifiable authorization MUST fail closed.

## 14. Audit

Authorization events SHOULD record:

- who authorized;
- what was authorized;
- why/under which objective;
- when;
- for how long;
- which policy/risk state applied;
- exact action binding.
