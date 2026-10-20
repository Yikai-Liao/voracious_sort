use block_msd_research::{
    count_first, count_first_full_scan, stable_baseline, Stats,
};
use std::{
    alloc::{GlobalAlloc, Layout, System},
    cmp::Ordering as Cmp,
    sync::atomic::{AtomicBool, AtomicUsize, Ordering},
    time::Instant,
};
use voracious_radix_sort::{msd_radixsort, RadixKey, Radixable};
struct Alloc;
static TRACK: AtomicBool = AtomicBool::new(false);
static LIVE: AtomicUsize = AtomicUsize::new(0);
static PEAK: AtomicUsize = AtomicUsize::new(0);
fn add(n: usize) {
    let v = LIVE.fetch_add(n, Ordering::Relaxed) + n;
    PEAK.fetch_max(v, Ordering::Relaxed);
}
unsafe impl GlobalAlloc for Alloc {
    unsafe fn alloc(&self, l: Layout) -> *mut u8 {
        let p = System.alloc(l);
        if !p.is_null() && TRACK.load(Ordering::Relaxed) {
            add(l.size());
        }
        p
    }
    unsafe fn dealloc(&self, p: *mut u8, l: Layout) {
        if TRACK.load(Ordering::Relaxed) {
            LIVE.fetch_sub(l.size(), Ordering::Relaxed);
        }
        System.dealloc(p, l);
    }
    unsafe fn realloc(&self, p: *mut u8, l: Layout, n: usize) -> *mut u8 {
        let q = System.realloc(p, l, n);
        if !q.is_null() && TRACK.load(Ordering::Relaxed) {
            LIVE.fetch_sub(l.size(), Ordering::Relaxed);
            add(n);
        }
        q
    }
}
#[global_allocator]
static ALLOC: Alloc = Alloc;
#[derive(Clone, Copy, Debug)]
struct Wide {
    key: u128,
    serial: u64,
    payload: [u64; 1],
}
impl PartialEq for Wide {
    fn eq(&self, b: &Self) -> bool {
        self.key == b.key
    }
}
impl PartialOrd for Wide {
    fn partial_cmp(&self, b: &Self) -> Option<Cmp> {
        self.key.partial_cmp(&b.key)
    }
}
impl Radixable<u128> for Wide {
    type Key = u128;
    fn key(&self) -> u128 {
        self.key
    }
}
#[derive(Clone, Copy, Debug)]
struct Large {
    key: u32,
    serial: u32,
    payload: [u64; 15],
}
impl PartialEq for Large {
    fn eq(&self, b: &Self) -> bool {
        self.key == b.key
    }
}
impl PartialOrd for Large {
    fn partial_cmp(&self, b: &Self) -> Option<Cmp> {
        self.key.partial_cmp(&b.key)
    }
}
impl Radixable<u32> for Large {
    type Key = u32;
    fn key(&self) -> u32 {
        self.key
    }
}
trait Verified {
    fn same(&self, b: &Self) -> bool;
    fn identity(&self) -> Option<usize> {
        None
    }
}
impl Verified for u32 {
    fn same(&self, b: &Self) -> bool {
        self == b
    }
}
impl Verified for u64 {
    fn same(&self, b: &Self) -> bool {
        self == b
    }
}
impl Verified for u128 {
    fn same(&self, b: &Self) -> bool {
        self == b
    }
}
impl Verified for Wide {
    fn identity(&self) -> Option<usize> {
        Some(self.serial as usize)
    }
    fn same(&self, b: &Self) -> bool {
        self.key == b.key
            && self.serial == b.serial
            && self.payload == b.payload
    }
}
impl Verified for Large {
    fn identity(&self) -> Option<usize> {
        Some(self.serial as usize)
    }
    fn same(&self, b: &Self) -> bool {
        self.key == b.key
            && self.serial == b.serial
            && self.payload == b.payload
    }
}
fn verify_unstable<T: Radixable<K> + Verified, K: RadixKey>(
    a: &[T],
    expected: &[T],
    lookup: &[T],
) {
    assert!(
        a.iter()
            .zip(expected)
            .all(|(a, b)| a.into_key_type() == b.into_key_type()),
        "ordinary MSD key failure"
    );
    if a.first().and_then(Verified::identity).is_some() {
        let mut seen = vec![false; a.len()];
        for value in a {
            let id = value.identity().unwrap();
            assert!(
                id < a.len() && !seen[id] && value.same(&lookup[id]),
                "ordinary MSD identity permutation failure"
            );
            seen[id] = true;
        }
    } else {
        assert!(a.iter().zip(expected).all(|(a, b)| a.same(b)));
    }
}
fn random(s: &mut u64) -> u64 {
    *s ^= *s << 13;
    *s ^= *s >> 7;
    *s ^= *s << 17;
    *s
}
const METHODS: [&str; 4] =
    ["full_scan", "early_scan", "ordinary", "stable_fixed"];
fn sort<T: Radixable<K>, K: RadixKey>(
    a: &mut [T],
    method: usize,
    block: usize,
) -> Stats {
    match method {
        0 => count_first_full_scan::block_msd_stable_radixsort(a, 8, block),
        1 => count_first::block_msd_stable_radixsort(a, 8, block),
        2 => {
            msd_radixsort(a, 8);
            Stats::default()
        },
        3 => {
            stable_baseline::msd_stable_radixsort(a, 8);
            Stats::default()
        },
        _ => unreachable!(),
    }
}
fn run<T: Radixable<K> + Verified, K: RadixKey>(
    name: &str,
    load: &str,
    mut source: Vec<T>,
    block: usize,
    repeats: usize,
) {
    if std::env::args()
        .nth(5)
        .map_or(false, |names| !names.split(',').any(|item| item == name))
    {
        return;
    }
    if load == "sorted" || load == "descending" || load == "almost_sorted" {
        source.sort_by_key(|value| value.into_key_type());
    }
    if load == "descending" {
        source.reverse();
    }
    if load == "almost_sorted" {
        let mut seed = 961748941;
        for i in (0..source.len()).step_by(100) {
            let other = random(&mut seed) as usize % source.len();
            source.swap(i, other);
        }
    }
    let mut reference = source.clone();
    reference.sort_by_key(|v| v.into_key_type());
    let mut lookup = source.clone();
    lookup.sort_by_key(Verified::identity);
    let verify = |a: &[T], method| {
        if method == 2 {
            verify_unstable::<T, K>(a, &reference, &lookup);
        } else {
            assert!(
                a.iter().zip(&reference).all(|(a, b)| a.same(b)),
                "{} {} {} failed",
                name,
                load,
                METHODS[method]
            );
        }
    };
    let mut a = source.clone();
    for method in 0..4 {
        a.copy_from_slice(&source);
        sort::<T, K>(&mut a, method, block);
        verify(&a, method);
    }
    let mut rows = Vec::new();
    for sample in 0..repeats {
        for offset in 0..4 {
            let method = (sample + offset) % 4;
            a.copy_from_slice(&source);
            let start = Instant::now();
            let stats =
                sort::<T, K>(std::hint::black_box(&mut a), method, block);
            let ns = start.elapsed().as_nanos();
            verify(&a, method);
            let union = {
                #[cfg(feature = "cf_phases")]
                {
                    stats.phases.union_records
                }
                #[cfg(not(feature = "cf_phases"))]
                {
                    0
                }
            };
            let histogram = {
                #[cfg(feature = "cf_phases")]
                {
                    stats.phases.histogram_records
                }
                #[cfg(not(feature = "cf_phases"))]
                {
                    0
                }
            };
            let scatter = {
                #[cfg(feature = "cf_phases")]
                {
                    stats.phases.scatter_records
                }
                #[cfg(not(feature = "cf_phases"))]
                {
                    0
                }
            };
            rows.push((
                method,
                sample,
                ns,
                stats.nodes,
                union,
                histogram,
                scatter,
            ));
        }
    }
    let mut peaks = [0; 4];
    for method in 0..4 {
        a.copy_from_slice(&source);
        LIVE.store(0, Ordering::Relaxed);
        PEAK.store(0, Ordering::Relaxed);
        TRACK.store(true, Ordering::Relaxed);
        let stats = sort::<T, K>(&mut a, method, block);
        drop(stats);
        TRACK.store(false, Ordering::Relaxed);
        assert_eq!(LIVE.load(Ordering::Relaxed), 0);
        peaks[method] = PEAK.load(Ordering::Relaxed);
        verify(&a, method);
    }
    for (method, sample, ns, nodes, union, histogram, scatter) in rows {
        println!(
            "{},{},{},{},{},{},{},{},{},{},{},{}",
            name,
            load,
            source.len(),
            block,
            METHODS[method],
            sample,
            ns,
            peaks[method],
            nodes,
            union,
            histogram,
            scatter
        );
    }
}
fn main() {
    let args: Vec<String> = std::env::args().collect();
    let n = args.get(1).map(|s| s.parse().unwrap()).unwrap_or(100_000);
    let repeats = args.get(2).map(|s| s.parse().unwrap()).unwrap_or(3);
    println!("type,load,n,block,algorithm,sample,ns,peak_heap,nodes,union_records,histogram_records,scatter_records");
    let blocks: Vec<usize> = if let Some(value) = args.get(3) {
        vec![value.parse().unwrap()]
    } else {
        vec![16, 64, 256]
    };
    for load in [
        "uniform",
        "skew95",
        "shared_prefix",
        "sorted",
        "descending",
        "almost_sorted",
    ]
    .iter()
    .copied()
    {
        if args
            .get(4)
            .map_or(false, |loads| !loads.split(',').any(|name| name == load))
        {
            continue;
        }
        let mut seed = 61789;
        let raw: Vec<u128> = (0..n)
            .map(|i| {
                let x = ((random(&mut seed) as u128) << 64)
                    | random(&mut seed) as u128;
                if load == "skew95" && i % 20 != 0 {
                    0
                } else if load == "shared_prefix" {
                    (0xabcdef1234567890u128 << 64) | (x & 0xffffff)
                } else {
                    x
                }
            })
            .collect();
        for block in blocks.iter().copied() {
            run::<u32, u32>(
                "u32",
                load,
                raw.iter().map(|&x| x as u32).collect(),
                block,
                repeats,
            );
            run::<u64, u64>(
                "u64",
                load,
                raw.iter().map(|&x| x as u64).collect(),
                block,
                repeats,
            );
            run::<u128, u128>("u128", load, raw.clone(), block, repeats);
            run::<Wide, u128>(
                "wide32",
                load,
                raw.iter()
                    .enumerate()
                    .map(|(i, &x)| Wide {
                        key: x,
                        serial: i as u64,
                        payload: [i as u64],
                    })
                    .collect(),
                block,
                repeats,
            );
            run::<Large, u32>(
                "large128",
                load,
                raw.iter()
                    .enumerate()
                    .map(|(i, &x)| Large {
                        key: x as u32,
                        serial: i as u32,
                        payload: [i as u64; 15],
                    })
                    .collect(),
                block,
                repeats,
            );
        }
    }
}
