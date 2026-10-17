use super::*;
use std::cmp::Ordering;

#[derive(Clone, Copy, Debug)]
struct Item {
    key: u128,
    id: usize,
    payload: [u64; 3],
}
impl PartialEq for Item {
    fn eq(&self, rhs: &Self) -> bool {
        self.key == rhs.key
    }
}
impl PartialOrd for Item {
    fn partial_cmp(&self, rhs: &Self) -> Option<Ordering> {
        self.key.partial_cmp(&rhs.key)
    }
}
impl Radixable<u128> for Item {
    type Key = u128;
    fn key(&self) -> u128 {
        self.key
    }
}
fn random(s: &mut u64) -> u64 {
    *s ^= *s << 13;
    *s ^= *s >> 7;
    *s ^= *s << 17;
    *s
}

#[test]
fn exhaustive_frontier_intervals() {
    for width in 1..=8 {
        for coarse in 1..=width {
            for pivot in 0..(1u128 << width) {
                let f = Frontier::new(pivot, width, coarse);
                let mut previous = 0;
                let mut group_start = 0;
                for x in 0..(1u128 << width) {
                    let label = f.label(x);
                    assert!(label >= previous);
                    assert!(
                        label < (1u128 << coarse) + (width - coarse) as u128
                    );
                    if x == 0 || previous != label {
                        group_start = x;
                    }
                    let low = f.remaining(x);
                    assert_eq!(x >> low, group_start >> low);
                    if low == 0 {
                        assert_eq!(x, group_start);
                    }
                    previous = label;
                }
            }
        }
    }
}

#[test]
fn wide_labels_and_common_high_bits() {
    for width in [1, 7, 8, 9, 15, 16, 23, 24, 63, 64, 65, 120, 127, 128] {
        for coarse in [1, 7, 8, 15, 16, 23, 24, 63, 64, 127, 128]
            .iter()
            .copied()
            .filter(|&k| k <= width)
        {
            for pivot in
                [0, 1, u128::MAX, 0xaaaa_aaaa_aaaa_aaaa_5555_5555_5555_5555]
            {
                let f = Frontier::new(pivot, width, coarse);
                let mut keys = vec![0, 1, mask(width), pivot & mask(width)];
                for b in 0..width {
                    keys.push((pivot ^ (1u128 << b)) & mask(width));
                }
                keys.sort();
                for pair in keys.windows(2) {
                    assert!(f.label(pair[0]) <= f.label(pair[1]));
                    assert_eq!(
                        f.label(pair[0]),
                        f.label(pair[0] | !mask(width))
                    );
                }
            }
        }
    }
}

#[test]
fn recursive_identity_and_payload_matrix() {
    let mut state = 0x123456789abcdef;
    for n in [
        0, 1, 2, 20, 127, 128, 129, 255, 256, 257, 511, 512, 513, 4095, 4096,
        65535, 65536, 65537,
    ] {
        for distribution in 0..8 {
            let mut input: Vec<Item> = (0..n)
                .map(|id| {
                    let random_key = (random(&mut state) as u128) << 64
                        | random(&mut state) as u128;
                    let key = match distribution {
                        0 => random_key,
                        1 => random_key & 0xffff,
                        2 => {
                            if id % 10 != 0 {
                                0
                            } else {
                                1u128 << (id % 128)
                            }
                        },
                        3 => (random_key & 0xffff) | (0xdeadbeefu128 << 96),
                        4 => [0, 18, 36, 54, 72, 90, 108, 126]
                            .iter()
                            .enumerate()
                            .fold(0, |key, (i, b)| {
                                key | (((id >> i) & 1) as u128) << b
                            }),
                        5 => {
                            if id % 10 != 0 {
                                random_key & ((1u128 << 64) - 1)
                            } else {
                                random_key
                            }
                        },
                        6 => id as u128 / 3,
                        _ => 7,
                    };
                    Item {
                        key,
                        id,
                        payload: [id as u64, !(id as u64), id as u64 * 37],
                    }
                })
                .collect();
            if distribution == 6 {
                input.reverse();
            }
            // Identity refers to incoming order even after a permutation.
            for (id, x) in input.iter_mut().enumerate() {
                x.id = id;
            }
            let mut expected = input.clone();
            expected.sort_by_key(|x| x.key);
            for mode in [Mode::L, Mode::H, Mode::P, Mode::F] {
                for bytes in [0, 1, 2, 3] {
                    for block in [1, 64] {
                        if n > 4096 && (block == 1 || bytes == 1 || bytes == 2)
                        {
                            continue;
                        }
                        let mut actual = input.clone();
                        sort::<_, u128>(
                            &mut actual,
                            Config { mode, bytes, coarse_bits: 0, block },
                        );
                        assert!(
                            actual
                                .iter()
                                .zip(&expected)
                                .all(|(a, b)| a.key == b.key
                                    && a.id == b.id
                                    && a.payload == b.payload),
                            "n={} distribution={} mode={:?} bytes={} block={}",
                            n,
                            distribution,
                            mode,
                            bytes,
                            block
                        );
                    }
                }
            }
            for experiment in [
                PaExperiment::Reference,
                PaExperiment::Terminal,
                PaExperiment::Ordered,
                PaExperiment::Lean,
                PaExperiment::Skew,
                PaExperiment::Both,
                PaExperiment::SkewThreeWay,
                PaExperiment::BothThreeWay,
                PaExperiment::CoreThreeWay,
                PaExperiment::ProbeThreeWay,
                PaExperiment::PrefixBand,
                PaExperiment::PrefixBandChild,
                PaExperiment::TerminalStableLeaf,
                PaExperiment::PrefixBandStableLeaf,
                PaExperiment::PrefixBandNested,
                PaExperiment::OrderedTiled,
                PaExperiment::TerminalLocal,
                PaExperiment::PrefixBandLocal,
                PaExperiment::Unified,
                PaExperiment::PrefixBandCached,
                PaExperiment::UnifiedCached,
                PaExperiment::UnifiedReuse,
                PaExperiment::UnifiedPrepared,
                PaExperiment::UnifiedBinary,
                PaExperiment::UnifiedBatch,
                PaExperiment::UnifiedSampled,
                PaExperiment::UnifiedReduced,
                PaExperiment::UnifiedCandidate,
            ] {
                let mut actual = input.clone();
                sort_pa_experiment::<_, u128>(&mut actual, experiment, 64);
                assert!(
                    actual.iter().zip(&expected).all(|(a, b)| a.key == b.key
                        && a.id == b.id
                        && a.payload == b.payload),
                    "Pa experiment {:?} n={} distribution={}",
                    experiment,
                    n,
                    distribution
                );
            }
        }
    }
}

#[test]
fn signed_float_converted_order() {
    let mut state = 0x123456789abcdef;
    let signed: Vec<i64> =
        (0..4097).map(|_| random(&mut state) as i64).collect();
    let mut floats: Vec<f64> =
        (0..4097).map(|_| f64::from_bits(random(&mut state))).collect();
    floats.extend([0., -0., f64::NAN, f64::INFINITY, f64::NEG_INFINITY]);
    for mode in [Mode::L, Mode::H, Mode::P, Mode::F] {
        let config = Config { mode, bytes: 1, coarse_bits: 0, block: 1 };
        let mut actual = signed.clone();
        let mut expected = signed.clone();
        expected.sort();
        sort::<_, i64>(&mut actual, config);
        assert_eq!(actual, expected);
        let mut actual = floats.clone();
        let mut expected = floats.clone();
        expected.sort_by_key(|x| <f64 as RadixKey>::into_keytype(x));
        sort::<_, f64>(&mut actual, config);
        assert!(actual
            .iter()
            .zip(expected)
            .all(|(a, b)| a.to_bits() == b.to_bits()));
    }
}

#[test]
fn pa_new_policies_preserve_converted_float_order() {
    let mut state = 42;
    let mut input: Vec<f64> =
        (0..4097).map(|_| f64::from_bits(random(&mut state))).collect();
    input.extend([
        0.,
        -0.,
        f64::NAN,
        f64::from_bits(0xfff8000000000017),
        f64::INFINITY,
        f64::NEG_INFINITY,
    ]);
    let mut expected = input.clone();
    expected.sort_by_key(|x| <f64 as RadixKey>::into_keytype(x));
    let mut reversed = expected.clone();
    reversed.reverse();
    for experiment in [
        PaExperiment::TerminalStableLeaf,
        PaExperiment::PrefixBandStableLeaf,
        PaExperiment::PrefixBandNested,
        PaExperiment::OrderedTiled,
        PaExperiment::TerminalLocal,
        PaExperiment::PrefixBandLocal,
        PaExperiment::Unified,
        PaExperiment::PrefixBandCached,
        PaExperiment::UnifiedCached,
        PaExperiment::UnifiedReuse,
        PaExperiment::UnifiedPrepared,
        PaExperiment::UnifiedBinary,
        PaExperiment::UnifiedBatch,
        PaExperiment::UnifiedSampled,
        PaExperiment::UnifiedReduced,
        PaExperiment::UnifiedCandidate,
    ] {
        for source in [&input, &expected, &reversed] {
            let mut actual = source.to_vec();
            sort_pa_experiment::<_, f64>(&mut actual, experiment, 17);
            assert!(
                actual
                    .iter()
                    .zip(&expected)
                    .all(|(a, b)| a.to_bits() == b.to_bits()),
                "{:?}",
                experiment
            );
        }
    }
}

#[test]
fn same_coarse_prefix_configs() {
    let mut state = 42;
    let input: Vec<Item> = (0..10001)
        .map(|id| Item { key: random(&mut state) as u128, id, payload: [0; 3] })
        .collect();
    let mut expected = input.clone();
    expected.sort_by_key(|x| x.key);
    for coarse_bits in [8, 16, 24, 64, 128] {
        let mut actual = input.clone();
        sort::<_, u128>(
            &mut actual,
            Config { mode: Mode::F, bytes: 0, coarse_bits, block: 1 },
        );
        assert!(actual
            .iter()
            .zip(&expected)
            .all(|(a, b)| a.key == b.key && a.id == b.id));
    }
}

#[test]
fn native_small_integer_widths() {
    let mut state = 0x123456789abcdef;
    let values: Vec<u64> = (0..4097).map(|_| random(&mut state)).collect();
    for mode in [Mode::L, Mode::H, Mode::P, Mode::F] {
        for bytes in [0, 1, 2, 16] {
            let config = Config { mode, bytes, coarse_bits: 0, block: 1 };
            macro_rules! check {
                ($t:ty) => {{
                    let mut actual: Vec<$t> =
                        values.iter().map(|&x| x as $t).collect();
                    let mut expected = actual.clone();
                    expected.sort();
                    sort::<_, $t>(&mut actual, config);
                    assert_eq!(actual, expected);
                }};
            }
            check!(u8);
            check!(u16);
            check!(u32);
            check!(i8);
            check!(i16);
            check!(i32);
        }
    }
    for experiment in [
        PaExperiment::Reference,
        PaExperiment::Terminal,
        PaExperiment::Ordered,
        PaExperiment::Lean,
        PaExperiment::Skew,
        PaExperiment::Both,
        PaExperiment::SkewThreeWay,
        PaExperiment::BothThreeWay,
        PaExperiment::CoreThreeWay,
        PaExperiment::ProbeThreeWay,
        PaExperiment::PrefixBand,
        PaExperiment::PrefixBandChild,
        PaExperiment::TerminalStableLeaf,
        PaExperiment::PrefixBandStableLeaf,
        PaExperiment::PrefixBandNested,
        PaExperiment::OrderedTiled,
        PaExperiment::TerminalLocal,
        PaExperiment::PrefixBandLocal,
        PaExperiment::Unified,
        PaExperiment::PrefixBandCached,
        PaExperiment::UnifiedCached,
        PaExperiment::UnifiedReuse,
        PaExperiment::UnifiedPrepared,
        PaExperiment::UnifiedBinary,
        PaExperiment::UnifiedBatch,
        PaExperiment::UnifiedSampled,
        PaExperiment::UnifiedReduced,
        PaExperiment::UnifiedCandidate,
    ] {
        macro_rules! check_pa {
            ($t:ty) => {{
                let mut actual: Vec<$t> =
                    values.iter().map(|&x| x as $t).collect();
                let mut expected = actual.clone();
                expected.sort();
                sort_pa_experiment::<_, $t>(&mut actual, experiment, 1);
                assert_eq!(actual, expected);
            }};
        }
        check_pa!(u8);
        check_pa!(u16);
        check_pa!(u32);
        check_pa!(u64);
        check_pa!(i8);
        check_pa!(i16);
        check_pa!(i32);
        check_pa!(i64);
    }
}

#[test]
fn block_tail_sizes_and_large_workspace() {
    let mut state = 42;
    for (n, block) in [(4097, 3), (10001, 17), (262145, 512)] {
        let input: Vec<Item> = (0..n)
            .map(|id| Item {
                key: ((random(&mut state) as u128) << 64)
                    | random(&mut state) as u128,
                id,
                payload: [id as u64; 3],
            })
            .collect();
        let mut expected = input.clone();
        expected.sort_by_key(|x| x.key);
        for mode in [Mode::L, Mode::P, Mode::F] {
            let mut actual = input.clone();
            sort::<_, u128>(
                &mut actual,
                Config { mode, bytes: 1, coarse_bits: 0, block },
            );
            assert!(actual.iter().zip(&expected).all(|(a, b)| a.key == b.key
                && a.id == b.id
                && a.payload == b.payload));
        }
        for experiment in [
            PaExperiment::Reference,
            PaExperiment::Terminal,
            PaExperiment::Ordered,
            PaExperiment::Lean,
            PaExperiment::Skew,
            PaExperiment::Both,
            PaExperiment::SkewThreeWay,
            PaExperiment::BothThreeWay,
            PaExperiment::CoreThreeWay,
            PaExperiment::ProbeThreeWay,
            PaExperiment::PrefixBand,
            PaExperiment::PrefixBandChild,
            PaExperiment::TerminalStableLeaf,
            PaExperiment::PrefixBandStableLeaf,
            PaExperiment::PrefixBandNested,
            PaExperiment::OrderedTiled,
            PaExperiment::TerminalLocal,
            PaExperiment::PrefixBandLocal,
            PaExperiment::Unified,
            PaExperiment::PrefixBandCached,
            PaExperiment::UnifiedCached,
            PaExperiment::UnifiedReuse,
            PaExperiment::UnifiedPrepared,
            PaExperiment::UnifiedBinary,
            PaExperiment::UnifiedBatch,
            PaExperiment::UnifiedSampled,
            PaExperiment::UnifiedReduced,
            PaExperiment::UnifiedCandidate,
        ] {
            let mut actual = input.clone();
            sort_pa_experiment::<_, u128>(&mut actual, experiment, block);
            assert!(actual.iter().zip(&expected).all(|(a, b)| a.key == b.key
                && a.id == b.id
                && a.payload == b.payload));
        }
    }
}

#[test]
#[cfg(feature = "frontier_work")]
fn pa_skew_gate_uses_a_heavy_child() {
    let mut state = 42;
    for heavy in [false, true] {
        let input: Vec<Item> = (0..32769)
            .map(|id| Item {
                key: if heavy && id % 10 != 0 {
                    0
                } else {
                    if heavy {
                        1u128 << (id % 128)
                    } else {
                        (random(&mut state) as u128) << 64
                            | random(&mut state) as u128
                    }
                },
                id,
                payload: [id as u64; 3],
            })
            .collect();
        let mut reference = input.clone();
        let mut actual = input.clone();
        let before = sort::<_, u128>(
            &mut reference,
            Config { mode: Mode::P, bytes: 0, coarse_bits: 0, block: 64 },
        );
        let after =
            sort_pa_experiment::<_, u128>(&mut actual, PaExperiment::Skew, 64);
        assert!(actual.iter().zip(&reference).all(|(a, b)| a.key == b.key
            && a.id == b.id
            && a.payload == b.payload));
        if heavy {
            assert!(after.candidate_records > 0);
            assert!(after.scatter_records < before.scatter_records);
        } else {
            assert_eq!(after.candidate_records, 0);
        }
        let mut probed = input.clone();
        let probe = sort_pa_experiment::<_, u128>(
            &mut probed,
            PaExperiment::ProbeThreeWay,
            64,
        );
        assert!(probed.iter().zip(&reference).all(|(a, b)| a.key == b.key
            && a.id == b.id
            && a.payload == b.payload));
        if heavy {
            assert!(probe.equal_nodes > 0);
            assert!(probe.scatter_records < after.scatter_records);
        } else {
            assert_eq!(probe.candidate_records, 0);
        }
    }
}

#[test]
#[cfg(feature = "frontier_work")]
fn pa_root_probe_is_only_a_cost_signal() {
    let mut state = 73;
    let mut input: Vec<u32> =
        (0..32769).map(|_| random(&mut state) as u32).collect();
    // Misleading samples pay candidate preparation but cannot certify a majority.
    for i in 0..64 {
        input[i * (32769 - 1) / 63] = if i == 20 { 1 } else { 0 };
    }
    let original = input.clone();
    let mut expected = input.clone();
    expected.sort();
    let work = sort_pa_experiment::<_, u32>(
        &mut input,
        PaExperiment::ProbeThreeWay,
        64,
    );
    assert_eq!(input, expected);
    assert!(work.candidate_records >= 32769);
    assert_eq!(work.equal_nodes, 0);
    let mut input = original;
    let work =
        sort_pa_experiment::<_, u32>(&mut input, PaExperiment::PrefixBand, 64);
    assert_eq!(input, expected);
    assert!(work.candidate_records >= 32769);
    assert_eq!(work.band_nodes, 0);
}

#[test]
#[cfg(feature = "frontier_work")]
fn pa_prefix_band_handles_distinct_keys() {
    let mut input: Vec<Item> = (0..32769)
        .map(|id| Item {
            key: id as u128
                | if id % 10 == 0 { 1u128 << (32 + id % 96) } else { 0 },
            id,
            payload: [id as u64; 3],
        })
        .collect();
    let mut state = 42;
    for i in (1..input.len()).rev() {
        let j = random(&mut state) as usize % (i + 1);
        input.swap(i, j);
    }
    let mut expected = input.clone();
    expected.sort_by_key(|x| x.key);
    assert!(expected.windows(2).all(|w| w[0].key != w[1].key));
    let mut reference = input.clone();
    let before = sort::<_, u128>(
        &mut reference,
        Config { mode: Mode::P, bytes: 0, coarse_bits: 0, block: 64 },
    );
    let mut actual = input;
    let after = sort_pa_experiment::<_, u128>(
        &mut actual,
        PaExperiment::PrefixBand,
        64,
    );
    assert!(actual.iter().zip(&expected).all(|(a, b)| a.key == b.key
        && a.id == b.id
        && a.payload == b.payload));
    assert!(after.band_nodes > 0);
    assert_eq!(after.equal_nodes, 0);
    assert!(after.scatter_records < before.scatter_records);
    // The classifier must skip prefix work; compact is an independent cost,
    // not a monotone consequence of fewer radix writes.
    eprintln!(
        "distinct fixture: scatter {} -> {}, compact {} -> {}",
        before.scatter_records,
        after.scatter_records,
        before.compact_records,
        after.compact_records
    );
}

#[test]
#[cfg(feature = "frontier_work")]
fn nested_band_can_choose_a_less_supported_terminal_majority() {
    let n = 32769;
    let mut input: Vec<Item> = (0..n)
        .map(|id| Item {
            key: id as u128
                | if id % 5 < 3 { 0 } else { 1u128 << (32 + id % 96) },
            id,
            payload: [id as u64; 3],
        })
        .collect();
    let mut state = 42;
    for i in (1..input.len()).rev() {
        let j = random(&mut state) as usize % (i + 1);
        input.swap(i, j);
    }
    // Fix the probe geometry: 38/64 near the median, eight wider points,
    // then exits outside the sampled interval. Exact membership still has a
    // majority, even though the narrower interval misses the 40/64 signal.
    for i in 0..64 {
        let index = i * ((n - 1) / 63) + i * ((n - 1) % 63) / 63;
        let key = input[index].id as u128;
        input[index].key = key
            | match i {
                0..=37 => 0,
                38..=45 => 1u128 << 96,
                _ => 1u128 << 127,
            };
    }
    let mut expected = input.clone();
    expected.sort_by_key(|x| x.key);
    assert!(expected.windows(2).all(|w| w[0].key != w[1].key));
    let after = sort_pa_experiment::<_, u128>(
        &mut input,
        PaExperiment::PrefixBandNested,
        64,
    );
    assert!(input.iter().zip(&expected).all(|(a, b)| a.key == b.key
        && a.id == b.id
        && a.payload == b.payload));
    assert!(after.terminal_band_nodes > 0);
}

#[test]
#[cfg(feature = "frontier_work")]
fn nested_band_rejection_keeps_the_original_interval() {
    let n = 513;
    let mut input: Vec<Item> = (0..n)
        .map(|id| Item {
            key: ((id as u32).wrapping_mul(0x9e3779b9) as u128)
                | if id % 5 == 0 { 1u128 << 127 } else { 0 },
            id,
            payload: [id as u64; 3],
        })
        .collect();
    let mut state = 42;
    for i in (1..n).rev() {
        let j = random(&mut state) as usize % (i + 1);
        input.swap(i, j);
    }
    for i in 0..64 {
        let index = i * ((n - 1) / 63) + i * ((n - 1) % 63) / 63;
        input[index].key = (input[index].id as u32).wrapping_mul(0x9e3779b9)
            as u128
            | if i < 50 { 0 } else { 1u128 << 127 };
    }
    let mut expected = input.clone();
    expected.sort_by_key(|x| x.key);
    let work = sort_pa_experiment::<_, u128>(
        &mut input,
        PaExperiment::PrefixBandNested,
        64,
    );
    assert!(input.iter().zip(&expected).all(|(a, b)| a.key == b.key
        && a.id == b.id
        && a.payload == b.payload));
    assert!(work.band_nodes > 0);
    assert_eq!(work.terminal_band_nodes, 0);
}
