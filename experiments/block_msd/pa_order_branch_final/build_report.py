#!/usr/bin/env python3
"""Render the fixed campaign report from complete audited CSV summaries."""
import csv
from pathlib import Path

ROOT = Path(__file__).resolve().parent
FIELDS = ('n', 'block', 'seed', 'layout', 'case')
RATIO = 'candidate_over_stable_msd_wall_median'


def read(name):
    with (ROOT/name).open(newline='') as stream:
        return list(csv.DictReader(stream))


def main():
    rows = read('review-matrix.csv')
    assert len(rows) == 103
    cells = {tuple(r[k] for k in FIELDS): r for r in rows}
    assert len(cells) == 103
    heldout = [r for r in rows if 'heldout' in r['file']]
    seen_prefix = [r for r in rows if r['file'].startswith(('final-prefix-b64', 'final-prefix-b512'))]
    assert len(heldout) == 12 and len(seen_prefix) == 24
    faster = sum(float(r[RATIO]) < 1 for r in rows)
    slower = sorted((r for r in rows if float(r[RATIO]) >= 1), key=lambda r:-float(r[RATIO]))
    assert len(slower) == 2
    chosen = [
        (1048576,64,42,'u8','sparse'), (1048576,64,42,'u16','sparse'),
        (1048576,64,42,'small8','uniform'), (1048576,512,42,'small8','uniform'),
        (1048576,64,42,'u64','deep_unique90'), (1048576,64,7,'u64','deep_unique90'),
        (1048576,512,42,'large128','uniform'),
        (1048576,512,42,'large128','majority_prefix'),
        (1048576,512,42,'large128','deep_unique90'),
        (262144,64,42,'u128','deep_unique90'),
        (16384,64,42,'u128','equal'), (16384,64,42,'wide32','sorted'),
        (1048576,64,42,'wide32','equal'), (1048576,64,42,'wide32','sorted'),
    ]
    lines = [
        '# 统一 Pa 均衡候选：完整验证结果', '',
        f'冻结源码 `49db9f8`，保留同一套 Pa 节点划分、递归和 Block 后端。主矩阵共 103 个场景，',
        f'其中 {faster} 个场景的配对耗时中位数快于 Stable MSD。剩余差距是小尺寸 wide32 有序',
        '输入约慢 6.6%，以及百万条 wide32 全等约慢 1.3%。这支持一个接近或超过 Stable、',
        '并保留 Block 辅助空间收益的均衡候选；未达到逐项全面胜出。', '',
        '103 场景由原定 91 个已见场景及最后执行的 12 个未见种子场景组成。每个场景 12 次',
        '配对正反轮转，保留 Pa A/A、线程 CPU、样本 p10/p90 和较慢次数。各文件单独分析，',
        '没有合并重复试验或跨场景均值来覆盖慢项。', '',
        '## 代表场景', '',
        '耗时单位为 ms。比值小于 1 表示候选更快；比值是逐次配对比值的中位数，',
        '不要求等于表内两个耗时中位数直接相除。Small8 是 u32 键加 u32 ID 的 8 字节记录；',
        'wide32 为 u128 键的 32 字节记录，large128 为 u32 键的 128 字节记录。', '',
        '| N | B | 种子 | 布局 | 输入 | 候选 ms | Stable ms | 候选 / Stable |',
        '|---:|---:|---:|---|---|---:|---:|---:|',
    ]
    for cell in chosen:
        r = cells[tuple(map(str,cell))]
        lines.append(f"| {cell[0]:,} | {cell[1]} | {cell[2]} | {cell[3]} | {cell[4]} | {float(r['candidate_wall_ms']):.4f} | {float(r['stable_msd_wall_ms']):.4f} | {float(r[RATIO]):.4f} |")
    lines += ['', '完整的 [103 场景审阅表](review-matrix.csv) 保留全部结果与波动信息。两个剩余慢项：', '']
    for r in slower:
        lines.append(f"- {r['layout']} / {r['case']} / N={int(r['n']):,}：比值 {float(r[RATIO]):.4f}，p10/p90 {float(r['candidate_over_stable_msd_wall_p10']):.3f}/{float(r['candidate_over_stable_msd_wall_p90']):.3f}，{r['candidate_slower_than_stable_msd_reps']}/12 次较慢，线程 CPU 比值 {float(r['candidate_over_stable_msd_threadcpu_median']):.3f}。")
    lines += ['',
        '小尺寸 wide32 有序的差距有一致样本支持，按实际代价保留；百万条全等则更接近持平。', '',
        '## 深偏斜与未见种子', '',
        f"24 个已见共享前缀场景的候选 / Stable 中位数范围为 {min(float(r[RATIO]) for r in seen_prefix):.4f}～{max(float(r[RATIO]) for r in seen_prefix):.4f}，每个场景的每次重复均更快。",
        '其中同时包含重复键偏斜和完整键全异的 progressive 90%/98% 共享前缀。全异数据',
        '低位保留唯一序号，高位逐层生成前缀，因此完整键始终唯一。', '',
        f"未见种子 `20261018` 的 12 个场景全部更快，候选 / Stable 范围 {min(float(r[RATIO]) for r in heldout):.4f}～{max(float(r[RATIO]) for r in heldout):.4f}；",
        f"候选 / 原 Pa 范围 {min(float(r['candidate_over_Pa_wall_median']) for r in heldout):.4f}～{max(float(r['candidate_over_Pa_wall_median']) for r in heldout):.4f}，候选 / Band 最高 {max(float(r['candidate_over_Pa_band_wall_median']) for r in heldout):.4f}。",
        '所有 12 场景的 12 次配对重复均快于 Stable。该种子在源码、阈值、机制选择冻结后最后执行，',
        '执行前置条件记录在 [heldout-gate.json](validation/heldout-gate.json)。', '',
        '## 保留的机制与空间', '',
        '保留节点规模前缀预算、共享前缀分类、稳定小叶子、受既有 Block 空间预算约束的局部分布，',
        '以及缓存工作集 gate、采样成本 gate 和已知标签变化掩码复用。16 MiB 是离线缓存 gate，',
        '辅助分配预算仍为 `512 * B * size_of(T)`。有序检测内部按原生比较能力选择归约或早退，',
        '所有键宽继续使用同一 Pa 划分和递归机制。', '',
        '低层保留三项有独立源码配对的改动：原 scalar scatter outlining、全等 native XOR/OR',
        '归约、软件宽键单调性检测早退。Small8 outlining 的独立配对中位数约为旧版 0.499/0.510',
        '（B64/B512）；百万条 u128 全等约 0.858，u128/wide32 有序约 0.860/0.949。窄键有序',
        '对照接近不变。全部配对、A/A 和样本分位数见 [源码配对](review-pairs.csv)。', '',
        '8 场景同程序消融中，u8/u16 稀疏的分组内核比 Prepared 的配对中位数快约 22%/19%；',
        '带 ID 记录没有稳定额外收益。22 场景独立机制对照保留了采样、复用、nested 与叶子',
        '控制的正负结果，见 [机制消融](MECHANISMS.md)，不把组件收益相加。', '',
        '62 个辅助堆场景中，候选峰值和分配次数全部与 Prepared 一致，峰值均不高于冻结 Block LSD；',
        '候选 / Stable 的辅助堆峰值最高为 0.253963。large128/B512 为 33,589,760 字节，',
        'Stable 在 uniform/majority 为 134,784,664/376,387,624 字节；wide32/deep_unique98/B64',
        '为 1,212,928 对 414,966,888 字节。这些是请求的同时存活辅助堆字节，不含输入和 oracle，',
        '也不等于 RSS 或栈。完整 [空间及工作量证据](RESOURCES.md)。', '',
        '## 正确性、复现与范围', '',
        '本轮 10,900 条正式测量记录与 896 条独立源码配对记录全部通过完整稳定 key/ID/payload',
        'oracle。103 场景及 8 场景消融的 3,552 个数值字段独立重建一致；实际正反轮转、输入',
        '地址、冻结源码和 ELF 哈希均已审计。新源码的 33 项优化构建 frontier 回归全部通过。', '',
        '相对 `8bf14e0`，156 个编译输入只变更安全的有序证明和位异常回归；整个 block.rs 字节',
        '一致。此前该源码的 32 项 ASan 测试和 170 条边界 oracle 作为相同指针内核的既有覆盖，',
        '本轮没有把它们标作新源码的 sanitizer 运行。原生堆/Work 计数可与回归编译重叠，所有',
        '正式速度测量均在构建和测试结束后执行。', '',
        '测量环境为六 vCPU Xeon Gold 6140 KVM，单线程固定客机 CPU 2，Rust 1.98.1 / LLVM 22.1.8，',
        '锁定依赖并离线构建；宿主频率与其他租户负载未锁定。结论限于所列硬件和代表矩阵。', '',
        '实现与证据保存在隔离分支 `block-pa-unified`；默认库算法未改，未推送。源码、完整原始数据、',
        '构建设置、稳定性证明和复现入口见 [DESIGN](DESIGN.md)、[METHODS](METHODS.md)、',
        '[REPRO](REPRO.md)、[source-sha256.txt](source-sha256.txt)、',
        '[binary-sha256.txt](binary-sha256.txt) 和 [evidence-sha256.txt](evidence-sha256.txt)。', '',
    ]
    (ROOT/'REPORT.md').write_text('\n'.join(lines))


if __name__ == '__main__':
    main()
