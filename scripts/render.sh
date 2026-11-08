#!/usr/bin/env bash
# Render PRINCIPLES.md from principles/P-*.md (sorted by id).
set -euo pipefail
cd "$(dirname "$0")/.."

python3 - <<'PY'
import glob, os, re

files = sorted(glob.glob("principles/P-*.md"))
out = []
out.append("# Faris Han Labs — Principles")
out.append("")
out.append("Canonical source: https://github.com/farishan-labs/principles")
out.append("This file is **derived** from that repo. Do not edit by hand;")
out.append("regenerate with `scripts/render.sh`.")
out.append("")
out.append("These are non-negotiable for the Faris Han Labs. They apply to cockpit")
out.append("and to every tool built under the lab.")
out.append("")

for f in files:
    with open(f) as fh:
        text = fh.read()
    # split frontmatter
    m = re.match(r"^---\n(.*?)\n---\n(.*)$", text, re.S)
    fm, body = (m.group(1), m.group(2)) if m else ("", text)
    meta = {}
    for line in fm.splitlines():
        if ":" in line:
            k, v = line.split(":", 1)
            meta[k.strip()] = v.strip()
    pid = meta.get("id", "")
    title = meta.get("title", "")
    # body without leading title heading? keep as is but ensure heading level
    body = body.strip()
    # drop a leading H1 heading that duplicates the section title
    body = re.sub(r"^#\s+[^\n]*\n+", "", body, count=1)
    out.append(f"## {pid} — {title}")
    out.append("")
    out.append(body)
    out.append("")

with open("PRINCIPLES.md", "w") as fh:
    fh.write("\n".join(out))
print("wrote PRINCIPLES.md")
PY
