# Extraction dependency boundary

The user selected pinned `hakmem = 0.2.0`, without allocation features, then explicitly required PA to abandon software compression fallback entirely. The library still supplies its own portable primitives, but PA never selects them for a production compressed-label partition. No usable hardware token means the original PA classifier and distribution route. `projection_portable` disables hardware admission as well as forwarding to hakmem/portable; it tests this original-route behavior, not a software compression strategy.

The pinned API has no architecture-neutral hardware-PEXT capability query. One private compatibility module in packed_projection.rs asks the library for its safe X86V3 token on supported x86-64 builds; this token proves BMI2 plus the library level's other requirements. Every other build returns None, constructing no software token. The availability check and `Isa::run` occur outside classification loops. Kernel extraction is `cpu.pext`; CPU feature detection, target-feature trampolines, intrinsic safety and u128 assembly belong to the dependency. There are no local intrinsic calls, unsafe extraction blocks or software gather implementation.

The small local target guard refers to the library's current token availability and is the remaining architecture adapter. It is deliberately conservative: a CPU with BMI2 but without the full library level remains on ordinary PA. An upstream architecture-neutral capability/token API would let this adapter disappear. The pinned release has no ARM SVE2 BitPerm BEXT or RISC-V multi-bit compression backend, so these targets use ordinary PA today. Cross-compilation establishes buildability, not real-machine speed. A supported instruction set also does not prove that an instruction is fast on every microarchitecture.

Local code owns exact variation masks, admission by actual shifted-prefix byte passes, compact label width and original-key recursion caps. Partial compression retains exactly the ordinary prefix's partition and must remove a real pass. Complete tags must not add first-node record passes. When the ordinary prefix already covers the whole variation, an equal-pass tag is rejected: original byte-boundary crossing alone is not a savings.

The prior software-cost strategy is explicitly rejected: the 32-cell whole-sort backend experiment at 33377af found five software and one hardware material regression signals. See BACKENDS.md and library-backends.json. The hardware-only policy requires new frozen executables and measurements; old native/software results cannot be relabeled.

For future upstream contributions, hakmem's existing token dispatch, u128 support, backend laws and codegen checks fit PA better than bitkit's current public gather interface. This is an engineering judgment, not a prediction of maintainer response or PR acceptance. Potential topics are a general hardware capability token, a measured ARM backend, or an optional prepared-mask interface for repeated extraction. None is implemented upstream by this change.

Primary sources:

- [hakmem ISA API](https://docs.rs/hakmem/0.2.0/hakmem/isa/index.html)
- [hakmem design](https://github.com/mightsleep/hakmem/blob/main/docs/design.md)
- [Arm SVE2 BitPerm operations](https://learn.arm.com/insights/sve/)
- [RISC-V ratified bit manipulation](https://docs.riscv.org/reference/isa/unpriv/b-st-ext.html)

bitkit 3.2.3 and bitintr 0.3.0 were also inspected. The former has runtime detection but public gather only for u32/u64, with a mask-bit-loop portable path; the latter selects at compile time and excludes u128. Probe source and lockfile are retained in library-research; they are not whole-sort performance evidence.
