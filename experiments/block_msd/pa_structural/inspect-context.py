#!/usr/bin/env python3
"""Record exact packed hot-kernel instruction bodies for a frozen executable."""
import argparse
import json
from pathlib import Path
import subprocess
from run import REPO, ROOT, digest, source_hash

p = argparse.ArgumentParser(__doc__)
p.add_argument('--binary', required=True)
p.add_argument('--prefix', required=True)
a = p.parse_args()
exe = REPO / 'experiments/block_msd/target/pa-structural' / a.binary
frozen = json.loads(Path(str(exe) + '.json').read_text())
assert frozen['sha256'] == digest(exe)
assert frozen['source_sha256'] == source_hash()
lines = subprocess.check_output(['nm', '-S', '-C', str(exe)], text=True).splitlines()
records = []
for line in lines:
    if 'Packed<' not in line or ', true>' not in line or 'run::trampoline' not in line:
        continue
    if '::scatter' in line and 'Sorter<' in line:
        kind = 'scatter'
    elif 'frontier::dense<' in line:
        kind = 'dense'
    elif 'pa::partition<' in line:
        kind = 'boundary'
    else:
        continue
    start, size, *_ = line.split(maxsplit=3)
    dump = subprocess.check_output(['objdump', '-d', f'--start-address={int(start,16)}',
                                   f'--stop-address={int(start,16)+int(size,16)}', str(exe)], text=True)
    pext = [x.strip() for x in dump.splitlines() if '\tpext' in x]
    calls = [x.strip() for x in dump.splitlines() if '\tcall' in x]
    extraction_calls = [x for x in calls if 'pext_u' in x]
    record = dict(kind=kind, symbol=line, pext=pext, calls=calls,
                  extraction_calls=extraction_calls)
    records.append(record)
    assert not extraction_calls, record
    # These cover the two previously distinct generic-target failures.
    u32_guard = kind == 'scatter' and 'Sorter<u32>' in line and 'Packed<u32, u8,' in line
    u128_guard = kind == 'scatter' and 'Sorter<u128>' in line and 'Packed<u128, u16,' in line
    if u32_guard or u128_guard:
        assert pext, record
        path = ROOT / 'validation' / f'{a.prefix}-{start}-{kind}.txt'
        path.write_text(line + '\n' + dump)
assert any('Sorter<u32>' in r['symbol'] for r in records)
assert any('Sorter<u128>' in r['symbol'] and 'Packed<u128, u16,' in r['symbol'] for r in records)
(ROOT / 'validation' / (a.prefix + '-codegen.json')).write_text(
    json.dumps(dict(frozen=frozen, bodies=records), indent=2) + '\n')
print('bodies', len(records), 'direct PEXT', sum(len(r['pext']) for r in records),
      'outlined extraction calls', sum(len(r['extraction_calls']) for r in records))
