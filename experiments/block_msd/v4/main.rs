#[path = "../v3/lib.rs"]
mod dense_v3;
use block_msd_research::block_msd_stable_radixsort;
use std::{
    alloc::{GlobalAlloc, Layout, System},
    cmp::Ordering as Cmp,
    sync::atomic::{AtomicBool, AtomicUsize, Ordering},
    time::Instant,
};
use voracious_radix_sort::{
    block_lsd_stable_radixsort, msd_stable_radixsort, RadixKey, Radixable,
};
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
}
impl Verified for u32 {
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
fn run<
    T: Radixable<K> + PartialEq + std::fmt::Debug + Verified,
    K: RadixKey,
>(
    name: &str,
    load: &str,
    mut source: Vec<T>,
    block: usize,
    repeats: usize,
) {
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
    reference.sort_by_key(|x| x.into_key_type());
    for method in 0..4 {
        let mut times = Vec::new();
        let peak;
        let mut nodes = 0;
        let mut packed = 0;
        let mut relocated = 0;
        let mut relocations = 0;
        for _ in 0..repeats {
            let mut a = source.clone();
            let start = Instant::now();
            match method {
                0 => {
                    let st = block_msd_stable_radixsort(&mut a, 8, block);
                    nodes = st.nodes;
                    packed = st.packed_tail_elements;
                    relocated = st.relocated_tail_elements;
                    relocations = st.tail_relocations;
                },
                1 => {
                    let st =
                        dense_v3::block_msd_stable_radixsort(&mut a, 8, block);
                    nodes = st.nodes;
                    packed = st.packed_tail_elements;
                },
                2 => block_lsd_stable_radixsort(&mut a, 8, block),
                _ => msd_stable_radixsort(&mut a, 8),
            }
            let ns = start.elapsed().as_nanos();
            assert!(
                a.iter().zip(&reference).all(|(a, b)| a.same(b)),
                "full-record stable output mismatch"
            );
            times.push(ns);
        }
        let mut a = source.clone();
        LIVE.store(0, Ordering::Relaxed);
        PEAK.store(0, Ordering::Relaxed);
        TRACK.store(true, Ordering::Relaxed);
        match method {
            0 => {
                let st = block_msd_stable_radixsort(&mut a, 8, block);
                nodes = st.nodes;
                packed = st.packed_tail_elements;
                relocated = st.relocated_tail_elements;
                relocations = st.tail_relocations;
            },
            1 => {
                let st = dense_v3::block_msd_stable_radixsort(&mut a, 8, block);
                nodes = st.nodes;
                packed = st.packed_tail_elements;
            },
            2 => block_lsd_stable_radixsort(&mut a, 8, block),
            _ => msd_stable_radixsort(&mut a, 8),
        }
        TRACK.store(false, Ordering::Relaxed);
        peak = PEAK.load(Ordering::Relaxed);
        assert_eq!(LIVE.load(Ordering::Relaxed), 0);
        assert!(
            a.iter().zip(&reference).all(|(a, b)| a.same(b)),
            "full-record stable output mismatch"
        );
        times.sort();
        println!(
            "{},{},{},{},{},{},{},{},{},{},{}",
            name,
            load,
            source.len(),
            block,
            ["dense_msd_v4", "dense_msd_v3", "block_lsd", "msd_stable"][method],
            times[times.len() / 2],
            peak,
            nodes,
            packed,
            relocated,
            relocations
        );
    }
}
fn main() {
    let args: Vec<String> = std::env::args().collect();
    let n = args.get(1).map(|s| s.parse().unwrap()).unwrap_or(100_000);
    let repeats = args.get(2).map(|s| s.parse().unwrap()).unwrap_or(3);
    println!("type,load,n,block,algorithm,median_ns,peak_extra_heap_bytes,nodes,packed_tail_elements,relocated_tail_elements,tail_relocations");
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
