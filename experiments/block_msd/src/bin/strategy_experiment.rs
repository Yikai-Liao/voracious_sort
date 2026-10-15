use block_msd_research::{
    carried_boundaries, count_first_full_scan, joint_histograms, leaf_batch,
    materialization_gate, node_local, skew_paths, stable_baseline,
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
const METHODS: [&str; 22] = [
    "full_scan",
    "local_free",
    "local_prefix",
    "carried",
    "leaf_batch",
    "joint0",
    "joint512",
    "gate_R4",
    "gate_potential4",
    "minority_single",
    "deferred_chain",
    "ordinary",
    "stable_fixed",
    "std_stable",
    "stream_carry_leaf",
    "local_carried",
    "gate_carried",
    "mono_gate_carried",
    "block_lsd",
    "block_lsd512",
    "hybrid",
    "hybrid_mono",
];
const CORE_METHODS: [usize; 9] = [1, 14, 20, 21, 18, 19, 11, 12, 13];

fn sort<T: Radixable<K>, K: RadixKey>(
    a: &mut [T],
    method: usize,
    block: usize,
) -> [usize; 11] {
    let mut monotone = [0; 3];
    let work = match method {
        0 | 3 | 4 | 14 => {
            let s = match method {
                0 => count_first_full_scan::block_msd_stable_radixsort(
                    a, 8, block,
                ),
                3 => {
                    carried_boundaries::block_msd_stable_radixsort(a, 8, block)
                },
                14 => block_msd_research::combined_stream::block_msd_stable_radixsort(a, 8, block),
                _ => leaf_batch::block_msd_stable_radixsort(a, 8, block),
            };
            [
                s.nodes,
                s.dense_nodes,
                s.dense_scattered_elements,
                s.scratch_elements,
                0,
                0,
                0,
                0,
            ]
        },
        1 | 2 | 15 => {
            let placement = if method == 1 {
                node_local::Placement::FreeList
            } else if method == 15 {
                node_local::Placement::CarriedFreeList
            } else {
                node_local::Placement::PrefixWriteback
            };
            let s = node_local::sort_with_placement(
                a,
                8,
                block,
                node_local::CACHE_BUDGET,
                placement,
            );
            [
                s.block_nodes,
                s.cache_entries,
                s.variation_records,
                s.block_scatter_records,
                s.cache_scatter_records,
                s.permutation_writes,
                s.prefix_writeback_records,
                s.peak_scratch_records,
            ]
        },
        5 | 6 => {
            let (_, s) = joint_histograms::sort_with_budget(
                a,
                8,
                block,
                if method == 5 { 0 } else { 512 * 1024 },
            );
            [
                s.hist_reused_records,
                s.hist_scanned_records,
                s.joint_updates,
                s.peak_bytes,
                s.peak_tables,
                s.tables_built,
                s.tables_denied,
                s.prepared_rejected_records,
            ]
        },
        7 | 8 | 16 | 17 | 20 | 21 => {
            let gate = if method == 7 {
                materialization_gate::Gate::Retired
            } else {
                materialization_gate::Gate::DyadicPotential
            };
            let s = if method >= 20 {
                materialization_gate::sort_hybrid(
                    a,
                    8,
                    block,
                    node_local::CACHE_BUDGET,
                    method == 21,
                )
            } else {
                materialization_gate::sort_with_options(
                    a,
                    8,
                    block,
                    node_local::CACHE_BUDGET,
                    gate,
                    method >= 16,
                    method == 17,
                )
            };
            monotone = [
                s.monotone_records,
                s.monotone_nodes,
                s.skipped_scatter_records,
            ];
            [
                s.accepted_records,
                s.retired_records,
                s.accepted_nodes,
                s.fallback_records,
                s.fallback_nodes,
                s.potential_drop as usize,
                s.local.permutation_writes,
                s.local.cache_entries,
            ]
        },
        9 | 10 => {
            let mode = if method == 9 {
                skew_paths::Mode::SingleLayer
            } else {
                skew_paths::Mode::DeferredChain
            };
            let s = skew_paths::sort_with_budget(
                a,
                8,
                block,
                skew_paths::WORKSPACE_BUDGET,
                mode,
            );
            [
                s.special_nodes,
                s.deferred_levels,
                s.major_records_moved,
                s.minor_records,
                s.peak_workspace_bytes,
                s.flushes,
                s.budget_flushes,
                s.fallback_calls,
            ]
        },
        11 => {
            msd_radixsort(a, 8);
            [0; 8]
        },
        12 => {
            stable_baseline::msd_stable_radixsort(a, 8);
            [0; 8]
        },
        13 => {
            a.sort_by_key(|value| value.into_key_type());
            [0; 8]
        },
        18 | 19 => {
            block_msd_research::submitted_lsd::block_lsd_stable_radixsort(
                a,
                8,
                if method == 19 { 512 } else { block },
            );
            [0; 8]
        },
        _ => unreachable!(),
    };
    let mut result = [0; 11];
    result[..8].copy_from_slice(&work);
    result[8..].copy_from_slice(&monotone);
    result
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
    if load == "descending" || load == "reverse_unique" {
        source.reverse();
    }
    if load == "reverse_unique" {
        assert!(
            source
                .windows(2)
                .all(|pair| pair[0].into_key_type() > pair[1].into_key_type()),
            "reverse_unique must be strictly decreasing in converted keys"
        );
    }
    if source.len() > 2
        && (load == "digit_grouped" || load == "digit_tail_inversion")
    {
        let dummy = source[0];
        let shift = dummy.type_size() - 8;
        let mask = dummy.default_mask(8) << dummy.usize_to_keytype(shift);
        let inversion = source.windows(2).position(|p| {
            p[1].extract(mask, shift) < p[0].extract(mask, shift)
        });
        assert_eq!(
            inversion,
            if load == "digit_grouped" { None } else { Some(source.len() - 2) },
            "top digit fixture"
        );
    }
    if load == "almost_sorted" {
        let mut seed = 961748941;
        for i in (0..source.len()).step_by(100) {
            let other = random(&mut seed) as usize % source.len();
            source.swap(i, other);
        }
    }
    let methods: Vec<usize> = match std::env::args().nth(6).as_deref() {
        None | Some("core") => CORE_METHODS.to_vec(),
        Some("all") => (0..METHODS.len()).collect(),
        _ => panic!("method set must be core or all"),
    };
    let mut reference = source.clone();
    reference.sort_by_key(|v| v.into_key_type());
    let mut lookup = source.clone();
    lookup.sort_by_key(Verified::identity);
    let verify = |a: &[T], method| {
        if method == 11 {
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
    for &method in &methods {
        a.copy_from_slice(&source);
        sort::<T, K>(&mut a, method, block);
        verify(&a, method);
    }
    let mut rows = Vec::new();
    for sample in 0..repeats {
        for offset in 0..methods.len() {
            let method = methods[(sample + offset) % methods.len()];
            a.copy_from_slice(&source);
            let start = Instant::now();
            let metrics =
                sort::<T, K>(std::hint::black_box(&mut a), method, block);
            let ns = start.elapsed().as_nanos();
            verify(&a, method);
            rows.push((method, sample, ns, metrics));
        }
    }
    let mut peaks = [0; METHODS.len()];
    for &method in &methods {
        a.copy_from_slice(&source);
        LIVE.store(0, Ordering::Relaxed);
        PEAK.store(0, Ordering::Relaxed);
        TRACK.store(true, Ordering::Relaxed);
        let stats = sort::<T, K>(&mut a, method, block);
        let _ = stats;
        TRACK.store(false, Ordering::Relaxed);
        assert_eq!(LIVE.load(Ordering::Relaxed), 0);
        peaks[method] = PEAK.load(Ordering::Relaxed);
        verify(&a, method);
    }
    for (method, sample, ns, metrics) in rows {
        print!(
            "{},{},{},{},{},{},{},{}",
            name,
            load,
            source.len(),
            block,
            METHODS[method],
            sample,
            ns,
            peaks[method]
        );
        for value in metrics {
            print!(",{}", value);
        }
        println!(
            ",{}",
            if method == 19 {
                512
            } else if matches!(method, 11 | 12 | 13) {
                0
            } else {
                block
            }
        );
    }
}
fn main() {
    let args: Vec<String> = std::env::args().collect();
    let n = args.get(1).map(|s| s.parse().unwrap()).unwrap_or(100_000);
    let repeats = args.get(2).map(|s| s.parse().unwrap()).unwrap_or(3);
    println!("type,load,n,block,algorithm,sample,ns,peak_heap,work1,work2,work3,work4,work5,work6,work7,work8,work9,work10,work11,method_block");
    let blocks: Vec<usize> = if let Some(value) = args.get(3) {
        vec![value.parse().unwrap()]
    } else {
        vec![16, 64, 256]
    };
    for load in [
        "uniform",
        "deep_skew",
        "skew95",
        "shared_prefix",
        "sorted",
        "descending",
        "reverse_unique",
        "digit_grouped",
        "digit_tail_inversion",
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
        if load == "reverse_unique" {
            assert!(
                n <= u32::MAX as usize,
                "unique keys must fit every layout"
            );
        }
        let mut seed = 61789;
        let raw: Vec<u128> = (0..n)
            .map(|i| {
                if load == "reverse_unique" {
                    return i as u128;
                }
                let x = ((random(&mut seed) as u128) << 64)
                    | random(&mut seed) as u128;
                if load == "digit_grouped" || load == "digit_tail_inversion" {
                    let digit = if load == "digit_tail_inversion" && i + 1 == n
                    {
                        0
                    } else {
                        (i as u128 * 256 / n as u128).min(255)
                    };
                    let repeated = 0x01000000010000000100000001000000u128;
                    (x & !(repeated * 255)) | (digit * repeated)
                } else if load == "deep_skew" {
                    if i % 97 == 0 {
                        1u128 << ((i / 97) % 128)
                    } else {
                        0
                    }
                } else if load == "skew95" && i % 20 != 0 {
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
