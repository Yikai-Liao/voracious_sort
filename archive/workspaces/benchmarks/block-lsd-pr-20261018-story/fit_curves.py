#!/usr/bin/env python3
"""Fit n/record-size policies using retained, exactly measured block arguments."""
from collections import defaultdict
import csv
import hashlib
import json
import math
from pathlib import Path
import statistics

import numpy as np

ROOT = Path(__file__).resolve().parent
OUT = ROOT / "fits"


def write(name, rows):
    fields = list(dict.fromkeys(key for row in rows for key in row))
    with (OUT / name).open("w", newline="") as stream:
        writer = csv.DictWriter(stream, fieldnames=fields)
        writer.writeheader()
        writer.writerows(rows)


def load():
    with (ROOT / "data/policy-screen-conditions.csv").open() as stream:
        rows = list(csv.DictReader(stream))
    cases = defaultdict(list)
    for row in rows:
        assert float(row["pooled_median_ns"]) > 0
        cases[row["kind"], row["dist"], int(row["n"])].append(row)
    keys = sorted(cases)
    assert len(keys) == 109
    count = max(len({int(r["block"]) for r in group}) for group in cases.values())
    blocks = np.full((len(keys), count), np.inf)
    times = np.full_like(blocks, np.inf)
    heaps = np.full_like(blocks, np.inf)
    names = []
    controls = defaultdict(list)
    for i, key in enumerate(keys):
        equal = defaultdict(list)
        for row in cases[key]:
            equal[int(row["block"])].append(row)
        algos = []
        for j, (block, group) in enumerate(sorted(equal.items())):
            # Duplicate function arguments share their pooled retained timings.
            assert len({r["pooled_median_ns"] for r in group}) == 1
            assert len({r["median_peak_bytes"] for r in group}) == 1
            blocks[i, j] = block
            times[i, j] = float(group[0]["pooled_median_ns"])
            heaps[i, j] = float(group[0]["median_peak_bytes"])
            algos.append("|".join(sorted(r["algorithm"] for r in group)))
        names.append(algos)
        for row in cases[key]:
            controls[row["algorithm"]].append(int(np.flatnonzero(blocks[i] == int(row["block"]))[0]))
    widths = np.array([int(cases[key][0]["record_bytes"]) for key in keys])
    lengths = np.array([key[2] for key in keys])
    assert np.all(np.isfinite(times[:, 0]))
    return keys, widths, lengths, blocks, times, heaps, names, controls


def models():
    result = []
    for alpha in np.arange(0, .751, .125):
        for beta in np.arange(0, 1.001, .125):
            for amplitude in [32, 48, 64, 96, 128, 192, 256, 384, 512, 768, 1024]:
                for floor in [0, 512, 1024, 2048, 4096]:
                    for cap in [0, 4096, 16384, 65536]:
                        if cap and floor > cap:
                            continue
                        family = "Power" if not floor and not cap else "Power + floor" if not cap else "Power + floor/cap"
                        result.append(dict(model_id=len(result), family=family, A=amplitude,
                                           alpha=float(alpha), beta=float(beta),
                                           floor_bytes=floor, cap_bytes=cap))
    return result


def target(model, n, s):
    value = model["A"] * (n / 1048576.) ** model["alpha"] * (s / 8.) ** (-model["beta"])
    value = np.maximum(value, model["floor_bytes"] / s)
    if model["cap_bytes"]:
        value = np.minimum(value, model["cap_bytes"] / s)
    return np.maximum(value, 1)


def metrics(selected_time, selected_heap, fastest, reference):
    ratios = selected_time / fastest
    return dict(conditions=len(ratios), gm_regret=float(np.exp(np.mean(np.log(ratios)))),
                p90_regret=float(np.quantile(ratios, .9)), max_regret=float(np.max(ratios)),
                within_25pct=float(np.mean(ratios <= 1.25)),
                gm_time_vs_4k=float(np.exp(np.mean(np.log(selected_time / reference)))),
                max_heap_bytes=float(np.max(selected_heap)))


def main():
    OUT.mkdir(exist_ok=True)
    keys, s, n, blocks, times, heaps, names, controls = load()
    candidates = models()
    chosen = np.empty((len(candidates), len(keys)), dtype=np.uint8)
    # Each choice depends on n,s alone; neither distribution nor timing is used.
    for start in range(0, len(candidates), 128):
        subset = candidates[start:start + 128]
        predictions = np.stack([target(model, n, s) for model in subset])
        distance = np.abs(np.log(blocks)[None, :, :] - np.log(predictions)[:, :, None])
        chosen[start:start + len(subset)] = np.argmin(distance, axis=2)
    cases_axis = np.arange(len(keys))[None, :]
    selected_time = times[cases_axis, chosen]
    selected_heap = heaps[cases_axis, chosen]
    fastest = times.min(axis=1)
    reference = times[np.arange(len(keys)), controls["block_fixed_bytes_4096"]]
    regret = selected_time / fastest
    log_regret = np.log(regret)
    baseline_b = np.maximum(np.ceil(4 * np.sqrt(9 * n / (512 * s))), np.maximum(1, 1024 // s))
    baseline_choice = np.argmin(np.abs(np.log(blocks) - np.log(baseline_b)[:, None]), axis=1)
    assert np.all(blocks[np.arange(len(keys)), baseline_choice] == baseline_b)
    baseline_time = times[np.arange(len(keys)), baseline_choice]
    baseline_heap = heaps[np.arange(len(keys)), baseline_choice]
    informative = n > 128
    families = ["Power", "Power + floor", "Power + floor/cap", "Total-byte power + floor"]
    # Refit the previously screened formula family in each split as a comparator.
    with (ROOT / "data/policy-floor-screen-conditions.csv").open() as stream:
        old_rows = list(csv.DictReader(stream))
    old_policies = sorted({r["policy"] for r in old_rows})
    old_index = {name: i for i, name in enumerate(old_policies)}
    case_index = {key: i for i, key in enumerate(keys)}
    old_times = np.empty((len(old_policies), len(keys)))
    old_heaps = np.empty_like(old_times)
    for row in old_rows:
        i = old_index[row["policy"]]
        j = case_index[row["kind"], row["dist"], int(row["n"])]
        old_times[i, j] = float(row["pooled_median_ns"])
        old_heaps[i, j] = float(row["median_peak_bytes"])

    def best(train, family=None):
        def belongs(model):
            if family == "Total-byte power + floor":
                return model["cap_bytes"] == 0 and model["floor_bytes"] > 0 and np.isclose(model["alpha"] + model["beta"], 1)
            return family is None or model["family"] == family
        indices = np.array([i for i, model in enumerate(candidates) if belongs(model)])
        p90 = np.quantile(regret[indices][:, train], .9, axis=1)
        gm = np.mean(log_regret[indices][:, train], axis=1)
        worst = np.max(regret[indices][:, train], axis=1)
        peak = np.max(selected_heap[indices][:, train], axis=1)
        # Stable model_id is a deterministic tie-break after all measured metrics.
        order = np.lexsort((indices, peak, worst, gm, p90))
        return int(indices[order[0]])

    def best_old(train):
        ratios = old_times[:, train] / fastest[train]
        order = np.lexsort((np.arange(len(old_policies)), np.max(old_heaps[:, train], axis=1),
                            np.max(ratios, axis=1), np.mean(np.log(ratios), axis=1),
                            np.quantile(ratios, .9, axis=1)))
        return int(order[0])

    ranking = []
    for i, model in enumerate(candidates):
        result = {**model, **metrics(selected_time[i], selected_heap[i], fastest, reference)}
        result["informative_p90_regret"] = float(np.quantile(regret[i, informative], .9))
        ranking.append(result)
    ranking.sort(key=lambda row: (row["informative_p90_regret"], row["gm_regret"], row["max_regret"], row["max_heap_bytes"], row["model_id"]))
    write("all-models.csv", ranking)
    winners = {family: best(informative, family) for family in families}
    winners["All power families"] = best(informative)
    rows = []
    details = []
    for family, index in winners.items():
        result = {**candidates[index], **metrics(selected_time[index], selected_heap[index], fastest, reference), "selection": family}
        result["gm_time_vs_c4_floor_1k"] = float(np.exp(np.mean(np.log(selected_time[index] / baseline_time))))
        positive = baseline_heap > 0
        result["positive_heap_conditions"] = int(positive.sum())
        result["gm_heap_vs_c4_floor_1k"] = float(np.exp(np.mean(np.log(selected_heap[index, positive] / baseline_heap[positive]))))
        result["p90_heap_vs_input"] = float(np.quantile(selected_heap[index] / (n * s), .9))
        rows.append(result)
        for j, key in enumerate(keys):
            b = int(chosen[index, j])
            details.append(dict(selection=family, kind=key[0], dist=key[1], n=int(n[j]), record_bytes=int(s[j]),
                                model_id=index, target_block=float(target(candidates[index], n[j], s[j])),
                                measured_block=int(blocks[j, b]), source_algorithms=names[j][b],
                                pooled_median_ns=float(selected_time[index, j]), median_peak_bytes=float(selected_heap[index, j]),
                                regret=float(regret[index, j]), time_vs_c4_floor_1k=float(selected_time[index, j] / baseline_time[j])))
    baseline_metrics = metrics(baseline_time, baseline_heap, fastest, reference)
    write("full-data-finalists.csv", rows)
    write("full-data-selected-conditions.csv", details)
    held_out = []
    folds = []
    for split, groups in [("record_bytes", s), ("length", n), ("distribution", np.array([key[1] for key in keys]))]:
        for value in sorted(set(groups)):
            test = groups == value
            train = ~test & informative
            assert np.any(train)
            selections = {family: best(train, family) for family in families}
            selections["All power families"] = best(train)
            prior = best_old(train)
            for family, index in [*selections.items(), ("Refit prior 111 formulas", prior)]:
                ts = old_times[index] if family == "Refit prior 111 formulas" else selected_time[index]
                hs = old_heaps[index] if family == "Refit prior 111 formulas" else selected_heap[index]
                chosen_model = old_policies[index] if family == "Refit prior 111 formulas" else str(index)
                folds.append(dict(split=split, held_out_group=str(value), family=family, selected_model=chosen_model,
                                  train_conditions=int(train.sum()), test_conditions=int(test.sum()),
                                  **metrics(ts[test], hs[test], fastest[test], reference[test]),
                                  gm_time_vs_c4_floor_1k=float(np.exp(np.mean(np.log(ts[test] / baseline_time[test]))))))
                for j in np.flatnonzero(test):
                    held_out.append(dict(split=split, held_out_group=str(value), family=family, kind=keys[j][0],
                                         dist=keys[j][1], n=int(n[j]), record_bytes=int(s[j]), selected_model=chosen_model,
                                         pooled_median_ns=float(ts[j]), median_peak_bytes=float(hs[j]),
                                         regret=float(ts[j] / fastest[j]), time_vs_c4_floor_1k=float(ts[j] / baseline_time[j])))
    write("cross-validation-folds.csv", folds)
    write("cross-validation-conditions.csv", held_out)
    summaries = []
    for split in ["record_bytes", "length", "distribution"]:
        for family in [*families, "All power families", "Refit prior 111 formulas"]:
            group = [r for r in held_out if r["split"] == split and r["family"] == family]
            assert len(group) == len(keys)
            ratios = np.array([r["time_vs_c4_floor_1k"] for r in group])
            rs = np.array([r["regret"] for r in group])
            summaries.append(dict(split=split, family=family, conditions=len(group),
                                  gm_time_vs_c4_floor_1k=float(np.exp(np.mean(np.log(ratios)))),
                                  p90_time_vs_c4_floor_1k=float(np.quantile(ratios, .9)), max_time_vs_c4_floor_1k=float(ratios.max()),
                                  gm_regret=float(np.exp(np.mean(np.log(rs)))), p90_regret=float(np.quantile(rs, .9)),
                                  max_regret=float(rs.max()), within_25pct=float(np.mean(rs <= 1.25)),
                                  max_heap_bytes=max(r["median_peak_bytes"] for r in group)))
    write("cross-validation-summary.csv", summaries)
    profiles = []
    for alpha in sorted({model["alpha"] for model in candidates}):
        indices = [i for i, model in enumerate(candidates) if model["alpha"] == alpha and model["cap_bytes"] == 0]
        winner = min(indices, key=lambda i: (float(np.quantile(regret[i, informative], .9)), float(np.mean(log_regret[i, informative])), i))
        profiles.append(dict(alpha=alpha, selected_model=winner, **metrics(selected_time[winner], selected_heap[winner], fastest, reference)))
    write("alpha-profile.csv", profiles)
    # Identifiability check: regress the smallest measured block within 10% of fastest.
    plateau = []
    for i, key in enumerate(keys):
        if n[i] <= 128:
            continue
        acceptable = times[i] <= 1.1 * fastest[i]
        block = float(np.min(blocks[i, acceptable]))
        plateau.append(dict(kind=key[0], dist=key[1], n=int(n[i]), record_bytes=int(s[i]),
                            smallest_block_within_10pct=block))
    write("near-optimal-plateau.csv", plateau)
    cells = defaultdict(list)
    for row in plateau:
        cells[row["n"], row["record_bytes"]].append(math.log(row["smallest_block_within_10pct"]))
    design = np.array([[1, math.log(nn / 1048576), -math.log(ss / 8)] for nn, ss in sorted(cells)])
    response = np.array([statistics.median(cells[key]) for key in sorted(cells)])
    coefficients = np.linalg.lstsq(design, response, rcond=None)[0]
    result = dict(conditions=len(keys), informative_conditions=int(informative.sum()),
                  parameter_grid_models=len(candidates), unique_widths=sorted(set(map(int, s))),
                  parameterization="b_target=max(1,F/s,A*(n/1048576)^alpha*(s/8)^(-beta)); optional min(C/s). Snap by absolute log distance to actually measured block set for the same n,s; ties choose smaller b.",
                  scoring="Fit on n>128: smallest P90 regret, then GM regret, worst regret, maximum heap, deterministic ID. Report all109 including the invariant comparison leaf.",
                  interpretation="All times describe exact measured arguments after snapping, not interpolated times of the continuous curve. Finite grid and existing workload reuse prevent universal-optimum claims.",
                  baseline={"formula": "max(ceil(4*sqrt(9*n/(512*s))),floor(1024/s),1)", **baseline_metrics},
                  finalists=rows, cross_validation=summaries,
                  plateau_loglinear_diagnostic=dict(A=float(np.exp(coefficients[0])), alpha=float(coefficients[1]), beta=float(coefficients[2]),
                      n_size_cells=len(cells), rule="Equal weight per n,s cell; median log of smallest block within 10% of fastest. Descriptive only; policy fit uses timing regret directly."),
                  source_sha256={str(path.relative_to(ROOT)): hashlib.sha256(path.read_bytes()).hexdigest() for path in [ROOT / "data/policy-screen-conditions.csv", ROOT / "data/policy-floor-screen-conditions.csv", Path(__file__), ROOT / "fit-contract.md"]})
    (OUT / "result.json").write_text(json.dumps(result, indent=2) + "\n")
    print(json.dumps(result, indent=2))


if __name__ == "__main__":
    main()
