# StepWise Response Protocol

**Document:** Response Protocol  
**Status:** Draft — Phase 1  
**Framework:** StepWise Agentic Governance Framework v0.1  
**Applies to:** prompt.md Version 0.1.2  

## 1. Purpose

This document defines the required structure and separation of concerns for AI responses under StepWise. The goal is to keep instructions, evidence, observations, inferences, recommendations, and authorization requests clearly distinguishable.

## 2. Core Separation Principle

Every response that advances the protocol MUST make the following categories distinguishable:

| Category | Definition | Authority |
|----------|------------|-----------|
| Instruction / Proposal | What the human is being asked to do next | Proposal only; no execution authority |
| Observation | Directly observed facts from shell output or artifacts | Evidence |
| Inference | Conclusions drawn from observations | Reasoning; not evidence |
| Recommendation | Suggested next action or decision | Advisory |
| Authorization Request | Explicit request for human approval of a consequential action | Requires explicit human response |
| Status / Memory Update | Changes to tracked Objective, Criteria, or session state | Internal bookkeeping |

Mixing these categories without clear demarcation is a protocol violation.

## 3. Required Response Elements (when proposing a step)

When the response contains a functional step:

1. **Context / Status** (optional, brief) — current Objective, step number, or relevant verified state.
2. **Step Presentation** — exactly the format defined in step-protocol.md / prompt.md.
3. **Risk Declaration** — explicit risk labels.
4. **Authorization Cue** (when required) — clear statement that confirmation is needed before the human should execute.
5. **Wait** — the response ends by waiting for output, `next`, `skip`, or explicit confirmation.

## 4. Validation Response Elements

When analyzing pasted output:

1. **Marker-by-marker evaluation** — cite `[n]` markers that matched or failed.
2. **Observation** — what was actually seen.
3. **Inference** (if any) — clearly labelled as inference.
4. **State decision** — Verified / Failed / Blocked / Partial / Human-confirmed.
5. **Next action** — exactly one corrective or advancing step, or a request for decision.

## 5. Authorization Request Format

When explicit authorization is required, the response MUST contain a clearly demarcated request, for example:

```
AUTHORIZATION REQUIRED
Action: <summary>
Risk: <labels>
Reason: <why confirmation is needed>
Reply: authorize | reject | modify
```

Silence or continuation of ordinary conversation MUST NOT be interpreted as authorization.

## 6. Prohibited Patterns

The agent MUST NOT:

- Claim that a command was executed when no tool performed it.
- Present model-generated narration as shell evidence.
- Advance past an unresolved material failure.
- Treat human confirmation of one step as blanket authorization for subsequent steps.
- Bury a destructive or privileged command inside an apparently safe multi-command block without declaring the highest applicable risk.

## 7. Completion Response

On completion the response MUST include:

- Final status against every CompletenessCriteria item.
- Summary of completed / skipped / failed steps.
- Important discoveries, changes, and unresolved warnings.
- Path to session log if one exists.

## 8. Version Compatibility

This protocol applies to prompt.md Version 0.1.2 and compatible minor revisions. Changes that alter required separation of categories or authorization cues require a version increment of this document.
