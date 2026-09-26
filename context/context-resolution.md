# StepWise Context Resolution

**Document:** Context Resolution  
**Status:** Draft — Phase 1  
**Framework:** StepWise Agentic Governance Framework v0.1  
**Prompt version:** 0.1.2  

## 1. Purpose

Defines how the AI determines the minimum context required for the current operation.

## 2. Resolution Algorithm (normative intent)

1. Identify the current protocol state (Objective, Criteria, Discovery, Proposal, etc.).
2. List the decisions or actions that must be taken in this turn.
3. For each decision, determine the smallest set of rules that govern it.
4. Map those rules to the lowest tier that contains them (prefer Tier 1, then a single feature, then a single spec section).
5. Load only that set.
6. If after loading the decision still cannot be made, escalate by loading the next most specific artifact; never bulk-load.

## 3. Anti-Patterns

- Loading every feature “just in case”.
- Loading a whole specification when only one section is required.
- Treating the presence of a file on disk as a reason to include it in context.
