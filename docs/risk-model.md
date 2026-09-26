# StepWise Risk Model

**Status:** Draft — Phase 1  
**Framework:** StepWise Agentic Governance Framework v0.1

## 1. Purpose

StepWise represents risk as independent dimensions that can combine to determine required governance controls.

Risk classification is not a prediction of harm. It is a control-selection mechanism.

## 2. Risk Dimensions

### R0 — Read Only

Does not intentionally modify persistent state.

### R1 — Create

Creates files, records, resources, packages, or other state.

### R2 — Modify

Changes existing state.

### R3 — Privileged

Requires elevated permissions or access.

### R4 — Credential Sensitive

Reads, handles, transforms, or transmits secrets or sensitive authentication material.

### R5 — Network

Communicates with external systems.

### R6 — Persistent State

Changes state that survives the current process/session.

### R7 — Destructive

Deletes, overwrites, invalidates, or materially damages existing state.

### R8 — Irreversible

An operation for which practical recovery is unavailable or uncertain.

### R9 — Protected Resource

Touches a resource designated as governance-, security-, audit-, production-, or otherwise protected.

### R10 — Production/Release Impacting

Can affect production behavior, release artifacts, distribution, or externally consumed versions.

## 3. Multiple Dimensions

An action MAY have multiple risk dimensions.

Example:

```text
git push --force
```

may simultaneously be:

- network;
- modify;
- persistent-state;
- destructive;
- potentially protected-resource;
- potentially release-impacting.

## 4. Risk Is Not Authorization

Risk classification determines required controls.

It does not itself authorize or prohibit an action.

## 5. Risk Escalation

If any applicable risk dimension increases, required governance controls MUST NOT become weaker.

## 6. Reference Control Levels

### Low

Typical read-only operations.

Expected controls:

- normal StepWise progression;
- evidence where required.

### Moderate

Creates/modifications/network operations.

Expected controls:

- explicit risk classification;
- evidence;
- authorization when policy requires.

### High

Privileged, credential-sensitive, protected-resource, destructive, or production-impacting operations.

Expected controls:

- explicit authorization;
- exact-action binding;
- stronger evidence;
- audit record.

### Critical

Irreversible or high-impact combinations.

Expected controls MAY include:

- explicit human authorization;
- confirmation of target/scope;
- recovery assessment;
- exact-action binding;
- enhanced audit;
- additional policy approval.

These levels are reference categories. Implementations MAY define stricter mappings.

## 7. Risk Unknown

If risk cannot be reasonably classified, the action SHOULD be treated as requiring stronger governance rather than weaker governance.

## 8. Credential Handling

Credential-sensitive operations SHOULD bypass ordinary automatic-copy/context pathways unless the applicable policy explicitly permits them.

Credential-bearing evidence SHOULD be redacted or withheld from AI context by default.

## 9. Protected Resources

Protected-resource access SHOULD require policy evaluation even when the underlying operation appears technically simple.

## 10. Irreversibility

Irreversible actions SHOULD identify:

- affected resource;
- recovery possibility;
- scope;
- expected result;
- authorization requirement.

## 11. Risk Reclassification

If new evidence changes the risk classification materially, previously granted authorization SHOULD be considered invalid until the new risk state is reviewed.

## 12. Risk Provenance

Risk classification SHOULD record:

- dimensions;
- classifier/source;
- timestamp;
- relevant action;
- policy version.

## 13. Fail Closed

An implementation MUST NOT lower a risk classification merely to avoid an authorization requirement.

## 14. Example

```text
Action:
Delete a protected release artifact.

Dimensions:
R2 Modify
R7 Destructive
R8 Irreversible
R9 Protected Resource
R10 Production/Release Impacting

Expected result:
High/Critical governance path.

Required:
Policy evaluation
Explicit authorization
Exact-action binding
Execution evidence
Verification
Audit record
```
