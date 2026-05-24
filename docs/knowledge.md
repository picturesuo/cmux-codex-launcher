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
- `user`: Pressing the cmux launcher should ask what file/app/repo is being worked on, infer the local checkout and GitHub target, then open the right cockpit in one step.
- `user`: After project selection, the chooser should ask for an explicit yes/no confirmation before using the inferred GitHub contribution target.
- `user`: Role workspaces should stay clean: left sidebar role entry, role-specific Codex surface, and preview surface only. Avoid hidden plan/doc/helper tabs inside each role.
- `user`: Deterministic profile launches should still exist for scripts and saved project commands.
- `user`: Penny launcher tabs should use Codex reasoning effort `xhigh` when the user says "extra high."
- `user`: Keep role prompts specific and avoid loading every tab with irrelevant context.
- `user`: Use safe fixtures and explicit docs for Penny demo work; avoid live connector fragility in launcher prompts.
- `user`: Agent guidance should be explicit and non-ambiguous: think before coding, keep changes simple, edit surgically, and define verifiable success criteria before implementation.
- `user`: Preserve Ghostty-launcher-style publishing for this repo: commit and push each finished repo-visible file change after verification unless local-only work is requested.

## Repo Facts

- `repo`: Canonical GitHub repo slug is `picturesuo/cmux-codex-launcher`.
- `repo`: Main entrypoint is `bin/cmux-codex-launcher`.
- `repo`: Interactive chooser mode is `bin/cmux-codex-launcher --choose`.
- `repo`: Default profile is `profiles/penny.env`.
- `repo`: User override profiles live in `~/.config/cmux-codex-launcher/profiles/<name>.env`.
- `repo`: Launch state lives in `~/.config/cmux-codex-launcher/state/last.env`.
- `repo`: Shared task context files live in `~/.codex/cmux-codex-launcher/`.
- `repo`: The launcher opens cmux workspaces with `cmux new-workspace --layout`.
- `repo`: The cmux plus-button action opens a temporary chooser workspace that closes itself after launching the role workspaces.
- `repo`: The launcher opens Codex Desktop with `codex app <project path>` when enabled.
- `repo`: The plan tab does not auto-run `cmux markdown open`; run the printed command after launch to avoid workspace recursion during startup.
- `repo`: Project-local cmux actions live in `.cmux/cmux.json`.
- `repo`: Global cmux launcher action lives in `~/.config/cmux/cmux.json` and points at `--choose`.
- `repo`: User wrapper `/Users/bensuo/codex-launchpad.sh` delegates no-argument launches to `--choose`.
- `repo`: `CMUX_CODEX_SEARCH_ROOTS` overrides local fuzzy search roots.
- `repo`: `CMUX_CODEX_PROJECTS_DIR` overrides where GitHub-only matches are cloned.
- `repo`: `scripts/test-launcher.sh` is the main smoke test.
- `repo`: `scripts/doctor.sh` checks local prerequisites and Penny profile resolution.
- `repo`: `scripts/install-local.sh` creates `~/bin/cmux-codex-launcher`.
- `repo`: `CML_AUTOSTART_ROLES=false` opens role tabs idle; use `--autostart-roles` only for intentional background agents.
- `repo`: `CML_ROLE_PANE_SPLIT=0.5` keeps role and preview panes equal; use `0.4` for a preview-heavy 60/40 split.
- `repo`: Public files must not contain secrets, tokens, OAuth credentials, private data, or local `.env` contents.
- `repo`: Dynamic chooser cockpits use `lead`, `build`, `verify`, and `ship` roles.

## Penny Profile Facts

- `penny`: Project path is `/Users/bensuo/Desktop/penny`.
- `penny`: Workspace name is `Penny Create`.
- `penny`: Preview URL is `http://localhost:3007`.
- `penny`: Codex effort is `xhigh`.
- `penny`: Dev command sources `.env.local` inside Penny and runs `PORT=3007 pnpm dev`.
- `penny`: Plan doc is `docs/penny-create-operating-outline.md`.
- `penny`: Extra read-first docs are `docs/yc-demo-coding-brief.md` and `docs/yc-demo-runbook.md`.
- `penny`: Role tabs are `lead`, `create-ui`, `brain-evidence`, `learn-canvas`, and `export-verify`.
- `penny`: Role tabs default to idle Codex CLI sessions to avoid recursive launcher starts.

## External References

- `external`: cmux project configs use `.cmux/cmux.json` for local actions, commands, and layouts.
- `external`: cmux supports `new-workspace --layout` for scripted split layouts.
- `external`: Codex CLI supports `codex app <path>` on macOS to open Codex Desktop on a workspace path.
- `external`: Karpathy's `autoresearch` treats Markdown as the human-written program for agents, with explicit editable files, fixed evaluation, and keep/discard loops.
- `external`: Steinberger's `agent-scripts` keeps AGENTS guidance terse, routing-heavy, and focused on hard rules; this launcher adapts that style but uses auto commit/push by default.

## Retrieval Hints

- Search this file, `README.md`, `tools.md`, and `docs/project-profiles.md` before broader search.
- Use `bin/cmux-codex-launcher --profile penny --dry-run` to inspect resolved profile state.
- Use `bin/cmux-codex-launcher --choose --query <hint> --dry-run` to inspect chooser resolution.
