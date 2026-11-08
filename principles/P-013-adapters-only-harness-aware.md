---
id: P-013
slug: adapters-only-harness-aware
title: Adapters are the only harness-aware code
version: 1.2.0
tags: [agent, adapters, separation]
---

# P-013 — Adapters are the only harness-aware code

Core logic stays harness-agnostic; only adapters know about a specific harness's
config, tool names, or extensions.

**Rationale.** Keeps the core portable and lets new harnesses be added without
touching shared logic.

**Applies to.** Every tool and feature in the lab.
