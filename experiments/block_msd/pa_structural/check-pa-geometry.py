#!/usr/bin/env python3
"""Check PA logical geometry while excluding physical work and Work timing."""
import argparse
import collections
import csv
import json
from pathlib import Path
from run import ROOT

p = argparse.ArgumentParser(__doc__)
p.add_argument('prefix')
p.add_argument('--reference', default='Pa_kernel')
p.add_argument('--candidate', default='Pa_odd_blocks')
a = p.parse_args()
logical = ['projection_nodes', 'projection_records', 'identity_nodes', 'nodes',
           'node_records', 'prepare_records', 'order_records', 'candidate_records',
           'runs_records', 'unresolved_records', 'leaves', 'leaf_records',
           'max_depth', 'frontier_nodes', 'equal_nodes', 'band_nodes',
           'band_records', 'terminal_band_nodes', 'probe_records', 'leaf_lengths']
report = []
hashes = set()
for path in sorted((ROOT / 'measurements').glob(a.prefix+'*.csv')):
    meta = json.loads(path.with_suffix('.json').read_text())
    assert meta['returncode'] == 0 and meta['args']['kind'] == 'work'
    hashes.add(meta['frozen']['sha256'])
    groups = collections.defaultdict(dict)
    for row in csv.DictReader(path.open()):
        assert row['instrumented'] == 'true' and row['kind'] == 'work'
        cell = tuple(row[k] for k in ['layout', 'case', 'n', 'block', 'seed'])
        assert row['method'] not in groups[cell]
        groups[cell][row['method']] = row
    for cell, methods in groups.items():
        before, after = methods[a.reference], methods[a.candidate]
        assert all(before[k] == after[k] for k in logical), (cell, {
            k: [before[k], after[k]] for k in logical if before[k] != after[k]})
        report.append({'cell': cell, 'logical_fields_equal': logical,
                       'methods': {name: {k: value for k, value in row.items()
                         if k not in ['wall_ns', 'cpu_ns', 'input_address']}
                         for name, row in methods.items()}})
assert report and len(hashes) == 1
(ROOT / (a.prefix+'checked.json')).write_text(json.dumps({
    'elf_sha256': next(iter(hashes)), 'cells': len(report), 'results': report
}, indent=2)+'\n')
print('logical geometry equal in', len(report), 'cells')
