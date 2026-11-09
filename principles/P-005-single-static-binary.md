---
id: P-005
slug: single-static-binary
title: Single static binary
version: 1.0.0
tags: [distribution, go, no-cgo, no-runtime-deps]
tier: top
group: Distribution
---

# P-005 — Single static binary

One file to install. Go, no CGO, no runtime deps.

**Rationale.** A single static binary removes install friction and makes the
tool trivially portable across machines and CI.

**Applies to.** Every tool and feature in the lab.
