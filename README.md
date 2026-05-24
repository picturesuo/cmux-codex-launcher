# cmux Codex Launcher

A small macOS launcher for opening a ready-to-work Codex desktop app workspace
or cmux coding cockpit on the right project.

It now supports two launch styles:

- Codex app first: project chooser, repo-local workflow files, shared context,
  and the Codex desktop app as the main work surface.
- cmux + Codex CLI: visible role workspaces, preview, logs, dev server, and
  verification panes when a terminal cockpit is still useful.

The launcher avoids the old Ghostty AppleScript project prompt. It uses explicit
profiles, deterministic defaults, and cmux workspace layouts.

## Quick Start

```bash
bin/cmux-codex-launcher --codex
bin/cmux-codex-launcher --codex --query penny
bin/cmux-codex-launcher --choose
bin/cmux-codex-launcher --choose --query penny --dry-run
bin/cmux-codex-launcher --profile penny
scripts/open-project-signals.sh
```

Install a local command:

```bash
scripts/install-local.sh
cmux-codex-launcher
```

The default profile is still `penny` for deterministic scripts. The cmux action
uses `--choose`, which asks what project, file, app, folder, or GitHub repo you
are working on and which GitHub repo the work should contribute to.

The cmux Command Palette and plus-button context menu also include
`Open Project Signals`. It starts CodexBar and RepoBar, then opens a small cmux
workspace with a plain-language guide on the left and ReleaseBar/RepoBar
reference surfaces on the right.

## Codex App First

Use `--codex` when the Codex desktop app should replace the terminal cockpit for
the current task:

```bash
bin/cmux-codex-launcher --codex
bin/cmux-codex-launcher --codex --profile penny
bin/cmux-codex-launcher --codex --reset-task
```

`--codex` asks for the project/file/repo unless a profile or project path is
given, confirms the GitHub target, seeds missing workflow files, opens Codex
Desktop, and skips cmux. The seeded target-repo files are:

```text
AGENTS.md
docs/agent-workflow.md
docs/workflow-packaging-audit.md
docs/queue.md
docs/knowledge.md
.codex/config.toml
```

Existing files are not overwritten. Use `--no-seed-codex-files` for repos that
already have their own Codex setup. Use `--reset-task` to clear only the mutable
task block in the launcher shared context, leaving durable knowledge and repo
docs intact.

See [docs/codex-app-workflow.md](docs/codex-app-workflow.md).

## One-Click Chooser

`--choose` searches:

- local git checkouts and matching files under `~/Desktop`, `~/Projects`,
  `~/src`, and `~/code`
- GitHub repos available to the active `gh` account
- explicit paths typed into the prompt

If a selected GitHub repo is not cloned locally, the launcher clones it under
`~/Desktop` by default. Set `CMUX_CODEX_PROJECTS_DIR` to use a different clone
root. Set `CMUX_CODEX_SEARCH_ROOTS` to a colon-separated list when your working
folders live somewhere else.

When the selected project matches a profile, the launcher reuses that profile.
Otherwise it builds a generic cockpit with `lead`, `build`, `verify`, and
`ship` roles. The shared context records the selected file/folder and GitHub
target so every Codex tab starts from the same repo boundary.

## What Opens

For `--codex`, the launcher opens Codex Desktop on the resolved checkout and
creates missing target-repo workflow files. For a cmux launch, the launcher can
open:

- a set of left-sidebar cmux workspaces, one per Codex role
- an optional dev-server workspace
- a browser preview as the right half of each role workspace when configured
- the cmux Feed in the right sidebar for agent messages and approvals
- the Codex desktop app for the same workspace path and model settings

By default each role workspace opens Codex CLI idle. A role workspace contains
only that role surface plus the preview surface when one is configured, so there
is no hidden plan/doc tab pile inside each role. That keeps the workspace ready
without letting background agents run setup commands or create recursive cmux
workspaces before you give them the actual task.

The launcher writes a shared context file under:

```text
~/.codex/cmux-codex-launcher/<project>-shared-context.md
```

Role prompts point agents at that file, the target project, and relevant docs.

## Profiles

Profiles are shell files in `profiles/*.env` or
`~/.config/cmux-codex-launcher/profiles/*.env`.

Use only non-secret values:

```bash
CML_PROJECT_NAME="Penny"
CML_PROJECT_DIR="/Users/bensuo/Desktop/penny"
CML_WORKSPACE_NAME="Penny Create"
CML_PREVIEW_URL="http://localhost:3007"
CML_DEV_COMMAND='if lsof -nP -iTCP:3007 -sTCP:LISTEN >/dev/null 2>&1; then printf "Penny dev server is already running at http://localhost:3007\n"; exec "${SHELL:-/bin/zsh}" -l; fi; set -a; [ -f .env.local ] && source .env.local; set +a; PENNY_SKIP_DATABASE_PREP=true PENNY_AUTH_MODE=dev PORT=3007 pnpm dev'
CML_PLAN_DOC="docs/penny-create-operating-outline.md"
CML_EXTRA_DOCS=("docs/yc-demo-coding-brief.md" "docs/yc-demo-runbook.md")
CML_CODEX_EFFORT="medium"
CML_CODEX_PLAN_EFFORT="high"
CML_ROLE_NAMES=("lead" "create-ui" "brain-evidence" "learn-canvas" "export-verify")
CML_ROLE_PANE_SPLIT="0.5"
CML_AUTOSTART_ROLES="false"
CML_SHOW_FEED_SIDEBAR="true"
CML_WORKSPACE_MODE="sidebar"
```

Do not put API keys, database passwords, OAuth secrets, or tokens in a profile.
Source a target project’s `.env.local` from the dev-server command instead.

## Commands

```bash
bin/cmux-codex-launcher --profile penny
bin/cmux-codex-launcher --choose
bin/cmux-codex-launcher --codex
bin/cmux-codex-launcher --codex --reset-task
bin/cmux-codex-launcher --choose --query "pricing page" --dry-run
bin/cmux-codex-launcher --project /path/to/repo --name "My Repo"
bin/cmux-codex-launcher --resume-last
bin/cmux-codex-launcher --status-last
bin/cmux-codex-launcher --print-layout --profile penny
bin/cmux-codex-launcher --no-app --profile penny
bin/cmux-codex-launcher --autostart-roles --profile penny
```

## Why This Shape

The implementation follows Codex and cmux patterns:

- repo-scoped `.codex/config.toml` plus small Markdown files for durable
  Codex-app behavior, including a workflow-packaging audit for deciding when
  repeated work should become a skill, subagent, automation, extension, or skip
- project-local `.cmux/cmux.json` commands and actions when a repo should carry
  its own layout
- a temporary chooser workspace for the plus button; after the chooser creates
  role workspaces, it closes itself so the sidebar stays clean
- `cmux new-workspace --layout` for one-shot launchers
- browser surfaces for local preview
- notification/read-state workflow instead of staring at many split panes
- `codex app <path>` for the desktop app when available

See [docs/launcher-design.md](docs/launcher-design.md) and
[docs/codex-app-workflow.md](docs/codex-app-workflow.md) for the Codex-first
path, and [docs/cmux-cockpit-loadout.md](docs/cmux-cockpit-loadout.md) for the
cmux cockpit. See
[docs/codex-terminal-profile.md](docs/codex-terminal-profile.md) for the
reasoning-effort defaults and [docs/project-signals.md](docs/project-signals.md)
for the optional project-signal tools.
