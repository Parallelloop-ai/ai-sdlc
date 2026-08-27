---
name: tdd-loop
description: Red-green-refactor test-driven development adapted for agent work. Use when implementing features or bugfixes where correctness matters, when asked to do TDD or write tests first, when building against a spec with verifiable behavior, or when agent-written code keeps breaking after delivery. Ensures every test is watched failing before it passes, and guards against the agent-specific failure of weakening tests to get green.
license: MIT
metadata:
  family: sdlc
  sources: "https://github.com/obra/superpowers; https://x.com/karpathy/status/2015883857489522876"
---

# TDD loop

For agent work, tests are not documentation or insurance — they are the verification harness that makes fast iteration safe. A failing test is a precise, machine-checkable success criterion; "loop until this passes" is the declarative instruction agents execute best.

## The loop

**RED** — Write the smallest test for the next slice of behavior. Run it. **Watch it fail, and check it fails for the right reason** — an assertion about the missing behavior, not an import error or typo. A test you never saw fail proves nothing: it may be vacuously green forever.

**GREEN** — Write the minimal code that passes. Run the *single* test (the fast invocation from AGENTS.md), then the surrounding suite. Minimal means no speculative parameters, no handling of cases no test demands yet.

**REFACTOR** — Only on a green bar. Structure, naming, duplication — behavior unchanged, suite green after.

Repeat in thin slices. One behavior per cycle keeps the loop seconds long; a 20-test upfront batch destroys the signal that makes TDD work.

## Agent-specific hard rules

- **Never weaken a test to get green.** Deleting, skipping, loosening an assertion, or bending a test to match buggy output is the cardinal agent sin — it silently converts a correctness harness into a rubber stamp. If a test looks wrong, stop and say so; changing it is a human decision.
- **Never mock the bug away.** Mock at real boundaries (network, clock, filesystem), not around the code under test. A test that mocks the buggy component tests nothing.
- **Failing-first applies to bugfixes doubly:** reproduce the bug as a failing test before fixing; that test is the proof and the permanent regression guard.

## Done

The brief's success criteria are each covered by at least one test that was seen failing, the full relevant suite is green from a fresh run, and no test was weakened along the way.
