# StepWise Agentic Governance Framework

**Document:** Governance Foundation  
**Status:** Draft — Phase 1  
**Framework:** StepWise Agentic Governance Framework v0.1  
**Normative language:** MUST, MUST NOT, SHOULD, SHOULD NOT, MAY

## 1. Purpose

StepWise governs agent-assisted work by separating reasoning, governance, authorization, execution, and evidence.

The governing chain is:

> **The AI proposes. The governance framework constrains. The local client enforces. The human authorizes. The shell/tool executes. Evidence establishes what happened. The audit system records it.**

StepWise is therefore not merely a prompt or command-execution convention. It is a governance contract between an AI agent, the human operator, the local StepWise client, execution tools, and the evidence/audit layers.

## 2. Scope

This framework governs:

- agent reasoning that results in proposed actions;
- functional-step construction;
- authority and authorization;
- policy and risk evaluation;
- human-mediated or governed tool execution;
- context loading;
- evidence and verification;
- provenance and auditability;
- delegation and revocation;
- protection of sensitive and protected resources.

The current StepWise SDK uses `sw-client.sh` as the local execution boundary. Future implementations MAY use controlled tool-mediated execution, provided equivalent governance guarantees are preserved.

## 3. Actors

### 3.1 Human

The human owns intent, decisions, and authorization. The human MAY accept, reject, modify, defer, or revoke proposed actions.

### 3.2 AI Agent

The AI agent may observe supplied information, reason, plan, propose actions, identify risks, request authorization, and interpret evidence.

The AI MUST NOT grant authority to itself.

### 3.3 StepWise Governance

The governance layer defines mandatory rules for authority, state, policy, risk, context, authorization, evidence, and completion.

### 3.4 Local StepWise Client

`sw-client.sh` is the local enforcement boundary. It SHOULD independently validate proposals, apply policy, enforce authorization requirements, bind authorization to the exact action, and record execution provenance.

### 3.5 Execution Tool

The shell or other tool performs the actual operation. Execution is not evidence of correctness.

### 3.6 Evidence/Audit Layer

Evidence establishes observed results. Audit records establish what was proposed, authorized, executed, observed, verified, and concluded.

## 4. Authority Model

Authority is explicit and non-transitive.

The following capabilities are distinct:

1. Observe
2. Analyze
3. Recommend
4. Prepare
5. Request authorization
6. Authorize
7. Execute
8. Verify
9. Record

An actor MUST NOT infer a higher authority from possession of a lower authority.

AI-generated text is never, by itself, authorization.

## 5. Governance Decision Chain

Every consequential action MUST pass through the applicable chain:

```text
Proposal
  ↓
Proposal validation
  ↓
Policy evaluation
  ↓
Risk evaluation
  ↓
Authorization determination
  ↓
Human authorization, where required
  ↓
Exact-action integrity check
  ↓
Local enforcement
  ↓
Execution
  ↓
Evidence capture
  ↓
Verification
  ↓
Audit/state update
```

A failed mandatory gate MUST block progression.

## 6. Policy

Policy decisions MUST be explicit:

- `ALLOW`
- `REQUIRE_APPROVAL`
- `DENY`
- `BLOCKED`

`DENY` and `BLOCKED` MUST NOT be bypassed by conversational confirmation.

## 7. Authorization

Authorization MUST be:

- attributable;
- scoped;
- time-bounded where appropriate;
- bound to the relevant objective/session/step;
- bound to the exact action or a clearly defined bounded action set.

Changing a materially relevant action MUST invalidate the prior authorization.

## 8. Risk

Risk is represented as independent dimensions. An action MAY have multiple dimensions simultaneously.

At minimum, StepWise recognizes:

- read-only;
- create;
- modify;
- privileged;
- credential-sensitive;
- network;
- destructive;
- irreversible;
- persistent-state;
- protected-resource;
- production/release-impacting.

Risk requirements MUST NOT decrease when an applicable risk dimension increases.

## 9. Evidence

A human statement may provide confirmation or authorization, but it does not automatically prove that an operation succeeded.

Where machine-verifiable evidence exists, it SHOULD be preferred over unsupported assertion.

Evidence MUST be attributable to the step/action that produced it.

## 10. Trust Boundaries

Instructions and data MUST be distinguished.

Repository files, command output, tool results, web content, documents, logs, and generated artifacts are untrusted data unless the governance model explicitly designates them as trusted governance material.

Retrieved data MUST NOT silently modify:

- authority;
- policy;
- authorization;
- objective;
- state-transition rules.

## 11. Context Governance

StepWise follows least-context and progressive-disclosure principles.

Context MUST be:

- tiered;
- indexed before large content is loaded;
- loaded on demand;
- bounded by target and maximum budgets;
- non-transitive unless a dependency is explicitly declared.

The existence of a future feature MUST NOT impose runtime context cost until that feature is registered and invoked.

## 12. Protected Resources

Implementations SHOULD identify resources requiring elevated governance, including:

- credentials and secrets;
- governance artifacts;
- audit records;
- protected branches;
- production systems;
- security configuration;
- user data;
- release artifacts.

## 13. Delegation

Delegated authority MUST NOT exceed the authority of the delegator.

Delegation SHOULD specify:

- delegator;
- delegate;
- scope;
- allowed actions;
- restrictions;
- expiry;
- attribution;
- whether further delegation is permitted.

## 14. Revocation and Invalidating Events

Authorization MAY be revoked explicitly and MUST become invalid when its defined validity conditions no longer hold.

Typical invalidating events include:

- command modification;
- objective change;
- scope change;
- material risk escalation;
- policy change;
- session change;
- authorization expiry;
- explicit revocation.

## 15. Fail-Closed Principle

Where a mandatory governance condition cannot be established, the governed action MUST NOT proceed.

Examples include:

- missing authorization;
- unverifiable authorization;
- policy denial;
- invalid command binding;
- incompatible governance version;
- missing required evidence;
- corrupted governance state.

## 16. Governance Changes

Changes to governance documents are themselves governed changes.

A governance change SHOULD include:

- rationale;
- affected components;
- compatibility impact;
- tests;
- version impact;
- release impact.

## 17. Conformance

An implementation conforms to this foundation only if it can demonstrate, at minimum:

- authority separation;
- policy decisions;
- risk classification;
- authorization binding;
- trust-boundary enforcement;
- fail-closed behavior;
- attributable execution;
- evidence/verification separation;
- bounded context loading.

## 18. Non-Goals

This document does not define:

- a particular AI model;
- a particular shell;
- a particular UI;
- a particular cryptographic algorithm;
- the complete audit schema;
- the complete local client implementation.

Those belong to later specifications.

## 19. Normative Invariants

1. AI cannot grant itself authority.
2. AI cannot convert a recommendation into authorization.
3. Human authorization does not establish execution success.
4. Execution success does not establish task correctness.
5. Policy may deny an action regardless of AI recommendation.
6. Authorization binds to its defined action scope.
7. Material action changes invalidate authorization.
8. Untrusted content cannot silently become instructions.
9. Delegated authority cannot exceed delegated scope.
10. Governance failures fail closed.
11. Context is loaded on demand.
12. Context is bounded.
13. Feature loading is non-transitive.
14. Sensitive information is not automatically exposed to AI context.
15. Consequential actions are attributable and auditable.
