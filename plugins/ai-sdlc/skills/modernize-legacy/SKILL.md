---
name: modernize-legacy
description: Staged AI-led modernization of legacy code - assess, map, extract rules, reimagine, transform, harden - with a review gate at every stage. Use when asked to modernize, migrate, refactor, or restructure a legacy codebase or module, port to a new framework or language version, untangle a monolith, or pay down architectural debt bigger than a single refactor. Turns big-bang rewrite requests into safe strangler-fig increments backed by characterization tests.
license: MIT
metadata:
  family: readiness
  sources: "https://claude.com/plugins/code-modernization; https://github.com/obra/superpowers; https://martinfowler.com/bliki/StranglerFigApplication.html"
---

# Modernize legacy code

The failure mode of modernization is the big-bang rewrite: months of parallel work, a terrifying cutover, and behavior lost because nobody knew it was there. This pipeline exists to make the alternative mechanical: small reversible increments, each gated by review, with the system working after every step. Each stage's output feeds write-plan/execute-plan; do not skip gates to feel fast.

## 1. Assess — what is actually here

Inventory the target: size, entry points, dependency ages, dead zones (`git log` cold spots), and the honest state of test coverage — not the percentage, but "would these tests catch a behavior change?" Deliver a one-page risk map: what is load-bearing, what is decorative, what nobody understands anymore. **Gate: the owner confirms the risk map matches their fears.**

## 2. Map — boundaries and seams

Find the real module boundaries (often not the directory boundaries): what calls what, where state lives, which interfaces are narrow enough to cut along. Identify the strangler seams — places where new code can shadow old behind an interface. **Gate: seams reviewed; the increment order agreed.**

## 3. Extract rules — make the implicit explicit

Before touching code, mine its implicit contracts: quirks callers depend on, ordering assumptions, tolerated invalid inputs. Where tests are missing, write **characterization tests** — capture current behavior as golden-master assertions, bugs and all, because today's bug is often tomorrow's depended-upon feature. This is the safety net everything else hangs from. **Gate: characterization suite green against untouched code.**

## 4. Reimagine — the target, in increments

Design the target architecture, then slice it into strangler increments: each one replaces a seam-bounded slice, ships independently, and leaves old and new coexisting behind the interface. Prefer boring targets — modernization is where novelty risk compounds worst. **Gate: design brief approved (brainstorm-first output format).**

## 5. Transform — one increment at a time

Per increment: plan it (write-plan), implement against the characterization tests, keep the old path deletable-but-present until the new one has soaked, and land via the normal review gates (review-rubric, verify-done). Never widen an increment mid-flight — new discoveries go into the map, not the diff. Rollback stays one revert away at all times.

## 6. Harden — prove the delta

After the final increment: run the characterization suite one last time, then retire it in favor of intention-revealing tests; measure before/after (performance, size, dependency count); run security-review on the new surfaces; delete the old paths and their flags. **Deliverable: the before/after evidence, not the adjective "modernized".**
