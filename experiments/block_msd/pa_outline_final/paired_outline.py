#!/usr/bin/env python3
"""Pair immutable pre/post-outline full ELFs; each child runs its stable oracle."""
import csv
import hashlib
import io
import json
import os
from pathlib import Path
import subprocess
import time

ROOT = Path(__file__).resolve().parent
REPO = ROOT.parents[2]
OLD = REPO / 'experiments/block_msd/target/pa-groups-final/time'
NEW = REPO / 'experiments/block_msd/target/pa-outline-final/time'
GROUP = 'Pa_unified_groups_t16777216'
SLOTS = ((OLD, GROUP, 'before'), (NEW, GROUP, 'outlined'),
         (NEW, 'stable_msd', 'stable'), (OLD, GROUP, 'before'))
CELLS = ((64, 'small8', 'uniform'), (512, 'small8', 'uniform'),
         (64, 'u64', 'uniform'), (64, 'u16', 'sparse'))
REPS = 16


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    dest = ROOT / 'pairs'
    dest.mkdir(exist_ok=True)
    hashes = {str(path.relative_to(REPO)): digest(path) for path in (OLD, NEW)}
    for folder, binary in ((ROOT.parent / 'pa_groups_final', OLD), (ROOT, NEW)):
        frozen = dict((line.split('  ', 1)[1], line.split('  ', 1)[0])
                      for line in (folder / 'binary-sha256.txt').read_text().splitlines())
        assert frozen[str(binary.relative_to(REPO))] == digest(binary)
    for block, layout, case in CELLS:
        base = dest / f'b{block}-{layout}-{case}-s42'
        assert not base.with_suffix('.csv').exists(), base
        metadata = {'started_ns': time.time_ns(), 'binary_sha256': hashes,
                    'source_before': (ROOT.parent / 'pa_groups_final/source-commit.txt').read_text().strip(),
                    'source_outlined': (ROOT / 'source-commit.txt').read_text().strip(),
                    'slot_builds': [x[2] for x in SLOTS], 'reps': REPS,
                    'input_note': 'same deterministic input and full oracle; ASLR addresses differ across processes',
                    'commands': [], 'load_before': Path('/proc/loadavg').read_text()}
        writer = None
        with base.with_suffix('.csv').open('w', newline='') as out:
            for rep in range(REPS):
                order = list(range(len(SLOTS)))
                rotation = (rep // 2) % len(SLOTS)
                order = order[rotation:] + order[:rotation]
                if rep % 2:
                    order.reverse()
                for position, slot in enumerate(order):
                    executable, method, build = SLOTS[slot]
                    command = ['taskset', '-c', '2', str(executable), '1048576', '1',
                               method, case, layout, 'time', str(block), '42']
                    start = time.time_ns()
                    result = subprocess.run(command, cwd=REPO, capture_output=True, text=True)
                    metadata['commands'].append({'outer_rep': rep, 'outer_slot': slot,
                        'position': position, 'argv': command, 'started_ns': start,
                        'ended_ns': time.time_ns(), 'returncode': result.returncode})
                    assert result.returncode == 0 and not result.stderr, (command, result.returncode, result.stderr)
                    rows = list(csv.DictReader(io.StringIO(result.stdout)))
                    assert len(rows) == 1, (command, rows)
                    row = rows[0]
                    assert row['method'] == method and row['rep'] == '0' and row['slot'] == '0'
                    assert row['kind'] == 'time' and row['instrumented'] == 'false'
                    assert (row['layout'], row['case'], row['n'], row['block'], row['seed']) == (layout, case, '1048576', str(block), '42')
                    assert int(row['wall_ns']) > 0 and int(row['cpu_ns']) > 0
                    row.update(build=build, outer_rep=rep, outer_slot=slot, position=position)
                    if writer is None:
                        writer = csv.DictWriter(out, fieldnames=list(row))
                        writer.writeheader()
                    writer.writerow(row)
                    out.flush()
        metadata.update(ended_ns=time.time_ns(), load_after=Path('/proc/loadavg').read_text())
        for filename, expected in hashes.items():
            assert digest(REPO / filename) == expected, filename
        base.with_suffix('.json').write_text(json.dumps(metadata, indent=2) + '\n')
        print(base.name, REPS * len(SLOTS), 'oracle rows', flush=True)


if __name__ == '__main__':
    main()
