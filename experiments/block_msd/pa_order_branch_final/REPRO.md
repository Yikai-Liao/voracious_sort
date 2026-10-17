# Reproduction

Use source-commit.txt and source-sha256.txt for the 156 compilation inputs.
binary-sha256.txt identifies the immutable complete native Time/Work ELFs under
target/pa-order-branch. Never overwrite copied executables or measurement files.
run.py refuses to replace an existing output name. Original build commands and
flags are in validation/build-work.log and the source screen's build-time.log;
env/ records toolchains and guest hardware. Time has no optional feature.

The fixed order is native Work build, fresh optimized33 frontier tests, logical
resources, timing barrier, ablation.sh, final.sh, mechanisms.sh, independent
source pairs, heldout.sh last. Resource rows may overlap test compilation and
have no wall/CPU speed claim. All formal timing waits for build/test completion.

For a fresh output directory, retain the exact scripts, inputs and flags:

- resources.sh; review_resources.py; compare_resources.py
- ablation.sh; review_ablation.py
- final.sh; review_matrix.py; audit_summaries.py
- mechanisms.sh; review_mechanisms.py
- paired_sources.py outline, equality, wide_order; review_pairs.py
- heldout.sh; review_matrix.py; audit_summaries.py
- validate.py for standard source/ELF, completion, address and rotation checks

Each run has raw CSV, exact argv, return code, resource snapshots and timestamps.
Every sort executes its full stable key/ID/payload oracle; oracle failure aborts
the child. Source pairs keep their own commands and reviews under pairs/.
Prior-source ASan evidence stays in pa_outline_final/; this safe-only final
diff does not present it as a new sanitizer campaign. See DESIGN.md.
