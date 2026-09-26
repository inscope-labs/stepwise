# StepWise Delegation Model

**Document:** Delegation Model  
**Status:** Draft — Phase 1  
**Framework:** StepWise Agentic Governance Framework v0.1  
**Applies to:** prompt.md Version 0.1.2  

## 1. Purpose

This document defines controlled delegation of authority among agents, sub-agents, tools, clients, and services under StepWise.

## 2. Core Invariant

```
delegate_scope ⊆ delegator_scope
```

A delegate MUST NOT receive authority that exceeds the authority held by the delegator at the time of delegation.

## 3. What May Be Delegated

Only authority that the delegator itself possesses may be delegated. In particular:

- An AI agent that holds only proposal authority (A0–A4) cannot delegate execution authority.
- A human may delegate narrow, time-limited authorization for specific actions.
- The local client may be granted enforcement authority within the bounds of issued tokens.

## 4. Required Delegation Attributes

A conforming delegation record MUST include:

| Attribute | Description |
|-----------|-------------|
| `delegation_id` | Unique identifier |
| `delegator` | Identity of the party granting authority |
| `delegate` | Identity of the party receiving authority |
| `scope` | Exact operations, resources, and limits granted |
| `allowed_actions` | Concrete actions or action classes permitted |
| `restrictions` | Further constraints (paths, risk ceilings, etc.) |
| `created_at` | Timestamp of grant |
| `expires_at` | Expiry (required unless explicitly permanent under policy) |
| `further_delegation` | Boolean — whether the delegate may re-delegate |
| `attribution` | How actions performed under the delegation are attributed |
| `parent_authorization_id` | Reference to the authorization (if any) that enabled this delegation |

## 5. Further Delegation

Further delegation is forbidden unless the original grant explicitly sets `further_delegation = true`. Even then, the sub-delegate’s scope MUST remain a subset of the immediate delegator’s scope.

## 6. Attribution

Every action performed under a delegation MUST be attributable to:

- the original human authorizer (if any),
- the delegator,
- the delegate that performed or requested the action,
- the delegation_id.

## 7. Revocation and Expiration

- Delegation ends at `expires_at` or on explicit revocation by the delegator or a higher authority.
- Revocation of a parent authorization SHOULD cascade to dependent delegations.
- After revocation or expiry the delegate retains no residual authority.

## 8. Prohibited Patterns

- Delegation of authority the delegator does not possess.
- Open-ended or unbounded delegations (“do whatever is needed”).
- Silent or implicit delegation inferred from conversation.
- Delegation that bypasses policy evaluation or risk classification.

## 9. Fail-Closed

If the validity or scope of a delegation cannot be positively established, the action MUST be blocked.
