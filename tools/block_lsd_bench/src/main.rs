mod baseline;
#[allow(dead_code)]
mod shared;
mod uninit;
use std::{
    alloc::{GlobalAlloc, Layout, System},
    cmp::Ordering,
    fmt::Debug,
    hint::black_box,
    panic::{catch_unwind, AssertUnwindSafe},
    sync::atomic::{AtomicBool, AtomicUsize, Ordering as AtomicOrdering},
    time::Instant,
};
use voracious_radix_sort::{
    block_lsd_stable_radixsort, lsd_radixsort, lsd_stable_radixsort,
    msd_stable_radixsort, RadixKey, Radixable,
};

// Track requested heap bytes only in a separate untimed memory run. Input,
// reference output and cloning are excluded. Allocator metadata and RSS are not
// measured. The tracking branch is disabled during timing.
struct Allocator;
static TRACK: AtomicBool = AtomicBool::new(false);
static LIVE: AtomicUsize = AtomicUsize::new(0);
static PEAK: AtomicUsize = AtomicUsize::new(0);
fn allocated(bytes: usize) {
    let live = LIVE.fetch_add(bytes, AtomicOrdering::Relaxed) + bytes;
    PEAK.fetch_max(live, AtomicOrdering::Relaxed);
}
unsafe impl GlobalAlloc for Allocator {
    unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
        let p = System.alloc(layout);
        if !p.is_null() && TRACK.load(AtomicOrdering::Relaxed) {
            allocated(layout.size());
        }
        p
    }
    unsafe fn alloc_zeroed(&self, layout: Layout) -> *mut u8 {
        let p = System.alloc_zeroed(layout);
        if !p.is_null() && TRACK.load(AtomicOrdering::Relaxed) {
            allocated(layout.size());
        }
        p
    }
    unsafe fn dealloc(&self, p: *mut u8, layout: Layout) {
        if TRACK.load(AtomicOrdering::Relaxed) {
            LIVE.fetch_sub(layout.size(), AtomicOrdering::Relaxed);
        }
        System.dealloc(p, layout);
    }
    unsafe fn realloc(
        &self,
        p: *mut u8,
        layout: Layout,
        size: usize,
    ) -> *mut u8 {
        let result = System.realloc(p, layout, size);
        if !result.is_null() && TRACK.load(AtomicOrdering::Relaxed) {
            LIVE.fetch_sub(layout.size(), AtomicOrdering::Relaxed);
            allocated(size);
        }
        result
    }
}
#[global_allocator]
static ALLOCATOR: Allocator = Allocator;

#[repr(C)]
#[derive(Clone, Copy, Debug)]
struct Record<K, const N: usize> {
    key: K,
    payload: [u32; N],
}
// These comparison traits must agree on key equivalence: Verge uses both.
// Full record identity is verified independently after every sort.
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
macro_rules! radixable {
    ($($t:ty),*) => {$ (
        impl<const N:usize> Radixable<$t> for Record<$t,N> {
            type Key=$t;
            fn key(&self)->$t {self.key}
        }
    )*};
}
radixable!(u32, u64, u128, i64, f64);
trait SampleKey: Copy {
    fn from_sample(sample: u128) -> Self;
}
macro_rules! samples {
    ($($t:ty),*) => {$ (impl SampleKey for $t {
        fn from_sample(sample:u128)->Self {sample as Self}
    })*};
}
samples!(u32, u64, u128, i64);
impl SampleKey for f64 {
    fn from_sample(sample: u128) -> Self {
        (sample as u64 as i64) as f64
    }
}
extern "C" {
    fn permuted_sort(pairs: *mut Record<u32, 1>, n: usize);
    fn benchmark_c_heap_bytes(n: usize) -> usize;
}
const ALGORITHMS: [&str; 20] = [
    "c_permuted",
    "rust_block_lsd",
    "rust_lsd_stable",
    "rust_msd_stable",
    "std_stable",
    "rust_block_lsd_4k",
    "block_baseline_4k",
    "block_uninit_4k",
    "block_cursor_4k",
    "block_branchless_4k",
    "block_typed_4k",
    "rust_lsd",
    "rust_lsd_core",
    "lsd_core_scalar",
    "lsd_core_array_loop",
    "lsd_core_seq",
    "lsd_core_crunchy",
    "block_prefetch_next_4k",
    "block_prefetch_64_4k",
    "block_prefetch_256_4k",
];
fn sort<K: RadixKey, const N: usize>(
    arr: &mut [Record<K, N>],
    algorithm: usize,
    c_sort: Option<fn(&mut [Record<K, N>])>,
) where
    Record<K, N>: Radixable<K>,
{
    match algorithm {
        0 => c_sort.unwrap()(arr),
        1 => block_lsd_stable_radixsort(arr, 8, 512),
        2 => lsd_stable_radixsort(arr, 8),
        3 => msd_stable_radixsort(arr, 8),
        4 => arr.sort_by(|a, b| a.partial_cmp(b).unwrap()),
        5 => block_lsd_stable_radixsort(
            arr,
            8,
            (4096 / std::mem::size_of::<Record<K, N>>()).max(1),
        ),
        6 => baseline::block_lsd_stable_radixsort(
            arr,
            8,
            (4096 / std::mem::size_of::<Record<K, N>>()).max(1),
        ),
        7 => uninit::block_lsd_stable_radixsort(
            arr,
            8,
            (4096 / std::mem::size_of::<Record<K, N>>()).max(1),
        ),
        8 => shared::cursor::block_lsd_stable_radixsort::<_, _, false, true>(
            arr,
            8,
            (4096 / std::mem::size_of::<Record<K, N>>()).max(1),
        ),
        9 => shared::cursor::block_lsd_stable_radixsort::<_, _, true, true>(
            arr,
            8,
            (4096 / std::mem::size_of::<Record<K, N>>()).max(1),
        ),
        10 => shared::cursor::block_lsd_stable_radixsort::<_, _, false, false>(
            arr,
            8,
            (4096 / std::mem::size_of::<Record<K, N>>()).max(1),
        ),
        11 => lsd_radixsort(arr, 8),
        12 => shared::core::sort::<_, _, 0>(arr),
        13 => shared::core::sort::<_, _, 1>(arr),
        14 => shared::core::sort::<_, _, 2>(arr),
        15 => shared::core::sort::<_, _, 3>(arr),
        16 => shared::core::sort::<_, _, 4>(arr),
        17 => shared::prefetch::block_lsd_stable_radixsort::<_, _, 0>(
            arr,
            8,
            (4096 / std::mem::size_of::<Record<K, N>>()).max(1),
        ),
        18 => shared::prefetch::block_lsd_stable_radixsort::<_, _, 64>(
            arr,
            8,
            (4096 / std::mem::size_of::<Record<K, N>>()).max(1),
        ),
        19 => shared::prefetch::block_lsd_stable_radixsort::<_, _, 256>(
            arr,
            8,
            (4096 / std::mem::size_of::<Record<K, N>>()).max(1),
        ),
        _ => unreachable!(),
    }
}
fn c_sort(arr: &mut [Record<u32, 1>]) {
    // SAFETY: repr(C) Record<u32,1> matches uint32_t[2], exclusively borrowed
    // during this synchronous C call. No other record layout reaches C.
    unsafe { permuted_sort(arr.as_mut_ptr(), arr.len()) }
}
fn valid<K: RadixKey, const N: usize>(
    arr: &[Record<K, N>],
    expected: &[Record<K, N>],
) -> bool
where
    Record<K, N>: Radixable<K>,
{
    arr.iter().zip(expected).all(|(a, b)| {
        a.into_key_type() == b.into_key_type() && a.payload == b.payload
    })
}
fn valid_for_algorithm<K: RadixKey, const N: usize>(
    arr: &[Record<K, N>],
    expected: &[Record<K, N>],
    algorithm: usize,
) -> bool
where
    Record<K, N>: Radixable<K>,
{
    let stable_output = valid(arr, expected);
    if !(11..=16).contains(&algorithm) || stable_output {
        return stable_output;
    }
    if arr.windows(2).any(|p| p[0].into_key_type() > p[1].into_key_type()) {
        return false;
    }
    // payload[0] is the unique original ordinal in this harness. Canonicalizing
    // only equal-key groups verifies every payload word without requiring stability.
    let mut canonical = arr.to_vec();
    let mut start = 0;
    while start < canonical.len() {
        let key = canonical[start].into_key_type();
        let mut end = start + 1;
        while end < canonical.len() && canonical[end].into_key_type() == key {
            end += 1;
        }
        canonical[start..end].sort_unstable_by_key(|r| r.payload[0]);
        start = end;
    }
    valid(&canonical, expected)
}

fn input<K: SampleKey, const N: usize>(
    n: usize,
    distribution: &str,
) -> Vec<Record<K, N>> {
    let mut state = 0x123456789abcdefu128;
    let original: Vec<_> = (0..n)
        .map(|i| {
            state ^= state << 13;
            state ^= state >> 7;
            state ^= state << 17;
            let value = match distribution {
                "uniform" => state,
                "duplicates" => state % 256,
                "sorted" => i as u128,
                "reverse" => (n - i) as u128,
                "constant" => 42,
                "skewed" => {
                    if i % 20 == 0 {
                        state
                    } else {
                        0
                    }
                },
                _ => unreachable!(),
            };
            let mut payload = [0; N];
            for (j, word) in payload.iter_mut().enumerate() {
                *word = (i as u32).wrapping_mul(j as u32 + 1);
            }
            Record { key: K::from_sample(value), payload }
        })
        .collect();
    original
}

fn bench<K: SampleKey + RadixKey + Debug, const N: usize>(
    workload: &str,
    n: usize,
    samples: usize,
    c_sort: Option<fn(&mut [Record<K, N>])>,
) where
    Record<K, N>: Radixable<K>,
{
    let distributions = std::env::var("BLOCK_LSD_DISTRIBUTIONS")
        .unwrap_or_else(|_| {
            "uniform,duplicates,sorted,reverse,constant,skewed".into()
        });
    for distribution in distributions.split(',') {
        let original = input::<K, N>(n, distribution);
        let mut expected = original.clone();
        expected.sort_by_key(|r| r.into_key_type());
        let first = if c_sort.is_some() { 0 } else { 1 };
        let mut active = Vec::new();
        let mut peaks = [0; ALGORITHMS.len()];
        let selected = std::env::var("BLOCK_LSD_ALGORITHMS").ok();
        for algorithm in first..ALGORITHMS.len() {
            // Public comparison by default; experimental copies are opt-in.
            if selected.is_none() && algorithm > 5 && algorithm != 11 {
                continue;
            }
            if selected.as_ref().map_or(false, |names| {
                !names.split(',').any(|name| name == ALGORITHMS[algorithm])
            }) {
                continue;
            }
            // The two block settings coincide for the eight-byte u32 pair.
            if algorithm == 5 && std::mem::size_of::<Record<K, N>>() == 8 {
                continue;
            }
            let mut arr = original.clone();
            LIVE.store(0, AtomicOrdering::Relaxed);
            PEAK.store(0, AtomicOrdering::Relaxed);
            TRACK.store(true, AtomicOrdering::Relaxed);
            let result = catch_unwind(AssertUnwindSafe(|| {
                sort(&mut arr, algorithm, c_sort)
            }));
            TRACK.store(false, AtomicOrdering::Relaxed);
            if result.is_err()
                || !valid_for_algorithm(&arr, &expected, algorithm)
            {
                let status =
                    if result.is_err() { "panic" } else { "incorrect" };
                println!(
                    "{},{},{},{},{},,,,{},{}",
                    workload,
                    distribution,
                    n,
                    ALGORITHMS[algorithm],
                    status,
                    std::mem::size_of::<Record<K, N>>(),
                    "unavailable"
                );
                continue;
            }
            peaks[algorithm] = if algorithm == 0 {
                unsafe { benchmark_c_heap_bytes(n) }
            } else {
                PEAK.load(AtomicOrdering::Relaxed)
            };
            active.push(algorithm);
        }
        for sample in 0..samples {
            for offset in 0..active.len() {
                let algorithm = active[(sample + offset) % active.len()];
                // Batch tiny sorts so clock-call overhead does not dominate.
                // Clone and validate each batch member outside the timed region.
                let batch = if n < 8192 {
                    (32768 / n.max(1)).clamp(1, 2048)
                } else {
                    1
                };
                let mut arrays: Vec<_> =
                    (0..batch).map(|_| original.clone()).collect();
                let start = Instant::now();
                for arr in &mut arrays {
                    sort(black_box(arr), algorithm, c_sort);
                }
                let ns = start.elapsed().as_nanos() / batch as u128;
                black_box(&arrays);
                assert!(
                    arrays.iter().all(|arr| valid_for_algorithm(
                        arr, &expected, algorithm
                    )),
                    "{} {} {}",
                    workload,
                    distribution,
                    ALGORITHMS[algorithm]
                );
                let memory_kind = if algorithm == 0 {
                    "c_requested_heap_formula"
                } else {
                    "rust_measured_requested_heap"
                };
                println!(
                    "{},{},{},{},ok,{},{},{},{},{}",
                    workload,
                    distribution,
                    n,
                    ALGORITHMS[algorithm],
                    sample,
                    ns,
                    peaks[algorithm],
                    std::mem::size_of::<Record<K, N>>(),
                    memory_kind
                );
            }
        }
    }
}

fn tune<K: SampleKey + RadixKey + Debug, const N: usize>(
    workload: &str,
    n: usize,
    samples: usize,
) where
    Record<K, N>: Radixable<K>,
{
    let bytes = std::mem::size_of::<Record<K, N>>();
    let configs: Vec<_> =
        if let Ok(spec) = std::env::var("BLOCK_LSD_TUNE_CONFIGS") {
            spec.split(',')
                .map(|entry| {
                    let (radix, target) =
                        entry.split_once(':').expect("use radix:block_bytes");
                    let radix: usize = radix.parse().unwrap();
                    let target: usize = target.parse().unwrap();
                    assert!((1..=8).contains(&radix) && target > 0);
                    (radix, (target / bytes).max(1))
                })
                .collect()
        } else {
            [4, 6, 7, 8]
                .iter()
                .flat_map(|&radix| {
                    [512, 1024, 2048, 4096, 8192, 16384, 32768, 65536]
                        .iter()
                        .map(move |&target| (radix, (target / bytes).max(1)))
                })
                .collect()
        };
    for distribution in ["uniform", "duplicates", "skewed"] {
        let original = input::<K, N>(n, distribution);
        let mut expected = original.clone();
        expected.sort_by_key(|r| r.into_key_type());
        let mut peaks = Vec::new();
        for &(radix, block) in &configs {
            let mut arr = original.clone();
            LIVE.store(0, AtomicOrdering::Relaxed);
            PEAK.store(0, AtomicOrdering::Relaxed);
            TRACK.store(true, AtomicOrdering::Relaxed);
            block_lsd_stable_radixsort(&mut arr, radix, block);
            TRACK.store(false, AtomicOrdering::Relaxed);
            assert_eq!(LIVE.load(AtomicOrdering::Relaxed), 0);
            assert!(valid(&arr, &expected));
            peaks.push(PEAK.load(AtomicOrdering::Relaxed));
        }
        for sample in 0..samples {
            for offset in 0..configs.len() {
                let index = (offset + sample * 5) % configs.len();
                let (radix, block) = configs[index];
                let mut arr = original.clone();
                let start = Instant::now();
                block_lsd_stable_radixsort(black_box(&mut arr), radix, block);
                let ns = start.elapsed().as_nanos();
                black_box(&arr);
                assert!(valid(&arr, &expected));
                println!(
                    "{},{},{},{},{},{},{},{},{},{}",
                    workload,
                    distribution,
                    n,
                    radix,
                    block * bytes,
                    block,
                    sample,
                    ns,
                    peaks[index],
                    bytes
                );
            }
        }
    }
}

// perf starts with counters disabled. Synchronize commands through its ack FIFO
// so input generation, cloning and the reference sort stay outside counters.
fn profile<K: SampleKey + RadixKey + Debug, const N: usize>(
    args: &[String],
    c_sort: Option<fn(&mut [Record<K, N>])>,
) where
    Record<K, N>: Radixable<K>,
{
    use std::io::{BufRead, BufReader, Write};
    let algorithm: usize = args[3].parse().unwrap();
    let n: usize = args[4].parse().unwrap();
    let repeats: usize = args[5].parse().unwrap();
    assert!(repeats > 0 && n <= u32::MAX as usize);
    assert!(algorithm < ALGORITHMS.len());
    assert!(
        algorithm != 0 || c_sort.is_some(),
        "C requires the u32_pair8 layout"
    );
    let distribution = args.get(6).map(String::as_str).unwrap_or("uniform");
    let original = input::<K, N>(n, distribution);
    let mut expected = original.clone();
    expected.sort_by_key(|r| r.into_key_type());
    let mut control = std::env::var("PERF_CONTROL").ok().map(|path| {
        let command =
            std::fs::OpenOptions::new().write(true).open(path).unwrap();
        let ack = BufReader::new(
            std::fs::File::open(std::env::var("PERF_ACK").unwrap()).unwrap(),
        );
        (command, ack)
    });
    let mut signal = |command: &str| {
        if let Some((file, ack)) = &mut control {
            writeln!(file, "{}", command).unwrap();
            file.flush().unwrap();
            let mut response = String::new();
            ack.read_line(&mut response).unwrap();
            assert_eq!(
                response.trim_matches(|c: char| c.is_whitespace() || c == '\0'),
                "ack"
            );
        }
    };
    for _ in 0..repeats {
        let mut arr = original.clone();
        signal("enable");
        sort(black_box(&mut arr), algorithm, c_sort);
        signal("disable");
        black_box(&arr);
        assert!(valid_for_algorithm(&arr, &expected, algorithm));
    }
    println!(
        "profile,{},{},{},{},ok",
        args[2], ALGORITHMS[algorithm], n, repeats
    );
}

fn main() {
    assert_eq!(std::mem::size_of::<Record<u32, 1>>(), 8);
    assert_eq!(
        std::mem::align_of::<Record<u32, 1>>(),
        std::mem::align_of::<u32>()
    );
    // The failed row records a panic; avoid timing/logging its hook allocations.
    if !std::env::args().any(|a| a == "--profile") {
        std::panic::set_hook(Box::new(|_| {}));
    }
    let mut args: Vec<_> = std::env::args().collect();
    if args.get(1).map(String::as_str) == Some("--profile") {
        match args[2].as_str() {
            "u32" => profile::<u32, 1>(&args, Some(c_sort)),
            "u64" => profile::<u64, 2>(&args, None),
            "u128" => profile::<u128, 4>(&args, None),
            "fat128" => profile::<u32, 31>(&args, None),
            _ => panic!("profile type must be u32, u64, u128 or fat128"),
        }
        return;
    }
    let tuning = args.get(1).map_or(false, |s| s == "--tune");
    let payload = args.get(1).map_or(false, |s| s == "--payload");
    let scale = args.get(1).map_or(false, |s| s == "--scale");
    if tuning || payload || scale {
        args.remove(1);
    }
    let samples: usize = args.get(1).map(|s| s.parse().unwrap()).unwrap_or(9);
    assert!(samples > 0);
    let sizes: Vec<usize> =
        args.iter().skip(2).map(|s| s.parse().unwrap()).collect();
    let sizes =
        if sizes.is_empty() { vec![1024, 100000, 1000000] } else { sizes };
    if tuning {
        println!("workload,distribution,n,radix,block_bytes,block_size,sample,ns,peak_extra_bytes,record_bytes");
        for n in sizes {
            assert!(n <= u32::MAX as usize);
            tune::<u32, 1>("u32_pair8", n, samples);
            tune::<u64, 2>("u64_pair16", n, samples);
            tune::<u128, 4>("u128_pair32", n, samples);
            tune::<u32, 31>("u32_payload128", n, samples);
        }
        return;
    }
    println!("workload,distribution,n,algorithm,status,sample,ns,peak_extra_bytes,record_bytes,memory_kind");
    if payload {
        for n in sizes {
            assert!(n <= u32::MAX as usize);
            bench::<u32, 1>("u32_pair8", n, samples, Some(c_sort));
            bench::<u32, 3>("u32_record16", n, samples, None);
            bench::<u32, 7>("u32_record32", n, samples, None);
            bench::<u32, 15>("u32_record64", n, samples, None);
            bench::<u32, 31>("u32_payload128", n, samples, None);
            bench::<u32, 63>("u32_record256", n, samples, None);
        }
        return;
    }
    for n in sizes {
        assert!(n <= u32::MAX as usize);
        bench::<u32, 1>("u32_pair8", n, samples, Some(c_sort));
        bench::<u64, 2>("u64_pair16", n, samples, None);
        bench::<u128, 4>("u128_pair32", n, samples, None);
        if !scale {
            bench::<i64, 2>("i64_pair16", n, samples, None);
            bench::<f64, 2>("f64_pair16", n, samples, None);
        }
        bench::<u32, 31>("u32_payload128", n, samples, None);
    }
}
