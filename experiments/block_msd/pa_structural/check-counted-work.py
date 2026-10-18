#!/usr/bin/env python3
"""Audit causal PA counters; instrumented wall times are deliberately excluded."""
import argparse
import collections
import csv
import json
from run import ROOT, BASE

p = argparse.ArgumentParser(__doc__)
p.add_argument('prefix')
a = p.parse_args()
records = []
hashes = set()
ignored = {'method', 'slot', 'wall_ns', 'cpu_ns', 'input_address'}
for path in sorted((ROOT / 'measurements').glob(a.prefix + '*.csv')):
    meta = json.loads(path.with_suffix('.json').read_text())
    assert meta['returncode'] == 0 and meta['args']['kind'] == 'work'
    assert path.with_suffix('.stderr').stat().st_size == 0
    hashes.add(meta['frozen']['sha256'])
    cells = collections.defaultdict(dict)
    for row in csv.DictReader(path.open()):
        assert row['kind'] == 'work' and row['instrumented'] == 'true'
        key = tuple(row[k] for k in ('layout', 'case', 'n', 'block', 'seed'))
        assert row['method'] not in cells[key]
        cells[key][row['method']] = row
    for key, methods in cells.items():
        def equal(names):
            expected = {k: v for k, v in methods[names[0]].items()
                        if k not in ignored}
            for name in names[1:]:
                actual = {k: v for k, v in methods[name].items()
                          if k not in ignored}
                assert actual == expected, (key, names, {
                    k: [expected[k], actual[k]] for k in expected
                    if expected[k] != actual[k]})

        combined = methods['Pa_strict_counted']
        layout, case, n, block, seed = key
        checked = []
        if layout in ['f32', 'f32_id16', 'u32'] and case == 'uniform':
            equal(['Pa_strict_counted', 'Pa_counted_key'])
            assert int(combined['projection_nodes']) == 0
            assert int(combined['leaves']) == 0
            assert int(combined['block_nodes']) > 0
            checked.append('count-derived full-key completion, no comparison leaves')
        if layout in ['f32', 'f32_id16'] and case == 'sparse16':
            equal([BASE, 'Pa_strict', 'Pa_counted_key', 'Pa_strict_counted'])
            assert int(combined['projection_nodes']) == 0
            checked.append('conservative guard preserves original terminal path')
        if layout in ['f64', 'f64_id32', 'u128', 'wide32'] and case in ['sparse16', 'sparse']:
            equal(['Pa_kernel', 'Pa_strict', 'Pa_strict_counted'])
            assert int(combined['projection_nodes']) > 0
            checked.append('strong packing retained unchanged')
        records.append({'cell': key, 'checks': checked, 'methods': {
            name: {k: v for k, v in row.items() if k not in ignored}
            for name, row in methods.items()}})

assert records and len(hashes) == 1
(ROOT / (a.prefix + 'checked.json')).write_text(json.dumps({
    'elf_sha256': next(iter(hashes)), 'cells': len(records),
    'results': records}, indent=2) + '\n')
print('checked', len(records), 'cells; instrumented timing excluded')
