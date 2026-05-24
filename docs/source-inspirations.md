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

Useful patterns:

- Markdown is the human-authored program for agents.
- Keep the harness small enough that agents can understand it.
- Name editable and read-only surfaces explicitly.
- Use a fixed evaluation loop when possible.
- Keep or discard changes based on measured output.
- Prefer simplicity when two outcomes are equivalent.

Agent behavior rules adapted here:

- Think before coding: state assumptions, surface confusion, name competing
  interpretations, and ask before implementing unclear work.
- Simplicity first: minimum code, no speculative features, no single-use
  abstractions, and no unrequested configurability.
- Surgical changes: touch only requested surfaces, match local style, and remove
  only dead code created by the current change.
- Goal-driven execution: turn tasks into testable criteria, run the check, then
  loop until the result proves completion.

Launcher adaptation:

- `AGENTS.md` and `docs/*.md` define the agent program.
- `bin/cmux-codex-launcher` is the runtime harness.
- Dry runs and smoke tests are the fixed evaluation loop.
- Dynamic roles get scoped surfaces and verification duties.

## Steinberger Agent Scripts

Source:

- https://github.com/steipete/agent-scripts/blob/main/AGENTS.MD
- https://steipete.me/posts/just-talk-to-it
- https://www.skills.sh/steipete/clawdis/tmux

Useful patterns:

- Keep global agent rules terse.
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
- Finished repo-visible file changes are committed and pushed one file at a time
  by default.
- Shared context captures current task state instead of bloating prompts.

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
