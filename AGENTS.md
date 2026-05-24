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
- `docs/agent-workflow.md`: launch loop, handoff, and shipping behavior.
- `docs/knowledge.md`: stable repo facts and user preferences.
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
- Push only when the user asks for GitHub publication, asks to push, or the task
  explicitly requires publication.
- Destructive git operations require explicit user instruction.
