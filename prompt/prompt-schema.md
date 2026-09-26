# StepWise Prompt Schema

**Document:** Prompt Schema  
**Status:** Draft — Phase 1  
**Framework:** StepWise Agentic Governance Framework v0.1  
**Applies to:** prompt.md Version 1.6.0  

## 1. Purpose

This document defines the machine-readable structure, required sections, version metadata, dependencies, and compatibility rules for the canonical StepWise operating prompt (`prompt.md`).

## 2. Prompt Identity

| Field | Value |
|-------|-------|
| Name | Interactive Execution Assistant |
| File | prompt.md |
| Version | 1.6.0 |
| Major | 1 |
| Minor | 6 |
| Patch | 0 |
| Status | Normative (behavioural core) |

Version compatibility rule: A feature or specification may be loaded only when its `Framework` major.minor matches this prompt's major.minor (1.6).

## 3. Required Top-Level Sections

The prompt MUST contain the following conceptual sections (order is conventional, not strict):

1. **Role & Goal** — Defines the assistant's role, human boundary, and overall objective.
2. **Execution Model** — Canonical sequence: Discover → baseline → define functional step → present → human runs → output → analyze → validate → adapt → proceed.
3. **Human Boundary** — Explicit separation of AI guidance from human execution.
4. **Intake** — Task restatement and information-discovery rules.
5. **Objective Clarification Gate** — Mandatory gate before Discovery/Baseline.
6. **Completeness Criteria Wizard** — Mandatory gate immediately after Objective confirmation; `skip` is forbidden.
7. **Discovery** — Safe environment fact-gathering.
8. **Baseline** — Pre-modification state inspection.
9. **Functional Steps** — Definition of the unit of interaction.
10. **Stepwise Interaction Format** — Exact presentation template including `BEGIN EXPECTED`/`END EXPECTED` and risk classification.
11. **Command Construction** — Safety, idempotency, and auditability preferences.
12. **Output Validation** — Marker-based comparison against expected output.
13. **State Progression** — Allowed states and advancement rules.
14. **Adaptive Planning** — Derivation of next step from verified state.
15. **Error Handling** — Failure identification and single corrective step rule.
16. **Assumption Verification** — Evidence over claim.
17. **Safety / Risk Classification** — Required risk labels and credential/privileged-data handling.
18. **Privileged / Destructive / Existing Work / Network** — Specific controls for each category.
19. **Contextual Memory** — What must be tracked across steps.
20. **Session State** — Explicit, non-persistent keys (`AUTO_CLIPBOARD_ENABLED`, ledger session).
21. **Context Tiers** — Tiered loading rules and feature/spec resolution.
22. **Feature Loading Table** — Mapping of feature names to load triggers.
23. **Minimal Drift / Human Control / Logging / Clipboard / One-Shot** — Supporting behavioural rules.
24. **Completion & Final Summary** — Criteria for declaring completion.
25. **Communication & Core Principles** — Style and priority ordering.
26. **Default Pattern** — Numbered operational sequence.
27. **Start** — Entry-point behaviour.

## 4. Dependencies

The core prompt has no hard runtime dependencies on external files. Optional capabilities are loaded on demand:

| Reference | Path (relative) | Load condition |
|-----------|-----------------|----------------|
| feature:clipboard | feature/clipboard.md | clipboard, runcopy, runledger, or sw:auto-copy/* |
| feature:inspection | feature/inspection.md | ledger session active/requested or output review needed |
| feature:context | feature/context.md | long outputs, growing memory, or compaction rules required |
| feature:execution | feature/execution.md | scripts, grouped commands, or one-shot mode |
| feature:logging | feature/logging.md | session log requested or required |

Specifications are loaded only when a feature explicitly names a required section (`spec:<feature>/<section>` → `specs/<feature>/<section>.md`).

## 5. Compatibility Metadata

```yaml
prompt:
  name: Interactive Execution Assistant
  version: "1.6.0"
  major: 1
  minor: 6
  patch: 0
  framework_compatibility: "1.6"
  required_gates:
    - ObjectiveClarificationGate
    - CompletenessCriteriaWizard
  forbidden_actions:
    - direct_execution
    - skip_on_completeness_criteria
    - clipboard_copy_of_credential_or_privileged_data
  context_tiers:
    - tier0_bootstrap
    - tier1_core          # this prompt
    - tier2_feature
    - tier3_specification
    - tier4_task_session
    - tier5_evidence
  session_state_keys:
    - AUTO_CLIPBOARD_ENABLED
    - ledger_session
```

## 6. Integrity

Any conforming implementation MUST treat the content of `prompt.md` (this version) as the highest-precedence behavioural authority for the AI agent. Features and specifications MAY add detail or further restrictions; they MUST NOT relax rules defined in the core prompt unless the prompt itself explicitly delegates that authority.

## 7. Change Control

Changes to the prompt that alter required gates, risk handling, human boundary, or completion rules require:

- version increment (at least minor),
- update to this schema document,
- corresponding updates to dependent features/specs,
- governance review under CHANGE-CONTROL.md (when present).
