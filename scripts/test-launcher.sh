#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

bash -n "$ROOT/bin/cmux-codex-launcher"
bash -n "$ROOT/scripts/install-local.sh"
bash -n "$ROOT/scripts/doctor.sh"

layout="$("$ROOT/bin/cmux-codex-launcher" --profile penny --print-layout)"

if command -v python3 >/dev/null 2>&1; then
  printf '%s\n' "$layout" | python3 -m json.tool >/dev/null
fi

dry_run="$("$ROOT/bin/cmux-codex-launcher" --profile penny --dry-run)"

case "$dry_run" in
  *"project: Penny"* ) ;;
  * ) printf 'dry run did not resolve Penny profile\n' >&2; exit 1 ;;
esac

case "$dry_run" in
  *"lead"* ) ;;
  * ) printf 'dry run did not include roles\n' >&2; exit 1 ;;
esac

printf 'ok: launcher smoke tests passed\n'

