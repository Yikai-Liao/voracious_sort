#!/usr/bin/env python3
"""Summarize same-run medians without deriving a parameter selection policy."""
import argparse
import csv
from collections import defaultdict
from pathlib import Path
from statistics import median

parser = argparse.ArgumentParser()
parser.add_argument('input', type=Path)
parser.add_argument('--csv', type=Path)
parser.add_argument('--max-n', type=int)
args = parser.parse_args()
samples = defaultdict(list)
heap = {}
statuses = defaultdict(int)
with args.input.open() as source:
    for row in csv.DictReader(source):
        statuses[row['status']] += 1
        if row['status'] != 'ok':
            continue
        if args.max_n is not None and int(row['n']) > args.max_n:
            continue
        key = (row['workload'], row['distribution'], int(row['n']), row['algorithm'])
        samples[key].append(int(row['ns']))
        heap[key] = int(row['peak_extra_bytes'])
times = {key: median(values) for key, values in samples.items()}
rows = []
for workload, distribution, n in sorted({key[:3] for key in times}):
    algorithm = ('rust_block_lsd' if workload == 'u32_pair8'
                 else 'rust_block_lsd_4k')
    key = (workload, distribution, n, algorithm)
    if key not in times:
        continue
    row = dict(workload=workload, distribution=distribution, n=n,
               algorithm=algorithm, samples=len(samples[key]),
               block_ns=times[key], block_heap=heap[key])
    for baseline in ['rust_lsd', 'rust_lsd_stable', 'rust_msd_stable', 'c_permuted']:
        other = (workload, distribution, n, baseline)
        row[baseline + '_ns'] = times.get(other, '')
        row[baseline + '_heap'] = heap.get(other, '')
        row[baseline + '_ratio'] = times[key] / times[other] if other in times else ''
    rows.append(row)
if args.csv:
    with args.csv.open('w') as destination:
        writer = csv.DictWriter(destination, fieldnames=list(rows[0]))
        writer.writeheader()
        writer.writerows(rows)
print('Input statuses: ' + ', '.join(f'{name}={count}' for name, count in statuses.items()))
print('\nRatios are block time / baseline time; values below 1 favor block.')
print('The block configuration is fixed at 4 KiB for this comparison, not selected per case.')
print('\n| Workload | Distribution | n | Block ms | Ordinary LSD ratio | Stable LSD ratio | MSD ratio | Block MiB |')
print('|---|---|---:|---:|---:|---:|---:|---:|')
for row in rows:
    ratios = [row[name + '_ratio'] for name in ['rust_lsd', 'rust_lsd_stable', 'rust_msd_stable']]
    cells = [f'{value:.3f}' if value != '' else '—' for value in ratios]
    print(f"| {row['workload']} | {row['distribution']} | {row['n']} | "
          f"{row['block_ns']/1e6:.6f} | {' | '.join(cells)} | {row['block_heap']/2**20:.3f} |")
