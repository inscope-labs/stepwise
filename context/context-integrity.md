# StepWise Context Integrity

**Document:** Context Integrity  
**Status:** Draft — Phase 1  
**Framework:** StepWise Agentic Governance Framework v0.1  
**Prompt version:** 0.1.2  

## 1. Purpose

Defines identity, version, hash, provenance, and compatibility requirements for loaded context.

## 2. Requirements

Every loaded governance, feature, or specification artifact SHOULD be identifiable by:

- artifact name / address
- version
- source (path or URI)
- framework compatibility
- integrity/hash where supported

## 3. Compatibility Check

Before treating an artifact as authoritative, verify that its declared Framework major.minor is compatible with the active prompt version (0.1.2). Incompatible artifacts MUST NOT silently override core rules.

## 4. Failure

An artifact that cannot be authenticated, version-checked, or resolved MUST NOT silently replace a trusted governance artifact. The dependent operation becomes Blocked.
