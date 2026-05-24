---
summary: Lightweight coordination rules for multiple cmux Codex tabs.
read_when:
  - You plan to run multiple Codex tabs on the same target project.
  - You need explicit ownership, handoff, or persistent-session guidance.
---

# Multi-Agent Workflow

Use multiple Codex tabs only when the work has clean ownership boundaries and a
shared target/GitHub repo is already resolved.

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
- Do not let multiple tabs edit the same file unless the lead tab is explicitly
  coordinating the sequence.
- A tab that finishes must report changed files, verification, residual risk,
  and whether anything needs shipping.

## Dynamic Chooser Roles

- `lead` owns coordination, git status, and integration.
- `build` owns implementation.
- `verify` owns tests, typecheck/build, and runtime proof.
- `ship` owns branch, origin, commit, push, release, and closeout hygiene.

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
- If the selected GitHub target does not match `origin`, stop and resolve that
  mismatch before making repo-visible changes.
