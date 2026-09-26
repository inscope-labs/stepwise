# StepWise Command Hashing Guide

## Purpose

Command hashing binds a proposed action to the exact action that the local enforcement layer is permitted to execute.

The hash is an integrity identifier, not authorization by itself.

## Required properties

1. Canonicalize the command before hashing.
2. Hash the canonical representation with SHA-256 or a repository-approved stronger algorithm.
3. Bind the hash to the proposal/session/action identity.
4. Store the algorithm and canonicalization version with the hash.
5. Recompute the hash immediately before execution.
6. Reject any mismatch.
7. Treat material command changes as a new proposal requiring policy/risk evaluation and, where required, fresh authorization.

## Canonicalization

The canonical representation must be deterministic. It must not depend on shell formatting that is irrelevant to the intended command, while also never normalizing away meaningful shell semantics.

Until the canonical grammar is formally specified, the implementation must not invent normalization rules.

## Recommended binding fields

- `session_id`
- `proposal_id`
- `action_id`
- `canonicalization_version`
- `hash_algorithm`
- `command_hash`

## Security rules

- Never hash an untrusted display string while executing a different representation.
- Never authorize one hash and execute another.
- Never allow a hash supplied only by the AI to establish integrity.
- Recompute locally.
- Fail closed on missing, malformed, or mismatched hashes.

## Example conceptual flow

`proposed command → canonical command → local SHA-256 → compare with authorized command_hash → execute only on match`

The exact canonical serialization belongs in the command-envelope schema and implementation.
