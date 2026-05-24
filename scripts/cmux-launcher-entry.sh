#!/usr/bin/env bash
set -u

ROOT="$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)"

chooser_workspace_ref() {
  if [ -n "${CMUX_WORKSPACE_ID:-}" ]; then
    printf '%s\n' "$CMUX_WORKSPACE_ID"
    return
  fi

  cmux identify --json 2>/dev/null \
    | sed -n 's/.*"workspace_ref" : "\([^"]*\)".*/\1/p' \
    | head -n 1
}

chooser_workspace="$(chooser_workspace_ref)"

cd "$ROOT" || exit 1
./bin/cmux-codex-launcher "$@"
launch_status=$?

if [ "$launch_status" -eq 0 ]; then
  if [ -n "$chooser_workspace" ]; then
    cmux close-workspace --workspace "$chooser_workspace" || {
      printf '\nLauncher succeeded, but closing the chooser workspace failed.\n' >&2
      exit 0
    }
    exit 0
  fi

  printf '\nLauncher succeeded, but I could not identify the chooser workspace to close.\n' >&2
  exit 0
fi

printf '\nLauncher failed (exit %s). Fix it here, then rerun ./scripts/cmux-launcher-entry.sh %s.\n' "$launch_status" "$*" >&2
exec "${SHELL:-/bin/zsh}" -l
