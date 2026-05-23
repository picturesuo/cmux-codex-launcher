---
summary: Design notes and external references for the cmux Codex launcher.
read_when:
  - You are changing launcher behavior, profiles, or cmux workspace layout.
---

# Launcher Design

## Goal

Open a coding workspace without asking which project to use. The launcher should
know the intended project from a profile, open cmux for coding, and open the
Codex app for knowledge work against the same path.

## Current Workflow Split

- Codex app: reading, learning, long-context discussion, Appshots, external app
  context, product thinking.
- cmux + Codex CLI: implementation work, parallel agents, logs, local preview,
  and verification.

## Incorporated Patterns

- cmux custom commands support project-local `.cmux/cmux.json`, actions, command
  palette entries, and workspace layouts with terminal/browser surfaces.
- cmux CLI supports `new-workspace --layout` for programmatic launchers.
- cmux surfaces map better to multiple coding agents than a permanent 3x3 grid:
  one visible workstream at a time, unread/notification routing for the rest.
- Codex CLI supports `codex app <path>` to open the Codex desktop app on macOS.
- Recent community launcher patterns favor no-prompt command-line launchers with
  `--dry-run`, explicit project paths, and repeatable defaults.

## Rules

- No GUI project-name prompt.
- No secrets in profiles.
- Profiles describe project paths, role names, doc paths, commands, and preview
  URLs only.
- A launch should be reproducible from the command line.
- A dry run should print enough data to debug without opening apps.

## Sources

- cmux custom commands: https://cmux.com/docs/custom-commands
- cmux workspace CLI docs: https://manaflow-ai-cmux.mintlify.app/cli/workspaces
- Codex CLI reference: https://developers.openai.com/codex/cli/reference

