# StepWise Governance Principles

**Status:** Draft — Phase 1  
**Framework:** StepWise Agentic Governance Framework v0.1

## 1. Human Agency

The human remains the authority for consequential decisions.

StepWise assists human decision-making; it does not replace the human's authority with model-generated judgment.

## 2. Separation of Reasoning and Execution

Reasoning and execution are separate concerns.

The AI MAY prepare a command or action proposal. Execution occurs only through the governed execution boundary.

## 3. No Self-Authorization

An AI agent MUST NOT treat its own reasoning, confidence, generated text, or internal state as authorization.

## 4. Explicit Authority

Authority MUST be explicit, scoped, attributable, and non-transitive.

A permission to perform one operation does not implicitly authorize another operation.

## 5. Least Authority

Actors and tools SHOULD receive only the authority required for the current task.

## 6. Exact-Action Integrity

Authorization MUST correspond to the action actually executed.

If a materially relevant property changes, authorization MUST be reacquired.

## 7. Policy Before Execution

Applicable policy MUST be evaluated before execution.

A policy denial MUST NOT be bypassed by human conversational confirmation.

## 8. Risk Before Authorization

The governance system MUST identify applicable risk dimensions before determining the required authorization.

## 9. Evidence Over Assertion

Claims about system state SHOULD be grounded in observable evidence.

Human confirmation can establish a human decision or observation where appropriate, but SHOULD NOT replace available machine evidence.

## 10. Fail Closed

When a required governance fact cannot be established, the governed action MUST stop rather than silently continue.

## 11. Trust Boundaries

Data is not automatically instruction.

External or retrieved content MUST be treated as untrusted unless explicitly trusted by the governance layer.

## 12. Non-Expansion of Authority

No component may silently broaden authority.

In particular:

- a task does not grant policy authority;
- a policy does not grant execution authority;
- an authorization does not grant unrelated authority;
- a tool result does not grant instruction authority.

## 13. Least Context

StepWise MUST prefer the smallest sufficient context.

Large context SHOULD be indexed and retrieved on demand rather than loaded wholesale.

## 14. Bounded Context

Every context tier SHOULD have a target and hard maximum.

Exceeding a budget triggers reduction, indexing, compaction, or narrower retrieval.

## 15. Non-Transitive Context Loading

Loading one feature does not automatically load every related feature or specification.

Dependencies MUST be explicit.

## 16. Provenance

Governance-relevant actions SHOULD be attributable to:

- session;
- agent;
- human actor;
- proposal;
- policy decision;
- authorization;
- action;
- evidence;
- result.

## 17. Verification Is Distinct From Execution

A successful process exit is evidence that a process exited successfully. It is not automatically evidence that the task objective was achieved.

## 18. Reversibility Awareness

Irreversible and destructive operations require stronger governance than ordinary operations.

## 19. Governance Is Itself Governed

Changes to the governance framework MUST be versioned, reviewed, tested, and released under explicit change control.

## 20. Minimum Sufficient Complexity

StepWise SHOULD add governance machinery only where it creates a measurable governance guarantee.

Complexity MUST NOT be added merely because a capability is technically possible.
