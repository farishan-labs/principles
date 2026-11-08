# Faris Han Labs — Principles

Canonical, versioned principles for the Faris Han Labs. Source of truth for
cockpit and every tool built under the lab.

## What's here

- `principles/P-NNN-*.md` — one file per principle, each uniquely identified
  by `id` (`P-001`..) and `slug`. Each carries a `tier` (`top`/`core`/`extended`).
- `principles.toml` — machine-readable manifest (ids, titles, tags, tiers, files).
- `TOP_PRINCIPLES.md` — derived top-tier view (6 principles, one line each;
  regenerate via `scripts/render-top.sh`). Load this first.
- `PRINCIPLES.md` — rendered combined view of all 22 (derived; regenerate via
  `scripts/render.sh`).
- `VERSION` — current semver of the principles set.
- `CHANGELOG.md` — history of changes.
- `scripts/validate.sh` — consistency check (unique ids, tiers, manifest sync).
- `scripts/render.sh` — regenerate `PRINCIPLES.md`.
- `scripts/render-top.sh` — regenerate `TOP_PRINCIPLES.md`.
- `docs/PRINCIPLES_FORMAT_RESEARCH.md` — research on top-most principles format.

## Tiers

Each principle carries a `tier`: `top` (6 overarching, non-negotiable),
`core` (standing rules), or `extended` (domain/specialised). Consumers that
need a cheap, always-loadable view should use `TOP_PRINCIPLES.md`.

## Unique identification

Each principle has a stable id `P-NNN` (e.g. `P-001`) and a slug
(`never-reinvent-exact-wheels`). IDs are never reused; removed principles keep
their id reserved. Consumers should key on `id`, not position or title.

## Versioning

SemVer over the principles set. Bump `VERSION`, append to `CHANGELOG.md`, and
tag (`vX.Y.Z`) for any change. Downstream repos (cockpit) pin a tag via git
submodule or a recorded version.

## Consuming

Cockpit derives its `PRINCIPLES.md` from this repo. To sync:

```sh
# from cockpit repo
git submodule update --init --recursive   # first time
./scripts/sync-principles.sh
```

## License

Apache-2.0. See `LICENSE`.
