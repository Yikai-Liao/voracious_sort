"""Keep per-cell losses and current-candidate A/A variation visible."""
import csv
import json
import statistics
import sys
from collections import defaultdict
from pathlib import Path

root = Path(__file__).resolve().parent
stage = root / sys.argv[1]
candidate = json.loads((stage / 'manifest.json').read_text())['methods'][0]
saved = defaultdict(dict)
for line in (root / 'auto-baseline/time.jsonl').read_text().splitlines():
    row = json.loads(line)
    if row['algorithm'] in ['pa', 'pa_aa']:
        key = row['kind'], row['dist'], row['n'], row['seed'], row['order']
        saved[key][row['algorithm']] = row

groups = defaultdict(list)
for line in (stage / 'time.jsonl').read_text().splitlines():
    row = json.loads(line)
    assert row['algorithm'] == candidate
    assert row['valid'] and row['ordered'] and row['preserved']
    groups[row['kind'], row['dist'], row['n']].append(row)

result = []
for (kind, dist, n), values in groups.items():
    ratios, old_aa = [], {}
    slots = defaultdict(dict)
    for row in values:
        key = kind, dist, n, row['seed'], row['order']
        old = saved[key]['pa']
        for field in ['input_digest', 'radix', 'block', 'bytes_per_record']:
            assert row[field] == old[field]
        ratios.append(row['ns'] / old['ns'])
        old_aa[key] = saved[key]['pa_aa']['ns'] / old['ns']
        slots[row['seed'], row['order']][row['slot']] = row['ns']
    aa = [v[1] / v[0] for v in slots.values() if len(v) == 2]
    outside_aa = []
    for row in values:
        key = kind, dist, n, row['seed'], row['order']
        current = slots[row['seed'], row['order']]
        current_aa = current[1] / current[0] if len(current) == 2 else 1.0
        envelope = max(old_aa[key], 1 / old_aa[key], current_aa, 1 / current_aa)
        outside_aa.append(row['ns'] / saved[key]['pa']['ns'] > envelope)
    old_ns = statistics.median(saved[key]['pa']['ns'] for key in old_aa)
    candidate_ns = statistics.median(r['ns'] for r in values)
    result.append(dict(kind=kind, dist=dist, n=n,
                       candidate_ns=candidate_ns, saved_pa_ns=old_ns,
                       delta_ns=candidate_ns - old_ns,
                       ratio=statistics.median(ratios),
                       minimum=min(ratios), maximum=max(ratios),
                       saved_aa_median=statistics.median(old_aa.values()),
                       saved_aa_min=min(old_aa.values()),
                       saved_aa_max=max(old_aa.values()),
                       candidate_aa_median=statistics.median(aa) if aa else '',
                       candidate_aa_min=min(aa) if aa else '',
                       candidate_aa_max=max(aa) if aa else '',
                       all_observations_above_aa_envelope=all(outside_aa),
                       observations=len(values)))

result.sort(key=lambda r: r['ratio'], reverse=True)
with (stage / 'acceptance-cells.csv').open('w') as out:
    writer = csv.DictWriter(out, fieldnames=list(result[0]))
    writer.writeheader()
    writer.writerows(result)
summary = dict(cases=len(result), rows=sum(r['observations'] for r in result),
               losses_over_5pct=sum(r['ratio'] > 1.05 for r in result),
               wins_over_10pct=sum(r['ratio'] < .9 for r in result),
               losses_over_10pct=sum(r['ratio'] > 1.1 for r in result),
               losses_over_20pct=sum(r['ratio'] > 1.2 for r in result),
               losses_over_10pct_and_1us=sum(r['ratio'] > 1.1 and r['delta_ns'] > 1000 for r in result),
               all_observations_over_10pct=sum(r['minimum'] > 1.1 for r in result),
               all_observations_over_20pct=sum(r['minimum'] > 1.2 for r in result),
               losses_over_5pct_above_aa_envelope=sum(r['ratio'] > 1.05 and r['all_observations_above_aa_envelope'] for r in result),
               worst=result[:20],
               note='Historical PA comparison; A/A describes variation, not a causal no-regression proof.')
(stage / 'acceptance-summary.json').write_text(json.dumps(summary, indent=2) + '\n')
print(json.dumps({k: v for k, v in summary.items() if k != 'worst'}, indent=2))
for row in result[:10]:
    print(f'{row["kind"]:10} {row["dist"]:20} n={row["n"]:8}'
          f' ratio={row["ratio"]:.3f} range={row["minimum"]:.3f}..{row["maximum"]:.3f}'
          f' delta={row["delta_ns"]:.0f}ns')
