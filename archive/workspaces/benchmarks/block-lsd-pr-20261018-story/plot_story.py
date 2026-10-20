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
NAMES = {CANDIDATE:"Block candidate", "lsd":"LSD stable", "std":"Rust stable", "timsort":"TimSort"}
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
    fig.text(.17,.948,"Candidate: c = 4, minimum 1 KiB per block; equal measured calls are reused",fontsize=7.5)
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
    fig.text(.17,.043,"1M: LSD has 205 valid cases; Rust stable and TimSort have 207. Two reversed-record LSD oracle failures are excluded.",fontsize=6)
    fig.text(.17,.024,"a: same-campaign medians and full timing ranges. Individual types and distributions are shown in Figure 1.",fontsize=6)
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


def policies():
    matrix=read("policy-strata-matrix.csv")
    rows=list(dict.fromkeys(r["stratum"] for r in matrix))
    cols=["block_fixed_128","block_fixed_bytes_1024","block_fixed_bytes_4096","block_normalized_2",
          "block_balanced_4","block_balanced_8","block_balanced_4__floor_128",
          "block_balanced_4__floor_bytes_4096","block_balanced_8__floor_bytes_1024",CANDIDATE]
    labels=["128 items","1 KiB","4 KiB","Byte sqrt k2","Balanced c4","Balanced c8",
            "c4 + min 128 items","c4 + min 4 KiB","c8 + min 1 KiB","c4 + min 1 KiB"]
    index={(r["stratum"],r["policy"]):r for r in matrix}
    values=np.array([[float(index[row,col]["gm_regret"]) for col in cols] for row in rows])
    assert np.all(values>=1-1e-12)
    fig=plt.figure(figsize=(183/25.4,205/25.4))
    grid=fig.add_gridspec(2,2,left=.17,right=.90,bottom=.19,top=.87,
                         height_ratios=[1.45,1],hspace=1.08,wspace=.54)
    a=fig.add_subplot(grid[0,:]);b=fig.add_subplot(grid[1,0]);c=fig.add_subplot(grid[1,1])
    for ax,label in zip([a,b,c],"abc"):letter(ax,label)
    fig.suptitle("Selecting one block policy across workloads",x=.17,y=.985,ha="left",fontsize=10)
    fig.text(.17,.950,"Completed 109-condition screen: exact measured calls; 10 representative policies shown from 111 formulas.",fontsize=7)
    norm=LogNorm(vmin=1,vmax=max(1.5,float(values.max())))
    im=a.imshow(values,cmap="Blues",norm=norm,aspect="auto",interpolation="nearest")
    for y in range(values.shape[0]):
        for x in range(values.shape[1]):
            a.text(x,y,f"{values[y,x]:.2f}",ha="center",va="center",fontsize=6,
                   color="white" if norm(values[y,x])>.62 else "#333333")
    a.add_patch(Rectangle((len(cols)-1-.5,-.5),1,len(rows),fill=False,ec=BLUE,lw=1.5,clip_on=False))
    a.set_xticks(range(len(cols)),labels,rotation=90,ha="right",va="center",rotation_mode="anchor")
    count=[int(index[row,cols[0]]["conditions"]) for row in rows]
    short=[r.replace("n=128","128 items").replace("n=1024","1K items").replace("n=16384","16K items").replace("n=262144","256K items").replace("n=1048576","1M items").replace("skew95 @1M","95% one key").replace("common_prefix @1M","Common prefix").replace("nearly_sorted @1M","1% swaps").replace("normal @1M","Normal").replace("organ_pipe @1M","Organ pipe").replace("push_front @1M","One item at front") for r in rows]
    a.set_yticks(range(len(rows)),[f"{name} (n={num})" for name,num in zip(short,count)])
    a.set_title("Per workload: time / fastest tested Block, then GM within each row",loc="left",pad=10)
    a.tick_params(axis="both",length=0)
    for tick in a.get_xticklabels()[-1:]:tick.set_color(BLUE);tick.set_fontweight("bold")
    cax=fig.add_axes([.915,a.get_position().y0,.014,a.get_position().height])
    cb=fig.colorbar(im,cax=cax);cb.set_label("Time ratio",fontsize=6)
    ticks=[v for v in [1,1.1,1.25,1.5,2,3,4,6,8] if v<=norm.vmax]
    cb.set_ticks(ticks,labels=[f"{v:g}" for v in ticks]);cb.ax.tick_params(labelsize=6);cb.minorticks_off()

    ranking=read("policy-floor-screen-ranking.csv")
    ranked={r["policy"]:r for r in ranking}
    curves=[("none","No floor",GREY,"-"),("bytes_1024","Min 1 KiB",BLUE,"-"),
            ("128","Min 128 items",ORANGE,"--"),("bytes_4096","Min 4 KiB","#9676A1",":")]
    coeffs=[1,2,4,8,16,32,64]
    for floor,label,color,style in curves:
        names=[f"block_balanced_{v}"+("" if floor=="none" else "__floor_"+floor) for v in coeffs]
        vals=[float(ranked[name]["p90_regret"]) for name in names]
        assert all(v>=1 for v in vals)
        b.plot(coeffs,vals,"o",ms=3,color=color,ls=style,lw=1,label=label)
    b.set_xscale("log",base=2);b.set_xticks(coeffs,[str(v) for v in coeffs])
    b.set_xlabel("Space-balanced coefficient c");b.set_ylabel("P90 time / fastest tested Block")
    b.set_title("Best measured c is inside the scan",loc="left",pad=9)
    b.grid(axis="y",color="#E7E7E7",lw=.4)
    b.legend(loc="upper left",bbox_to_anchor=(-.10,-.33),ncol=2,frameon=False,columnspacing=1,handlelength=1.5,fontsize=6)

    detailed=read("policy-floor-screen-conditions.csv")
    grouped={}
    for row in detailed:
        if int(row["n"])==1048576:
            grouped.setdefault(row["policy"],[]).append(row)
    points={}
    for policy,group in grouped.items():
        assert len(group)==63
        heap=np.array([float(r["median_peak_bytes"])/(int(r["n"])*int(r["record_bytes"])) for r in group])
        regret=np.array([float(r["regret"]) for r in group])
        assert np.all(heap>0) and np.all(regret>0)
        points[policy]=(float(np.exp(np.mean(np.log(heap))))*100,float(np.quantile(regret,.9)))
    all_points=np.array(list(points.values()))
    c.scatter(all_points[:,0],all_points[:,1],s=9,color="#BBBBBB",alpha=.75,lw=0)
    for policy,label,color,marker in [(CANDIDATE,"c4 + min 1 KiB",BLUE,"o"),
                                      ("block_balanced_8","c8, no floor","#9676A1","^"),
                                      ("block_fixed_bytes_1024","Fixed 1 KiB",ORANGE,"s"),
                                      ("block_fixed_bytes_4096","Fixed 4 KiB",GREY,"D")]:
        x,y=points[policy];c.scatter([x],[y],s=23,color=color,marker=marker,edgecolor="white",lw=.4,label=label)
    c.set_xscale("log");plain_log(c,"x")
    c.set_xlabel("GM extra heap / input (%)");c.set_ylabel("P90 time / fastest tested Block")
    c.set_title("Time / heap tradeoff: 1M screen",loc="left",pad=9)
    c.grid(axis="y",color="#E7E7E7",lw=.4)
    c.legend(loc="upper left",bbox_to_anchor=(-.08,-.33),ncol=2,frameon=False,columnspacing=1,handlelength=1,fontsize=6)
    fig.text(.17,.065,"a: 109 measured conditions; parenthetical n counts workloads. Rows overlap. All 111 formulas remain in CSV.",fontsize=6)
    fig.text(.17,.043,"b: 109 screening conditions. c: all 111 formulas, same 63 large conditions; smaller and lower is better.",fontsize=6)
    fig.text(.17,.021,"P90 and GM are descriptive across conditions; no population confidence interval or unique universal optimum is claimed.",fontsize=6)
    save(fig,"02-policy-selection",exclude=[cax])


def main():
    (ROOT/"figures").mkdir(exist_ok=True);(ROOT/"qa").mkdir(exist_ok=True)
    provenance=json.loads((ROOT/"data/evaluation-provenance.json").read_text())
    for source,digest in provenance["source_sha256"].items():
        assert hashlib.sha256((ROOT/source).read_bytes()).hexdigest()==digest,source
    by_type();comparison();policies()
    files=[Path(__file__),ROOT/"data/evaluation-provenance.json"]+list((ROOT/"data").glob("comparison-*.csv"))
    files += [ROOT/"data/policy-strata-matrix.csv",ROOT/"data/policy-floor-screen-ranking.csv",ROOT/"data/policy-floor-screen-conditions.csv"]
    (ROOT/"qa/story-render-provenance.json").write_text(json.dumps({str(p.relative_to(ROOT)):hashlib.sha256(p.read_bytes()).hexdigest() for p in files},indent=2)+"\n")


if __name__=="__main__":main()
