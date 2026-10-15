#!/usr/bin/env python3
"""Summarize verified scan-experiment samples; normal and phase runs stay separate."""
import csv
import statistics
import sys
from collections import defaultdict

cases = defaultdict(lambda: defaultdict(list))
for path in sys.argv[1:]:
    with open(path) as source:
        for row in csv.DictReader(source):
            key = (row['type'], row['load'], int(row['n']), int(row['block']))
            cases[key][row['algorithm']].append(row)
out = csv.writer(sys.stdout)
out.writerow(['type', 'load', 'n', 'block', 'full_scan_ns', 'early_scan_ns',
              'early_over_full', 'ordinary_ns', 'stable_fixed_ns',
              'early_over_ordinary', 'early_over_stable_fixed',
              'full_heap', 'early_heap', 'ordinary_heap', 'stable_fixed_heap'])
for key, methods in sorted(cases.items()):
    names = ['full_scan', 'early_scan', 'ordinary', 'stable_fixed']
    assert set(methods) == set(names), key
    values = [statistics.median(int(r['ns']) for r in methods[name]) for name in names]
    heaps = []
    for name in names:
        peak = {int(r['peak_heap']) for r in methods[name]}
        assert len(peak) == 1, (key, name, peak)
        heaps.append(peak.pop())
    assert {r['nodes'] for r in methods['full_scan']} == {r['nodes'] for r in methods['early_scan']}, key
    old, new, ordinary, stable = values
    out.writerow([*key, *values[:2], f'{new/old:.6f}', *values[2:],
                  f'{new/ordinary:.6f}', f'{new/stable:.6f}', *heaps])
