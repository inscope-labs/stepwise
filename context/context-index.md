# StepWise Context Index

**Document:** Context Index  
**Status:** Draft — Phase 1  
**Framework:** StepWise Agentic Governance Framework v0.1  
**Prompt version:** 0.1.2  

## 1. Purpose

Defines the metadata/index structure used to discover available context without loading its full contents.

## 2. Index Requirements

An index entry MUST include at minimum:

| Field | Description |
|-------|-------------|
| address | `feature:<name>` or `spec:<feature>/<section>` |
| path | Repository-relative path |
| version | Artifact version |
| framework_compatibility | Compatible prompt major.minor |
| size_bytes | Source size |
| summary | One-line description |
| depends_on | List of other addresses required |
| integrity | Hash or integrity identifier when available |

## 3. Bootstrap Index

Tier 0 SHOULD expose a minimal index of registered features and specifications so that the agent can decide what to load without reading every file.

## 4. Index-before-Content Rule

Before loading the body of any Tier 2 or Tier 3 artifact, the corresponding index entry (or an equivalent metadata header) MUST be consulted. This prevents accidental bulk loading.
