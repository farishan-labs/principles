#!/usr/bin/env bash
# Validate principles repo consistency.
set -euo pipefail
cd "$(dirname "$0")/.."

python3 - <<'PY'
import glob, os, re, sys

# tomllib (3.11+) with tomli fallback (3.10)
try:
    import tomllib
except ModuleNotFoundError:
    import tomli as tomllib

files = sorted(glob.glob("principles/P-*.md"))
ids = []
file_meta = {}
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
    file_meta[pid] = meta

if len(ids) != len(set(ids)):
    print("DUPLICATE IDS:", [i for i in ids if ids.count(i) > 1]); sys.exit(1)

# parse manifest with tomllib (no hand-parsing)
with open("principles.toml", "rb") as fh:
    manifest = tomllib.load(fh)

manifest_entries = manifest.get("principle", [])
manifest_ids = [e["id"] for e in manifest_entries]
if sorted(manifest_ids) != sorted(ids):
    print("MANIFEST/FILE MISMATCH")
    print("  manifest:", sorted(manifest_ids))
    print("  files:   ", sorted(ids))
    sys.exit(1)

manifest_by_id = {e["id"]: e for e in manifest_entries}

# tier + group consistency between frontmatter and manifest
for pid in ids:
    fm_tier = file_meta[pid].get("tier", "").strip().strip('"')
    fm_group = file_meta[pid].get("group", "").strip().strip('"')
    m_entry = manifest_by_id[pid]
    m_tier = m_entry.get("tier", "")
    m_group = m_entry.get("group", "")
    if fm_tier != m_tier:
        print("TIER MISMATCH for", pid, fm_tier, m_tier); sys.exit(1)
    if fm_tier not in ("top", "core", "extended"):
        print("BAD TIER for", pid, fm_tier); sys.exit(1)
    if fm_group != m_group:
        print("GROUP MISMATCH for", pid, repr(fm_group), repr(m_group)); sys.exit(1)
    if not fm_group:
        print("MISSING group for", pid); sys.exit(1)
    # manifest file path must exist
    mf = m_entry.get("file", "")
    if mf and not os.path.exists(mf):
        print("MANIFEST FILE MISSING:", pid, mf); sys.exit(1)

top_count = sum(1 for m in file_meta.values() if m.get("tier", "").strip().strip('"') == "top")
if not (3 <= top_count <= 7):
    print("TOP TIER COUNT OUT OF RANGE:", top_count); sys.exit(1)

# version single source of truth: VERSION must match any version claim; toml has no version field now
ver = open("VERSION").read().strip()
# sanity: version looks like semver
if not re.match(r"^\d+\.\d+\.\d+$", ver):
    print("BAD VERSION:", ver); sys.exit(1)

# ensure toml meta has no 'version' key (single source of truth)
if "version" in manifest.get("meta", {}):
    print("VERSION FOUND IN principles.toml meta; remove it (VERSION is canonical)"); sys.exit(1)

print(f"OK: {len(ids)} principles ({top_count} top), ids unique, tiers+groups in sync, manifest in sync, version {ver}")
PY