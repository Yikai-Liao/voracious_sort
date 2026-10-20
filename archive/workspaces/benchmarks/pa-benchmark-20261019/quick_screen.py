"""Screen new candidates against saved PA rows; never run old algorithms."""
import collections
import csv
import json
import statistics
import sys
from pathlib import Path

from run_auto import ROOT, freeze, run

def prepare(name, method, cases, harness='candidate/harness', binary='target/release/block-lsd-pr-benchmark'):
    stage = ROOT / name
    stage.mkdir()
    (stage / 'harness').symlink_to(ROOT / harness, target_is_directory=True)
    (stage / 'benchmark-time').write_bytes((ROOT / binary).read_bytes())
    (stage / 'benchmark-time').chmod(0o700)
    (stage / 'cases.json').write_text(json.dumps(cases, indent=2) + '\n')
    (stage / 'methods.txt').write_text(method + '\n')
    freeze(stage)
    return stage

def compare(stage):
    saved = {}
    for line in (ROOT / 'auto-baseline/time.jsonl').read_text().splitlines():
        r = json.loads(line)
        if r['algorithm'] == 'pa':
            saved[r['kind'], r['dist'], r['n'], r['seed'], r['order']] = r
    groups = collections.defaultdict(list)
    for line in (stage / 'time.jsonl').read_text().splitlines():
        r = json.loads(line)
        old = saved[r['kind'], r['dist'], r['n'], r['seed'], r['order']]
        for field in ['input_digest', 'block', 'radix', 'bytes_per_record']:
            assert r[field] == old[field], (field, r, old)
        # The harness XORs one output digest per batch element. Even batch
        # counts therefore produce zero, and pilot-selected counts may differ.
        if r['batch'] % 2 == old['batch'] % 2:
            assert r['digest'] == old['digest']
        groups[r['kind'], r['dist'], r['n'], r['algorithm']].append((r['ns'], old['ns']))
    rows = []
    for (kind, dist, n, method), pairs in groups.items():
        ratios = [a / b for a, b in pairs]
        row = dict(kind=kind, dist=dist, n=n, method=method,
                   saved_pa_ms=statistics.median(b for a,b in pairs)/1e6,
                   candidate_ms=statistics.median(a for a,b in pairs)/1e6,
                   ratio_to_saved_pa=statistics.median(ratios),
                   minimum=min(ratios), maximum=max(ratios), observations=len(pairs))
        rows.append(row)
        print(f"{kind:10} {dist:20} n={n:8} PA={row['saved_pa_ms']:.4f}ms candidate={row['candidate_ms']:.4f}ms ratio={row['ratio_to_saved_pa']:.3f} range={min(ratios):.3f}..{max(ratios):.3f}")
    with (stage / 'comparison.csv').open('w') as f:
        writer = csv.DictWriter(f, fieldnames=list(rows[0]))
        writer.writeheader()
        writer.writerows(rows)
    print('Historical comparison, same input digests and build profile; no new PA measurements.')

if __name__ == '__main__':
    stage = ROOT / sys.argv[1]
    if sys.argv[2] == 'compare':
        compare(stage)
    else:
        run(stage, 'time', 3)
        compare(stage)
