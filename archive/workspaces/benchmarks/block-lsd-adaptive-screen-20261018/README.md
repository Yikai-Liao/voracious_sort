# Block LSD 改进评估

本轮所有代码候选均已撤回，两个工作区保持原版。先读 [是否值得修的判断](ASSESSMENT.md)，再读 [最终确认结果](RESULTS.md)。原版未修改；用于比较的块长固定为 `c=4`、最低 1 KiB。

| 目录 | 状态与作用 |
| --- | --- |
| `prefix-reuse/` | 第一版的 18 条件筛查，后来被更广验证否决 |
| `prefix-confirmation/` | 第一版的完整 109 条件时间比较；发现退化后拒绝，内存中止 |
| `prefix-exit-index/` | 最后一次出口索引实现，15 条件时间/内存均完成，仍因浮点全相等退化被否决 |
| `single-displaced/` | 已撤回的单元素错位候选。完整计时与中止前的部分内存观测仅作历史记录，不能视为完成验收 |
| `bounded-runs/` | 已撤回的固定两段草稿。没有运行该候选的基准 |
| `withdrawn-source/` | 从候选工作区撤下的源码与补丁，不属于当前实现 |

每次运行前冻结调度、源码和二进制摘要。两版在同一可执行程序中，以原版同函数别名提供 A/A。排序、探测和排序内部的分配计时；输入构造、复制、完整输出检查和块长计算不计时。内存单独使用追踪分配的程序测量。

`run_screen.py` 拒绝追加重复运行；如要重测，创建新目录并重新冻结。只重算最终 CSV 和报告：

```sh
python3 analyze_screen.py prefix-exit-index
python3 make_report.py
```

此前的原版算法比较、块长策略研究和四张图已独立封存于 `../block-lsd-pr-20261018-story/` 与 `../../archives/block-lsd-strategy-study-20261018.tar.zst`。本目录的代码实验不改写那些结果。

全部实验记录的便携归档为 `../../archives/block-lsd-prefix-evaluation-20261018.tar.zst`。SHA256SUMS 对有效载荷逐项封存；构建缓存不进入归档。
