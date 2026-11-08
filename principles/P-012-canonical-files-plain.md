---
id: P-012
slug: canonical-files-plain
title: Canonical files are plain markdown/JSON
version: 1.2.0
tags: [agent, portability, canonical]
tier: core
---

# P-012 — Canonical files are plain markdown/JSON

Canonical content is plain markdown/JSON, never harness syntax. Adapters render it
into harness-specific formats.

**Rationale.** Plain formats outlive any single harness and stay diffable,
portable, and human-editable.

**Applies to.** Every tool and feature in the lab.
