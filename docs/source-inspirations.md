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
- Push only on request unless repo policy says otherwise.
- Treat dirty worktrees and unknown changes as important state, not noise.

Launcher adaptation:

- `AGENTS.md` holds hard rules only.
- `tools.md` is the command catalog.
- Workflow detail lives in focused docs.
- GitHub publication stays opt-in for this launcher repo.
- Shared context captures current task state instead of bloating prompts.

