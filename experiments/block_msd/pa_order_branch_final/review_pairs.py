#!/usr/bin/env python3
"""Audit every fixed source-paired process and keep all paired comparisons."""
import csv
import hashlib
import json
from pathlib import Path
import statistics as stat
from analyze import quantile
from paired_sources import CONFIG, GROUP, REPS
ROOT = Path(__file__).resolve().parent
REPO = ROOT.parents[2]
result = []
for experiment, config in CONFIG.items():
    expected = set(config[4])
    paths = sorted((ROOT / 'pairs' / experiment).glob('*.csv'))
    assert len(paths) == len(expected), experiment
    seen = set()
    for path in paths:
        meta = json.loads(path.with_suffix('.json').read_text())
        cell = tuple(meta[k] for k in ('n', 'block', 'layout', 'case'))
        assert cell in expected and cell not in seen
        seen.add(cell)
        assert meta['experiment'] == experiment and meta['reps'] == REPS
        for filename, digest in meta['binary_sha256'].items():
            assert hashlib.sha256((REPO / filename).read_bytes()).hexdigest() == digest
        commands = meta['commands']
        assert len(commands) == 64 and all(c['returncode'] == 0 for c in commands)
        rows = list(csv.DictReader(path.open()))
        assert len(rows) == 64
        groups = {}
        for row, command in zip(rows, commands):
            rep, slot = int(row['outer_rep']), int(row['outer_slot'])
            assert 0 <= rep < REPS and 0 <= slot < 4
            assert row['build'] == ('before', 'after', 'stable', 'before')[slot]
            assert row['method'] == ('stable_msd' if slot == 2 else GROUP)
            assert row['kind'] == 'time' and row['instrumented'] == 'false'
            assert tuple(row[k] for k in ('n','block','layout','case')) == tuple(map(str, cell))
            assert row['seed'] == '42' and command['outer_rep'] == rep and command['outer_slot'] == slot
            assert int(row['position']) == command['position']
            binary_name = config[2] if slot in (0, 3) else config[3]
            assert command['argv'][:4] == ['taskset', '-c', '2', str(REPO / 'experiments/block_msd/target' / binary_name / 'time')]
            assert command['argv'][4:] == [row['n'], '1', row['method'], row['case'], row['layout'], 'time', row['block'], '42']
            assert slot not in groups.setdefault(rep, {})
            groups[rep][slot] = row
        assert set(groups) == set(range(REPS))
        ratios, cpu, stable, aa = [], [], [], []
        for rep, group in sorted(groups.items()):
            assert set(group) == set(range(4))
            rotation = (rep // 2) % 4
            order = list(range(4))[rotation:] + list(range(4))[:rotation]
            if rep % 2:
                order.reverse()
            assert [int(group[s]['position']) for s in order] == list(range(4))
            wall = [int(group[i]['wall_ns']) for i in range(4)]
            thread = [int(group[i]['cpu_ns']) for i in range(4)]
            assert min(wall + thread) > 0
            ratios.append(wall[1]/stat.mean((wall[0],wall[3])))
            cpu.append(thread[1]/stat.mean((thread[0],thread[3])))
            stable.append(wall[1]/wall[2])
            aa.append(wall[3]/wall[0])
        result.append(dict(experiment=experiment, file=path.name, n=cell[0], block=cell[1],
            layout=cell[2], case=cell[3], reps=REPS, after_over_before=stat.median(ratios),
            ratio_p10=quantile(ratios,.1), ratio_p90=quantile(ratios,.9),
            after_slower_reps=sum(x>1 for x in ratios), threadcpu_ratio=stat.median(cpu),
            after_over_stable=stat.median(stable), before_aa_p10=quantile(aa,.1),before_aa_p90=quantile(aa,.9)))
    assert seen == expected
with (ROOT/'review-pairs.csv').open('w',newline='') as out:
    writer=csv.DictWriter(out,fieldnames=list(result[0]));writer.writeheader();writer.writerows(result)
print('14 cells / 896 full-oracle process pairs, fixed source deltas, actual reversed rotations and frozen ELF hashes verified')
