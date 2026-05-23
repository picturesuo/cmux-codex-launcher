---
summary: Durable launcher facts and user workflow preferences.
read_when:
  - You need stable repo facts before changing launcher behavior.
  - You are checking whether a profile or doc belongs in this repo.
---

# Knowledge

## User Workflow

- `user`: Prefer cmux plus Codex CLI for coding workstreams, logs, preview, and verification.
- `user`: Prefer the Codex desktop app for reading, learning, strategy, and broader product context.
- `user`: No launcher should ask which project is being worked on when the intended project is known.
- `user`: The default no-argument workflow should open Penny ready to code.
- `user`: Penny work should use medium reasoning effort unless explicitly changed.
- `user`: Keep role prompts specific and avoid loading every tab with irrelevant context.
- `user`: Use safe fixtures and explicit docs for Penny demo work; avoid live connector fragility in launcher prompts.

## Repo Facts

- `repo`: Canonical GitHub repo slug is `picturesuo/cmux-codex-launcher`.
- `repo`: Main entrypoint is `bin/cmux-codex-launcher`.
- `repo`: Default profile is `profiles/penny.env`.
- `repo`: User override profiles live in `~/.config/cmux-codex-launcher/profiles/<name>.env`.
- `repo`: Launch state lives in `~/.config/cmux-codex-launcher/state/last.env`.
- `repo`: Shared task context files live in `~/.codex/cmux-codex-launcher/`.
- `repo`: The launcher opens cmux workspaces with `cmux new-workspace --layout`.
- `repo`: The launcher opens Codex Desktop with `codex app <project path>` when enabled.
- `repo`: Project-local cmux actions live in `.cmux/cmux.json`.
- `repo`: `scripts/test-launcher.sh` is the main smoke test.
- `repo`: `scripts/doctor.sh` checks local prerequisites and Penny profile resolution.
- `repo`: `scripts/install-local.sh` creates `~/bin/cmux-codex-launcher`.
- `repo`: `CML_AUTOSTART_ROLES=false` opens role tabs idle; use `--autostart-roles` only for intentional background agents.
- `repo`: Public files must not contain secrets, tokens, OAuth credentials, private data, or local `.env` contents.

## Penny Profile Facts

- `penny`: Project path is `/Users/bensuo/Desktop/penny`.
- `penny`: Workspace name is `Penny Create`.
- `penny`: Preview URL is `http://localhost:3007`.
- `penny`: Dev command sources `.env.local` inside Penny and runs `PORT=3007 pnpm dev`.
- `penny`: Plan doc is `docs/penny-create-operating-outline.md`.
- `penny`: Extra read-first docs are `docs/yc-demo-coding-brief.md` and `docs/yc-demo-runbook.md`.
- `penny`: Role tabs are `lead`, `create-ui`, `brain-evidence`, `learn-canvas`, and `export-verify`.
- `penny`: Role tabs default to idle Codex CLI sessions to avoid recursive launcher starts.

## External References

- `external`: cmux project configs use `.cmux/cmux.json` for local actions, commands, and layouts.
- `external`: cmux supports `new-workspace --layout` for scripted split layouts.
- `external`: Codex CLI supports `codex app <path>` on macOS to open Codex Desktop on a workspace path.

## Retrieval Hints

- Search this file, `README.md`, `tools.md`, and `docs/project-profiles.md` before broader search.
- Use `bin/cmux-codex-launcher --profile penny --dry-run` to inspect resolved profile state.
