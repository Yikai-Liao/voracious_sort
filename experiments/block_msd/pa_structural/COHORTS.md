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
| inline-smoke/confirm/generic/nested-control | 6fceaaa generic 46+7 cells, independent q64 repeats and two-cell executable ABBA; original-PA material gate passed locally. Native acceptance pending. |

The current source uses only a hardware token for compressed labels, delegates extraction to pinned hakmem, and otherwise keeps ordinary PA. Final validation requires its own immutable executables; historical hardware or software results are not transferred to it.
