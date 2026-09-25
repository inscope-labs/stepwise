# StepWise Policy Model

**Status:** Draft — Phase 1  
**Framework:** StepWise Agentic Governance Framework v0.1

## 1. Purpose

Policy determines whether a proposed action is permitted, requires additional authorization, or is blocked.

Policy is an enforcement layer between proposal and execution.

## 2. Policy Decisions

Every evaluated action MUST resolve to one of:

### ALLOW

The action satisfies applicable policy and requires no additional governance gate beyond those already satisfied.

### REQUIRE_APPROVAL

The action may proceed only after the required authorization is obtained.

### DENY

The action is prohibited by policy.

Human confirmation MUST NOT override `DENY`.

### BLOCKED

The system cannot safely establish that execution is permitted.

Examples:

- missing policy;
- malformed proposal;
- unknown resource;
- invalid authorization;
- governance version mismatch;
- integrity failure.

`BLOCKED` MUST fail closed.

## 3. Policy Inputs

Policy evaluation MAY use:

- actor;
- session;
- objective;
- proposed action;
- target;
- resource class;
- risk dimensions;
- authorization;
- environment;
- governance version;
- protected-resource status.

## 4. Policy Precedence

More restrictive applicable policy MUST NOT be weakened by lower-priority content.

Policy itself MUST NOT be changed by untrusted task data.

## 5. Protected Resources

Policies SHOULD support elevated controls for protected resources.

Examples:

- credentials;
- audit records;
- governance files;
- protected branches;
- production systems.

## 6. Risk Interaction

Policy SHOULD consume risk dimensions rather than relying on one single risk label.

Example:

```text
destructive + protected_resource
```

may require stronger controls than either dimension independently.

## 7. Human Authorization

Policy may require authorization.

Policy MUST NOT treat authorization as permission to violate a prohibition.

## 8. Unknowns

If a policy-required property cannot be established, the default should be `BLOCKED` unless the policy explicitly defines a safe fallback.

## 9. Policy Scope

Policies SHOULD be scoped to:

- operation;
- resource;
- actor;
- environment;
- objective;
- time.

A broad policy should not be inferred from a narrow policy.

## 10. Policy Evaluation Order

A reference evaluation order is:

```text
validate proposal
    ↓
identify resource
    ↓
identify risk
    ↓
identify applicable policy
    ↓
evaluate prohibitions
    ↓
evaluate approval requirements
    ↓
return decision
```

## 11. Policy Immutability During Execution

Once authorization is granted, a material policy change SHOULD invalidate the authorization.

## 12. Policy Provenance

A policy decision SHOULD identify:

- policy version;
- rule identifier;
- inputs;
- decision;
- timestamp.

## 13. Fail Closed

If the system cannot establish that an action is permitted, it MUST NOT silently interpret the uncertainty as `ALLOW`.
