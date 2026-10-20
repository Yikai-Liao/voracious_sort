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
    pub fn add(n: usize) {
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

extern "C" {
    fn benchmark_timsort(data: *mut std::ffi::c_void, n: usize, kind: u32);
}
#[cfg(feature = "track-alloc")]
#[no_mangle]
extern "C" fn benchmark_cpp_allocate(n: usize) {
    if allocation::ACTIVE.load(std::sync::atomic::Ordering::Relaxed) {
        allocation::add(n);
    }
}
#[cfg(feature = "track-alloc")]
#[no_mangle]
extern "C" fn benchmark_cpp_deallocate(n: usize) {
    if allocation::ACTIVE.load(std::sync::atomic::Ordering::Relaxed) {
        allocation::LIVE.fetch_sub(n, std::sync::atomic::Ordering::Relaxed);
    }
}

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
    fn cpp_kind() -> u32;
    fn rank(word: u128, i: usize) -> Self {
        Self::make(word, i)
    }
    fn low_constant(word: u128) -> u128 {
        word & !65535
    }
    fn high_only(word: u128) -> u128 {
        (word & 127) << 24
    }
    fn normal(z: f64, i: usize) -> Self {
        Self::make((1073741824.0 + z * 1048576.0) as u128, i)
    }
    fn dedicated(_: &mut [Self]) {
        panic!("no dedicated implementation for this type")
    }
    fn has_dedicated() -> bool {
        false
    }
}
fn unsupported<T>(_: &mut [T]) {
    panic!("no dedicated implementation");
}
macro_rules! integer {
    ($t:ty, $bits:expr, $ded:path, $has:expr, $kind:expr) => {
        impl Value<$t> for $t {
            fn cpp_kind() -> u32 {
                $kind
            }
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
            fn high_only(w: u128) -> u128 {
                (w & 127) << ($bits - 8)
            }
            fn normal(z: f64, i: usize) -> Self {
                let offset = if <$t>::MIN == 0 { 1073741824.0 } else { 0.0 };
                Self::make((offset + z * 1048576.0) as i128 as u128, i)
            }
            fn dedicated(a: &mut [Self]) {
                $ded(a)
            }
            fn has_dedicated() -> bool {
                $has
            }
        }
    };
}
integer!(u32, 32, voracious_radix_sort::lsd_u32, true, 0);
integer!(u64, 64, unsupported, false, 1);
integer!(u128, 128, unsupported, false, 2);
integer!(i32, 32, unsupported, false, 3);
integer!(i64, 64, unsupported, false, 4);
impl Value<f64> for f64 {
    fn cpp_kind() -> u32 {
        6
    }
    fn rank(word: u128, _: usize) -> Self {
        word as f64
    }
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
    fn low_constant(w: u128) -> u128 {
        w & 0x7fefffffff000000
    }
    fn high_only(w: u128) -> u128 {
        ((w & 127) << 56) | 0x0001000000000000
    }
    fn normal(z: f64, _: usize) -> Self {
        z
    }
}
impl Value<f32> for f32 {
    fn cpp_kind() -> u32 {
        5
    }
    fn rank(word: u128, _: usize) -> Self {
        word as f32
    }
    fn make(w: u128, _: usize) -> Self {
        let mut bits = w as u32;
        if bits & 0x7f800000 == 0x7f800000 {
            bits ^= 0x00800000;
        }
        if bits == 0x80000000 {
            bits = 0;
        }
        Self::from_bits(bits)
    }
    fn same(&self, b: &Self) -> bool {
        self.to_bits() == b.to_bits()
    }
    fn fingerprint(&self) -> u64 {
        mix(self.to_bits() as u64)
    }
    fn prefix(w: u128) -> u128 {
        0x3f800000 | (w & 65535)
    }
    fn low_constant(w: u128) -> u128 {
        w & 0x7f7f0000
    }
    fn high_only(w: u128) -> u128 {
        ((w & 127) << 24) | 0x00010000
    }
    fn normal(z: f64, _: usize) -> Self {
        z as f32
    }
    fn dedicated(a: &mut [Self]) {
        voracious_radix_sort::lsd_f32(a)
    }
    fn has_dedicated() -> bool {
        true
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
    fn cpp_kind() -> u32 {
        if N == 2 {
            7
        } else {
            assert_eq!(N, 14);
            8
        }
    }
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
    fn high_only(w: u128) -> u128 {
        (w & 127) << 56
    }
}

fn input<T: Value<K>, K: RadixKey>(dist: &str, n: usize, seed: u64) -> Vec<T> {
    let mut state = seed;
    let mut zipf_cdf = Vec::new();
    if dist == "zipf" {
        let mut total = 0.0;
        for i in 1..=1024 {
            total += (i as f64).powf(-1.2);
            zipf_cdf.push(total);
        }
        for x in &mut zipf_cdf {
            *x /= total;
        }
    }
    let mut a: Vec<T> = (0..n)
        .map(|i| {
            let w = ((next(&mut state) as u128) << 64) | next(&mut state) as u128;
            if matches!(dist, "normal" | "uniform_numeric") {
                let u = ((w as u64 >> 11) as f64 + 0.5) / (1u64 << 53) as f64;
                let v = (((w >> 64) as u64 >> 11) as f64 + 0.5) / (1u64 << 53) as f64;
                if dist == "uniform_numeric" {
                    return T::normal(2.0 * u - 1.0, i);
                }
                return T::normal(
                    (-2.0 * u.ln()).sqrt() * (std::f64::consts::TAU * v).cos(),
                    i,
                );
            }
            let w = match dist {
                "uniform" => w,
                "uniform_narrow" => w % 1_000_000_000,
                "skew95" => {
                    if w as u64 % 20 != 0 {
                        0
                    } else {
                        w
                    }
                }
                "few_unique" => w & 15,
                "sqrt_keys" => w % (n as f64).sqrt().ceil().max(1.0) as u128,
                "common_prefix" => T::prefix(w),
                "low_bits_constant" => T::low_constant(w),
                "high_only" => T::high_only(w),
                "late_difference" => {
                    if i + 1 == n {
                        43
                    } else {
                        42
                    }
                }
                "alternating" => {
                    if i % 2 == 0 {
                        0
                    } else {
                        u128::MAX
                    }
                }
                "organ_pipe" => i.min(n - 1 - i) as u128,
                "sawtooth" => (i % (n / 16).max(2)) as u128,
                "zipf" => {
                    let u = ((w as u64 >> 11) as f64 + 0.5) / (1u64 << 53) as f64;
                    zipf_cdf.partition_point(|x| *x < u) as u128
                }
                "all_equal" => 42,
                "sorted"
                | "reversed"
                | "nearly_sorted"
                | "almost_sorted"
                | "reverse_nearly_sorted"
                | "push_front"
                | "push_middle" => (i / 4) as u128,
                _ => panic!("unknown distribution"),
            };
            if matches!(
                dist,
                "uniform"
                    | "skew95"
                    | "common_prefix"
                    | "low_bits_constant"
                    | "high_only"
                    | "alternating"
            ) {
                T::make(w, i)
            } else {
                T::rank(w, i)
            }
        })
        .collect();
    if matches!(
        dist,
        "sorted"
            | "reversed"
            | "nearly_sorted"
            | "almost_sorted"
            | "reverse_nearly_sorted"
            | "push_front"
            | "push_middle"
    ) {
        a.sort_by_key(|v| v.into_key_type());
        if matches!(dist, "reversed" | "reverse_nearly_sorted") {
            a.reverse();
        }
        if matches!(
            dist,
            "nearly_sorted" | "reverse_nearly_sorted" | "almost_sorted"
        ) {
            let swaps = if dist == "almost_sorted" {
                (n as f64).log2().ceil() as usize
            } else {
                n / 100
            };
            for _ in 0..swaps.max(1) {
                a.swap(next(&mut state) as usize % n, next(&mut state) as usize % n);
            }
        }
        if dist == "push_front" {
            a.rotate_right(1);
        }
        if dist == "push_middle" {
            a[n / 2..].rotate_right(1);
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
        x if x.starts_with("block_") => {
            block_lsd_stable_radixsort::<T, K>(black_box(a), radix, block)
        }
        "lsd" | "lsd_aa" => lsd_stable_radixsort::<T, K>(black_box(a), radix),
        "lsd_plain" => voracious_radix_sort::lsd_radixsort::<T, K>(black_box(a), radix),
        "lsd_core" => {
            voracious_radix_sort::lsd_radixsort_aux::<T, K>(black_box(a), radix, false, 0)
        }
        "lsd_heuristic" => {
            voracious_radix_sort::lsd_radixsort_heu::<T, K>(black_box(a), radix, 100_000)
        }
        "dlsd" => voracious_radix_sort::dlsd_radixsort::<T, K>(black_box(a), radix),
        "thiel" => voracious_radix_sort::thiel_radixsort::<T, K>(black_box(a), radix),
        "dedicated" => T::dedicated(black_box(a)),
        // The bridge has a matching POD layout and compares the same converted
        // key. It makes one FFI call per sort, never one per comparison.
        "timsort" => unsafe { benchmark_timsort(a.as_mut_ptr().cast(), a.len(), T::cpp_kind()) },
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
        stable || !(algorithm.starts_with("block_") || matches!(algorithm, "std" | "timsort")),
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
            let mut b = vec![
                "lsd",
                "block_count_128",
                "block_lsd",
                "block_count_1024",
                "block_bytes_1024",
                "block_bytes",
                "block_bytes_8192",
                "block_sqrt_half",
                "block_sqrt",
                "block_sqrt_double",
                "lsd_plain",
                "lsd_core",
                "dlsd",
                "std",
                "timsort",
                "lsd_aa",
            ];
            if kind != "u128" {
                b.push("thiel");
            }
            if !kind.starts_with("record") {
                b.push("lsd_heuristic");
            }
            if T::has_dedicated() {
                b.push("dedicated");
            }
            b
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
                let balanced = (9.0 * n as f64
                    / (2.0 * (1usize << radix) as f64 * std::mem::size_of::<T>() as f64))
                    .sqrt();
                let block = match algorithm {
                    "block_count_128" => 128,
                    "block_count_1024" => 1024,
                    "block_bytes_1024" => (1024 / std::mem::size_of::<T>()).max(1),
                    "block_bytes" => (4096 / std::mem::size_of::<T>()).max(1),
                    "block_bytes_8192" => (8192 / std::mem::size_of::<T>()).max(1),
                    "block_sqrt_half" => (0.5 * balanced).ceil().max(1.0) as usize,
                    "block_sqrt" => balanced.ceil().max(1.0) as usize,
                    "block_sqrt_double" => (2.0 * balanced).ceil().max(1.0) as usize,
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
        "i32" => run::<i32, i32>(&args),
        "f32" => run::<f32, f32>(&args),
        "f64" => run::<f64, f64>(&args),
        "record32" => run::<Record<2>, u64>(&args),
        "record128" => run::<Record<14>, u64>(&args),
        _ => panic!("unknown type"),
    }
}
