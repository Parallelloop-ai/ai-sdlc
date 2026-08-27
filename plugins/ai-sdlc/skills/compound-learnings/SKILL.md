---
name: compound-learnings
description: Capture corrections, review findings, and debugging lessons back into the repo so every future agent run starts smarter. Use after fixing a bug caused by a knowledge gap, after a human corrects agent behavior or retypes the same instruction, after code review surfaces a recurring pattern, when the same mistake happens twice, or when someone says remember this or add this to the docs. Routes each lesson to AGENTS.md, a skill, a scoped rules file, or a mechanical check, and prunes stale guidance while there.
license: MIT
metadata:
  family: sdlc
  sources: "https://github.com/EveryInc/compound-engineering-plugin; https://every.to/guides/compound-engineering; https://code.claude.com/docs/en/memory; https://x.com/bcherny/status/2007179832300581177"
---

# Compound learnings

Each unit of work should make the next one easier. Without this step, the team pays for the same lesson repeatedly — every session rediscovers the proxy quirk, every reviewer re-flags the same pattern. The capture step is what converts agent usage from a treadmill into compounding capital.

## When to capture

Mistake made twice · human correction that will apply again · review finding that is a pattern rather than a one-off · gotcha that cost real time · procedure performed for the second time. (One-off trivia, things the code already says, and this-task-only context do NOT get captured — memory bloat is how guidance dies.)

## Routing — strongest home wins

1. **Mechanically enforceable?** → a lint rule, hook, type, or CI check. The best lesson is one no one ever needs to read again. Always ask this first.
2. **A durable fact or rule, needed repo-wide?** → one line in AGENTS.md (usually Gotchas or Conventions), written as trap + consequence: "X breaks Y because Z", not a bare command.
3. **Only relevant to part of the tree?** → `.claude/rules/<area>.md` with a `paths:` glob, so it loads only when an agent touches those files.
4. **A multi-step procedure?** → a skill (spec frontmatter, so every harness reads it). Procedures in prose files rot; skills load on demand.

## Write it so it survives

- Include the **why**. A rule with a reason gets followed and correctly updated later; a bare imperative gets cargo-culted, then deleted by someone who cannot tell if it still matters.
- One line where one line does it. Match the file's existing voice.
- Check for an existing entry covering it — **update rather than duplicate**; contradictory duplicates are worse than absence.

## Prune while you are there

Guidance files are code. On every capture visit, scan for entries that are stale, superseded, or derivable — delete them (git remembers). Bloated guidance gets skimmed, and skimmed guidance protects no one. If the human pushes back on a capture, that is signal about what they consider durable — recalibrate, do not re-add.
