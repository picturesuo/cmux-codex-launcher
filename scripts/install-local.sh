#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BIN_DIR="${HOME}/bin"
TARGET="${BIN_DIR}/cmux-codex-launcher"

mkdir -p "$BIN_DIR"
ln -sf "$ROOT/bin/cmux-codex-launcher" "$TARGET"

printf 'Installed: %s -> %s\n' "$TARGET" "$ROOT/bin/cmux-codex-launcher"

if ! printf '%s' ":$PATH:" | grep -q ":$BIN_DIR:"; then
  printf 'Note: %s is not currently on PATH.\n' "$BIN_DIR"
fi

