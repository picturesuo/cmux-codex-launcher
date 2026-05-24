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

Useful patterns:

- Keep global agent rules terse.
- Put routing, secrets, git, release, and CI behavior where agents will see it.
- Prefer exact local commands over generic advice.
- Use explicit publish policy; in this repo, publish mode is now `auto` unless
  the user asks for local-only work.
- Treat dirty worktrees and unknown changes as important state, not noise.

Launcher adaptation:

- `AGENTS.md` holds hard rules only.
- `tools.md` is the command catalog.
- Workflow detail lives in focused docs.
- Finished repo-visible file changes are committed and pushed one file at a time
  by default.
- Shared context captures current task state instead of bloating prompts.
