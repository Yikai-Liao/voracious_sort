use block_msd_research::work_reduction::kernel_u32;
use std::time::Instant;
fn main() {
    let repeats =
        std::env::args().nth(1).map(|s| s.parse().unwrap()).unwrap_or(101);
    println!("n,algorithm,sample,ns,scatter_nodes,scatter_records,leaf_calls");
    for n in [1024, 4096, 16384, 65536, 262144] {
        let mut seed = 61789u64;
        let source: Vec<u32> = (0..n)
            .map(|_| {
                seed ^= seed << 13;
                seed ^= seed >> 7;
                seed ^= seed << 17;
                seed as u32
            })
            .collect();
        let mut expected = source.clone();
        expected.sort();
        let mut a = source.clone();
        let mut scratch = vec![0; n];
        let mut shape = None;
        let methods = [
            "cached_three_arrays",
            "cached_two_arrays",
            "copy_scatter_key_leaf",
            "copy_scatter_partial_leaf",
        ];
        for sample in 0..repeats {
            for offset in 0..4 {
                let method = (sample + offset) % 4;
                a.copy_from_slice(&source);
                let start = Instant::now();
                let work = kernel_u32(
                    std::hint::black_box(&mut a),
                    &mut scratch,
                    32,
                    method,
                );
                let ns = start.elapsed().as_nanos();
                assert_eq!(a, expected);
                if let Some(old) = shape {
                    assert_eq!(old, work);
                } else {
                    shape = Some(work);
                }
                println!(
                    "{},{},{},{},{},{},{}",
                    n, methods[method], sample, ns, work.0, work.1, work.2
                );
            }
        }
    }
}
