#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LAUNCHER_WORKSPACE="${CMUX_WORKSPACE_ID:-}"

open -ga "CodexBar" >/dev/null 2>&1 || true
open -ga "RepoBar" >/dev/null 2>&1 || true

cmux new-workspace \
  --name "Peter Toolbelt" \
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
            "name": "toolbelt-status",
            "command": "./scripts/peter-toolbelt-status.sh; exec \"${SHELL:-/bin/zsh}\" -l"
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
          },
          {
            "type": "browser",
            "name": "clawsweeper",
            "url": "https://clawsweeper.openclaw.ai/"
          }
        ]
      }
    }
  ]
}
JSON
)" \
  --focus true

if [ "${CLOSE_TOOLBELT_LAUNCHER:-false}" = "true" ] && [ -n "$LAUNCHER_WORKSPACE" ]; then
  cmux close-workspace --workspace "$LAUNCHER_WORKSPACE" >/dev/null 2>&1 || true
fi
