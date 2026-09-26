# StepWise Mission

> **StepWise exists so that AI-assisted shell work stays under your control.**
> You define the mission. Results are verified before you rely on them. Context
> carries forward. Your choice of model stays yours. Nothing happens out of
> sight. Trust is calibrated, not assumed. Resource use stays bounded.
>
> **Privacy and security are not features — they are the ground StepWise stands on.**

Version: 1.1  
Status: Normative  
Audience: Operators, contributors, and AI agents evaluating proposed features  
Repository: https://github.com/inscope-labs/step-wise

---

## 1. How to Read This Document

This document is **normative**. It defines what StepWise is allowed to become.

- **Operators** use it to understand what StepWise promises them.
- **Contributors** use it to decide whether a proposed feature belongs.
- **AI agents** use it as a hard gate. Section 9 defines the decision procedure
  and the required output format. An agent that proposes or implements a feature
  without passing that gate has violated this document.

Every pillar is named in the operator’s voice. It states a stake the operator
holds, not a mechanism StepWise builds. Internal machinery lives *beneath* a
pillar as implementation. It never replaces the pillar’s name.

---

## 2. The Seven Pillars

All seven are two-word, user-facing labels. All seven describe an experience the
operator has. None describe an internal architecture.

| # | Pillar | Operator’s Problem | The Promise |
|---|--------|--------------------|-------------|
| 1 | **Human Control** | “The AI runs off and does things I didn’t ask for.” | You define intent and scope. Nothing proceeds without your approval. |
| 2 | **Verified Results** | “It said it worked. I don’t know if it did.” | Progression requires evidence, not assertion. |
| 3 | **Session Continuity** | “I re-explain everything every time.” | Verified context carries forward across sessions. |
| 4 | **Model Freedom** | “I’m locked into one vendor.” | The protocol is constant; the model is replaceable. |
| 5 | **Full Visibility** | “I can’t tell what happened, when, or why.” | Every decision is logged and auditable. |
| 6 | **Bounded Consumption** | “It burned tokens, time, or money without asking.” | Every session has explicit, visible limits. |
| 7 | **Calibrated Trust** | “It sounds confident even when it’s guessing.” | Uncertainty is surfaced before you act. |

---

## 3. Pillar Definitions

Each pillar lists its promise, its implementing features, and its
**anti-patterns** — the failure modes an agent must reject.

### 3.1 Human Control

**Promise.** The human defines the mission. The AI does not begin work until
intent is concrete, testable, and scoped. The AI never expands scope on its own.
The AI never executes commands — the human always does.

**Implementing features.** Objective Clarification Gate · Completeness Criteria
Wizard · Drift Guard · Skip Sentinel · Assumption Verifier · Human-in-the-Loop
Execution · Compact Mode · Express Mode

**Anti-patterns (reject).**
- Any feature that lets the AI execute a command directly.
- Any feature that begins discovery before an Objective exists.
- Any feature that expands scope without explicit operator consent.
- Any feature that allows `skip` on a mandatory safety or validation gate.
- Any feature that makes approval implicit, remembered, or blanket by default.
- Any feature that permits an agent or tool loop to expand scope, iterate, or
  escalate privileges without an explicit, per-step operator approval gate.
- Any feature that treats “skip” or “remember this approval” as a durable
  default rather than a single-use, logged exception.

### 3.2 Verified Results

**Promise.** Every step declares its expected output before execution. Actual
output is compared against it. Completion is declared only when every criterion
has fresh evidence. “Command succeeded” is never treated as “task complete.”

**Implementing features.** Expected vs Actual Side-by-Side · Risk Classification
· Pre-Destructive Checklist · Command Linter · Evidence-Based Completion Criteria
· Evidence Anchor Links · Rollback Suggestion · Impact Radius Estimate

**Anti-patterns (reject).**
- Any feature that marks a step complete without comparing expected vs actual.
- Any feature that infers success from an exit code alone.
- Any feature that treats model narration as evidence.
- Any feature that removes or bypasses a validation gate to reduce friction.
- Any feature that treats model-generated narration, citations, or API claims
  as evidence without independent verification.
- Any feature that accepts an exit code or tool success status as sufficient
  proof of task completion when expected-output criteria remain unmet.

### 3.3 Session Continuity

**Promise.** Verified facts, constraints, failures, and corrections survive the
session. Memory is a hypothesis, never evidence. Memory never overrides fresh
verification.

**Implementing features.** Contextual Memory Sync · Knowledge Base · Session
Replay & Review · Handoff Snapshot · Decision Log · Evidence Vault

**Anti-patterns (reject).**
- Any feature that treats recalled memory as verified fact.
- Any feature that stores credentials, secrets, or sensitive-step output.
- Any feature that replaces a discovery step on an unverified recall.
- Any feature that silently overwrites or discards prior session state.
- Any feature that injects retrieved documents, prior conversation fragments,
  or embeddings into context without marking them as unverified and subject to
  fresh validation.
- Any feature that allows memory to silently replace a required discovery or
  verification step.

### 3.4 Model Freedom

**Promise.** StepWise depends on no single AI provider, model, or vendor. The
protocol is the constant; the model is a replaceable component. Users own their
context, memory, and workflow regardless of what happens in the model market.

**Implementing features.** Provider Adapter Layer · Portable Memory Format ·
Model Routing · Capability Abstraction · Self-Hosted Deployment

**Anti-patterns (reject).**
- Any feature that only works on one provider with no abstraction path.
- Any feature that locks memory, audit history, or session state into a
  provider-proprietary format.
- Any feature that makes switching models invalidate session state or history.
- Any feature that requires a provider-specific capability as a hard dependency.

### 3.5 Full Visibility

**Promise.** Every decision, command, approval, skip, and override is visible and
auditable. Nothing important happens silently. The operator can always answer:
*What happened, when, why, and with what evidence?*

**Implementing features.** Session Ledger · Session Timeline · Risk Accumulator ·
Decision Log · Export Audit Package · Compliance Reporter · Failure Detection
Thresholds · Human Escalation Triggers

**Anti-patterns (reject).**
- Any feature that performs a consequential action without a log entry.
- Any feature that removes or weakens the tamper-evident audit trail.
- Any feature that exposes secrets in the name of visibility (see §4).
- Any feature that makes audit history dependent on one provider’s format.

### 3.6 Bounded Consumption

**Promise.** The system is finite. Every session has explicit limits on
iterations, time, output, and cost. When a limit is reached, StepWise stops and
asks — it does not silently degrade.

**Implementing features.** Iteration & Repetition Limits · Timeout Handling ·
Bounded Output Capture · Context Compaction · Prompt Caching · Quota Tracking ·
Usage Transparency

**Anti-patterns (reject).**
- Any feature that removes an iteration, time, or output cap without a bound.
- Any feature that degrades capability silently instead of stopping and asking.
- Any feature that hides usage or produces surprise cost.
- Any feature that skips validation to conserve tokens (see §5).

### 3.7 Calibrated Trust

**Promise.** StepWise surfaces uncertainty before the operator acts, so
confidence in a step matches how much that step deserves.

**Implementing feature.** Confidence Calibration Panel, comprising:
- **Confidence level** — calibrated via self-consistency sampling or a separate
  calibration model, not the model’s self-reported number.
- **Basis of proposal** — verified memory fact, fresh discovery output, or
  unverified inference.
- **Uncertainty flags** — the specific parts of the step the model is less sure
  about.
- **Counter-explanation** — what would need to be true for this to be wrong.
- **Suggested verification** — a safe, read-only sub-step that reduces
  uncertainty before the main step runs.

**Anti-patterns (reject).**
- Any feature that presents an unverified inference as a verified fact.
- Any feature that displays a raw, uncalibrated self-reported confidence score
  as if it were meaningful.
- Any feature that removes the ability to see the basis of a proposal.
- Any feature that inflates operator confidence without adding evidence.
- Any feature that presents an uncalibrated self-reported confidence score as
  actionable.
- Any feature that omits a counter-explanation or suggested verification step
  when uncertainty flags are present.
- Any feature that conceals possible deceptive alignment or goal-misgeneralisation
  indicators from the operator.

---

## 4. Infrastructural Foundation: Privacy & Security

Privacy and security are not pillars. They are the **ground the pillars stand
on**. Every pillar depends on them. If they fail, nothing above them matters.

| Foundation Requirement | What It Enforces |
|---|---|
| **Fail-Closed Sensitive-Step Bypass** | Credential/privileged-data steps are never copied, never recorded, never stored. Unrecognized risk labels default to sensitive. |
| **Secret Scrubbing** | Secrets are stripped at the LLM boundary before reaching any model. |
| **Credential-Path Denylist** | `~/.ssh`, `**/*.pem`, and similar paths are blocked by default. |
| **Append-Only, Hash-Chained Audit Logs** | Logs are tamper-evident and use restrictive permissions (0600). |
| **Kernel-Enforced Sandboxing** | Landlock (Linux) and Seatbelt (macOS) limit what an approved command can actually do. |
| **Redaction by Default** | Sensitive output is redacted before it reaches conversation or memory. |
| **Injection-Resistant Boundaries** | Model, tool, and retrieval inputs are treated as untrusted. System instructions and safety gates cannot be overridden by content originating outside the operator’s explicit session. |

**The rule.** No pillar may be implemented in a way that weakens the foundation.
A feature that improves Full Visibility by exposing secrets is not a feature — it
is a violation.

---

## 5. Conflict Resolution

When pillars conflict, StepWise resolves them in this order. The foundation
always outranks every pillar.

| Conflict | Winner | Rationale |
|---|---|---|
| Foundation vs. any pillar | **Foundation** | Privacy and security are non-negotiable. |
| Privacy vs. Session Continuity | **Privacy** | Never store what shouldn’t be stored. |
| Privacy vs. Full Visibility | **Privacy** | Redact, don’t expose. |
| Human Control vs. Bounded Consumption | **Human Control** | Clarify first, then bound. |
| Verified Results vs. Bounded Consumption | **Verified Results** | Never skip validation to save tokens. |
| Model Freedom vs. Full Visibility | **Model Freedom** | Do not tie audit to a provider-specific format. |
| Session Continuity vs. Verified Results | **Verified Results** | Fresh evidence beats recalled hypothesis. |
| Calibrated Trust vs. any pillar | **Calibrated Trust** | Never inflate confidence to satisfy another pillar. |

This ordering is itself part of the mission. It states what StepWise sacrifices
first and what it will never sacrifice.

---

## 6. The Seven-Pillar Test

For any proposed feature, a human or agent must be able to complete this
sentence truthfully:

> **This feature strengthens [pillar] because it [operator-visible benefit],
> without weakening the foundation or any other pillar.**

If the sentence cannot be completed truthfully, the feature is rejected or
revised.

---

## 7. Amendment

This document changes only by explicit decision of the maintainer. An AI agent
may **not** edit, reinterpret, or extend this document on its own initiative.

If an agent believes a pillar, promise, or anti-pattern is wrong, it must:
1. State the specific clause it disputes.
2. State the operator problem the clause fails to serve.
3. Propose the minimal amendment.
4. Wait for explicit human approval.

Agents may quote this document. They may not rewrite it.

---

## 8. Feature Gate for AI Agents

This section is the machine-applicable procedure. An agent evaluating any
proposed feature must run every gate in order and stop at the first failure.

### Gate 0 — Foundation
Does the feature touch credentials, secrets, privileged data, audit integrity,
sandbox boundaries, or injection surfaces?
→ If it weakens any foundation requirement in §4, **REJECT**.

### Gate 1 — Pillar mapping
Does the feature strengthen at least one of the seven pillars?
→ If it maps to no pillar, **REJECT**.
→ If it maps only to an internal mechanism, return to §2 and re-map. The
   mechanism is not the pillar.

### Gate 2 — Non-violation
Does the feature weaken the foundation or any other pillar, including any
anti-pattern listed in §3?
→ If yes, **REJECT**, unless §5 explicitly resolves the conflict in the
   feature’s favor.

### Gate 3 — User-facing naming
Can the feature be described in the operator’s voice, as a stake the operator
holds — not as internal architecture?
→ If no, **REVISE** the description before proceeding.

### Gate 4 — Test sentence
Can §6 be completed truthfully?
→ If no, **REJECT**.

### Gate 5 — Bounds
Does the feature introduce unbounded iteration, time, output, cost, or
autonomy?
→ If yes, **REVISE** to add explicit bounds, or **REJECT**.

### Required Output Format

An agent evaluating a feature must emit exactly this structure:

```
FEATURE: <name>
PILLAR: <one of the seven, or NONE>
STRENGTHENS: <operator-visible benefit, one sentence>
FOUNDATION IMPACT: <none | weakens — explain>
PILLAR IMPACT: <none | weakens <pillar> — explain>
CONFLICT RESOLUTION: <N/A | §5 rule applied>
TEST SENTENCE: <the §6 sentence, completed>
BOUNDS: <explicit limits introduced, or N/A>
DECISION: <APPROVE | REVISE | REJECT>
REASON: <one sentence>
```

### Common Rejection Reasons

- **Mechanism-as-pillar.** Naming an internal component as if it were a user stake.
- **Safety-for-friction.** Removing a gate to reduce interaction overhead.
- **Confidence inflation.** Presenting inference as verified fact.
- **Visibility-by-exposure.** Improving audit by leaking secrets.
- **Convenience lock-in.** A capability that only works on one provider.
- **Unbounded autonomy.** Any action loop without an explicit ceiling.
- **Silent degradation.** Reducing capability instead of stopping and asking.
- **Injection acceptance.** Allowing external content to override system
  instructions or safety gates.

---

## 9. One-Line Summary

**StepWise keeps the operator in control of AI-assisted shell work — with
verified results, continuous context, model freedom, full visibility, bounded
resource use, and calibrated trust — on a foundation of privacy and security
that is never negotiable.**
