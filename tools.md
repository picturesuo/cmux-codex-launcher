# tools.md

Use this file as the practical command reference for repo-local tools. Prefer
commands that exist here over copied commands from older launcher repos.

## Launcher

### `bin/cmux-codex-launcher`

- Purpose: open a profiled cmux workspace and optional Codex desktop app.
- Location: `bin/cmux-codex-launcher`

Safe examples:

```bash
bin/cmux-codex-launcher --choose
bin/cmux-codex-launcher --choose --query penny --dry-run
bin/cmux-codex-launcher --choose --query "docs/launcher-design" --dry-run
bin/cmux-codex-launcher --profile penny --dry-run
bin/cmux-codex-launcher --profile penny
bin/cmux-codex-launcher --resume-last
bin/cmux-codex-launcher --status-last
bin/cmux-codex-launcher --project /path/to/repo --name "Project"
bin/cmux-codex-launcher --print-layout --profile penny
bin/cmux-codex-launcher --autostart-roles --profile penny
```

Environment overrides:

```bash
CMUX_CODEX_SEARCH_ROOTS="$HOME/Desktop:$HOME/Projects" bin/cmux-codex-launcher --choose
CMUX_CODEX_PROJECTS_DIR="$HOME/Projects" bin/cmux-codex-launcher --choose
```

### `profiles/*.env`

- Purpose: define project path, docs, roles, model, dev server, and preview URL.
- Location: `profiles/penny.env` for the default public Penny profile.
- Notes: do not put secrets in profile files.

## Verification

### `scripts/test-launcher.sh`

- Purpose: run shell syntax checks, validate layout JSON, and ensure Penny,
  dynamic, and file-picker resolution.
- Location: `scripts/test-launcher.sh`

```bash
bash scripts/test-launcher.sh
```

Ten-pass launcher verification:

```bash
for i in 1 2 3 4 5 6 7 8 9 10; do
  printf 'pass %s\n' "$i"
  bash scripts/test-launcher.sh >/dev/null
  bin/cmux-codex-launcher --choose --query penny --dry-run >/dev/null
  bin/cmux-codex-launcher --choose --query pnny --dry-run >/dev/null
  CMUX_CODEX_SEARCH_ROOTS="$PWD" bin/cmux-codex-launcher --choose --query 'lauch design' --dry-run >/dev/null
done
```

### `scripts/doctor.sh`

- Purpose: check `cmux`, `codex`, `git`, `gh`, shell syntax, cmux config validity, and Penny profile resolution.
- Location: `scripts/doctor.sh`

```bash
bash scripts/doctor.sh
```

### `cmux config validate`

- Purpose: validate global and project-local cmux JSON.
- Location: system `cmux` CLI.

```bash
cmux config validate
```

## Installation

### `scripts/install-local.sh`

- Purpose: create `~/bin/cmux-codex-launcher` as a symlink to this checkout.
- Location: `scripts/install-local.sh`

```bash
bash scripts/install-local.sh
```

### User Launch Wrappers

These files are outside the repo but should point at this project:

```text
/Users/bensuo/codex-launchpad.sh
/Users/bensuo/OPEN_CMUX_CODEX.command
/Users/bensuo/OPEN_GHOSTTY_CODEX.command
```

They should delegate to:

```text
/Users/bensuo/Desktop/cmux-codex-launcher/bin/cmux-codex-launcher
```

## cmux

### `cmux new-workspace`

- Purpose: create a workspace with scripted terminal/browser surfaces.
- Location: system `cmux` CLI.

```bash
cmux new-workspace --help
cmux new-workspace --cwd . --name "Codex coding" --command "codex"
cmux new-workspace --cwd . --name "Dev" --layout '{"pane":{"surfaces":[{"type":"terminal","command":"pwd"}]}}'
```

### `.cmux/cmux.json`

- Purpose: project-local cmux plus-button and command-palette actions.
- Behavior: the plus button runs `Choose Codex Cockpit`, a temporary picker
  workspace that asks for the project and GitHub target, launches role
  workspaces, then closes itself.

```bash
cmux config validate
cmux reload-config
```

### `cmux markdown open`

- Purpose: open a markdown file as a formatted live panel.

```bash
cmux markdown open docs/penny-create-operating-outline.md --focus false
```

### Codex reasoning defaults

```bash
rg -n "CML_CODEX_(PLAN_)?EFFORT|plan_effort|model_reasoning_effort" profiles bin docs README.md
bin/cmux-codex-launcher --profile penny --dry-run
```

Expected posture: interactive Codex terminal effort is `medium`, Plan mode is
`high`, and `xhigh` is opt-in only.

## GitHub

### `gh`

- Purpose: create and publish the GitHub repo when requested.
- Location: system `gh` CLI.

```bash
gh repo view picturesuo/cmux-codex-launcher
gh repo create picturesuo/cmux-codex-launcher --public --source . --remote origin --push
```
