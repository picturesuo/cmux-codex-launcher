---
summary: Current one-click cmux cockpit loadout and success criteria.
read_when:
  - You are changing the cmux plus-button action.
  - You are changing role workspace layout, preview split, or chooser prompts.
  - You need the recent public cmux workflow research.
---

# cmux Cockpit Loadout

## Goal

Pressing the cmux new-workspace button should start a short chooser, not a
blank terminal. The chooser asks what project, file, app, folder, or GitHub repo
the user wants to work on, confirms the GitHub contribution target, then opens a
clean coding cockpit.

## Success Criteria

1. The first prompt asks what project, file, app, folder, or GitHub repo to work
   on.
2. The second prompt asks whether the inferred GitHub repo is the right
   contribution target. If not, it asks for the correct repo.
3. The selected local checkout and GitHub repo are written into shared context.
4. Each role opens as a left-sidebar cmux workspace.
5. Each role workspace contains only the role Codex surface and, when configured,
   the preview browser surface.
6. Plan docs, markdown helpers, dev servers, logs, and shipping helpers do not
   hide inside every role workspace.
7. Preview sits beside the active role at `CML_ROLE_PANE_SPLIT=0.5` by default.
   Use `0.4` when the preview should take about 60% of the width.
8. Role tabs stay idle unless `--autostart-roles` is explicit.
9. The temporary chooser workspace closes after successfully creating the real
   role workspaces.
10. Verification passes with `bash scripts/test-launcher.sh`, `cmux config
    validate`, and a relevant dry run.

## Loadout Shape

For a profiled project such as Penny:

- left sidebar: one workspace per role, such as `Penny: lead` and
  `Penny: create-ui`
- role workspace: Codex CLI on the left, preview browser on the right
- dev server: separate workspace
- shared context: `~/.codex/cmux-codex-launcher/<project>-shared-context.md`
- Codex desktop app: opened on the same checkout for reading, learning, and
  broader product thinking

For a dynamic project:

- roles: `lead`, `build`, `verify`, `ship`
- preview/dev server: inferred only when the project clearly exposes a standard
  dev command and likely local URL

## Recent Public Workflow Notes

- Peter Steinberger posted on May 23, 2026 that his current split is Codex Mac
  app for knowledge work, learning, and reading, and cmux plus Codex CLI for
  coding. Source snapshot: https://digg.com/ai/j5do9ink
- The cmux homepage now quotes the same split and frames cmux as a terminal for
  coding agents and multitasking. Source: https://cmux.com/
- The cmux README says cmux is used to run many Claude Code and Codex sessions
  in parallel, with sidebar status, notification rings, and browser panes beside
  terminals. Source: https://github.com/manaflow-ai/cmux
- The May 22, 2026 cmux Vault post adds searchable old agent sessions and drag
  to reopen for Codex, Claude Code, OpenCode, and Pi. Source:
  https://cmux.com/blog/cmux-vault
- Community examples on the cmux homepage emphasize one WIP task per vertical
  tab, agents on one side, and browser or PR/resources on the other. This
  launcher adapts that into one role workspace plus preview, instead of piling
  many hidden surfaces into one workspace.

## Do Not Drift

- Do not add live connector claims to launcher prompts.
- Do not create GUI prompts outside the terminal chooser.
- Do not auto-start role agents unless the user asks.
- Do not put plan docs or markdown viewers inside every role workspace.
- Do not hide reusable knowledge in shared context; put durable facts in docs.
