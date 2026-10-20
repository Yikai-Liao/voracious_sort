"""Produce a reviewable report using frozen candidate data only."""
import csv,json,statistics,sys
from pathlib import Path
root=Path(__file__).resolve().parent
stage=root/sys.argv[1]
manifest=json.loads((stage/'manifest.json').read_text())
rows=list(csv.DictReader((stage/'acceptance-cells.csv').open()))
for r in rows:
 for k in ['ratio','candidate_ns','saved_pa_ns','minimum','maximum','delta_ns']:
  r[k]=float(r[k])
 r['n']=int(r['n'])
bykey={(r['kind'],r['dist'],r['n']):r for r in rows}
full=manifest['schedule']==json.loads((root/'auto-baseline/manifest.json').read_text())['schedule']
losses=[r for r in rows if r['ratio']>1.1]
targets=[r for r in rows if r['n']==1048576 and r['dist'] in ['uniform_numeric','normal','high_only','low_bits_constant']]
def table(values):
 s='| Type | Distribution | n | Saved PA ms | Candidate ms | Ratio | Observed ratio range |\n|---|---|---:|---:|---:|---:|---:|\n'
 for r in values:
  s+=f"| {r['kind']} | {r['dist']} | {r['n']} | {r['saved_pa_ns']/1e6:.5f} | {r['candidate_ns']/1e6:.5f} | {r['ratio']:.3f} | {r['minimum']:.3f}–{r['maximum']:.3f} |\n"
 return s
ledger=[]
for p in sorted(root.glob('*/time-completion.json')):
 m=p.parent/'manifest.json'
 if not m.exists():continue
 methods=json.loads(m.read_text())['methods']
 if not set(methods)<={'pa_interval','pa_runs','pa_adaptive','pa_radix'}:continue
 c=json.loads(p.read_text()); ledger.append((p.parent.name,len(json.loads(m.read_text())['schedule']),c['rows'],c['seconds']))
audit=json.loads((root/'validation-followup.json').read_text())
s=f'''# Experimental PA: pure radix repair

The current candidate contains two radix mechanisms: translated-interval completion and exact constant-tail completion. It adds no stable-comparison fallback or natural-run merge completion. The earlier hybrid results are archived and do not count as PA radix-core gains.

Latest frozen stage: `{stage.name}`; {len(rows)} cells, {sum(int(r['observations']) for r in rows)} timings, all nine benchmark types. Full original 1045-cell schedule completed: **{full}**. Default adoption: **NOT ACCEPTED**. There are {len(losses)} cells with median historical candidate/PA ratio above 1.10. The complete per-cell record, A/A ranges and all slower observations are in `acceptance-cells.csv`; no aggregate speedup overrides a per-cell loss.

## Original PA weaknesses from saved data

The saved 1045-cell matrix shows a carry-width problem: at 1M records PA takes 25.49 ms on u32 uniform_numeric versus Block LSD's 8.54 ms (2.99x), and 32.01 ms on u64 versus 11.13 ms (2.88x). i32 normal is 2.76x slower than Block LSD. A narrow numeric interval that crosses a binary carry appears wide to the original prefix selection.

The low-tail case also pays unnecessary completion work: f32 low_bits_constant is 9.94 ms versus Block LSD's 4.97 ms. The exact prepared variation mask can prove that omitted low bits are constant, making a complete prefix distribution sufficient.

Run-shaped input remains a distinct weakness: f32 push_middle is 7.31x slower than saved LSD, record32 push_middle 8.81x slower than saved Timsort. Natural-run merging improved these cases but is a hybrid strategy. Those gains are excluded from the current radix-core claim, and the current mechanisms do not claim to repair all run-shaped inputs.

## Two current mechanisms

1. A bounded sample admits a possible carry-crossing interval only above the existing `512*block` workspace boundary. An exact min/max/variation proof then checks every key, preserving converted native widths. Subtract the proved minimum and use the existing grouped radix distributor only when completing the translated full key needs no more byte passes than the old first prefix. An unsampled outlier rejects the proof.
2. The existing union/intersection mask proves whether every low bit omitted by the selected prefix is constant. If so, sorting labels finishes complete keys. A separate complete-prefix classifier specializes the terminal distributor; ordinary prefix partition keeps its original constant `false` argument. This adds no record buffer, input scan, or runtime policy field. One varying low-bit outlier prevents completion.

Both paths preserve key order, stable equal-key identities and payloads. PA's original <=128-record comparison leaf, c=4/minimum-1KiB block policy and existing workspace threshold are retained. The original recursion signatures are unchanged. Rejected interval proofs call the fixed UnifiedGroups entry; this can repeat a failed order scan. The production Block LSD PR is untouched.

## Latest target results

{table(sorted(targets,key=lambda r:(r['dist'],r['kind'])))}
Ratios are medians of matched per-input candidate/saved-PA ratios and need not equal quotients of displayed timing medians. These are historical comparisons, not same-process paired causal estimates.

## Losses above 10 percent

{table(sorted(losses,key=lambda r:r['ratio'],reverse=True))}
The A/A fields describe observed variation, not a statistical no-regression guarantee. Repeated slow cells remain unresolved and prevent adoption. No old algorithm was rerun to normalize these results.

## Validation and measurement limits

The revision-14 library passed all 64 tests with `frontier_work`. The final classifier specialization reran the constant-tail proof test, including stable full records, nonzero constant low bits and a single varying low-bit outlier. The translated-interval tests cover carry boundaries and an unsampled outlier; every timed batch additionally passes the full order/identity/payload oracle outside timing.

The final executable retains the original PA/strict dispatch arms as compiler context, but its measurement manifest schedules only `pa_radix`. Two identical candidate slots, three seeds and two observation orders yield 12 timings from six input/ordering conditions; slots do not add independent seeds. Input digests, key widths, block and radix match saved PA. XOR output digests are compared only when repeated-batch parity matches, while every stable oracle must pass.

No compiler or correctness job overlaps timing. Native opt3/codegen1/thin-LTO, CPU 2 pinning and the existing runner/oracle are retained. All frozen stage files are hash-audited. Audit status: **{audit['status']}**; {audit['candidate_only_rows']} candidate-only rows across {len(audit['stages'])} completed stages, successful processes and zero process VmSwap. `validation-followup.json` records exact source/executable checks. Cross-process compiler layout and host variability remain limits; A/A cannot remove them.

Only new candidates were timed after the workflow correction. The earlier unnecessary full PA rerun is retained in `auto-baseline` and was never repeated after the correction. Other algorithms reuse sources listed in `reuse-sources.json`. `PLAN.md`, `run_auto.py`, and frozen reference files remain unchanged.

## Preserved experiments

Revisions 1–12 explored interval and hybrid run/comparison completion. Revision 11's added comparison completion failed its paired near-sorted screen; this path was removed. Revision 13 first combined both pure radix mechanisms. Revision 14 restored original recursive signatures but failed the broad gate. Revision 15 retained unmeasured original dispatch arms; its diagnostic still showed losses. Revision 16 isolates terminal-prefix specialization to preserve the ordinary partition's compile-time contract. Static evidence is stored in `leaf-disassembly-evidence.json`, `kernel-frame-evidence.json` and `wrapper-disassembly-v15.json`; changed code generation alone is not a measured causal explanation for every slow cell.

`REPORT-v3.md` and `REPORT-v6.md` preserve earlier conclusions. Every failed and noisy timing remains in its immutable stage.

| Stage | Cells | Timing rows | Runtime seconds |
|---|---:|---:|---:|
'''
for name,cells,count,seconds in ledger:s+=f'| {name} | {cells} | {count} | {seconds:.2f} |\n'
s+='\nSource: `/root/code/voracious_sort-workspaces/block-pa-benchmark-20261019/experiments/block_msd/src/frontier/`; branch `research/pa-benchmark-20261019`.\n'
(root/'REPORT.md').write_text(s)
print('wrote report',len(rows),'cells',len(losses),'losses >10%, full',full)
