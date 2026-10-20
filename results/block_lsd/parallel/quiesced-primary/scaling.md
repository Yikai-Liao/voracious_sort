| Layout | n | Load | Algorithm | Threads | Median ms | T1/Tp | Efficiency |
|---|---:|---|---|---:|---:|---:|---:|
| u128_pair32 | 4,194,304 | uniform | rayon_block | 1 | 337.625 | 1.00 | 100.0% |
| u128_pair32 | 4,194,304 | uniform | rayon_block | 2 | 215.196 | 1.57 | 78.4% |
| u128_pair32 | 4,194,304 | uniform | rayon_block | 4 | 175.159 | 1.93 | 48.2% |
| u128_pair32 | 4,194,304 | uniform | rayon_block | 8 | 170.365 | 1.98 | 24.8% |
| u128_pair32 | 4,194,304 | uniform | rayon_block | 16 | 195.751 | 1.72 | 10.8% |
| u32_pair8 | 4,194,304 | uniform | c_parallel | 1 | 23.680 | 1.00 | 100.0% |
| u32_pair8 | 4,194,304 | uniform | c_parallel | 2 | 23.405 | 1.01 | 50.6% |
| u32_pair8 | 4,194,304 | uniform | c_parallel | 4 | 16.533 | 1.43 | 35.8% |
| u32_pair8 | 4,194,304 | uniform | c_parallel | 8 | 14.790 | 1.60 | 20.0% |
| u32_pair8 | 4,194,304 | uniform | c_parallel | 16 | 21.776 | 1.09 | 6.8% |
| u32_pair8 | 4,194,304 | uniform | rayon_block | 1 | 28.602 | 1.00 | 100.0% |
| u32_pair8 | 4,194,304 | uniform | rayon_block | 2 | 26.424 | 1.08 | 54.1% |
| u32_pair8 | 4,194,304 | uniform | rayon_block | 4 | 18.541 | 1.54 | 38.6% |
| u32_pair8 | 4,194,304 | uniform | rayon_block | 8 | 17.620 | 1.62 | 20.3% |
| u32_pair8 | 4,194,304 | uniform | rayon_block | 16 | 26.624 | 1.07 | 6.7% |
| u32_payload128 | 4,194,304 | uniform | rayon_block | 1 | 360.827 | 1.00 | 100.0% |
| u32_payload128 | 4,194,304 | uniform | rayon_block | 2 | 268.126 | 1.35 | 67.3% |
| u32_payload128 | 4,194,304 | uniform | rayon_block | 4 | 232.662 | 1.55 | 38.8% |
| u32_payload128 | 4,194,304 | uniform | rayon_block | 8 | 246.178 | 1.47 | 18.3% |
| u32_payload128 | 4,194,304 | uniform | rayon_block | 16 | 268.920 | 1.34 | 8.4% |
| u64_pair16 | 4,194,304 | uniform | rayon_block | 1 | 89.071 | 1.00 | 100.0% |
| u64_pair16 | 4,194,304 | uniform | rayon_block | 2 | 57.589 | 1.55 | 77.3% |
| u64_pair16 | 4,194,304 | uniform | rayon_block | 4 | 53.099 | 1.68 | 41.9% |
| u64_pair16 | 4,194,304 | uniform | rayon_block | 8 | 47.595 | 1.87 | 23.4% |
| u64_pair16 | 4,194,304 | uniform | rayon_block | 16 | 60.612 | 1.47 | 9.2% |

16 threads use SMT on this 8-core machine; thread efficiency divides by 16.
