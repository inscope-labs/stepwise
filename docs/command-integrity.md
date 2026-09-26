# StepWise Command Integrity

**Document:** Command Integrity  
**Status:** Draft — Phase 1  
**Framework:** StepWise Agentic Governance Framework v0.1  
**Prompt version:** 0.1.2  

## 1. Purpose

Command integrity guarantees that the action authorized by a human is exactly the action that the local client permits to execute.

Core invariant:

```
authorized_command_hash == executed_command_hash
```

If the equality does not hold, execution MUST be blocked.

## 2. Canonicalization

Before hashing, the command MUST be converted to a deterministic canonical form. The canonicalization rules (versioned) MUST be recorded with every hash. Until a formal grammar is published, implementations MUST NOT invent ad-hoc normalization that could alter semantics.

## 3. Hashing

- Algorithm: SHA-256 (or a repository-approved stronger algorithm).
- Input: the canonical command bytes.
- Output: lowercase hex digest.
- The algorithm identifier and canonicalization version travel with the hash.

## 4. Binding

The hash is bound into:

- the proposal envelope,
- the authorization token (when authorization is required),
- the execution record,
- the audit event.

## 5. Verification Points

1. At proposal acceptance — store the hash.
2. At authorization — bind the hash into the token.
3. Immediately before execution — recompute and compare.
4. After execution — record the hash that was actually run.

Any mismatch at step 3 aborts execution.

## 6. Related Artifacts

- `docs/command-hashing.md` — practical hashing guide
- `schemas/command-envelope.schema.json` — envelope structure
- `schemas/proposal.schema.json` — proposal structure
- `authorization/authorization-token.md` — token fields including action_hash
