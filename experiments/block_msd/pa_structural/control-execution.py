#!/usr/bin/env python3
"""ABBA with the previous checkpoint, to expose shared-refactor costs."""
import argparse
from collections import defaultdict
import csv
import json
from pathlib import Path
import statistics as st
import subprocess
import time
from analyze import quantile
from run import BASE, ROOT, REPO, digest, source_hash

p = argparse.ArgumentParser()
p.add_argument('--target', choices=['generic', 'native'], required=True)
a = p.parse_args()
old = REPO.parent / 'voracious_sort-pa-structural/experiments/block_msd/target/pa-structural' / ('hw_single_' + a.target)
new = REPO / 'experiments/block_msd/target/pa-structural' / ('execution_' + a.target)
meta = {'target': a.target, 'started_ns': time.time_ns(), 'runs': []}
for name, binary in [('old', old), ('new', new)]:
    frozen = json.loads(Path(str(binary) + '.json').read_text())
    assert frozen['sha256'] == digest(binary)
    if name == 'new':
        assert frozen['source_sha256'] == source_hash()
    meta[name] = frozen
samples = defaultdict(lambda: defaultdict(list))
for block in [64, 512]:
    for outer, which in enumerate(['old', 'new', 'new', 'old']):
        path = ROOT / 'measurements' / f'execution-{a.target}-control-b{block}-{outer}-{which}.csv'
        assert not path.exists()
        candidate = 'Pa_packed' if which == 'old' else 'Pa_kernel'
        methods = ','.join([BASE, candidate, candidate, BASE])
        command = ['taskset', '-c', '2', str(old if which == 'old' else new),
                   '1048576', '8', methods, 'sparse,uniform', 'u32', 'time', str(block), '42']
        started = time.time_ns()
        with path.open('w') as out, path.with_suffix('.stderr').open('w') as err:
            subprocess.run(command, cwd=REPO, stdout=out, stderr=err, check=True)
        assert path.with_suffix('.stderr').stat().st_size == 0
        meta['runs'].append(dict(file=path.name, command=command,
                                 started_ns=started, ended_ns=time.time_ns()))
        grouped = defaultdict(list)
        for row in csv.DictReader(path.open()):
            assert row['kind'] == 'time' and row['instrumented'] == 'false'
            cell = tuple(row[k] for k in ['layout', 'case', 'n', 'block', 'seed'])
            grouped[cell, row['method'], int(row['rep'])].append(int(row['wall_ns']))
        for (cell, method, rep), values in grouped.items():
            samples[cell][which + ':' + method].append(st.mean(values))
results = []
for cell, methods in samples.items():
    row = {'cell': cell, 'medians_ms': {k: st.median(v) / 1e6 for k, v in methods.items()}}
    for method in ['new:' + BASE, 'new:Pa_kernel', 'old:Pa_packed']:
        ratios = [x / y for x, y in zip(methods[method], methods['old:' + BASE])]
        row[method] = dict(median=st.median(ratios), p10=quantile(ratios, .1), p90=quantile(ratios, .9))
    results.append(row)
meta.update(results=results, ended_ns=time.time_ns())
(ROOT / f'execution-{a.target}-control.json').write_text(json.dumps(meta, indent=2) + '\n')
print(json.dumps(results, indent=2))
