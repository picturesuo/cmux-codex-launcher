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

`--codex` uses the same resolution and shared-context contract, but opens the
Codex desktop app as the main surface and skips cmux.

## Launch Loop

1. Resolve target from `--choose`, a profile, explicit args, or last state.
2. Prefer a known profile when the selected checkout matches one.
3. Otherwise create a generic cockpit with `lead`, `build`, `verify`, and
   `ship`.
4. Write selected target and GitHub repo into the shared context.
5. Open role workspaces idle unless `--autostart-roles` is explicit.
6. Start dev server and preview only when the profile or project shape gives a
   reasonable command and URL.

Codex-app-first launches use the same first four steps, then seed missing
target-repo workflow files and open the Codex desktop app instead of creating
cmux role workspaces.

Use `docs/workflow-packaging-audit.md` when the user asks whether repeated work
should become a skill, subagent, automation, or other reusable asset. The audit
must inspect existing assets first, shortlist candidates with evidence, and
create only high-confidence missing items.

Each role workspace should stay visually simple: one role-specific Codex
surface and, when configured, one preview browser surface. Plan docs and helper
surfaces belong in docs, shared context, or separate workspaces, not hidden
inside every role.

## Role Contract

- `lead`: scope, repo state, task split, integration, final answer.
- `build`: implementation only; smallest coherent change.
- `verify`: tests, typecheck, build, browser/runtime proof when relevant.
- `ship`: branch/origin/status, commits, pushes, release hygiene.

Profile-specific roles can replace this generic set when the target project has
known ownership boundaries.

## Before Editing

Do not pick a path silently when the task is ambiguous.

Before implementation, name:

- assumptions that affect the path
- interpretations that would produce different diffs
- success criteria and the command or runtime proof for each criterion
- the files or surfaces expected to change

If the user asks for something broad, reduce it to a verifiable goal. If the
goal cannot be made verifiable from local context, ask before editing.

Example:

1. Add chooser regression test -> verify: `bash scripts/test-launcher.sh`
2. Update launcher behavior -> verify: `--choose --query penny --dry-run`
3. Update cmux config -> verify: `cmux config validate`

## Experiment Discipline

For iterative launcher changes, use a small loop:

1. State the behavior being improved.
2. Change one bounded surface.
3. Run a dry run or smoke check.
4. Keep the change only if the output proves the behavior improved.
5. Log the proof in the final response or shared context.

This mirrors the useful part of an autonomous experiment loop without letting
agents rewrite unrelated surfaces.

Keep changes only when the check proves improvement. If the check is neutral and
the code is more complex, simplify or discard the change.

## Context Reset

- Treat about 80% context used as the reset point.
- Before compaction or handoff, update the shared context with status,
  decisions, changed files, verification, and next action.
- Do not spend the final 20% of context on broad planning, multi-file edits, or
  rediscovering docs.

## Publish Boundary

- This launcher repo commits focused changes on `main`.
- Publish mode is `auto` unless the user explicitly asks for local-only work.
- Commit and push each finished repo-visible file change immediately after
  verification.
- Prefer one commit per finished file by default. Group files only when they are
  inseparable, such as source plus generated output.
- Launched target projects follow their own `AGENTS.md`.
- Penny asks agents to commit and push finished repo-visible changes on `main`.
- Private, scratch, partial, failing, and unverified work should stay out of
  default publish paths.

## Decision Discipline

- Ask only when ambiguity changes scope, data exposure, architecture, or publish
  behavior.
- Prefer the simplest complete change; no speculative features, abstractions, or
  configurability.
- Add regression coverage when a bug was observed and the check is cheap.
- Do not edit adjacent code, docs, formatting, or config unless the current
  request requires it.
- Mention unrelated cleanup opportunities; do not perform them unless asked.
- Every changed line should trace to the request, a verified bug, or cleanup
  made necessary by the current change.
