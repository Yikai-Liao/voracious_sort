#!/usr/bin/env python3
"""Write the PR report from retained, audited summaries; never rerun sorting."""
import csv
import json
import math
from pathlib import Path
import statistics

ROOT = Path(__file__).resolve().parent
POLICIES = {"block_lsd":"固定 512 元素", "block_bytes":"固定 4 KiB", "block_sqrt":"空间平衡 c=1"}


def geometric(values):
    return math.exp(statistics.mean(math.log(x) for x in values))


def expanded_section():
    with (ROOT/"data/supplemental-sqrt-summary.csv").open() as f:
        data=list(csv.DictReader(f))
    for r in data:
        r["n"]=int(r["n"]);r["block"]=int(r["block"])
        for name in ["median_ns","median_peak_bytes","ratio_vs_block_fixed_512","ratio_vs_block_fixed_bytes_4096"]:r[name]=float(r[name])
    audit=json.loads((ROOT/"data/supplemental-sqrt-audit.json").read_text())
    by_key={(r["kind"],r["dist"],r["n"],r["algorithm"]):r for r in data}
    lines=["## 补测：扩大系数与块字节归一化", "",
        "初始 0.5/1/2 的系数窗口偏向空间最优点，未充分覆盖固定 512 两侧。初始公式将类型字节数放在根号内，也没有统一单块字节预算。按用户修正，完整保留初始结果，并单独冻结补测以下两类：", "",
        "- 空间平衡：`b=max(1,ceil(c*sqrt(9*n/(512*s))))`，`c=1/2/4/8/16/32/64`。",
        "- 块字节归一化：`b=max(1,floor(k*sqrt(n)/s))`，`k=1/2/4/8/16/32/64/128` 字节，先给共同预算 `B(n)=k*sqrt(n)`。", "",
        f"补测完成 {audit['input_cases']} 个输入条件、{audit['time_observations']:,} 次时间观测与 {audit['memory_observations']:,} 次内存观测。覆盖全部类型/主长度的均匀输入、额外 u64 增长长度，以及百万元素处的六种预声明压力分布。每条件同批重跑固定块策略和 LSD/Rust stable/TimSort/A/A，不混用两批时间。新系数未重跑初始全部 23 分布，具体覆盖见 README。", "",
        "百万元素时，归一化组的块字节数在所有类型上均为 1–128 KiB，已覆盖 4 KiB 两侧，无需新增实验；固定 512 元素另作对照，仅对 8 字节元素等于 4 KiB。两类范围的元素块长也均逐类型跨过 512，审计读数如下：", "",
        "| 类型 | 空间平衡：最小–最大块长 | 块字节归一化：最小–最大块长 |", "| --- | ---: | ---: |"]
    for kind,values in audit["block_ranges_at_1048576"].items():
        a,b=values["space_balanced_sqrt"],values["byte_normalized_sqrt"]
        lines.append(f"| {kind} | {a[0]}–{a[1]} | {b[0]}–{b[1]} |")
    lines += ["", "以下为补测中 1,048,576 个均匀元素的完整参数读数，单位为 `块长 / ms / MiB`。两个比较类型分列；全部九种类型见敏感性图和 CSV。", "",
        "| 策略 | u64 | record128 |", "| --- | ---: | ---: |"]
    methods=[(f"block_fixed_{b}",f"固定 {b} 元素") for b in [128,512,1024]]
    methods += [(f"block_fixed_bytes_{b}",f"固定 {b//1024} KiB") for b in [1024,4096,8192]]
    methods += [(f"block_balanced_{c}",f"空间平衡 c={c}") for c in [1,2,4,8,16,32,64]]
    methods += [(f"block_normalized_{k}",f"字节归一化 k={k}") for k in [1,2,4,8,16,32,64,128]]
    methods += [("lsd","原 LSD stable"),("std","Rust stable"),("timsort","TimSort")]
    for algorithm,name in methods:
        cells=[]
        for kind in ["u64","record128"]:
            r=by_key[kind,"uniform",1048576,algorithm]
            block=str(r["block"]) if algorithm.startswith("block_") else "—"
            cells.append(f"{block} / {r['median_ns']/1e6:.3f} / {r['median_peak_bytes']/2**20:.3f}")
        lines.append(f"| {name} | {' | '.join(cells)} |")
    equal=audit["equal_block_normalized_vs_fixed_512"]
    lines += ["",
        f"百万元素时取归一化 `k=s/2`，每种类型均恰好得到 `b=512`，与固定 512 调用同一个函数、使用同一组参数。{equal['samples']} 个配对比的中位数为 {equal['median_ratio']:.4f}，相对 1 的绝对偏差中位数 {equal['absolute_change_percent_median']:.2f}%、P95 {equal['absolute_change_percent_p95']:.2f}%。参数公式的计算均在计时之外。这项检查说明应把先前的速度差归于当时选出的块长和数据条件，不能推成增长规律必然牺牲速度。", "",
        "下面分别使用**补测同批固定 512 元素**和**固定 4 KiB**作分母。均匀列为九种类型，压力列为九种类型 × 六种分布的等权几何均值，不代表业务权重，也不作显著性检验。逐条件极值、完整范围保留在 CSV。", "",
        "| 平方根策略 | 均匀 / 512 元素 | 压力 / 512 元素 | 均匀 / 4 KiB | 压力 / 4 KiB |", "| --- | ---: | ---: | ---: | ---: |"]
    for algorithm,name in methods:
        if not algorithm.startswith(("block_balanced_","block_normalized_")):continue
        uniform=[r["ratio_vs_block_fixed_512"] for r in data if r["algorithm"]==algorithm and r["dist"]=="uniform" and r["n"]==1048576]
        stress=[r["ratio_vs_block_fixed_512"] for r in data if r["algorithm"]==algorithm and r["group"]=="stress"]
        assert len(uniform)==9 and len(stress)==54
        uniform_bytes=[r["ratio_vs_block_fixed_bytes_4096"] for r in data if r["algorithm"]==algorithm and r["dist"]=="uniform" and r["n"]==1048576]
        stress_bytes=[r["ratio_vs_block_fixed_bytes_4096"] for r in data if r["algorithm"]==algorithm and r["group"]=="stress"]
        assert len(uniform_bytes)==9 and len(stress_bytes)==54
        lines.append(f"| {name} | {geometric(uniform):.3f} | {geometric(stress):.3f} | {geometric(uniform_bytes):.3f} | {geometric(stress_bytes):.3f} |")
    lines += ["",
        f"补测全部 Block、Rust stable、TimSort 输出均通过完整 oracle，输入摘要与初始数据一致，所有 Block 分配在实现上界内。A/A 时间比中位数 {audit['aa_median_ratio']:.4f}，绝对变化中位数 {audit['aa_absolute_change_percent_median']:.2f}%、P95 {audit['aa_absolute_change_percent_p95']:.2f}%。进程 {audit['processes']} 个，失败 {audit['process_failures']}；结束时 VmSwap 最大值 {audit['max_final_process_swap_kib']} KiB，最大 RSS {audit['max_process_rss_kib']/1024:.1f} MiB。系统 swap in/out 页数 {audit['global_swap_traffic_pages']['pswpin']}/{audit['global_swap_traffic_pages']['pswpout']}，包含其他进程活动。", "",
        "大系数可能允许现有 full-scatter 路径在部分测量长度上使用接近输入大小的额外缓冲区。扩大系数后的速度必须连同实际内存读数解释，不能将这些有限长度点全部称作平方根渐近区间。完整系数没有按快慢删除，也不从同批数据选出一个普遍最优默认值。", ""]
    return lines


def main():
    with (ROOT/"data/summary.csv").open() as f:
        data = list(csv.DictReader(f))
    for r in data:
        r["n"] = int(r["n"])
        for name in ["median_ns","median_peak_bytes","ratio_vs_timsort","ratio_vs_std","ratio_vs_lsd","ratio_vs_lsd_core"]:
            r[name] = float(r[name])
    by_key = {(r["kind"],r["dist"],r["n"],r["algorithm"]):r for r in data}
    audit = json.loads((ROOT/"data/audit.json").read_text())
    manifest = json.loads((ROOT/"manifest.json").read_text())
    large = [r for r in data if r["n"] == 1048576 and r["algorithm"] == "block_lsd"]
    valid_lsd = [r["ratio_vs_lsd"] for r in large if r["pair_valid_vs_lsd"] == "True"]
    lsd_ratio = geometric(valid_lsd)
    tim_ratio = geometric([r["ratio_vs_timsort"] for r in large])
    largest_n = max(r["n"] for r in data if r["kind"] == "u64" and r["dist"] == "uniform")
    largest_peaks = {a:by_key["u64","uniform",largest_n,a]["median_peak_bytes"]/2**20
                     for a in ["block_lsd","block_sqrt","lsd","timsort"]}
    lines = ["# Block LSD PR：时间与空间测量", "",
        f"候选 `{manifest['candidate_commit'][:12]}`；上游 `{manifest['upstream_commit'][:12]}`。所有实现与二进制已冻结，测量保存在独立目录，PR 代码未改动。", "",
        f"完成 {audit['input_cases']:,} 个输入条件，{audit['time_observations']:,} 次时间观测、{audit['memory_observations']:,} 次内存观测。覆盖 9 种类型、23 种分布、主长度 128–1,048,576，另有 u64 均匀分布到 16,777,216 的增长测量。", "",
        "时间覆盖整次排序及内部内存申请/释放，输入复制和 oracle 校验在计时之外。空间指标为排序期间额外存活的请求字节峰值，不含输入缓冲区和分配器内部元数据；进程 RSS 另列，包含 harness 和校验开销。", "",
        f"本次百万元素矩阵中，固定 512 元素策略相对原 LSD stable 的配对耗时比几何均值为 **{lsd_ratio:.3f}**（{len(valid_lsd)}/{len(large)} 个语义一致条件），相对 TimSort 为 **{tim_ratio:.3f}**。总体优势仍在，但结构化输入有大幅退化；较大记录也需要区分固定元素数与固定字节数。初始空间平衡 c=1 降低空间增长；扩大系数与字节归一化结果见下文补测，速度需结合具体参数判断。", "",
        "## 主要结果", "",
        "以下为 1,048,576 元素、全部 9 种类型 × 23 种分布的等权描述汇总。每格先求同种子/顺序的时间比中位数，再对条件求几何平均；小于 1 表示 Block 更快。它不代表任何实际业务的类型或分布权重。超过 5% 的快/慢比例只是描述性阈值，不是显著性检验。", "",
        "| 预声明策略 | 时间 / TimSort 几何均值 | 时间 / Rust stable 几何均值 | 比 TimSort 快 >5% | 比 TimSort 慢 >5% |", "| --- | ---: | ---: | ---: | ---: |"]
    for a,label in POLICIES.items():
        group = [r for r in data if r["n"]==1048576 and r["algorithm"]==a]
        ratios = [r["ratio_vs_timsort"] for r in group]
        lines.append(f"| {label} | {geometric(ratios):.3f} | {geometric([r['ratio_vs_std'] for r in group]):.3f} | {sum(x<.95 for x in ratios)}/{len(group)} | {sum(x>1.05 for x in ratios)}/{len(group)} |")
    lines += ["", "不能把这些汇总表述为所有场景加速。以下保留各策略在同一主长度下相对 TimSort 的最好与最差条件，避免只报告优势分布。", "",
        "| 策略 | 最小时间比：类型 / 分布 | 最大时间比：类型 / 分布 |", "| --- | --- | --- |"]
    for a,label in POLICIES.items():
        group = [r for r in data if r["n"]==1048576 and r["algorithm"]==a]
        best = min(group,key=lambda r:r["ratio_vs_timsort"])
        worst = max(group,key=lambda r:r["ratio_vs_timsort"])
        lines.append(f"| {label} | {best['ratio_vs_timsort']:.3f}：{best['kind']} / {best['dist']} | {worst['ratio_vs_timsort']:.3f}：{worst['kind']} / {worst['dist']} |")
    lines += ["", "## 相对现有 LSD 的长度趋势", "",
        "为区分接口整体表现与无 Verge 的核心路径，下面同时列原 `lsd_stable_radixsort` 与 `lsd_radixsort_aux`。每格为配对时间比的几何均值，小于 1 表示 Block 更快；括号内为完整输出一致的条件数。这里只汇总两侧完整输出都等于稳定 oracle 的输入条件；不同列有效条件可能不同。不一致观测仍完整保留，此表也不将本来不稳定的核心接口重新声明为稳定排序。", "",
        "| 元素数 | 策略 | 时间 / 原 LSD stable API | 时间 / LSD core [U] |", "| ---: | --- | ---: | ---: |"]
    for n in manifest["primary_sizes"]:
        for a,label in POLICIES.items():
            group=[r for r in data if r["group"]=="primary" and r["n"]==n and r["algorithm"]==a]
            cells=[]
            for baseline in ["lsd","lsd_core"]:
                values=[r[f"ratio_vs_{baseline}"] for r in group if r[f"pair_valid_vs_{baseline}"]=="True"]
                cells.append(f"{geometric(values):.3f} ({len(values)}/{len(group)})" if values else "N/A")
            lines.append(f"| {n:,} | {label} | {' | '.join(cells)} |")
    lines += ["", "## 均匀输入的直接读数", "",
        "以下时间单位 ms、额外请求堆峰值单位 MiB；均为中位数。全部观测范围见 CSV 和图中误差线。此表单独列类型，避免把 32/128 字节记录与标量的内存开销混在一起。", "",
        "| 类型 | Block 512：ms / MiB | Block 4 KiB：ms / MiB | 空间平衡 c=1：ms / MiB | 原 LSD stable：ms / MiB | Rust stable：ms / MiB | TimSort：ms / MiB |", "| --- | ---: | ---: | ---: | ---: | ---: | ---: |"]
    for kind in manifest["kinds"]:
        cells=[]
        for a in list(POLICIES)+["lsd","std","timsort"]:
            r=by_key[kind,"uniform",1048576,a]
            mark=" †" if r["full_stable_output_matches"] != "True" else ""
            cells.append(f"{r['median_ns']/1e6:.3f} / {r['median_peak_bytes']/2**20:.3f}{mark}")
        lines.append("| "+kind+" | "+" | ".join(cells)+" |")
    lines += ["", "† 表示该条件至少一次未等于完整稳定 oracle；不能作为同语义比较。", "",
        "## 空间增长与参数选择", "",
        f"全部 Block 内存观测均未超过实现上界 `2*R*b*s + 9*floor(n/b) + 66*R`。在 u64 均匀分布、n≥1,048,576 的范围，平方根系数 1 策略的 log(额外请求堆) 对 log(n) 描述性斜率为 **{audit['sqrt_policy_large_u64_log_log_slope']:.3f}**；这验证本次输入范围内的增长趋势，不代替复杂度证明。", "",
        f"最大实测输入为 {largest_n:,} 个均匀 u64：固定 512 元素额外请求堆峰值 **{largest_peaks['block_lsd']:.3f} MiB**，平方根策略 **{largest_peaks['block_sqrt']:.3f} MiB**，原 LSD **{largest_peaks['lsd']:.3f} MiB**，TimSort **{largest_peaks['timsort']:.3f} MiB**。", "",
        "固定 512 元素的 scratch 随记录大小增长；固定 4 KiB 的 scratch 近似固定，但描述符随 n/b 增长；空间平衡平方根策略同时随输入长度和元素大小调整 b。初始九组数据和扩展参数均保留在 CSV；最终敏感性图采用补测的四类参数。本报告未根据同一数据挑选并宣称一个普遍最优默认值。", "",
        "## 正确性与测量边界", "",
        f"Block 全部九组参数、Rust stable、TimSort 的完整排序输出均通过 oracle；配对输入摘要一致。另有浮点特殊值的独立位序检查。现有对照共有 **{audit['comparator_failure_cases']:,} 个算法标签×输入条件**未等于稳定 oracle（含 A/A 标签），均原样保留并在图中加叉；按算法：", ""]
    for a,count in audit["comparator_failure_cases_by_algorithm"].items():
        lines.append(f"- `{a}`：{count:,}")
    lines += ["", f"所有对照的 key 次序失败条件：{audit['key_order_failure_cases']}；数据 fingerprint 失败条件：{audit['fingerprint_failure_cases']}。fingerprint 是保留检查而非无碰撞证明；候选与两个稳定比较排序使用完整逐项比较。", "",
        f"A/A 对照共有 {audit['aa_samples']:,} 个配对时间比，整体中位数 {audit['aa_median_ratio']:.4f}；相对 1 的绝对偏差中位数 {audit['aa_absolute_change_percent_median']:.2f}%，P90 {audit['aa_absolute_change_percent_p90']:.2f}%，P95 {audit['aa_absolute_change_percent_p95']:.2f}%。接近此波动量级的差异不作为稳定性能收益。", "",
        f"正式测量子进程 {audit['processes']:,} 个，退出失败 {audit['process_failures']}；各进程结束时的 VmSwap 最大值={audit['max_final_process_swap_kib']} KiB；全系统同期 swap in/out 页数 {audit['global_swap_traffic_pages']['pswpin']:,}/{audit['global_swap_traffic_pages']['pswpout']:,}。系统计数包含其他进程，不可归因于排序。最大子进程 RSS={audit['max_process_rss_kib']/1024:.1f} MiB。", "",
        "时间与内存分别测量；两批 campaign 各自在固定 guest CPU 上单线程执行，比较仅在同批内进行。独立输入预热后的批量测量不代表冷启动。TimSort 是 C++ 实现，Rust stable 是本工具链的标准库实现，编译器和 FFI 差异必须随结果说明。没有做 p 值检验，也不把最小/最大范围当作置信区间。", "",
        "A/A 按主长度分层如下，避免把极短调用中的开销和波动混入大数组的解释。A/A 同时包含方法标签分派及时间间隔的影响，是本 harness 下的变化参照。", "",
        "| 元素数 | 配对数 | 时间比中位数 | 绝对变化中位数 | 绝对变化 P95 |", "| ---: | ---: | ---: | ---: | ---: |"]
    for n, values in audit["aa_by_primary_size"].items():
        lines.append(f"| {int(n):,} | {values['samples']:,} | {values['median_ratio']:.4f} | {values['absolute_change_percent_median']:.2f}% | {values['absolute_change_percent_p95']:.2f}% |")
    lines += ["",
        "## 图与数据入口", "",
        "- [主图 PNG](figures/overview.png) / [PDF](figures/overview.pdf) / [SVG](figures/overview.svg)：u64 时间与空间增长、记录宽度影响，以及最初选择的八种分布加两种退化压力条件。压力条件在中途检查后追加展示，完整矩阵和参数保持不变。", 
        "- [扩展参数敏感性图](figures/block-policy-sensitivity.pdf)：全部九种类型，四类参数，均匀分布，1,048,576 元素。", 
        "- [平方根策略增长图](figures/sqrt-policy-scaling.pdf)：分开显示空间平衡与块字节归一化家族的时间/内存增长，代表系数在补测前确定。",
        "- [完整算法比较矩阵](figures/algorithm-comparison-1048576.pdf)：每类型一页、全部 23 种分布，包含库内适用 LSD 变体和两个稳定比较排序。", 
        "- [逐条件汇总 CSV](data/summary.csv)、[逐次时间 CSV](data/timing.csv)、[逐次内存 CSV](data/memory.csv)、[原始 JSONL 和进程记录](data/)、[验证审计](data/audit.json)。", 
        "- [方法、分布定义和重画命令](README.md)、[绘图源](plot.py)、[QA 记录](qa/)。", "",
        "图中点为中位数，时间范围为三种子×正反序的六次观测，内存范围为三次独立执行；确定性分布在不同种子下可能内容相同，不能视作独立随机数据集。矩阵省略逐格范围以保证可读，完整范围保留在 CSV。所有正式观测均保留，没有删除不利结果。", ""]
    index=lines.index("## 主要结果")
    lines[index]="## 初始完整矩阵主要结果"
    lines[index:index]=expanded_section()
    (ROOT/"REPORT.md").write_text("\n".join(lines))
    print(ROOT/"REPORT.md")


if __name__ == "__main__":
    main()
