#!/usr/bin/env bash
# Render TOP_PRINCIPLES.md from tier=top principles.
set -euo pipefail
cd "$(dirname "$0")/.."

python3 - <<'PY'
import glob, os, re

files = sorted(glob.glob("principles/P-*.md"))
# group map for the index (theme -> list of ids)
groups = [
    ("Reuse & research", ["P-001", "P-007", "P-011", "P-021"]),
    ("Portability & lock-in", ["P-002", "P-012", "P-013", "P-022"]),
    ("Minimalism & scope", ["P-003", "P-004", "P-009", "P-018"]),
    ("Distribution", ["P-005", "P-006"]),
    ("Reliability & control", ["P-008", "P-010"]),
    ("Security", ["P-015", "P-016"]),
    ("Coordination", ["P-017"]),
    ("Agent capabilities", ["P-014"]),
    ("Auth & consent", ["P-019"]),
    ("CLI", ["P-020"]),
]

# load all principles
principles = {}
for f in files:
    text = open(f).read()
    m = re.match(r"^---\n(.*?)\n---\n(.*)$", text, re.S)
    fm, body = (m.group(1), m.group(2)) if m else ("", text)
    meta = {}
    for line in fm.splitlines():
        if ":" in line:
            k, v = line.split(":", 1)
            meta[k.strip()] = v.strip()
    # tags may be list-like; keep raw
    body = body.strip()
    body = re.sub(r"^#\s+[^\n]*\n+", "", body, count=1).strip()
    # first paragraph = one-liner statement
    first_para = body.split("\n\n", 1)[0].replace("\n", " ").strip()
    principles[meta["id"]] = {
        "id": meta["id"],
        "title": meta.get("title", "").strip('"'),
        "tier": meta.get("tier", ""),
        "one_liner": first_para,
    }

top = [p for p in principles.values() if p["tier"] == "top"]
top.sort(key=lambda x: x["id"])

out = []
out.append("# Faris Han Labs — Top Principles")
out.append("")
out.append("Canonical source: https://github.com/farishan-labs/principles")
out.append("This file is **derived**. Regenerate with `scripts/render-top.sh`.")
out.append("Full set (22 principles): see `PRINCIPLES.md`.")
out.append("")
out.append("> The non-negotiables. Six principles that govern everything built under")
out.append("> the lab. If a decision conflicts with one of these, the principle wins.")
out.append("> Load this file first; reach for `PRINCIPLES.md` only when you need")
out.append("> rationale, examples, or the specialised rules.")
out.append("")

out.append("## Top principles")
out.append("")
for i, p in enumerate(top, 1):
    out.append(f"{i}. **{p['id']} — {p['title']}.** {p['one_liner']}")
out.append("")

out.append("## All principles by group")
out.append("")
for name, ids in groups:
    items = [f"{pid} ({principles[pid]['title']})" for pid in ids if pid in principles]
    if items:
        out.append(f"- **{name}:** " + ", ".join(items))
out.append("")

out.append("## Optional (secondary)")
out.append("")
out.append("- Full rationale, examples, applies-to: `PRINCIPLES.md`")
out.append("- Machine-readable index (ids, titles, tags, tiers, files): `principles.toml`")
out.append("- Change history: `CHANGELOG.md`")
out.append("- Validation: `scripts/validate.sh`")
out.append("")

with open("TOP_PRINCIPLES.md", "w") as fh:
    fh.write("\n".join(out))
print("wrote TOP_PRINCIPLES.md")
PY