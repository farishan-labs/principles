## Scope

Canonical principles for Faris Han Labs. Source of truth for every tool built
under the lab (cockpit, and others). Docs only — no code beyond render/validate
helpers.

## Rules

- Each principle has a unique id (`P-NNN`) and a dedicated file under
  `principles/`.
- `principles.toml` is the manifest; keep it in sync with the files.
- Never edit a derived copy (e.g. cockpit/PRINCIPLES.md) by hand; regenerate
  from this repo.
- Bump `VERSION` + add a `CHANGELOG.md` entry + git tag for any change to the
  set of principles or their wording that affects downstream consumers.
- Keep principles short, actionable, and non-negotiable in tone.
