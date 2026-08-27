---
name: ship-clean
description: Clean landing discipline for finishing work - commits, PR preparation, and branch hygiene for agent-written changes. Use when asked to commit, open or prepare a PR, finish or land a branch, or ship a change, and before any push to a shared remote. Produces small honest commits, a PR description with verification evidence, appropriate AI-contribution disclosure, and explicit human sign-off for anything outward-facing.
license: MIT
metadata:
  family: sdlc
  sources: "https://github.com/obra/superpowers; https://github.com/EveryInc/compound-engineering-plugin; https://github.com/ghostty-org/ghostty/blob/main/AI_POLICY.md"
---

# Ship clean

The landing is the part of agent work other people live with. A reviewable PR with honest evidence gets merged and trusted; a 40-file mystery diff gets rubber-stamped or rots — both outcomes are failures.

## Commits

- Small and coherent: one intention per commit, message = what + why. Never bundle the drive-by fix with the feature — separate commit or leave it out.
- Honest messages: "partial fix for X, Y still open" beats "fix X" that quietly does not. The log is the team's memory; do not poison it.
- Nothing lands uninspected: run the verify-done gate before the final commit, and read the staged diff (`git diff --staged`) — staging surprises (a .env, a debug file) are cheapest to catch here.

## The PR

- **Description = what + why + how verified.** Paste real evidence: test totals, the command outputs, screenshots for UI. A reviewer should be able to trust-but-verify in one read.
- Note risks and the rollback path for anything touching state (migrations, config, wire contracts).
- **Disclose substantial AI contribution** where the repo or team expects it (policy file, commit trailer, or PR note). Normalizing disclosure is what keeps AI-led work reviewable at team scale.
- Right-size: if the diff has grown past comfortable review (~400 lines changed is a common ceiling), propose splitting before requesting review, not after.

## Branch and blast radius

- Work on feature branches; shared branches (main/stage) receive merges, not direct pushes.
- **Pushing, merging, publishing, and deploying are human decisions.** Prepare everything, then ask — approval for one push is not approval for the next. Never rewrite shared history.
- After merge: delete the branch, close the loop (link/close the issue, update the plan file to done). A finished task leaves no dangling state behind.
