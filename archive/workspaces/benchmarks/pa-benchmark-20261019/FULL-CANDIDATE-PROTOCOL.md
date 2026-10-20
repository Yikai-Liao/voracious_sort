# Final pure radix candidate protocol

Keep PLAN.md, run_auto.py, saved references and previously frozen measurements unchanged. The final candidate is pa_radix: native-width interval translation plus exact constant-tail completion. No new comparison fallback or natural-run merging is included.

1. Build all nine types with the saved native opt3/codegen1/thin-LTO profile. Complete correctness checks before timing and freeze executable/source hashes.
2. Screen carry-crossing interval and constant-tail targets, then representative broad controls including small near-sorted inputs. Inspect every loss before expanding.
3. If expansion is supported, use run_auto.py’s original full schedule and assert exact equality to auto-baseline/manifest.json: 1045 cases. Run only pa_radix in two identical slots, three seeds and two observation orders. This gives 12 timings from six seed/order conditions per case; slots share the saved reference and are not extra independent input seeds.
4. The existing full stable key/identity/payload oracle runs outside every timed batch. Compare input digests, widths, block, radix, seed and order to saved PA. Retain process status, RSS, swap and VM logs. No compiler or correctness job overlaps timing.
5. Report all cells, all median losses above 5/10/20 percent, saved PA A/A, and current-candidate A/A. Historical ratios and A/A cannot establish a same-process causal no-regression guarantee. No overall average excuses a repeatable per-case loss. Do not rerun any older algorithm.
