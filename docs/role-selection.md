---
summary: Quick reference for current launcher role tabs.
read_when:
  - You need to decide which Penny tab should own a task.
  - You are editing profiles or role prompts.
---

# Role Selection

## Dynamic Chooser Roles

- `lead`: scope control, task decomposition, git state, and integration.
- `build`: implementation in the selected target repo.
- `verify`: test/build/typecheck/runtime proof.
- `ship`: commit, push, release, changelog, and closeout hygiene when requested
  or required by the target repo.

## Penny Profile Roles

- `lead`: Penny Create coordination and integration.
- `create-ui`: Landing, Create, options, comments, artifact layout, and UI
  evidence.
- `brain-evidence`: fixtures, Brain source display, memory chips, privacy
  labels, and import wording.
- `learn-canvas`: Learn-this flows, return-to-Create state, visual outline, and
  Canvas graph polish.
- `export-verify`: export prompt content, test/build/typecheck work, and
  browser smoke verification.

## Adding Roles

Add project-specific roles in the relevant profile instead of hardcoding them in
the launcher.

A durable role needs:

- clear ownership
- likely disjoint files
- specific read-first docs
- specific verification responsibility
