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
    base = os.path.basename(f)
    if not base.startswith(pid + "-"):
        print("FILENAME/ID MISMATCH:", base, pid); sys.exit(1)
    ids.append(pid)

if len(ids) != len(set(ids)):
    print("DUPLICATE IDS:", [i for i in ids if ids.count(i) > 1]); sys.exit(1)

manifest_ids = []
manifest_tiers = {}
cur_id = None
for line in open("principles.toml"):
    m = re.match(r'^id\s*=\s*"([^"]+)"', line.strip())
    if m:
        cur_id = m.group(1)
        manifest_ids.append(cur_id)
    m = re.match(r'^tier\s*=\s*"([^"]+)"', line.strip())
    if m and cur_id:
        manifest_tiers[cur_id] = m.group(1)

if sorted(manifest_ids) != sorted(ids):
    print("MANIFEST/FILE MISMATCH")
    print("  manifest:", sorted(manifest_ids))
    print("  files:   ", sorted(ids))
    sys.exit(1)

file_tiers = {}
for f in files:
    text = open(f).read()
    m = re.match(r"^---\n(.*?)\n---\n", text, re.S)
    fm = m.group(1)
    meta = {}
    for line in fm.splitlines():
        if ":" in line:
            k, v = line.split(":", 1)
            meta[k.strip()] = v.strip()
    file_tiers[meta["id"]] = meta.get("tier", "")

for pid in ids:
    if file_tiers.get(pid) != manifest_tiers.get(pid):
        print("TIER MISMATCH for", pid, file_tiers.get(pid), manifest_tiers.get(pid)); sys.exit(1)
    if file_tiers.get(pid) not in ("top", "core", "extended"):
        print("BAD TIER for", pid, file_tiers.get(pid)); sys.exit(1)

top_count = sum(1 for t in file_tiers.values() if t == "top")
if not (3 <= top_count <= 7):
    print("TOP TIER COUNT OUT OF RANGE:", top_count); sys.exit(1)

ver = open("VERSION").read().strip()
print(f"OK: {len(ids)} principles ({top_count} top), ids unique, tiers in sync, manifest in sync, version {ver}")
PY