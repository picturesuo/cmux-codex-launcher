---
summary: Shared workflow rules for Codex sessions launched from this repo.
read_when:
  - You are changing target-project launch prompts.
  - You need the context reset, handoff, or publish boundary.
---

# Agent Workflow

## Context Reset

- Treat about 80% context used as the reset point.
- Before compacting or starting a fresh tab, update the shared context file with status, decisions, changed files, verification, and next action.
- Do not spend the final 20% of context on broad planning or multi-file edits.

## Publish Boundary

- This launcher repo commits and pushes when the user asks for GitHub publication.
- Launched target projects follow their own `AGENTS.md`.
- Penny currently asks agents to commit and push finished repo-visible changes on `main`.
- Private, scratch, partial, failing, and unverified work should stay out of default publish paths.

## Current Penny Role Shape

- `lead`: coordination, scope, git status, and final integration.
- `create-ui`: Landing to Create, five equal options, comments, artifact UX, and evidence visibility.
- `brain-evidence`: safe fixture/manual source evidence, source chips, privacy copy, and `trainingUse=false`.
- `learn-canvas`: Create to Learn bridge, return state, visual outline, and Canvas ending.
- `export-verify`: export prompt quality and verification.

## Decision Discipline

- State assumptions when they affect the path.
- Ask only when ambiguity changes scope, data exposure, architecture, or publish behavior.
- Prefer the simplest complete change; no speculative features, abstractions, or connector work.
- Every changed line should trace to the request, a verified bug, or cleanup caused by the current change.
