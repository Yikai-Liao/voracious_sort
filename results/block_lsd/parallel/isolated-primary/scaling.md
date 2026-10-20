| Layout | n | Load | Algorithm | Threads | Median ms | T1/Tp | Efficiency |
|---|---:|---|---|---:|---:|---:|---:|
| u128_pair32 | 4,194,304 | uniform | rayon_block | 1 | 425.151 | 1.00 | 100.0% |
| u128_pair32 | 4,194,304 | uniform | rayon_block | 2 | 353.304 | 1.20 | 60.2% |
| u128_pair32 | 4,194,304 | uniform | rayon_block | 4 | 298.555 | 1.42 | 35.6% |
| u128_pair32 | 4,194,304 | uniform | rayon_block | 8 | 291.936 | 1.46 | 18.2% |
| u128_pair32 | 4,194,304 | uniform | rayon_block | 16 | 315.603 | 1.35 | 8.4% |
| u32_pair8 | 4,194,304 | uniform | c_parallel | 1 | 35.551 | 1.00 | 100.0% |
| u32_pair8 | 4,194,304 | uniform | c_parallel | 2 | 52.384 | 0.68 | 33.9% |
| u32_pair8 | 4,194,304 | uniform | c_parallel | 4 | 39.609 | 0.90 | 22.4% |
| u32_pair8 | 4,194,304 | uniform | c_parallel | 8 | 46.999 | 0.76 | 9.5% |
| u32_pair8 | 4,194,304 | uniform | c_parallel | 16 | 61.490 | 0.58 | 3.6% |
| u32_pair8 | 4,194,304 | uniform | rayon_block | 1 | 38.989 | 1.00 | 100.0% |
| u32_pair8 | 4,194,304 | uniform | rayon_block | 2 | 43.019 | 0.91 | 45.3% |
| u32_pair8 | 4,194,304 | uniform | rayon_block | 4 | 38.262 | 1.02 | 25.5% |
| u32_pair8 | 4,194,304 | uniform | rayon_block | 8 | 49.128 | 0.79 | 9.9% |
| u32_pair8 | 4,194,304 | uniform | rayon_block | 16 | 82.884 | 0.47 | 2.9% |
| u32_payload128 | 4,194,304 | uniform | rayon_block | 1 | 464.414 | 1.00 | 100.0% |
| u32_payload128 | 4,194,304 | uniform | rayon_block | 2 | 376.408 | 1.23 | 61.7% |
| u32_payload128 | 4,194,304 | uniform | rayon_block | 4 | 343.959 | 1.35 | 33.8% |
| u32_payload128 | 4,194,304 | uniform | rayon_block | 8 | 354.531 | 1.31 | 16.4% |
| u32_payload128 | 4,194,304 | uniform | rayon_block | 16 | 366.717 | 1.27 | 7.9% |
| u64_pair16 | 4,194,304 | uniform | rayon_block | 1 | 104.923 | 1.00 | 100.0% |
| u64_pair16 | 4,194,304 | uniform | rayon_block | 2 | 100.805 | 1.04 | 52.0% |
| u64_pair16 | 4,194,304 | uniform | rayon_block | 4 | 105.855 | 0.99 | 24.8% |
| u64_pair16 | 4,194,304 | uniform | rayon_block | 8 | 113.369 | 0.93 | 11.6% |
| u64_pair16 | 4,194,304 | uniform | rayon_block | 16 | 147.651 | 0.71 | 4.4% |

16 threads use SMT on this 8-core machine; thread efficiency divides by 16.
