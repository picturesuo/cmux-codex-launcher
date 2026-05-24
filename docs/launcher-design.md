---
summary: Design notes and external references for the cmux Codex launcher.
read_when:
  - You are changing launcher behavior, profiles, chooser search, or cmux workspace layout.
---

# Launcher Design

## Goal

Open a coding cockpit from a fuzzy human hint.

The launcher should ask what project, file, app, folder, or GitHub repo the
user is working on, find the matching local checkout or GitHub repo, confirm
the GitHub contribution target, then open cmux and Codex Desktop against the
same project path.

Deterministic profile launches remain available for scripted paths such as
`--profile penny`.

## Current Workflow Split

- Codex Desktop: reading, learning, long-context discussion, Appshots, external
  app context, and product thinking.
- cmux + Codex CLI: coding workstreams, preview, logs, verification, and
  shipping hygiene.

## Design Principles

- Markdown programs the agents; shell scripts provide the runtime.
- The user-facing launch path should be one command.
- Dry runs should explain exactly what will open.
- Profiles should encode known project context.
- Dynamic launches should infer only conservative defaults.
- Role tabs should open idle by default to avoid accidental background work.
- The selected target and GitHub repo must be visible in every role tab.
- Keep the main cmux workspace tabbed by default so one agent surface is visible
  at a time and Feed can use the right sidebar.

## Incorporated Patterns

- Karpathy-style loop: small harness, explicit editable surface, fixed
  evaluation, keep/discard based on measured output.
- Steinberger-style AGENTS: terse hard rules, strong routing, secrets hygiene,
  atomic publish boundaries, and practical git constraints. This repo adapts
  that style to the user's requested auto commit/push workflow.
- cmux custom commands: project-local `.cmux/cmux.json`, actions, command
  palette entries, and workspace layouts.
- cmux CLI: `new-workspace --layout` for scripted split layouts.
- Codex CLI: `codex app <path>` for opening Codex Desktop on macOS.

## Chooser Contract

`--choose` should:

1. Ask for a project, file, app, folder, or GitHub repo.
2. Search local git checkouts, matching files, explicit paths, and GitHub repos.
3. Prefer an existing profile when the resolved checkout matches one.
4. Clone GitHub-only matches under `CMUX_CODEX_PROJECTS_DIR` or `~/Desktop`.
5. Infer dynamic roles only when no profile fits.
6. Write selected target and GitHub repo into shared context.
7. Never store secrets or credentials in generated files.

## Dynamic Cockpit Shape

When no profile matches:

- `lead`: coordination and repo state
- `build`: implementation
- `verify`: tests and runtime proof
- `ship`: branch/origin/commit/push hygiene

The dynamic cockpit can include a dev server and browser preview only when the
repo clearly exposes a standard `dev` command and likely local URL. Those open
as tabs in the same pane rather than as default splits.

## Sources

- Karpathy `autoresearch`: https://github.com/karpathy/autoresearch
- Karpathy `program.md`: https://github.com/karpathy/autoresearch/blob/master/program.md
- Steinberger `agent-scripts` AGENTS: https://github.com/steipete/agent-scripts/blob/main/AGENTS.MD
- Steinberger `Just Talk To It`: https://steipete.me/posts/just-talk-to-it
- Simon Willison on Peter's Codex CLI workflow: https://simonwillison.net/2025/Oct/14/agentic-engineering/
- Simon Willison on parallel coding agents: https://simonwillison.net/2025/Oct/5/parallel-coding-agents/
- OpenAI Codex best practices: https://developers.openai.com/codex/learn/best-practices
- cmux custom commands: https://cmux.com/docs/custom-commands
- cmux workspace CLI docs: https://manaflow-ai-cmux.mintlify.app/cli/workspaces
- Codex CLI reference: https://developers.openai.com/codex/cli/reference
