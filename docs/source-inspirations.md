---
summary: External agent-instruction patterns adapted for this repo.
read_when:
  - You are updating AGENTS.md or workflow docs.
  - You need to understand why the docs are split this way.
---

# Source Inspirations

This repo adapts patterns from current public GitHub projects without copying
their instruction files.

## Karpathy Autoresearch

Source:

- https://github.com/karpathy/autoresearch
- https://github.com/karpathy/autoresearch/blob/master/program.md
- Karpathy-inspired `CLAUDE.md` guidelines: https://github.com/forrestchang/andrej-karpathy-skills/blob/main/CLAUDE.md

Useful patterns:

- Markdown is the human-authored program for agents.
- Keep the harness small enough that agents can understand it.
- Name editable and read-only surfaces explicitly.
- Use a fixed evaluation loop when possible.
- Keep or discard changes based on measured output.
- Prefer simplicity when two outcomes are equivalent.
- Use four concise behavioral rules in agent instructions: think before coding,
  simplicity first, surgical changes, and goal-driven execution.
- Treat broad or ambiguous tasks as work to convert into testable criteria
  before editing.

Agent behavior rules adapted here:

- Think before coding: state assumptions, surface confusion, name competing
  interpretations, and ask before implementing unclear work.
- Simplicity first: minimum code, no speculative features, no single-use
  abstractions, and no unrequested configurability.
- Surgical changes: touch only requested surfaces, match local style, and remove
  only dead code created by the current change.
- Goal-driven execution: turn tasks into testable criteria, run the check, then
  loop until the result proves completion.
- Auto publish stays gated by proof: inspect dirty state, verify, commit, then
  push finished repo-visible work.

Launcher adaptation:

- `AGENTS.md` and `docs/*.md` define the agent program.
- `bin/cmux-codex-launcher` is the runtime harness.
- `--codex` seeds a small repo-local Markdown program for the Codex app when a
  target repo is missing one.
- Dry runs and smoke tests are the fixed evaluation loop.
- Dynamic roles get scoped surfaces and verification duties.

## Steinberger Agent Scripts

Source:

- https://github.com/steipete/agent-scripts/blob/main/AGENTS.MD
- https://steipete.me/posts/just-talk-to-it
- https://zenn.dev/seyz/articles/20260308-steipete-codex-how-to
- https://www.skills.sh/steipete/clawdis/tmux

Useful patterns:

- Keep global agent rules terse.
- Use `medium` for everyday Codex coding and reserve `high` for complex design
  or architecture passes; avoid making `xhigh` the default.
- Put routing, secrets, git, release, and CI behavior where agents will see it.
- Prefer exact local commands over generic advice.
- Use explicit publish policy; in this repo, publish mode is now `auto` unless
  the user asks for local-only work.
- Treat dirty worktrees and unknown changes as important state, not noise.
- Keep parallel agent sessions visible in terminal panes when steering matters.
- Prefer lightweight CLIs such as `gh` over context-heavy tool plumbing when the
  CLI can answer the same question.
- Use a terminal multiplexer as the control surface for long-running interactive
  agent sessions.
- Use screenshots as fast UI context, then verify with tests or runtime checks.

Launcher adaptation:

- `AGENTS.md` holds hard rules only.
- `tools.md` is the command catalog.
- Workflow detail lives in focused docs.
- Codex-app-first launches preserve the same publish and shared-context
  workflow without requiring a Ghostty or cmux pane grid.
- Finished repo-visible file changes are committed and pushed one file at a time
  by default.
- Shared context captures current task state instead of bloating prompts.
- Launcher profiles set Codex terminal reasoning to `medium` and Plan mode to
  `high`.
- RepoBar and CodexBar belong in the menu bar; ReleaseBar and RepoBar belong in
  a separate Project Signals workspace; summarize and gitcrawl feed
  Markdown/evidence into the real work. ClawSweeper remains a reference pattern,
  not a default surface.

## Simon Willison Parallel Agents

Source:

- https://simonwillison.net/2025/Oct/5/parallel-coding-agents/

Useful patterns:

- Use agents for research proof-of-concepts before committing to an approach.
- Send agents through existing codepaths to produce reusable archaeology notes.
- Keep small maintenance tasks separate from high-risk feature work.
- Specify actual implementation work clearly enough that review stays cheap.

Launcher adaptation:

- Keep the generic cockpit role set small: `lead`, `build`, `verify`, `ship`.
- Treat research and archaeology as first-class work the visible role tabs can
  do, not as background automation hidden from the user.
- Preserve useful findings in shared context or docs so future prompts start
  with better local knowledge.

## OpenAI Codex App Workflows

Sources:

- https://developers.openai.com/codex/learn/best-practices
- https://developers.openai.com/codex/memories
- https://developers.openai.com/codex/memories/chronicle
- https://openai.com/index/introducing-the-codex-app/
- https://openai.com/academy/codex-automations/
- https://openai.com/academy/top-10-use-cases-codex-for-work/

Useful patterns:

- Keep personal Codex defaults in `~/.codex/config.toml` and repo-specific
  behavior in `.codex/config.toml` or repo docs.
- Turn repeated work into skills only when the scope is narrow, the inputs and
  outputs are clear, and the workflow is worth reusing.
- Use automations for specific, repeatable, easy-to-review recurring work.
- Treat sessions as working threads; fork for alternatives, compact for handoff,
  and use subagents for bounded exploration, tests, triage, or archaeology.
- Use Memories for stable preferences and recurring patterns, not hard
  requirements that should live in repo instructions.
- Use Chronicle for discovery and orientation only, then confirm important
  details in the source system.
- OpenAI's public Codex app examples emphasize practical skills for Figma,
  project management, deployment, image generation, OpenAI API work, documents,
  spreadsheets, and PDFs.
- OpenAI describes internal skills for evals, training-run monitoring, docs,
  and growth-reporting workflows, plus automations for issue triage, CI
  summaries, release briefs, and bug checks.

Launcher adaptation:

- `--codex` seeds `docs/workflow-packaging-audit.md` so target projects can
  audit recent sessions, Memories, Chronicle leads, and existing assets before
  creating a skill, subagent, automation, or extension.
- The audit shortlist must include skips and existing coverage, which keeps the
  launcher from creating speculative or overlapping assets.
- Existing docs and scripts remain the first packaging choice for repo-local
  work; skills and automations are reserved for repeated cross-surface or
  scheduled workflows.

## Recent Agent Session Managers

Sources:

- https://mato.sh/
- https://getconduit.sh/docs/
- https://github.com/codex-yolo/codex-yolo
- https://pkg.go.dev/github.com/izll/agent-session-manager
- https://www.warp.dev/agents

Useful patterns:

- Use a visible navigation surface for agent sessions instead of relying on
  hidden terminal tabs.
- Give each agent a separate terminal/session boundary.
- Keep instant switching keyboard-friendly.
- Show activity, idle, blocked, or unread state beside the session entry.
- Keep the raw agent TUI intact rather than wrapping it in a custom chat UI.

Launcher adaptation:

- Default cmux launches now create one left-sidebar workspace per role.
- Each role workspace contains one Codex surface on the left and, when a
  preview URL is configured, one browser preview on the right.
- cmux Feed and notification hooks provide the attention signal instead of
  requiring the user to scan every agent surface.
