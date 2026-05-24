---
summary: Codex terminal defaults for the launcher.
read_when:
  - You are changing Codex model, reasoning, Plan mode, or terminal launch defaults.
  - You are deciding whether a profile should use medium, high, or xhigh.
---

# Codex Terminal Profile

## Default

Launcher-created Codex CLI sessions should start with:

- `model`: `gpt-5.5`
- `model_reasoning_effort`: `medium`
- `plan_mode_reasoning_effort`: `high`

The user-level Codex config should match this posture:

```toml
model = "gpt-5.5"
model_reasoning_effort = "medium"
plan_mode_reasoning_effort = "high"
```

## Why

Recent public Steinberger summaries describe everyday Codex coding at `medium`,
with `high` saved for complex architecture or design work and `xhigh` avoided
as a default because latency and cost rarely pay off in normal interactive
coding.

Karpathy's `autoresearch` pattern points in the same direction structurally:
define a tight written program, keep the harness small, run a fixed proof, and
keep or discard changes based on the result. Reasoning effort is not the whole
workflow; clear Markdown instructions and a reliable evaluation loop are.

## Use The Ladder

- `medium`: default for interactive implementation, small refactors, bug fixes,
  docs, and normal role tabs.
- `high`: planning, architecture, reviews, challenge passes, thorny debugging,
  and work where a bad plan would create expensive rework.
- `xhigh`: opt-in only for unusually hard asynchronous work where waiting is
  acceptable and the task has a strong verification gate.

## Launcher Contract

- Profiles should set `CML_CODEX_EFFORT=medium` unless there is a documented
  project-specific reason not to.
- Profiles should set `CML_CODEX_PLAN_EFFORT=high` for Plan mode.
- Role terminals should print both values before starting Codex so the current
  launch posture is visible.
- Smoke tests should fail if a default profile silently regresses back to
  `xhigh`.

## Sources

- Steinberger Codex app summary: https://zenn.dev/seyz/articles/20260308-steipete-codex-how-to
- Steinberger `agent-scripts` AGENTS: https://github.com/steipete/agent-scripts/blob/main/AGENTS.MD
- Karpathy `autoresearch`: https://github.com/karpathy/autoresearch
- OpenAI Codex config reference: https://developers.openai.com/codex/config-reference
