#!/usr/bin/env python3
"""Validate optimized sanitizer probes independently of formal timing rows."""
import csv
import hashlib
import json
from pathlib import Path
import time
ROOT = Path(__file__).resolve().parent
REPO = ROOT.parents[2]
METHODS = ('Pa_unified_prepared_t16777216', 'Pa_unified_groups_t16777216')
SIZES = dict(u8=1, u16=2, u32=4, u64=8, u8_id8=8, u16_id8=8,
             small8=8, u128=16, wide32=32, large128=128)
BLOCKS = (3, 17, 64, 129, 512)
FOLDER = ROOT / 'validation/optimized-asan'
expected = {f'{case}-b{block}.csv' for case in ('sparse', 'uniform') for block in BLOCKS}
assert {p.name for p in FOLDER.glob('*.csv')} == expected
count = 0
for path in sorted(FOLDER.glob('*.csv')):
    case, block = path.stem.split('-b')
    layouts = set(SIZES) if case == 'uniform' else set(SIZES) - {'u128', 'wide32', 'large128'}
    rows = list(csv.DictReader(path.open()))
    assert len(rows) == 2 * len(layouts), path
    assert path.with_suffix('.stderr').stat().st_size == 0, path
    positions, addresses = set(), {}
    for row in rows:
        slot = int(row['slot'])
        assert 0 <= slot < 2 and row['method'] == METHODS[slot]
        assert (row['n'], row['rep'], row['seed'], row['block']) == ('262145', '0', '42', block)
        assert row['case'] == case and row['layout'] in layouts
        assert int(row['record_bytes']) == SIZES[row['layout']]
        assert row['kind'] == 'time' and row['instrumented'] == 'false'
        key = row['layout'], slot
        assert key not in positions
        positions.add(key)
        assert addresses.setdefault(row['layout'], row['input_address']) == row['input_address']
    count += len(rows)
assert count == 170, count
log = (ROOT / 'validation/asan-tests.log').read_text()
assert '32 passed; 0 failed' in log
hashes = {}
for line in (ROOT / 'binary-sha256.txt').read_text().splitlines():
    expected, path = line.split('  ', 1)
    assert hashlib.sha256((REPO / path).read_bytes()).hexdigest() == expected, path
    hashes[path] = expected
assert len(hashes) == 4, hashes
(FOLDER / 'validation.json').write_text(json.dumps({
    'validated_ns': time.time_ns(), 'source_commit': (ROOT / 'source-commit.txt').read_text().strip(),
    'binary_sha256': hashes, 'optimized_sanitizer_frontier_tests_passed': 32,
    'pure_optimized_sanitizer_oracle_rows': count, 'blocks': BLOCKS,
    'record_sizes': SIZES, 'no_stderr': True,
    'scope': 'memory-safety and full stable oracle only; no ASan timing claims'
}, indent=2) + '\n')
print('32 optimized ASan tests and 170 pure full-layout sanitizer oracle rows PASS; four frozen ELFs verified')
