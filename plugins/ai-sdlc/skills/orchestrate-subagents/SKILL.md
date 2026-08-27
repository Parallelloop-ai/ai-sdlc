---
name: orchestrate-subagents
description: Fan work out to fresh-context subagents and integrate their results safely - parallel tasks, isolated research, and perspective-diverse review. Use when work splits into independent tasks that could run in parallel, when heavy exploration or research would pollute the main context window, when multiple review perspectives are wanted on one change, when asked to parallelize, delegate, use subagents or agent teams, or when a plan from write-plan has file-disjoint phases. Covers briefing, worktree isolation, and reviewing returned work.
license: MIT
metadata:
  family: sdlc
  sources: "https://github.com/obra/superpowers; https://github.com/humanlayer/advanced-context-engineering-for-coding-agents; https://x.com/bcherny/status/2017742743125299476; https://x.com/karpathy/status/2015883857489522876"
---

# Orchestrate subagents

Subagents buy two things: **isolation** (heavy exploration happens in a disposable context and only the conclusion comes back) and **parallelism** (independent tasks run at once). Both are paid for at the handoff — a subagent sees nothing of your conversation, so the brief is everything, and its output is unverified until you check it.

## When to fan out — and when not to

Fan out when tasks are file-disjoint and independently verifiable, when research would flood your window with reading you only need conclusions from, or when you want genuinely independent review perspectives on one change. Do NOT fan out for tightly-coupled sequential edits (coordination overhead exceeds the win), tasks too small to outweigh spawn cost, judgment calls (taste stays with the human and the primary context), or for spectacle — an agent swarm you cannot review is a liability, not leverage.

## The brief

Write each subagent's task as if for a competent stranger with no context — because that is literally what it is:

- **Goal** in one sentence, plus explicit constraints and non-goals (subagents scope-creep too).
- **Exact paths** to read or touch; never "the auth module".
- **The done-check**: the command and expected result that proves completion. If you cannot state one, the task is not ready to delegate — sharpen it first.
- **Expected return format**: what should come back (a diff, a findings list, a file:line-referenced report) so results are integrable, not prose to re-mine.

## Isolation rules

- Parallel **writers** get one git worktree each — never two agents mutating one checkout; the corruption is silent and the debugging is miserable. Readers can share.
- Give each task a fresh context rather than one long-lived helper; recall degrades as windows fill, and fresh-per-task is the compaction discipline applied to delegation.

## Receiving work back

Treat a subagent's "done" as a claim, not a fact. Run its done-check yourself; review the diff with the two-stage discipline (spec compliance, then quality — see review-rubric); integrate one branch at a time so a bad result cannot hide inside a batch merge. A subagent report without evidence gets the same response a human's would: show me.
