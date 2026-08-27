# ai-sdlc

State-of-the-art AI-led SDLC skills + repo AI-readiness tooling, curated and rewritten from the best published practitioner material (Karpathy's workflow notes, Superpowers, Anthropic official guidance, Compound Engineering, HumanLayer, and more — full attribution in docs/SOURCES.md). Dual-runtime: one skills tree consumed by both Claude Code and Codex.

## Skills (13)

- **Readiness**: `audit-ai-readiness` (30-check scored rubric), `generate-context-files` (canonical AGENTS.md + CLAUDE.md shim, verified commands), `agentify-repo` (permissions, hooks, test lanes, CI, AI policy)
- **SDLC**: `brainstorm-first`, `write-plan`, `execute-plan`, `tdd-loop`, `review-rubric`, `debug-systematically`, `verify-done`, `compound-learnings`, `ship-clean`
- **Principles**: `ai-led-engineering`

## Install

Claude Code:

```bash
claude plugin marketplace add Parallelloop-ai/ai-sdlc
```

then `/plugin install ai-sdlc@ai-sdlc`. Skills invoke as `/ai-sdlc:<name>` or auto-trigger by description.

Codex (and other harnesses reading `~/.codex/skills`): clone this repo and run `./install.sh`, which registers the Claude marketplace and symlinks every skill for Codex.

## Extending

Skills use only open-standard frontmatter (agentskills.io), so any compliant harness reads them. Company-specific knowledge belongs in a private overlay plugin that layers on top of this core — same pattern, separate repo.

## Design

See DESIGN.md (architecture + decisions) and docs/SOURCES.md (curation ledger).
