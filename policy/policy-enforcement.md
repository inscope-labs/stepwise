# StepWise Policy Enforcement Guide

## Purpose

Policy enforcement is the local decision boundary that determines whether a proposed action may proceed.

The AI may recommend a policy result, but it is not the policy authority.

## Decision set

- `ALLOW` — execution may proceed only if all other gates pass.
- `REQUIRE_APPROVAL` — human authorization is required before execution.
- `DENY` — action must not execute.
- `BLOCKED` — evaluation cannot safely establish permission; execution must stop.

## Evaluation order

1. Validate proposal/envelope structure.
2. Establish session and scope.
3. Establish instruction/data trust boundaries.
4. Identify target resources.
5. Determine risk dimensions.
6. Evaluate protected-resource rules.
7. Evaluate credential/sensitive-data rules.
8. Evaluate policy.
9. Determine authorization requirement.
10. Bind authorization to the exact action.
11. Re-check material invariants immediately before execution.

## Fail-closed rules

Unknown policy, missing policy, malformed policy, unavailable policy engine, contradictory policy, or inability to determine scope must not result in `ALLOW`.

A lower-level component must not override a higher-level `DENY` or `BLOCKED` result.

## Local authority

The local client enforces the policy result. Conversational confirmation, AI text, or an unsigned/unbound field cannot override the local policy decision.

## Material changes

A change to command, target, privilege, resource, scope, or other policy-relevant attribute requires policy re-evaluation. Where the authorization binding changes, fresh authorization is required.
