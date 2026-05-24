---
summary: Project signal tools for quota, repo health, source digestion, and GitHub evidence.
read_when:
  - You are changing the RepoBar, CodexBar, ReleaseBar, summarize, gitcrawl, or project-signal integration.
  - You are deciding which external workflow tools belong in the cmux launcher.
---

# Project Signals

## Goal

Keep the outside edge of a project visible without stuffing every coding role
workspace with extra tabs.

Peter Steinberger's setup is the inspiration, not the product name. The useful
pattern is a small signal cockpit: quota, repo health, source digestion, and
GitHub evidence.

This workspace is optional. It answers "what is happening around the project?"
The normal coding cockpit still answers "what are we building right now?"

## Quick Start

Open it from cmux with **Open Project Signals**, or run:

```bash
scripts/open-project-signals.sh
```

The left pane explains what is installed and what to use. The right pane opens
RepoBar and ReleaseBar reference surfaces. It intentionally does not open a
ClawSweeper tab by default because that is a high-noise automation reference,
not part of the daily Penny flow.

## Daily Use

Most days, you do not need to open this workspace. Open it when you are about
to start a longer run, when something feels stuck outside the code, or when you
need to turn external material into clean context.

The practical loop is:

1. Check CodexBar before starting a long agent run.
2. Check RepoBar if repo/CI/PR state matters.
3. Use `summarize --extract` for public research sources.
4. Use `gitcrawl` only when GitHub issues or PRs should become local evidence.
5. Return to the normal role workspace to actually build.

## Local Tools

- CodexBar: glance at Codex usage and reset windows before starting a long run.
- RepoBar: watch GitHub repo health after you select which repos matter.
- summarize: turn a public URL or local file into Markdown before giving it to
  Codex.
- gitcrawl: cache GitHub issues and PRs locally after you explicitly choose a
  repo to sync.

## Web Surfaces

- ReleaseBar: release freshness and commits-since-release dashboard.
- ClawSweeper Live: reference pattern for conservative issue/PR triage
  automation.

## cmux Contract

The `Project Signals` cmux action should:

1. Start RepoBar and CodexBar if macOS can open them.
2. Open one left-side terminal surface that explains local tool status and use.
3. Open browser surfaces for ReleaseBar and RepoBar on the right.
4. Leave Penny role workspaces clean: role Codex terminal plus preview only.

## Usage

```bash
scripts/open-project-signals.sh
scripts/project-signals-status.sh
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
