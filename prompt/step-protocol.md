# StepWise Step Protocol

**Document:** Step Protocol  
**Status:** Draft — Phase 1  
**Framework:** StepWise Agentic Governance Framework v0.1  
**Applies to:** prompt.md Version 0.1.2  

## 1. Purpose

This document defines the normative structure of a functional step as proposed by the AI agent under StepWise. Every step that requests human execution MUST conform to this protocol.

## 2. Required Fields

A conforming step proposal MUST include the following elements (names may be rendered in the human-facing format defined by prompt.md):

| Field | Description | Required |
|-------|-------------|----------|
| session_id | Identifier of the current StepWise session | SHOULD |
| step_id | Monotonically increasing or uniquely generated step identifier within the session | MUST |
| proposal_id | Unique identifier for this specific proposal (allows re-proposal after rejection) | SHOULD |
| objective_id | Reference to the confirmed Objective | SHOULD |
| goal | One-line statement of what the step establishes or changes | MUST |
| command | The exact command or bounded command sequence to be executed | MUST |
| working_directory | Directory in which the command is intended to run (absolute or clearly relative) | SHOULD |
| risk | One or more risk labels from the core set | MUST |
| expected | Numbered list of expected observable results inside BEGIN EXPECTED / END EXPECTED | MUST |
| evidence_requirements | What constitutes sufficient evidence that the step succeeded | SHOULD |
| authorization_requirements | Whether explicit human authorization is required before execution | MUST (implicit by risk) |
| command_hash | Canonical hash of the exact command string (when local enforcement is active) | SHOULD |

## 3. Human-Facing Presentation Format

The AI MUST present exactly one functional step per turn using the format prescribed in prompt.md:

```
Step N — <goal>

Command:
```bash
<command or bounded command sequence>
```

What it does: <1–3 sentences>
Expected output:
```
BEGIN EXPECTED
[1] <expected line or section>
[2] ...
END EXPECTED
```
Risk: <label(s)>

Run this and paste the output.
```

## 4. Risk Labels

The following labels are defined by the core prompt and MUST be used when applicable. Multiple labels may apply simultaneously.

- `read-only`
- `creates`
- `modifies`
- `privileged`
- `credential/privileged-data`
- `network`
- `destructive`
- `difficult to reverse`
- `irreversible`

Unrecognized labels MUST be treated as `credential/privileged-data` for safety purposes.

## 5. Command Integrity

When the local enforcement client is active:

- The proposed command string MUST be hashed with the canonical algorithm defined in command-hashing.md.
- Authorization (if required) MUST bind to that exact hash.
- Any material change to the command after authorization invalidates the authorization.

## 6. Expected Output Block

- Every executable step MUST include a `BEGIN EXPECTED` / `END EXPECTED` block.
- Markers MUST be numbered sequentially starting at [1].
- On validation the agent MUST cite specific marker numbers that failed to match.
- Free-form prose may accompany citations but MUST NOT replace them.

## 7. Authorization Binding

Steps whose risk classification requires confirmation MUST NOT be treated as authorized until the operator has given explicit confirmation for that specific proposal. Conversational acknowledgment of the overall task is not sufficient.

## 8. Non-Executable Content

Diagnostic analysis, status summaries, and requests for information that do not contain a command block are not functional steps and are not subject to this protocol’s execution rules.

## 9. Version Compatibility

This protocol applies to prompt.md Version 0.1.2 and compatible minor revisions. Material changes to required fields require a version increment of this document and corresponding prompt updates.
