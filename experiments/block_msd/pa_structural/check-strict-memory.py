#!/usr/bin/env python3
"""Check measured workspace peaks against original PA in one ELF cohort."""
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
for path in sorted((ROOT / 'measurements').glob(a.prefix + '*.csv')):
    meta = json.loads(path.with_suffix('.json').read_text())
    assert meta['returncode'] == 0 and meta['args']['kind'] == 'memory'
    assert path.with_suffix('.stderr').stat().st_size == 0
    hashes.add(meta['frozen']['sha256'])
    cells = collections.defaultdict(dict)
    for row in csv.DictReader(path.open()):
        assert row['kind'] == 'memory' and row['instrumented'] == 'false'
        assert int(row['wall_ns']) == 0 and int(row['cpu_ns']) == 0
        key = tuple(row[k] for k in ('layout', 'case', 'n', 'block', 'seed'))
        assert row['method'] not in cells[key]
        cells[key][row['method']] = row
    for key, methods in cells.items():
        before = methods[BASE]
        after = methods['Pa_strict']
        assert int(after['heap_peak']) <= int(before['heap_peak']), (key, before, after)
        records.append({'cell': key, 'original_heap': int(before['heap_peak']),
                        'strict_heap': int(after['heap_peak']),
                        'original_allocs': int(before['allocs']),
                        'strict_allocs': int(after['allocs'])})
assert records and len(hashes) == 1
(ROOT / (a.prefix + 'checked.json')).write_text(json.dumps({
    'elf_sha256': next(iter(hashes)), 'cells': len(records), 'results': records}, indent=2) + '\n')
print('checked', len(records), 'cells; no candidate peak exceeds original PA')
