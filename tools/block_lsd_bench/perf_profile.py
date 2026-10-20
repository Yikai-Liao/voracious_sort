#!/usr/bin/env python3
"""Count only sorting regions, with perf FIFO enable/disable acknowledgments."""
import argparse
import os
from pathlib import Path
import subprocess
import tempfile

parser = argparse.ArgumentParser()
parser.add_argument('--perf', default='perf')
parser.add_argument('--binary', default='tools/block_lsd_bench/target/release/block_lsd_bench')
parser.add_argument('--type', choices=['u32', 'u64', 'u128', 'fat128'], default='u64')
parser.add_argument('--algorithm', type=int, default=5)
parser.add_argument('--n', type=int, default=1000000)
parser.add_argument('--repeats', type=int, default=20)
parser.add_argument('--record', action='store_true')
parser.add_argument('--events', default='cycles:u,instructions:u,branches:u,branch-misses:u,cache-references:u,cache-misses:u')
parser.add_argument('--output', required=True)
args = parser.parse_args()
with tempfile.TemporaryDirectory(prefix='block-radix-perf-') as tmp:
    control, ack = Path(tmp)/'control', Path(tmp)/'ack'
    os.mkfifo(control)
    os.mkfifo(ack)
    env = dict(os.environ, PERF_CONTROL=str(control), PERF_ACK=str(ack))
    mode = ['record', '-e', 'cycles:u', '-F', '999', '-g', '-o', args.output] if args.record else [
        'stat', '-x', ',', '-o', args.output, '-e', args.events]
    command = ['taskset', '-c', '0', args.perf, *mode, '--delay=-1',
        f'--control=fifo:{control},{ack}', '--', args.binary, '--profile',
        args.type, str(args.algorithm), str(args.n), str(args.repeats), 'uniform']
    subprocess.run(command, env=env, check=True, timeout=180)
