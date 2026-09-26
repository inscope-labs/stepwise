# StepWise Context Budget

**Document:** Context Budget  
**Status:** Draft — Phase 1  
**Framework:** StepWise Agentic Governance Framework v0.1  
**Prompt version:** 0.1.2  

## 1. Purpose

Defines target and hard-maximum budgets for each context tier so that context remains bounded and predictable.

## 2. Measurement

Three distinct measurements are recognized (see also specs/context/size-limits.md):

- **Source size** — bytes on disk of the artifact.
- **Serialized context size** — bytes after inclusion in the working context.
- **Token cost** — estimated tokens consumed by the model.

Budgets SHOULD be expressed primarily in source size and token cost; serialized size is derived.

## 3. Reference Budgets (Phase 1)

| Tier | Target (tokens) | Hard ceiling (tokens) | Notes |
|------|-----------------|-----------------------|-------|
| 0 Bootstrap | < 500 | 1 000 | Index and version only |
| 1 Core | < 8 000 | 12 000 | prompt.md + invariants |
| 2 Feature | < 4 000 per feature | 6 000 per feature | One feature at a time preferred |
| 3 Specification | < 2 000 per section | 3 000 per section | Load only named sections |
| 4 Task/Session | < 6 000 | 10 000 | Objective, criteria, state |
| 5 Evidence | Index only by default | Raw evidence on explicit need | Prefer references over full text |

These numbers are starting points; the active `context-policy.yaml` and `specs/context/size-limits.md` are the authoritative sources when present.

## 4. Exceeding a Budget

When a tier approaches or exceeds its target:

1. Prefer indexing / summarization over full inclusion.
2. Evict the least-recently-used lower-priority content.
3. If the hard ceiling would be breached, refuse further loading and surface the condition to the operator.
