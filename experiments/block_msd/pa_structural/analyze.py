#!/usr/bin/env python3
"""Validate complete paired cells and summarize ratios without pooling timings."""
import collections
import csv
import json
from pathlib import Path
import statistics as st
import sys

ROOT = Path(__file__).resolve().parent

def quantile(values, q):
    values = sorted(values)
    at = (len(values) - 1) * q
    lo = int(at)
    return values[lo] + (values[min(lo + 1, len(values) - 1)] - values[lo]) * (at - lo)

def analyze(prefix):
    results = []
    hashes = set()
    for path in sorted((ROOT/'measurements').glob(prefix+'*.csv')):
        meta = json.loads(path.with_suffix('.json').read_text())
        assert meta['returncode'] == 0
        assert meta['args']['kind'] == 'time'
        hashes.add(meta['frozen']['sha256'])
        methods = meta['args']['methods'].split(',')
        cells = collections.defaultdict(dict)
        for row in csv.DictReader(path.open()):
            assert row['instrumented'] == 'false' and row['kind'] == 'time'
            cell = tuple(row[k] for k in ('layout','case','n','block','seed'))
            rep, slot = int(row['rep']), int(row['slot'])
            assert row['method'] == methods[slot]
            assert (rep,slot) not in cells[cell]
            cells[cell][rep,slot] = row
        for cell, rows in cells.items():
            reps = meta['args']['reps']
            assert set(rows) == {(r,s) for r in range(reps) for s in range(len(methods))}
            bymethod = {m: [st.mean(int(rows[r,s]['wall_ns']) for s in range(len(methods)) if methods[s] == m) for r in range(reps)] for m in set(methods)}
            for method, times in bymethod.items():
                row = dict(zip(('layout','case','n','block','seed'), cell), file=path.name, method=method, wall_ms=st.median(times)/1e6)
                for other, othertimes in bymethod.items():
                    ratios = [a/b for a,b in zip(times,othertimes)]
                    row[other+'_median'] = st.median(ratios)
                    row[other+'_p10'] = quantile(ratios,.1)
                    row[other+'_p90'] = quantile(ratios,.9)
                slots = [s for s in range(len(methods)) if methods[s] == method]
                if len(slots) == 2:
                    ratios = [int(rows[r,slots[1]]['wall_ns']) / int(rows[r,slots[0]]['wall_ns']) for r in range(reps)]
                    row.update(aa_median=st.median(ratios), aa_p10=quantile(ratios,.1), aa_p90=quantile(ratios,.9))
                results.append(row)
    assert len(hashes) == 1, 'mixed or missing ELFs'
    fields = list(dict.fromkeys(k for r in results for k in r))
    with (ROOT / (prefix+'summary.csv')).open('w') as out:
        w = csv.DictWriter(out,fieldnames=fields); w.writeheader(); w.writerows(results)
    for method in sorted(set(r['method'] for r in results)):
        group = [r for r in results if r['method'] == method]
        comparisons = sorted(set(k[:-7] for r in group for k in r if k.endswith('_median') and k != 'aa_median' and k != method+'_median'))
        print(method, len(group), 'cells', {other:sum(r.get(other+'_median',2)<1 for r in group) for other in comparisons})

if __name__ == '__main__': analyze(sys.argv[1])
