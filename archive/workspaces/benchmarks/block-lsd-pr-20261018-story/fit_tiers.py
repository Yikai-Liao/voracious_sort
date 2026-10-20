#!/usr/bin/env python3
"""Compare smooth policies and regular byte/item tiers without inventing timings."""
from itertools import combinations_with_replacement
import hashlib
import json
import math
from pathlib import Path

import numpy as np

from fit_curves import load, metrics

ROOT = Path(__file__).resolve().parent
OUT = ROOT / "fits"


def write(name, rows):
    import csv
    fields = list(dict.fromkeys(k for r in rows for k in r))
    with (OUT / name).open("w", newline="") as stream:
        writer = csv.DictWriter(stream, fieldnames=fields)
        writer.writeheader()
        writer.writerows(rows)


def main():
    keys, s, n, blocks, times, heaps, names, controls = load()
    S = n * s
    axis = np.arange(len(keys))
    fastest = times.min(axis=1)
    reference = times[axis, controls["block_fixed_bytes_4096"]]
    base_b = np.maximum(np.ceil(4 * np.sqrt(9 * n / (512 * s))), np.maximum(1, 1024 // s))
    base_index = np.argmin(abs(blocks - base_b[:, None]), axis=1)
    assert np.all(blocks[axis, base_index] == base_b)
    base_times = times[axis, base_index]
    models = []
    choices = []
    covered = []
    nominal = []

    def add(model, wanted):
        index = np.argmin(abs(blocks - wanted[:, None]), axis=1)
        available = (blocks[axis, index] == wanted) | (n <= 128)
        # n<=128 is the same comparison-sort leaf independent of block argument.
        index[n <= 128] = 0
        models.append(dict(model_id=len(models), **model))
        choices.append(index)
        covered.append(available)
        nominal.append(wanted)

    add(dict(family="Reference", label="Smooth c4 + 1 KiB", kind="balanced", c=4), base_b)
    # Mathematically motivated powers-of-two quantization, unlimited above.
    for c in [1, 2, 4, 8, 16, 32, 64]:
        target_bytes = np.maximum(1024, c * np.sqrt(9 * S / 512))
        for mode in ["down", "nearest", "up"]:
            power = np.log2(target_bytes)
            rounded = np.floor(power) if mode == "down" else np.floor(power + .5) if mode == "nearest" else np.ceil(power)
            y = np.exp2(rounded).astype(np.int64)
            assert np.all(y % s == 0)
            add(dict(family="Quantized sqrt", label=f"c{c}, round {mode}", kind="quantized_sqrt", c=c,
                     rounding=mode, minimum_block_bytes=1024), y // s)
    # Fixed tiers: thresholds on input bytes or record count; allow unused tiers.
    specs = [("Byte tiers 1/4/8 KiB", [1024, 4096, 8192], S, "input_bytes"),
             ("Byte tiers 1/2/4/8 KiB", [1024, 2048, 4096, 8192], S, "input_bytes"),
             ("Item tiers 128/512/1024", [128, 512, 1024], n, "records")]
    for family, tiers, x, unit in specs:
        # Thresholds are powers of two; no thresholds are located by timing interpolation.
        thresholds = [0] + [2 ** p for p in range(int(np.log2(x.min())), int(np.log2(x.max())) + 2)]
        for cuts in combinations_with_replacement(thresholds, len(tiers) - 1):
            selected = np.searchsorted(cuts, x, side="right")
            values = np.array(tiers)[selected]
            wanted = values // s if unit == "input_bytes" else values
            add(dict(family=family, label=family, kind="threshold_tiers", tiers=json.dumps(tiers),
                     thresholds=json.dumps(cuts), threshold_unit=unit), wanted)
    choices = np.array(choices, dtype=np.uint8)
    available = np.array(covered)
    nominal = np.array(nominal)
    ts = times[axis[None, :], choices]
    hs = heaps[axis[None, :], choices]
    regret = ts / fastest
    eligible = available.all(axis=1)
    train_mask = n > 128

    def best(train, family):
        indices = np.array([i for i, m in enumerate(models) if m["family"] == family and eligible[i]])
        assert len(indices), family
        rr = regret[indices][:, train]
        rank = np.lexsort((indices, hs[indices][:, train].max(axis=1), rr.max(axis=1),
                           np.log(rr).mean(axis=1), np.quantile(rr, .9, axis=1)))
        return int(indices[rank[0]])

    ranking = []
    for i, model in enumerate(models):
        row = {**model, "exact_coverage": int(available[i].sum()), "eligible_for_full_comparison": bool(eligible[i])}
        if eligible[i]:
            row.update(metrics(ts[i], hs[i], fastest, reference))
            row["gm_time_vs_smooth_c4_floor"] = float(np.exp(np.mean(np.log(ts[i] / base_times))))
            row["informative_p90_regret"] = float(np.quantile(regret[i, train_mask], .9))
        ranking.append(row)
    ranking.sort(key=lambda r: (not r["eligible_for_full_comparison"], r.get("informative_p90_regret", float("inf")),
                                r.get("gm_regret", float("inf")), r["model_id"]))
    write("tier-all-models.csv", ranking)
    families = list(dict.fromkeys(m["family"] for m in models if m["family"] != "Reference"))
    winners = {family: best(train_mask, family) for family in families}
    # Keep all c4 variants visible, including their missing-coverage evidence.
    selections = {"Smooth c4 + 1 KiB": 0, **winners}
    selections.update({f"c4 round {m['rounding']}": i for i, m in enumerate(models)
                       if m["kind"] == "quantized_sqrt" and m["c"] == 4})
    finalists = []
    details = []
    missing = []
    for label, index in selections.items():
        row = {**models[index], "selection": label, "exact_coverage": int(available[index].sum())}
        if eligible[index]:
            row.update(metrics(ts[index], hs[index], fastest, reference))
            row["gm_time_vs_smooth_c4_floor"] = float(np.exp(np.mean(np.log(ts[index] / base_times))))
        finalists.append(row)
        for j, key in enumerate(keys):
            selected = int(choices[index, j])
            result = dict(selection=label, model_id=index, kind=key[0], dist=key[1], n=int(n[j]),
                          record_bytes=int(s[j]), input_bytes=int(S[j]), nominal_block=int(nominal[index, j]),
                          nominal_block_bytes=int(nominal[index, j] * s[j]),
                          exact_available=bool(available[index, j]), identical_small_leaf=bool(n[j] <= 128))
            if available[index, j]:
                result.update(pooled_median_ns=float(ts[index, j]), median_peak_bytes=float(hs[index, j]),
                              regret=float(regret[index, j]), time_vs_smooth_c4_floor=float(ts[index, j] / base_times[j]),
                              source_algorithms=names[j][selected])
            else:
                missing.append(result)
            details.append(result)
    write("tier-finalists.csv", finalists)
    write("tier-selected-conditions.csv", details)
    if missing:
        write("tier-missing-conditions.csv", missing)
    quantized_ids = [i for i, m in enumerate(models) if m["kind"] == "quantized_sqrt"]
    common = np.all(available[quantized_ids], axis=0)
    common_rows = []
    for i in [0, *quantized_ids]:
        common_rows.append({**models[i], "common_conditions": int(common.sum()),
                            **metrics(ts[i, common], hs[i, common], fastest[common], reference[common]),
                            "gm_time_vs_smooth_c4_floor": float(np.exp(np.mean(np.log(ts[i, common] / base_times[common]))))})
    write("quantized-common-support.csv", common_rows)
    common_excluded = [dict(kind=keys[j][0], dist=keys[j][1], n=int(n[j]), record_bytes=int(s[j]))
                       for j in np.flatnonzero(~common)]
    write("quantized-common-excluded.csv", common_excluded)
    # One common intersection for the c4 smooth/down/nearest/up comparison.
    c4_ids = [i for i in quantized_ids if models[i]["c"] == 4]
    c4_common = np.all(available[c4_ids], axis=0)
    c4_rows = []
    for i in [0, *c4_ids]:
        c4_rows.append({**models[i], "common_conditions": int(c4_common.sum()),
                       **metrics(ts[i, c4_common], hs[i, c4_common], fastest[c4_common], reference[c4_common]),
                       "gm_time_vs_smooth_c4_floor": float(np.exp(np.mean(np.log(ts[i, c4_common] / base_times[c4_common]))))})
    write("c4-quantized-common-support.csv", c4_rows)
    folds = []
    held_out = []
    for split, groups in [("record_bytes", s), ("length", n), ("distribution", np.array([key[1] for key in keys]))]:
        for group in sorted(set(groups)):
            test = groups == group
            train = ~test & train_mask
            for family in families:
                index = best(train, family)
                folds.append(dict(split=split, held_out_group=str(group), family=family, model_id=index,
                                  model=json.dumps(models[index]), **metrics(ts[index, test], hs[index, test], fastest[test], reference[test]),
                                  gm_time_vs_smooth_c4_floor=float(np.exp(np.mean(np.log(ts[index, test] / base_times[test]))))))
                for j in np.flatnonzero(test):
                    held_out.append(dict(split=split, held_out_group=str(group), family=family, model_id=index,
                                         kind=keys[j][0], dist=keys[j][1], n=int(n[j]), record_bytes=int(s[j]),
                                         regret=float(regret[index, j]), time_vs_smooth_c4_floor=float(ts[index, j] / base_times[j]),
                                         median_peak_bytes=float(hs[index, j])))
    write("tier-cv-folds.csv", folds)
    write("tier-cv-conditions.csv", held_out)
    summary = []
    for split in ["record_bytes", "length", "distribution"]:
        for family in families:
            rows = [r for r in held_out if r["split"] == split and r["family"] == family]
            assert len(rows) == len(keys)
            rr = np.array([r["regret"] for r in rows])
            ratio = np.array([r["time_vs_smooth_c4_floor"] for r in rows])
            summary.append(dict(split=split, family=family, conditions=len(rows),
                                gm_time_vs_smooth_c4_floor=float(np.exp(np.log(ratio).mean())),
                                p90_time_vs_smooth_c4_floor=float(np.quantile(ratio, .9)),
                                gm_regret=float(np.exp(np.log(rr).mean())), p90_regret=float(np.quantile(rr, .9)),
                                max_regret=float(rr.max()), within_25pct=float(np.mean(rr <= 1.25))))
    write("tier-cv-summary.csv", summary)
    result = dict(models=len(models), fully_measured_models=int(eligible.sum()), conditions=len(keys),
                  finalists=finalists, cross_validation=summary,
                  quantized_common_support=common_rows, quantized_common_excluded=common_excluded,
                  c4_quantized_common_support=c4_rows,
                  interpretation="Only exactly measured block arguments or the identical n<=128 leaf are evaluated. Missing arguments have no estimated timings and are excluded from full-coverage ranking; availability uses no speed information. Thresholds chosen on known data are exploratory.",
                  continuous_reference="c4 balanced sqrt + 1 KiB floor; exact integer blocks already measured.",
                  source_sha256={str(p.relative_to(ROOT)): hashlib.sha256(p.read_bytes()).hexdigest()
                                 for p in [ROOT / "data/policy-screen-conditions.csv", Path(__file__), ROOT / "fit_curves.py"]})
    (OUT / "tier-result.json").write_text(json.dumps(result, indent=2) + "\n")
    print(json.dumps(result, indent=2))


if __name__ == "__main__":
    main()
