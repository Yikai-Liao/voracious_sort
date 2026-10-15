#!/usr/bin/env python3
"""Sequential native measurements; correctness/oracle checks live in each driver."""
import argparse
import csv
import os
from pathlib import Path
import subprocess
import time

HERE = Path(__file__).resolve().parent
ROOT = HERE.parent
NATIVE = Path(os.environ.get('MSD_REDUCTION_NATIVE', '/tmp/block-msd-reduction-native/release'))
DIAGNOSTIC = Path(os.environ.get('MSD_REDUCTION_DIAGNOSTIC', '/tmp/block-msd-reduction-diagnostic/release'))
CPU = os.environ.get('MSD_CPU', '0')
LOADS = 'uniform,deep_skew,skew95,shared_prefix,sorted,descending,reverse_unique,digit_grouped,digit_tail_inversion,almost_sorted'
TYPES = 'u32,u64,u128,wide32,large128'
CORE = ['local_free','reduction_control','cached_two_arrays','cycle_placement','hybrid','hybrid_control','hybrid_prepared','hybrid_mono','hybrid_independent_mono','hybrid_fused_mono','block_lsd','block_lsd512','ordinary','stable_fixed','std_stable']


def run_file(label, n, repeats, loads=LOADS, types=TYPES, methods='core', diagnostic=False):
    binary = (DIAGNOSTIC if diagnostic else NATIVE) / 'work_reduction_experiment'
    path = HERE / f'{label}-{n}.csv'
    start = time.monotonic()
    args = ['taskset','-c',CPU,str(binary),str(n),str(repeats),'64',loads,types,methods]
    with path.open('w', newline='') as output:
        subprocess.run(args, stdout=output, check=True)
    with path.open(newline='') as data:
        rows = list(csv.DictReader(data))
    expected_methods = CORE if methods == 'core' else (['reduction_control','cached_two_arrays','cycle_placement','hybrid_control','hybrid_prepared','hybrid_independent_mono','hybrid_fused_mono'] if methods == 'diagnostics' else methods.split(','))
    assert {r['algorithm'] for r in rows} == set(expected_methods)
    expected = len(types.split(','))*len(loads.split(','))*len(expected_methods)*(1 if diagnostic else repeats)
    assert len(rows) == expected, (path, len(rows), expected)
    assert all(None not in r and None not in r.values() for r in rows), path
    print(f'{path.name}: {len(rows)} rows; {time.monotonic()-start:.1f}s; PASS', flush=True)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('suite', choices=['pilot','full','diagnostics','boundaries','kernels','combined'])
    args = parser.parse_args()
    if args.suite == 'pilot':
        for n in (1024, 16384):
            run_file('smoke',n,1,'uniform,deep_skew,digit_grouped,digit_tail_inversion','u32,wide32,large128')
        run_file('pilot',1048576,5,'uniform,deep_skew,digit_grouped,digit_tail_inversion','u32,wide32,large128')
    elif args.suite == 'full':
        for n in (1024,16384,262144,1048576):
            run_file('normal',n,15)
    elif args.suite == 'diagnostics':
        for n in (1024,16384,262144,1048576):
            run_file('diagnostics',n,0,methods='diagnostics',diagnostic=True)
    elif args.suite == 'boundaries':
        methods='local_free,reduction_control,cached_two_arrays,cycle_placement,hybrid_control,hybrid_prepared,hybrid_independent_mono,hybrid_fused_mono'
        for n in (127,128,129,255,256,257,511,512,513,1023,1024,1025,16383,16384,16385,32767,32768,32769):
            run_file('dyadic',n,8,'uniform,deep_skew',methods=methods)
        # Exact frozen cache_fits root cutoffs for the five native layouts.
        for layout, limit in [('u32',28608),('u64',12736),('u128',4800),('wide32',2368),('large128',832)]:
            for n in (limit-1,limit,limit+1):
                run_file('cache-'+layout,n,8,'uniform,deep_skew',layout,methods)
    elif args.suite == 'kernels':
        with (HERE/'kernel-comparison.csv').open('w') as output:
            subprocess.run(['taskset','-c',CPU,str(NATIVE/'work_kernel_experiment'),'100'],stdout=output,check=True)
        print('kernel-comparison.csv: PASS',flush=True)
    elif args.suite == 'combined':
        # Run only after independent results justify both combinations.
        methods='local_free,reduction_control,cached_two_arrays,cycle_placement,two_arrays_cycles,hybrid_control,hybrid_prepared,hybrid_independent_mono,hybrid_fused_mono,hybrid_prepared_fused,block_lsd,block_lsd512,ordinary,stable_fixed,std_stable'
        for n in (1024,16384,262144,1048576):
            run_file('combined',n,15,methods=methods)


if __name__ == '__main__':
    main()
