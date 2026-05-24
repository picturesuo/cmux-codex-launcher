---
summary: Rules for what belongs in repo policy, shared task state, and runtime prompt context.
read_when:
  - You are changing prompt size, context packing, or shared-artifact ownership.
  - You need to decide whether guidance belongs in AGENTS.md, docs, or the shared task artifact.
---

# Context Budget

## Placement

- Stable policy belongs in `AGENTS.md`.
- Durable workflow explanation belongs in `docs/*.md`.
- Durable reusable facts belong in `docs/knowledge.md`.
- Mutable task state belongs in the shared context artifact.
- Runtime prompts should carry only target facts, selected GitHub repo, role
  scope, and the smallest useful read-first list.

## Prompt Shape

- Prefer pointers to docs over duplicating long instructions.
- Include role-specific delta; do not paste every role's responsibilities into
  every role prompt.
- Include selected target and GitHub repo so a role can ship to the right place.
- Avoid output-format boilerplate already covered by repo policy or shared
  context.

## Reset Rule

- Treat about 80% context used as the reset point for long-running panes.
- Before compacting or starting a fresh pane, write current status, decisions,
  changed files, verification, and next action to the shared artifact.
- Do not spend the final 20% of context on broad planning, multi-file edits, or
  rediscovering local docs.

## Anti-Bloat Rule

A line earns space in `AGENTS.md` or a role prompt only if it prevents a likely
wrong action in this repo. Otherwise move it to a supporting doc or omit it.
