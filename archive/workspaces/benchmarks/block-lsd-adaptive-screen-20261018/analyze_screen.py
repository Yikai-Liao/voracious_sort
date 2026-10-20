#!/usr/bin/env python3
import argparse
import csv
import hashlib
import json
import math
from pathlib import Path
import statistics as stats

ROOT = Path(__file__).resolve().parent


def analyze(stage):
    manifest = json.loads((stage / 'manifest.json').read_text())
    raw = [json.loads(line) for line in (stage / 'time.jsonl').read_text().splitlines()]
    assert len(raw) == 18 * len(manifest['schedule'])
    lookup = {(r['kind'], r['dist'], r['n'], r['pair'], r['order'], r['algorithm']): r for r in raw}
    assert len(lookup) == len(raw)
    memory = [json.loads(line) for line in (stage / 'memory.jsonl').read_text().splitlines()] if (stage / 'memory-completion.json').exists() else []
    result = []
    for case in manifest['schedule']:
        key = case['kind'], case['dist'], case['n']
        ratios, aa, before, after = [], [], [], []
        for pair in range(3):
            for order in range(2):
                b, a, control = [lookup[(*key, pair, order, name)] for name in manifest['methods']]
                assert b['input_digest'] == a['input_digest'] == control['input_digest']
                ratios.append(a['ns'] / b['ns'])
                aa.append(control['ns'] / b['ns'])
                before.append(b['ns']); after.append(a['ns'])
        envelope = max(max(r, 1/r) for r in aa)
        row = dict(**case, before_ns=stats.median(before), after_ns=stats.median(after),
                   paired_ratio=stats.median(ratios), ratio_min=min(ratios), ratio_max=max(ratios),
                   aa_ratio=stats.median(aa), aa_min=min(aa), aa_max=max(aa), aa_symmetric_envelope=envelope,
                   all_six_faster=max(ratios) < 1, all_six_slower=min(ratios) > 1,
                   all_six_faster_beyond_aa=max(ratios) < 1/envelope,
                   all_six_slower_beyond_aa=min(ratios) > envelope)
        if memory:
            for method, label in [('block_before','before'), ('block_after','after')]:
                matched = [r for r in memory if (r['kind'],r['dist'],r['n']) == key and r['algorithm'] == method]
                assert len(matched) == 3
                row[f'{label}_peak_bytes'] = max(r['peak_bytes'] for r in matched)
        result.append(row)
    result.sort(key=lambda r: (r['dist'], r['kind'], r['n']))
    with (stage/'comparison.csv').open('w') as f:
        writer=csv.DictWriter(f, fieldnames=result[0].keys()); writer.writeheader(); writer.writerows(result)
    summary = dict(conditions=len(result), time_observations=len(raw), memory_observations=len(memory),
                   geometric_mean_ratio=math.exp(stats.mean(math.log(r['paired_ratio']) for r in result)),
                   all_six_faster_beyond_aa=sum(r['all_six_faster_beyond_aa'] for r in result),
                   all_six_slower_beyond_aa=sum(r['all_six_slower_beyond_aa'] for r in result),
                   source_sha256={p.name:hashlib.sha256(p.read_bytes()).hexdigest() for p in [stage/'manifest.json',stage/'time.jsonl',Path(__file__)]})
    (stage/'analysis.json').write_text(json.dumps(summary,indent=2)+'\n')
    print(json.dumps(summary,indent=2))
    for r in result:
        print(f"{r['kind']:10s} {r['dist']:17s} n={r['n']:8d} after/before={r['paired_ratio']:.4f} range=[{r['ratio_min']:.4f},{r['ratio_max']:.4f}] AA=[{r['aa_min']:.4f},{r['aa_max']:.4f}]")


if __name__ == '__main__':
    parser=argparse.ArgumentParser(); parser.add_argument('stage'); args=parser.parse_args()
    analyze(ROOT/args.stage)
