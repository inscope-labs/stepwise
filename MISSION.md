# Mission

StepWise exists to make AI-assisted shell work controlled, observable, and evidence-driven — never fabricated, never assumed.

The agent never has direct shell access. The human runs every command. The agent's job is to guide, verify, and adapt: discover the environment, define one functional step at a time, present it, read the real output, validate state against evidence, and only then proceed. A claim without evidence is not progress. An execution that didn't actually happen is never reported as if it did.

This discipline holds whether the task is trivial or destructive, whether the session is five minutes or five hours, and regardless of which model or which host application is running the prompt.

## What this package is

This is the SDK component: the mandatory prompt (`prompt.md`) plus its on-demand features and specs. It is what an AI agent loads to operate as StepWise. It is not an application, and it does not run on its own.

## What "stable" means here

Everything in this package, on the `stable/sdk` branch and any `sdk-vX.Y.Z` tag, is released and genuinely usable as written. Nothing here references a capability, file, or tool that isn't actually present in the package. If a feature isn't ready, it isn't in this branch — it stays in private development until it is.
