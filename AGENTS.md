# AGENTS.md

## Purpose
This repo builds a small macOS launcher for a cmux + Codex workflow.

The launcher should open a project-specific cmux cockpit and, optionally, the
Codex desktop app for the same project path. It replaces old AppleScript
project prompts with explicit profiles and predictable command-line behavior.

## Working Rules
- Keep shell scripts portable to macOS `bash` 3.2 where practical.
- Do not store secrets in profiles, `.cmux/cmux.json`, docs, or scripts.
- Prefer project profiles for paths, commands, ports, and role prompts.
- Prefer cmux workspace layouts over Ghostty/AppleScript automation.
- Keep no-argument launch behavior deterministic. Do not add GUI prompts.
- Default public docs should be safe to publish.
- For target projects, read their own `AGENTS.md` before editing.

## Verification
- Run `bash -n bin/cmux-codex-launcher scripts/*.sh` after shell edits.
- Run `bash scripts/test-launcher.sh` after launcher behavior changes.
- Run `cmux config validate` when changing `.cmux/cmux.json`.
- Use `bin/cmux-codex-launcher --profile penny --dry-run` before a real launch.

## Git
- Commit focused changes on `main`.
- Push when the user asks for GitHub publication or the task explicitly includes repo creation.

