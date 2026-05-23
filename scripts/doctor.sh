#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

check() {
  local label=$1
  shift
  if "$@" >/dev/null 2>&1; then
    printf 'ok: %s\n' "$label"
  else
    printf 'missing: %s\n' "$label"
  fi
}

check "cmux" command -v cmux
check "codex" command -v codex
check "git" command -v git
check "gh" command -v gh

bash -n "$ROOT/bin/cmux-codex-launcher"
printf 'ok: launcher syntax\n'

if command -v cmux >/dev/null 2>&1; then
  cmux config validate >/dev/null
  printf 'ok: cmux config validates\n'
fi

"$ROOT/bin/cmux-codex-launcher" --profile penny --dry-run >/dev/null
printf 'ok: Penny profile resolves\n'

