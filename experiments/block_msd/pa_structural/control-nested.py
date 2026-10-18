#!/usr/bin/env python3
"""ABBA control for the isolated nested-write expansion on generic builds."""
import argparse
from collections import defaultdict
import csv
import json
from pathlib import Path
import resource
import statistics as st
import subprocess
import time
from analyze import quantile
from run import BASE, ROOT, REPO, digest, source_hash

p = argparse.ArgumentParser(__doc__)
p.add_argument('--binary', default='inline_generic')
p.add_argument('--prefix', default='inline-nested-control')
a = p.parse_args()
folder = REPO / 'experiments/block_msd/target/pa-structural'
executables = {'old': folder / 'kernel_final_generic', 'new': folder / a.binary}
meta = dict(order=['old', 'new', 'new', 'old'], commands=[],
            vmstat_before=Path('/proc/vmstat').read_text())
for name, exe in executables.items():
    frozen = json.loads(Path(str(exe) + '.json').read_text())
    assert frozen['sha256'] == digest(exe)
    assert frozen['features'] == '' and frozen['rustflags'] == ''
    meta[name] = frozen
assert meta['old']['sha256'] == '26eeac6512119e0f8a4581cbd0cb883ccaa76e1ad6ef2813a127adcf94b147d6'
assert meta['new']['source_sha256'] == source_hash()
samples = defaultdict(lambda: defaultdict(list))
for layout, block in [('u128', 64), ('wide32', 512)]:
    for outer, which in enumerate(meta['order']):
        path = ROOT / 'measurements' / f'{a.prefix}-{layout}-b{block}-{outer}-{which}.csv'
        assert not path.exists(), path
        methods = ','.join([BASE, 'Pa_kernel', 'Pa_kernel', BASE])
        command = ['taskset', '-c', '2', str(executables[which]), '262144', '8', methods,
                   'project64_spaced', layout, 'time', str(block), '42']
        started = time.time_ns()
        with path.open('w') as out, path.with_suffix('.stderr').open('w') as err:
            result = subprocess.run(command, cwd=REPO, stdout=out, stderr=err)
        meta['commands'].append(dict(command=command, file=path.name, sha256=digest(path),
                                     returncode=result.returncode, started_ns=started, ended_ns=time.time_ns()))
        assert result.returncode == 0 and path.with_suffix('.stderr').stat().st_size == 0
        rows = list(csv.DictReader(path.open()))
        assert len(rows) == 32 and len({r['input_address'] for r in rows}) == 1
        grouped = defaultdict(list)
        for r in rows:
            assert r['kind'] == 'time' and r['instrumented'] == 'false'
            cell = tuple(r[k] for k in ('layout', 'case', 'n', 'block', 'seed'))
            grouped[cell, r['method'], int(r['rep'])].append(int(r['wall_ns']))
        for (cell, method, rep), values in grouped.items():
            assert len(values) == 2
            samples[cell][which + ':' + method].append(st.mean(values))
    print(layout, block, flush=True)
results = []
for cell, methods in samples.items():
    row = dict(cell=cell)
    for numerator, denominator in [('new:' + BASE, 'old:' + BASE),
                                   ('new:Pa_kernel', 'old:' + BASE),
                                   ('old:Pa_kernel', 'old:' + BASE),
                                   ('new:Pa_kernel', 'old:Pa_kernel')]:
        ratios = [x / y for x, y in zip(methods[numerator], methods[denominator])]
        assert len(ratios) == 16
        row[numerator + '/' + denominator] = dict(median=st.median(ratios),
                                                  p10=quantile(ratios, .1), p90=quantile(ratios, .9))
    results.append(row)
meta['results'] = results
meta['vmstat_after'] = Path('/proc/vmstat').read_text()
usage = resource.getrusage(resource.RUSAGE_CHILDREN)
meta['usage'] = {k: getattr(usage, k) for k in ['ru_utime', 'ru_stime', 'ru_maxrss', 'ru_minflt', 'ru_majflt', 'ru_nivcsw']}
(ROOT / (a.prefix + '.json')).write_text(json.dumps(meta, indent=2) + '\n')
print(json.dumps(results, indent=2))
