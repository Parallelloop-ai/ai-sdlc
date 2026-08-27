# ai-sdlc — AI-led SDLC plugin (design)

Status: v0.1.0. Decisions locked 2026-08-26.

## Decisions
1. **Home**: local-first (own git repo, no remote at first). Published as a marketplace repo once proven.
2. **Content**: curate + REWRITE. Distill the best published material (Karpathy, Superpowers, Anthropic official, HumanLayer, et al.) into original, tightly-written skills with per-skill attribution. No wholesale vendoring.
3. **Runtime**: dual-runtime, tested in BOTH Claude Code and Codex.
4. **Flavor**: generic core (`ai-sdlc`, this repo) + a company-internal overlay plugin maintained in a separate private repo.

## Naming
`ai-sdlc` (renamed from the working name software3 before publication; skills invoke as `/ai-sdlc:<skill>`).

## Architecture (verified against both harnesses on this machine)
```
ai-sdlc/                          ← marketplace repo root
├── .claude-plugin/marketplace.json ← Claude Code marketplace (schema per code.claude.com docs)
├── .agents/plugins/marketplace.json← Codex marketplace mirror (schema observed in ~/.codex bundled marketplaces)
├── plugins/
│   ├── ai-sdlc/                  ← generic plugin
│   │   ├── .claude-plugin/plugin.json
│   │   ├── .codex-plugin/plugin.json   ← same shape; Codex adds an `interface` block (observed in openai-bundled/latex)
│   │   └── skills/<name>/SKILL.md      ← ONE shared skills tree, read by both
├── docs/SOURCES.md                 ← curation ledger: source → URL → what we took → where it landed
└── DESIGN.md
```
- **Portability rule**: shared skills use ONLY open-standard frontmatter (`name`, `description`, `license`, `compatibility`, `metadata`, `allowed-tools` — agentskills.io core). Claude-only powers (`context: fork`, hooks, `when_to_use`, dynamic `!`cmd`` injection) are allowed only in skills marked claude-only in `metadata`, with graceful degradation in Codex.
- Evidence: Codex bundled plugin `latex` = `.codex-plugin/plugin.json` + `skills/*/SKILL.md` with `name`/`description`-only frontmatter; Codex marketplace at `.agents/plugins/marketplace.json`. Codex CLI ships in ChatGPT.app (`CODEX_CLI_PATH=/Applications/ChatGPT.app/Contents/Resources/codex`).

## Skill families — v1 target
**Family R — repo AI-readiness (the core ask)**
- `audit-ai-readiness` — score a repo against a rubric (context files present+fresh, one-command test/lint/typecheck, permission allowlist, hooks, docs seams, secrets hygiene, CI feedback speed); emits scored report + prioritized fix plan.
- `generate-context-files` — write/refresh CLAUDE.md + AGENTS.md as ONE source mirrored (the repo's existing pattern: identical files, or symlink where tooling allows). Verified-commands-only discipline; <300-line root budget; progressive disclosure via imports; nested files for monorepos.
- `agentify-repo` — the revamp playbook: .claude/settings.json permissions, format/lint hooks, fast deterministic test lane, .claude/skills scaffold, PR conventions for agent-authored changes, sandbox notes.

**Family S — SDLC discipline (curated from Superpowers / Anthropic / Boris Cherny / HumanLayer / Every)**
- `brainstorm-first`, `write-plan`, `execute-plan`, `tdd-loop`, `review-rubric`, `debug-systematically`, `ship-clean` (commit/PR hygiene), `parallel-agents` (subagent orchestration patterns).

**Family P — principles**
- `ai-led-engineering` — the distilled Karpathy-et-al. operating principles as a reference skill (autonomy slider, short leash, small verifiable diffs, context curation).

**Company overlay (separate private repo)**
- Internal-architecture overlay skills layer on top of this generic core; kept out of the public repo by design.

## Curation pipeline (per skill)
source material → extract principles → rewrite imperative + minimal (≤200 lines/SKILL.md, supporting refs in skill dir) → `metadata.sources: [urls]` in frontmatter + entry in docs/SOURCES.md → eval on a guinea-pig repo.

## Test plan
- `claude plugin validate` clean; smoke via `claude --plugin-dir`.
- Guinea pigs: internal repos with and without existing context files (tracked privately).
- Codex: add local marketplace, run the same skills via ChatGPT-app Codex on the same guinea pig; acceptance = skill fires and produces equivalent output in both harnesses.

## Open items (research agents in flight)
- Karpathy artifact inventory (what actually exists vs myth) → seeds Family P.
- Bundle landscape crown-jewels list → seeds Family S skill-by-skill source map.
- Codex: user-added marketplace mechanics + frontmatter tolerance for extra fields; whether Claude Code reads AGENTS.md natively yet (affects mirror-vs-symlink choice).

## Roadmap
0. ✅ Scaffold (this)  → 1. Research synthesis → SOURCES.md → 2. Author Family R (highest value: fixes the repos) → 3. Family S → 4. Overlay → 5. Dual-runtime verification pass → 6. Publish: push repo (ASK FIRST per working agreement), `/plugin marketplace add`, team rollout.

## Design deltas after research (2026-08-26, all four streams landed)
1. **AGENTS.md is canonical; CLAUDE.md is a shim.** Claude Code does NOT read AGENTS.md natively (largest open feature request, #6235). Anthropic's documented bridge: CLAUDE.md containing `@AGENTS.md` + optional Claude-specific extras (symlink as alternative; import on Windows). Our generator produces this pattern and migrates divergent copied pairs to it. Codex reads AGENTS.md natively (root→cwd, 32KiB cap).
2. **Shared skills use ONLY the 6 spec fields** (`name`, `description`, `license`, `compatibility`, `metadata`, `allowed-tools`): non-Claude runtimes reject unknown frontmatter keys. `name` must equal the directory name; description ≤1024 chars; body <500 lines; refs one level deep. If a future skill needs Claude-only frontmatter, it goes in a `skills-claude/` dir listed only in `.claude-plugin/plugin.json` (its `skills` field accepts an array).
3. **Codex install path**: primary = symlinks into `~/.codex/skills/` (the proven Superpowers pattern; Codex also reads `.agents/skills` and supports `$skill-installer`). The `.codex-plugin/` manifests stay as forward-compat for Codex's plugin/marketplace system (observed live in ~/.codex bundled marketplaces, undocumented publicly). `install.sh` wires both runtimes.
4. **Karpathy verdict**: no first-party bundle exists. The 4 rules circulating as "karpathy-skills" are Forrest Chang's (multica-ai) distillation of Karpathy's 2026-01-26 X post. We encode from the primary post and credit both. His one real skill (nanochat read-arxiv-paper) is a knowledge-ingestion pattern worth a future skill.
5. **The core tension we encode rather than resolve**: process-maximalist (Superpowers/GSD/Compound) vs process-minimalist (Steinberger "just talk to it"; Boris Cherny's vanilla setup). Aug-2026 SOTA = verification harnesses + context compaction + captured learnings, with ceremony scaled to task size. This lives in `ai-led-engineering`.
