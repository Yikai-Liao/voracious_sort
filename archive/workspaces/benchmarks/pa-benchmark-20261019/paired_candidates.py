"""Compare two new candidates in the same timed process and reversed slots."""
import csv
import json
import statistics
import sys
from collections import defaultdict
from pathlib import Path

stage = Path(__file__).resolve().parent / sys.argv[1]
control = sys.argv[2] if len(sys.argv) > 2 else 'pa_interval'
candidate = sys.argv[3] if len(sys.argv) > 3 else 'pa_adaptive'
pairs = defaultdict(dict)
for line in (stage / 'time.jsonl').read_text().splitlines():
    row = json.loads(line)
    assert row['valid'] and row['ordered'] and row['preserved']
    key = row['kind'], row['dist'], row['n'], row['seed'], row['order']
    pairs[key][row['algorithm']] = row

groups = defaultdict(list)
for key, values in pairs.items():
    a, b = values[candidate], values[control]
    for field in ['input_digest', 'block', 'radix', 'bytes_per_record']:
        assert a[field] == b[field]
    groups[key[:3]].append((a['ns'], b['ns']))

rows = []
for (kind, dist, n), values in groups.items():
    ratios = [a / b for a, b in values]
    row = dict(kind=kind, dist=dist, n=n, candidate=candidate, control=control,
               candidate_ns=statistics.median(a for a, b in values),
               control_ns=statistics.median(b for a, b in values),
               ratio=statistics.median(ratios),
               delta_ns=statistics.median(a - b for a, b in values),
               minimum=min(ratios), maximum=max(ratios))
    rows.append(row)
    print(f'{kind:10} {dist:16} n={n:6} ratio={row["ratio"]:.3f}'
          f' delta={row["delta_ns"]:.0f}ns range={min(ratios):.3f}..{max(ratios):.3f}')
with (stage / 'paired-comparison.csv').open('w') as out:
    writer = csv.DictWriter(out, fieldnames=list(rows[0]))
    writer.writeheader()
    writer.writerows(rows)
