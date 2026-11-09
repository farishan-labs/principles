---
id: P-014
slug: skills-declare-capabilities
title: Skills declare their capabilities
version: 1.2.0
tags: [agent, skills, capabilities]
tier: core
group: Agent capabilities
---

# P-014 — Skills declare their capabilities

Skills keep their markdown body but gain frontmatter declaring `requires`,
`optional`, and `min-context`. Adapters skip or fall back when a requirement
is missing.

**Rationale.** Makes skill portability explicit and lets runtimes degrade
gracefully instead of failing at call time.

**Applies to.** Every tool and feature in the lab.
