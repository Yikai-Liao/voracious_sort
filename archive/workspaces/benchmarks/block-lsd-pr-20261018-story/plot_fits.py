#!/usr/bin/env python3
"""Plot model geometry and retained-data validation; never run a benchmark."""
import csv
import hashlib
import json
from pathlib import Path
import sys

import matplotlib as mpl
mpl.use("Agg")
import matplotlib.pyplot as plt
from matplotlib.lines import Line2D
import numpy as np

ROOT = Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT / "qa-tools"))
from audit_panel_alignment import require_matplotlib_panel_alignment

mpl.rcParams.update({
    "font.family": "sans-serif", "font.sans-serif": ["DejaVu Sans", "Arial", "Helvetica"],
    "font.size": 7, "axes.titlesize": 7.5, "axes.labelsize": 7,
    "xtick.labelsize": 6.3, "ytick.labelsize": 6.3, "legend.fontsize": 6.5,
    "axes.spines.top": False, "axes.spines.right": False,
    "axes.linewidth": .6, "svg.fonttype": "none", "pdf.fonttype": 42,
    "savefig.dpi": 300,
})


def read(name):
    with (ROOT / "fits" / name).open() as stream:
        return list(csv.DictReader(stream))


def main():
    # Logarithmic geometry and ratios must be strictly positive; assert below.
    (ROOT / "figures").mkdir(exist_ok=True)
    (ROOT / "qa").mkdir(exist_ok=True)
    result = json.loads((ROOT / "fits/result.json").read_text())
    tiers = json.loads((ROOT / "fits/tier-result.json").read_text())
    for source, digest in {**result["source_sha256"], **tiers["source_sha256"]}.items():
        assert hashlib.sha256((ROOT / source).read_bytes()).hexdigest() == digest, source
    selected = read("tier-selected-conditions.csv")
    labels = ["Smooth c4 + 1 KiB", "c4 round down", "c4 round nearest", "c4 round up"]
    display = ["Smooth c4 + 1 KiB", "Round down", "Nearest tier", "Round up"]
    colors = ["#296A9C", "#999999", "#6D6875", "#BF8955"]
    styles = ["-", "--", "-.", ":"]
    lookup = {(r["selection"], r["kind"], r["dist"], r["n"]): r for r in selected}
    all_cases = {(r["kind"], r["dist"], r["n"]) for r in selected}
    common = sorted(case for case in all_cases if all(lookup[label, *case]["exact_available"] == "True" for label in labels))
    assert len(common) == 107
    fig, axes = plt.subplots(2, 2, figsize=(183 / 25.4, 175 / 25.4))
    fig.subplots_adjust(left=.105, right=.98, bottom=.14, top=.82, wspace=.40, hspace=.69)
    for ax, label in zip(axes.flat, "abcd"):
        ax.annotate(label, (0, 1), xycoords="axes fraction", xytext=(-17, 7), textcoords="offset points",
                    ha="left", va="bottom", fontsize=9, fontweight="bold", annotation_clip=False)
        ax.grid(axis="y", color="#E7E7E7", lw=.4)
        ax.set_axisbelow(True)
    fig.suptitle("Regular tiers trade simplicity for speed in this screen", x=.105, y=.985, ha="left", fontsize=10)
    handles = [Line2D([], [], color=c, ls=style, lw=1.5, label=label)
               for c, style, label in zip(colors, styles, display)]
    fig.legend(handles=handles, loc="upper left", bbox_to_anchor=(.09, .947), ncol=4, columnspacing=1.5, frameon=False)

    ax = axes[0, 0]
    # These are deterministic formula geometries, not synthesized timing data.
    input_mib = np.geomspace(.125, 128, 1400)
    smooth = np.maximum(1024, 4 * np.sqrt(9 * input_mib * 2**20 / 512))
    assert np.all(input_mib > 0) and np.all(smooth > 0)
    values = [smooth, np.exp2(np.floor(np.log2(smooth))),
              np.exp2(np.floor(np.log2(smooth) + .5)), np.exp2(np.ceil(np.log2(smooth)))]
    for value, color, style in zip(values, colors, styles):
        ax.plot(input_mib, value / 1024, color=color, ls=style, lw=1.5)
    ax.set_xscale("log", base=2); ax.set_yscale("log", base=2)
    ax.set_xticks([.125, .5, 2, 8, 32, 128], ["1/8", "1/2", "2", "8", "32", "128"])
    ax.set_yticks([1, 2, 4, 8], ["1", "2", "4", "8"])
    ax.minorticks_off()
    ax.set_xlabel("Total input size (MiB)"); ax.set_ylabel("Bytes per block (KiB)")
    ax.set_title("Function shapes: the same c = 4 target", loc="left", pad=9)

    ax = axes[0, 1]
    for label, color, style in zip(labels, colors, styles):
        values = np.sort([float(lookup[label, *case]["regret"]) for case in common])
        assert np.all(values > 0)
        ax.step(values, np.arange(1, len(values) + 1) / len(values) * 100,
                where="post", color=color, ls=style, lw=1.5)
    ax.set_xscale("log", base=2)
    ax.set_xticks([1, 1.25, 1.5, 2, 3], ["1", "1.25", "1.5", "2", "3"])
    ax.minorticks_off(); ax.set_xlim(.98, 3); ax.set_ylim(0, 102)
    ax.set_xlabel("Time / fastest measured Block configuration")
    ax.set_ylabel("Share of 107 common conditions (%)")
    ax.set_title("Regular tiers lose more often in the tail", loc="left", pad=9)

    ax = axes[1, 0]
    profile = read("alpha-profile.csv")
    alphas = np.array([float(r["alpha"]) for r in profile])
    p90 = np.array([float(r["p90_regret"]) for r in profile])
    assert np.all(np.diff(alphas) > 0) and np.all(p90 >= 1)
    ax.plot(alphas, p90, "o-", color="#696969", ms=3.5, lw=1.2,
            label="Refit all other parameters")
    ax.axhline(result["baseline"]["p90_regret"], color=colors[0], ls="--", lw=1,
               label="Smooth c4 + 1 KiB")
    ax.set_xticks([0, .125, .25, .375, .5, .625, .75], ["0", ".125", ".25", ".375", ".5", ".625", ".75"])
    ax.set_ylim(1, 1.4)
    ax.set_xlabel("Length exponent alpha in the free power model")
    ax.set_ylabel("P90 time / fastest measured configuration")
    ax.set_title("The data do not identify a sharp exponent", loc="left", pad=9)
    ax.legend(loc="upper left", frameon=False)

    ax = axes[1, 1]
    ax.grid(False)
    folds = read("cross-validation-folds.csv")
    summaries = read("cross-validation-summary.csv")
    families = ["Power", "Power + floor", "Total-byte power + floor"]
    model_labels = ["Free power", "Free power + floor", "Input-byte power + floor"]
    model_colors = ["#999999", "#5D7894", "#9B739E"]
    splits = ["record_bytes", "length", "distribution"]
    for offset, family, color, label in zip([-.19, 0, .19], families, model_colors, model_labels):
        center = np.array([float(next(r["gm_time_vs_c4_floor_1k"] for r in summaries if r["split"] == split and r["family"] == family)) for split in splits])
        lo = np.array([min(float(r["gm_time_vs_c4_floor_1k"]) for r in folds if r["split"] == split and r["family"] == family) for split in splits])
        hi = np.array([max(float(r["gm_time_vs_c4_floor_1k"]) for r in folds if r["split"] == split and r["family"] == family) for split in splits])
        assert np.all(lo <= center) and np.all(center <= hi)
        ax.errorbar(np.arange(3) + offset, center, yerr=[center - lo, hi - center], fmt="D", ms=3.4,
                    color=color, lw=.9, capsize=2, label=label)
    ax.axhline(1, color=colors[0], lw=.9, ls="--")
    ax.set_xticks(range(3), ["Width\n5 folds", "Length\n15 folds", "Distribution\n7 folds"])
    ax.set_ylim(.70, 1.15); ax.set_xlim(-.5, 2.5)
    ax.set_ylabel("Held-out time / smooth c4 + 1 KiB")
    ax.set_title("Extra fitting freedom gives no stable gain", loc="left", pad=9)
    ax.legend(loc="lower right", frameon=False, fontsize=6)

    fig.text(.105, .060, "Replay uses exact measured arguments; panel b excludes two missing conditions. Panel a shows formulas only.", fontsize=6)
    fig.text(.105, .038, "c: 109 conditions. d: geometric mean over held-out cases; whiskers span fold means, not confidence intervals.", fontsize=6)
    fig.canvas.draw()
    stem = "curve-and-tier-fitting"
    require_matplotlib_panel_alignment(fig, json_out=ROOT / "qa" / (stem + ".alignment.json"),
                                      overlay_svg=ROOT / "qa" / (stem + ".alignment.svg"),
                                      tolerance_pt=1.5, gutter_tolerance_pt=1.5,
                                      require_panel_labels=True, strict=True)
    fig.savefig(ROOT / "figures" / (stem + ".pdf"))
    fig.savefig(ROOT / "figures" / (stem + ".svg"))
    fig.savefig(ROOT / "figures" / (stem + ".png"), dpi=300)
    plt.close(fig)
    sources = [Path(__file__), ROOT / "fits/result.json", ROOT / "fits/tier-result.json",
               ROOT / "fits/tier-selected-conditions.csv", ROOT / "fits/alpha-profile.csv",
               ROOT / "fits/cross-validation-folds.csv", ROOT / "fits/cross-validation-summary.csv"]
    (ROOT / "qa" / (stem + ".provenance.json")).write_text(json.dumps({
        str(p.relative_to(ROOT)): hashlib.sha256(p.read_bytes()).hexdigest() for p in sources}, indent=2) + "\n")


if __name__ == "__main__":
    main()
