#!/usr/bin/env python3
"""Render the reader's comparison-first evidence sequence from retained CSVs."""
import csv
import hashlib
import json
from pathlib import Path
import sys

import matplotlib as mpl
mpl.use("Agg")
import matplotlib.pyplot as plt
from matplotlib.colors import LogNorm
from matplotlib.lines import Line2D
from matplotlib.patches import Rectangle
from matplotlib.ticker import FuncFormatter, NullFormatter
import numpy as np

from evaluate_reuse import CANDIDATE, DISTS

ROOT = Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT / "qa-tools"))
from audit_panel_alignment import require_matplotlib_panel_alignment

mpl.rcParams.update({
    "font.family":"sans-serif", "font.sans-serif":["DejaVu Sans","Arial","Helvetica"],
    "font.size":7, "axes.titlesize":7.5, "axes.labelsize":7,
    "xtick.labelsize":6.3, "ytick.labelsize":6.3, "legend.fontsize":6.5,
    "axes.spines.top":False, "axes.spines.right":False, "axes.linewidth":.6,
    "svg.fonttype":"none", "pdf.fonttype":42, "savefig.dpi":300,
})
BLUE = "#296A9C"
GREY = "#797979"
ORANGE = "#BF8955"
NAMES = {CANDIDATE:"Block LSD", "lsd":"LSD stable", "std":"Driftsort", "timsort":"TimSort"}
DIST_NAMES = dict(zip(DISTS, ["Uniform bits", "Uniform numeric", "Uniform narrow", "95% one key", "16 keys", "sqrt(n) keys", "Common prefix", "Constant low bits", "High byte varies", "Sorted", "Reversed + ties", "1% swaps", "log2(n) swaps", "Reverse + 1% swaps", "All equal", "Last key differs", "Alternating extremes", "Organ pipe", "Sawtooth", "Zipf (1.2)", "Normal", "One item at front", "One item in middle"]))


def read(name):
    with (ROOT / "data" / name).open() as stream:
        return list(csv.DictReader(stream))


def letter(ax, label):
    ax.annotate(label, (0,1), xycoords="axes fraction", xytext=(-17,7), textcoords="offset points",
                ha="left", va="bottom", fontsize=9, fontweight="bold", annotation_clip=False)


def plain_log(ax, axis="both"):
    def show(value, _):
        if value <= 0:
            return ""
        if value < 1 and np.isclose(1/value, round(1/value)):
            return f"1/{round(1/value)}"
        if value >= 1000:
            return f"{value:,.0f}"
        return f"{value:g}"
    for key in (["x","y"] if axis == "both" else [axis]):
        target = getattr(ax, key+"axis")
        target.set_major_formatter(FuncFormatter(show))
        target.set_minor_formatter(NullFormatter())


def save(fig, stem, exclude=()):
    fig.canvas.draw()
    require_matplotlib_panel_alignment(fig, json_out=ROOT/"qa"/(stem+".alignment.json"),
                                      overlay_svg=ROOT/"qa"/(stem+".alignment.svg"), exclude_axes=list(exclude),
                                      tolerance_pt=1.5, gutter_tolerance_pt=1.5,
                                      require_panel_labels=True, strict=True)
    fig.savefig(ROOT/"figures"/(stem+".pdf"))
    fig.savefig(ROOT/"figures"/(stem+".svg"))
    fig.savefig(ROOT/"figures"/(stem+".png"), dpi=300)
    plt.close(fig)


def comparison():
    # Logarithmic times, heaps and ratios must be strictly positive.
    largest = read("comparison-largest-example.csv")
    counts = read("comparison-memory-counts.csv")
    comparisons = read("candidate-comparisons.csv")
    fig = plt.figure(figsize=(183/25.4,230/25.4))
    grid = fig.add_gridspec(2,2, left=.17, right=.97, bottom=.12, top=.88,
                          height_ratios=[1,1.3], wspace=.47, hspace=.58)
    a = fig.add_subplot(grid[0,0]); b = fig.add_subplot(grid[0,1])
    c=fig.add_subplot(grid[1,:])
    for ax, label in zip([a,b,c],"abc"):
        letter(ax,label)
    fig.suptitle("Block LSD: auxiliary heap and overall speed distribution", x=.17,y=.985,ha="left",fontsize=10)
    fig.text(.17,.948,"Block LSD: c = 4, minimum 1 KiB per block; radix = 8",fontsize=7.5)
    colors = {CANDIDATE:BLUE,"lsd":"#555555","std":"#929292","timsort":ORANGE}
    markers = {CANDIDATE:"o","lsd":"s","std":"D","timsort":"^"}
    for row in largest:
        name=row["algorithm"]
        x=float(row["median_peak_bytes"])/2**20; y=float(row["median_ns"])/1e6
        assert x > 0 and y > 0
        xlo=float(row["min_peak_bytes"])/2**20; xhi=float(row["max_peak_bytes"])/2**20
        ylo=float(row["min_ns"])/1e6; yhi=float(row["max_ns"])/1e6
        a.errorbar(x,y,xerr=[[x-xlo],[xhi-x]],yerr=[[y-ylo],[yhi-y]],fmt=markers[name],
                   color=colors[name],ms=4,lw=.8,capsize=2)
        offset,ha=(6,-9),"left" if name==CANDIDATE else "right"
        if name!=CANDIDATE:offset=(-5,-10 if name=="std" else 8)
        a.annotate(NAMES[name],(x,y),xytext=offset,textcoords="offset points",ha=ha,va="center",fontsize=6.5)
    a.set_xscale("log",base=2);a.set_yscale("log",base=2);plain_log(a)
    a.set_xlim(min(float(r["min_peak_bytes"])/2**20 for r in largest)*.7,
               max(float(r["max_peak_bytes"])/2**20 for r in largest)*1.35)
    a.set_ylim(min(float(r["min_ns"])/1e6 for r in largest)*.65,
               max(float(r["max_ns"])/1e6 for r in largest)*1.5)
    a.set_xlabel("Peak extra heap (MiB)");a.set_ylabel("Sort time (ms)")
    a.set_title("16M uniform u64: joint cost",loc="left",pad=10)
    a.grid(False)
    b.set_title("How often is the heap lower?",loc="left",pad=10)
    relations=["less","equal","more"]
    for i, row in enumerate(counts):
        total=int(row["conditions"]);left=0
        for relation,color in zip(relations,[BLUE,"#C8C8C8",ORANGE]):
            width=int(row[relation])/total*100
            b.barh(i,width,left=left,height=.60,color=color,edgecolor="white",lw=.5)
            if width>=10:
                b.text(left+width/2,i,str(int(row[relation])),ha="center",va="center",fontsize=6.5,
                       color="white" if relation=="less" else "#333333")
            left+=width
    b.set_yticks(range(3),[NAMES[r["comparator"]]+f"\nn={r['conditions']}" for r in counts])
    b.invert_yaxis();b.set_xlim(0,100);b.set_xticks([0,50,100])
    b.set_xlabel("Share of comparable 1M conditions (%)")
    b.spines["left"].set_visible(False);b.tick_params(axis="y",length=0)
    b.legend(handles=[Rectangle((0,0),1,1,color=color,label=label) for color,label in
                      zip([BLUE,"#C8C8C8",ORANGE],["Less","Equal","More"])],
             loc="upper left",bbox_to_anchor=(-.02,-.28),ncol=3,frameon=False,columnspacing=1,handlelength=1)
    for comparator,color,marker in [("lsd",BLUE,"o"),("std",GREY,"s"),("timsort",ORANGE,"^")]:
        values=np.sort([float(row["median_paired_time_ratio"]) for row in comparisons
                       if int(row["n"])==1048576 and row["comparator"]==comparator
                       and row["stable_semantics_match"]=="True"])
        c.step(np.r_[1/64,values,8],np.r_[0,np.arange(1,len(values)+1)/len(values)*100,100],
               where="post",color=color,lw=1.1,label=NAMES[comparator])
    c.set_xscale("log",base=2);plain_log(c,"x")
    c.set_xlim(1/64,8);c.set_ylim(0,100);c.set_yticks([0,25,50,75,100])
    c.axvline(1,color="#444444",ls="--",lw=.8)
    c.set_title("Empirical distribution across the benchmark cases",loc="left",pad=10)
    c.set_xlabel("Candidate time / comparator time threshold")
    c.set_ylabel("Cases at or below threshold (%)")
    c.grid(axis="y",color="#E7E7E7",lw=.4)
    c.legend(loc="lower right",frameon=False)
    fig.text(.17,.062,"c: every case has equal weight; these curves describe case differences, not timing uncertainty.",fontsize=6)
    fig.text(.17,.043,"1M: LSD has 205 valid cases; Driftsort and TimSort have 207. Two reversed-record LSD oracle failures are excluded.",fontsize=6)
    fig.text(.17,.024,"a: medians and full timing ranges. Details are shown in the per-type comparisons.",fontsize=6)
    save(fig,"01b-efficiency-overview")


def by_type():
    """Fix the record type in each facet; show each input case as its own point."""
    comparisons=read("candidate-comparisons.csv")
    kinds=["u32","i32","f32","u64","i64","f64","u128","record32","record128"]
    fig=plt.figure(figsize=(183/25.4,280/25.4))
    grid=fig.add_gridspec(3,3,left=.20,right=.98,bottom=.09,top=.875,wspace=.24,hspace=.23)
    axes=[fig.add_subplot(grid[y,x]) for y in range(3) for x in range(3)]
    mappings=[("lsd",BLUE,"o",-.23),("std",GREY,"s",0),("timsort",ORANGE,"^",.23)]
    for index,(ax,kind) in enumerate(zip(axes,kinds)):
        letter(ax,"abcdefghi"[index]);ax.set_title(kind,loc="left",pad=8)
        for comparator,color,marker,offset in mappings:
            lookup={row["dist"]:row for row in comparisons if row["kind"]==kind
                    and row["comparator"]==comparator and int(row["n"])==1048576}
            positions=[];speedups=[]
            for y,dist in enumerate(DISTS):
                row=lookup[dist]
                if row["stable_semantics_match"]=="True":
                    positions.append(y+offset);speedups.append(1/float(row["median_paired_time_ratio"]))
            assert all(1/8<value<64 for value in speedups)
            ax.scatter(speedups,positions,s=6,marker=marker,color=color,lw=0,zorder=3)
        ax.set_xscale("log",base=2);plain_log(ax,"x")
        ax.set_xlim(1/8,64);ax.set_xticks([1/8,1/2,1,2,8,32])
        ax.set_ylim(len(DISTS)-.4,-.6)
        ax.set_yticks(range(len(DISTS)),[DIST_NAMES[dist] for dist in DISTS] if index%3==0 else [])
        ax.tick_params(axis="y",length=0,labelsize=6,pad=3)
        ax.tick_params(axis="x",labelsize=5.8,pad=2)
        ax.axvline(1,color="#555555",lw=.75,ls="--",zorder=2)
        ax.grid(axis="x",color="#E6E6E6",lw=.35,zorder=0)
        if index>=6:ax.set_xlabel("Block speedup (x)",fontsize=6.5)
    handles=[Line2D([],[],color=color,marker=marker,lw=0,ms=3,label=NAMES[comparator])
             for comparator,color,marker,_ in mappings]
    fig.suptitle("Block LSD speed by type and input structure",x=.20,y=.985,ha="left",fontsize=10)
    fig.text(.20,.956,"1M elements; c = 4, minimum 1 KiB/block; each point is one type and distribution",fontsize=7)
    fig.legend(handles=handles,loc="upper left",bbox_to_anchor=(.19,.942),ncol=3,frameon=False)
    fig.text(.20,.047,"Speedup = reciprocal of the median of six paired candidate/comparator time ratios. Right of 1 is faster.",fontsize=6)
    fig.text(.20,.030,"Each facet fixes one type; no range across types is drawn. Two reversed-record LSD oracle failures are omitted.",fontsize=6)
    fig.text(.20,.013,"Points summarize timings; no confidence interval or noise-based significance claim is encoded.",fontsize=6)
    save(fig,"01-algorithm-comparison")


def native_by_type(group, title, stem):
    """Fix the record type in each facet; show each input case as its own point."""
    comparisons=read("native-comparisons.csv")
    kinds=["u32","i32","f32","u64","i64","f64","u128","record32","record128"]
    fig=plt.figure(figsize=(183/25.4,280/25.4))
    grid=fig.add_gridspec(3,3,left=.20,right=.98,bottom=.09,top=.875,wspace=.24,hspace=.23)
    axes=[fig.add_subplot(grid[y,x]) for y in range(3) for x in range(3)]
    mappings=[(name,color,marker,offset) for name,color,marker,offset in zip(group,[BLUE,GREY,ORANGE],["o","s","^"],[-.23,0,.23])]
    for index,(ax,kind) in enumerate(zip(axes,kinds)):
        letter(ax,"abcdefghi"[index]);ax.set_title(kind,loc="left",pad=8)
        for comparator,color,marker,offset in mappings:
            lookup={row["dist"]:row for row in comparisons if row["kind"]==kind
                    and row["comparator"]==comparator and int(row["n"])==1048576}
            positions=[];speedups=[]
            for y,dist in enumerate(DISTS):
                row=lookup.get(dist)
                if row is not None:
                    positions.append(y+offset);speedups.append(float(row["speedup"]))
            assert all(1/8<value<64 for value in speedups)
            ax.scatter(speedups,positions,s=6,marker=marker,color=color,lw=0,zorder=3)
        ax.set_xscale("log",base=2);plain_log(ax,"x")
        ax.set_xlim(1/8,64);ax.set_xticks([1/8,1/2,1,2,8,32])
        ax.set_ylim(len(DISTS)-.4,-.6)
        ax.set_yticks(range(len(DISTS)),[DIST_NAMES[dist] for dist in DISTS] if index%3==0 else [])
        ax.tick_params(axis="y",length=0,labelsize=6,pad=3)
        ax.tick_params(axis="x",labelsize=5.8,pad=2)
        ax.axvline(1,color="#555555",lw=.75,ls="--",zorder=2)
        ax.grid(axis="x",color="#E6E6E6",lw=.35,zorder=0)
        if index>=6:ax.set_xlabel("Block speedup (x)",fontsize=6.5)
    handles=[Line2D([],[],color=color,marker=marker,lw=0,ms=3,label=NATIVE_NAMES[comparator])
             for comparator,color,marker,_ in mappings]
    fig.suptitle(title,x=.20,y=.985,ha="left",fontsize=10)
    fig.text(.20,.956,"1M elements; c = 4, minimum 1 KiB/block; each point is one type and distribution",fontsize=7)
    fig.legend(handles=handles,loc="upper left",bbox_to_anchor=(.19,.942),ncol=3,frameon=False)
    fig.text(.20,.047,"Speedup = comparator median time / Block median time. Right of 1 is faster.",fontsize=6)
    fig.text(.20,.030,"Each facet fixes one type; [U] = unstable contract. Unsupported combinations have no point.",fontsize=6)
    fig.text(.20,.013,"All 23 distributions are retained. Stability differences are not treated as equivalent output guarantees.",fontsize=6)
    save(fig,stem)


NATIVE_NAMES={"lsd_plain":"LSD [U]", "lsd_core":"LSD core [U]", "lsd_heuristic":"LSD + CS heuristic [U]", "dlsd":"DLSD [U]", "thiel":"Thiel [U]", "dedicated":"lsd_u32 / lsd_f32 [U]"}

def main():
    by_type()
    comparison()
    native_by_type(["lsd_plain","lsd_core","lsd_heuristic"], "Block LSD versus native LSD variants", "03-native-lsd-variants")
    native_by_type(["dlsd","thiel","dedicated"], "Block LSD versus other native radix variants", "04-native-radix-variants")


if __name__ == "__main__":
    main()
