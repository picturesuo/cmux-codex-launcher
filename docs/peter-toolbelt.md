---
summary: Peter Steinberger-inspired local toolbelt for cmux.
read_when:
  - You are changing the RepoBar, CodexBar, ReleaseBar, summarize, or gitcrawl integration.
  - You are deciding which external workflow tools belong in the cmux launcher.
---

# Peter Toolbelt

## Goal

Borrow the useful shape from Peter Steinberger's visible cmux/sidebar workflow:
keep project health, usage limits, source digestion, and maintainer evidence
visible without stuffing every coding role workspace with extra tabs.

## Local Tools

- RepoBar: menu bar app for repository health, CI, PRs, issues, releases, and
  local checkout state.
- CodexBar: menu bar app and CLI for Codex/provider usage and reset windows.
- summarize: CLI for turning URLs, files, PDFs, videos, and transcripts into
  clean Markdown summaries.
- gitcrawl: local-first GitHub issue and pull request cache for maintainer
  triage and local search.

## Web Surfaces

- ReleaseBar: release freshness and commits-since-release dashboard.
- ClawSweeper Live: reference pattern for conservative issue/PR triage
  automation.

## cmux Contract

The `Peter Toolbelt` cmux action should:

1. Start RepoBar and CodexBar if macOS can open them.
2. Open one left-side terminal surface that reports local tool status.
3. Open browser surfaces for ReleaseBar, RepoBar, and ClawSweeper on the right.
4. Leave Penny role workspaces clean: role Codex terminal plus preview only.

## Usage

```bash
scripts/open-peter-toolbelt.sh
scripts/peter-toolbelt-status.sh
```

Use `summarize` when a source should become Markdown context before handing it
to Codex:

```bash
summarize --extract https://repobar.app/
summarize --length medium https://steipete.me/posts/just-talk-to-it
```

Use `gitcrawl` when GitHub issues or PRs should become local searchable
evidence:

```bash
gitcrawl doctor
gitcrawl sync picturesuo/Penny
gitcrawl threads --repo picturesuo/Penny
```

Do not enable ClawSweeper-style mutation automatically. For this launcher, the
portable pattern is review first, produce Markdown, then let a human decide
whether anything should be applied.

## Install Notes

Preferred install commands:

```bash
brew install --cask repobar
brew tap steipete/tap
brew install --cask steipete/tap/codexbar
brew install summarize
brew tap openclaw/tap
brew install openclaw/tap/gitcrawl
```

If Homebrew cannot install `gitcrawl` because local Command Line Tools are too
old, use the release archive from `openclaw/gitcrawl` and put the binary on
`PATH`.
