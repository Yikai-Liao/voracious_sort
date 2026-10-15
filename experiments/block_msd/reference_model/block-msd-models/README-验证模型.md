# Block MSD 抽象验证模型

这些脚本是数学构造的独立状态模型，不是排序库实现，也不是性能基准。没有调用或执行 tokenizers 仓库代码。

## 内容

- `model-validation-summary.json`：去重后的模型检查索引；不同模型的输入有重叠，不能将各项相加作为不同输入总量。
- `global_dfs_model.py` / `retained_dfs_model.py`：串行块池、父尾部所有权、保留完整结果块。
- `fixed_fork_model.py` / `cooperative_root_model.py`：固定预算交接和根分段稳定顺序。
- `adaptive_frontier_model.py`：有界前沿和拆分占块增量。
- `batch_finalizer_model.py`：只读收集、前缀消费、目标避让、最终回写。
- 其余脚本：局部原语、边界、深度碎片、重复搬移和故意破坏协议的反例。
- 对应 JSON：已完成检查的记录；主批次回写配置不另增加避让池，但显式使用外部收集缓冲。

## 运行

在解压目录内，用 Python 3 运行对应脚本，例如：

```sh
python3 batch_finalizer_model.py --no-extra-pool
python3 cooperative_root_model.py
python3 check-cycle-finalization-model.py
```

脚本使用标准库及同目录模块。完整穷举的耗时随环境变化。随机测试使用脚本内固定种子；程序输出是检查结果，不是计时数据。

## 证据范围

逐记录标签、Python 字典/集合/列表、某些逐记录读取描述符用于检查正确性。它们不满足报告要求的生产元数据布局，不能通过观察这些脚本的内存或耗时验证 O(n/b) 目录或原生性能。

“并行”检查通过任务完成顺序和阶段顺序模拟进行，没有真正启动并发线程。实际代码仍须验证所有权交接、内存顺序、数据竞争、Rust 未初始化内存和 panic/drop 安全。

故意错误的协议测试以复现损坏为成功条件，不应被误认为正确算法失败。
