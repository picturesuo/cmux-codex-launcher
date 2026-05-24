# AGENTS.md

## Purpose

This repo builds the personal cmux + Codex launcher.

The launcher should take a fuzzy file/app/repo hint, resolve the right local
checkout and GitHub repo, then open a cmux cockpit with useful Codex tabs,
preview/log surfaces, shared context, and a clear ship path.

## Read First

- `README.md`: user-facing behavior and commands.
- `tools.md`: exact local commands.
- `docs/launcher-design.md`: architecture and external references.
- `docs/codex-app-workflow.md`: Codex-app-first workflow and seeded files.
- `docs/cmux-cockpit-loadout.md`: one-click cmux loadout and success criteria.
- `docs/codex-terminal-profile.md`: Codex reasoning defaults and when to use medium, high, or xhigh.
- `docs/project-signals.md`: quota, repo health, summarize, gitcrawl, and dashboard integration.
- `docs/agent-workflow.md`: launch loop, handoff, and shipping behavior.
- `docs/knowledge.md`: stable repo facts and user preferences.
- `docs/agentic-workflow-research.md`: sourced workflow research and success criteria.
- `docs/source-inspirations.md`: external patterns adapted for this repo.

## Hard Rules

- Keep shell scripts portable to macOS `bash` 3.2 where practical.
- No secrets in profiles, `.cmux/cmux.json`, docs, scripts, commits, or issue/PR
  bodies.
- Keep `AGENTS.md` to durable rules; put workflow explanation in `docs/*.md`.
- Prefer project profiles for paths, commands, ports, docs, and role prompts.
- Prefer cmux workspace layouts over Ghostty or AppleScript automation.
- Do not add GUI prompts. `--choose` may ask in the terminal; deterministic
  profile launches must stay scriptable.
- Public docs must be safe to publish.
- For target projects launched by this tool, read that repo's own `AGENTS.md`
  before editing.

## Think Before Coding

- State assumptions before implementation when they affect the path.
- Do not hide confusion. If something is unclear, name it and ask.
- If multiple interpretations exist, present them before choosing.
- If a simpler approach exists, say so and use it unless there is a concrete
  reason not to.
- Push back when the request implies unnecessary scope, risky data exposure, or
  brittle architecture.

## Simplicity First

- Write the minimum code that solves the problem.
- No features beyond what was asked.
- No abstractions for single-use code.
- No speculative configurability.
- No error handling for impossible scenarios.
- If a change feels overbuilt, rewrite it smaller before handoff.

## Surgical Changes

- Touch only what the request requires.
- Do not improve adjacent code, comments, formatting, docs, or config unless the
  current change requires it.
- Match existing style even when another style would be preferable.
- Mention unrelated dead code or cleanup opportunities; do not remove them
  unless asked.
- Remove only imports, variables, functions, docs, or config entries made
  obsolete by your own change.
- Every changed line must trace to the user request, a verified bug, or cleanup
  caused by the current change.

## Goal-Driven Execution

- Convert vague tasks into verifiable success criteria before editing.
- For bugs, prefer a check that reproduces the failure before fixing it.
- For behavior changes, define the dry run, test, or runtime proof that will
  show completion.
- For multi-step work, keep a short plan where each step has an explicit check.
- Loop until the relevant checks pass or a real blocker is named.

## Launcher Loop

1. Resolve the target from explicit args, `--choose`, a profile, or last state.
2. Confirm the local checkout and GitHub contribution target.
3. Build the smallest useful cockpit: plan/context, focused role tabs, optional
   dev server, optional browser preview.
4. Write selected target and GitHub repo into the shared context.
5. Keep role tabs idle by default unless `--autostart-roles` is explicit.
6. Verify with dry runs before real launches when behavior changes.

## Scope Boundaries

- `bin/cmux-codex-launcher` owns launcher behavior.
- `profiles/*.env` owns project-specific defaults.
- `.cmux/cmux.json` owns project-local cmux actions and commands.
- `~/.config/cmux/cmux.json` is user-global config; back it up before editing.
- `docs/*.md` owns durable workflow knowledge, not current task state.
- `~/.codex/cmux-codex-launcher/*-shared-context.md` owns current task state.

## Verification

- Shell edits: `bash -n bin/cmux-codex-launcher scripts/*.sh`
- Launcher behavior: `bash scripts/test-launcher.sh`
- Layout JSON: `bin/cmux-codex-launcher --profile penny --print-layout`
- Picker behavior: `bin/cmux-codex-launcher --choose --query penny --dry-run`
- cmux config edits: `cmux config validate`, then `cmux reload-config`

## Git

- Work on `main`.
- Start with `git status --short --branch`.
- Preserve user or other-agent changes; do not revert unrelated work.
- Use focused commits with conventional prefixes when practical.
- Publish mode is `auto` unless the user explicitly asks for local-only work.
- Commit and push each finished repo-visible file change immediately after
  verification.
- Prefer one commit per finished file; group files only when they are
  inseparable, such as source plus generated output.
- Destructive git operations require explicit user instruction.
