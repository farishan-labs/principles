# Changelog

All notable changes to the Faris Han Labs principles set are documented here.
Versioning follows [SemVer](https://semver.org/): MAJOR for rewording/removal
that breaks downstream consumers, MINOR for additions, PATCH for clarifications.

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
