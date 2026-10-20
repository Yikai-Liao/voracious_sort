# 代码与 Benchmark 归档

分支：`archive/block-lsd-experiments-20261020`。

仓库根目录保存最新 Block LSD 代码，包括公开的
`block_lsd_stable_radixsort(arr, radix)`、自动块长策略、私有手动块长内核，
以及对应的文档和测试。最新改动基于 `e649c6a`；原排序内核函数体没有改变。
源码校验值和已通过的 release 测试结果见 [SNAPSHOT.json](archive/SNAPSHOT.json)：
默认配置 10 个单元测试、5 个集成测试、4 个文档测试；all-features 为
98 个单元测试、5 个集成测试、4 个文档测试。两种配置各有 1 个忽略的文档测试。
完整接口补丁另存于 [adaptive-api.diff](archive/adaptive-api.diff)。

本次新增的是整理后的数据、报告、图表和脚本，约 30 MiB，最大单文件约 2.6 MiB。
历史冻结二进制包、构建缓存、汇编与 perf 转储、下载的参考论文不在本次上传中。
较大的 CSV/JSONL 使用 gzip 无损压缩，内容相同的文件只保存一份；解压和去重均有逐文件 SHA-256 校验。
已存在的早期实验及其 Git 历史保留。

## 阅读入口

| 内容 | 入口 |
| --- | --- |
| 最新 PR 正文与接口说明 | [PR 正文](archive/workspaces/pr-draft-20261018/PR-body.md)、[API](archive/workspaces/pr-draft-20261018/API.md) |
| 最新整理后的比较数据 | [PR 数据](archive/workspaces/pr-draft-20261018/data/) |
| 最新配图 | [图表目录](archive/workspaces/pr-draft-20261018/figures/) |
| 原版完整时间/空间矩阵 | [报告](archive/workspaces/benchmarks/block-lsd-pr-20261018/REPORT.md)、[数据](archive/workspaces/benchmarks/block-lsd-pr-20261018/data/) |
| 块长策略、拟合与补充验证 | [报告](archive/workspaces/benchmarks/block-lsd-pr-20261018-story/REPORT.md)、[数据](archive/workspaces/benchmarks/block-lsd-pr-20261018-story/data/)、[拟合结果](archive/workspaces/benchmarks/block-lsd-pr-20261018-story/fits/) |
| 已撤回的 Block LSD 候选 | [评估结果](archive/workspaces/benchmarks/block-lsd-adaptive-screen-20261018/RESULTS.md) |
| 后续 PA 候选的整理结果 | [报告](archive/workspaces/benchmarks/pa-benchmark-20261019/REPORT.md) |
| 更早的 Block LSD 实验 | [results/block_lsd](results/block_lsd/README.md) |
| 数据目录、文件别名与内容校验值 | [DATA-INDEX.json](archive/DATA-INDEX.json) |

原矩阵保留 112,170 条时间观测和 56,085 条内存观测，平方根策略补充实验保留
16,350 条时间观测和 8,175 条内存观测，逐表记录见
[OBSERVATIONS.json](archive/OBSERVATIONS.json)。CSV 保留种子、顺序、算法、参数、
逐次耗时或分配量、输入摘要和正确性结果；相应的重复 JSONL 不再上传。
后续策略验证和各候选阶段的数据另按原目录保存，失败、拒绝和中断状态均保留。

性能图描述原内核在已记录参数下的测量，不包含新公开封装计算块长的开销。
已撤回候选和未完成验收的 PA 结果均不计作已采用的性能改进。

## 校验与恢复数据目录

仅需 Python 标准库。在仓库根目录执行：

```sh
python3 archive/verify.py
python3 archive/restore_data.py --output ../voracious-sort-restored-data
```

第二条命令需要一个空目录；它恢复原 CSV/JSONL 文件名和被去重的文件，
逐项核对内容哈希，以便读取数据及使用原绘图脚本。无需下载历史二进制包。
也可以直接用 `pandas.read_csv("path/to/timing.csv.gz")` 读取压缩表。

各实验原有的 README、manifest 和日志用于保留测量方法与当时结论；其中有些路径指向
本地完整冻结包或可重建的二进制。本分支实际上传内容以本说明、DATA-INDEX.json 和
archive/SHA256SUMS 为准。脚本中的原机器路径和依赖配置按新环境调整。
