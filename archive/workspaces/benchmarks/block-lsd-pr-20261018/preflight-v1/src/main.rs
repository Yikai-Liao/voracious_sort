use std::{cmp::Ordering, hint::black_box, time::Instant};
use voracious_radix_sort::{block_lsd_stable_radixsort, lsd_stable_radixsort, RadixKey, Radixable};

#[cfg(feature = "track-alloc")]
mod allocation {
    use std::{
        alloc::{GlobalAlloc, Layout, System},
        sync::atomic::{AtomicBool, AtomicUsize, Ordering::Relaxed},
    };
    pub struct Meter;
    pub static ACTIVE: AtomicBool = AtomicBool::new(false);
    pub static LIVE: AtomicUsize = AtomicUsize::new(0);
    pub static PEAK: AtomicUsize = AtomicUsize::new(0);
    pub static TOTAL: AtomicUsize = AtomicUsize::new(0);
    pub static CALLS: AtomicUsize = AtomicUsize::new(0);
    fn add(n: usize) {
        let live = LIVE.fetch_add(n, Relaxed) + n;
        PEAK.fetch_max(live, Relaxed);
        TOTAL.fetch_add(n, Relaxed);
        CALLS.fetch_add(1, Relaxed);
    }
    unsafe impl GlobalAlloc for Meter {
        unsafe fn alloc(&self, l: Layout) -> *mut u8 {
            let p = System.alloc(l);
            if !p.is_null() && ACTIVE.load(Relaxed) {
                add(l.size());
            }
            p
        }
        unsafe fn alloc_zeroed(&self, l: Layout) -> *mut u8 {
            let p = System.alloc_zeroed(l);
            if !p.is_null() && ACTIVE.load(Relaxed) {
                add(l.size());
            }
            p
        }
        unsafe fn dealloc(&self, p: *mut u8, l: Layout) {
            if ACTIVE.load(Relaxed) {
                LIVE.fetch_sub(l.size(), Relaxed);
            }
            System.dealloc(p, l);
        }
        unsafe fn realloc(&self, p: *mut u8, l: Layout, n: usize) -> *mut u8 {
            let q = System.realloc(p, l, n);
            if !q.is_null() && ACTIVE.load(Relaxed) {
                LIVE.fetch_sub(l.size(), Relaxed);
                add(n);
            }
            q
        }
    }
    pub fn start() {
        for v in [&LIVE, &PEAK, &TOTAL, &CALLS] {
            v.store(0, Relaxed);
        }
        ACTIVE.store(true, Relaxed);
    }
    pub fn stop() -> (usize, usize, usize) {
        ACTIVE.store(false, Relaxed);
        assert_eq!(LIVE.load(Relaxed), 0, "sort retained an allocation");
        (PEAK.load(Relaxed), TOTAL.load(Relaxed), CALLS.load(Relaxed))
    }
}
#[cfg(feature = "track-alloc")]
#[global_allocator]
static ALLOCATOR: allocation::Meter = allocation::Meter;

fn mix(mut x: u64) -> u64 {
    x = (x ^ (x >> 30)).wrapping_mul(0xbf58476d1ce4e5b9);
    x = (x ^ (x >> 27)).wrapping_mul(0x94d049bb133111eb);
    x ^ (x >> 31)
}
fn next(state: &mut u64) -> u64 {
    *state = state.wrapping_add(0x9e3779b97f4a7c15);
    mix(*state)
}

trait Value<K: RadixKey>: Radixable<K> {
    fn make(word: u128, position: usize) -> Self;
    fn same(&self, other: &Self) -> bool;
    fn fingerprint(&self) -> u64;
    fn position(&mut self, _: usize) {}
    fn prefix(word: u128) -> u128;
}
macro_rules! integer {
    ($t:ty, $bits:expr) => {
        impl Value<$t> for $t {
            fn make(w: u128, _: usize) -> Self {
                w as $t
            }
            fn same(&self, other: &Self) -> bool {
                self == other
            }
            fn fingerprint(&self) -> u64 {
                mix(*self as u64) ^ mix((*self as u128 >> 64) as u64)
            }
            fn prefix(w: u128) -> u128 {
                ((u128::MAX >> (128 - $bits)) & !65535) | (w & 65535)
            }
        }
    };
}
integer!(u32, 32);
integer!(u64, 64);
integer!(u128, 128);
integer!(i64, 64);
impl Value<f64> for f64 {
    fn make(w: u128, _: usize) -> Self {
        let mut bits = w as u64;
        if bits & 0x7ff0000000000000 == 0x7ff0000000000000 {
            bits ^= 0x0010000000000000;
        }
        if bits == 0x8000000000000000 {
            bits = 0;
        }
        Self::from_bits(bits)
    }
    fn same(&self, other: &Self) -> bool {
        self.to_bits() == other.to_bits()
    }
    fn fingerprint(&self) -> u64 {
        mix(self.to_bits())
    }
    fn prefix(w: u128) -> u128 {
        0x3ff0000000000000 | (w & 65535)
    }
}
#[repr(C)]
#[derive(Clone, Copy)]
struct Record<const N: usize> {
    key: u64,
    id: u64,
    payload: [u64; N],
}
impl<const N: usize> PartialEq for Record<N> {
    fn eq(&self, b: &Self) -> bool {
        self.key == b.key
    }
}
impl<const N: usize> PartialOrd for Record<N> {
    fn partial_cmp(&self, b: &Self) -> Option<Ordering> {
        self.key.partial_cmp(&b.key)
    }
}
impl<const N: usize> Radixable<u64> for Record<N> {
    type Key = u64;
    fn key(&self) -> u64 {
        self.key
    }
}
impl<const N: usize> Value<u64> for Record<N> {
    fn make(w: u128, i: usize) -> Self {
        Self {
            key: w as u64,
            id: i as u64,
            payload: std::array::from_fn(|j| {
                mix((i as u64).wrapping_mul(17).wrapping_add(j as u64))
            }),
        }
    }
    fn same(&self, b: &Self) -> bool {
        self.key == b.key && self.id == b.id && self.payload == b.payload
    }
    fn fingerprint(&self) -> u64 {
        self.payload
            .iter()
            .fold(mix(self.key) ^ mix(self.id), |x, p| x.wrapping_add(mix(*p)))
    }
    fn position(&mut self, i: usize) {
        *self = Self::make(self.key as u128, i);
    }
    fn prefix(w: u128) -> u128 {
        (u64::MAX as u128 & !65535) | (w & 65535)
    }
}

fn input<T: Value<K>, K: RadixKey>(dist: &str, n: usize, seed: u64) -> Vec<T> {
    let mut state = seed;
    let mut a: Vec<T> = (0..n)
        .map(|i| {
            let w = ((next(&mut state) as u128) << 64) | next(&mut state) as u128;
            let w = match dist {
                "uniform" => w,
                "few_unique" => w & 15,
                "common_prefix" => T::prefix(w),
                "all_equal" => 42,
                "sorted" | "reversed" | "nearly_sorted" => (i / 4) as u128,
                _ => panic!("unknown distribution"),
            };
            T::make(w, i)
        })
        .collect();
    if matches!(dist, "sorted" | "reversed" | "nearly_sorted") {
        a.sort_by_key(|v| v.into_key_type());
        if dist == "reversed" {
            a.reverse();
        }
        if dist == "nearly_sorted" {
            for _ in 0..(n / 100).max(1) {
                a.swap(next(&mut state) as usize % n, next(&mut state) as usize % n);
            }
        }
        for (i, v) in a.iter_mut().enumerate() {
            v.position(i);
        }
    }
    a
}

#[inline(never)]
fn sort<T: Value<K>, K: RadixKey>(a: &mut [T], algorithm: &str, radix: usize, block: usize) {
    match algorithm {
        "block_lsd" | "block_bytes" | "block_sqrt" => {
            block_lsd_stable_radixsort::<T, K>(black_box(a), radix, block)
        }
        "lsd" | "lsd_aa" => lsd_stable_radixsort::<T, K>(black_box(a), radix),
        "std" => a.sort_by_key(|v| v.into_key_type()),
        _ => panic!("unknown algorithm"),
    }
}

fn validate<T: Value<K>, K: RadixKey>(
    work: &[T],
    expected: &[T],
    algorithm: &str,
) -> (bool, bool, bool, u64) {
    let stable = work.iter().zip(expected).all(|(a, b)| a.same(b));
    let ordered = stable
        || work
            .windows(2)
            .all(|w| w[0].into_key_type() <= w[1].into_key_type());
    let digest = work
        .iter()
        .fold(0u64, |s, v| s.wrapping_add(v.fingerprint()));
    let preserved = stable
        || digest
            == expected
                .iter()
                .fold(0u64, |s, v| s.wrapping_add(v.fingerprint()));
    assert!(
        stable || matches!(algorithm, "lsd" | "lsd_aa"),
        "candidate/oracle mismatch"
    );
    (stable, ordered, preserved, digest)
}

fn run<T: Value<K>, K: RadixKey>(args: &[String]) {
    let mode = &args[1];
    let kind = &args[2];
    let dist = &args[3];
    let n: usize = args[4].parse().unwrap();
    let master: u64 = args[5].parse().unwrap();
    let radix: usize = args[6].parse().unwrap();
    let block: usize = args[7].parse().unwrap();
    let seeds: usize = args[8].parse().unwrap();
    let only = args.get(9).map(String::as_str).unwrap_or("all");
    for pair in 0..seeds {
        let seed = mix(master.wrapping_add(pair as u64));
        let original = input::<T, K>(dist, n, seed);
        let input_digest = original
            .iter()
            .fold(0u64, |s, v| s.rotate_left(1) ^ v.fingerprint());
        let mut expected = original.clone();
        expected.sort_by_key(|v| v.into_key_type());
        let base = if only == "all" {
            vec![
                "lsd",
                "block_lsd",
                "block_bytes",
                "block_sqrt",
                "std",
                "lsd_aa",
            ]
        } else {
            vec![only]
        };
        let orders = if mode == "time" { 2 } else { 1 };
        for order in 0..orders {
            let mut algorithms = base.clone();
            if order == 1 {
                algorithms.reverse();
            }
            // Rotate the order between seeds, preserving the exact reversed partner.
            let rotate = pair % algorithms.len();
            if order == 0 {
                algorithms.rotate_left(rotate);
            } else {
                algorithms.rotate_right(rotate);
            }
            for (slot, &algorithm) in algorithms.iter().enumerate() {
                // Policy selection is outside the sort's timed interval.
                let block = match algorithm {
                    "block_bytes" => (4096 / std::mem::size_of::<T>()).max(1),
                    "block_sqrt" => ((9.0 * n as f64
                        / (2.0 * (1usize << radix) as f64 * std::mem::size_of::<T>() as f64))
                        .sqrt()
                        .ceil() as usize)
                        .max(1),
                    _ => block,
                };
                let mut warm = original.clone();
                let start = Instant::now();
                sort::<T, K>(&mut warm, algorithm, radix, block);
                let pilot = start.elapsed().as_nanos().max(1) as usize;
                validate::<T, K>(&warm, &expected, algorithm);
                drop(warm);
                if mode == "time" {
                    // Clone/initialization/verification are outside the timed interval.
                    // 3 ms target, at most 64 MiB of independent input buffers.
                    let cap =
                        (64 * 1024 * 1024 / (n * std::mem::size_of::<T>()).max(1)).clamp(1, 2048);
                    let batch = (3_000_000usize.div_ceil(pilot)).clamp(1, cap);
                    let mut work: Vec<Vec<T>> = (0..batch).map(|_| original.clone()).collect();
                    let start = Instant::now();
                    for a in &mut work {
                        sort::<T, K>(black_box(a), algorithm, radix, block);
                    }
                    let elapsed = start.elapsed().as_nanos();
                    let mut valid = true;
                    let mut ordered = true;
                    let mut preserved = true;
                    let mut digest = 0;
                    for a in &work {
                        let (v, o, p, d) = validate::<T, K>(a, &expected, algorithm);
                        valid &= v;
                        ordered &= o;
                        preserved &= p;
                        digest ^= d;
                    }
                    println!("{{\"mode\":\"time\",\"kind\":\"{kind}\",\"dist\":\"{dist}\",\"n\":{n},\"bytes_per_record\":{},\"pair\":{pair},\"seed\":{seed},\"order\":{order},\"slot\":{slot},\"algorithm\":\"{algorithm}\",\"radix\":{radix},\"block\":{block},\"elapsed_ns\":{elapsed},\"batch\":{batch},\"ns\":{},\"valid\":{valid},\"ordered\":{ordered},\"preserved\":{preserved},\"input_digest\":{input_digest},\"digest\":{digest}}}", std::mem::size_of::<T>(), elapsed as f64 / batch as f64);
                } else {
                    #[cfg(not(feature = "track-alloc"))]
                    panic!("memory mode needs --features track-alloc");
                    #[cfg(feature = "track-alloc")]
                    {
                        let mut work = original.clone();
                        allocation::start();
                        sort::<T, K>(&mut work, algorithm, radix, block);
                        let (peak, total, calls) = allocation::stop();
                        let (valid, ordered, preserved, digest) =
                            validate::<T, K>(&work, &expected, algorithm);
                        println!("{{\"mode\":\"memory\",\"kind\":\"{kind}\",\"dist\":\"{dist}\",\"n\":{n},\"bytes_per_record\":{},\"pair\":{pair},\"seed\":{seed},\"algorithm\":\"{algorithm}\",\"radix\":{radix},\"block\":{block},\"peak_bytes\":{peak},\"total_bytes\":{total},\"alloc_calls\":{calls},\"valid\":{valid},\"ordered\":{ordered},\"preserved\":{preserved},\"input_digest\":{input_digest},\"digest\":{digest}}}", std::mem::size_of::<T>());
                    }
                }
            }
        }
    }
    let status = std::fs::read_to_string("/proc/self/status").unwrap();
    let swap = status
        .lines()
        .find(|s| s.starts_with("VmSwap:"))
        .unwrap_or("VmSwap: unavailable");
    eprintln!("process_swap {swap}");
}
fn main() {
    let args: Vec<String> = std::env::args().collect();
    match args[2].as_str() {
        "u32" => run::<u32, u32>(&args),
        "u64" => run::<u64, u64>(&args),
        "u128" => run::<u128, u128>(&args),
        "i64" => run::<i64, i64>(&args),
        "f64" => run::<f64, f64>(&args),
        "record32" => run::<Record<2>, u64>(&args),
        "record128" => run::<Record<14>, u64>(&args),
        _ => panic!("unknown type"),
    }
}
