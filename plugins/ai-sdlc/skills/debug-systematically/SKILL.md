---
name: debug-systematically
description: Root-cause-first debugging discipline. Use when investigating any bug, error, stack trace, test failure, flaky behavior, or regression, when a previous fix did not hold, or when someone says debug this, why is this failing, or it works on my machine. Reproduces first, forms competing hypotheses, runs the cheapest discriminating experiment, fixes the cause rather than the symptom, and locks the fix in with a regression test.
license: MIT
metadata:
  family: sdlc
  sources: "https://github.com/obra/superpowers; https://github.com/EveryInc/compound-engineering-plugin"
---

# Debug systematically

Guess-and-patch debugging converges by luck and regresses by default. This discipline exists because the expensive part of a bug is not the fix — it is every hour spent on the wrong theory, and every future recurrence of a symptom-patched cause.

## Process

1. **Reproduce before anything.** Get a reliable, minimal, scripted reproduction — ideally a failing test. If you cannot reproduce it, that is the investigation now (logs, exact environment/version deltas, timing). No repro, no fix — only hope.
2. **Read the actual error.** The full message, the right frame of the stack, the logs just before. Agents (and humans) pattern-match on the first familiar word and chase ghosts; the answer is written down surprisingly often.
3. **State 2-3 competing hypotheses** ranked by likelihood, each with the mechanism it implies. Naming more than one is the guard against tunnel vision on the first idea.
4. **Run the cheapest discriminating experiment** — the one whose outcome splits the hypotheses. Instrument (targeted logs, debugger, `git bisect`, shrink the repro) rather than speculate. One variable at a time; parallel edits destroy the signal.
5. **Explain the mechanism before fixing.** You understand the bug when you can say "X causes Y because Z" and predict what else Z would break. A fix without a mechanism is a coincidence that happened to compile.
6. **Fix the cause.** If a symptom-level mitigation is genuinely warranted now (incident pressure), say so explicitly, ship it labeled as such, and file the cause with a repro attached.
7. **Lock it in.** The repro becomes a permanent regression test — confirm it fails on the pre-fix code and passes after. If the bug came from a knowledge gap that will recur, route the lesson through compound-learnings.

## Anti-patterns

Shotgun edits ("changed several things, seems fixed"); retry-until-green on flaky tests; editing the test to match buggy output; declaring victory without re-running the original repro; blaming the framework before your own diff (`git log` the suspect area first — the newest change is the usual suspect).
