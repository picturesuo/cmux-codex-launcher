---
summary: Shared workflow rules for Codex sessions launched from this repo.
read_when:
  - You are changing target-project launch prompts.
  - You need the context reset, handoff, or publish boundary.
  - You are deciding how many cmux tabs or roles a launch should create.
---

# Agent Workflow

## Operating Model

The launcher is a small agent harness. Treat Markdown as the program that
defines the work loop, and treat shell scripts as the runtime.

Good launcher behavior is explicit:

- target checkout is known
- GitHub contribution repo is known
- role ownership is named
- verification commands are visible
- shared context captures current state
- shipping rules come from the target repo

## Launch Loop

1. Resolve target from `--choose`, a profile, explicit args, or last state.
2. Prefer a known profile when the selected checkout matches one.
3. Otherwise create a generic cockpit with `lead`, `build`, `verify`, and
   `ship`.
4. Write selected target and GitHub repo into the shared context.
5. Open role tabs idle unless `--autostart-roles` is explicit.
6. Start dev server and preview only when the profile or project shape gives a
   reasonable command and URL.

## Role Contract

- `lead`: scope, repo state, task split, integration, final answer.
- `build`: implementation only; smallest coherent change.
- `verify`: tests, typecheck, build, browser/runtime proof when relevant.
- `ship`: branch/origin/status, commits, pushes when the target repo asks for it.

Profile-specific roles can replace this generic set when the target project has
known ownership boundaries.

## Experiment Discipline

For iterative launcher changes, use a small loop:

1. State the behavior being improved.
2. Change one bounded surface.
3. Run a dry run or smoke check.
4. Keep the change only if the output proves the behavior improved.
5. Log the proof in the final response or shared context.

This mirrors the useful part of an autonomous experiment loop without letting
agents rewrite unrelated surfaces.

## Context Reset

- Treat about 80% context used as the reset point.
- Before compaction or handoff, update the shared context with status,
  decisions, changed files, verification, and next action.
- Do not spend the final 20% of context on broad planning, multi-file edits, or
  rediscovering docs.

## Publish Boundary

- This launcher repo commits focused changes on `main`.
- Push this launcher repo only when the user asks to publish/push or the task
  explicitly requires GitHub publication.
- Launched target projects follow their own `AGENTS.md`.
- Penny asks agents to commit and push finished repo-visible changes on `main`.
- Private, scratch, partial, failing, and unverified work should stay out of
  default publish paths.

## Decision Discipline

- Ask only when ambiguity changes scope, data exposure, architecture, or publish
  behavior.
- Prefer the simplest complete change.
- Add regression coverage when a bug was observed and the check is cheap.
- Every changed line should trace to the request, a verified bug, or cleanup
  made necessary by the current change.
