# Final build boundary

The narrow a088915 campaign is a screen, preserved unchanged under ../pa_groups. Final candidate behavior keeps that grouped algorithm and the fixed offline 16 MiB policy. The only library adjustment is an overflow-safe equivalent private byte guard; copied test comments are corrected.

Final release builds use native CPU, incremental=1, codegen-units=16, opt-level=3, no LTO and debug="line-tables-only" in the existing experiment Cargo.toml. This retains source locations for profiling while reducing the full type/local debug data in large monomorphized harnesses and copied executables. It is a build-setting change, not a sorting optimization. All final controls and full-layout ablations come from the same final ELF. Do not pool narrow-screen timings with final timings. Frozen earlier ELFs/ledgers remain unchanged.

The current optimized Cargo caches are retained. Disk reclamation removes only completed unreferenced debug test caches and obsolete release caches whose files all predate the line-tables-only profile change; each removal is recorded under validation. Frozen executables remain intact. All builds use jobs6. Final time and frontier_work runners are frozen separately; nightly ASan debug testing uses its own target directory with assertions/overflow checks and debug info disabled. Run no formal timing while build/test jobs are active.
