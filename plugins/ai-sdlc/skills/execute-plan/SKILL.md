---
name: execute-plan
description: Execute a written plan task-by-task with checkpointed verification and honest divergence handling. Use when asked to execute or continue a plan file, implement a designed feature phase by phase, resume interrupted or handed-off agent work, or when a plan from write-plan exists. Runs each task to its done-check, records evidence in the plan file, and stops to resurface when reality diverges from the plan.
license: MIT
metadata:
  family: sdlc
  sources: "https://github.com/obra/superpowers; https://github.com/open-gsd/gsd-core; https://github.com/humanlayer/advanced-context-engineering-for-coding-agents"
---

# Execute a plan

The plan file is the source of truth and the only memory that survives. Trust it over recollection; update it as you go or it rots into fiction.

## Loop

1. **Read the whole plan** (and its brief) before touching anything — end conditions and non-goals included. You are executing an intent, not a checklist.
2. **One task at a time.** Do exactly the task; resist adjacent "while I'm here" improvements — the non-goals section is binding. Surgical diffs: only files the task implies.
3. **Checkpoint every task.** Run the task's done-check. Paste the actual evidence (command + output summary) into the plan's Log, tick the checkbox, and commit with a message referencing the task. A ticked box with no evidence is a lie waiting to be discovered late.
4. **Keep context fresh.** At phase boundaries — or when the window gets heavy — prefer starting clean and re-reading the plan file over dragging a long transcript. Recall degrades in the middle of large contexts; the plan file is the compaction.
5. **Diverge loudly.** When a task is impossible as written, an assumption proves false, or the done-check cannot pass: STOP. Write what you found into the Log, propose the amended plan, and resurface to the human. Silent improvisation is how plans and reality end up describing different systems. (Trivial mechanical adjustments — a renamed file, a moved import — just note and proceed.)
6. **Finish properly.** After the last task, verify the plan's END CONDITIONS (not just per-task checks) — then run verify-done for the final gate, and mark the plan Status: done.

## Resuming

On resume (new session, new executor): read plan + Log top to bottom, run the done-checks of the last two ticked tasks to confirm reality still matches the record, then continue. Never trust a checkbox you cannot re-verify cheaply.
