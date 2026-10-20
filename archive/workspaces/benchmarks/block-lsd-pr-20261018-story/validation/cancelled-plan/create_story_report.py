#!/usr/bin/env python3
"""Assemble comparison-first results from the completed frozen validation."""
import csv
import json
from pathlib import Path

from evaluate import CANDIDATE

ROOT = Path(__file__).resolve().parent


def read(name):
    with (ROOT/"data"/name).open() as stream:return list(csv.DictReader(stream))


def main():
    overall=read("comparison-overall.csv")
    rank=read("validated-policy-ranking.csv")
    large=read("comparison-largest-example.csv")
    audit=json.loads((ROOT/"validation/data/audit.json").read_text())
    chosen=next(r for r in rank if r["scope"]=="all" and r["policy"]==CANDIDATE)
    cases=read("validated-policy-conditions.csv")
    observations=read("candidate-comparisons.csv")
    with (ROOT/"validation/data/summary.csv").open() as stream:
        native=list(csv.DictReader(stream))
    native_index={(r["kind"],r["dist"],int(r["n"]),r["algorithm"]):r for r in native}
    lines=[
        "# Block LSD：先比较算法，再解释自动 block 策略",
        "",
        "选定候选为 **c=4 的空间平衡平方根增长，加最小 1 KiB/block**。它只依赖输入长度和元素字节数，不识别分布。候选定义先在已封存的 109 条件中筛选，再冻结，对原有完整 1,045 条件重新计时、测量内存和核验完整稳定输出。本报告中的算法对比均使用这次验证批次；没有将两个批次的绝对耗时混合。",
        "",
        "## 1. 与其他算法比较：优势有边界",
        "",
        "[图 1 PDF](figures/01-algorithm-comparison.pdf) · [PNG](figures/01-algorithm-comparison.png) · [逐条件对比](data/candidate-comparisons.csv)",
        "",
        "1M 元素、9 类型 × 23 分布，每个条件先计算 6 个同种子/顺序的耗时比，再取中位数；下表为条件等权几何均值。少数基线完整稳定输出不等于 oracle 的条件，仅从要求同语义的比较中排除，原始记录保留。5% 胜负是描述阈值，不能当显著性判断。",
        "",
        "| 比较器 | 同语义条件数 | 候选/比较器耗时 GM | 快>5% / 慢>5% | 堆更少 / 相等 / 更多 |",
        "| --- | ---: | ---: | ---: | ---: |",
    ]
    names={"lsd":"LSD stable 接口","std":"Rust stable","timsort":"TimSort"}
    for row in overall:
        lines.append(f"| {names[row['comparator']]} | {row['conditions']} | {float(row['gm_paired_time_ratio']):.3f} | {row['faster_5pct']} / {row['slower_5pct']} | {row['less']} / {row['equal']} / {row['more']} |")
    lines += [
        "",
        "因此应把目标写成已测条件中的速度/空间取舍。额外堆更少并非每个工况都成立：对已有长有序段或仅一个元素错位的输入，run-aware 算法可能只需很少缓冲，Block 仍需按桶维护 scratch 与 descriptor。图中同时保留内存相等和更多的条件。",
        "",
        "最大 uniform u64 输入为 16,777,216 元素。同一个新批次的实际中位数如下；图 1a 同时画出全部重复范围。",
        "",
        "| 算法 | 耗时 ms | 峰值额外堆 MiB |",
        "| --- | ---: | ---: |",
    ]
    for row in large:
        label="Block 候选" if row["algorithm"]==CANDIDATE else names[row["algorithm"]]
        lines.append(f"| {label} | {float(row['median_ns'])/1e6:.2f} | {float(row['median_peak_bytes'])/2**20:.3f} |")
    lines += [
        "",
        "## 2. 为什么选它：稳健性、下限和内存一起看",
        "",
        "[图 2 PDF](figures/02-policy-selection.pdf) · [PNG](figures/02-policy-selection.png) · [全部策略排名](data/validated-policy-ranking.csv)",
        "",
        "热力图按**每个工况**归一化：先用该工况最快的已验证 finalist 参数作分母，再在标出的规模/分布组内取几何均值。行是工况组，列是策略；这对应比较同样输入下各策略的代价。没有做全局 min-max，也没有按每个算法自己的最好/最差值缩放。后两种做法会混入工况规模差异，或抹掉算法之间的绝对差距。",
        "",
        "筛选阶段保留了 c=1/2/4/8/16/32/64 的完整范围，所以 c=8 从来不是扫描上界。字节下限比较包括 1/4/8 KiB，元素下限包括 128/512/1024；所有 111 个可由同参数实测调用复用的公式都在 CSV。完整矩阵再验证 6 个参数族 finalist，以及可由这些调用精确复用的 6 个带下限公式。",
        "",
        "| 验证策略 | GM regret | P90 regret | 最坏 regret | 相对固定 4 KiB 耗时 | 最大堆 MiB |",
        "| --- | ---: | ---: | ---: | ---: | ---: |",
    ]
    # Keep all finalists in a table so a reviewer can inspect losses as well as wins.
    for row in [r for r in rank if r["scope"]=="all"]:
        label=row["policy"].replace("block_balanced_","c").replace("__floor_bytes_1024"," + min1KiB").replace("__floor_bytes_4096"," + min4KiB").replace("__floor_128"," + min128items").replace("block_fixed_bytes_1024","Fixed1KiB").replace("block_fixed_bytes_4096","Fixed4KiB").replace("block_fixed_128","Fixed128items").replace("block_normalized_2","ByteSqrt k2")
        lines.append(f"| {label} | {float(row['gm_regret']):.3f} | {float(row['p90_regret']):.3f} | {float(row['max_regret']):.3f} | {float(row['gm_time_vs_fixed_4k']):.3f} | {float(row['max_heap_bytes'])/2**20:.3f} |")
    lines += [
        "",
        f"冻结候选在完整验证的 P90 regret 为 {float(chosen['p90_regret']):.3f}，最坏为 {float(chosen['max_regret']):.3f}；{float(chosen['fraction_within_25pct_fastest'])*100:.1f}% 条件在最快 finalist 的 25% 以内。这些是有限候选间的稳健性指标，不证明连续参数最优或逐工况必胜。大输入子集（n>=262144）单列在同一排名 CSV 中，避免小数组相同叶子稀释差异。",
        "",
        "平方根来自辅助堆上界 `512*b*s+9*floor(n/b)+66*256` 的平衡。用 S=n*s、y=b*s 表示，就是 `512*y+9*S/y`；连续空间最优 y*=sqrt(9*S/512)。运行时间没有同样的严格最优证明，c=4 是计时筛出的系数。下限还能使部分小输入走 bounded scatter，不能只解释成缓存大小。",
        "",
        "## 3. 光滑曲线、固定档位与额外拟合",
        "",
        "[图 3 PDF](figures/curve-and-tier-fitting.pdf) · [PNG](figures/curve-and-tier-fitting.png) · [完整拟合报告](FIT-REPORT.md)",
        "",
        "在现有 109 条件中搜索 13,860 个自由幂律/上下限格点。较好自由目标为 `max(512/s,192*(n/2^20)^(3/8)*(s/8)^(-1/2),1)`；映射到已测块长后，样本内仅比 c4/1KiB 快约 0.3%，按完整长度留出重新拟合时反而慢约 3.3%。数据不支持为了这点差异增加选择器复杂度，或把 3/8 指数认定为真实最优。",
        "",
        "在共同有数据的 107 条件中，c4 取最近 2 次幂 KiB 档位比光滑版本平均多耗时约 5.9%；organ_pipe 上某些条件超过两倍。规整档位可以保留为候选，但不宜先验假定 1/2/4/8 KiB 最快。两个缺测条件留空，不插值；接近 KiB 但避开不利地址 stride 的档位仍是待测假设，没有混入已验证策略。",
        "",
        "## 4. 显著退化的工况是什么",
        "",
        "下面使用同批 u64、1M 的实际中位数，区分完整 LSD stable 接口与去掉 Verge 预处理的 LSD core。core 的完整语义结果同样留在数据里；这里只比较该 u64 条件输出通过的记录。",
        "",
        "| 分布 | Block ms | LSD stable ms | LSD core ms | Block / stable 配对比 |",
        "| --- | ---: | ---: | ---: | ---: |",
    ]
    for dist in ["uniform","organ_pipe","almost_sorted","push_front","push_middle","nearly_sorted"]:
        candidate=next(r for r in cases if r["policy"]==CANDIDATE and r["kind"]=="u64" and r["dist"]==dist and int(r["n"])==1048576)
        lsd=native_index["u64",dist,1048576,"lsd"]
        core=native_index["u64",dist,1048576,"lsd_core"]
        assert lsd["full_stable_output_matches"]==core["full_stable_output_matches"]=="True"
        ratio=next(r for r in observations if r["kind"]=="u64" and r["dist"]==dist and int(r["n"])==1048576 and r["comparator"]=="lsd")
        lines.append(f"| {dist} | {float(candidate['median_ns'])/1e6:.3f} | {float(lsd['median_ns'])/1e6:.3f} | {float(core['median_ns'])/1e6:.3f} | {float(ratio['median_paired_time_ratio']):.3f} |")
    lines += [
        "",
        "organ_pipe 是一个上升段和一个下降段；push_front/push_middle 只移动一个元素；almost_sorted 只做约 log2(n) 次交换。这些输入含有很长的有序段。原 LSD stable 接口先用 Verge 识别有序段，局部处理后合并；两个 run 合并时只为较短 run 分配缓冲。Block 的有序检查只会直接处理整个数组有序/反序的情况，其余输入仍需 radix 扫描、换块与压紧。因此它可能远胜纯 radix core，却输给带 run 自适应的稳定接口。TimSort 与 Rust stable 也能从输入已有结构获益。这里是调用结构和对照结果支持的解释，不是把所有损失都归因于 block 选得不对。",
        "",
        "可核对封存源码中的 [Block 入口](validation/harness/source/pr/src/sorts/block_lsd_stable_sort.rs)、[LSD stable 入口](validation/harness/source/pr/src/sorts/lsd_stable_sort.rs)、[run 合并](validation/harness/source/pr/src/algo/k_way_merge.rs) 和[输入生成器](validation/harness/src/main.rs)。",
        "",
        "2 次幂档位在 organ_pipe 上的附加损失还有 cache set 冲突假说，见拟合报告；未做 PMU 确证，和上述 run 自适应解释分开。",
        "",
        "## 测量、核验与重画",
        "",
        f"新验证保留 {audit['time_observations']:,} 个时间观测、{audit['memory_observations']:,} 个内存观测。所有 Block/Rust stable/TimSort 完整稳定输出通过，输入摘要与原批次一致，全部 Block 堆量在声明上界内。进程结束 VmSwap 最大 {audit['max_final_process_swap_kib']} KiB；进程 major fault 共 {audit['total_process_major_faults']}。全局 swap 交通另存审计，不将进程结束值误称峰值。",
        "",
        f"同批 A/A 有 {audit['aa_samples']} 个配对样本，绝对变化中位数 {audit['aa_absolute_change_percent_median']:.2f}%，P95 {audit['aa_absolute_change_percent_p95']:.2f}%。等权几何均值不是业务权重，不给 1% 以内的差异作稳定收益承诺。",
        "",
        "计时包含排序内部申请/释放内存，输入复制和 oracle 核验在计时外；策略计算也在计时外。内存是分配器请求的峰值存活额外堆字节，排除输入本体与分配器内部元数据，不能直接当进程 RSS。内存二进制与时间二进制分离，原生编译参数、源码、输入摘要、命令和每个进程的资源记录都保留。",
        "",
        "先用保存的 Python 环境运行 evaluate.py，再运行 plot_story.py 和 plot_fits.py 即可从 CSV/JSONL 重画，不需要重新排序。PDF/SVG 是可编辑分享稿，PNG 是 300 dpi 预览。全部源数据、拟合模型、未支持档位和排除条件均保留；原封存包也保持原样。",
        "",
        "[新验证审计](validation/data/audit.json) · [验证 manifest](validation/manifest.json) · [图形 QA](qa/README.md) · [原始完整数据与历史图](../block-lsd-pr-20261018/README.md)",
    ]
    (ROOT/"REPORT.md").write_text("\n".join(lines)+"\n")


if __name__=="__main__":main()
