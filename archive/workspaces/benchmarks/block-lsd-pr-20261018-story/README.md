# Block LSD：算法比较与自动 block 策略

阅读顺序：先看算法在具体输入上的性能，再看自动 block 策略的选择，最后看自由曲线和固定档位是否值得采用。

- [主报告](REPORT.md)：数据复用、逐条件比较、A/A 波动和退化原因。
- [图 1：按九种类型分面的性能点图](figures/01-algorithm-comparison.pdf)。每点为一种类型、一个分布、一个比较器；1 右侧表示 Block 更快。
- [效率总览](figures/01b-efficiency-overview.pdf)：大输入实际时间/堆、内存条件计数与总体速度经验分布。
- [图 2：自动策略选择](figures/02-policy-selection.pdf)。
- [图 3：曲线与档位拟合](figures/curve-and-tier-fitting.pdf)及[完整拟合报告](FIT-REPORT.md)。
- [图法调研](VISUALIZATION-RESEARCH.md)、[算法改进候选](ALGORITHM-IMPROVEMENTS.md)、[逐面板 QA](qa/README.md)。

候选只依赖元素数 n 和元素字节数 s，radix=8：

```text
b = max(1, ceil(4*sqrt(9*n/(512*s))), floor(1024/s))
```

平方根来自空间上界的两项平衡，c=4 与最小 1 KiB 是 109 个已完成条件、111 个有限公式的速度/空间折中，不能称为已证明的通用最快策略。与 c8 的耗时差不足以越过 A/A 波动，c4 的额外理由是较少堆量。

## 已完成的数据与来源

| 数据 | 内容 |
| --- | --- |
| data/original-{timing,memory}.csv、summary.csv | 原始完整 1,045 条件，各算法正式时间/内存和汇总 |
| data/supplemental-sqrt-*.csv | 已封存的 109 条件扩大系数扫描；筛选与拟合只使用该批时间 |
| data/policy-{screen,floor-screen}-* | 21 个原始公式、111 个含下限公式的筛选，派生调用必须等于实际已测参数 |
| validation/ | 已停止的完整重跑计划、884 条完成的计时前缀、冻结源码/二进制、输入摘要、原始 JSONL；INTERRUPTED.json 标明未完成 |
| missing-only/ | 查重后的缺口清单与冻结协议；仅补 32 条候选计时及其同批三个对照、210 条候选内存 |
| data/validated-policy-conditions.csv | 候选全部 1,045 条件的覆盖，每行写明时间与内存来源 |
| data/candidate-comparisons.csv | 同批同种子/顺序的三组比较，共 3,135 行，包含失败基线标记与同工况 A/A 信息 |
| data/reuse-audit.json、evaluation-provenance.json | 输入、输出、堆上界、复用来源和摘要核验 |
| fits/ | 拟合格点、逐条件所选块长、分组留出、档位缺测、数学与缓存几何说明 |
| figures/、qa/ | 可编辑 PDF/SVG、PNG、对齐/字形/碰撞与逐面板验收 |
| validation/cancelled-plan/ | 已取消完整重跑的旧分析/流水线文件，仅保留历史，不参与最终生成 |

原始正式观测 192,780 条、保留的中断前缀时间观测 58,266 条、真正缺口补测 1,398 条全部保留。最终候选时间来源为原始 764、扩展 71、前缀 178、缺口 32 个条件；内存来源为原始 764、扩展 71、缺口 210 个条件。没有把中断批次称为完成的完整验证。原始封存包保持原样。

每个耗时比在同一批次按种子和顺序配对，再取六对中位数。来源选择优先级固定，不按最快结果选批次；不跨批拼接绝对耗时计算收益。候选的稳定输出、输入摘要和额外堆上界全部通过核验。LSD Stable 的两个 reversed-record oracle 失败仍保留，仅从同语义速度比较排除。

撤去 5% 胜负阈值。主报告列出至少 1.5/2 倍的较大效应，并提供逐工况同批 A/A 包络的保守描述筛选；这些不构成总体显著性检验。主图按具体类型分面，不以跨类型 min/max 冒充误差条。

计时包括排序内部申请/释放，输入复制、oracle 核验和策略计算在外。内存是请求的峰值存活额外堆，排除输入与分配器元数据，不是 RSS。时间和内存分别测量；确定性构造的重复不代表独立随机数据集。

## 从保存的数据重画

无需重新运行排序。依赖来自锁定文件：

```bash
uv venv --python 3.14t .venv
uv pip sync --python .venv/bin/python python-requirements.lock
.venv/bin/python fit_curves.py
.venv/bin/python fit_tiers.py
.venv/bin/python evaluate_reuse.py
.venv/bin/python plot_fits.py
.venv/bin/python plot_story.py
.venv/bin/python audit_story.py
.venv/bin/python create_fit_report.py
.venv/bin/python create_story_report.py
```

每次重画后必须重新检查所有 PDF，并逐面板查看；旧审计不能用于新 PDF。每张多面板图导出前执行 1.5 pt 对齐门槛，导出后查实际 5 pt 最小字形和文字碰撞。PDF/SVG 为可编辑分享稿，PNG 为 300 dpi 预览；本包不是期刊最终提交文件。

新排序实验应建立新目录，不向现有 JSONL 追加，也不要执行 validation/complete.sh 恢复已取消的完整矩阵。当前二进制按本机 native 指令集编译，异机重编译应重新冻结，不沿用当前二进制哈希。

原始便携包：[block-lsd-pr-benchmark-20261018.tar.zst](../../archives/block-lsd-pr-benchmark-20261018.tar.zst)。本策略研究独立封存为 `../../archives/block-lsd-strategy-study-20261018.tar.zst`，随附归档 SHA256 和逐文件流式核验记录。`seal_story.py --verify` 核对目录中的全部交付文件，`verify_archive.py` 核对归档与内部清单。
