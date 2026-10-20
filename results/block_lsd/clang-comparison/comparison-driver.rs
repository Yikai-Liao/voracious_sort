use std::{hint::black_box, time::Instant};
use voracious_radix_sort::{block_lsd_stable_radixsort, RadixKey, Radixable};
mod candidate {
    #[path = "/home/lyk/code/voracious_sort-block-lsd/src/sorts/utils.rs"]
    pub mod utils;
    #[path = "/tmp/block-lsd-review/clang-comparison/submitted-source.rs"]
    pub mod submitted;
}
#[repr(C)]
#[derive(Clone, Copy, Debug, PartialEq, Eq, PartialOrd)]
struct Record { key: u32, payload: u32 }
impl Radixable<u32> for Record {
    type Key = u32;
    fn key(&self) -> u32 { self.key }
}
extern "C" {
    fn clang_permuted_sort(records: *mut Record, n: usize);
    fn gcc_permuted_sort(records: *mut Record, n: usize);
}
#[inline(never)]
fn rust_sort(arr: &mut [Record]) { block_lsd_stable_radixsort(arr, 8, 512); }
#[inline(never)]
fn submitted_sort(arr: &mut [Record]) { candidate::submitted::block_lsd_stable_radixsort(arr, 8, 512); }
fn run(arr: &mut [Record], method: usize) {
    match method {
        0 => unsafe { clang_permuted_sort(arr.as_mut_ptr(), arr.len()) },
        1 => unsafe { gcc_permuted_sort(arr.as_mut_ptr(), arr.len()) },
        2 => submitted_sort(arr),
        3 => rust_sort(arr),
        _ => unreachable!(),
    }
}
const NAMES: [&str; 4] = ["clang", "gcc", "submitted", "optimized"];
fn input(n: usize, distribution: &str) -> Vec<Record> {
    let mut state = 0x123456789abcdef0123456789abcdefu128;
    (0..n).map(|i| {
        state ^= state << 13; state ^= state >> 7; state ^= state << 17;
        let key = match distribution {
            "uniform" => state as u32,
            "duplicates" => (state % 256) as u32,
            "sorted" => i as u32,
            "reverse" => (n-i) as u32,
            _ => unreachable!(),
        };
        Record { key, payload: i as u32 }
    }).collect()
}
fn main() {
    let args: Vec<_> = std::env::args().collect();
    if args.get(1).map(String::as_str) == Some("--profile") {
        use std::io::{BufRead, BufReader, Write};
        let method: usize = args[3].parse().unwrap();
        let n = args[4].parse().unwrap();
        let repeats: usize = args[5].parse().unwrap();
        let original = input(n, "uniform");
        let mut expected = original.clone(); expected.sort_by_key(|r| r.key);
        let mut control = std::env::var("PERF_CONTROL").ok().map(|path| (
            std::fs::OpenOptions::new().write(true).open(path).unwrap(),
            BufReader::new(std::fs::File::open(std::env::var("PERF_ACK").unwrap()).unwrap())
        ));
        let mut signal = |command: &str| {
            if let Some((file, ack)) = &mut control {
                writeln!(file, "{}", command).unwrap(); file.flush().unwrap();
                let mut response = String::new(); ack.read_line(&mut response).unwrap();
                assert_eq!(response.trim_matches(|c:char| c.is_whitespace() || c=='\0'), "ack");
            }
        };
        for _ in 0..repeats {
            let mut arr = original.clone();
            signal("enable"); run(black_box(&mut arr), method); signal("disable");
            assert_eq!(arr, expected);
        }
        println!("profile,{},{},ok", NAMES[method], repeats);
        return;
    }
    let n = args.get(1).map(|x| x.parse().unwrap()).unwrap_or(1048576);
    let samples: usize = args.get(2).map(|x| x.parse().unwrap()).unwrap_or(15);
    let distribution = args.get(3).map(String::as_str).unwrap_or("uniform");
    let original = input(n, distribution);
    let mut expected = original.clone(); expected.sort_by_key(|r| r.key);
    for method in 0..4 { let mut arr = original.clone(); run(&mut arr, method); assert_eq!(arr, expected); }
    println!("n,distribution,algorithm,sample,ns");
    let mut arr = original.clone();
    for sample in 0..samples {
        for offset in 0..4 {
            let method = (sample+offset)%4;
            arr.copy_from_slice(&original);
            let start = Instant::now(); run(black_box(&mut arr), method);
            let ns = start.elapsed().as_nanos(); black_box(&arr); assert_eq!(arr, expected);
            println!("{},{},{},{},{}", n, distribution, NAMES[method], sample, ns);
        }
    }
}
