---
summary: How launcher profiles are loaded and what should go in them.
read_when:
  - You need to add a new project to the launcher.
  - You are debugging wrong project, wrong port, or wrong docs behavior.
---

# Project Profiles

Profiles are shell files. They are intentionally simple because the launcher is
for one person’s workstation, not for untrusted remote configuration.

Profile lookup order:

1. `~/.config/cmux-codex-launcher/profiles/<name>.env`
2. `profiles/<name>.env` inside this repo

Deterministic profile launch uses:

1. `CMUX_CODEX_LAUNCHER_PROFILE`
2. `penny`

The user-facing cmux action and `/Users/bensuo/codex-launchpad.sh` default to
`--choose`, not directly to Penny. Keep both paths working:

- `--choose`: interactive chooser for daily launches
- `--profile penny`: deterministic profile launch for scripts and dry runs

## Supported Variables

- `CML_PROJECT_NAME`
- `CML_PROJECT_DIR`
- `CML_WORKSPACE_NAME`
- `CML_WORKSPACE_DESCRIPTION`
- `CML_PREVIEW_URL`
- `CML_DEV_COMMAND`
- `CML_PLAN_DOC`
- `CML_EXTRA_DOCS`
- `CML_ROLE_NAMES`
- `CML_ROLE_PANE_SPLIT`
- `CML_CODEX_MODEL`
- `CML_CODEX_EFFORT`
- `CML_SANDBOX`
- `CML_APPROVAL`
- `CML_OPEN_CODEX_APP`
- `CML_AUTOSTART_ROLES`
- `CML_SHOW_FEED_SIDEBAR`
- `CML_WORKSPACE_MODE`
- `CML_SELECTED_TARGET`
- `CML_GITHUB_REPO`

Arrays use bash syntax:

```bash
CML_ROLE_NAMES=("lead" "build" "verify")
CML_EXTRA_DOCS=("docs/roadmap.md" "docs/runbook.md")
```

Set `CML_AUTOSTART_ROLES=false` when the launcher should open role tabs ready
but idle. Set it to `true` only when you intentionally want each Codex tab to
start work immediately from its role prompt.

`CML_WORKSPACE_MODE=sidebar` is the default. It opens one cmux workspace per
role so the left sidebar is the role switcher and unread agent messages can
mark the relevant workspace. Use `tabs` only for the older single-workspace,
multi-surface layout.

`CML_ROLE_PANE_SPLIT=0.5` is the default role/preview split. Lower it to `0.4`
when the preview should get roughly 60% of the workspace width.

`CML_SELECTED_TARGET` and `CML_GITHUB_REPO` are normally set by the chooser.
Profiles do not need to define them.

## Safety

Do not store secrets in a profile. Store secrets in the target project’s ignored
`.env.local`, a keychain, or a secret manager. The launcher can source
`.env.local` from `CML_DEV_COMMAND` if a dev server needs it.

## Profile Fit

Add or update a profile when a project has stable defaults:

- known project path
- stable dev command and preview URL
- project docs worth opening every launch
- roles with durable ownership boundaries
- repo-specific sandbox, approval, or model needs

Do not create a profile for a one-off checkout when the dynamic chooser cockpit
is enough.
