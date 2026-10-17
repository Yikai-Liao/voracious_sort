# Frozen full-layout code-generation evidence

Source 8bf14e0; full ten-layout native timing ELF target/pa-outline-final/time.
The SHA256 ledger is ../binary-sha256.txt. No new perf sampling was run in this
campaign. The pre-change sampled diagnosis remains under
../../pa_groups_final/profile/small8-uniform: 4209 of 6470 whole-process samples
fell in three per-record write closures. Those samples include restore/oracle
and are not percentages of the timed sorting phase.

The implementation change is an explicit inline(never) boundary on the original
scalar scatter. Its entire body and the grouped kernel are byte-for-byte equal
to 2513fa5. This shared scalar kernel serves all experimental Block policies;
it is not an optimization exclusive to the Group policy.

nm-demangled.txt retains full Rust type names. Small is the benchmark's small8
u32-key/u32-serial record; Small8 is instead u8_id8. The linker folds identical
Pa partition scalar functions into distribute_children names. symbols.json and
small-pa-step-caller.asm prove that the actual Pa step calls the selected folded
functions. The three byte functions are [1583, 1603, 1603] bytes, and have no per-record
write-closure calls; their remaining calls are on bounds/panic paths. The Pa
step is 2840 bytes at 0x000000000014fed0.

The earlier pa_direct same-ELF ablation also improved its unchanged original
loop. The copied macro loop had no consistent additional gain, so it and its
policy/runtime flag were removed. The simpler outline reproduces the narrow
screen benefit and retains the original implementation. Independent frozen
old/new full-ELF pairing is planned after the seen guards pass; those results
remain separate from the same-ELF primary matrix.

No instruction-count or missing-call observation alone certifies speed. The
full matrix, paired CPU/wall comparisons, A/A distributions, stable oracles and
work/heap evidence determine acceptance.
