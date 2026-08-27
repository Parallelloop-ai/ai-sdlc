---
name: agentify-repo
description: Revamp a repository so AI agents work in it safely and fast - permission allowlists, hooks, fast test lanes, scoped rules, project skills, CI feedback, and an AI contribution policy. Use whenever someone asks to make a repo AI-ready, AI-led, or agent-friendly, set up Claude Code or Codex properly for a team repo, reduce permission prompts, wire hooks or guardrails for agents, or apply the fixes from an audit-ai-readiness report. Complements generate-context-files, which owns AGENTS.md and CLAUDE.md themselves.
license: MIT
metadata:
  family: readiness
  sources: "https://code.claude.com/docs/en/best-practices; https://lucumr.pocoo.org/2025/6/12/agentic-coding/; https://github.com/ghostty-org/ghostty/blob/main/AI_POLICY.md; https://github.com/disler/claude-code-hooks-mastery; https://x.com/bcherny/status/2007179832300581177"
---

# Agentify a repo

Turn a repository into an environment where agents iterate fast and cannot do expensive damage. Work the layers in order — each builds on the previous. Show the human what you changed at each layer; settings and hooks are team-wide behavior.

## 0. Context files first

If AGENTS.md/CLAUDE.md are missing, bloated, or drifted, run generate-context-files before anything else. Everything below assumes agents know the repo's commands.

## 1. Permissions: pre-approve the safe, deny the dangerous

In `.claude/settings.json` (project-level, committed):
- **Allow** the everyday read-and-verify loop so agents never stall on prompts: the test command, lint, typecheck, build, `git status/diff/log`, the package manager's install/run.
- **Deny** the blast-radius surfaces: deploy commands, database migrations against real environments, `git push --force`, package publishing.
- Principle: *enforcement lives in config, not prose.* A context-file line saying "never force-push" is a suggestion; a deny rule is a fact. Sandboxing (OS-level) where available beats both.

## 2. Hooks: make correctness automatic

- PostToolUse hook on Write|Edit → run the formatter (and fast lint --fix) on the touched file. Style then never needs prose instructions, and diffs stay clean.
- Block-writes hook for generated dirs, lockfiles-by-hand, or migration folders if the team hand-reviews those.
- Keep hooks fast (<2s) and deterministic; a slow or flaky hook teaches the team to disable hooks.

## 3. Fast test lane: the agent's heartbeat

- Document the single-test invocation in AGENTS.md; it is the most-used command in agent work.
- If the full suite exceeds ~5 minutes, create a fast lane (unit-only, affected-only) agents run per iteration, with the full suite at verify-time.
- Kill flakiness in the unit lane (mock network/time); a flaky suite blinds the agent — it cannot tell its own breakage from noise.

## 4. Scoped rules and project skills

- Area-specific guidance → `.claude/rules/<area>.md` with `paths:` globs, so frontend rules load only when touching frontend files. This is the context-saving mechanism; imports are organization only.
- Repeated procedures (release, deploy, migration, codegen) → project skills in `.claude/skills/<name>/SKILL.md`, spec-frontmatter only so Codex and other harnesses read them too. Procedures do not belong in AGENTS.md.

## 5. CI as the second feedback loop

- PR checks must be readable by the agent (`gh pr checks`, log access) so it can react to failures without a human relaying them.
- Fail fast and specifically: a check named "lint" that fails with the offending file beats a monolithic "build" that fails at minute 22.

## 6. Isolation for parallel and unattended work

- Parallel agents → one git worktree each; never two agents in one checkout.
- Unattended/looped runs → sandbox or devcontainer with network and filesystem limits; autonomy is earned by the walls around it, not by trust.

## 7. AI contribution policy (teams and open source)

Add a short policy (AI_POLICY.md or an AGENTS.md Etiquette entry): disclosure expectations for substantial AI contribution, review requirements before merge, and what is out of bounds (e.g. AI-generated PRs for unaccepted issues). Modeled on Ghostty's policy — governance is part of being AI-ready, not an afterthought.

## 8. Verify the revamp

Re-run audit-ai-readiness and report the before/after scorecard. The delta is the deliverable.
