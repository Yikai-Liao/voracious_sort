# Stable local-completion screen

This is a new source cohort after the repeated float failure archived at `255c22d`. It borrows Rollercoaster's exact-count bucket boundaries and MSD-to-local-LSD completion. Its swaps, reverse preprocessing and unstable comparison fallback are not copied.

Two independent methods inherit the complete `Pa_kernel` classifier policy and execution context:

- `Pa_local_prefix`: complete exactly the same classifier label using the new backend. Logical recursive intervals and small-leaf policy are unchanged.
- `Pa_local_key`: use the same backend, but an ordinary node without an approved band or packed classifier completes its entire remaining converted key. This tests the cost of avoiding the existing prepare/leaf recursion, including the possible cost of extra low-byte passes on wide keys.

The backend finishes a range with the existing stable dense LSD whenever its complete scratch/histogram requirement fits the existing `512 * B * sizeof(T)` budget. Otherwise it counts and stably splits the highest active byte with the existing recycling sorter, drops that workspace, and completes each exact histogram interval. It skips constant bytes detected by those counts. It adds at most one 256-entry count array per label byte (up to 16 levels); this bounded stack cost is reported separately from heap scratch. Neither the original PA 16 MiB execution gate nor hardware/packing admission is retuned.

First run correctness tests, including complete identity/payload, nonfinite bit patterns and guarded classifier contexts. Then freeze native and ordinary-ISA executables before timing. No compilation or instrumented Work may overlap timing. All timing uses CPU 2, restored inputs, complete-record oracles, rotating/reversed paired slots and same-method A/A.

Small-screen slots are `[local_prefix, original_PA, local_key, Pa_kernel, Rollercoaster, Block_LSD, Pa_kernel, local_key, original_PA, local_prefix]`, with ten repetitions, n1,048,576 and seed42. Screen finite floats first at B512 (uniform/sparse16 times all four layouts), then B64 for the same eight cells plus normal12/subnormal scalar f32/f64 at B64/B512. Integer screen uses uniform/sparse times u32/u64/u128/wide32/large128 at B64/B512, large128 deep_unique90 at both blocks, and u128/wide32 q64 at both blocks (the q64 boundary uses n262,144). Native and generic cohorts remain separate.

Confirm any original-PA material signal independently with reversed four-slot A/A and 16 repetitions. A failed method is rejected independently; no full-matrix acceptance is inferred from passing a small screen. Surviving methods need the original 103 integer cells, float matrix, ordinary-ISA screens and fresh holdouts before acceptance. Timing, Work, resource and source evidence stay separate. No tuning from a failed cell is accepted without a new independently identified candidate.
