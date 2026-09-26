# StepWise Override Policy

**Document:** Override Policy  
**Status:** Draft — Phase 1  
**Framework:** StepWise Agentic Governance Framework v0.1  
**Applies to:** prompt.md Version 0.1.2  

## 1. Purpose

This document states whether emergency or override operations are permitted under StepWise and, if so, under what exact conditions.

## 2. Policy Statement

**Overrides that bypass mandatory governance controls are prohibited.**

StepWise does not provide a general “break-glass” or emergency override that allows:

- skipping required authorization,
- ignoring a policy `DENY` or `BLOCKED` decision,
- executing an action whose authorization token is missing, expired, revoked, or unbound,
- disabling audit or evidence capture for a consequential action,
- elevating privilege beyond an existing valid authorization.

## 3. Rationale

The framework is designed around fail-closed behaviour. An override mechanism that can silently defeat authorization, policy, or audit would undermine the core invariants:

- AI cannot grant itself authority.
- Human authorization binds to an exact action.
- Policy may deny regardless of recommendation.
- Consequential actions are attributable and auditable.

## 4. Permitted Explicit Human Actions

The following remain possible and are not considered overrides:

- A human may authorize a previously denied action only by first changing the governing policy or by issuing a new authorization under a policy that permits it.
- A human may revoke any outstanding authorization.
- A human may terminate a session.
- A human may choose not to execute a proposed step.

These are ordinary exercises of human authority, not bypasses of the governance machinery.

## 5. Future Exception Process (Reserved)

If a future version of the framework introduces a tightly controlled emergency procedure, it MUST:

- require a distinct, high-assurance authorization event,
- be limited in scope and duration,
- generate a mandatory, non-suppressible audit record,
- trigger post-event review,
- be explicitly versioned and enabled only by policy.

No such procedure exists in the current version.

## 6. Implementation Requirement

Local clients and enforcement components MUST NOT implement a hidden or undocumented override path. Any attempt to execute without a valid authorization token and a non-denying policy decision MUST fail closed.
