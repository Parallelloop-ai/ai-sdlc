---
name: write-plan
description: Turn an approved design or task into an executable plan file with atomic tasks and verifiable success criteria. Use when asked to plan an implementation, break down a feature or migration, create a task list for agent execution, or after brainstorm-first produces a design brief. Produces a durable goal-backward plan sized for fresh-context execution, ready for execute-plan.
license: MIT
metadata:
  family: sdlc
  sources: "https://github.com/obra/superpowers; https://github.com/open-gsd/gsd-core; https://github.com/humanlayer/advanced-context-engineering-for-coding-agents; https://steveyegge.spicytakes.org/post/2025-11-12-introducing-beads-a-coding-agent-memory-system"
---

# Write a plan

A plan exists so that execution can be verified, interrupted, and resumed. Context windows die; files survive. Write the plan as a file, not a message.

## Goal-backward, not task-forward

Start from the end state: if this work were done, what would be observably true? List those end conditions first — commands that pass, behaviors demonstrable, artifacts existing. Then derive the tasks that make each condition true. Task-forward planning produces busywork that feels productive; goal-backward planning produces the shortest path and catches missing requirements before they surface mid-build.

## Atomic tasks

- Each task completable within roughly half a fresh context window — small enough that an executor never needs to compact mid-task, large enough to be a coherent unit.
- 2-3 tasks per phase; phases ordered so the system works (builds, tests green) after every phase, never leaving main broken between phases.
- Per task, write: **goal** (one sentence) · **files touched** (best guess) · **done-check** (the exact command or observation that proves it, with expected result) · **rollback note** if the task is risky.
- Declarative over imperative: give the executor success criteria and constraints, not keystrokes. Smart executors beat scripts when reality diverges — and reality always diverges.

## The plan file

Save to `docs/plans/<yyyy-mm-dd>-<slug>.md`:

```markdown
# Plan: <name>          Status: draft | in-progress | done
**Brief**: <link to design brief or 2-line summary>
**End conditions**: checklist of observable outcomes
**Non-goals / off-limits**: what NOT to touch (protects against scope creep)

## Phase 1 — <name>
- [ ] Task 1.1: goal / files / done-check / rollback
...
## Log
(execute-plan appends evidence and divergences here)
```

The Non-goals line matters more than it looks: agents drift into "improvements" nobody asked for, and an explicit off-limits list is the cheapest scope-creep defense.

## Scale it

A one-file fix needs no plan file — state the done-check in conversation and go. Reach for the file when work spans phases, sessions, or executors.
