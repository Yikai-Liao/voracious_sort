# 上传材料与 Rust 实验的核对

来源为用户上传的 `Block-MSD-数学证明与多路线分析.md.txt` 和 `Block-MSD-抽象验证模型.zip`。先列出zip条目，解压的只有模型.py、README和验证summary，未执行未检查的脚本。相关源码只导入Python标准库及同目录模型，无网络/外部执行/文件写入。

- §5 的 Pool / Arena / Node 共享块池、按digit序DFS和prefix消费，与我们的Arena/full+parent-stream表示一致。材料使用q+R+2D+8保守供给；原v1使用R+2D+4，具体窗口常数不同，应各自证明而非复用预算。我们的Vec capacity、已消费IDs和IntoIter在完整元数据界中计入。
- 材料 normalized_dfs_model / endpoint_arena_model 的首末端折叠，与v2的relocated-head段同构。材料在每个child(<b)结束后normalize，期间允许<2b碎片；Rust按read/受限chunk归一化，persistent live blocks严格ceil(R/b)，支持v3整个dense node输出导致的任意长child segment。后者必须使用logical peek/visit，不能继续原cursor/b定位。
- §13认为为省一层一个块加入别名状态可能不划算。我们的v5新增simple_stream消融：保留其他优化，关闭relocation，以R+2D+4供给。是否首选由速度、内存、维护成本的实际对照决定，不能为了1b常数硬保留慢路径。
- §16整node dense scatter候选只预留跨桶边界、动态复用内部块，需要约2R活块以及共享边界证明；我们的v3/v4/v5仅在size<=R*b且ceil(size/b)<=free时预留整个dense output。没有将它放宽到任意大node，没有声称已经实现材料的无界候选。
- §5保留完整终止块的C+E表示有真正的性能潜力。我们当前完成结果仍是单dense writer，因此叶子记录都再次写入writer；不能把“保留C”和当前实现性能混用。parent提出的all-children<=128终止融合与C+E进一步改造将作为独立实验，而非悄悄改变finalizer证明。
- §11少digit仍多搬移的两个反例直接解释我们uniform u32仍慢的风险：当前节点访问量虽低，但全node histogram、leaf gather、writer追加、tail packing和最终置换都要计费。v5 bulk只改善这些操作的实现成本，不从数学上消除记录搬移。
- 并行根、worker固定预算回收、自适应前沿、batch barrier/evacuation只存在材料的抽象模型；Rust当前未实现并行，不能把模型中的调度/容量定理宣称为Rust并发安全。

模型使用逐记录tag/Python字典/集合来发现覆盖、重复/丢失和释放错误，不是低空间元数据布局；模型内存与时间不能替代Rust实际峰值堆和CPU benchmark。model不同输入有重叠，不能相加成不同输入总数。

已检查后重新执行的有限模型：

- `independent_endpoint_check.py`：72,285 cases；149,012 endpoint merges；1,143,886 records relocated，全部检查通过。结果为 `endpoint-rerun.json`。
- `model_edge_cases.py`：base、retained、normalized各320cases，结果 `edge-rerun.json`。这些case跨模型重叠，不合并成960个不同输入。
- `batch_negative_tests.py`：两个故意破坏协议的模型都如预期损坏数据，结果 `negative-rerun.json`。这是反例验证成功，不是正确算法在这些协议下通过。

未重跑模型包内全部大规模穷举和并行调度模型。原上传summary仍只是用户提供的既有检查记录，不冒称本轮运行结果。
