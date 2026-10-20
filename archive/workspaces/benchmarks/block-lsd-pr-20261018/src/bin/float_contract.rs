use voracious_radix_sort::{block_lsd_stable_radixsort, Radixable};
extern "C" {
    fn benchmark_timsort(data: *mut std::ffi::c_void, n: usize, kind: u32);
}
macro_rules! check {
    ($t:ty, $u:ty, $kind:expr, $bits:expr) => {{
        let patterns: &[$u] = &$bits;
        println!("{{\"kind\":\"{}\",\"role\":\"input_patterns\",\"bits\":{:?}}}", stringify!($t), patterns);
        for n in [128, 515, 16384] {
            let input: Vec<$t> = patterns.iter().copied().cycle().take(n).map(<$t>::from_bits).collect();
            let mut expected = input.clone();
            expected.sort_by_key(|v| v.into_key_type());
            let expected: Vec<$u> = expected.iter().map(|v| v.to_bits()).collect();
            for algorithm in ["block", "std", "timsort"] {
                let parameters = if algorithm == "block" { vec![(1,1),(4,3),(8,128),(8,512),(8,1024)] } else { vec![(8,512)] };
                for (radix, block) in parameters {
                    let mut work = input.clone();
                    match algorithm {
                        "block" => block_lsd_stable_radixsort(&mut work, radix, block),
                        "std" => work.sort_by_key(|v| v.into_key_type()),
                        "timsort" => unsafe { benchmark_timsort(work.as_mut_ptr().cast(), n, $kind) },
                        _ => unreachable!(),
                    }
                    assert!(work.iter().map(|v| v.to_bits()).eq(expected.iter().copied()));
                    println!("{{\"kind\":\"{}\",\"n\":{n},\"algorithm\":\"{algorithm}\",\"radix\":{radix},\"block\":{block},\"exact_bits_match\":true}}", stringify!($t));
                }
            }
        }
    }};
}
fn main() {
    check!(
        f32,
        u32,
        5,
        [
            0, 0x80000000, 0x7f800000, 0xff800000, 0x7fc00001, 0x7fa00002, 0xffc00003, 0xffa00004,
            1, 0x80000001, 0x3f800000, 0xbf800000, 0x7f7fffff, 0xff7fffff
        ]
    );
    check!(
        f64,
        u64,
        6,
        [
            0,
            0x8000000000000000,
            0x7ff0000000000000,
            0xfff0000000000000,
            0x7ff8000000000001,
            0x7ff0000000000002,
            0xfff8000000000003,
            0xfff0000000000004,
            1,
            0x8000000000000001,
            0x3ff0000000000000,
            0xbff0000000000000,
            0x7fefffffffffffff,
            0xffefffffffffffff
        ]
    );
}
