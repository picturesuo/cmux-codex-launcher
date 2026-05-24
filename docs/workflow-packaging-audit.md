---
summary: Audit repeated work and package only the smallest useful Codex asset.
read_when:
  - The user asks what should become a skill, subagent, or automation.
  - You are turning recent sessions, Memories, or Chronicle evidence into reusable workflow assets.
  - You are deciding whether repeated work is already covered by existing Codex setup.
---

# Workflow Packaging Audit

## Goal

Find repeated manual work worth packaging for Codex, then create only the
high-confidence missing asset. The default outcome can be "skip" when the
evidence is thin, sensitive, too broad, or already covered.

## Evidence Order

Use the strongest available evidence first:

1. Recent Codex sessions, task summaries, shared context files, and repo docs.
2. Codex Memories and rollout summaries for patterns repeated across sessions.
3. Chronicle, when enabled, for discovery only. Confirm important details in
   the source system before acting.
4. Existing skills, custom subagents, automations, project docs, and scripts.

Do not use screenshots, Chronicle notes, Memories, or session summaries as a
source of truth for sensitive facts. Treat them as leads and verify in the
repo, tracker, document, calendar, or CLI that owns the work.

## Candidate Test

Package a workflow only when it passes all of these checks:

- It happened at least twice, or is clearly likely to recur and costly to repeat.
- It has stable inputs, a repeatable procedure, and a clear output or stopping
  condition.
- It improves speed, quality, consistency, or reliability enough to justify the
  extra artifact.
- Existing skills, subagents, automations, docs, or scripts do not already cover
  it well.

Skip work that is one-off, ambiguous, secret-heavy, too personal to encode,
poorly evidenced, or better handled by a normal prompt.

## Smallest Useful Form

- Skill: a reusable method, playbook, or tool workflow that should be available
  on demand.
- Custom subagent: a bounded specialist investigation or review role that can be
  delegated and reported back.
- Automation: a scheduled or recurring check, report, reminder, or monitor.
- Extend existing: a small improvement to a current skill, doc, script,
  automation, or agent instruction.
- Skip: not worth packaging yet.

Prefer extension over duplication. Prefer a short doc or script over a skill
when the workflow only belongs to one repo. Prefer an automation only after the
interactive prompt shape has worked at least once and the output is easy to
review.

## Shortlist Format

Produce a compact shortlist before creating anything:

```text
Repeated workflow:
Evidence and dates:
Frequency/confidence:
Recommended form:
Worth creating because:
Already covered by:
Decision:
```

Include "skip" decisions in the shortlist so future sessions can see what was
considered and why it was not packaged.

## Creation Rules

After the shortlist, create only high-confidence missing items.

Keep each created asset narrow:

- Name the inputs it expects.
- Name the exact procedure or delegation boundary.
- Name the output and stopping condition.
- Name the verification step.
- Name the source systems it may consult.
- State what it must not do, especially around secrets and private data.

Do not create speculative, overlapping, or broad "do everything" assets. If the
candidate needs more evidence, write the missing evidence requirement instead.

## Codex App Patterns

Use Codex app sessions as the main working threads. Keep one coherent unit of
work per thread; fork when exploring alternatives; compact when the useful
context needs to survive; use subagents for bounded research, tests, triage, or
archaeology; and keep repo-specific behavior in repo docs or `.codex/config.toml`.

Use Memories for stable preferences, recurring workflows, tech stacks, and
pitfalls. Keep hard requirements in `AGENTS.md`, repo docs, or committed
scripts so they travel with the project.

Use Automations for specific, repeatable, reviewable work such as weekly
summaries, daily issue triage, CI-failure summaries, release briefs, bug scans,
or recurring workflow audits.

Use skills when a repeated workflow needs instructions plus resources or scripts
and should work across the Codex app, CLI, or IDE extension.

Public OpenAI examples emphasize practical skills for Figma implementation,
project management, deployment, image generation, OpenAI API work, documents,
spreadsheets, and PDFs. OpenAI also describes internal skills for evals,
training-run monitoring, docs, and growth-reporting workflows, plus
automations for issue triage, CI summaries, release briefs, and bug checks.

## External Patterns

- Karpathy: keep the harness small, write the agent program in Markdown, define
  editable surfaces, and keep or discard changes based on measured output.
- Steinberger: talk plainly, use parallel Codex sessions when the boundaries are
  visible, favor exact CLIs over context-heavy tool setup, and avoid turning
  every task into ceremony.
- Simon Willison: parallel agents are most useful for research, archaeology,
  small maintenance, and clearly specified implementation work where review is
  cheap.

## Finish Format

End with:

```text
Created or extended:
Deliberately skipped:
Needs more evidence:
Verification:
```

## Sources

- OpenAI Codex best practices: https://developers.openai.com/codex/learn/best-practices
- OpenAI Codex Memories: https://developers.openai.com/codex/memories
- OpenAI Codex Chronicle: https://developers.openai.com/codex/memories/chronicle
- OpenAI Codex app announcement: https://openai.com/index/introducing-the-codex-app/
- OpenAI Codex automations academy: https://openai.com/academy/codex-automations/
- OpenAI workflow audit use case: https://openai.com/academy/top-10-use-cases-codex-for-work/
- Karpathy autoresearch: https://github.com/karpathy/autoresearch
- Steinberger agent scripts: https://github.com/steipete/agent-scripts
- Simon Willison on parallel coding agents: https://simonwillison.net/2025/Oct/5/parallel-coding-agents/
- Simon Willison on Steinberger's Codex workflow: https://simonwillison.net/2025/Oct/14/agentic-engineering/
