---
name: review-rubric
description: Structured two-stage code review - spec compliance first, then code quality - with confidence-rated findings. Use when asked to review code, a diff, a branch, or a PR, before merging agent-written changes, as the review stage after execute-plan, or when someone wants a second pair of eyes on changes. Catches over-engineering, scope creep, and silent spec deviations that casual review misses.
license: MIT
metadata:
  family: sdlc
  sources: "https://github.com/obra/superpowers; https://github.com/EveryInc/compound-engineering-plugin; https://x.com/karpathy/status/2015883857489522876"
---

# Review rubric

Review in two ordered stages. Stage 1 exists because the most expensive review failure is polishing code that does the wrong thing.

## Stage 1 — Spec compliance

Against the original ask (brief, plan, or issue — read it first, not the PR description's paraphrase):
- Walk the acceptance criteria one by one: met, partially met, or missing? Demand evidence over assurance.
- **The surgical-changes check:** list every change the spec did *not* ask for — refactors, renames, deleted comments, "improved" error handling, drive-by cleanups. Each is either explicitly justified or flagged for removal. Agent diffs fail here more than anywhere else.
- Anything silently reinterpreted? Agents resolve ambiguity by picking quietly; reviews resurface those picks.

If Stage 1 fails materially, stop — report; Stage 2 polish on wrong code is wasted work.

## Stage 2 — Quality

- **Simplicity:** could a strong senior cut this by half? Hunt speculative abstraction, single-use helpers, defensive bloat around impossible states, config nobody asked for. Over-complication is the default failure mode of generated code; the fix is deletion, not comments.
- **Correctness hotspots:** boundaries (empty/zero/max), error paths that swallow or double-handle, concurrency and ordering assumptions, resource cleanup. Trace the one or two most dangerous paths by hand rather than skimming everything evenly.
- **Security, on risky surfaces only:** input handling, authn/z changes, secrets, injection sinks, new dependencies.
- **Tests:** do the new tests fail if the feature breaks? (Mentally revert the feature — which test catches it?) Were any existing tests weakened, skipped, or deleted? That is a blocking finding, always.

## Findings format

For each finding: `severity (blocker/major/minor) · confidence (certain/likely/possible) · file:line · one-line claim · concrete failure scenario`. Only report findings you would stake a review comment on — a plausible-sounding non-bug costs the author an hour. No style nits where a linter exists; propose the lint rule instead.

## Verdict

Approve / approve-with-comments / request-changes, with the specific gate for the last one. State plainly what you did not review (e.g. "did not run the migration against real data") so approval is scoped honestly.
