---
summary: Current public research notes behind the cmux Codex launcher workflow.
read_when:
  - You are updating launcher roles, prompts, or one-click cockpit behavior.
  - You need sourced rationale for the agentic workflow choices.
---

# Agentic Workflow Research

These notes are sourced from public web pages and GitHub files inspected during
the launcher pass. Direct X screenshot browsing is brittle from the web index;
when screenshots were referenced through mirrored pages or articles, this file
treats them as supporting context rather than primary evidence.

## Success Criteria For This Launcher

- One click from cmux opens `--choose`.
- The first prompt asks what project/file/app/folder/GitHub repo to work on.
- The second prompt confirms the GitHub contribution repo.
- The resolved local checkout, selected target, and GitHub repo appear in every
  role tab and the shared context.
- Known projects reuse profiles; unknown projects get a conservative dynamic
  cockpit.
- Dynamic cockpits use `lead`, `build`, `verify`, and `ship`.
- Verification includes smoke tests and 10 consecutive dry-run workflow passes.

## Karpathy Pattern

Sources:

- https://github.com/karpathy/autoresearch
- https://github.com/karpathy/autoresearch/blob/master/program.md

Useful details:

- Treat Markdown as the executable program for an agent loop.
- Name editable and read-only files explicitly.
- Establish a baseline before changing behavior.
- Use one fixed metric or proof per loop.
- Keep changes only when they improve the measured result or simplify equal
  behavior.
- Record every attempt with status: keep, discard, or crash.

Launcher implication:

- `AGENTS.md` defines durable behavior.
- Dry runs and smoke tests are the launcher metric.
- The chooser should make target and GitHub state explicit before any agent
  starts coding.
- A complex change that does not improve dry-run clarity, launch correctness, or
  shipping safety should be removed.

## Peter Steinberger Pattern

Sources:

- https://steipete.me/posts/just-talk-to-it
- https://github.com/steipete/agent-scripts/blob/main/AGENTS.MD
- https://www.skills.sh/steipete/clawdis/tmux
- https://websearchapi.ai/blog/openclaw-state-of-the-claw-peter-steinberger

Useful details:

- Codex CLI can be the daily driver, with several sessions running in parallel.
- Keep agents in visible terminal panes when context and steering matter.
- Use atomic commits so each agent lands only its own files.
- Think in blast radius: split work when file overlap or reset risk gets high.
- Ask for options before changes when impact is unclear.
- Screenshots are high-bandwidth context for UI work.
- Use persistent CLI sessions for long-running servers, logs, tests, and agent
  work.
- Prefer CLIs such as `gh` when they avoid MCP context overhead.
- Peter's published tmux skill treats tmux as the control layer for monitoring
  Codex/Claude sessions, sending input, and scraping recent pane output.
- Ask for tests after feature/fix work when behavior is not purely visual.
- Keep human review in the loop; do not run a dark factory that merges without
  taste or review.

Launcher implication:

- The cockpit should optimize attended parallelism: visible role tabs, one dev
  server, preview surface, shared context, and commit/push hygiene.
- The launcher should avoid overbuilt orchestration. It should set up the right
  panes and let the user talk directly to Codex.
- cmux should preserve the useful tmux pattern: persistent visible sessions,
  direct CLI control, and readable pane output, but with project/GitHub routing
  handled by the one-click launcher.
- The `ship` role is first-class because clean commits and pushes are part of
  the workflow, not an afterthought.

## OpenAI Codex Pattern

Sources:

- https://developers.openai.com/codex/learn/best-practices
- https://developers.openai.com/community

Useful details:

- Good prompts include goal, context, constraints, and done-when criteria.
- `AGENTS.md` is durable repo guidance; keep it short and practical.
- Configure Codex for the real environment early: working directory, model,
  sandbox, approvals, tools, and connectors.
- Reliability comes from tests, checks, review, and visible validation.
- Skills and automations are useful only after a workflow is stable manually.
- Public community examples emphasize parallel tasks, long-running sessions, CI
  debugging, and messy-PR cleanup.

Launcher implication:

- Profiles carry stable environment setup.
- Dynamic launches infer only conservative defaults.
- Role prompts should include done-when checks instead of vague “make it work”
  wording.
- Repeated launcher work should become a small script or doc only after the
  manual flow is proven.

## Simon Willison Pattern

Sources:

- https://simonwillison.net/2025/Oct/5/parallel-coding-agents/
- https://simonwillison.net/2025/Oct/14/agentic-engineering/

Useful details:

- Parallel agents are most valuable when the review bottleneck stays under
  control.
- Good parallel work categories are research proof-of-concepts, system
  archaeology, small maintenance, and carefully specified directed work.
- Research agents can answer whether a library or approach works without
  landing their code.
- Explanations produced during codebase archaeology should be saved because
  they become useful context for later prompts.
- Several terminal sessions are reasonable when tasks are independent or
  low-risk; risky work needs stronger isolation.

Launcher implication:

- The launcher should not assume every tab is an implementation tab.
- The `lead` tab should be able to send research or archaeology work to other
  visible panes and then preserve useful notes in shared context or docs.
- The `verify` and `ship` roles exist because the bottleneck is reviewing and
  landing work, not generating more code.

## cmux Pattern

Sources:

- https://cmux.com/docs/skills
- https://cmux.com/pl/docs/agent-integrations/oh-my-codex
- https://cmux.com/docs/custom-commands

Useful details:

- cmux provides skills for core pane control, current-workspace automation,
  settings, customization, diagnostics, browser surfaces, and markdown panels.
- Project and global `cmux.json` can wire one-click actions and context menus.
- Markdown panels are useful for live plans and notes beside terminals.
- Agent integrations can translate tmux-style pane behavior into cmux splits.

Launcher implication:

- The global new-workspace action should point to `--choose`.
- The project-local action should also point to `--choose`.
- Browser previews, markdown plans, dev servers, and role tabs belong in one
  repeatable layout.
- cmux config changes must be backed up, validated, and reloaded.
