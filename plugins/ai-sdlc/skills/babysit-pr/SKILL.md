---
name: babysit-pr
description: Drive an open pull request to merge-readiness - watch CI, fix failures at root cause, triage and resolve reviewer feedback, and re-request review. Use when asked to babysit, shepherd, or watch a PR, get a PR green or over the line, handle review comments or CI failures on an open PR, or after ship-clean opens one. Ends at merge-ready with an evidence-backed status report; merging itself stays a human decision.
license: MIT
metadata:
  family: sdlc
  sources: "https://github.com/EveryInc/compound-engineering-plugin; https://github.com/obra/superpowers"
---

# Babysit a PR

A PR left alone after opening rots: CI flakes get ignored, review comments age into conflicts, and the author context-switches away. This skill owns the gap between "opened" and "merge-ready" — the phase most workflows leave to nobody.

## The loop

Cycle through checks and feedback until the stop condition; report honestly at each pass.

**1. CI status.** Read the actual failing check's logs (`gh pr checks`, then the log), not just the red X. Fix failures at root cause on the same branch in small commits — debug-systematically applies; a CI failure is a bug report. For suspected flakes: rerun **once**, and say so ("rerun passed; failure looked infra-shaped: <evidence>"). Never retry-until-green — a flake you launder into the merge is a bug you shipped blind.

**2. Reviewer feedback triage.** Classify every comment into three bins:
- **Do it** — correct, in scope: fix it, reply with the commit reference, resolve the thread.
- **Discuss** — reasonable but conflicts with the spec or has a cost the reviewer may not see: reply with the tradeoff, once, with reasons; let the human owner settle it.
- **Decline with reasons** — asks for out-of-scope work or contradicts the approved design: say so respectfully and link the brief/plan; never silently ignore a comment, and never silently comply with scope creep either (write-plan's non-goals are binding here too).

**3. Resolution hygiene.** Reply with evidence, not "done" (the verify-done rule applied to threads: link the commit, paste the passing check). Resolve only threads the reviewer's concern actually addressed. Re-request review when all their comments have a response, not after each one.

**4. Keep the branch current.** If main moved: rebase or merge per the repo's convention, re-run the full checks after, and never force-push over a reviewer's in-progress review without telling them.

## Stop conditions

**Merge-ready** = approvals in, checks green from the latest commit, no unresolved threads, branch current. Report it with the evidence and stop — merging, like all pushes to shared state, is the human's call (ship-clean). **Blocked** = a Discuss item awaits the owner, or CI fails for reasons outside the diff: report exactly what is needed from whom, rather than idling or improvising.
