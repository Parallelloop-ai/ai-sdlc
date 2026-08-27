---
name: verify-done
description: Evidence-based completion gate before declaring any work finished. Use before saying done, fixed, implemented, or all tests pass, before handing off or merging agent work, at the end of execute-plan, and whenever wrapping up a task of any size. Requires fresh command output as evidence, checks the diff for leftovers, and re-reads the original ask so the thing delivered is the thing requested.
license: MIT
metadata:
  family: sdlc
  sources: "https://github.com/obra/superpowers; https://x.com/bcherny/status/2007179832300581177; https://github.com/open-gsd/gsd-core"
---

# Verify done

"It works" is a prediction until you have fresh evidence. Verification is the single highest-leverage step in agent-led work — the difference between shipping and shipping-shaped output — and it is precisely the step most tempting to skip at the end of a long task.

## The gate

1. **Re-read the ORIGINAL ask** — not your summary of it, which has drifted with every compaction. Goal-backward: list what would be observably true if this were done. Check each.
2. **Run the checks NOW.** Full relevant test suite, lint, typecheck, build — fresh, in this state of the tree, not recalled from twenty minutes ago. Quote real output (totals, times, exit codes). "Tests passed earlier" is not evidence; the tree has changed since earlier.
3. **Read your own diff** end to end (`git diff`, every file): each change intentional and in-scope? Leftover debug prints, commented-out code, stray TODOs, accidental formatting churn, files that should not be there?
4. **Poke the edges the ask implies.** Empty input, the error path, the concurrent case — whichever boundary this change obviously owns. One minute of adversarial poking beats a paragraph of reassurance.
5. **For substantial changes, run a fresh-eyes pass.** A subagent (or you, after a deliberate reset) whose only job is to *refute* "this is done" against the checklist from step 1. The author's context is contaminated by intent — they see what they meant, not what is there.
6. **Report honestly, in three bins:** verified (with evidence) · assumed (and why it is safe to assume) · out of scope (named, not hidden). If any check failed: the work is not done; say exactly that and what remains — a clean "not done, X remains" builds more trust than a hedged "should work".

Never weaken a check to pass the gate. The gate exists for the moment you most want to skip it.
