---
id: P-020
slug: cli-conventions
title: CLIs follow open conventions
version: 1.2.0
tags: [cli, conventions, ux]
tier: core
---

# P-020 — CLIs follow open conventions

Command-line tools follow open conventions: POSIX/GNU option syntax, XDG base
directories, `NO_COLOR`/`TERM=dumb`/TTY-aware color, stdout for data and
stderr for messaging, standard exit codes (0 success, 2 usage error), and
machine-readable output via `--json`/`--plain`.

**Rationale.** Predictable CLIs compose with other tools and scripts; ad hoc
conventions break pipelines.

**Applies to.** Every tool and feature in the lab.
