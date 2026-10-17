// Diagnostic only. Generator functions extracted verbatim from 02735e95304b3a9d17ba38a80663caabb8d1da74.
fn random(s: &mut u64) -> u64 {
    *s ^= *s << 13;
    *s ^= *s >> 7;
    *s ^= *s << 17;
    *s
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
fn main() {
    println!("n,bits,seed,case,width,ordinary_bits,band_low,skipped_bits,population,population_fraction,approved");
    for n in [262144usize, 1048576] {
        for bits in [64usize, 128] {
            for seed in [42u64, 7] {
                for case in ["deep_skew", "majority_prefix", "deep_unique90", "deep_unique98"] {
                    let arr = make_keys(n, bits, case, seed);
                    if case.starts_with("deep_unique") {
                        let reserved = ((usize::BITS as usize - (n - 1).leading_zeros() as usize + 7) / 8) * 8;
                        let mut seen = vec![false; n];
                        for key in &arr {
                            let id = (key & ((1u128 << reserved) - 1)) as usize;
                            assert!(id < n && !seen[id]);
                            seen[id] = true;
                        }
                    }
                    let mut sample = [0u128; 64];
                    let last = n - 1;
                    let mut ascending = true;
                    let mut descending = true;
                    let mut previous = arr[0];
                    for i in 0..64 {
                        let key = arr[i * (last / 63) + i * (last % 63) / 63];
                        ascending &= previous <= key;
                        descending &= previous >= key;
                        previous = key;
                        sample[i] = key;
                    }
                    let union = arr.iter().fold(0u128, |a, b| a | b);
                    let intersection = arr.iter().fold(u128::MAX, |a, b| a & b);
                    let width = 128 - (union ^ intersection).leading_zeros() as usize;
                    let coarse = ((usize::BITS as usize - (n - 1).leading_zeros() as usize + 7) / 8) * 8;
                    let pivot = *sample.select_nth_unstable(32).1;
                    for key in &mut sample { *key ^= pivot; }
                    let distance = *sample.select_nth_unstable(39).1;
                    let low = 128 - distance.leading_zeros() as usize;
                    let prefix = pivot >> low;
                    let population = arr.iter().filter(|key| **key >> low == prefix).count();
                    let sample_has_exit = sample.iter().any(|d| *d >> low != 0);
                    let approved = !ascending && !descending && bits - low > coarse && sample_has_exit && width.saturating_sub(low) > coarse.min(width) && population > n / 2;
                    println!("{n},{bits},{seed},{case},{width},{coarse},{low},{},{population},{:.9},{approved}", width.saturating_sub(low), population as f64 / n as f64);
                }
            }
        }
    }
}
