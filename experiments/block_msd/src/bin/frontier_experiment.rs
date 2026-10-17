use block_msd_research::frontier::{self, Config, Mode};
use std::{
    alloc::{GlobalAlloc, Layout, System},
    cmp::Ordering as Cmp,
    sync::atomic::{AtomicBool, AtomicUsize, Ordering},
    time::Instant,
};
use voracious_radix_sort::{RadixKey, Radixable};
struct Alloc;
static TRACK: AtomicBool = AtomicBool::new(false);
static LIVE: AtomicUsize = AtomicUsize::new(0);
static PEAK: AtomicUsize = AtomicUsize::new(0);
static ALLOCS: AtomicUsize = AtomicUsize::new(0);
static REQUESTED: AtomicUsize = AtomicUsize::new(0);
fn add(n: usize) {
    ALLOCS.fetch_add(1, Ordering::Relaxed);
    REQUESTED.fetch_add(n, Ordering::Relaxed);
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
}
impl Verified for u8 {
    fn same(&self, b: &Self) -> bool {
        self == b
    }
}
impl Verified for u16 {
    fn same(&self, b: &Self) -> bool {
        self == b
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
    fn same(&self, b: &Self) -> bool {
        self.key == b.key
            && self.serial == b.serial
            && self.payload == b.payload
    }
}
impl Verified for Large {
    fn same(&self, b: &Self) -> bool {
        self.key == b.key
            && self.serial == b.serial
            && self.payload == b.payload
    }
}
fn random(s: &mut u64) -> u64 {
    *s ^= *s << 13;
    *s ^= *s >> 7;
    *s ^= *s << 17;
    *s
}

#[derive(Clone, Copy, Debug)]
struct Small {
    key: u32,
    serial: u32,
}
impl PartialEq for Small {
    fn eq(&self, b: &Self) -> bool {
        self.key == b.key
    }
}
impl PartialOrd for Small {
    fn partial_cmp(&self, b: &Self) -> Option<Cmp> {
        self.key.partial_cmp(&b.key)
    }
}
impl Radixable<u32> for Small {
    type Key = u32;
    fn key(&self) -> u32 {
        self.key
    }
}
impl Verified for Small {
    fn same(&self, b: &Self) -> bool {
        self.key == b.key && self.serial == b.serial
    }
}

#[derive(Clone, Copy, Debug)]
struct Small16 {
    key: u16,
    serial: u32,
}
#[derive(Clone, Copy, Debug)]
struct Small8 {
    key: u8,
    serial: u32,
}
impl PartialEq for Small8 {
    fn eq(&self, b: &Self) -> bool {
        self.key == b.key
    }
}
impl PartialOrd for Small8 {
    fn partial_cmp(&self, b: &Self) -> Option<Cmp> {
        self.key.partial_cmp(&b.key)
    }
}
impl Radixable<u8> for Small8 {
    type Key = u8;
    fn key(&self) -> u8 {
        self.key
    }
}
impl Verified for Small8 {
    fn same(&self, b: &Self) -> bool {
        self.key == b.key && self.serial == b.serial
    }
}
impl PartialEq for Small16 {
    fn eq(&self, b: &Self) -> bool {
        self.key == b.key
    }
}
impl PartialOrd for Small16 {
    fn partial_cmp(&self, b: &Self) -> Option<Cmp> {
        self.key.partial_cmp(&b.key)
    }
}
impl Radixable<u16> for Small16 {
    type Key = u16;
    fn key(&self) -> u16 {
        self.key
    }
}
impl Verified for Small16 {
    fn same(&self, b: &Self) -> bool {
        self.key == b.key && self.serial == b.serial
    }
}

const METHODS: &[&str] = &[
    "Pa_ref",
    "Pa_terminal",
    "Pa_ordered",
    "Pa_lean",
    "Pa_skew",
    "Pa_skew3",
    "Pa_both",
    "Pa_both3",
    "Pa_core3",
    "Pa_probe3",
    "Pa_band",
    "Pa_band_child",
    "L",
    "L_frozen",
    "H1",
    "H2",
    "H3",
    "P1",
    "P2",
    "P3",
    "Pa",
    "F1",
    "F2",
    "F3",
    "Fa",
    "Fsame1",
    "Fsame2",
    "Fsame3",
    "best_msd",
    "stable_msd",
];
const CASES: &[&str] = &[
    "uniform",
    "sorted",
    "reverse",
    "equal",
    "few",
    "common_high",
    "deep_skew",
    "deep_unique90",
    "deep_unique98",
    "multi_heavy",
    "majority_prefix",
    "outlier_first",
    "sparse",
    "comb",
];

fn execute<T: Radixable<K>, K: RadixKey>(
    arr: &mut [T],
    method: &str,
    block: usize,
) -> frontier::Work
where
    <<T as Radixable<K>>::Key as RadixKey>::Key: frontier::NativeKey,
{
    match method {
        "Pa_ref" | "Pa_terminal" | "Pa_ordered" | "Pa_lean" | "Pa_skew"
        | "Pa_both" | "Pa_skew3" | "Pa_both3" | "Pa_core3" | "Pa_probe3"
        | "Pa_band" | "Pa_band_child" => {
            use frontier::PaExperiment::*;
            let experiment = match method {
                "Pa_ref" => Reference,
                "Pa_terminal" => Terminal,
                "Pa_ordered" => Ordered,
                "Pa_lean" => Lean,
                "Pa_skew" => Skew,
                "Pa_skew3" => SkewThreeWay,
                "Pa_both3" => BothThreeWay,
                "Pa_core3" => CoreThreeWay,
                "Pa_probe3" => ProbeThreeWay,
                "Pa_band" => PrefixBand,
                "Pa_band_child" => PrefixBandChild,
                _ => Both,
            };
            return frontier::sort_pa_experiment::<T, K>(
                arr, experiment, block,
            );
        },
        "L_frozen" => {
            block_msd_research::submitted_lsd::block_lsd_stable_radixsort::<T, K>(
                arr, 8, block,
            );
            return Default::default();
        },
        "best_msd" => {
            use block_msd_research::reduction_node as r;
            r::sort_reduced::<T, K>(
                arr,
                8,
                block,
                r::CACHE_BUDGET,
                r::Placement::ScratchPathCycles,
                true,
            );
            return Default::default();
        },
        "stable_msd" => {
            block_msd_research::stable_baseline::msd_stable_radixsort::<T, K>(
                arr, 8,
            );
            return Default::default();
        },
        _ => {},
    }
    let mode = match method.as_bytes()[0] {
        b'L' => Mode::L,
        b'H' => Mode::H,
        b'P' => Mode::P,
        b'F' => Mode::F,
        _ => panic!("unknown method"),
    };
    let coarse_bits = if method.starts_with("Fsame") {
        method[5..].parse::<usize>().unwrap() * 8
    } else {
        0
    };
    let bytes = if method == "L" || method.ends_with('a') || coarse_bits != 0 {
        0
    } else {
        method[1..].parse().unwrap()
    };
    frontier::sort::<T, K>(arr, Config { mode, bytes, coarse_bits, block })
}

fn make_keys(n: usize, bits: usize, case: &str, seed: u64) -> Vec<u128> {
    let mut state = seed;
    let mask = if bits == 128 { u128::MAX } else { (1u128 << bits) - 1 };
    let unique_bits =
        usize::BITS as usize - n.saturating_sub(1).leading_zeros() as usize;
    let reserved = ((unique_bits + 7) / 8) * 8;
    if case.starts_with("deep_unique") {
        assert!(reserved <= bits, "distinct workload does not fit key width");
    }
    let mut keys: Vec<u128> = (0..n)
        .map(|i| {
            let r = ((random(&mut state) as u128) << 64
                | random(&mut state) as u128)
                & mask;
            match case {
                "uniform" | "sorted" | "reverse" => r,
                "equal" => mask / 3,
                "few" => (r % 8) * (mask / 9),
                "common_high" => (mask & !0xfffff) | (r & 0xfffff),
                "deep_skew" | "outlier_first" => {
                    if i % 10 != 0 {
                        0
                    } else {
                        1u128 << (i % bits)
                    }
                },
                "deep_unique90" | "deep_unique98" => {
                    let keep = if case == "deep_unique90" { 90 } else { 98 };
                    let mut key = i as u128;
                    let mut exited = false;
                    for byte in (reserved / 8..bits / 8).rev() {
                        let draw = random(&mut state);
                        if !exited && draw % 100 < keep {
                            continue;
                        }
                        let value = if exited {
                            draw & 255
                        } else {
                            1 + (draw >> 8) % 255
                        };
                        exited = true;
                        key |= (value as u128) << (byte * 8);
                    }
                    key
                },
                "multi_heavy" => ((r % 4) << (bits - 2)) | (r & 0xfff),
                "majority_prefix" => {
                    if i % 10 != 0 {
                        r & ((1u128 << (bits / 2)) - 1)
                    } else {
                        r
                    }
                },
                "sparse" => [0, 18, 36, 54, 72, 90, 108, 126]
                    .iter()
                    .copied()
                    .filter(|&b| b < bits)
                    .enumerate()
                    .fold(0, |key, (j, b)| {
                        key | ((((i % 256) >> j) & 1) as u128) << b
                    }),
                "comb" => {
                    if i % 2 == 0 {
                        0
                    } else {
                        (1u128 << ((i % ((bits + 7) / 8)) * 8).min(bits - 1))
                            | (r & 7)
                    }
                },
                _ => panic!("unknown case"),
            }
        })
        .collect();
    if case == "sorted" {
        keys.sort();
    } else if case == "reverse" {
        keys.sort_by(|a, b| b.cmp(a));
    } else if case != "outlier_first" && case != "equal" {
        for i in (1..n).rev() {
            let j = random(&mut state) as usize % (i + 1);
            keys.swap(i, j);
        }
    }
    if case == "outlier_first" && n > 0 {
        keys[0] = mask;
    }
    keys
}

#[cfg(test)]
mod workload_tests {
    use super::*;
    #[test]
    fn progressive_skew_has_distinct_complete_keys() {
        for bits in [32, 64, 128] {
            for case in ["deep_unique90", "deep_unique98"] {
                let keys = make_keys(32769, bits, case, 42);
                let mut sorted = keys.clone();
                sorted.sort();
                assert!(sorted.windows(2).all(|w| w[0] != w[1]));
                assert!(keys.windows(2).any(|w| w[0] > w[1]));
                let first_byte_zero =
                    keys.iter().filter(|&&x| x >> (bits - 8) == 0).count();
                assert!(
                    first_byte_zero > keys.len() * 8 / 10
                        && first_byte_zero < keys.len()
                );
            }
        }
    }
}

#[repr(C)]
#[derive(Default)]
struct Timespec {
    sec: i64,
    nsec: i64,
}
extern "C" {
    fn clock_gettime(clock: i32, result: *mut Timespec) -> i32;
}
fn cpu_ns() -> u128 {
    let mut t = Timespec::default();
    assert_eq!(unsafe { clock_gettime(3, &mut t) }, 0); // CLOCK_THREAD_CPUTIME_ID on Linux
    t.sec as u128 * 1_000_000_000 + t.nsec as u128
}

fn run<T: Radixable<K> + Verified, K: RadixKey>(
    input: Vec<T>,
    layout: &str,
    case: &str,
    methods: &[&str],
    reps: usize,
    block: usize,
    seed: u64,
    kind: &str,
) where
    <<T as Radixable<K>>::Key as RadixKey>::Key: frontier::NativeKey,
{
    let mut expected = input.clone();
    expected.sort_by_key(|x| x.into_key_type());
    let mut actual = input.clone();
    // Warm each path on the same allocation; restoring and oracle checks are outside timing.
    for method in methods {
        actual.copy_from_slice(&input);
        execute::<T, K>(&mut actual, method, block);
        assert!(
            actual.iter().zip(&expected).all(|(a, b)| a.same(b)),
            "warmup {} {} {}",
            layout,
            case,
            method
        );
    }
    for rep in 0..reps {
        // Rotate and reverse each paired block. Repeated method slots provide A/A.
        for j in 0..methods.len() {
            let index = if rep % 2 == 0 {
                (j + rep / 2) % methods.len()
            } else {
                (methods.len() - 1 - j + rep / 2) % methods.len()
            };
            let method = methods[index];
            actual.copy_from_slice(&input);
            let mut elapsed = 0;
            let mut cpu = 0;
            let stats;
            if kind == "memory" {
                LIVE.store(0, Ordering::Relaxed);
                PEAK.store(0, Ordering::Relaxed);
                ALLOCS.store(0, Ordering::Relaxed);
                REQUESTED.store(0, Ordering::Relaxed);
                TRACK.store(true, Ordering::Relaxed);
                stats = execute::<T, K>(&mut actual, method, block);
                TRACK.store(false, Ordering::Relaxed);
                assert_eq!(
                    LIVE.load(Ordering::Relaxed),
                    0,
                    "workspace escaped sort"
                );
            } else {
                let c = cpu_ns();
                let start = Instant::now();
                stats = std::hint::black_box(execute::<T, K>(
                    std::hint::black_box(&mut actual),
                    method,
                    block,
                ));
                elapsed = start.elapsed().as_nanos();
                cpu = cpu_ns() - c;
            }
            assert!(
                actual.iter().zip(&expected).all(|(a, b)| a.same(b)),
                "{} {} {} rep {}",
                layout,
                case,
                method,
                rep
            );
            let peak =
                if kind == "memory" { PEAK.load(Ordering::Relaxed) } else { 0 };
            let allocs = if kind == "memory" {
                ALLOCS.load(Ordering::Relaxed)
            } else {
                0
            };
            let lengths = if cfg!(feature = "frontier_work") {
                stats
                    .leaf_lengths
                    .iter()
                    .enumerate()
                    .filter(|(_, n)| **n != 0)
                    .map(|(len, n)| format!("{}:{}", len, n))
                    .collect::<Vec<_>>()
                    .join(";")
            } else {
                String::new()
            };
            let values = [
                layout.to_string(),
                case.to_string(),
                input.len().to_string(),
                std::mem::size_of::<T>().to_string(),
                seed.to_string(),
                block.to_string(),
                method.to_string(),
                index.to_string(),
                rep.to_string(),
                kind.to_string(),
                elapsed.to_string(),
                cpu.to_string(),
                peak.to_string(),
                allocs.to_string(),
                stats.nodes.to_string(),
                stats.node_records.to_string(),
                stats.prepare_records.to_string(),
                stats.order_records.to_string(),
                stats.candidate_records.to_string(),
                stats.label_evals.to_string(),
                stats.scatter_records.to_string(),
                stats.dense_nodes.to_string(),
                stats.block_nodes.to_string(),
                stats.passes.to_string(),
                stats.compact_records.to_string(),
                stats.tail_records.to_string(),
                stats.runs_records.to_string(),
                stats.unresolved_records.to_string(),
                stats.leaves.to_string(),
                stats.leaf_records.to_string(),
                stats.max_depth.to_string(),
                stats.max_path_passes.to_string(),
                stats.frontier_nodes.to_string(),
                stats.equal_nodes.to_string(),
                stats.band_nodes.to_string(),
                stats.band_records.to_string(),
                stats.probe_records.to_string(),
                cfg!(feature = "frontier_work").to_string(),
                (actual.as_ptr() as usize).to_string(),
                lengths,
            ];
            println!("{}", values.join(","));
        }
    }
}

fn main() {
    let args: Vec<String> = std::env::args().collect();
    let n = args.get(1).map_or(1048576, |s| s.parse().unwrap());
    let reps = args.get(2).map_or(12, |s| s.parse().unwrap());
    let method_arg = args.get(3).map_or(
        "L,L_frozen,H1,H2,H3,P1,P2,P3,Pa,F1,F2,F3,Fa,Fsame1,Fsame2,Fsame3",
        String::as_str,
    );
    let methods: Vec<&str> = method_arg.split(',').collect();
    assert!(methods.iter().all(|m| METHODS.contains(m)));
    let cases: Vec<&str> = args
        .get(4)
        .map_or("uniform,deep_skew,majority_prefix,sparse", String::as_str)
        .split(',')
        .collect();
    assert!(cases.iter().all(|c| CASES.contains(c)));
    let layouts: Vec<&str> = args
        .get(5)
        .map_or("u32,u64,small8,wide32,large128", String::as_str)
        .split(',')
        .collect();
    let kind = args.get(6).map_or("time", String::as_str);
    assert!(["time", "work", "memory"].contains(&kind));
    assert!(
        (kind == "work") == cfg!(feature = "frontier_work"),
        "use separate timed and work binaries"
    );
    let block = args.get(7).map_or(64, |s| s.parse().unwrap());
    let seed = args.get(8).map_or(0x123456789abcdef, |s| s.parse().unwrap());
    println!("layout,case,n,record_bytes,seed,block,method,slot,rep,kind,wall_ns,cpu_ns,heap_peak,allocs,nodes,node_records,prepare_records,order_records,candidate_records,label_evals,scatter_records,dense_nodes,block_nodes,passes,compact_records,tail_records,runs_records,unresolved_records,leaves,leaf_records,max_depth,max_path_passes,frontier_nodes,equal_nodes,band_nodes,band_records,probe_records,instrumented,input_address,leaf_lengths");
    for layout in layouts {
        for &case in &cases {
            let bits = match layout {
                "u8" | "u8_id8" => 8,
                "u16" | "u16_id8" => 16,
                "u32" | "small8" | "large128" => 32,
                "u64" => 64,
                "u128" | "wide32" => 128,
                _ => panic!("unknown layout"),
            };
            let keys = make_keys(n, bits, case, seed);
            match layout {
                "u8" => run::<_, u8>(
                    keys.iter().map(|&x| x as u8).collect(),
                    layout,
                    case,
                    &methods,
                    reps,
                    block,
                    seed,
                    kind,
                ),
                "u8_id8" => run::<_, u8>(
                    keys.iter()
                        .enumerate()
                        .map(|(i, &key)| Small8 {
                            key: key as u8,
                            serial: i as u32,
                        })
                        .collect(),
                    layout,
                    case,
                    &methods,
                    reps,
                    block,
                    seed,
                    kind,
                ),
                "u16" => run::<_, u16>(
                    keys.iter().map(|&x| x as u16).collect(),
                    layout,
                    case,
                    &methods,
                    reps,
                    block,
                    seed,
                    kind,
                ),
                "u16_id8" => run::<_, u16>(
                    keys.iter()
                        .enumerate()
                        .map(|(i, &key)| Small16 {
                            key: key as u16,
                            serial: i as u32,
                        })
                        .collect(),
                    layout,
                    case,
                    &methods,
                    reps,
                    block,
                    seed,
                    kind,
                ),
                "u32" => run::<_, u32>(
                    keys.iter().map(|&x| x as u32).collect(),
                    layout,
                    case,
                    &methods,
                    reps,
                    block,
                    seed,
                    kind,
                ),
                "u64" => run::<_, u64>(
                    keys.iter().map(|&x| x as u64).collect(),
                    layout,
                    case,
                    &methods,
                    reps,
                    block,
                    seed,
                    kind,
                ),
                "u128" => run::<_, u128>(
                    keys, layout, case, &methods, reps, block, seed, kind,
                ),
                "small8" => run::<_, u32>(
                    keys.iter()
                        .enumerate()
                        .map(|(i, &x)| Small {
                            key: x as u32,
                            serial: i as u32,
                        })
                        .collect(),
                    layout,
                    case,
                    &methods,
                    reps,
                    block,
                    seed,
                    kind,
                ),
                "wide32" => run::<_, u128>(
                    keys.iter()
                        .enumerate()
                        .map(|(i, &key)| Wide {
                            key,
                            serial: i as u64,
                            payload: [!(i as u64)],
                        })
                        .collect(),
                    layout,
                    case,
                    &methods,
                    reps,
                    block,
                    seed,
                    kind,
                ),
                "large128" => run::<_, u32>(
                    keys.iter()
                        .enumerate()
                        .map(|(i, &key)| Large {
                            key: key as u32,
                            serial: i as u32,
                            payload: [!(i as u64); 15],
                        })
                        .collect(),
                    layout,
                    case,
                    &methods,
                    reps,
                    block,
                    seed,
                    kind,
                ),
                _ => unreachable!(),
            }
        }
    }
}
