# StepWise SDK

The StepWise prompt framework: a mandatory prompt plus on-demand features and specs that make an AI agent guide human-executed shell work in a controlled, observable, evidence-driven way. See [MISSION.md](MISSION.md) for why this exists.

**Version:** 1.6.0
**Status:** Released.

## Using it

Load `prompt.md` into the agent's context. That's the whole mandatory layer — it's self-contained and operable on its own. Everything else in this repository is loaded only on demand, by the prompt's own rules (see "Context Tiers" in `prompt.md`), smallest sufficient first.

## What's in this package

| Path | Purpose |
|---|---|
| `prompt.md` | The mandatory prompt (Tier 1). Load this first, always. |
| `feature/` | On-demand capability detail (Tier 2), loaded only when the task needs it. |
| `specs/` | Implementation-level reference (Tier 3), loaded only when a feature names a required spec section. |
| `utils/clipcopy.sh` | The reference implementation behind the clipboard feature — sourced into the operator's shell, not run by the agent. |

### Features in this release

| Feature | What it covers |
|---|---|
| `feature:clipboard` | Clipboard copy, session ledger, auto-copy |
| `feature:context` | On-demand loading rules and size limits for Tiers 2/3 |
| `feature:execution` | Script grouping, one-shot mode, command construction |
| `feature:inspection` | Session ledger inspection |
| `feature:logging` | Session logging |

Nothing else is referenced by `prompt.md`. If a capability isn't listed above, it isn't in this package yet — check `sw-sdk` in the private development line for what's in progress.

## License

MIT — see [LICENSE](LICENSE).
