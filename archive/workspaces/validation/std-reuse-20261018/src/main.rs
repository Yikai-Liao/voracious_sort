use std::{hint::black_box, time::{Duration, Instant}};
use voracious_radix_sort::block_lsd_stable_radixsort;

fn main() {
    let case = std::env::args().nth(1).unwrap();
    let n = match case.as_str() { "small" => 128, "scatter" => 8192, _ => 1 << 20 };
    let mut state = 0x123456789abcdefu64;
    let input: Vec<u64> = (0..n).map(|i| {
        state ^= state << 13; state ^= state >> 7; state ^= state << 17;
        match case.as_str() {
            "equal" => 42,
            "late-difference" => if i + 1 == n { 43 } else { 42 },
            "descending" => ((n-i)/7) as u64,
            _ => state,
        }
    }).collect();
    let mut expected = input.clone(); expected.sort();
    let mut work = input.clone();
    block_lsd_stable_radixsort(&mut work, 8, 512);
    assert_eq!(work, expected);
    let mut elapsed = Duration::ZERO;
    let mut iterations = 0u64;
    let mut digest = 0u64;
    while elapsed.as_millis() < 180 {
        work.copy_from_slice(&input);
        let start = Instant::now();
        block_lsd_stable_radixsort(black_box(&mut work), 8, 512);
        elapsed += start.elapsed();
        digest = digest.wrapping_add(black_box(work[n/2]));
        iterations += 1;
    }
    assert_eq!(work, expected);
    println!("{{\"case\":\"{}\",\"ns_per_sort\":{},\"iterations\":{},\"check\":{}}}", case, elapsed.as_nanos() as f64 / iterations as f64, iterations, digest);
}
