---
name: brainstorm-first
description: Socratic requirements exploration before writing any code. Use when starting a new feature, project, or design, when a request is ambiguous or underspecified, when someone asks to brainstorm, spec, or think through an approach, or before write-plan on anything non-trivial. Extracts requirements one question at a time, surfaces hidden assumptions and tradeoffs, and ends with a short approved design brief with verifiable success criteria.
license: MIT
metadata:
  family: sdlc
  sources: "https://github.com/obra/superpowers; https://x.com/karpathy/status/2015883857489522876; https://github.com/humanlayer/advanced-context-engineering-for-coding-agents"
---

# Brainstorm first

The top agent failure mode is proceeding on wrong silent assumptions — building the wrong thing correctly. A bad line of understanding here becomes thousands of bad lines of code later, so this stage has the highest leverage per minute of any in the lifecycle.

## Process

1. **Understand what exists before asking anything.** Read the relevant code, docs, and recent history first. Questions that the repo already answers waste the human's attention and spend your credibility.
2. **Ask one question at a time.** A wall of six questions gets one lazy answer. Prefer concrete options over open prompts ("cursor-based or offset pagination?" beats "how should pagination work?"), because options expose the tradeoff you are actually asking about.
3. **Surface assumptions and inconsistencies out loud.** State what you are assuming and invite correction. If the request conflicts with something in the codebase, or two requirements pull against each other, say so now — hiding a tradeoff to seem agreeable is how sycophancy ships bugs. Push back when warranted: once, clearly, with reasons, then defer.
4. **Explore 2-3 genuinely different approaches** with honest costs, and recommend one. If a boring, well-trodden approach fits, prefer it — novelty is where agents are weakest.
5. **Write the brief.** End with a short design brief and get explicit approval before any planning or code:

```markdown
## Design brief: <name>
**Problem** — one paragraph, in the user's terms.
**Approach** — the chosen path and the one-line reason it beat the alternatives.
**Success criteria** — 3-7 verifiable statements (each checkable by a command,
a test, or observable behavior — not "works well").
**Non-goals** — what this deliberately does not do.
**Risks / open questions** — what could invalidate the approach.
```

## Scale it

Trivial or fully-specified task: skip the ceremony — restate the task in one sentence with one clarifying question if needed, and go. The skill is for ambiguity, not ritual.
