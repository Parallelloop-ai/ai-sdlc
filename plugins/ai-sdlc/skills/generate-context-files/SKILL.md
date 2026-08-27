---
name: generate-context-files
description: Create or refresh a repository's agent context files - a canonical AGENTS.md plus a CLAUDE.md shim - with verified commands and zero bloat. Use whenever someone asks to write, update, slim, or fix CLAUDE.md or AGENTS.md, make a repo ready for Claude Code, Codex, Cursor or other coding agents, onboard a repo for AI development, or fix drift between duplicated context files. Also use after audit-ai-readiness flags context-file problems, and for requests like "init this repo for agents" or "our agent keeps getting the build commands wrong".
license: MIT
metadata:
  family: readiness
  sources: "https://code.claude.com/docs/en/memory; https://code.claude.com/docs/en/best-practices; https://agents.md/; https://gist.github.com/yurukusa/d36197848911f025add142abefcde685"
---

# Generate context files

Produce the two files that onboard every coding agent into a repo, structured so they cannot drift apart.

## The layout (and why)

- **AGENTS.md at repo root = the canonical file.** Codex, Cursor, Copilot, Gemini CLI and the broader ecosystem read it natively.
- **CLAUDE.md = a shim**, because Claude Code reads CLAUDE.md and not AGENTS.md. Its entire body:

  ```markdown
  @AGENTS.md

  <!-- Claude-specific additions only below this line -->
  ```

  A symlink (`ln -s AGENTS.md CLAUDE.md`) is equivalent where the platform allows it; prefer the import on Windows and in repos where contributors use both OSes.
- **Never two divergent copies.** Identical-looking pairs rot silently; the import/symlink makes drift structurally impossible.
- Monorepos: keep root lean; give each major package its own AGENTS.md (+shim). Nested files load on demand when an agent works there, so they cost nothing until needed.

## Process

1. **Inventory.** Find existing AGENTS.md / CLAUDE.md / .cursorrules / copilot-instructions at all depths. If a divergent pair exists, diff it, merge the union of true content, and converge on the canonical layout. Preserve hard-won gotchas — they are the most valuable lines in the file.
2. **Mine the repo.** Package manifests and lockfiles (real commands, not guessed ones), Makefile/justfile, CI workflows (what actually gates a merge), README, existing docs/ADRs, `git log` for hot areas and recent incident-shaped commits.
3. **Verify every command by running it.** Nothing goes in the Commands section that you have not executed successfully in this session (skip genuinely destructive ones and mark them clearly). A context file that lies is worse than none — the agent will trust it over its own discovery.
4. **Draft AGENTS.md ≤ 200 lines** using the section template in [references/agents-md-template.md](references/agents-md-template.md).
5. **Apply the litmus test to every line:** "Would removing this cause an agent to make a mistake?" If not, cut it. Specifically exclude: anything derivable from the code (directory layout, dependency lists, file inventories), standard language conventions, API docs (link instead), frequently-changing facts (they rot), and platitudes ("write clean code", "be careful").
6. **Write the CLAUDE.md shim.** Claude-specific extras below the import line only if genuinely Claude-only (pointers to `.claude/rules/`, project skills, hook behavior notes).
7. **Route what does not belong.** A multi-step *procedure* (release, migration, deploy) → a skill, not a context-file section. Guidance that only applies to part of the tree → `.claude/rules/<name>.md` with a `paths:` glob so it loads only when relevant. A rule a machine could enforce → propose a hook or lint rule instead of prose.
8. **Review as code.** Context files are instructions every future agent will follow — an injection surface and a quality lever. Read the final file top to bottom once more; then show the human the diff rather than silently overwriting what a team maintains.

## Quality bar

Emphasis ("IMPORTANT") on at most one stubborn line — emphasize everything and nothing stands out. Prefer one concrete example over three abstract rules. Every gotcha states the failure it prevents, because a rule with a why survives review and a bare command does not.
