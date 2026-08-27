# AGENTS.md section template

Target ≤ 200 lines total. Omit any section with nothing non-obvious to say.

```markdown
# <Repo name>

<2-3 lines: what this is, what it serves, where it runs. The elevator context an
agent cannot infer from file names alone.>

## Commands
<Only verified commands. One line each: what it does + when to use it.>
- Build: `...`
- Test (full): `...`        <runtime if notable>
- Test (single): `...`      <the selective invocation — agents need this most>
- Lint / typecheck: `...`
- Run locally: `...`

## Architecture facts you cannot derive
<Service boundaries, ports, wire-contract partners, data stores, external deps.
Facts, not narrative. Link ADRs/design docs for depth.>

## Conventions that differ from defaults
<Only deviations. House style the linter already enforces does not belong here.>

## Gotchas
<The "mistake made twice" list. Each entry: the trap + the failure it causes.
This section earns its lines with blood; keep it current, prune stale entries.>

## Etiquette
<PR flow, branch rules, review expectations, AI-disclosure policy,
never-push/never-deploy rules. The blast-radius contract.>

## Pointers
<Deeper docs, ADR index, skills for procedures, per-package AGENTS.md files.>
```
