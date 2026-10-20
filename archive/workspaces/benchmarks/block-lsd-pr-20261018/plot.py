#!/usr/bin/env python3
"""Render retained benchmark data; this script never invokes the benchmark."""
import argparse
import csv
import hashlib
import json
from pathlib import Path
import sys

import matplotlib as mpl
mpl.use("Agg")
import matplotlib.pyplot as plt
from matplotlib.backends.backend_pdf import PdfPages
from matplotlib.lines import Line2D
from matplotlib.ticker import FuncFormatter, NullFormatter
import numpy as np

ROOT = Path(__file__).resolve().parent
OUTPUT = ROOT
HELPERS = ROOT/"qa-tools"
sys.path.insert(0,str(HELPERS))
from audit_panel_alignment import require_matplotlib_panel_alignment

mpl.rcParams.update({
    "font.family":"sans-serif", "font.sans-serif":["DejaVu Sans","Arial","Helvetica"],
    "font.size":6.5,"axes.labelsize":7,"axes.titlesize":7.5,
    "xtick.labelsize":6,"ytick.labelsize":6,"legend.fontsize":6.5,
    "axes.spines.top":False,"axes.spines.right":False,"axes.linewidth":0.6,
    "xtick.major.width":0.6,"ytick.major.width":0.6,
    "svg.fonttype":"none","pdf.fonttype":42,"savefig.dpi":300,
})
POLICIES=["block_lsd","block_bytes","block_sqrt"]
KINDS=["u32","u64","u128","i32","i64","f32","f64","record32","record128"]
METHODS=["block_count_128","block_lsd","block_count_1024","block_bytes_1024","block_bytes","block_bytes_8192",
         "block_sqrt_half","block_sqrt","block_sqrt_double","lsd","lsd_plain","lsd_core","lsd_heuristic","dlsd","thiel","dedicated","std","timsort"]
DISTS=["uniform","uniform_numeric","uniform_narrow","skew95","few_unique","sqrt_keys","common_prefix","low_bits_constant","high_only","sorted","reversed","nearly_sorted","almost_sorted","reverse_nearly_sorted","all_equal","late_difference","alternating","organ_pipe","sawtooth","zipf","normal","push_front","push_middle"]
NAMES={"block_lsd":"Block: 512 items","block_bytes":"Block: 4 KiB","block_sqrt":"Block: balanced c = 1",
       "lsd":"LSD stable","std":"Rust stable","timsort":"TimSort"}
COLORS={"block_lsd":"#3776AB","block_bytes":"#D58C45","block_sqrt":"#8865A5","lsd":"#9D9D9D","std":"#484848","timsort":"#747474"}
STYLES={"block_lsd":("o","-"),"block_bytes":("s","--"),"block_sqrt":("^","-"),"lsd":("v",":"),"std":("D","--"),"timsort":("x","-.")}
DISPLAY={"record32":"Record 32 B","record128":"Record 128 B"}
DIST_LABELS={"uniform":"Uniform bits","uniform_numeric":"Uniform numeric","uniform_narrow":"Uniform narrow","skew95":"95% one key","few_unique":"16 keys","sqrt_keys":"sqrt(n) keys","common_prefix":"Common prefix","low_bits_constant":"Constant low bits","high_only":"High byte varies","sorted":"Sorted","reversed":"Reversed + ties","nearly_sorted":"1% swaps","almost_sorted":"log2(n) swaps","reverse_nearly_sorted":"Reverse + 1% swaps","all_equal":"All equal","late_difference":"Last key differs","alternating":"Alternating extremes","organ_pipe":"Organ pipe","sawtooth":"Sawtooth","zipf":"Zipf (1.2)","normal":"Normal","push_front":"One item at front","push_middle":"One item in middle"}
MATRIX_NAMES=["Block 128","Block 512","Block 1024","Block 1 KiB","Block 4 KiB","Block 8 KiB","Block sqrt x0.5","Block sqrt x1","Block sqrt x2","LSD stable","LSD [U]","LSD core [U]","LSD+CS [U]","DLSD [U]","Thiel [U]","Dedicated [U]","Rust stable","TimSort"]


def load(path=None):
    # Times and paired ratios must be strictly positive before log plotting.
    # Zero heap peaks are omitted only from logarithmic heap curves.
    result={}
    with (path or ROOT/"data/summary.csv").open() as f:
        for r in csv.DictReader(f):
            for k in ["n","block","bytes_per_record"]: r[k]=int(r[k])
            for k in list(r):
                if k in ["median_ns","min_ns","max_ns","median_peak_bytes","min_peak_bytes","max_peak_bytes"] or k.startswith("ratio_vs_"):
                    r[k]=float(r[k])
            r["valid"]=r["full_stable_output_matches"]=="True"
            assert r["n"] > 0 and r["median_ns"] > 0
            assert r["median_peak_bytes"] >= 0
            assert all(r[k] > 0 for k in r if k.startswith("ratio_vs_"))
            result[r["kind"],r["dist"],r["n"],r["algorithm"]]=r
    return result


def letter(ax,label):
    ax.annotate(label,(0,1),xycoords="axes fraction",xytext=(-17,7),textcoords="offset points",
                fontsize=9,fontweight="bold",ha="left",va="bottom",annotation_clip=False)


def save(fig,stem,exclude=()):
    fig.canvas.draw()
    report=require_matplotlib_panel_alignment(fig,json_out=OUTPUT/"qa"/(stem+".alignment.json"),
        overlay_svg=OUTPUT/"qa"/(stem+".alignment.svg"),exclude_axes=list(exclude),
        tolerance_pt=1.5,gutter_tolerance_pt=1.5,require_panel_labels=len(fig.axes)-len(exclude)>1,strict=True)
    fig.savefig(OUTPUT/"figures"/(stem+".pdf"))
    fig.savefig(OUTPUT/"figures"/(stem+".svg"))
    fig.savefig(OUTPUT/"figures"/(stem+".png"),dpi=300)
    print(stem,report["status"] if "status" in report else report.get("verdict","checked"))


def size_axis(ax):
    ax.set_xscale("log",base=2)
    ticks=[128,1024,16384,262144,4194304,16777216]
    ax.set_xticks(ticks,["128","1K","16K","256K","4M","16M"])
    # Keep corresponding time/heap axes identical when zero-heap points are absent.
    ax.set_xlim(128*.8,16777216*1.25)
    ax.set_xlabel("Number of records")
    ax.grid(axis="y",color="#E7E7E7",lw=.4,zorder=0)


def plain_log_ticks(ax,axis="y",ratio=False):
    def display(value,_):
        if value <= 0:
            return ""
        if ratio and value < 1 and np.isclose(1/value,round(1/value)):
            return f"1/{round(1/value)}"
        if value >= 1000:
            return f"{value/1000:g}k"
        if value < .001:
            return f"{value:.0e}"
        return f"{value:g}"
    for name in (["x","y"] if axis=="both" else [axis]):
        target=getattr(ax,name+"axis")
        target.set_major_formatter(FuncFormatter(display))
        target.set_minor_formatter(NullFormatter())


def overview(data):
    fig,axes=plt.subplots(2,2,figsize=(183/25.4,180/25.4))
    fig.subplots_adjust(left=.105,right=.98,bottom=.15,top=.84,wspace=.42,hspace=.67)
    methods=POLICIES+["lsd","std","timsort"]
    sizes=sorted({key[2] for key in data if key[:2]==("u64","uniform")})
    for index,metric in enumerate(["ns","peak_bytes"]):
        ax=axes[0,index]
        for a in methods:
            rows=[data["u64","uniform",n,a] for n in sizes]
            scale=1e6 if metric=="ns" else 2**20
            center=np.array([r["median_"+metric]/scale for r in rows])
            lo=np.array([r["min_"+metric]/scale for r in rows])
            hi=np.array([r["max_"+metric]/scale for r in rows])
            valid=center>0
            marker,style=STYLES[a]
            ax.plot(np.array(sizes)[valid],center[valid],marker=marker,ms=2.8,ls=style,lw=1.1,color=COLORS[a],label=NAMES[a])
            ax.fill_between(np.array(sizes)[valid],lo[valid],hi[valid],color=COLORS[a],alpha=.10,lw=0)
        size_axis(ax); ax.set_yscale("log")
        plain_log_ticks(ax)
        ax.set_ylabel("Sort time (ms)" if index==0 else "Peak extra heap (MiB)")
        ax.set_title("Uniform u64: time" if index==0 else "Uniform u64: extra heap",loc="left",pad=8)
    widths=[("u32",4),("u64",8),("u128",16),("record32",32),("record128",128)]
    ax=axes[1,0]
    for a in methods:
        rows=[data[k,"uniform",1048576,a] for k,s in widths]
        mid=np.array([r["median_peak_bytes"]/2**20 for r in rows])
        low=np.array([r["min_peak_bytes"]/2**20 for r in rows])
        high=np.array([r["max_peak_bytes"]/2**20 for r in rows])
        marker,style=STYLES[a]
        ax.errorbar([s for k,s in widths],mid,yerr=[mid-low,high-mid],color=COLORS[a],marker=marker,ms=3,lw=1,ls=style,capsize=1.5)
    ax.set_xscale("log",base=2);ax.set_yscale("log")
    plain_log_ticks(ax)
    ax.set_xticks([s for k,s in widths],["u32","u64","u128","Rec32","Rec128"])
    ax.set_xlabel("Record type (4, 8, 16, 32, 128 bytes)")
    ax.set_ylabel("Peak extra heap (MiB)")
    ax.set_title("Record width: 1,048,576 uniform records",loc="left",pad=8)
    ax.grid(axis="y",color="#E7E7E7",lw=.4)
    ax=axes[1,1]
    # Preserve the initial eight; add two adverse structured-input examples
    # identified during the campaign. The complete 23-condition matrix is retained.
    selected=["uniform","skew95","common_prefix","sorted","reversed","nearly_sorted","few_unique","normal","organ_pipe","push_front"]
    for j,a in enumerate(POLICIES+["lsd","std"]):
        rows=[data["u64",d,1048576,a] for d in selected]
        y=np.array([r["ratio_vs_timsort"] for r in rows])
        lo=np.array([r["ratio_vs_timsort_min"] for r in rows]);hi=np.array([r["ratio_vs_timsort_max"] for r in rows])
        marker,_=STYLES[a]
        ax.errorbar(np.arange(len(selected))+(j-2)*.14,y,yerr=[y-lo,hi-y],ls="none",marker=marker,ms=2.6,color=COLORS[a],lw=.6,capsize=1)
    ax.axhline(1,color="#999999",ls="--",lw=.6,zorder=0)
    ax.set_yscale("log",base=2)
    plain_log_ticks(ax,ratio=True)
    ax.set_xticks(range(len(selected)),[DIST_LABELS[d] for d in selected],rotation=90,ha="right",va="center",rotation_mode="anchor")
    ax.set_ylabel("Time / TimSort (lower is faster)")
    ax.set_title("Distribution: 1,048,576 u64 records",loc="left",pad=8)
    for ax,label in zip(axes.flat,"abcd"):letter(ax,label)
    handles=[Line2D([],[],color=COLORS[a],marker=STYLES[a][0],ls=STYLES[a][1],lw=1,ms=3,label=NAMES[a]) for a in methods]
    fig.legend(handles=handles,loc="upper center",bbox_to_anchor=(.54,.97),ncol=3,columnspacing=1.8,frameon=False)
    fig.text(.105,.025,"For u64, 512 items = 4 KiB (identical parameters). Bands/bars: full observed range.",fontsize=6)
    save(fig,"overview")
    plt.close(fig)


def parameters(data):
    fig,axes=plt.subplots(3,3,figsize=(183/25.4,180/25.4))
    fig.subplots_adjust(left=.11,right=.98,bottom=.11,top=.82,wspace=.40,hspace=.60)
    families=[
        ([f"block_fixed_{b}" for b in [128,512,1024]],"#3776AB","Fixed items: 128 / 512 / 1024"),
        ([f"block_fixed_bytes_{b}" for b in [1024,4096,8192]],"#D58C45","Fixed bytes: 1 / 4 / 8 KiB"),
        ([f"block_balanced_{c}" for c in [1,2,4,8,16,32,64]],"#8865A5","Space-balanced: c = 1 to 64"),
        ([f"block_normalized_{k}" for k in [1,2,4,8,16,32,64,128]],"#328C7D","Byte-normalized: k = 1 to 128")]
    for ax,kind,label in zip(axes.flat,KINDS,"abcdefghi"):
        for (family,color,_),style in zip(families,["-","--","-.",":"]):
            points=[data[kind,"uniform",1048576,a] for a in family]
            x=np.array([p["median_peak_bytes"]/2**20 for p in points]);y=np.array([p["median_ns"]/1e6 for p in points])
            ax.plot(x,y,color=color,lw=.7,ls=style,alpha=.7)
            for i,p in enumerate(points):
                block_bytes=p["block"]*p["bytes_per_record"]
                marker="o" if block_bytes<4096 else "s" if block_bytes==4096 else "^"
                ax.errorbar(x[i],y[i],yerr=[[y[i]-p["min_ns"]/1e6],[p["max_ns"]/1e6-y[i]]],
                    xerr=[[x[i]-p["min_peak_bytes"]/2**20],[p["max_peak_bytes"]/2**20-x[i]]],
                    color=color,marker=marker,ms=3.2,lw=.6,capsize=1)
        for a in ["std","timsort"]:
            p=data[kind,"uniform",1048576,a]
            x=p["median_peak_bytes"]/2**20;y=p["median_ns"]/1e6
            ax.errorbar(x,y,xerr=[[x-p["min_peak_bytes"]/2**20],[p["max_peak_bytes"]/2**20-x]],
                yerr=[[y-p["min_ns"]/1e6],[p["max_ns"]/1e6-y]],
                marker="x" if a=="timsort" else "D",ms=3,color=COLORS[a],ls="none",lw=.6,capsize=1)
        ax.set_xscale("log");ax.set_yscale("log")
        plain_log_ticks(ax,axis="both")
        ax.set_title(DISPLAY.get(kind,kind),loc="left",pad=8)
        ax.grid(color="#E9E9E9",lw=.4)
        letter(ax,label)
    handles=[Line2D([],[],color=color,lw=1,ls=style,label=name)
             for (_,color,name),style in zip(families,["-","--","-.",":"])]
    handles += [Line2D([],[],color=COLORS[a],ls="none",marker="x" if a=="timsort" else "D",ms=3,label=NAMES[a]) for a in ["std","timsort"]]
    fig.legend(handles=handles,loc="upper center",bbox_to_anchor=(.53,.99),ncol=2,frameon=False,columnspacing=2)
    fig.text(.11,.875,"Block bytes: circle < 4 KiB; square = 4 KiB; triangle > 4 KiB. Bars: full observed range.",fontsize=6)
    fig.text(.11,.055,"At this n, normalized k = 1 / 4 / 8 equals fixed 1 / 4 / 8 KiB.",fontsize=6)
    fig.supxlabel("Peak extra requested heap (MiB)",fontsize=7,y=.015)
    fig.supylabel("Sort time (ms); uniform inputs, 1,048,576 records",fontsize=7,x=.012)
    save(fig,"block-policy-sensitivity")
    plt.close(fig)


def sqrt_scaling(data):
    fig,axes=plt.subplots(2,2,figsize=(183/25.4,180/25.4))
    fig.subplots_adjust(left=.105,right=.98,bottom=.14,top=.84,wspace=.42,hspace=.80)
    families=[
        ("Space-balanced",[(f"block_balanced_{c}",f"Balanced c = {c}",color,marker,style)
            for c,color,marker,style in zip([1,8,16,64],["#AA9DB9","#8865A5","#6E4C91","#44295E"],["o","s","^","d"],[":","-","--","-."])]),
        ("Byte-normalized",[(f"block_normalized_{k}",f"Normalized k = {k}",color,marker,style)
            for k,color,marker,style in zip([1,4,16,128],["#86B7AD","#328C7D","#236C60","#174E45"],["o","s","^","d"],[":","-","--","-."])])]
    sizes=sorted({key[2] for key in data if key[:2]==("u64","uniform")})
    for row,(family,policies) in enumerate(families):
        methods=policies+[
            ("block_fixed_512","Block: 512 items",COLORS["block_lsd"],"D","-"),
            ("lsd","LSD stable",COLORS["lsd"],"v","-.")]
        for column,metric in enumerate(["ns","peak_bytes"]):
            ax=axes[row,column]
            for algorithm,name,color,marker,style in methods:
                points=[data["u64","uniform",n,algorithm] for n in sizes]
                scale=1e6 if metric=="ns" else 2**20
                mid=np.array([r["median_"+metric]/scale for r in points])
                low=np.array([r["min_"+metric]/scale for r in points])
                high=np.array([r["max_"+metric]/scale for r in points])
                positive=mid>0
                ax.plot(np.array(sizes)[positive],mid[positive],color=color,marker=marker,
                    ms=2.8,lw=1,ls=style,label=name)
                ax.fill_between(np.array(sizes)[positive],low[positive],high[positive],
                    color=color,alpha=.10,lw=0)
            size_axis(ax);ax.set_yscale("log");plain_log_ticks(ax)
            ax.set_ylabel("Sort time (ms)" if metric=="ns" else "Peak extra heap (MiB)")
            ax.set_title(family+(": time" if metric=="ns" else ": extra heap"),loc="left",pad=8)
            letter(ax,"abcd"[row*2+column])
        handles=[Line2D([],[],color=color,marker=marker,ls=style,lw=1,ms=3,label=name)
                 for _,name,color,marker,style in methods]
        fig.legend(handles=handles,loc="upper center",bbox_to_anchor=(.54,.985 if row==0 else .50),
            ncol=3,frameon=False,columnspacing=1.5)
    fig.text(.105,.070,"Balanced: b = ceil(c sqrt(9n / (512s))). Normalized: b = floor(k sqrt(n) / s).",fontsize=6)
    fig.text(.105,.047,"Both clamp b to at least 1. Uniform u64; s = 8 bytes. Representatives fixed before the supplement.",fontsize=6)
    fig.text(.105,.024,"Bands: full observed range (six time / three heap measurements). All coefficients remain in CSV.",fontsize=6)
    save(fig,"sqrt-policy-scaling")
    plt.close(fig)


def matrices(data,n):
    stem=f"algorithm-comparison-{n}"
    with PdfPages(OUTPUT/"figures"/(stem+".pdf")) as pdf:
        for kind in KINDS:
            fig,ax=plt.subplots(figsize=(183/25.4,160/25.4))
            fig.subplots_adjust(left=.225,right=.985,bottom=.29,top=.88)
            values=np.full((len(DISTS),len(METHODS)),np.nan)
            invalid=[]
            for i,d in enumerate(DISTS):
                for j,a in enumerate(METHODS):
                    if (kind,d,n,a) in data:
                        row=data[kind,d,n,a]
                        assert row["ratio_vs_timsort"]>0
                        values[i,j]=np.log2(row["ratio_vs_timsort"])
                        if not row["valid"]: invalid.append((j,i))
            cmap=mpl.colormaps["RdBu_r"].copy();cmap.set_bad("#E8E8E8")
            im=ax.imshow(np.ma.masked_invalid(values),vmin=-3,vmax=3,cmap=cmap,aspect="auto",interpolation="nearest")
            ax.set_xticks(range(len(METHODS)),MATRIX_NAMES,rotation=90,ha="right",va="center",rotation_mode="anchor",fontsize=6)
            ax.set_yticks(range(len(DISTS)),[DIST_LABELS[d] for d in DISTS],fontsize=6.5)
            ax.tick_params(length=0,pad=3)
            if invalid:
                cross_colors=["white" if abs(values[i,j])>=1.5 else "#202020" for j,i in invalid]
                ax.scatter(*zip(*invalid),marker="x",s=15,linewidths=.6,color=cross_colors)
            for i,j in zip(*np.where(np.isnan(values))):ax.text(j,i,"N/A",ha="center",va="center",fontsize=5.2,color="#666666")
            ax.set_title(f"{DISPLAY.get(kind,kind)} | {n:,} records",loc="left",fontsize=9,pad=13)
            fig.text(.225,.955,"Initial campaign: paired time / TimSort; six measurements per cell",fontsize=7)
            fig.text(.225,.145,"Cross: output differs from stable oracle. [U]: unstable contract. N/A: unsupported.",fontsize=6)
            cax=fig.add_axes([.32,.065,.55,.018])
            colorbar=fig.colorbar(im,cax=cax,orientation="horizontal",ticks=[-3,-2,-1,0,1,2,3],extend="both")
            colorbar.ax.set_xticklabels(["1/8","1/4","1/2","1","2","4","8"])
            colorbar.set_label("Relative time (blue faster; red slower; colour clipped at 1/8 and 8)",fontsize=6.5)
            fig.canvas.draw()
            require_matplotlib_panel_alignment(fig,json_out=OUTPUT/"qa"/(stem+"-"+kind+".alignment.json"),exclude_axes=[cax],strict=True)
            pdf.savefig(fig)
            fig.savefig(OUTPUT/"figures"/(stem+"-"+kind+".svg"))
            fig.savefig(OUTPUT/"figures"/(stem+"-"+kind+".png"),dpi=300)
            plt.close(fig)
    print(stem,"9 pages")


def main():
    global OUTPUT
    parser=argparse.ArgumentParser()
    parser.add_argument("--matrix-n",type=int,default=1048576)
    parser.add_argument("--output-dir",type=Path,default=ROOT,help="Destination for figures/ and qa/; input CSV remains in the frozen bundle")
    args=parser.parse_args()
    OUTPUT=args.output_dir.resolve()
    (OUTPUT/"figures").mkdir(parents=True,exist_ok=True)
    (OUTPUT/"qa").mkdir(parents=True,exist_ok=True)
    data=load()
    supplement=load(ROOT/"data/supplemental-sqrt-summary.csv")
    overview(data);parameters(supplement);sqrt_scaling(supplement);matrices(data,args.matrix_n)
    (OUTPUT/"qa/render-provenance.json").write_text(json.dumps({
        "source_bundle":str(ROOT),"matrix_n":args.matrix_n,
        "summary_csv_sha256":hashlib.sha256((ROOT/"data/summary.csv").read_bytes()).hexdigest(),
        "plot_source_sha256":hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
        "supplemental_summary_sha256":hashlib.sha256((ROOT/"data/supplemental-sqrt-summary.csv").read_bytes()).hexdigest(),
        "runtime":{"python":sys.version,"matplotlib":mpl.__version__,"numpy":np.__version__},
    },indent=2)+"\n")


if __name__=="__main__":main()
