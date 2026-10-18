# Extraction dependency boundary

User requirement: keep instruction selection, architecture-specific code and automatic fallback in a third-party library. The candidate now uses pinned `hakmem = 0.2.0`, without allocation features. Its `Isa::pext` supports the native integer widths including u128. `hakmem::dispatch!` chooses a token outside the classification loop, and `projection_portable` forwards to `hakmem/portable`.

Local code owns the exact variation mask, admission by expected record passes, compact label width and original-key recursion cap. A contiguous field uses ordinary shift/mask arithmetic. General mask extraction, including high/low u128 assembly, is delegated to the dependency. The prior local target_arch/target_feature checks, BMI2 intrinsic calls, unsafe extraction blocks and seven-stage software gather plan are removed.

Admission now uses the conservative representation-cost rule on every target: general gathers complete a multiword key; cheap contiguous fields may also qualify. It does not ask which CPU is running. This gives up some previously admitted scalar/partial native projections. That is a material strategy change requiring new end-to-end measurements; earlier native results cannot be relabeled as results for the library candidate.

Verified source coverage in the pinned release: runtime x86-64 instruction-set dispatch and portable implementations elsewhere. The release does not provide an ARM SVE2 BitPerm BEXT backend or a RISC-V multi-bit compression backend. Cross-compilation checks establish buildability, not real-machine speed. No local ARM/RISC-V intrinsic branch is added to fill that gap.

The user explicitly selected hakmem after the comparison with bitkit. For a future upstream contribution, its existing batch dispatch, u128 support and backend-law/codegen checks fit PA better; this is an engineering fit judgment, not a prediction about maintainer response or PR acceptance. Candidate topics are a genuinely measured ARM backend or an optional prepared-mask API for repeated gathers. Neither is part of this change.

Primary sources:

- [hakmem ISA API](https://docs.rs/hakmem/0.2.0/hakmem/isa/index.html)
- [hakmem repository](https://github.com/mightsleep/hakmem)
- [Arm SVE2 BitPerm operations](https://learn.arm.com/insights/sve/)
- [RISC-V ratified bit manipulation](https://docs.riscv.org/reference/isa/unpriv/b-st-ext.html)
- [RISC-V early bcompress draft](https://raw.githubusercontent.com/riscv/riscv-bitmanip/master/bitmanip-draft.pdf)

`bitkit 3.2.3` and `bitintr 0.3.0` were also inspected. The former has runtime detection but its public gather API only covers u32/u64 and its portable fallback loops over mask bits. The latter uses compile-time selection and excludes u128. A small generic-build probe checked the public extraction semantics for both candidate libraries; it is a screening probe only, not a whole-sort performance result.
