#!/usr/bin/env bash
set -u

section() {
  printf '\n== %s ==\n' "$1"
}

have() {
  command -v "$1" >/dev/null 2>&1
}

section "What this is"
cat <<'TEXT'
Project Signals is optional. It is not another place to do coding work.

Use it when you want to check the outside edge of a project:
- Am I about to run out of Codex usage?
- Is the repo healthy?
- Are there public sources worth turning into Markdown?
- Do GitHub issues/PRs need to become local evidence?

The normal coding cockpit remains the launcher: choose a project, confirm the
GitHub target, then work in the role workspace plus preview.
TEXT

section "What to use"
cat <<'TEXT'
Use now:
- CodexBar: glanceable Codex usage and reset windows.
- RepoBar: GitHub repo health after you choose repos to watch.
- summarize --extract <url-or-file>: turn public sources into Markdown context.

Use later:
- ReleaseBar: release freshness once a project has real releases.
- gitcrawl: local issue/PR cache after you explicitly choose repos to sync.

Do not automate by default:
- ClawSweeper-style issue/PR mutation. Keep it as a reference pattern only.
TEXT

section "Safety posture"
cat <<'TEXT'
Safe default: no tool here should mutate a repo or upload project files unless
you explicitly run a command that does that. Prefer summarize --extract for
public sources; use gitcrawl sync only for repos you are comfortable caching
locally.
TEXT

section "Codex defaults"
if [ -f "$HOME/.codex/config.toml" ]; then
  rg -n '^(model|model_reasoning_effort|plan_mode_reasoning_effort)' "$HOME/.codex/config.toml" 2>/dev/null || true
else
  printf 'Missing %s/.codex/config.toml\n' "$HOME"
fi

section "Menu bar apps"
if [ -d /Applications/CodexBar.app ]; then
  printf 'CodexBar: installed at /Applications/CodexBar.app\n'
else
  printf 'CodexBar: not installed. Install with: brew install --cask steipete/tap/codexbar\n'
fi

if [ -d /Applications/RepoBar.app ]; then
  printf 'RepoBar: installed at /Applications/RepoBar.app\n'
else
  printf 'RepoBar: not installed. Install with: brew install --cask repobar\n'
fi

section "CodexBar usage"
if have codexbar; then
  codex_tmp="$(mktemp -t codexbar-usage.XXXXXX)"
  codexbar usage --provider codex --status --no-color >"$codex_tmp" 2>/dev/null &
  codex_pid=$!
  for _ in 1 2 3 4 5; do
    kill -0 "$codex_pid" >/dev/null 2>&1 || break
    sleep 1
  done
  if kill -0 "$codex_pid" >/dev/null 2>&1; then
    kill "$codex_pid" >/dev/null 2>&1 || true
    wait "$codex_pid" 2>/dev/null || true
    printf 'CodexBar CLI is installed, but usage did not return quickly. Open CodexBar and configure the account.\n'
  else
    wait "$codex_pid" 2>/dev/null || true
    if [ -s "$codex_tmp" ]; then
      cat "$codex_tmp"
    else
      printf 'CodexBar CLI is installed, but usage needs the app/account to be configured.\n'
    fi
  fi
  rm -f "$codex_tmp"
else
  printf 'codexbar CLI is not on PATH.\n'
fi

section "summarize"
if have summarize; then
  summarize --version
  printf 'Try: summarize --extract https://repobar.app/\n'
else
  printf 'summarize is not on PATH. Install with: brew install summarize\n'
fi

section "gitcrawl"
if have gitcrawl; then
  gitcrawl --version
  gitcrawl doctor --json 2>/dev/null | sed -n \
    -e 's/.*"github_token_present": \([^,]*\).*/github_token_present: \1/p' \
    -e 's/.*"repository_count": \([^,]*\).*/repository_count: \1/p' \
    -e 's/.*"openai_key_present": \([^,]*\).*/openai_key_present: \1/p'
  printf 'Try: gitcrawl sync picturesuo/Penny\n'
else
  printf 'gitcrawl is not on PATH. Install from https://gitcrawl.sh/installation/\n'
fi

section "Web dashboards"
printf 'ReleaseBar: https://release.bar/picturesuo\n'
printf 'RepoBar: https://repobar.app/\n'
printf 'ClawSweeper Live reference: https://clawsweeper.openclaw.ai/\n'
