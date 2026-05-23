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

No-argument launch uses:

1. `CMUX_CODEX_LAUNCHER_PROFILE`
2. `penny`

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
- `CML_CODEX_MODEL`
- `CML_CODEX_EFFORT`
- `CML_SANDBOX`
- `CML_APPROVAL`
- `CML_OPEN_CODEX_APP`
- `CML_AUTOSTART_ROLES`

Arrays use bash syntax:

```bash
CML_ROLE_NAMES=("lead" "build" "verify")
CML_EXTRA_DOCS=("docs/roadmap.md" "docs/runbook.md")
```

Set `CML_AUTOSTART_ROLES=false` when the launcher should open role tabs ready
but idle. Set it to `true` only when you intentionally want each Codex tab to
start work immediately from its role prompt.

## Safety

Do not store secrets in a profile. Store secrets in the target project’s ignored
`.env.local`, a keychain, or a secret manager. The launcher can source
`.env.local` from `CML_DEV_COMMAND` if a dev server needs it.
