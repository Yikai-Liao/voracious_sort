#!/usr/bin/env python3
"""Paired, whole-sort comparison of one frozen candidate with the original."""
import argparse
import hashlib
import json
import math
import os
from pathlib import Path
import random
import re
import subprocess
import time

ROOT = Path(__file__).resolve().parent
WIDTHS = dict(u32=4, i32=4, f32=4, u64=8, i64=8, f64=8,
              u128=16, record32=32, record128=128)
SEED = 0x6A09E667F3BCC909


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def block_length(case):
    size = WIDTHS[case['kind']]
    return max(1, 1024 // size, math.ceil(4 * math.sqrt(9 * case['n'] / (512 * size))))


def vmstat():
    values = dict(line.split() for line in Path('/proc/vmstat').read_text().splitlines())
    return {k: int(values[k]) for k in ['pswpin', 'pswpout', 'pgmajfault', 'oom_kill']}


def freeze(stage):
    assert not (stage / 'manifest.json').exists(), 'Stage is already frozen'
    cases = json.loads((stage / 'cases.json').read_text())
    assert len({(c['kind'], c['dist'], c['n']) for c in cases}) == len(cases)
    random.Random(20261022).shuffle(cases)
    for case in cases:
        case['block'] = block_length(case)
    files = [ROOT / 'run_screen.py', stage / 'cases.json', stage / 'candidate.diff',
             stage / 'benchmark-time', stage / 'benchmark-memory']
    files += [p for p in (stage / 'harness').rglob('*') if p.is_file()
              and not {'target', '__pycache__'}.intersection(p.relative_to(stage).parts)]
    manifest = dict(
        original_commit='e649c6af49d6bfdde896ca40cad387235fce4bfa',
        original_branch='origin/archive/block-lsd-original-20261018',
        created_utc=time.strftime('%Y-%m-%dT%H:%M:%SZ', time.gmtime()),
        schedule=cases, methods=['block_before', 'block_after', 'block_before_aa'],
        selection='max(1, floor(1024/s), ceil(4*sqrt(9*n/(512*s))))',
        radix=8, seed=SEED, cpu=[2], threads=1,
        timing='Complete sort including probes and allocation; block selection, clone, and full stable oracle excluded',
        cache='One untimed warmup; independent cloned inputs; 3 ms target, 64 MiB/2048 buffer cap',
        repetitions='3 seeds, each with forward/reversed method order; same-function baseline A/A alias',
        interpretation='Per-case effects and A/A are descriptive; a small aggregate improvement cannot excuse repeatable case losses',
        memory='Separate instrumented binary: peak live requested heap during sort, excluding input/harness/allocator metadata',
        files={os.path.relpath(p, stage): sha(p) for p in files},
        rustc=subprocess.check_output(['/root/.cargo/bin/rustc', '-Vv'], text=True),
        rustflags='-C target-cpu=native', profile='opt-level=3, codegen-units=1, lto=thin',
        vmstat_start=vmstat())
    (stage / 'manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')
    print(f'Frozen {len(cases)} conditions, {len(cases)*18} time and {len(cases)*9} memory observations')


def run(stage, mode):
    manifest = json.loads((stage / 'manifest.json').read_text())
    for name, digest in manifest['files'].items():
        assert sha(stage / name) == digest, name
    out = stage / f'{mode}.jsonl'
    assert not out.exists(), 'Refusing to append a duplicate run'
    started = time.time()
    for i, case in enumerate(manifest['schedule'], 1):
        methods = ','.join(f'{a}:{case["block"]}' for a in manifest['methods'])
        args = ['taskset', '-c', '2', '/usr/bin/time', '-f', 'RESOURCE %M %F %W %x',
                str(stage / f'benchmark-{mode}'), mode, case['kind'], case['dist'],
                str(case['n']), str(SEED), '8', str(case['block']), '3', methods]
        before = vmstat(); start = time.time()
        proc = subprocess.run(args, capture_output=True, text=True,
                              env={**os.environ, 'RAYON_NUM_THREADS': '1'})
        after = vmstat()
        meta = dict(case=case, command=args, returncode=proc.returncode,
                    start_unix=start, wall_seconds=time.time()-start,
                    stderr=proc.stderr, vmstat_delta={k: after[k]-before[k] for k in before})
        with (stage / f'{mode}-processes.jsonl').open('a') as f:
            f.write(json.dumps(meta) + '\n')
        assert proc.returncode == 0, proc.stderr
        assert int(re.search(r'VmSwap:\s+(\d+)', proc.stderr).group(1)) == 0
        rows = [json.loads(line) for line in proc.stdout.splitlines()]
        assert len(rows) == (18 if mode == 'time' else 9)
        for row in rows:
            assert row['valid'] and row['ordered'] and row['preserved'], row
            assert row['block'] == case['block']
            if mode == 'memory':
                bound = 512*row['block']*row['bytes_per_record'] + 9*(row['n']//row['block']) + 66*256
                assert row['peak_bytes'] <= bound, (row, bound)
        assert len({(r['pair'], r['input_digest']) for r in rows}) == 3
        with out.open('a') as f:
            for row in rows:
                f.write(json.dumps(row) + '\n')
        print(f'{mode} {i}/{len(manifest["schedule"])} {case["kind"]} {case["dist"]} n={case["n"]} elapsed={time.time()-started:.1f}s', flush=True)
    (stage / f'{mode}-completion.json').write_text(json.dumps(dict(
        wall_seconds=time.time()-started, vmstat_end=vmstat(), observations=len(manifest['schedule'])*(18 if mode=='time' else 9)), indent=2)+'\n')


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('stage')
    parser.add_argument('mode', choices=['freeze', 'time', 'memory'])
    args = parser.parse_args()
    stage = ROOT / args.stage
    freeze(stage) if args.mode == 'freeze' else run(stage, args.mode)
