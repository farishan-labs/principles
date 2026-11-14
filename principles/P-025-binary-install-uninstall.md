---
id: P-025
slug: binary-install-uninstall
title: Binaries ship install/uninstall targets
version: 1.0.0
tags: [cli, distribution, install, uninstall]
tier: core
group: Distribution
---

# P-025 — Binaries ship install/uninstall targets

Every executable produced by the lab (binary, script, or tray indicator)
ships an easy install and uninstall path: a `Makefile` with `install` and
`uninstall` targets (or equivalent documented commands) that place the
artifact in `~/.local/bin` and remove it cleanly. Install must be
idempotent (`cp -f`); uninstall must remove only the artifact, never user
data.

Binaries that are meant to run in the background (tray indicators,
daemons) must daemonize themselves so invoking them returns immediately.

**Rationale.** Consistent install/uninstall keeps machines clean and makes
tools trivially removable; foreground-by-default background tools block
terminals and break autostart.

**Applies to.** Every tool and feature in the lab.
