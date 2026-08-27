---
name: audit-ai-readiness
description: Audit any repository for AI-agent readiness and produce a scored report with a prioritized fix plan. Use whenever someone asks how ready a repo is for AI-led development, whether coding agents will work well in a codebase, before rolling out Claude Code or Codex on a repo or team, when agents keep underperforming or repeating mistakes in a codebase, or as the first step before agentify-repo. Also use for requests like "review our AI setup", "why does the agent struggle here", or "score this repo for agents".
license: MIT
metadata:
  family: readiness
  sources: "https://code.claude.com/docs/en/best-practices; https://marmelab.com/blog/2026/01/21/agent-experience.html; https://michaelscodingspot.com/preparing-codebase-ai-agents/; https://lucumr.pocoo.org/2025/6/12/agentic-coding/; https://arxiv.org/abs/2606.09935"
---

# Audit AI-readiness

Score how well a repository supports AI-led development, then hand back a report a team can act on. The audit is evidence-based: run commands and read files; never score a dimension from assumptions.

## Why these dimensions

An agent's output quality is capped by its feedback loop (if tests take 10 minutes, the agent's iteration is 10 minutes; if they are flaky, the agent cannot tell its own failures from noise) and by what the repo tells it (context files) versus what it must guess. The rubric weighs those levers highest.

## Process

1. **Inventory context files.** Find every AGENTS.md, CLAUDE.md, .cursorrules, .github/copilot-instructions.md at any depth. For pairs: check whether they are linked (symlink or `@AGENTS.md` import) or divergent copies — diff them. Note line counts and last-modified vs recent code churn (`git log -1 --format=%ci -- <file>` vs repo activity).
2. **Verify the documented commands.** Every build/test/lint command claimed in context files or README: actually run it (read-only ones directly; destructive ones with `--dry-run` or skip and note). A context file that lies is worse than none.
3. **Time the feedback loop.** Run the test suite once, measure wall time. Check whether a single test can be run selectively and whether that invocation is documented. Run lint/typecheck if present.
4. **Check agent configuration.** `.claude/settings.json` permissions (allowlist? deny rules?), hooks, `.claude/rules/*.md` with `paths:` globs, project skills, sandbox/devcontainer setup.
5. **Assess legibility.** Sample the largest source files (`find`/`wc -l`), look for dead code regions, duplicate basenames that confuse search, missing seams. Check for ADRs/design docs and E2E tests that document main flows.
6. **Assess safety.** Scan for committed secrets (entropy/pattern scan). Note prompt-injection surface: context files and docs are instructions agents will follow — flag anything unreviewed or auto-generated. Check for an AI-contribution policy if the repo takes external PRs.
7. **Score and report.** Work through [references/rubric.md](references/rubric.md) — every check is a binary YES/NO with evidence. Then write the report.

## Report format

Use exactly this structure:

```
# AI-readiness audit: <repo>  (<date>)
Overall: <A-F> — <one-line verdict>

## Scorecard
| Dimension | Score | Evidence highlights |
(6 rows, score = n/N binary checks passed)

## Top fixes, in leverage order
1..5 — each: what, why it matters for agents, effort (S/M/L), which skill fixes it
   (context files → generate-context-files; config/hooks/tests → agentify-repo)

## What is already good
(so the team does not break it)
```

Order fixes by leverage, not ease: feedback loop > context files > enforcement config > legibility > safety > knowledge capture. Be specific — "test suite is 14m31s, no single-test invocation documented" beats "tests are slow".
