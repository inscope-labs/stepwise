# StepWise Authorization Binding Guide

## Purpose

Authorization binding prevents an approval for one action from being reused for a materially different action.

## Binding invariant

> Authorization is valid only for the exact action, within the exact approved scope, under the exact applicable policy and session conditions.

## Required binding

At minimum, an authorization record should bind:

- authorization ID
- session ID
- proposal ID
- action ID
- canonicalization version
- command hash
- policy decision/version
- risk classification/version
- authorized scope
- authorization time
- expiration, if applicable
- revocation state
- authorizing human identity/reference
- authorization state

## Verification before execution

The local client must independently verify:

1. authorization exists;
2. authorization is in an executable state;
3. authorization has not expired;
4. authorization has not been revoked or invalidated;
5. session remains valid;
6. policy remains compatible;
7. risk-relevant attributes have not changed;
8. command hash recomputed locally matches the authorized hash;
9. target and scope remain unchanged;
10. required evidence/audit hooks are available.

Any failure blocks execution.

## Material change rule

A materially changed action is a new action. Do not patch the old authorization in place.

Examples include changes to:

- command semantics;
- target path/resource;
- privilege level;
- production/release target;
- credentials;
- network destination;
- destructive or irreversible behavior;
- authorization scope.

## No self-authorization

The AI cannot create, approve, or extend its own authorization. The local client cannot infer authorization merely because an AI requested it.

## Revocation and expiration

Authorization must become unusable after expiration or revocation. Invalidated authorization cannot be silently restored.

## Auditability

The system should record the relationship between proposal, policy decision, authorization, exact action hash, execution attempt, observation, verification result, and final session state.
