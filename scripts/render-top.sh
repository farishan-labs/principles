#!/usr/bin/env bash
# Render TOP_PRINCIPLES.md from tier=top principles.
set -euo pipefail
cd "$(dirname "$0")/.."

python3 - <<'PY'
import glob, os, re

files = sorted(glob.glob("principles/P-*.md"))

# stable group order (themes). New groups append alphabetically at the end.
GROUP_ORDER = [
    "Reuse & research",
    "Portability & lock-in",
    "Minimalism & scope",
    "Distribution",
    "Reliability & control",
    "Security",
    "Coordination",
    "Agent capabilities",
    "Auth & consent",
    "CLI",
]

principles = {}
for f in files:
    text = open(f).read()
    m = re.match(r"^---\n(.*?)\n---\n(.*)$", text, re.S)
    fm, body = (m.group(1), m.group(2)) if m else ("", text)
    meta = {}
    for line in fm.splitlines():
        if ":" in line:
            k, v = line.split(":", 1)
            meta[k.strip()] = v.strip().strip('"')
    body = body.strip()
    body = re.sub(r"^#\s+[^\n]*\n+", "", body, count=1).strip()
    first_para = body.split("\n\n", 1)[0].replace("\n", " ").strip()
    pid = meta.get("id", "")
    principles[pid] = {
        "id": pid,
        "title": meta.get("title", ""),
        "tier": meta.get("tier", ""),
        "group": meta.get("group", ""),
        "one_liner": first_para,
    }

top = [p for p in principles.values() if p["tier"] == "top"]
top.sort(key=lambda x: x["id"])
total = len(principles)

# group index derived from files (no hardcoded id lists)
groups_map = {}
for p in principles.values():
    groups_map.setdefault(p["group"], []).append(p["id"])
for g in groups_map:
    groups_map[g].sort()

ordered_groups = [g for g in GROUP_ORDER if g in groups_map]
for g in sorted(groups_map):
    if g not in ordered_groups:
        ordered_groups.append(g)

out = []
out.append("# Faris Han Labs — Top Principles")
out.append("")
out.append("Canonical source: https://github.com/farishan-labs/principles")
out.append("This file is **derived**. Regenerate with `scripts/render-top.sh`.")
out.append(f"Full set ({total} principles): see `PRINCIPLES.md`.")
out.append("")
out.append("> The non-negotiables. The top-tier principles that govern everything built under")
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
for name in ordered_groups:
    ids = groups_map[name]
    items = [f"{pid} ({principles[pid]['title']})" for pid in ids]
    out.append(f"- **{name}:** " + ", ".join(items))
out.append("")

out.append("## Optional (secondary)")
out.append("")
out.append("- Full rationale, examples, applies-to: `PRINCIPLES.md`")
out.append("- Machine-readable index (ids, titles, tags, tiers, groups, files): `principles.toml`")
out.append("- Change history: `CHANGELOG.md`")
out.append("- Validation: `scripts/validate.sh`")
out.append("")

with open("TOP_PRINCIPLES.md", "w") as fh:
    fh.write("\n".join(out))
print(f"wrote TOP_PRINCIPLES.md ({len(top)} top, {total} total)")
PY