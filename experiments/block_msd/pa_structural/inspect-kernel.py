#!/usr/bin/env python3
"""Inspect exact generic-target u32 packed scalar/context hot bodies."""
import argparse
import json
from pathlib import Path
import subprocess
from run import ROOT, REPO, digest, source_hash

p = argparse.ArgumentParser()
p.add_argument('--binary', required=True)
p.add_argument('--prefix', required=True)
a = p.parse_args()
exe = REPO / 'experiments/block_msd/target/pa-structural' / a.binary
frozen = json.loads(Path(str(exe) + '.json').read_text())
assert frozen['sha256'] == digest(exe)
assert frozen['source_sha256'] == source_hash()
lines = subprocess.check_output(['nm', '-S', '-C', str(exe)], text=True).splitlines()
selected = {}
for kind in ['scatter', 'dense']:
    for context in [False, True]:
        matches = []
        for line in lines:
            if 'Packed<u32, u8,' not in line or 'Masked<' in line:
                continue
            if (', true>' in line) != context:
                continue
            valid = ('Sorter<u32>>::scatter' in line and 'scatter_grouped' not in line) if kind == 'scatter' else ('frontier::dense::<u32, u8,' in line or 'frontier::dense<u32, u8,' in line)
            if not valid or (context and 'run::trampoline' not in line):
                continue
            matches.append(line)
        assert len(matches) == 1, (kind, context, matches)
        line = matches[0]
        start, size, *_ = line.split(maxsplit=3)
        dump = subprocess.check_output(['objdump', '-d', f'--start-address={int(start, 16)}', f'--stop-address={int(start, 16) + int(size, 16)}', str(exe)], text=True)
        label = f'{a.prefix}-u32-{kind}-' + ('context' if context else 'scalar')
        (ROOT / 'validation' / (label + '.txt')).write_text(line + '\n' + dump)
        result = dict(symbol=line, pext=[x.strip() for x in dump.splitlines() if '\tpext ' in x], extraction_calls=[x.strip() for x in dump.splitlines() if 'call' in x and 'pext_u' in x])
        if context:
            assert result['pext'] and not result['extraction_calls']
        else:
            assert result['extraction_calls'] and not result['pext']
        selected[label] = result
        print(label, 'direct_pext', len(result['pext']), 'outlined_calls', len(result['extraction_calls']))
(ROOT / 'validation' / (a.prefix + '-codegen.json')).write_text(json.dumps(dict(frozen=frozen, symbols=selected), indent=2) + '\n')
