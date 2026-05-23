---
summary: Lightweight coordination rules for multiple cmux Codex tabs.
read_when:
  - You plan to run multiple Codex tabs on the same target project.
  - You need explicit ownership, handoff, or persistent-session guidance.
---

# Multi-Agent Workflow

Use multiple Codex tabs only when the work has clean ownership boundaries.

## When To Split Work

Use multiple tabs when:

- one tab can keep moving on the main path while another handles a bounded side task
- validation, documentation, or exploration can run in parallel with implementation
- the target files and responsibilities are disjoint

Do not split work when:

- the next step is blocked on one urgent result
- multiple tabs would edit the same files at the same time
- coordination cost is higher than the likely speedup

## Coordination Rules

- One tab per task or concern.
- Give each tab a clear goal, write scope, and expected output.
- Keep the visible tab on the task you are actively steering.
- Use cmux unread state and notifications for background tabs instead of keeping every tab split on screen.
- Update the shared context before handoff or compaction.

## Penny Default Roles

- `lead` owns coordination and integration.
- `create-ui` owns front-end Create polish.
- `brain-evidence` owns fixture and evidence behavior.
- `learn-canvas` owns Learn bridge and Canvas ending.
- `export-verify` owns export and checks.

## Git Boundaries

- Keep write scopes disjoint whenever possible.
- Check `git status` and `git diff` before integrating another tab's work.
- Follow the target repo's `AGENTS.md` for commit and push behavior.
