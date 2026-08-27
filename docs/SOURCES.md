# Curation ledger

Every skill in this plugin is REWRITTEN, not copied. This maps each source to what we distill and where it lands. Per-skill attribution also lives in each SKILL.md `metadata.sources`. Survey date: 2026-08-26.

## Primary sources (mine these)

| Source | URL | License | What we take | Lands in |
|---|---|---|---|---|
| obra/superpowers (Jesse Vincent) | https://github.com/obra/superpowers | MIT | Process spine: brainstorm→plan→execute checkpoints; subagent-driven dev w/ two-stage review (spec compliance, then code quality); verification-before-completion gate; systematic-debugging (root-cause first); git-worktree isolation; "pressure-test skills on subagents" meta-technique | Family S: `brainstorm-first`, `write-plan`, `execute-plan`, `tdd-loop`, `review-rubric`, `debug-systematically`, `verify-done` |
| Anthropic official plugins | https://github.com/anthropics/claude-plugins-official | Apache-2.0 | code-modernization pipeline (assess→map→extract-rules→reimagine→transform→harden) = repo-revamp skeleton; feature-dev explorer→architect→reviewer trio w/ confidence-scored findings; security-guidance write-time vuln checks; claude-code-setup (analyze codebase→recommend automations); claude-md-management | Family R: `audit-ai-readiness`, `agentify-repo`; Family S: `review-rubric` |
| Every compound-engineering (Kieran Klaassen) | https://github.com/EveryInc/compound-engineering-plugin | MIT | ce-compound learning loop: write every bug/correction/review finding back into rules+docs the next run reads; tiered parallel reviewers w/ confidence gating; PR lifecycle automation (babysit, resolve-feedback); dedicated simplification pass; ~80% plan/review 20% execution inversion | Family S: `compound-learnings`, `review-rubric`, `ship-clean` |
| open-gsd/gsd-core | https://github.com/open-gsd/gsd-core | MIT | Goal-backward verification (derive required end-conditions, check each); fresh-context-per-phase subagents; persistent STATE.md/CONTEXT.md across sessions; atomic 2-3-task plans sized to half a context window. VENDOR PATTERNS ONLY — do not depend (governance/meme-coin incident; original repo archived 2026-06) | Family S: `write-plan`, `execute-plan`, `verify-done` |
| anthropics/skills + agentskills spec | https://github.com/anthropics/skills | Apache-2.0 | skill-creator authoring discipline; the Agent Skills spec (portable frontmatter core); webapp-testing verification pattern | Everywhere (authoring standard); Family R |
| affaan-m/everything-claude-code | https://github.com/affaan-m/everything-claude-code | MIT | SELECTIVELY: continuous-learning "instincts"; AgentShield idea (scan agent configs as attack surface — relevant to our own supply chain); per-language reviewer structure. ⚠️ malware clone exists in the wild; never adopt wholesale (286 skills = context bloat) | Family S: `compound-learnings`; Family R: `audit-ai-readiness` (security dimension) |
| disler (IndyDevDan) hook repos | https://github.com/disler/claude-code-hooks-mastery | MIT | Deterministic hook enforcement patterns; damage-control permission rails; observability | Family R: `agentify-repo` |
| gstack (Garry Tan) | https://github.com/garrytan/gstack | MIT | Role-persona command UX only (one command = one accountable specialist); content overlaps Superpowers | UX inspiration, no direct skill |

## Ecosystem lessons baked into our design
- **Anti-bloat**: over-installed bundles measurably degrade context (wshobson issue #93: ~404k tokens of agent descriptions; "only ~12 of 100 subagents earn their context"). → ai-sdlc stays SMALL: ~12 skills, granular, no agent zoo.
- **Supply chain**: GSD rug-pull saga + ECC malware clone → we vendor/rewrite, pin nothing external, and our marketplace lists only our own code.
- **Distribution when published**: claude-plugins-official (submission form), skills.sh (`npx skills add`), own marketplace repo.
- **Convergent spine** (all top frameworks agree): plan before code → TDD → fresh-context subagents → review gates → verification before "done". Differences are only where the human checkpoint sits.

## Pending (research in flight)
- Karpathy artifact inventory → Family P `ai-led-engineering`.
- CLAUDE.md/AGENTS.md best-practice details + portability verification → Family R `generate-context-files`.

## Karpathy + luminary corpus (verified 2026-08-26)
| Source | URL | What we take | Lands in |
|---|---|---|---|
| Karpathy Jan-2026 workflow post (PRIMARY) | https://x.com/karpathy/status/2015883857489522876 | 4 failure modes (silent assumptions, hidden tradeoffs, over-complication/defensive bloat, scope creep); prescriptions: declarative success criteria, tests-first, small verified steps, human = requirements+design+review | `ai-led-engineering`, `brainstorm-first`, `write-plan`, `review-rubric` |
| multica-ai/andrej-karpathy-skills (3rd-party distillation, MIT, ~207k stars) | https://github.com/multica-ai/andrej-karpathy-skills | The 4-rule framing (Think Before Coding / Simplicity First / Surgical Changes / Goal-Driven Execution) — credited as the popular distillation; we encode from the primary post | `ai-led-engineering` |
| nanochat read-arxiv-paper skill (Karpathy's ONE real skill) | https://github.com/karpathy/nanochat/blob/master/.claude/skills/read-arxiv-paper/SKILL.md | Knowledge-ingestion pattern: deterministic fetch/cache + repo-contextualized summary; knowledge accretes as files | future `ingest-knowledge` skill (v2) |
| Boris Cherny threads + best-practices | https://x.com/bcherny/status/2007179832300581177 | Verification = #1 lever (2-3x quality); parallel worktree sessions; CLAUDE.md as living team memory; "grill me before PR" | `verify-done`, `agentify-repo`, `compound-learnings` |
| Armin Ronacher corpus | https://lucumr.pocoo.org/tags/ai/ | Agent-legible repo design (simple explicit code, fast misuse-proof tools, logs as agent food); skills > MCP tool multiplication | `agentify-repo`, `audit-ai-readiness` |
| HumanLayer ACE-FCA + 12-factor agents | https://github.com/humanlayer/advanced-context-engineering-for-coding-agents | Research→Plan→Implement with fresh contexts + written handoffs; keep context utilization ~40-60%; specs/plans as durable state | `write-plan`, `execute-plan` |
| Mitchell Hashimoto (Ghostty AI_POLICY.md + non-trivial vibing) | https://github.com/ghostty-org/ghostty/blob/main/AI_POLICY.md | AI-contribution governance (disclosure, review gates) — dimension most bundles lack | `ship-clean`, `agentify-repo` |
| Steve Yegge (Beads) | https://steveyegge.spicytakes.org/post/2025-11-12-introducing-beads-a-coding-agent-memory-system | Plan files rot; durable tracked state the agent itself operates | `execute-plan` (plan-file discipline) |
| Geoffrey Huntley (Ralph) | https://ghuntley.com/ralph/ | Bounded autonomous loops; progress in files+git not context | noted for future autonomous lane |
| Peter Steinberger ("Just Talk To It") | https://steipete.me/posts/just-talk-to-it | The anti-ceremony pole: ceremony scaled to task size | `ai-led-engineering` |
| Simon Willison skills analysis | https://simonwillison.net/tags/skills/ | Skills-vs-MCP rationale; standardization timeline (Agent Skills → AAIF Dec-2025) | DESIGN.md rationale |
| Anthropic official docs (memory, best-practices, skills) | https://code.claude.com/docs/en/memory | <200-line target; per-line litmus test; exclude derivable content; @AGENTS.md bridge; rules-with-paths; procedures→skills; /doctor anti-bloat | `generate-context-files`, `audit-ai-readiness`, `compound-learnings` |
| Marmelab Agent Experience + Michael's Coding Spot + GitInject paper | https://marmelab.com/blog/2026/01/21/agent-experience.html | AI-ready repo consensus (fast selective tests, small files, grep-friendly names, E2E as docs); injection surface in repo files (arXiv 2606.09935) | `audit-ai-readiness`, `agentify-repo` |
