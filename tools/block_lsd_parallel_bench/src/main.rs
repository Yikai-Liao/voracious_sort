use rayon::{prelude::*, ThreadPool, ThreadPoolBuilder};
use std::{cmp::Ordering, hint::black_box, time::Instant};
use voracious_radix_sort::{
    block_lsd_stable_mt_radixsort_in_pool, block_lsd_stable_radixsort,
    lsd_stable_radixsort, RadixKey, RadixSort, Radixable,
};

#[repr(C)]
#[derive(Clone, Copy, Debug)]
struct Record<K, const N: usize> {
    key: K,
    payload: [u32; N],
}
impl<K: PartialEq, const N: usize> PartialEq for Record<K, N> {
    fn eq(&self, other: &Self) -> bool {
        self.key == other.key
    }
}
impl<K: PartialOrd, const N: usize> PartialOrd for Record<K, N> {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        self.key.partial_cmp(&other.key)
    }
}
macro_rules! keys { ($($t:ty),*) => { $(
    impl<const N: usize> Radixable<$t> for Record<$t, N> {
        type Key = $t;
        fn key(&self) -> $t { self.key }
    }
    impl Sample for $t { fn sample(x: u128) -> Self { x as Self } }
)* } }
trait Sample {
    fn sample(x: u128) -> Self;
}
keys!(u32, u64, u128);
extern "C" {
    fn parallel_sort(pairs: *mut Record<u32, 1>, n: usize);
    fn permuted_sort(pairs: *mut Record<u32, 1>, n: usize);
    fn omp_set_dynamic(dynamic: i32);
    fn omp_set_num_threads(threads: i32);
    fn benchmark_omp_cpus(cpus: *mut i32);
    fn sched_getcpu() -> i32;
    fn sched_setaffinity(pid: i32, size: usize, mask: *const u8) -> i32;
}
fn pin(cpu: usize) {
    let mut mask = [0u8; 128];
    mask[cpu / 8] |= 1 << (cpu % 8);
    assert_eq!(
        unsafe { sched_setaffinity(0, mask.len(), mask.as_ptr()) },
        0,
        "CPU affinity failed"
    );
}
fn prepare_affinity(method: usize, threads: usize) {
    let cpus: Vec<usize> = std::env::var("BENCH_CPUS")
        .unwrap_or_else(|_| "0,2,4,6,8,10,12,14,1,3,5,7,9,11,13,15".to_string())
        .split(',')
        .map(|s| s.parse().unwrap())
        .collect();
    let mut mask = [0u8; 128];
    for &cpu in &cpus[..if method == 4 { threads } else { 1 }] {
        mask[cpu / 8] |= 1 << (cpu % 8);
    }
    assert_eq!(unsafe { sched_setaffinity(0, mask.len(), mask.as_ptr()) }, 0);
}
fn c_parallel(arr: &mut [Record<u32, 1>]) {
    unsafe {
        parallel_sort(arr.as_mut_ptr(), arr.len());
    }
}
fn c_serial(arr: &mut [Record<u32, 1>]) {
    unsafe {
        permuted_sort(arr.as_mut_ptr(), arr.len());
    }
}
const METHODS: [&str; 7] = [
    "rayon_block",
    "serial_block",
    "serial_lsd",
    "rayon_stable",
    "repo_mt",
    "c_parallel",
    "c_permuted",
];
fn run<K: RadixKey, const N: usize>(
    arr: &mut [Record<K, N>],
    method: usize,
    block: usize,
    pool: &ThreadPool,
    c: Option<fn(&mut [Record<K, N>])>,
    threads: usize,
) where
    Record<K, N>: Radixable<K>,
{
    match method {
        0 => block_lsd_stable_mt_radixsort_in_pool(arr, 8, block, pool),
        1 => block_lsd_stable_radixsort(arr, 8, block),
        2 => lsd_stable_radixsort(arr, 8),
        3 => pool.install(|| arr.par_sort_by_key(|item| item.into_key_type())),
        4 => arr.voracious_mt_sort(threads),
        5 | 6 => c.unwrap()(arr),
        _ => unreachable!(),
    }
}
fn input<K: Sample, const N: usize>(n: usize, load: &str) -> Vec<Record<K, N>> {
    let mut state = 0x517cc1b727220a95b7e151628aed2a6bu128;
    (0..n)
        .map(|i| {
            state ^= state << 13;
            state ^= state >> 7;
            state ^= state << 17;
            let key = match load {
                "uniform" => state,
                "duplicates" => state % 256,
                "skew" => {
                    if i % 20 != 0 {
                        0
                    } else {
                        state
                    }
                },
                _ => panic!("unknown load"),
            };
            let mut payload = [0u32; N];
            for (j, word) in payload.iter_mut().enumerate() {
                *word = (i as u32).wrapping_mul(17).wrapping_add(j as u32);
            }
            payload[0] = i as u32;
            Record { key: K::sample(key), payload }
        })
        .collect()
}
fn check<K: RadixKey, const N: usize>(
    arr: &[Record<K, N>],
    original: &[Record<K, N>],
    expected: &[Record<K, N>],
    stable: bool,
) where
    Record<K, N>: Radixable<K>,
{
    if stable {
        assert!(arr
            .iter()
            .zip(expected)
            .all(|(a, b)| a.into_key_type() == b.into_key_type()
                && a.payload == b.payload));
    } else {
        let mut seen = vec![false; original.len()];
        for (i, item) in arr.iter().enumerate() {
            if i != 0 {
                assert!(arr[i - 1].into_key_type() <= item.into_key_type());
            }
            let ordinal = item.payload[0] as usize;
            assert!(!seen[ordinal]);
            seen[ordinal] = true;
            assert!(
                item.into_key_type() == original[ordinal].into_key_type()
                    && item.payload == original[ordinal].payload
            );
        }
    }
}
fn bench<K: RadixKey + Sample, const N: usize>(
    name: &str,
    n: usize,
    samples: usize,
    threads: usize,
    pool: &ThreadPool,
    c: Option<fn(&mut [Record<K, N>])>,
    c_seq: Option<fn(&mut [Record<K, N>])>,
) where
    Record<K, N>: Radixable<K>,
{
    let block = (4096 / std::mem::size_of::<Record<K, N>>()).max(1);
    let requested = std::env::var("METHODS").unwrap_or_else(|_| "rayon_block,serial_block,serial_lsd,rayon_stable,repo_mt,c_parallel,c_permuted".to_string());
    let methods: Vec<_> = (0..METHODS.len())
        .filter(|&m| {
            requested.split(',').any(|s| s == METHODS[m])
                && (m < 5 || c.is_some())
                && (threads == 1 || ![1, 2, 6].contains(&m))
        })
        .collect();
    for load in std::env::var("LOADS")
        .unwrap_or_else(|_| "uniform,duplicates,skew".to_string())
        .split(',')
    {
        let original = input::<K, N>(n, load);
        let mut expected = original.clone();
        expected.sort_by_key(|item| item.into_key_type());
        // Warm every method, including both runtimes, before measured sorts.
        for &method in &methods {
            let mut arr = original.clone();
            prepare_affinity(method, threads);
            run(
                &mut arr,
                method,
                block,
                pool,
                if method == 6 { c_seq } else { c },
                threads,
            );
            check(&arr, &original, &expected, method != 4);
        }
        for sample in 0..samples {
            for order in 0..methods.len() {
                let method = methods[(sample + order) % methods.len()];
                let mut arr = original.clone();
                prepare_affinity(method, threads);
                let start = Instant::now();
                run(
                    black_box(&mut arr),
                    method,
                    block,
                    pool,
                    if method == 6 { c_seq } else { c },
                    threads,
                );
                let ns = start.elapsed().as_nanos();
                check(&arr, &original, &expected, method != 4);
                println!(
                    "{},{},{},{},{},{},{},{},{},ok",
                    name,
                    std::mem::size_of::<Record<K, N>>(),
                    n,
                    load,
                    METHODS[method],
                    threads,
                    block,
                    sample,
                    ns
                );
            }
        }
    }
}
fn main() {
    // Linux-specific pinning is confined to the benchmark, not the library.
    let args: Vec<_> = std::env::args().collect();
    let name = &args[1];
    let samples: usize = args[2].parse().unwrap();
    let threads: usize = args[3].parse().unwrap();
    let cpus: Vec<usize> = std::env::var("BENCH_CPUS")
        .unwrap_or_else(|_| "0,2,4,6,8,10,12,14,1,3,5,7,9,11,13,15".to_string())
        .split(',')
        .map(|s| s.parse().unwrap())
        .collect();
    assert!(samples > 0 && threads > 0 && threads <= cpus.len());
    pin(cpus[0]);
    // OpenMP reads OMP_PLACES before main; the driver supplies its environment.
    unsafe {
        omp_set_dynamic(0);
        omp_set_num_threads(threads as i32);
    }
    let worker_cpus = cpus.clone();
    let pool = ThreadPoolBuilder::new()
        .num_threads(threads)
        .start_handler(move |i| pin(worker_cpus[i]))
        .build()
        .unwrap();
    let mut omp_cpus = vec![-1i32; threads];
    unsafe {
        benchmark_omp_cpus(omp_cpus.as_mut_ptr());
    }
    let rayon_cpus = pool.broadcast(|_| unsafe { sched_getcpu() });
    let expected: Vec<_> =
        cpus[..threads].iter().map(|&cpu| cpu as i32).collect();
    assert_eq!(
        omp_cpus, expected,
        "set OMP_PLACES before starting the executable"
    );
    assert_eq!(rayon_cpus, expected, "Rayon placement failed");
    eprintln!(
        "threads={} rayon_cpus={:?} omp_cpus={:?}",
        threads, rayon_cpus, omp_cpus
    );
    println!("layout,record_bytes,n,distribution,algorithm,threads,block_size,sample,ns,status");
    for n in args[4..].iter().map(|s| s.parse::<usize>().unwrap()) {
        assert!(n > 128 && n <= u32::MAX as usize);
        match name.as_str() {
            "u32" => bench::<u32, 1>(
                "u32_pair8",
                n,
                samples,
                threads,
                &pool,
                Some(c_parallel),
                Some(c_serial),
            ),
            "u64" => bench::<u64, 2>(
                "u64_pair16",
                n,
                samples,
                threads,
                &pool,
                None,
                None,
            ),
            "u128" => bench::<u128, 4>(
                "u128_pair32",
                n,
                samples,
                threads,
                &pool,
                None,
                None,
            ),
            "fat128" => bench::<u32, 31>(
                "u32_payload128",
                n,
                samples,
                threads,
                &pool,
                None,
                None,
            ),
            _ => panic!("type must be u32/u64/u128/fat128"),
        }
    }
}
