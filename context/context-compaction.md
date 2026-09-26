# StepWise Context Compaction

**Document:** Context Compaction  
**Status:** Draft — Phase 1  
**Framework:** StepWise Agentic Governance Framework v0.1  
**Prompt version:** 0.1.2  

## 1. Purpose

Defines summarization, indexing, and reduction strategies when a context tier approaches its budget limit.

## 2. Triggers

Compaction is considered when:

- a tier exceeds its target budget,
- session memory is growing across many steps,
- evidence records accumulate beyond index size.

## 3. Allowed Strategies

1. **Index replacement** — replace full text with an index entry + hash.
2. **Summarization** — produce a shorter, provenance-preserving summary of verified state (never of raw untrusted data presented as instruction).
3. **Eviction** — remove least-recently-used Tier 2/3 content that is not required for the current step.
4. **Reference-only evidence** — keep only pointers to evidence; load raw evidence on explicit demand.

## 4. Prohibited Strategies

- Dropping mandatory Tier 1 (core prompt) content.
- Summarizing away safety gates, risk labels, or authorization requirements.
- Treating a summary as higher authority than the original governance artifact.
