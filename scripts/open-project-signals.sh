#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LAUNCHER_WORKSPACE="${CMUX_WORKSPACE_ID:-}"

open -ga "CodexBar" >/dev/null 2>&1 || true
open -ga "RepoBar" >/dev/null 2>&1 || true

cmux new-workspace \
  --name "Project Signals" \
  --cwd "$ROOT" \
  --layout "$(cat <<'JSON'
{
  "direction": "horizontal",
  "split": 0.5,
  "children": [
    {
      "pane": {
        "surfaces": [
          {
            "type": "terminal",
            "name": "signals-guide",
            "command": "./scripts/project-signals-status.sh; exec \"${SHELL:-/bin/zsh}\" -l"
          }
        ]
      }
    },
    {
      "pane": {
        "surfaces": [
          {
            "type": "browser",
            "name": "releasebar",
            "url": "https://release.bar/picturesuo"
          },
          {
            "type": "browser",
            "name": "repobar",
            "url": "https://repobar.app/"
          }
        ]
      }
    }
  ]
}
JSON
)" \
  --focus true

if [ "${CLOSE_SIGNALS_LAUNCHER:-false}" = "true" ] && [ -n "$LAUNCHER_WORKSPACE" ]; then
  cmux close-workspace --workspace "$LAUNCHER_WORKSPACE" >/dev/null 2>&1 || true
fi
