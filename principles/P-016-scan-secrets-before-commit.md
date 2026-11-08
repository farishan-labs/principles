---
id: P-016
slug: scan-secrets-before-commit
title: Scan for secrets before committing
version: 1.2.0
tags: [security, git, secrets]
tier: extended
---

# P-016 — Scan for secrets before committing

Run the secret scanner before every commit that touches shared or synced data.

**Rationale.** Automated scanning is the cheap, automatic check; humans miss
things under time pressure.

**Applies to.** Every tool and feature in the lab.
