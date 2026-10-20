#!/usr/bin/env python3
"""Explain the final comparison-first figures and explicit data reuse."""
import csv
import json
from pathlib import Path

from evaluate_reuse import CANDIDATE

ROOT=Path(__file__).resolve().parent


def read(name):
    with (ROOT/"data"/name).open() as stream:
        return list(csv.DictReader(stream))


def main():
    audit=json.loads((ROOT/"data/reuse-audit.json").read_text())
    overall=read("comparison-overall.csv")
    ranking=read("policy-floor-screen-ranking.csv")
    selected=next(row for row in ranking if row["policy"]==CANDIDATE)
    conditions=read("validated-policy-conditions.csv")
    old={(r["kind"],r["dist"],int(r["n"]),r["algorithm"]):r for r in read("summary.csv")}
    names={"lsd":"LSD stable","std":"Rust stable","timsort":"TimSort",CANDIDATE:"Block 候选"}
    lines=[
        "# Block LSD：先比较算法，再解释自动 block 策略", "",
        "候选为 **c=4 的空间平衡平方根增长，加最小 1 KiB/block**。它只依赖输入长度 n 和元素字节数 s，不识别分布。先用已完成的 109 条件、111 个原始/带下限公式筛选，再复用完整矩阵中的相同实际参数，补齐真正缺失的候选调用。这里的结论限于已测输入和有限参数族，不宣称唯一通用最优。", "",
        "```text", "b = max(1, ceil(4*sqrt(9*n/(512*s))), floor(1024/s))", "```", "",
        "## 1. 与其他排序算法比较", "",
        "[图 1 PDF](figures/01-algorithm-comparison.pdf) · [PNG](figures/01-algorithm-comparison.png) · [逐条件对比](data/candidate-comparisons.csv)", "",
        "1M 元素、9 类型 × 23 分布。每个条件的耗时比始终在同一批次内按种子/顺序配对，再取六对的中位数；下表对条件等权取几何均值。不同批次只汇总无量纲配对比，不拼接绝对时间计算收益。LSD stable 的 reversed record32/record128 完整稳定输出不同于 oracle，故其同语义比较为 205 条，其余比较器均为 207 条；失败原始记录保留。", "",
        "撤去 5% 胜负阈值：它与观测波动同量级，不能据此宣称可靠收益。下表改列较大效应的数量，T 表示候选时间、B 表示对照时间；T≤2B/3 对应至少 1.5 倍速，T≤B/2 对应至少 2 倍速。这些仍是效应描述，不是显著性门槛。", "",
        "| 比较器 | 条件数 | T/B 耗时 GM | T≤2B/3 / T≥1.5B | T≤B/2 / T≥2B | 堆更少 / 相等 / 更多 |",
        "| --- | ---: | ---: | ---: | ---: | ---: |",
    ]
    for row in overall:
        lines.append(f"| {names[row['comparator']]} | {row['conditions']} | {float(row['gm_paired_time_ratio']):.3f} | {row['faster_1_5x']} / {row['slower_1_5x']} | {row['faster_2x']} / {row['slower_2x']} | {row['less']} / {row['equal']} / {row['more']} |")
    noise=audit["aa_for_1m_lsd_compared_conditions"]
    guarded=audit["large_effect_aa_screen_1m_lsd"]
    lines += ["",f"噪声对照：全部规模的各批 A/A 绝对变化中位数约 5.0%–5.5%，P95 为 28.9%–31.7%。只看本图中有同批 A/A 的 {guarded['assessable']} 个 1M/LSD 工况（{noise['observations']} 次 A/A），对应中位数为 {noise['absolute_change_percent_median']:.2f}%，P95 为 {noise['absolute_change_percent_p95']:.2f}%；不能把全尺度波动直接当成某一工况的误差条。", "",
              f"额外保守筛选逐工况比较：令 k 为该工况六次 A/A 的最大对称倍数 max(AA,1/AA)。要求候选中位数至少 1.5 倍速，且六次候选/对照配对比全部小于 1/k；{guarded['large_gain_beyond_observed_envelope']} 个工况通过。相反方向采用六次都大于 k 且中位数慢至少 1.5 倍，{guarded['large_loss_beyond_observed_envelope']} 个通过。另 {guarded['not_assessable']} 个没有同批 A/A，单列为不能评估，未补测。这个筛选只说明效应超过已观察波动，不给总体显著性保证；确定性输入重复、有限种子和条件选择仍限制外推。"]
    lines += ["", "图 1 的九个面板分别固定一种类型，纵轴为 23 种输入分布，横轴为 Block 的加速倍数：六次同批候选/比较器配对耗时比的中位数取倒数。1 右侧更快，左侧更慢；颜色和点形只区分比较器。没有跨类型均值或范围，没有把类型差异画成误差条。两项 LSD reversed-record 稳定输出不匹配，省略相应点并保留失败记录。", "",
              "TimSort 的类型差异很大，例如 uniform 的候选/TimSort 比值为 f32 的 0.039 与 record128 的 0.737，分别约 25.4 倍速与 1.36 倍速。它们是不同数据表示的相对性能，不能解释为重复测试方差。宽键和宽记录的 radix 处理与搬运成本不同；浮点比较还需键转换。未对这些成本做独立消融，因此只把它们列为代码支持的可能因素，不宣称确定贡献。", "",
              "内存优势有边界：已有长有序段或仅一个元素错位时，run 自适应算法可能只需很少缓冲，Block 仍需 scratch 与 descriptor。图中保留相等和更多的条件。空间指标是分配器请求的峰值存活额外堆，排除输入和分配器内部元数据，不能当作 RSS。", "",
              "[效率总览 PDF](figures/01b-efficiency-overview.pdf) 将空间和总体速度分布单独展示。1b-a 使用同一个已完成批次的 16,777,216 元素 uniform u64；1b-b 为上表的内存条件计数；1b-c 是逐工况配对中位数的经验分布，每条曲线的全部条件等权，不是重复计时的方差。其总体汇总不取代图 1 的逐类型明细。图法依据与具体论文图例见[调研](VISUALIZATION-RESEARCH.md)。", "",
              "16M uniform u64 的实际代价：", "",
              "| 算法 | 耗时 ms | 峰值额外堆 MiB |", "| --- | ---: | ---: |"]
    for row in read("comparison-largest-example.csv"):
        lines.append(f"| {names[row['algorithm']]} | {float(row['median_ns'])/1e6:.2f} | {float(row['median_peak_bytes'])/2**20:.3f} |")
    lines += ["", "## 2. 为什么选这个 block 策略", "",
              "[图 2 PDF](figures/02-policy-selection.pdf) · [PNG](figures/02-policy-selection.png) · [全部 111 公式排名](data/policy-floor-screen-ranking.csv)", "",
              "策略筛选直接使用已完成的 109 条件扫描，含全部 9 类型的 uniform 多规模数据、1M 的六类压力输入，以及额外 u64 增长规模。它不是所有类型、规模、分布的完全交叉矩阵。图 2a 按每个工况除以最快已测 Block 参数，再在标出的组内取几何均值；这是比较相同输入下的策略代价，不做全局 min-max 或按算法自行缩放。", "",
              "c 已扫描 1/2/4/8/16/32/64，c=8 不是上界。比较了最小 128/512/1024 元素和最小 1/4/8 KiB。带下限公式的实际 block 始终等于根号策略或固定策略的一个已有参数，不产生新的组合调用。相同有效参数在同一批次内合并观测；n<=128 的相同稳定比较叶子单独识别。", "",
              "| 策略 | GM regret | P90 regret | 最坏 regret | 相对固定 4 KiB 耗时 | 最大堆 MiB |",
              "| --- | ---: | ---: | ---: | ---: | ---: |"]
    shown=[CANDIDATE,"block_balanced_8__floor_bytes_1024","block_balanced_4","block_balanced_8","block_fixed_128","block_fixed_bytes_1024","block_fixed_bytes_4096","block_normalized_2"]
    by_policy={row["policy"]:row for row in ranking}
    for policy in shown:
        row=by_policy[policy]
        label=policy.replace("block_balanced_","c").replace("__floor_bytes_1024"," + min1KiB").replace("block_fixed_128","Fixed128items").replace("block_fixed_bytes_1024","Fixed1KiB").replace("block_fixed_bytes_4096","Fixed4KiB").replace("block_normalized_2","ByteSqrt k2")
        lines.append(f"| {label} | {float(row['gm_regret']):.3f} | {float(row['p90_regret']):.3f} | {float(row['max_regret']):.3f} | {float(row['gm_time_vs_fixed_4k']):.3f} | {float(row['max_heap_bytes'])/2**20:.3f} |")
    lines += ["", f"候选的筛选 P90 regret 为 {float(selected['p90_regret']):.3f}，最坏为 {float(selected['max_regret']):.3f}；{float(selected['fraction_within_25pct_fastest'])*100:.1f}% 条件在最快已测参数的 25% 以内。这是有限扫描中的稳健折中，并非连续参数最优的证明。图 2b 检查系数位置和下限效果，2c 同时显示时间尾部与内存取舍。", "",
              "平方根的数学依据来自辅助堆上界 `512*b*s+9*floor(n/b)+66*256`。令 S=n*s、y=b*s，忽略取整后平衡 `512*y+9*S/y`，得到 y*=sqrt(9*S/512)。这是空间模型的最优；速度系数 c 仍由计时筛选。1 KiB 下限还会让部分小输入切换到 bounded scatter，不能只解释为缓存容量。", "",
              "c4 与 c8 加相同 1 KiB 下限后的耗时差不足以认定稳定速度胜负；选择 c4 的主要额外理由是所测最大堆约 3.20 MiB，相比 c8 的 6.11 MiB 更少。图中的 P90 和样本内排名用于寻找折中，不能越过 A/A 波动限制宣称唯一最快。", "",
              "## 3. 拟合曲线与固定档位", "",
              "[图 3 PDF](figures/curve-and-tier-fitting.pdf) · [PNG](figures/curve-and-tier-fitting.png) · [完整拟合报告](FIT-REPORT.md)", "",
              "13,860 个自由幂律/上下限格点中，较好目标为 `max(512/s,192*(n/2^20)^(3/8)*(s/8)^(-1/2),1)`。映射到已经实测的块长后，样本内仅比 c4/1KiB 快约 0.3%；按完整长度留出重新拟合后反而慢约 3.3%。连续公式的新块长没有直接计时，不能把映射结果当作它的实测速度。", "",
              "共同有数据的 107 条件中，向下/最近/向上取 2 次幂档位平均多耗时约 5.9%/5.9%/8.6%，organ_pipe 上部分条件超过两倍。两个缺测条件明确列出，现有证据不支持为规整档位补全整轮测试。近似 KiB、避开不利地址 stride 的档位仍是待测假说。", "",
              "## 4. 显著退化为什么发生", "",
              "候选在 u64、1M 的逐条件配对比（小于 1 为更快）：", "",
              "| 分布 | 候选 / LSD stable | 时间来源 |", "| --- | ---: | --- |"]
    for dist in ["uniform","organ_pipe","almost_sorted","push_front","push_middle","nearly_sorted"]:
        row=next(r for r in conditions if r["kind"]=="u64" and r["dist"]==dist and int(r["n"])==1048576)
        lines.append(f"| {dist} | {float(row['ratio_vs_lsd']):.3f} | {row['time_source']} |")
    lines += ["", "原有完整矩阵还提供同批的固定 4 KiB Block、LSD stable 和去掉 Verge 预处理的 LSD core。下表用来区分 run 自适应接口与纯 radix 核心；不是 c4 的参数消融。u64、1M，单位 ms：", "",
              "| 分布 | Block 4 KiB | LSD stable | LSD core |", "| --- | ---: | ---: | ---: |"]
    for dist in ["uniform","organ_pipe","almost_sorted","push_front","push_middle"]:
        rows=[old["u64",dist,1048576,algorithm] for algorithm in ["block_bytes","lsd","lsd_core"]]
        assert all(r["full_stable_output_matches"]=="True" for r in rows)
        lines.append(f"| {dist} | "+" | ".join(f"{float(r['median_ns'])/1e6:.3f}" for r in rows)+" |")
    lines += ["", "organ_pipe 有一个上升段和一个下降段；push_front/push_middle 只移动一个元素；almost_sorted 约做 log2(n) 次交换。LSD stable 接口用 Verge 识别长有序段，再局部处理、合并；两个 run 合并只为较短 run 申请缓冲。Block 直接跳过整个数组有序/反序的情况，其余输入仍需 radix 扫描、换块和压紧。因此，Block 可能快于纯 radix core，却输给利用已有 run 的接口。TimSort、Rust stable 也能受益于已有有序结构。这是代码和对照结果支持的解释，尚未做专门机制实验。", "",
              "late_difference 则已经有序：前 n−1 个键为 42，最后一个为 43。Block 的 first_different_key 先扫描几乎全数组，再从头 check_order，又扫描一次；这是另一个可直接定位的工作量差距。reversed 含重复键时，Block 为保持 payload 稳定还要修复等键组，不能为追平只反转整段的路径删除这一保证；LSD 的两个 reversed-record 失败条件已排除。", "",
              "源码：[Block 入口](validation/harness/source/pr/src/sorts/block_lsd_stable_sort.rs)、[LSD stable 入口](validation/harness/source/pr/src/sorts/lsd_stable_sort.rs)、[run 合并](validation/harness/source/pr/src/algo/k_way_merge.rs)、[输入生成器](validation/harness/src/main.rs)。精确 2 次幂档位的 cache set 冲突另列为假说，尚无 PMU 因果确认。", "",
              "可改进，但优先级应由已定位的多余工作决定：[改进方案与验证边界](ALGORITHM-IMPROVEMENTS.md)。先复用已确认的相等前缀，避免 late_difference 重扫；再尝试稳定、零堆的单元素错位修复，以覆盖 push_front/push_middle；organ_pipe 需要稳定 run 合并，并受现有 scratch 预算约束。这些方案尚未实现、未计时，不能写成已获得的速度收益。", "",
              "## 数据复用、缺口补测与复现", "",
              f"全部 1,045 条件的候选时间来源：{audit['time_source_conditions']}；内存来源：{audit['memory_source_conditions']}。优先级在查覆盖时固定为原始批次、扩大系数批次、已保留前缀、缺口补测，没有按最快结果挑批次。每条记录保存时间、内存和比较器来源。", "",
              "固定 1 KiB 原已覆盖全部 1,045 条件，c4 扫描覆盖 109 条件；c4+1KiB 原有两批数据可直接覆盖 835 条件。一次不必要的完整重跑已停止，884 条完成的计时前缀原样保留，其中 178 条用于补充候选覆盖；之后只补 32 条缺失计时和 210 条缺失内存。32 条计时仅带 LSD/Rust stable/TimSort 三个同批对照，共 768 时间观测；内存只测候选，共 630 观测。没有重启完整矩阵。", "",
              "所有候选完整稳定输出与 oracle 相同，输入摘要逐种子匹配原矩阵，候选堆峰值均在上界内。各批 A/A 分别保留，不混合成一个噪声统计；见审计。原始 192,780 条正式观测、58,266 条中断前缀观测和 1,398 条缺口补测观测全部保留。中断批次不称为完成的完整验证。", "",
              "计时包含排序内部申请/释放，输入复制、oracle 核验和策略计算在计时外。耗时比只在同一批次内配对；堆量来自同输入、同有效参数的已有测量，来源逐行公开。确定性输入的重复不是独立随机数据集。等权工况 GM 不是业务加权，也不给 1% 内差异作稳定收益承诺。", "",
              "运行 evaluate_reuse.py，再运行 plot_story.py、plot_fits.py、audit_story.py 和本报告生成器，即可从保存的 CSV/JSONL 重画，无需重新排序。PDF/SVG 为可编辑分享稿，PNG 为 300 dpi 预览。", "",
              "[覆盖与复用审计](data/reuse-audit.json) · [缺口清单](missing-only/coverage-before.csv) · [补测 manifest](missing-only/manifest.json) · [中断记录](validation/INTERRUPTED.json) · [图形 QA](qa/README.md) · [旧完整包](../block-lsd-pr-20261018/README.md)"]
    (ROOT/"REPORT.md").write_text("\n".join(lines)+"\n")


if __name__=="__main__":
    main()
