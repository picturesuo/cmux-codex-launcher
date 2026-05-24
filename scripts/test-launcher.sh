#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

bash -n "$ROOT/bin/cmux-codex-launcher"
bash -n "$ROOT/scripts/cmux-launcher-entry.sh"
bash -n "$ROOT/scripts/install-local.sh"
bash -n "$ROOT/scripts/doctor.sh"
bash -n "$ROOT/scripts/open-peter-toolbelt.sh"
bash -n "$ROOT/scripts/peter-toolbelt-status.sh"

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

case "$dry_run" in
  *"workspace_mode: sidebar"* ) ;;
  * ) printf 'dry run did not use sidebar workspace mode\n' >&2; exit 1 ;;
esac

case "$dry_run" in
  *"effort: medium"* ) ;;
  * ) printf 'dry run did not default interactive Codex effort to medium\n' >&2; exit 1 ;;
esac

case "$dry_run" in
  *"plan_effort: high"* ) ;;
  * ) printf 'dry run did not default Plan mode effort to high\n' >&2; exit 1 ;;
esac

case "$dry_run" in
  *'"name":"Penny: lead"'* ) ;;
  * ) printf 'dry run did not create a left-sidebar lead workspace\n' >&2; exit 1 ;;
esac

case "$dry_run" in
  *'"split":0.5'*'"name":"preview"'* ) ;;
  * ) printf 'dry run did not put preview beside role workspace\n' >&2; exit 1 ;;
esac

case "$dry_run" in
  *'"name":"plan"'*|*"cmux markdown open"* )
    printf 'sidebar role layout should not add plan/doc helper tabs\n' >&2
    exit 1
    ;;
esac

case "$dry_run" in
  *'model_reasoning_effort="xhigh"'*|*"gpt-5.5 xhigh"* )
    printf 'launcher should not make xhigh the default reasoning profile\n' >&2
    exit 1
    ;;
esac

cmux_config="$(cat "$ROOT/.cmux/cmux.json")"

case "$cmux_config" in
  *'"choose-codex-cockpit"'*'"type": "command"'*'"command":'*'./scripts/cmux-launcher-entry.sh --choose'*'"target": "newTabInCurrentPane"'* ) ;;
  * ) printf 'cmux plus action is not wired to the temporary picker workspace\n' >&2; exit 1 ;;
esac

case "$cmux_config" in
  *'"open-peter-toolbelt"'*'"command":'*'CLOSE_TOOLBELT_LAUNCHER=true ./scripts/open-peter-toolbelt.sh'* ) ;;
  * ) printf 'cmux config is not wired to the Peter Toolbelt action\n' >&2; exit 1 ;;
esac

case "$cmux_config" in
  *'; status=$?'*|*' status=$?'* )
    printf 'cmux launcher action should not use zsh reserved status variable\n' >&2
    exit 1
    ;;
esac

picker_dry_run="$("$ROOT/bin/cmux-codex-launcher" --choose --query penny --dry-run)"

case "$picker_dry_run" in
  *"profile: penny"* ) ;;
  * ) printf 'picker did not reuse Penny profile\n' >&2; exit 1 ;;
esac

case "$picker_dry_run" in
  *"github_repo: picturesuo/Penny"* ) ;;
  * ) printf 'picker did not infer Penny GitHub repo\n' >&2; exit 1 ;;
esac

dynamic_dry_run="$("$ROOT/bin/cmux-codex-launcher" --choose --query "$ROOT" --dry-run)"

case "$dynamic_dry_run" in
  *"profile: dynamic"* ) ;;
  * ) printf 'direct-path picker did not create dynamic profile\n' >&2; exit 1 ;;
esac

case "$dynamic_dry_run" in
  *"ship"* ) ;;
  * ) printf 'dynamic picker did not include shipping role\n' >&2; exit 1 ;;
esac

file_dry_run="$(CMUX_CODEX_SEARCH_ROOTS="$ROOT" "$ROOT/bin/cmux-codex-launcher" --choose --query launcher-design --dry-run)"

case "$file_dry_run" in
  *"selected_target: $ROOT/docs/launcher-design.md"* ) ;;
  * ) printf 'file picker did not resolve launcher-design doc\n' >&2; exit 1 ;;
esac

printf 'ok: launcher smoke tests passed\n'
