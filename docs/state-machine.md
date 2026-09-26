# StepWise State Machine

**Status:** Draft — Phase 1  
**Framework:** StepWise Agentic Governance Framework v0.1

## 1. Purpose

This document defines the normative lifecycle for governed StepWise work.

## 2. States

```text
INIT
  ↓
OBJECTIVE
  ↓
CRITERIA
  ↓
DISCOVERY
  ↓
BASELINE
  ↓
PROPOSE
  ↓
POLICY_CHECK
  ↓
RISK_CHECK
  ↓
AUTHORIZATION
  ↓
EXECUTION
  ↓
OBSERVATION
  ↓
VERIFICATION
  ↓
STATE_UPDATE
  ↓
NEXT / COMPLETE
```

Failure paths may enter:

```text
BLOCKED
FAILED
REJECTED
CANCELLED
REVOKED
RECOVERY
```

## 3. State Definitions

### INIT

Establish session identity and governance version.

### OBJECTIVE

Establish the task objective.

### CRITERIA

Define measurable completeness criteria.

### DISCOVERY

Inspect relevant existing state before proposing changes.

### BASELINE

Record sufficient starting state to distinguish change from pre-existing state.

### PROPOSE

Generate a functional step.

### POLICY_CHECK

Evaluate applicable policy.

### RISK_CHECK

Identify risk dimensions and required controls.

### AUTHORIZATION

Obtain required human authorization.

### EXECUTION

Execute only the authorized action through the governed execution boundary.

### OBSERVATION

Collect execution/effect evidence.

### VERIFICATION

Determine whether evidence satisfies the step and task criteria.

### STATE_UPDATE

Record verified state and update the session.

### NEXT

Proceed to the next required step.

### COMPLETE

All mandatory criteria are satisfied and no unresolved failure remains.

## 4. Mandatory Transition Rules

The implementation MUST NOT transition to execution when:

- required policy evaluation is missing;
- policy returns `DENY` or `BLOCKED`;
- required authorization is missing;
- authorization is invalid or stale;
- action binding fails.

## 5. Failure

A failure MUST be represented explicitly.

An unresolved failure MUST NOT be silently converted into success.

## 6. Skip

`skip` is permitted only for steps explicitly designated skippable.

A mandatory governance gate MUST NOT be skipped.

## 7. State Invalidations

The following may invalidate downstream state:

- objective change;
- criteria change;
- material environment change;
- policy change;
- risk escalation;
- command modification;
- authorization revocation;
- governance version change.

The implementation SHOULD invalidate only the affected dependent state rather than indiscriminately discarding the entire session.

## 8. Completion

Completion requires:

1. objective established;
2. mandatory criteria satisfied;
3. required evidence present;
4. verification completed;
5. no unresolved blocking failure;
6. required audit/state records written.

## 9. Recovery

Recovery MUST preserve prior evidence and state.

Recovery MUST NOT silently rewrite history.

## 10. State Integrity

State transitions SHOULD be attributable and SHOULD record:

- previous state;
- next state;
- triggering event;
- actor;
- timestamp;
- relevant step/session identifiers.

## 11. Human Confirmation

Human confirmation MAY advance a state only where the protocol explicitly defines that confirmation as sufficient for that transition.

Confirmation MUST NOT substitute for required policy, authorization, or machine-verifiable evidence.
