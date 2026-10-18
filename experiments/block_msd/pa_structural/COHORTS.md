# Evidence cohorts

Cohorts are not pooled across executable hashes. Historical names containing `final` describe the invocation at that time and do not imply acceptance. Every completed timed run has raw CSV, stderr and resource/build metadata; incomplete or overlapping fragments live only in validation/.

| Prefix or checkpoint | Scope and disposition |
|---|---|
| screen, a4ac2cc | Byte-only portable classifier and forced-local scheduling; rejected by scalar sparse regressions. |
| general, 3a8dbc2 | General projection screen, positive local checkpoint only. |
| narrow, 5c5cc90 | Ordinary classifier narrowing and small buckets; insufficient stable gains, removed. |
| final-, 78c7307 | First full 103 cells, aggressive information budget; rejected by reproducible large-record tiny-leaf regression. |
| bounded-screen-, 22671bf | 53-cell geometry-preserving screen; positive checkpoint, not a full final matrix. |
| keyset, pa-keyset-rejected-20261018 | 27-cell independent key-set majority generalization; rejected and removed. |
| portable-final- | Old local software gather; rejected by scalar and partial-label regressions. |
| accepted- | Only an early 20-cell native guard batch before software-policy changes; incomplete acceptance. |
| software-validated- | Pre-library software policy; 46 cells, two unresolved signals. Superseded, not accepted. |
| library-backends, 44e2cc1 | Whole-sort old PA/software/hardware ABBA at 33377af; five software and one hardware signals. Rejected. |
| hwonly-screen-, 4f53e58 | Hardware-only 16 guard cells; u32 sparse regression. Rejected. Overlapping information/confirmation fragments excluded. |
| hw-simple-u32-, 31ff0d2 | Two isolated repeated controls show removing the field branch fixes u32 sparse regression. Local checkpoint. |
| single-final-, 08e5691 | 5f6d211 native original 103 cells completed without a material original-PA regression; ordinary-target sparse failure independently confirmed. Rejected overall. |
| execution-*-first/control, e39428b | d2669f1 kernel context passes four u32 cells per target and ABBA checkpoint control; direct library grouping regresses uniform and is removed. Local screen only. |
| kernel-generic-/kernel-final- and extensions | 9bba819 ordinary-target 46-cell validation and independent q64 confirmation; rejected by a reproducible 1.55x slowdown. Native extensions stopped. See VALIDATION_KERNEL_FINAL.md. |
| inline-smoke/confirm/generic/nested-control | 6fceaaa generic 46+7 cells, independent q64 repeats and two-cell executable ABBA; original-PA material gate passed locally, with a small repeated loss. |
| inline-final/native-screen/heldout/frozen/memory2/work | Same 6fceaaa source: native 103+46+30 cells, independent boundary repeats, frozen-original ABBA, 16 memory and 21 Work cells passed the single-machine integer acceptance. See VALIDATION_INLINE_FINAL.md. Float extension subsequently rejected the overall candidate. |
| float-native/confirm/causal | Same 6fceaaa source with harness 6712845: native 88 finite + 16 special cells; a reversed repeat confirms f32_id16/sparse16/B512 slowdown of 1.1634x. Rejected overall; generic, holdout and planned sparse Work stopped. See FLOAT_VALIDATION.md. |

| local-native/generic-* (baaa505) | New stable count-boundary/local-LSD variants from e86ca7a; correctness passed; eight-cell native float screen and eight independent confirmations reject both methods; two Work cells identify added classification/compaction. All larger scopes stopped. See LOCAL_COMPLETION_PLAN.md and LOCAL_COMPLETION_VALIDATION.md. |

| leaf-layout-native-float-first (518c6f2) | PA bounded cached leaves and caller-side block-capacity ablations plus their combination. Native library61 and float6 correctness checks pass; first eight-cell native screen and independent repeats reject the combined candidate. Remaining scopes stopped; isolated capacity control is exploratory only. Existing Block LSD kernel code is unchanged. See LEAF_LAYOUT_VALIDATION.md. |

| pa-capacity-native-float-first (17531ed) | Standalone PA caller-capacity candidate after removal of failed leaf code. Native library59 and float6 tests pass; independent seed20261024 eight-cell screen passes, but the original seed42 boundary repeat confirms1.183x regression. Rejected; larger scopes stopped. Existing kernel and PA classification/leaf rules unchanged. See PA_CAPACITY_PLAN.md. |

| pa-plan-* (a34545b) | Value-owned packed classification plan; rejected capacity rule removed. Native library59 and float6 checks pass, exact Work/leaf geometry equality established. Assembly shows register PEXT masks. Original-seed positive/reversed repeats reject the candidate (~1.138x vs original PA). Same-ELF two-seed diagnostics show no consistent gain vs borrowed packed kernel. Larger scopes stopped. See PA_PLAN_VALIDATION.md. |

The current source uses only a hardware token for compressed labels, delegates extraction to pinned hakmem, and otherwise keeps ordinary PA. Final validation requires its own immutable executables; historical hardware or software results are not transferred to it.

| counted- (current) | Independent conservative-packing and count-derived completion; correctness passed, small performance gates pending. Prior evidence is not acceptance for this source. |
