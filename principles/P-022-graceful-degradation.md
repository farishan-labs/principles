---
id: P-022
slug: graceful-degradation
title: Degrade gracefully
version: 1.2.0
tags: [robustness, capabilities, fallback]
---

# P-022 — Degrade gracefully

When a capability (tool, MCP server, model feature) is missing, skip or fall
back rather than fail. Never assume every environment has everything.

**Rationale.** Tools run across machines with different setups; hard
dependencies on optional capabilities break portability (P-002).

**Applies to.** Every tool and feature in the lab.
