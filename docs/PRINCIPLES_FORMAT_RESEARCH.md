# Research: Best format for top-most principles (human + AI review)

Date: 2026-11-08
Repo: farishan-labs/principles
Status: research complete; recommendation ready for implementation.

## 1. Problem

The principles set now holds 22 principles (P-001..P-022). The rendered
`PRINCIPLES.md` is ~236 lines / ~8 KB. That is too much for a human to
review at a glance, and it forces an AI agent to load the entire set into
context before it can decide what matters most.

We need a **top-most tier**: a small, curated subset of the most overarching
principles, in a format that is fast for a human to scan and cheap for an
agent to load, while staying machine-parseable and versioned like the rest.

## 2. What "top-most" means

Not "most important to read first" only. A top-most principle is one that:

- is overarching (it constrains decisions across the whole lab, not one tool);
- is non-negotiable in the strongest sense (conflicts are resolved in its
  favour);
- is stable (changes rarely; a change is a MINOR+ bump);
- subsumes or motivates several lower principles.

The cockpit README already designates six of these as "The big ones":
P-001, P-002, P-003, P-004, P-005, P-006. That is the seed set.

## 3. Survey of existing formats

### 3.1 Anthropic — Claude's Constitution
- Structure: a 4-item numbered list of core values at the very top
  (Broadly safe, Broadly ethical, Compliant with guidelines, Genuinely
  helpful), each one line, ordered by priority. Then long sections.
- Stated audience: "written with Claude as its primary audience... optimized
  for precision over accessibility."
- Takeaway: a short, ordered, priority-ranked summary block at the top;
  details follow. Precision over prose for the AI reader.

### 3.2 OpenAI — Model Spec
- Structure: "Red-line principles" (top-most, non-overridable) + "General
  principles" + specific risks + detailed instructions, each tagged with an
  authority level (Root/System/Developer/User/Guideline).
- Takeaway: explicit tiering with a named top tier ("red-line") that is
  small and absolute; lower tiers are overridable. Authority levels are
  machine-readable tags.

### 3.3 Google — AI Principles
- Structure: 3 top-level principles, each with 4 numbered sub-points.
  Two-level hierarchy, short.
- Takeaway: 3-7 top items, each expandable to a few sub-points. Fits on
  one screen.

### 3.4 llms.txt (llmstxt.org)
- Structure: H1 title, blockquote one-line summary, free-form detail, then
  H2 "file lists" of links, with an "Optional" section for secondary info.
- Purpose: a small curated overview that fits in a context window; detail
  lives behind links and is fetched only when needed.
- Takeaway: the "Optional" convention and the "small enough to fit in
  context, detail behind links" rule are directly applicable.

### 3.5 12-Factor App
- Structure: 12 numbered factors, each a short title + one short paragraph
  + a dedicated page. One principle per short page.
- Takeaway: one principle per file already matches our layout; the top tier
  should be a single short page/card, not the whole set.

### 3.6 ADR (MADR) / RFC 2119
- ADR: status, context, decision, consequences — good for *decisions*, not
  for standing principles.
- RFC 2119 keywords (MUST/SHOULD/MAY): give AI an unambiguous
  interpretation of normative strength.
- Takeaway: use imperative normative verbs (Never/Always/Must) — already
  our style. Add an explicit "normative strength" only where needed.

### 3.7 Cockpit README "The big ones"
- Already a 5-bullet (6-principle) short list. Confirms the seed set and
  the "bullets, one line each" shape that humans already accept.

## 4. Properties a good top-most format must have

For humans:
- Scannable in under 30 seconds (one screen).
- Each item one line: ID + title + one sentence.
- Clear that it is a subset, with a pointer to the full set.

For AI agents:
- Small enough to always fit in context (target < 2 KB / ~500 tokens).
- Stable IDs so consumers key on id (already our rule).
- Machine-parseable (frontmatter/manifest), not free prose only.
- Explicit "optional/secondary" section so an agent knows what it may skip.
- Normative strength clear (imperative wording).

For the repo/process:
- Derived, not hand-edited (like PRINCIPLES.md).
- Validated (count, uniqueness, tier consistency).
- Versioned (bump VERSION + CHANGELOG + tag).

## 5. Recommendation

Adopt a **three-tier model** with a dedicated top file:

- **Tier 0 — Top (red-line):** 6 principles (P-001..P-006), the "big ones".
  Rendered as `TOP_PRINCIPLES.md` (llms.txt-shaped: H1, blockquote
  summary, numbered one-line items, "All principles by group", "Optional").
- **Tier 1 — Core:** the remaining general principles (P-007..P-010,
  P-012..P-014, P-017, P-020, P-022, ...), i.e. the standing rules.
- **Tier 2 — Extended/specialised:** tool- or domain-specific ones
  (P-015, P-016, P-018, P-019, P-021, ...).

Implementation details:

1. Add a `tier` field to each principle's frontmatter and to `principles.toml`
   (`top` | `core` | `extended`). Single source of truth stays the manifest.
2. Add `scripts/render-top.sh` producing `TOP_PRINCIPLES.md` from tier=top
   entries, using each principle's first paragraph as the one-liner.
3. Group the "All principles" index by theme (reuse, portability,
   minimalism, distribution, reliability/control, security, coordination,
   agent, auth, cli) — derived from tags, not hand-maintained where possible.
4. Extend `validate.sh`: tier values allowed; top count between 3 and 7;
   every principle has a tier; manifest/frontmatter tier agree.
5. Bump VERSION 1.2.0 -> 1.3.0, CHANGELOG entry, tag v1.3.0.
6. Propagate to cockpit: update `scripts/sync-principles.sh` to also render
   and copy `TOP_PRINCIPLES.md`; cockpit README "The big ones" already
   matches.

## 6. Why not alternatives

- Keeping everything in one file with a "Top" section: an agent loading the
  file still pays for 22 principles. Separate file keeps the top tier cheap.
- A JSON-only top file: less readable for humans; markdown + manifest
  (already our pattern) serves both.
- Re-ranking by tags automatically: tags are too noisy to define "top";
  top is a curated, stable designation (like red-line). Keep it explicit.

## 7. Open questions

- Should top-tier principles also carry RFC 2119 strength (MUST/SHOULD)?
  Current wording is already imperative ("Never", "Keep"). Recommend: keep
  imperative prose; add strength only if a principle is genuinely advisory.
- Should cockpit ingest TOP_PRINCIPLES.md into AGENTS.md automatically?
  Recommend yes, as a short "Top principles" block, but that is a cockpit-side
  change; out of scope for this repo's first pass.
