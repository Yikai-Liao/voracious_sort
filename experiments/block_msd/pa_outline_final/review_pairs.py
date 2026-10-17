#!/usr/bin/env python3
"""Validate process pair rotations and summarize pre/post-outline comparisons."""
import csv
import hashlib
import json
from pathlib import Path
import statistics
from analyze import quantile
ROOT = Path(__file__).resolve().parent
REPO = ROOT.parents[2]
result = []
for path in sorted((ROOT / 'pairs').glob('*.csv')):
    meta = json.loads(path.with_suffix('.json').read_text())
    assert len(meta['commands']) == 64
    assert all(c['returncode'] == 0 for c in meta['commands'])
    for filename, expected in meta['binary_sha256'].items():
        assert hashlib.sha256((REPO / filename).read_bytes()).hexdigest() == expected
    rows = list(csv.DictReader(path.open()))
    assert len(rows) == 64
    groups = {}
    for row in rows:
        rep, slot = int(row['outer_rep']), int(row['outer_slot'])
        assert 0 <= rep < 16 and 0 <= slot < 4
        assert row['build'] == ('before', 'outlined', 'stable', 'before')[slot]
        assert row['method'] == ('stable_msd' if slot == 2 else 'Pa_unified_groups_t16777216')
        assert row['kind'] == 'time' and row['instrumented'] == 'false'
        assert row['n'] == '1048576' and row['seed'] == '42'
        assert slot not in groups.setdefault(rep, {})
        groups[rep][slot] = row
    ratios, cpu, stable, aa = [], [], [], []
    for rep, group in sorted(groups.items()):
        assert set(group) == set(range(4))
        rotation = (rep // 2) % 4
        order = list(range(4))[rotation:] + list(range(4))[:rotation]
        if rep % 2:
            order.reverse()
        assert [int(group[slot]['position']) for slot in order] == list(range(4))
        wall = [int(group[i]['wall_ns']) for i in range(4)]
        thread = [int(group[i]['cpu_ns']) for i in range(4)]
        ratios.append(wall[1] / statistics.mean((wall[0], wall[3])))
        cpu.append(thread[1] / statistics.mean((thread[0], thread[3])))
        stable.append(wall[1] / wall[2])
        aa.append(wall[3] / wall[0])
    row = dict(file=path.name, reps=16, outlined_over_before=statistics.median(ratios),
        ratio_p10=quantile(ratios, .1), ratio_p90=quantile(ratios, .9),
        outlined_slower_reps=sum(x > 1 for x in ratios),
        threadcpu_ratio=statistics.median(cpu), outlined_over_stable=statistics.median(stable),
        before_aa_p10=quantile(aa, .1), before_aa_p90=quantile(aa, .9))
    result.append(row)
assert len(result) == 4, len(result)
with (ROOT / 'review-pairs.csv').open('w', newline='') as stream:
    writer = csv.DictWriter(stream, fieldnames=list(result[0]))
    writer.writeheader()
    writer.writerows(result)
print('4 process-paired cells, 256 full-oracle rows, complete reversed rotations and frozen ELF hashes verified')
