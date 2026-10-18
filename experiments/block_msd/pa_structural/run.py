#!/usr/bin/env python3
"""Run immutable evidence executables; record source, input and resource metadata."""
import argparse
import hashlib
import json
from pathlib import Path
import resource
import subprocess
import time

ROOT = Path(__file__).resolve().parent
REPO = ROOT.parents[2]
BASE = 'Pa_unified_groups_t16777216'

def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()

def source_hash():
    paths = sorted((REPO / 'experiments/block_msd/src').rglob('*.rs'))
    paths += sorted((REPO / 'src').rglob('*.rs'))
    paths += [REPO / 'Cargo.toml', REPO / 'Cargo.lock', REPO / 'experiments/block_msd/Cargo.toml', REPO / 'experiments/block_msd/Cargo.lock']
    return hashlib.sha256(''.join(str(p.relative_to(REPO)) + ':' + digest(p) + '\n' for p in paths).encode()).hexdigest()

def main():
    p = argparse.ArgumentParser(__doc__)
    p.add_argument('name')
    p.add_argument('--binary', default='screen')
    p.add_argument('--n', type=int, default=1048576)
    p.add_argument('--reps', type=int, default=12)
    p.add_argument('--block', type=int, default=64)
    p.add_argument('--seed', type=int, default=42)
    p.add_argument('--cpu', default='2')
    p.add_argument('--kind', default='time', choices=['time', 'work', 'memory'])
    p.add_argument('--methods', default=f'{BASE},Pa_packed,Pa_packed_aggressive,Rollercoaster,L_frozen,{BASE}')
    p.add_argument('--cases', default='uniform,sparse')
    p.add_argument('--layouts', default='u32,u64,u128,wide32,large128')
    a = p.parse_args()
    if 'reverse_unique' in a.cases.split(','):
        bits = {'u8':8, 'u8_id8':8, 'u16':16, 'u16_id8':16, 'u32':32, 'small8':32, 'large128':32, 'u64':64, 'u128':128, 'wide32':128}
        if any(a.n > (1 << bits[layout]) - 1 for layout in a.layouts.split(',')):
            p.error('reverse_unique needs enough distinct key values for n; use wide layouts or reduce n')
    binary = REPO / 'experiments/block_msd/target/pa-structural' / a.binary
    frozen = json.loads(Path(str(binary) + '.json').read_text())
    assert frozen['sha256'] == digest(binary)
    assert frozen['source_sha256'] == source_hash(), 'source differs from frozen executable'
    for path, sha256 in frozen.get('extra_sources', {}).items():
        assert digest(REPO/path) == sha256, f'extra source differs from frozen executable: {path}'
    output = ROOT / 'measurements' / f'{a.name}.csv'
    output.parent.mkdir(exist_ok=True)
    assert not output.exists(), f'refusing to overwrite {output}'
    command = ['taskset', '-c', a.cpu, str(binary), str(a.n), str(a.reps), a.methods, a.cases, a.layouts, a.kind, str(a.block), str(a.seed)]
    meta = dict(command=command, args=vars(a), frozen=frozen, started_ns=time.time_ns(), meminfo_before=Path('/proc/meminfo').read_text(), load_before=Path('/proc/loadavg').read_text(), vmstat_before=Path('/proc/vmstat').read_text())
    with output.open('w') as out, output.with_suffix('.stderr').open('w') as err:
        result = subprocess.run(command, cwd=REPO, stdout=out, stderr=err)
    meta.update(returncode=result.returncode, ended_ns=time.time_ns(), meminfo_after=Path('/proc/meminfo').read_text(), load_after=Path('/proc/loadavg').read_text(), vmstat_after=Path('/proc/vmstat').read_text())
    usage = resource.getrusage(resource.RUSAGE_CHILDREN)
    meta['usage'] = {k: getattr(usage, k) for k in ['ru_utime','ru_stime','ru_maxrss','ru_minflt','ru_majflt','ru_nivcsw']}
    output.with_suffix('.json').write_text(json.dumps(meta, indent=2) + '\n')
    result.check_returncode()
    print(a.name, round((meta['ended_ns'] - meta['started_ns']) / 1e9, 2), flush=True)

if __name__ == '__main__':
    main()
