---
id: P-024
slug: single-source-no-drift
title: Single source, no drift
version: 1.0.0
tags: [docs, single-source, drift, derived-files]
tier: core
group: Documentation & drift
---

# P-024 — Single source, no drift

Derived copies of a document drift. Prefer a single canonical source and
link to it; if a copy is unavoidable, regenerate it automatically or
remove it. Never maintain parallel hand-edited versions of the same content.

**Rationale.** Parallel copies diverge silently, producing conflicting
guidance and wasted reconciliation effort. One source (or generated output)
keeps truth singular.

**Applies to.** Docs, READMEs, derived principle files, generated configs.