---
summary: Codex-app-first workflow, seeded project files, and reset loop.
read_when:
  - You want Codex Desktop to be the primary work surface instead of cmux.
  - You are changing --codex, --seed-codex-files, or --reset-task behavior.
  - You need the Ghostty-launcher patterns adapted into the Codex app.
---

# Codex App Workflow

## Goal

Make the Codex desktop app usable as the main terminal-like work surface while
keeping the good parts of the Ghostty and cmux launchers:

- fuzzy project/file/repo resolution
- explicit GitHub contribution target
- repo-local Markdown that programs the agent loop
- shared mutable task context
- durable knowledge and queue files
- a clear verify, commit, and push path

The Codex app is the cockpit. cmux remains available when visible terminal panes,
previews, logs, or many simultaneous role workspaces are useful.

## One Command

Use:

```bash
bin/cmux-codex-launcher --codex
```

`--codex` means:

- choose the target project, file, folder, app, or GitHub repo
- confirm the GitHub contribution target
- seed missing Codex workflow files into the target repo
- open the Codex desktop app on the resolved checkout
- skip cmux workspace creation

Use a deterministic path when you already know the target:

```bash
bin/cmux-codex-launcher --codex --profile penny
bin/cmux-codex-launcher --codex --project /path/to/repo --name Repo
bin/cmux-codex-launcher --codex --query penny
```

## Seeded Files

`--codex` implies `--seed-codex-files`. The launcher creates only missing files:

- `AGENTS.md`
- `docs/agent-workflow.md`
- `docs/workflow-packaging-audit.md`
- `docs/queue.md`
- `docs/knowledge.md`
- `.codex/config.toml`

Existing files are never overwritten. The seeded files are intentionally small:
`AGENTS.md` routes the session, `docs/agent-workflow.md` defines the loop,
`docs/workflow-packaging-audit.md` decides when repeated work should become a
skill, subagent, automation, extension, or skip, `docs/queue.md` holds the next
small task, `docs/knowledge.md` holds durable facts, and `.codex/config.toml`
sets repo-scoped model and reasoning defaults.

The seeded `AGENTS.md` adapts the Karpathy-style `CLAUDE.md` rules into Codex:
think before coding, simplicity first, surgical changes, and goal-driven
execution. It also carries the Steinberger-style publish boundary: inspect dirty
state, verify, commit, and push finished repo-visible work unless the user asks
for local-only work.

Skip seeding when a repo already has its own workflow:

```bash
bin/cmux-codex-launcher --codex --no-seed-codex-files --profile penny
```

## Reset Loop

Use `--reset-task` when you want a clean mutable task block in the launcher
shared context:

```bash
bin/cmux-codex-launcher --codex --reset-task
```

This does not delete durable knowledge, repo docs, or the launcher selection. It
only refreshes the `Codex Task` block so the next app thread starts from a blank
current task.

## Operating Model

1. Open Codex with `--codex`.
2. Tell Codex the task in normal language.
3. Let Codex read `AGENTS.md`, `docs/agent-workflow.md`,
   `docs/workflow-packaging-audit.md`, `docs/queue.md`, `docs/knowledge.md`,
   and the shared context path printed by the launcher.
4. For parallel work, start another Codex app thread against the same checkout
   and assign a disjoint file, slice, or proof.
5. Before compaction or handoff, update the shared context with status, changed
   files, verification, and next action.

## Adapted Patterns

- Karpathy: Markdown is the program; one loop should name editable surfaces,
  read-only surfaces, proof, keep/discard criteria, and compact coding rules
  inspired by `CLAUDE.md`.
- Steinberger: use plain language, visible boundaries, repo-local rules, exact
  CLIs such as `gh`, and small verified publish units.
- OpenAI Codex docs: keep personal defaults in `~/.codex/config.toml`, keep
  repo-specific behavior in `.codex/config.toml`, use sessions and subagents
  for bounded work, and turn repeated work into skills or automations only when
  the workflow is specific, repeatable, and easy to review.
- OpenAI Codex app examples: use practical skills for Figma, project
  management, deployment, image generation, OpenAI API work, documents,
  spreadsheets, and PDFs; use automations for issue triage, CI summaries,
  release briefs, bug checks, and recurring summaries.
- Memories and Chronicle: use them to discover repeated preferences and
  workflows, but confirm important details in the source system before creating
  durable instructions or automation.
- Simon Willison: parallel agents work best for research, archaeology, small
  maintenance, and carefully specified work where review stays cheap.

## Sources

- Karpathy `program.md`: https://github.com/karpathy/autoresearch/blob/master/program.md
- OpenAI Codex best practices: https://developers.openai.com/codex/learn/best-practices#configure-codex-for-consistency
- OpenAI Codex skills best practices: https://developers.openai.com/codex/learn/best-practices#turn-repeatable-work-into-skills
- OpenAI Codex automation best practices: https://developers.openai.com/codex/learn/best-practices#use-automations-for-repeated-work
- OpenAI Codex Memories: https://developers.openai.com/codex/memories
- OpenAI Codex Chronicle: https://developers.openai.com/codex/memories/chronicle
- OpenAI Codex app announcement: https://openai.com/index/introducing-the-codex-app/
- OpenAI Codex config sample: https://developers.openai.com/codex/config-sample
- Simon Willison on parallel coding agents: https://simonwillison.net/2025/Oct/5/parallel-coding-agents/
- Simon Willison on Steinberger's Codex workflow: https://simonwillison.net/2025/Oct/14/agentic-engineering/
