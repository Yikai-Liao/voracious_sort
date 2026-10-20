#!/usr/bin/env python3
"""Write a concise, reproducible account of curve and tier fitting."""
import csv
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parent


def main():
    power = json.loads((ROOT / "fits/result.json").read_text())
    tiers = json.loads((ROOT / "fits/tier-result.json").read_text())
    baseline = power["baseline"]
    selected = next(r for r in power["finalists"] if r["selection"] == "Power + floor")
    simple = next(r for r in power["finalists"] if r["selection"] == "Total-byte power + floor")
    lines = [
        "# 自动 block 策略：曲线与固定档位拟合",
        "",
        "现有策略扫描支持 **c=4 的平方根增长 + 最小 1 KiB/block** 作为折中候选。自由幂律只能带来约 0.3% 的样本内耗时改善；按整个输入长度留出后没有保留优势。规整的 2 次幂档位在共同有数据的 107 个条件上更慢，尤其在 organ_pipe 上。当前结果不支持把更复杂的拟合或精确 KiB 档位升级为通用默认值。",
        "",
        "拟合本身没有新运行排序计时，使用已封存第二批的全部 109 个条件、21 个 Block 原始策略。算法比较优先复用已有相同实际 block 参数；完整重跑已停止，只补齐 32 个缺失计时工况和 210 个缺失内存工况，详见[主报告](REPORT.md)。候选定义没有根据本次自由拟合更改。",
        "",
        "## 数学依据与函数形式",
        "",
        "令 n 为元素数、s 为元素字节数、S=n*s 为输入字节数，y=b*s 为每块字节数。当前 radix=8 的辅助堆上界是 `512*b*s + 9*floor(n/b) + 66*256`。忽略取整得到 `M(y)=512*y+9*S/y+66*256`，求导可得连续空间最优 `y*=sqrt(9*S/512)`。因此平方根在空间上有严格依据；速度还受换块管理、搬运和缓存影响，系数 c 需要计时确定。",
        "",
        "筛选候选约等于 `y=max(1024,4*sqrt(9*S/512))`，约在 3.56 MiB 输入处开始增长。实际整数公式为：",
        "",
        "```text",
        "b = max(1, ceil(4*sqrt(9*n/(512*s))), floor(1024/s))",
        "```",
        "",
        "1 KiB 下限不仅限制小块：它扩大了允许完整 scatter 的预算，让部分小输入切换算法路径；n<=128 则更早走稳定比较排序叶子。跨这些分支拟合单一光滑曲线，不一定能识别真实机制。[完整推导](fits/MATH.md)。",
        "",
        "## 自由幂律没有显示稳定收益",
        "",
        f"共检查 {power['parameter_grid_models']:,} 个有限格点模型，允许长度指数、记录宽度指数、字节下限和上限变化。训练只使用 n>128 的 {power['informative_conditions']} 个条件，报告仍包含全部 109 条件。目标依次为最小 P90 regret、几何平均 regret、最坏 regret、最大额外堆。regret 的分母是同一条件最快的已测试 Block 配置。",
        "",
        "| 策略 | 几何平均 regret | P90 regret | 最坏 regret | 相对固定 4 KiB 耗时 |",
        "| --- | ---: | ---: | ---: | ---: |",
    ]
    if not (ROOT/"figures/curve-and-tier-fitting.pdf").exists():
        lines[4:4] = ["拟合表和公式已完成；图正在等待计时阶段结束后渲染，文末图链接届时生效。", ""]
    for label, row in [("c4 + 最小 1 KiB", baseline), ("自由幂律 + 下限（实测参数映射）", selected), ("仅按输入总字节数的幂律 + 下限", simple)]:
        lines.append(f"| {label} | {row['gm_regret']:.3f} | {row['p90_regret']:.3f} | {row['max_regret']:.3f} | {row['gm_time_vs_4k']:.3f} |")
    lines += [
        "",
        "自由拟合较好的目标为 `max(512/s, 192*(n/2^20)^(3/8)*(s/8)^(-1/2),1)`。这条连续曲线的新块长没有直接计时；上表评估的是按对数距离映射到同一个 n、s 下**已经实测**的块长。运行时选择只依赖 n、s，不依赖分布或该条件的观测速度。不能把这个表写成连续公式本身的实测速率。",
        "",
        f"映射策略样本内耗时变化为 {(selected['gm_time_vs_c4_floor_1k']-1)*100:+.2f}%；在额外堆为正的 {selected['positive_heap_conditions']} 个条件上，堆量几何平均变化为 {(selected['gm_heap_vs_c4_floor_1k']-1)*100:+.2f}%。这点耗时差小于同批 A/A 约 5% 的典型变化；A/A 是波动参照，不是显著性检验。",
        "",
        "| 留出分组后重新拟合 | 自由幂律 + 下限，相对 c4/1KiB 耗时 | 输入字节幂律 + 下限，相对耗时 |",
        "| --- | ---: | ---: |",
    ]
    for split, label in [("record_bytes", "元素字节数（5 折）"), ("length", "输入长度（15 折）"), ("distribution", "分布（7 折）")]:
        row1 = next(r for r in power["cross_validation"] if r["family"] == "Power + floor" and r["split"] == split)
        row2 = next(r for r in power["cross_validation"] if r["family"] == "Total-byte power + floor" and r["split"] == split)
        lines.append(f"| {label} | {row1['gm_time_vs_c4_floor_1k']:.3f} | {row2['gm_time_vs_c4_floor_1k']:.3f} |")
    lines += [
        "",
        "每次在留出组之外重新选参数，表中为全部被留出条件的等权几何平均。它是既有数据的交叉验证；c4/1KiB 对照先前已在这 109 个条件中筛选过，所以这不是完全独立的外部测试。还保留了原 111 公式族在相同分组下重新拟合的结果，避免只给复杂模型做难度更高的检验。",
        "",
        "分布和尺寸在这组数据中并非完全交叉：留出 uniform 后，训练数据仅剩 1M 的压力分布，因此这一折同时要求外推输入规模，长度指数也无法从其训练数据单独识别。留出结果用于暴露这些局限，不把它解读为纯粹的分布泛化测试。带 16 KiB 上限的样本内优胜模型与无上限模型在全部已测点选择相同参数，该上限从未生效，也不能据此推断最佳 cache 容量。",
        "",
        "长度指数从 0 到 0.75，重新拟合其他参数后的 P90 regret 都约为 1.13–1.14，曲线很平。总输入字节数单变量的受约束模型 `beta=1-alpha` 仍选出 alpha=beta=0.5。109 条件只有 35 种 (n,s)，其中 30 种不在小数组叶子；大规模增长主要只有 8 字节记录。目前不足以把 3/8 或 1/4 认定为更正确的指数。",
        "",
        "固定 s 时，自由幂律的两项空间随 n 分别按 `n^alpha`、`n^(1-alpha)` 增长。alpha=3/8 会把渐近空间主项变成 `n^(5/8)`，不能沿用平方根空间的宣称。固定最高档位或固定上限最终也会让 descriptor 项线性增长。",
        "",
        "## 固定档位与光滑增长",
        "",
        "这里单独比较 `c=4`、最小 1 KiB 的目标，分别保留原整数块长，或把块字节数向下、取最近、向上量化到 2 次幂。各量化方式各缺 1 个条件，合并为两个 u64/uniform 条件：n=524,288 与 n=2,097,152 时缺每块 2 KiB（b=256）的计时。因此以下使用相同的 107 个条件，没有插值补齐两个缺口。",
        "",
        "| c4 策略 | 几何平均 regret | P90 regret | 最坏 regret | 相对光滑版本耗时 | 最大额外堆 MiB |",
        "| --- | ---: | ---: | ---: | ---: | ---: |",
    ]
    for row in tiers["c4_quantized_common_support"]:
        label = "光滑 + 1 KiB 下限" if row["kind"] == "balanced" else {"down": "向下取档", "nearest": "最近档位", "up": "向上取档"}[row["rounding"]]
        lines.append(f"| {label} | {row['gm_regret']:.3f} | {row['p90_regret']:.3f} | {row['max_regret']:.3f} | {row['gm_time_vs_smooth_c4_floor']:.3f} | {row['max_heap_bytes']/2**20:.3f} |")
    lines += [
        "",
        "另做了阈值拟合：每块字节档 1/4/8 KiB、1/2/4/8 KiB，以及元素数档 128/512/1024。只在全部 109 条件都有实测参数时纳入完整排名；固定阈值表的几何平均耗时比光滑候选多约 6%–9%。这个覆盖限制会排除部分本来值得研究的档位策略；完整格点排名、覆盖表和共同支持集都保留，不能把排名第一的受支持策略称为全体量化策略最佳。",
        "",
        "最近档位的退化主要在 organ_pipe：i32、n=1,048,576，1 KiB 档比光滑 c4 约慢 2.295 倍；u32 约慢 2.155 倍。对这些规则输入，精确 2 次幂档位可能有地址布局问题。当前 CPU2 的 L1D 为 32 KiB、64 B/cache line、64 sets、8-way；初始桶写入游标按 block 字节数 y 等距排列。若 y=64*q 且游标进度相同，简单 set 取模模型只覆盖 `64/gcd(q,64)` 个 sets。1 KiB stride 只覆盖 4 个，2 KiB 只覆盖 2 个；u32 光滑 c4 的 1088 B stride 是 17 条 cache line，可覆盖 64 个。organ_pipe 会产生同步推进桶游标的 digit 序列，因此这一解释有代码与硬件依据。尚未用 PMU 或地址隔离实验确认因果。",
        "",
        "如果继续研究固定档位，可以比较近似 KiB、但避开不利 stride 的档，例如名义 B 加 `lcm(64,s)`；当前 s<=64 B 时为 1088/2112/4160/8256 B，s=128 B 时为 1152/2176/4224/8320 B。这是新的待测假设，本文没有替它生成速度数据。",
        "",
        "量化空间最优 `y*` 到最近 2 次幂，忽略取整时，可变辅助空间相对连续空间最优最多增加 `3/(2*sqrt(2))-1`，约 6.07%；向上或向下取档上界是 25%。这个界要求 y* 在档位覆盖范围内，也不适用于把 c=4 速度候选当成空间最优，更不保证时间。",
        "",
        "## 文件与复现",
        "",
        "- [比较图 PDF](figures/curve-and-tier-fitting.pdf) / [PNG](figures/curve-and-tier-fitting.png)。",
        "- [全部自由模型](fits/all-models.csv)、[交叉验证](fits/cross-validation-summary.csv)、[逐条件选中参数](fits/full-data-selected-conditions.csv)。",
        "- [全部档位模型及覆盖](fits/tier-all-models.csv)、[共同支持集](fits/c4-quantized-common-support.csv)、[缺测参数](fits/tier-missing-conditions.csv)。",
        "- [数学推导](fits/MATH.md)、[拟合协议](fit-contract.md)、[原始来源校验](data/source-provenance.json)。",
        "",
        "用保存的 Python 环境依次执行 `fit_curves.py`、`fit_tiers.py`、`plot_fits.py`、`create_fit_report.py` 即可重算和重画；都不调用排序 benchmark。每次重画后运行 `audit_story.py --fits-only`，复核源代码、对齐、字形和碰撞；本次导出检查见 [QA 记录](qa/README.md)。",
        "",
        "以上是该机器、有限参数格点和等权测试条件上的探索性证据。它既不证明业务加权最优，也不证明跨机器通用最优。",
    ]
    (ROOT / "FIT-REPORT.md").write_text("\n".join(lines) + "\n")


if __name__ == "__main__":
    main()
