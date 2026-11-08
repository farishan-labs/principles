---
id: P-004
slug: programmable-extensions
title: Programmable extensions, not toggles
version: 1.0.0
tags: [extensions, programmability, manifests]
---

# P-004 — Programmable extensions, not toggles

Extensions are code with a manifest and hook points. The agent can author them
("software that builds itself"). Configuration toggles are not extensions.

**Rationale.** Toggles cap capability at what the author anticipated.
Programmable extensions let users and agents grow the tool without core
changes.

**Applies to.** Every tool and feature in the lab.
