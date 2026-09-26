# sw-client — Scope at StepWise v0.1.2 (human-controlled prompt)

**Status:** Draft — Phase 1
**Framework:** StepWise Agentic Governance Framework v0.1

## 1. Context

`prompt.md` at v0.1.2 describes a human-controlled execution model: the AI
never holds execution capability. It proposes a functional step; a human
reviews it and runs it themselves. This document scopes what `sw-client.sh`
and `sw-exec.sh` need to do *for that model specifically* — not for the
autonomous/agentic model the rest of the governance scaffolding
(`policy/`, `authorization/`, `schemas/`, `sw-audit.sh`, `sw-revoke.sh`)
is ultimately built for.

## 2. Purpose

Route every functional step the AI proposes through one canonical local
surface (`sw-client.sh`) instead of a raw shell command, so that:

- the exact command text is hashed before it runs,
- execution happens through a single internal boundary (`sw-exec.sh`),
- a local, append-only record of what ran and what happened exists
  afterward.

The human's own act of running `sw-client.sh "<command>"` **is** the
authorization event at this scope. There is no separate approval step to
insert, because there is no autonomous actor yet whose authority needs
bounding.

## 3. In scope

- `sw-client.sh "<command>"` — hash, execute via `sw-exec.sh`, record,
  return the real exit status.
- `sw-client.sh --check` — read-only self-check (presence/executability
  of `sw-exec.sh`, `sha256sum`, ledger-directory writability). Bootstraps
  `$STEPWISE_HOME`/ledger dir if absent so a first-ever run reports
  identically to steady state; this is not treated as a side effect
  since an empty directory has no observable governance consequence.
- `sw-client.sh --version` / `--help`.
- A lightweight per-session id (`$STEPWISE_HOME/session.id`, or
  `STEPWISE_SESSION_ID` override) — enough to group a session's ledger
  entries. Not the full `session-model.md` lifecycle (create / resume /
  close / recover).
- A local JSONL ledger at `$STEPWISE_HOME/ledger/<session>.jsonl`:
  session id, step id, timestamp, exact command text, its hash, exit
  status. One record per step, newline-terminated, written before
  proceeding to the next step.
- `sw-exec.sh` actually executing the received command text (via
  `bash -c`) and returning its real exit status, for the sole caller
  `sw-client.sh`.
- A reserved `POLICY_SCRIPT` hook, no-op when unset, so Phase 2's policy
  engine can plug into the same wrapper later without redesigning it.

## 4. Out of scope at this version

Already scaffolded elsewhere in the SDK, but deliberately not wired into
`sw-client.sh`/`sw-exec.sh` yet:

- Authorization tokens / lifecycle / delegation / override
  (`authorization/`) — nothing to authorize beyond the human's own act of
  running the wrapper.
- Revocation (`sw-revoke.sh`) — nothing persists as a standing grant.
- Policy `ALLOW` / `REQUIRE_APPROVAL` / `DENY` branching and the risk
  engine (`policy/`, `risk/`) — no autonomous decision is being made;
  `POLICY_SCRIPT` stays a no-op pass-through.
- `sw-verify.sh`'s authorization-hash *binding* check — relevant once a
  proposal and its authorization are separate events; here they're the
  same human action.
- Credential redaction, context-tier loading, command-envelope schemas —
  agentic-era concerns with no autonomous caller yet to apply them to.

## 5. Relationship to Phase 2

Nothing here should require a redesign when the autonomous/agentic model
is introduced. The ledger, the hash, and the single-execution-boundary
discipline established now are exactly what the policy/authorization
layer will need to attach to later. The `POLICY_SCRIPT` hook exists for
that reason.
