# StepWise Authorization Lifecycle

**Document:** Authorization Lifecycle  
**Status:** Draft — Phase 1  
**Framework:** StepWise Agentic Governance Framework v0.1  
**Applies to:** prompt.md Version 0.1.2  

## 1. Purpose

This document defines when an authorization becomes valid, when it remains valid, and the events that cause it to become invalid.

## 2. Creation

An authorization is created only by an explicit human authorization event that references a specific proposal and action. Creation records the fields required by authorization-token.md and sets the initial state to `AUTHORIZED`.

## 3. Validity Conditions

An authorization remains valid only while all of the following hold:

- state is `AUTHORIZED`;
- current time is before `expires_at` (if set);
- the exact action hash still matches;
- the session is still the same active session;
- the Objective has not been materially changed;
- the applicable policy version and decision have not changed in a way that would have produced a different result;
- the risk classification has not escalated;
- no explicit revocation has occurred;
- any scope restrictions still cover the intended action.

## 4. Invalidating Events

The following events MUST cause the authorization to become invalid (transition to `INVALID`, `REVOKED`, or `EXPIRED` as appropriate):

| Event | Effect |
|-------|--------|
| Command / action text modified | Invalid (material change) |
| Target resource or path changed | Invalid (material change) |
| Working directory change that alters scope | Invalid |
| Privilege level increased | Invalid |
| Risk classification escalated | Invalid |
| Objective changed | Invalid (or requires re-authorization) |
| Session terminated or replaced | Invalid |
| Policy change that would alter the decision | Invalid |
| Explicit human revocation | `REVOKED` |
| Wall-clock expiry | `EXPIRED` |
| One-time token successfully used | `CONSUMED` |
| Integrity check failure | `INVALID` |

## 5. Material Change Rule

A material change creates a new action. The old authorization MUST NOT be patched or reused. A fresh authorization request is required.

## 6. Revocation

- Any human who can authorize an action of the given scope MAY revoke it.
- Governance components MAY revoke on policy or security events.
- Revocation takes effect immediately for any subsequent execution attempt.
- Revocation MUST be recorded in the audit trail.

## 7. Expiration

- Time-limited tokens become `EXPIRED` at `expires_at`.
- Expired tokens MUST be treated as non-executable.
- There is no automatic renewal; a new authorization event is required.

## 8. Consumption

- One-time or step-scoped tokens transition to `CONSUMED` after successful use.
- Consumed tokens MUST NOT authorize further executions.

## 9. Fail-Closed Default

If the validity of an authorization cannot be positively established, the local client MUST treat it as invalid and block execution.
