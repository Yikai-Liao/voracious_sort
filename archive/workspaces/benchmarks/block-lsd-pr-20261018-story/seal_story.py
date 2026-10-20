#!/usr/bin/env python3
"""Seal this version without changing the earlier immutable benchmark bundle."""
import argparse
import hashlib
import json
from pathlib import Path
import time

ROOT=Path(__file__).resolve().parent
SKIP={".git",".venv","target","__pycache__"}


def sha(path):
    result=hashlib.sha256()
    with path.open("rb") as stream:
        for part in iter(lambda:stream.read(1024*1024),b""):result.update(part)
    return result.hexdigest()


def included():
    return sorted(path for path in ROOT.rglob("*") if path.is_file() and not SKIP.intersection(path.relative_to(ROOT).parts)
                  and path.name!="SHA256SUMS")


def main():
    parser=argparse.ArgumentParser();parser.add_argument("--verify",action="store_true")
    if parser.parse_args().verify:
        seen=set()
        for line in (ROOT/"SHA256SUMS").read_text().splitlines():
            digest,name=line.split("  ",1);assert name not in seen;seen.add(name)
            assert sha(ROOT/name)==digest,name
        assert seen=={str(path.relative_to(ROOT)) for path in included()}
        print(f"Verified {len(seen)} sealed files");return
    audit=json.loads((ROOT/"data/reuse-audit.json").read_text())
    assert audit["input_conditions"]==1045 and audit["missing_only_time_observations"]==768 and audit["missing_only_memory_observations"]==630
    assert audit["all_candidate_outputs_match"] and audit["all_candidate_heap_measurements_within_bound"]
    for name in ["REPORT.md","FIT-REPORT.md","qa/README.md","qa/export-metadata.json","data/evaluation-provenance.json"]:
        assert (ROOT/name).is_file(),name
    for stem in ["01-algorithm-comparison","01b-efficiency-overview","02-policy-selection","curve-and-tier-fitting"]:
        collision=json.loads((ROOT/"qa"/(stem+".collision-audit.json")).read_text())
        glyph=json.loads((ROOT/"qa"/(stem+".glyph-audit.json")).read_text())
        alignment=json.loads((ROOT/"qa"/(stem+".alignment.json")).read_text())
        assert collision["summary"]["fail"]==0 and glyph["below_minimum_count"]==0 and alignment["verdict"]=="PASS",stem
    for entry in json.loads((ROOT/"qa/export-metadata.json").read_text()):
        assert sha(ROOT/entry["file"])==entry["sha256"]
    assert "PENDING" not in (ROOT/"qa/README.md").read_text()
    (ROOT/"SEAL.json").write_text(json.dumps(dict(created_utc=time.strftime("%Y-%m-%dT%H:%M:%SZ",time.gmtime()),
        scope="Comparison-first strategy study; earlier immutable bundle remains separate and unchanged.",
        missing_only_time_observations=768,missing_only_memory_observations=630,
        retained_interrupted_time_observations=58266,
        source_previous_formal_observations=192780,
        fitting="Retained-data analysis only; unmeasured continuous block predictions have no fabricated timings.",
        exclusions=sorted(SKIP),manifest="SHA256SUMS"),indent=2)+"\n")
    files=included()
    (ROOT/"SHA256SUMS").write_text("".join(f"{sha(path)}  {path.relative_to(ROOT)}\n" for path in files))
    print(f"Sealed {len(files)} files")


if __name__=="__main__":main()
