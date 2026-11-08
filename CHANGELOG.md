# Changelog

All notable changes to the Faris Han Labs principles set are documented here.
Versioning follows [SemVer](https://semver.org/): MAJOR for rewording/removal
that breaks downstream consumers, MINOR for additions, PATCH for clarifications.

## [1.3.0] - 2026-11-08

### Added
- Three-tier model (top / core / extended) for principles, with a `tier` field
  in frontmatter and manifest.
- `TOP_PRINCIPLES.md`: derived, llms.txt-shaped view of the 6 top-tier
  principles, one line each, plus a grouped index of all 22 and an Optional
  section. Target < 2 KB for cheap agent loading.
- `scripts/render-top.sh`: regenerates `TOP_PRINCIPLES.md`.
- `docs/PRINCIPLES_FORMAT_RESEARCH.md`: research on best format for top-most
  principles for human + AI review.

### Changed
- `scripts/validate.sh` now checks tier values, tier consistency between
  frontmatter and manifest, and top-tier count (3-7).

## [1.2.0] - 2026-11-08

### Added
- P-012..P-022: consolidated related principles from farishan-labs org repos
  (agent, agent-shared-memory, forager, cli, cockpit) — canonical files plain,
  adapters-only harness-aware, skills declare capabilities, no secrets in shared
  memory, scan secrets before commit, durable changes announced, forager only
  forages, manual keys no signup, CLI conventions, research gate before code,
  graceful degradation.

## [1.1.0] - 2026-11-08

### Added
- P-011 — Research before creating a new repo (research gate / graduation rule).

## [1.0.0] - 2026-11-08

### Added
- Initial canonical set of 10 lab principles (P-001..P-010), extracted from
  `farishan-labs/cockpit` PRINCIPLES.md.
- Machine-readable manifest `principles.toml`.
- Per-principle files under `principles/`.
- Render helper `scripts/render.sh` producing `PRINCIPLES.md`.
