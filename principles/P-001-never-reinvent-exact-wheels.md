---
id: P-001
slug: never-reinvent-exact-wheels
title: Never reinvent exact wheels
version: 1.0.0
tags: [reuse, composition, anti-nih]
tier: top
---

# P-001 — Never reinvent exact wheels

If a proven tool already does it, depend on it, aggregate it, or extend it.
Build only the glue and the control plane.

**Rationale.** Rebuilding an existing wheel wastes effort and inherits none of
the battle-testing. Composition over reinvention keeps the core small and the
surface area honest.

**Examples.** herdr for terminals/agents, pi for harness minimalism, opencode
for coding agents, nakama where it fits, tmux for multiplexing, SQLite for
storage.

**Applies to.** Every tool and feature in the lab.
