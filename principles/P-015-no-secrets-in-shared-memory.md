---
id: P-015
slug: no-secrets-in-shared-memory
title: Never store secrets in shared memory
version: 1.2.0
tags: [security, memory, secrets]
tier: extended
---

# P-015 — Never store secrets in shared memory

Shared memory holds only non-sensitive facts. API keys, tokens, passwords,
private keys, session cookies, and sensitive personal/financial data are never
stored; scan before committing.

**Rationale.** Shared memory is synced across machines and agents; a leak there
is a leak everywhere.

**Applies to.** Every tool and feature in the lab.
