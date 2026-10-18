const FINITE_CASES: &[&str] = &[
    "uniform",
    "normal12",
    "log_scale",
    "few_unique",
    "skew90",
    "sparse8",
    "sparse16",
    "signed_sparse8",
    "subnormal",
    "sorted",
    "reverse",
];
const SPECIAL_CASES: &[&str] = &["special_mix", "all_bits"];
const FLOAT_LAYOUTS: &[&str] = &["f32", "f64", "f32_id16", "f64_id32"];

macro_rules! verified_float {
    ($float:ty) => {
        impl Verified for $float {
            fn same(&self, other: &Self) -> bool {
                self.to_bits() == other.to_bits()
            }
            fn identity_order(&self) -> u128 {
                self.to_bits() as u128
            }
            fn key_order(&self) -> u128 {
                <$float as RadixKey>::into_keytype(self) as u128
            }
        }
    };
}
verified_float!(f32);
verified_float!(f64);

macro_rules! float_record {
    ($name:ident, $float:ty, $id:ty, $payload:ty) => {
        #[repr(C)]
        #[derive(Clone, Copy, Debug)]
        struct $name {
            key: $float,
            serial: $id,
            payload: $payload,
        }
        impl PartialEq for $name {
            fn eq(&self, other: &Self) -> bool {
                self.key == other.key
            }
        }
        impl PartialOrd for $name {
            fn partial_cmp(&self, other: &Self) -> Option<Cmp> {
                self.key.partial_cmp(&other.key)
            }
        }
        impl Radixable<$float> for $name {
            type Key = $float;
            fn key(&self) -> $float {
                self.key
            }
        }
        impl Verified for $name {
            fn same(&self, other: &Self) -> bool {
                self.key.to_bits() == other.key.to_bits()
                    && self.serial == other.serial
                    && self.payload == other.payload
            }
            fn identity_order(&self) -> u128 {
                self.serial as u128
            }
            fn key_order(&self) -> u128 {
                <$float as RadixKey>::into_keytype(&self.key) as u128
            }
        }
    };
}
float_record!(Float32Record, f32, u32, u64);
float_record!(Float64Record, f64, u64, [u64; 2]);

#[derive(Clone, Copy)]
struct FloatFormat {
    width: usize,
    mantissa: usize,
    exponent: usize,
    bias: u64,
}
const FORMAT32: FloatFormat =
    FloatFormat { width: 32, mantissa: 23, exponent: 8, bias: 127 };
const FORMAT64: FloatFormat =
    FloatFormat { width: 64, mantissa: 52, exponent: 11, bias: 1023 };

impl FloatFormat {
    fn bits(self, value: f64) -> u64 {
        if self.width == 32 {
            (value as f32).to_bits() as u64
        } else {
            value.to_bits()
        }
    }
    fn key(self, bits: u64) -> u64 {
        if self.width == 32 {
            f32::from_bits(bits as u32).into_key_type() as u64
        } else {
            f64::from_bits(bits).into_key_type()
        }
    }
    fn special(self) -> [u64; 16] {
        let sign = 1u64 << (self.width - 1);
        let exp = ((1u64 << self.exponent) - 1) << self.mantissa;
        let quiet = 1u64 << (self.mantissa - 1);
        let one = self.bias << self.mantissa;
        [
            0,
            sign,
            exp,
            sign | exp,
            exp | quiet | 1,
            sign | exp | quiet | 1,
            exp | 1,
            sign | exp | 1,
            1,
            sign | 1,
            exp - 1,
            sign | (exp - 1),
            one,
            sign | one,
            exp | quiet | 17,
            sign | exp | quiet | 17,
        ]
    }
}

fn unit_float(state: &mut u64) -> f64 {
    // Input preparation only. Half-bin offset avoids an exact zero input.
    ((random(state) >> 11) as f64 + 0.5) * (1.0 / 9007199254740992.0)
}

fn float_input(
    format: FloatFormat,
    case: &str,
    n: usize,
    seed: u64,
) -> Vec<u64> {
    let mut state = seed;
    let fraction = (1u64 << format.mantissa) - 1;
    let sign = 1u64 << (format.width - 1);
    let mut bits: Vec<u64> = (0..n)
        .map(|_| {
            match case {
                "log_scale" => {
                    let raw = random(&mut state);
                    let exponent =
                        1 + random(&mut state) % ((1 << format.exponent) - 2);
                    (raw & (sign | fraction)) | (exponent << format.mantissa)
                },
                "subnormal" => {
                    let raw = random(&mut state);
                    (raw & sign) | (raw & fraction).max(1)
                },
                "sparse8" | "sparse16" | "signed_sparse8" => {
                    let q = if case == "sparse16" { 16 } else { 8 };
                    let raw = random(&mut state);
                    let mut bits = format.bias << format.mantissa;
                    for bit in 0..q {
                        bits |= ((raw >> bit) & 1)
                            << (bit * (format.mantissa - 1) / (q - 1));
                    }
                    if case == "signed_sparse8" {
                        bits |= ((raw >> q) & 1) * sign;
                    }
                    bits
                },
                "special_mix" => {
                    format.special()[(random(&mut state) % 16) as usize]
                },
                "all_bits" => {
                    let raw = random(&mut state);
                    if format.width == 32 {
                        raw as u32 as u64
                    } else {
                        raw
                    }
                },
                _ => {
                    let value = match case {
                        "uniform" | "sorted" | "reverse" => {
                            (unit_float(&mut state) - 0.5) * 2_000_000.0
                        },
                        "normal12" => {
                            ((0..12)
                                .map(|_| unit_float(&mut state))
                                .sum::<f64>()
                                - 6.0)
                                * 1000.0
                        },
                        "few_unique" => (random(&mut state) % 16) as f64 - 8.0,
                        "skew90" => {
                            if random(&mut state) % 10 != 0 {
                                1.0
                            } else {
                                (unit_float(&mut state) - 0.5) * 2_000_000.0
                            }
                        },
                        _ => panic!("unknown float input: {}", case),
                    };
                    // The finite comparator cohort excludes signed-zero ambiguity.
                    format.bits(if value == 0.0 { 0.25 } else { value })
                },
            }
        })
        .collect();
    if matches!(case, "sorted" | "reverse") {
        bits.sort_unstable_by_key(|bits| format.key(*bits));
        if case == "reverse" {
            bits.reverse();
        }
    }
    bits
}

pub fn floats_main() {
    let args: Vec<String> = std::env::args().collect();
    let n = args.get(1).map_or(1_048_576, |s| s.parse().unwrap());
    let reps = args.get(2).map_or(14, |s| s.parse().unwrap());
    assert!(n <= u32::MAX as usize, "record identities must fit u32");
    let methods: Vec<_> = args.get(3).map_or(
        "Pa_kernel,Pa_unified_groups_t16777216,Rollercoaster,L_frozen,stable_msd,Pa_unified_groups_t16777216,Pa_kernel",
        String::as_str).split(',').collect();
    let cases: Vec<_> =
        args.get(4).map_or("uniform", String::as_str).split(',').collect();
    let layouts: Vec<_> = args
        .get(5)
        .map_or("f32,f64,f32_id16,f64_id32", String::as_str)
        .split(',')
        .collect();
    let kind = args.get(6).map_or("time", String::as_str);
    let block = args.get(7).map_or(64, |s| s.parse().unwrap());
    let seed = args.get(8).map_or(42, |s| s.parse().unwrap());
    assert!(methods.iter().all(|m| [
        "Pa_kernel",
        "Pa_odd_blocks",
        "Pa_packed",
        "Pa_unified_groups_t16777216",
        "Rollercoaster",
        "L_frozen",
        "stable_msd"
    ]
    .contains(m)));
    assert!(cases
        .iter()
        .all(|c| FINITE_CASES.contains(c) || SPECIAL_CASES.contains(c)));
    assert!(layouts.iter().all(|layout| FLOAT_LAYOUTS.contains(layout)));
    assert!(["time", "memory", "work"].contains(&kind));
    assert_eq!(kind == "work", cfg!(feature = "frontier_work"));
    if cases.iter().any(|case| SPECIAL_CASES.contains(case)) {
        assert!(methods.iter().all(|m| ["Pa_kernel", "Pa_odd_blocks", "Pa_packed", "Pa_unified_groups_t16777216", "L_frozen"].contains(m)),
                "NaN/zero total-key cases exclude comparators with partial-order leaves");
    }
    // Schema matches the inherited run() exactly; float-run.py checks it
    // against the frozen parent harness before each invocation.
    println!("layout,case,n,record_bytes,seed,block,method,slot,rep,kind,wall_ns,cpu_ns,heap_peak,allocs,projection_nodes,projection_records,identity_nodes,nodes,node_records,prepare_records,order_records,candidate_records,label_evals,scatter_records,dense_nodes,block_nodes,passes,compact_records,tail_records,runs_records,unresolved_records,leaves,leaf_records,max_depth,max_path_passes,frontier_nodes,equal_nodes,band_nodes,band_records,terminal_band_nodes,probe_records,instrumented,input_address,leaf_lengths");
    for layout in layouts {
        for case in &cases {
            let format =
                if layout.starts_with("f32") { FORMAT32 } else { FORMAT64 };
            let bits = float_input(format, case, n, seed);
            match layout {
                "f32" => run::<_, f32>(
                    bits.iter()
                        .map(|bits| f32::from_bits(*bits as u32))
                        .collect(),
                    layout,
                    case,
                    &methods,
                    reps,
                    block,
                    seed,
                    kind,
                ),
                "f64" => run::<_, f64>(
                    bits.iter().map(|bits| f64::from_bits(*bits)).collect(),
                    layout,
                    case,
                    &methods,
                    reps,
                    block,
                    seed,
                    kind,
                ),
                "f32_id16" => run::<_, f32>(
                    bits.iter()
                        .enumerate()
                        .map(|(id, bits)| Float32Record {
                            key: f32::from_bits(*bits as u32),
                            serial: id as u32,
                            payload: !(id as u64).wrapping_mul(73),
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
                "f64_id32" => run::<_, f64>(
                    bits.iter()
                        .enumerate()
                        .map(|(id, bits)| Float64Record {
                            key: f64::from_bits(*bits),
                            serial: id as u64,
                            payload: [
                                !(id as u64),
                                (id as u64).wrapping_mul(73),
                            ],
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

#[cfg(test)]
mod float_tests {
    use super::*;

    #[test]
    fn finite_cohort_has_matching_numeric_and_converted_key_order() {
        assert_eq!(std::mem::size_of::<Float32Record>(), 16);
        assert_eq!(std::mem::size_of::<Float64Record>(), 32);
        for format in [FORMAT32, FORMAT64] {
            for case in FINITE_CASES {
                let bits = float_input(format, case, 4097, 42);
                let number = |bits: u64| {
                    if format.width == 32 {
                        f32::from_bits(bits as u32) as f64
                    } else {
                        f64::from_bits(bits)
                    }
                };
                assert!(
                    bits.iter().all(|bits| number(*bits).is_finite()
                        && number(*bits) != 0.0),
                    "{}",
                    case
                );
                for pair in bits.windows(2) {
                    assert_eq!(
                        format.key(pair[0]).cmp(&format.key(pair[1])),
                        number(pair[0]).partial_cmp(&number(pair[1])).unwrap(),
                        "{}",
                        case
                    );
                }
            }
        }
    }

    #[test]
    fn special_records_keep_nan_bits_identity_payload_and_stability() {
        for block in [3, 64, 512] {
            for case in SPECIAL_CASES {
                let input: Vec<_> = float_input(FORMAT32, case, 8193, 42)
                    .into_iter()
                    .enumerate()
                    .map(|(id, bits)| Float32Record {
                        key: f32::from_bits(bits as u32),
                        serial: id as u32,
                        payload: !(id as u64),
                    })
                    .collect();
                let mut expected = input.clone();
                expected.sort_by_key(|record| record.into_key_type());
                let input64: Vec<_> = float_input(FORMAT64, case, 8193, 42)
                    .into_iter()
                    .enumerate()
                    .map(|(id, bits)| Float64Record {
                        key: f64::from_bits(bits),
                        serial: id as u64,
                        payload: [!(id as u64), id as u64],
                    })
                    .collect();
                let mut expected64 = input64.clone();
                expected64.sort_by_key(|record| record.into_key_type());
                for method in [
                    "Pa_unified_groups_t16777216",
                    "Pa_kernel",
                    "Pa_odd_blocks",
                    "L_frozen",
                ] {
                    let mut actual = input.clone();
                    execute::<_, f32>(&mut actual, method, block);
                    assert!(
                        output_matches(&actual, &expected, method),
                        "f32 {} {} B{}",
                        method,
                        case,
                        block
                    );
                    let mut actual64 = input64.clone();
                    execute::<_, f64>(&mut actual64, method, block);
                    assert!(
                        output_matches(&actual64, &expected64, method),
                        "f64 {} {} B{}",
                        method,
                        case,
                        block
                    );
                }
            }
        }
    }
}
