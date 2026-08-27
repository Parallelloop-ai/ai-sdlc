---
name: ai-led-engineering
description: Core operating principles for AI-led software development, distilled from primary sources - Karpathy's workflow notes, Boris Cherny, Armin Ronacher, HumanLayer, and the 2026 practitioner consensus. Use at the start of any substantial agent-led coding effort, when deciding how much process a task deserves, when an agent is over-engineering, scope-creeping, or assuming silently, when someone asks for the Karpathy rules or AI coding principles, or when a team is defining how humans and coding agents should collaborate.
license: MIT
metadata:
  family: principles
  sources: "https://x.com/karpathy/status/2015883857489522876; https://github.com/multica-ai/andrej-karpathy-skills; https://x.com/bcherny/status/2007179832300581177; https://lucumr.pocoo.org/tags/ai/; https://github.com/humanlayer/advanced-context-engineering-for-coding-agents; https://steipete.me/posts/just-talk-to-it"
---

# AI-led engineering

Operating principles for working as (or with) a coding agent. These are distilled from primary practitioner sources; the four behavioral rules originate in Andrej Karpathy's January 2026 workflow notes (popularized as the "karpathy-skills" file by Forrest Chang).

## The four behavioral rules

1. **Think before coding.** State your assumptions out loud; ask when the requirement is genuinely ambiguous; push back once, with reasons, when the request conflicts with what you can see. The worst failure is building the wrong thing correctly on a silent guess.
2. **Simplicity first.** Write the code a strong senior would call minimal: no single-use abstractions, no speculative configurability, no defensive handling of impossible states. Generated code trends 2-10x bigger than needed; treat deletion as a feature. If simple and clever tie, simple wins — the next reader is an agent with no context.
3. **Surgical changes.** Touch only what the task requires. Match the surrounding style even where you disagree. No drive-by refactors, comment deletions, or "improvements" nobody asked for — every unrequested change is review burden and regression surface.
4. **Goal-driven execution.** Convert every task into verifiable success criteria before starting, then loop against them. Declarative beats imperative: "make this command exit 0" outlives any list of steps. Done means criteria checked with fresh evidence, not effort expended.

## The three structural levers

- **Verification is the #1 lever.** A way to check work — tests, build, a screenshot harness, a simulator — is worth 2-3x on final quality, more than any prompt or model choice. If no check exists, building one is usually the first task. Evidence over assertion, always.
- **Context is a budget, files are memory.** Recall degrades as the window fills; keep utilization moderate and split large work into research → plan → implement with fresh context per phase, handing off through written artifacts (briefs, plan files). What matters gets written down; scrollback is not state.
- **Compound every lesson.** Corrections, review findings, and debugging discoveries get routed into the repo (context files, rules, skills, lint rules) so the next run starts smarter. Teams that skip this pay for the same lesson forever.

## Calibration

- **Scale ceremony to blast radius and novelty, not habit.** The field's poles are both right: full brainstorm→plan→TDD→review for novel, shared, or stateful work; "just talk to it" for throwaway scripts and well-trodden changes. Ceremony on a typo fix costs more than the fix; skipping process on a migration costs a weekend.
- **Know where agents are weak.** Genuinely novel code (no training-set precedent), long unattended runs, and taste calls. Keep the leash short there — smaller steps, more checkpoints — and long where the ground is well-trodden. The human's enduring jobs: requirements, high-level design, and review.
- **Make the repo agent-legible.** Simple explicit code, fast misuse-resistant tooling, greppable names, current context files. When agents underperform somewhere chronically, the repo is usually the bug — fix the environment before blaming the model.
