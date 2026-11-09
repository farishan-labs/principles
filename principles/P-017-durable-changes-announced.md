---
id: P-017
slug: durable-changes-announced
title: Durable changes are announced
version: 1.2.0
tags: [coordination, memory, communication]
tier: core
group: Coordination
---

# P-017 — Durable changes are announced

Any change to a durable fact (URL, service, credential location, port, tunnel,
Access app) is committed together with an inbox note to other agents and an
update to the shared memory's ground truth.

**Rationale.** Silent durable changes desync agents and machines; co-committing
the announcement keeps everyone aligned.

**Applies to.** Every tool and feature in the lab.
