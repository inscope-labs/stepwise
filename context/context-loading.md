# StepWise Context Loading

**Document:** Context Loading  
**Status:** Draft — Phase 1  
**Framework:** StepWise Agentic Governance Framework v0.1  
**Prompt version:** 0.1.2  

## 1. Purpose

Defines progressive disclosure and on-demand loading rules for StepWise context.

## 2. Loading Procedure

1. Start with Tier 0 (bootstrap) + Tier 1 (core prompt).
2. Determine whether the current operation can be completed with what is already loaded.
3. If not, load the single most relevant Tier 2 feature.
4. If the feature names a required specification section, load only that section (Tier 3).
5. Never preload. Never load something merely because it exists.
6. Record what was loaded in session state for auditability.

## 3. Address Resolution

| Address | Resolves to |
|---------|-------------|
| `feature:<name>` | `feature/<name>.md` |
| `spec:<feature>/<section>` | `specs/<feature>/<section>.md` |

Resolution is performed relative to the location from which the core prompt was loaded.

## 4. Failure Handling

If required reference information cannot be loaded:

- State becomes **Blocked**.
- Emit: “Required reference information is unavailable. I will not infer the missing protocol rule.”
- Do not fill the gap from general knowledge.
- Ask the operator to supply the missing artifact or abort the dependent operation.

## 5. Precedence

```
prompt.md (Tier 1) > feature/* (Tier 2) > specs/* (Tier 3)
```

Lower tiers may add constraints; they may never remove or weaken a higher-tier rule.
