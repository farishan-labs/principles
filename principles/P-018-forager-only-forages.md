---
id: P-018
slug: forager-only-forages
title: Forager only forages
version: 1.2.0
tags: [scope, forager, single-responsibility]
---

# P-018 — Forager only forages

A foraging tool discovers and catalogs sources; it never swaps, rotates, or
fails over consumers. Consumers decide how to use what was found.

**Rationale.** Keeps a discovery tool's scope small and prevents it from
becoming a hidden control plane (P-009).

**Applies to.** Every tool and feature in the lab.
