# cmux Codex Launcher

A small macOS launcher for opening a ready-to-work cmux coding cockpit and the
Codex desktop app on the same project.

It is built for the current Peter-style split:

- Codex app: reading, knowledge work, learning, Appshots, and strategy.
- cmux + Codex CLI: coding workstreams, preview, logs, and verification.

The launcher avoids the old Ghostty AppleScript project prompt. It uses explicit
profiles, deterministic defaults, and cmux workspace layouts.

## Quick Start

```bash
bin/cmux-codex-launcher --profile penny --dry-run
bin/cmux-codex-launcher --profile penny
```

Install a local command:

```bash
scripts/install-local.sh
cmux-codex-launcher
```

The default profile is `penny`, so a no-argument run opens Penny unless you set
`CMUX_CODEX_LAUNCHER_PROFILE`.

## What Opens

For a profile, the launcher can open:

- a cmux workspace with named Codex CLI tabs
- a plan/docs terminal that opens a markdown panel
- an optional dev-server tab
- an optional browser preview pane
- the Codex desktop app for the same workspace path

By default the role tabs open Codex CLI idle. That keeps the workspace ready
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
CML_ROLE_NAMES=("lead" "create-ui" "brain-evidence" "learn-canvas" "export-verify")
CML_AUTOSTART_ROLES="false"
```

Do not put API keys, database passwords, OAuth secrets, or tokens in a profile.
Source a target project’s `.env.local` from the dev-server command instead.

## Commands

```bash
bin/cmux-codex-launcher --profile penny
bin/cmux-codex-launcher --project /path/to/repo --name "My Repo"
bin/cmux-codex-launcher --resume-last
bin/cmux-codex-launcher --status-last
bin/cmux-codex-launcher --print-layout --profile penny
bin/cmux-codex-launcher --no-app --profile penny
bin/cmux-codex-launcher --autostart-roles --profile penny
```

## Why This Shape

The implementation follows current cmux patterns:

- project-local `.cmux/cmux.json` commands and actions when a repo should carry
  its own layout
- `cmux new-workspace --layout` for one-shot launchers
- browser surfaces for local preview
- notification/read-state workflow instead of staring at many split panes
- `codex app <path>` for the desktop app when available

See [docs/launcher-design.md](docs/launcher-design.md) for the design notes and
external references.
