#!/usr/bin/env python3
"""Fixed independent source deltas, each using immutable complete executables."""
import argparse
import csv
import hashlib
import io
import json
from pathlib import Path
import subprocess
import time

ROOT = Path(__file__).resolve().parent
REPO = ROOT.parents[2]
GROUP = 'Pa_unified_groups_t16777216'
CONFIG = {
    'outline': ('pa_groups_final', 'pa_outline_final', 'pa-groups-final', 'pa-outline-final', (
        (1048576, 64, 'small8', 'uniform'), (1048576, 512, 'small8', 'uniform'),
        (1048576, 64, 'u64', 'uniform'), (1048576, 64, 'u16', 'sparse'))),
    'equality': ('pa_outline_final', 'pa_equal_bits', 'pa-outline-final', 'pa-equal-bits', (
        (16384, 64, 'u128', 'equal'), (16384, 64, 'wide32', 'equal'),
        (1048576, 64, 'u128', 'equal'), (1048576, 64, 'wide32', 'equal'))),
    'wide_order': ('pa_equal_bits', 'pa_order_branch', 'pa-equal-bits', 'pa-order-branch', (
        (16384, 64, 'u128', 'sorted'), (16384, 64, 'wide32', 'sorted'),
        (1048576, 64, 'u128', 'sorted'), (1048576, 64, 'wide32', 'sorted'),
        (1048576, 64, 'u8', 'sorted'), (1048576, 64, 'u16', 'sorted'))),
}
REPS = 16


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    parser = argparse.ArgumentParser(__doc__)
    parser.add_argument('experiment', choices=CONFIG)
    args = parser.parse_args()
    before_dir, after_dir, before_bin, after_bin, cells = CONFIG[args.experiment]
    folders = [ROOT.parent / before_dir, ROOT.parent / after_dir]
    binaries = [REPO / 'experiments/block_msd/target' / name / 'time'
                for name in (before_bin, after_bin)]
    hashes = {str(p.relative_to(REPO)): digest(p) for p in binaries}
    releases = []
    for folder, binary in zip(folders, binaries):
        frozen = dict((line.split('  ', 1)[1], line.split('  ', 1)[0])
                      for line in (folder / 'binary-sha256.txt').read_text().splitlines())
        assert frozen[str(binary.relative_to(REPO))] == digest(binary)
        releases.append(json.loads((folder / 'build-settings.json').read_text())['release'])
    assert releases[0] == releases[1], releases
    slots = ((binaries[0], GROUP, 'before'), (binaries[1], GROUP, 'after'),
             (binaries[1], 'stable_msd', 'stable'), (binaries[0], GROUP, 'before'))
    dest = ROOT / 'pairs' / args.experiment
    dest.mkdir(parents=True, exist_ok=True)
    for n, block, layout, case in cells:
        base = dest / f'n{n}-b{block}-{layout}-{case}-s42'
        assert not base.with_suffix('.csv').exists(), base
        metadata = dict(experiment=args.experiment, n=n, block=block, layout=layout,
            case=case, seed=42, started_ns=time.time_ns(), binary_sha256=hashes,
            source_before=(folders[0] / 'source-commit.txt').read_text().strip(),
            source_after=(folders[1] / 'source-commit.txt').read_text().strip(),
            release=releases[0], slot_builds=[x[2] for x in slots], reps=REPS,
            input_note='same frozen deterministic input and oracle; ASLR addresses differ across child processes',
            commands=[], load_before=Path('/proc/loadavg').read_text())
        writer = None
        with base.with_suffix('.csv').open('w', newline='') as out:
            for rep in range(REPS):
                rotation = (rep // 2) % 4
                order = list(range(4))[rotation:] + list(range(4))[:rotation]
                if rep % 2:
                    order.reverse()
                for position, slot in enumerate(order):
                    executable, method, build = slots[slot]
                    argv = ['taskset', '-c', '2', str(executable), str(n), '1',
                            method, case, layout, 'time', str(block), '42']
                    start = time.time_ns()
                    result = subprocess.run(argv, cwd=REPO, capture_output=True, text=True)
                    metadata['commands'].append(dict(outer_rep=rep, outer_slot=slot,
                        position=position, argv=argv, started_ns=start,
                        ended_ns=time.time_ns(), returncode=result.returncode))
                    assert result.returncode == 0 and not result.stderr, (argv, result.stderr)
                    rows = list(csv.DictReader(io.StringIO(result.stdout)))
                    assert len(rows) == 1
                    row = rows[0]
                    assert row['method'] == method and row['rep'] == row['slot'] == '0'
                    assert row['kind'] == 'time' and row['instrumented'] == 'false'
                    assert (row['layout'], row['case'], row['n'], row['block'], row['seed']) == (layout, case, str(n), str(block), '42')
                    assert int(row['wall_ns']) > 0 and int(row['cpu_ns']) > 0
                    row.update(build=build, outer_rep=rep, outer_slot=slot, position=position)
                    if writer is None:
                        writer = csv.DictWriter(out, fieldnames=list(row))
                        writer.writeheader()
                    writer.writerow(row)
                    out.flush()
        metadata.update(ended_ns=time.time_ns(), load_after=Path('/proc/loadavg').read_text())
        for filename, expected in hashes.items():
            assert digest(REPO / filename) == expected
        base.with_suffix('.json').write_text(json.dumps(metadata, indent=2) + '\n')
        print(args.experiment, base.name, 64, 'oracle rows', flush=True)


if __name__ == '__main__':
    main()
