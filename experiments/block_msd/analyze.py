#!/usr/bin/env python3
"""Compare checked count-first medians and measured allocator peaks."""
import csv
import pathlib
import os
import sys

primary = os.environ.get('MSD_PRIMARY', 'count_first_msd')
paths = [pathlib.Path(p) for p in sys.argv[1:]]
if not paths:
    paths = sorted(p for p in pathlib.Path(__file__).parent.glob('bench-count-first-*.csv')
                   if p.stem[len('bench-count-first-'):].isdigit())
rows = [row for path in paths for row in csv.DictReader(path.open())]
groups = {}
for row in rows:
    groups.setdefault((row['type'], row['load'], int(row['n']), int(row['block'])), {})[row['algorithm']] = row
out = csv.writer(sys.stdout)
out.writerow(['type', 'load', 'n', 'block', 'count_first_ns', 'v5_ns', 'ordinary_ns',
              'stable_ns_if_valid', 'ratio_v5', 'ratio_ordinary', 'ratio_stable_if_valid',
              'count_first_heap', 'v5_heap', 'ordinary_heap', 'stable_heap_if_valid'])
for key, values in sorted(groups.items()):
    required = [primary, 'bounded_msd_v5_onegap', 'msd_ordinary', 'msd_stable']
    if any(name not in values for name in required):
        raise ValueError(f'incomplete case {key}')
    new, old, ordinary, stable = [values[name] for name in required]
    assert new['status'] == old['status'] == 'ok', key
    assert ordinary['status'] == 'ok_unstable_contract', key
    ns = int(new['median_ns'])
    stable_ok = stable['status'] == 'ok'
    out.writerow([*key, ns, old['median_ns'], ordinary['median_ns'],
                  stable['median_ns'] if stable_ok else '',
                  f"{ns / int(old['median_ns']):.4f}",
                  f"{ns / int(ordinary['median_ns']):.4f}",
                  f"{ns / int(stable['median_ns']):.4f}" if stable_ok else '',
                  new['peak_extra_heap_bytes'], old['peak_extra_heap_bytes'],
                  ordinary['peak_extra_heap_bytes'],
                  stable['peak_extra_heap_bytes'] if stable_ok else ''])
