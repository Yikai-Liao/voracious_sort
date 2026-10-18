#!/usr/bin/env python3
"""Check retained packing and fallback geometry; exclude instrumented timing."""
import argparse
import collections
import csv
import json
from run import ROOT, BASE

p = argparse.ArgumentParser(__doc__)
p.add_argument('prefix')
a = p.parse_args()
ignored = {'method', 'slot', 'wall_ns', 'cpu_ns', 'input_address'}
records = []
hashes = set()
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
        strict = methods['Pa_strict']
        layout, case, n, block, seed = key
        check = None
        if case == 'uniform' or (layout in ['f32', 'f32_id16'] and case == 'sparse16'):
            check = BASE
            assert int(strict['projection_nodes']) == 0
        if layout in ['u32', 'u128', 'wide32', 'large128', 'f64', 'f64_id32'] and case in ['sparse', 'sparse16']:
            check = 'Pa_kernel'
            assert int(strict['projection_nodes']) > 0
        if check:
            expected = {k: v for k, v in methods[check].items() if k not in ignored}
            actual = {k: v for k, v in strict.items() if k not in ignored}
            assert actual == expected, (key, check, {
                k: [expected[k], actual[k]] for k in expected if expected[k] != actual[k]})
        records.append({'cell': key, 'equal_to': check, 'methods': {
            name: {k: v for k, v in row.items() if k not in ignored}
            for name, row in methods.items()}})
assert records and len(hashes) == 1
(ROOT / (a.prefix + 'checked.json')).write_text(json.dumps({
    'elf_sha256': next(iter(hashes)), 'cells': len(records), 'results': records}, indent=2) + '\n')
print('checked', len(records), 'cells; instrumented timing excluded')
