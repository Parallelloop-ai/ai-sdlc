# AI-readiness rubric

Binary checks. Answer each YES/NO with one line of evidence (command output or file:line). Score each dimension n/N; overall grade: A ≥ 90%, B ≥ 75%, C ≥ 60%, D ≥ 40%, F below.

## 1. Context files (agent onboarding)
- C1 An AGENTS.md (or CLAUDE.md) exists at repo root.
- C2 The pair is single-source: CLAUDE.md is a symlink or contains `@AGENTS.md` — not a divergent copy (diff proves it).
- C3 Root context file is ≤ 200 lines (past ~500, models skim; bloat causes instructions to be ignored).
- C4 Every command in it runs successfully as written.
- C5 No derivable bloat: no directory trees, dependency lists, or file-by-file descriptions an agent can discover itself.
- C6 Touched within the last 90 days OR repo has had no meaningful churn since.
- C7 Monorepo only: subdirectory context files exist for major packages (they load on demand).

## 2. Feedback loop (the ceiling on agent quality)
- F1 One documented command runs the test suite.
- F2 A single test/file can be run selectively, and the invocation is documented in the context file.
- F3 Full suite completes in under 5 minutes (measure it).
- F4 Lint and typecheck commands exist and pass on main.
- F5 Tests are deterministic — no known-flaky markers, no time/network dependence in unit lane (external deps mocked).

## 3. Enforcement config (rules as config, not prose)
- E1 `.claude/settings.json` (or equivalent) pre-approves the safe everyday commands (test, lint, build).
- E2 Deny rules or sandbox config exist for destructive surfaces (deploy, migrations, force-push).
- E3 Hooks auto-run formatter/linter on edit, so style is never left to prose instructions.
- E4 Nothing in the context file says "always/never do X" that a hook or lint rule could enforce mechanically instead.

## 4. Legibility (grep-first navigation)
- L1 90% of source files are under ~500 lines; no single God-file holds a main flow.
- L2 Names are unique and grep-friendly: searching a symbol/filename lands on one thing (agents grep; they do not use RAG).
- L3 No significant dead code or commented-out blocks in main paths.
- L4 Architecture decisions that cannot be derived from code are written down (ADRs, design docs) and linked from the context file.
- L5 E2E or integration tests illustrate the main user flows (agents read tests as executable documentation).

## 5. Safety
- S1 No secrets in the repo (scan passes); secret sources documented (env/ESO/vault).
- S2 Context files and committed instruction files are human-reviewed like code (injection surface — repo files can carry embedded instructions).
- S3 Guidance exists for isolation on risky/parallel work (worktrees, sandbox, devcontainer).
- S4 If the repo accepts external PRs: an AI-contribution policy states disclosure and review expectations.

## 6. Knowledge capture (compounding)
- K1 Repeated procedures (release, migration, deploy) are captured as skills or scripts, not tribal knowledge.
- K2 There is a place lessons land (context-file gotchas section, lessons file, rules dir) and evidence it is actually updated.
- K3 The context file's gotchas reflect real recent incidents (spot-check against git history), not stale folklore.
