# FHL Licensing Guideline

Version: 1.0 (draft)
Applies to: all Faris Han Labs repos, products, and content.
Source of truth: `farishan-labs/principles` (P-006, P-023).

## 1. Goals

1. Keep the lab's software **open and self-hostable** (P-002, P-006).
2. Protect the commons with **copyleft by default** so derivatives stay open.
3. Let **companies pay (a lot)** for the right to use FHL code in proprietary
   products without sharing source.
4. Attract sponsors/contributors where permissive terms help.
5. Keep paid product assets monetizable (no redistribution).

## 2. Default rules

- **Software (community edition): GPL-3.0.** Default for all new repos unless
  an exception below applies.
- **Sponsor-attracting building blocks: Apache-2.0.** Use when the goal is
  broad adoption, corporate contribution, or embedding in proprietary stacks
  (e.g. design tokens, UI primitives, shared libs).
- **Paid/commercial edition: commercial license.** Buyers receive a commercial
  license (Apache-2.0 or proprietary, per product) that permits proprietary
  use without copyleft.
- **No closed-by-default repos.** Monetization is via dual licensing and paid
  assets, not by hiding the core (P-006).

## 3. Dual-licensing model

FHL may release the **same codebase** under two (or more) licenses:

- **Community edition — GPL-3.0.** Free to use, modify, and redistribute,
  provided derivatives are also GPL-3.0 and source is shared.
- **Commercial edition — Apache-2.0 or proprietary.** Sold via Gumroad (or
  direct) to customers who need to embed FHL code in proprietary products
  without copyleft. Price should reflect that value ("a lot").

### 3.1 Derivative works and "separate files"

- You **can** dual-license **your own copyright**. If you wrote the code, you
  may offer it under GPL (free) and Apache/commercial (paid) at the same time.
- You **cannot** relicense third-party GPL code. If a repo incorporates
  third-party GPL code, the combined work must remain GPL unless you obtain
  permission or remove/replace that code.
- Putting code in "separate files" does **not** by itself escape copyleft. It
  depends on whether the new code is a derivative work (linking, subclassing,
  shared data structures, etc.). When in doubt, treat it as derivative.
- Clean-room reimplementation or genuinely independent modules may be
  licensed separately (e.g. Apache-2.0) even if they interoperate with a
  GPL core.

### 3.2 Current repo assignments

| Repo | Community license |
|---|---|
| `providers` | GPL-3.0 |
| `design-tokens` | GPL-3.0 |
| `ui` | GPL-3.0 |
| `web-components` | GPL-3.0 |
| `workflow-kit` (core) | GPL-3.0 |
| `workflow-kit` Pro pack assets | Commercial (paid) |
| Paid Gumroad products | Commercial (paid, all rights reserved) |

### 3.3 Choosing per repo

Use these criteria to decide per repo (document the choice in `LICENSE` and
`README`):

| Prefer GPL-3.0 when... | Prefer Apache-2.0 when... |
|---|---|
| You don't want competitors embedding it proprietarily. | You want corporate sponsors/contributors. |
| It's an end-user tool or app. | It's a library/building block. |
| You plan to sell a commercial license. | You want maximum adoption. |
| Derivatives should stay open. | Patent grant matters. |

Paid products are always sold with a commercial license regardless of the
community edition's license.

## 4. Product and content terms

For Gumroad digital products (OPC kits, prompts, templates, Pro packs):

- **License: All rights reserved + personal/commercial use, no redistribution.**
  Buyers may use the assets in their own projects (including client work).
  They may not redistribute, resell, or sublicense the files.
- **Core code (where applicable) stays OSS** under its repo license (GPL or
  Apache). The paid product covers polished assets, support, and the
  commercial license.
- **Refunds, seats, update windows** follow the product page (default: 14-day
  refund, 12 months updates, seat counts per tier).

## 5. Enforcement

- **Honor system + Gumroad license key in the zip.** No DRM or hard gating
  in v0. License key is for support/attribution, not activation.
- Report violations politely; reserve the right to add gating later.

## 6. Provenance (contributors)

- **DCO recommended, not required.** GitHub does not auto-detect DCO; sign-off
  is optional unless a repo opts in. Repos that opt in require
  `Signed-off-by` on commits (or a DCO bot check).
- GitHub's built-in "Verified" commits (GPG signing) are an acceptable
  alternative signal of provenance.
- Apache repos: DCO recommended; CLA optional if commercial dual-licensing
  needs stronger IP control.
- No formal CLA is required by default (keep friction low).

## 7. Trademark

- The "Faris Han Labs" / "FHL" name and logo are **not** licensed by the
  code/content licenses. They may not be used to imply endorsement without
  permission. Attribution is optional but appreciated.

## 8. Exceptions and changes

- Any repo or product that deviates from this guideline must document the
  deviation in its `LICENSE` and `README`.
- Changes to this guideline require a principles version bump (MAJOR for
  breaking changes) and a changelog entry.

## 9. Disclaimer

This guideline is an engineering policy, not legal advice. Have counsel
review before relying on it for enforcement or high-value licensing deals.