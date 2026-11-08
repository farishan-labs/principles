#!/usr/bin/env bash
# Validate principles repo consistency.
set -euo pipefail
cd "$(dirname "$0")/.."

python3 - <<'PY'
import glob, os, re, sys

files = sorted(glob.glob("principles/P-*.md"))
ids = []
for f in files:
    text = open(f).read()
    m = re.match(r"^---\n(.*?)\n---\n", text, re.S)
    if not m:
        print("MISSING FRONTMATTER:", f); sys.exit(1)
    fm = m.group(1)
    meta = {}
    for line in fm.splitlines():
        if ":" in line:
            k, v = line.split(":", 1)
            meta[k.strip()] = v.strip()
    pid = meta.get("id", "")
    if not pid:
        print("MISSING id:", f); sys.exit(1)
    # filename should start with id
    base = os.path.basename(f)
    if not base.startswith(pid + "-"):
        print("FILENAME/ID MISMATCH:", base, pid); sys.exit(1)
    ids.append(pid)

if len(ids) != len(set(ids)):
    print("DUPLICATE IDS:", [i for i in ids if ids.count(i) > 1]); sys.exit(1)

# manifest ids
manifest_ids = []
for line in open("principles.toml"):
    m = re.match(r'^id\s*=\s*"([^"]+)"', line.strip())
    if m:
        manifest_ids.append(m.group(1))

if sorted(manifest_ids) != sorted(ids):
    print("MANIFEST/FILe MISMATCH")
    print("  manifest:", sorted(manifest_ids))
    print("  files:   ", sorted(ids))
    sys.exit(1)

# VERSION consistency
ver = open("VERSION").read().strip()
print(f"OK: {len(ids)} principles, ids unique, manifest in sync, version {ver}")
PY
