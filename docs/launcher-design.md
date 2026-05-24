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

- Codex Desktop first: everyday project work when the user wants the Codex app
  to act like the terminal, with repo-local Markdown files, shared context, and
  Codex config doing the routing.
- cmux + Codex CLI: attended parallel workstreams, previews, logs,
  verification, and shipping hygiene when visible terminal panes are worth the
  extra machinery.

## Design Principles

- Markdown programs the agents; shell scripts provide the runtime.
- The user-facing launch path should be one command.
- Dry runs should explain exactly what will open.
- Profiles should encode known project context.
- Dynamic launches should infer only conservative defaults.
- Role tabs should open idle by default to avoid accidental background work.
- The selected target and GitHub repo must be visible in every role tab.
- Codex-app-first launches should seed only missing workflow files and never
  overwrite a target repo's existing instructions.
- Keep each role in a separate cmux workspace by default so the left sidebar is
  the role switcher, one agent is visible at a time, and unread notifications
  mark the workspace that needs attention.
- The plus-button chooser should be a temporary workspace that closes after a
  successful launch, leaving only role workspaces and any intentional support
  workspaces in the sidebar.

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
- Codex reasoning: interactive terminal sessions default to `medium`, while
  Plan mode defaults to `high` for architecture and design passes.

## Chooser Contract

`--choose` should:

1. Ask for a project, file, app, folder, or GitHub repo.
2. Search local git checkouts, matching files, explicit paths, and GitHub repos.
3. Prefer an existing profile when the resolved checkout matches one.
4. Clone GitHub-only matches under `CMUX_CODEX_PROJECTS_DIR` or `~/Desktop`.
5. Infer dynamic roles only when no profile fits.
6. Write selected target and GitHub repo into shared context.
7. Never store secrets or credentials in generated files.

`--codex` should:

1. Use the same chooser, profile, project override, and GitHub confirmation path.
2. Open Codex Desktop on the resolved checkout.
3. Skip cmux workspace creation.
4. Create only missing target-repo workflow files:
   `AGENTS.md`, `docs/agent-workflow.md`, `docs/queue.md`,
   `docs/knowledge.md`, and `.codex/config.toml`.
5. Leave existing target repo workflow files untouched.
6. Support `--reset-task` for clearing only the mutable shared-context task
   block.

## Dynamic Cockpit Shape

When no profile matches:

- `lead`: coordination and repo state
- `build`: implementation
- `verify`: tests and runtime proof
- `ship`: branch/origin/commit/push hygiene

The dynamic cockpit can include a dev server and browser preview only when the
repo clearly exposes a standard `dev` command and likely local URL. The dev
server opens as a background sidebar workspace; the browser preview opens as
the right half of each role workspace rather than as another tab or pane pile.

## Sources

- Karpathy `autoresearch`: https://github.com/karpathy/autoresearch
- Karpathy `program.md`: https://github.com/karpathy/autoresearch/blob/master/program.md
- Steinberger `agent-scripts` AGENTS: https://github.com/steipete/agent-scripts/blob/main/AGENTS.MD
- Steinberger `Just Talk To It`: https://steipete.me/posts/just-talk-to-it
- Steinberger Codex app summary: https://zenn.dev/seyz/articles/20260308-steipete-codex-how-to
- Simon Willison on Peter's Codex CLI workflow: https://simonwillison.net/2025/Oct/14/agentic-engineering/
- Simon Willison on parallel coding agents: https://simonwillison.net/2025/Oct/5/parallel-coding-agents/
- OpenAI Codex best practices: https://developers.openai.com/codex/learn/best-practices
- OpenAI Codex config reference: https://developers.openai.com/codex/config-reference
- OpenAI Codex config sample: https://developers.openai.com/codex/config-sample
- cmux custom commands: https://cmux.com/docs/custom-commands
- cmux homepage community workflow notes: https://cmux.com/
- Peter Steinberger May 23, 2026 cmux/Codex split snapshot: https://digg.com/ai/j5do9ink
- cmux Vault changelog: https://cmux.com/blog/cmux-vault
- cmux workspace CLI docs: https://manaflow-ai-cmux.mintlify.app/cli/workspaces
- Codex CLI reference: https://developers.openai.com/codex/cli/reference
