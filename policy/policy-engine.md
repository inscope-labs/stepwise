# StepWise Policy Engine

**Document:** Policy Engine  
**Status:** Draft — Phase 1 (interface definition)  
**Framework:** StepWise Agentic Governance Framework v0.1  
**Prompt version:** 0.1.2  

## 1. Purpose

The policy engine is the local component that evaluates a proposed action against the active policy set and returns one of the four decisions defined in policy-model.md:

- `ALLOW`
- `REQUIRE_APPROVAL`
- `DENY`
- `BLOCKED`

It is invoked by the local client before any execution attempt.

## 2. Inputs

- Canonical action / command envelope
- Risk dimensions (from risk-model / risk-matrix)
- Session and objective identifiers
- Active policy set (policy-defaults.yaml or successor)
- Authorization state (if any)
- Protected-resource registry (when available)

## 3. Output

```text
{
  "decision": "ALLOW | REQUIRE_APPROVAL | DENY | BLOCKED",
  "rule_id": "<matched rule or null>",
  "policy_version": "<version>",
  "authorization_required": true | false,
  "reasons": ["..."],
  "timestamp": "<ISO-8601>"
}
```

## 4. Evaluation Contract

1. Validate the proposal envelope.
2. Determine applicable risk dimensions.
3. Select matching rules from the active policy set using the configured precedence (default: most_restrictive).
4. Return the resulting decision.
5. On any evaluation failure or missing policy → `BLOCKED` (fail-closed).

## 5. Non-Goals (Phase 1)

- Full production implementation language binding.
- Dynamic policy loading from remote sources.
- Machine-learning-based policy inference.

The concrete executable (shell function, binary, or library) is supplied by later implementation work. This document defines only the required interface and behaviour.
