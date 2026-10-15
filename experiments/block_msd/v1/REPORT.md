# Dense partial block MSD：研究原型

本原型把论文 §7 的 dense partial 思路落实成了一个可运行的稳定 MSD 排序，保留其数据块并通过 DFS 共享块池。它只位于独立实验项目中，未接入库 API 或 dispatcher。通过有限测试支持实现正确性；下面的证明是设计级证明，需要独立审查，不能把它当成已经完成同行评审的论文成果。

来源：[Clausecker / Schintke 2026 论文 §7](https://arxiv.org/html/2607.05302v1)，本地作者 C 仓库固定 revision `f69e816c3cd79d312cd67aea5b9cf1c338c1b371` 的 `paper/paper.tex` 916–934 行。原文提出将每层 σ 个 partial 尾块拼成 dense 块，额外记录桶边界；作者未实现和评估这种 MSD。

## 模型与契约

单线程 RAM 模型，输入 n 个定长、Copy 元素，元素宽度 s bytes；转换后的键 W bits，digit 宽度 r∈1..=8，σ=2^r，最大深度 d=ceil(W/r)，每块 b 元素。排序次序是仓库现有 `Radixable<K>::into_key_type()` 的升序；相等转换键保持输入顺序。使用已有 `Radixable`、`RadixKey`，无新 trait，不要求 Default。signed 和 floats 使用现有转换规则。自定义 extract 必须与转换键一致，且返回合法桶索引。

实验公共入口名为 `block_msd_stable_radixsort(arr, radix, block_size)`，返回诊断 Stats；这个返回值只是实验接口，不建议直接成为生产 API。`block_msd_stable_radixsort_body(...,leaf_limit)` 允许在 0..=32 中指定叶子阈值，0 强制纯 block 路径；默认 32 使用至多 32T 的稳定插入排序，比较转换键，避免 `PartialOrd` 与 key 不一致。

## 表示与不变量

输入的 floor(n/b) 个物理整块与 `(σ+2d+4)` 个 scratch 整块组成一个固定 arena。输入最后不足 b 的尾部只在初始化复制、最后恢复；不拿它充当可重用整块。block ID 唯一；free 列表中的 ID 没有逻辑有效元素，live ID 不得二次释放。所有存储均初始化，raw pointer 从不触及未初始化 T 或已释放的 Vec。原型保留 bounds/live assertions。

一个待处理桶包含按稳定顺序排列的整块 ID，和 parent dense tail stream 中紧接前一个兄弟的 tail 长度。子桶之间的 tail 拼在同一 stream，允许边界穿过物理块。每个 stream 保留 block IDs、有效总长度、消费 cursor。兄弟严格按 digit 升序、DFS 顺序消费，cursor 单调推进；一个 dense 块读完即归还共享池。最后不足整块的 stream，在其有效元素读完时释放。每层最多产生一个这样的 stream。

当前 node 为每个 digit 预留一个输出 head，按照逻辑输入顺序 scatter；head 满时将 ID 加入对应桶的 full 列表，立即换一个 head。读完一个输入整块才释放，所以无覆盖尚未读取输入的风险。所有新 head 从 free 池取得。

scatter 完成后，只把各桶的不足 b 个尾元素按 digit 序写入 dense stream；整块数据保持原位，仅迁移 ID。各桶记录 tail 长度，建立下一层的逻辑边界。所有旧 head 都在 recurse 之前释放。

terminal 桶按逻辑顺序写入一个全局 dense final stream。final stream 满块即保留 ID。完成所有 DFS 后只做一次物理整块置换：若目标位置包含尚未输出的数据块，交换两块并更新 inverse 映射；否则覆盖 dead 块。最后恢复输入尾部。没有逐层 compact 到连续 slice，也没有 nT scatter buffer。

## 稳定性与正确性推导

1. 根桶的 full 列表加 root tail 是原始输入序列。假设 node 的 full 列表加 parent tail segment 表示该前缀桶的稳定输入序列。
2. 顺序 scatter 对每个 digit 输出一个 subsequence；同一 digit 内 full heads 和最后 partial head 的串接保持此 subsequence 次序。
3. 按 digit 序 dense-pack partial 只复制各 partial 内原序列，长度与边界足以恢复每个桶。下一层 full 加 tail 恰好是稳定 subsequence，归纳不变量成立。
4. DFS 按 digit 升序输出。对于第一处不同 digit 的两个键，较小 digit 桶完整地先输出；全部 digit 相同的键始终在同一桶且每层保持次序。常量前缀由 union/intersection 扫描跳过，不能改变比较结果。小叶子插入只移动严格大于当前 key 的元素，因此相等键保持原序。
5. final writer 顺序拼接 terminal 桶得到稳定排序序列。最终置换仅迁移物理表示，inverse 在每次交换后仍指向未完成输出的 block ID，所以输出不变。

这比“把 LSD rounds 倒过来”多了实际的 MSD bucket recursion、tail 边界、跨层共享池和 final stream。全局用倒序 LSD rounds 会使最后低位成为最高优先级，不能实现 MSD。

## 全部空间界

必须分清论文的 partial overhead 和整个排序内存。以下计入排列/ID、free/live、所有活跃祖先的 Vec 容量、final 输出 ID 与最后 inverse，不只数元素 scratch。

每个祖先 dense stream 有两种空隙：首块已被前面兄弟消费的 prefix，以及末块不足整块的 padding，各自 <b。直接只读 stream 因此要保守计入 **2b/层**，不能未经实现就声称作者所设想的 1b/层。current scatter 的 σ 个 heads 最多 σb 空位；current input block 读完前的已消费 prefix <b；global final writer 的未满末块 <b；尾部 packing 暂时复制一个 head、以及对齐剩余，再留 2b。因此 `(σ+2d+4)b` scratch 是保守供应界。叶子外部 buffer 另有至多 32T；Copy 读写的单元素 transient 是 O(T)。

DFS frontier 上待处理 full 块和 final full 块的 live IDs 总数 O(n/b)；scatter 前后的输入/输出 ID 可短暂同时存在，仍 O(n/b)。每个 frame 最多 σ 个 Bucket descriptor、tail 长度和 dense-tail IDs；dense stream 每层长度 <σb，至多 σ blocks，其 IDs 即使已消费但 Vec 尚未 drop 也要计入 O(σd)。Vec 容量倍增只改变常数。free/live 全局表和 final inverse 另计 O(n/b+σ+d)。叶子释放source后，free Vec可临时比其初始scratch容量长ceil(32/b)，加上容量倍增仍在此界。Bucket.full的input IntoIter保存整个输入ID allocation直到当前scatter循环结束，但它在子递归开始前已经drop；父层IntoIter保留σ个Bucket对象和deferred siblings，其full-ID内容属于尚未消费的frontier。不会每层各保留一个根规模ID Vec。调用栈 O(d) frames。

完整额外空间为：

`M = O(s [σb + 2bd + 32] + w [n/b + σd]) bytes`，w 是机器字宽 bytes。

scratch 元素精确分配 `s(σ+2d+4)b` bytes，其他 Vec 由 benchmark 的 allocator 峰值实测。fixed b 不给 O(√n) 总空间，因为 n/b metadata 随 n 增长。固定 σ、d、s 时 b=Θ(√n) 才得到 O(√n)。若 σ、d 作为变量，按主项平衡可选 `b≈sqrt(c_metadata*w*n / [s(σ+2d+4)])`；于是空间含 `O(sqrt(s*w*n*(σ+2d)) + wσd + 32s)`。c_metadata 代表实际同时持有的 ID 表容量常数，不能把它假装成已校准的性能模型。

这个方案比为每层每桶独立保留 partial 块的 O(σbd) 元素 slack 小，特别是宽键、深 recursion；它尚未实现作者的每层只有一块 slack 的常数。

## 工作量与参数

每层的 key union/intersection scan 和 scatter 对每个输入元素至多常数次访问，tail packing 每个 node 至多移动其输入元素数，DFS final writer 与置换额外 O(n) 数据移动。terminal 叶子阈值是固定32，插入最多 O(32n)。若实际 branching node 数为 N，初始化 bucket/head 和遍历 digit 需 O(σN)。跳过常量 prefix 后每个内部节点至少两个非空孩子，所以 N≤n−1；总工作 `O(nd+σN+n)`，固定 σ 时线性于 nd；把 σ 作为变量时不能漏掉 σN。

默认32叶子用于控制 σN 的常数。它不依赖类型或负载分类。原型仍频繁分配 Vec<Bucket> 和小 full-ID Vec，还做 scalar checked block access；存在明显的未优化成本。

超参数的更本质控制量是明确的 workspace budget 与有效活动集，而不是预先测出一张类型/负载查表。理论式给出内存平衡 b；缓存约束可限制 current heads 的 `σ*b*s`，并纳入正在消费的 source/packed-tail 工作集。内存最小点不等于速度甜点：b 小会增加 ID 管理和频繁块切换，b 大使 heads 超出缓存，并增加初始化 scratch 和尾部 packing 成本。不能仅从元素宽度断言最优 b，也不能从本实验三个候选点宣称找到普适最优值。

## 验证和复现

`./run.sh` 执行 debug/release 测试、release 编译、CPU0 两组 benchmark。测试包含 5 个 radix、8 个 block size、空/单元素/整块前后边界、按输入序号检查完整 record 稳定性、signed extrema、随机 u128/i128/i64/u32、偏斜、float ±0 和 infinities，以及长度2..10的全部二值键序列。每个测试同时验证 default32和pure0路径；pure0反转输入后重新建立稳定 oracle。

使用 `sort_by_key(into_key_type)` 建立稳定参考，比较整个 record，包括 serial 和 payload。对浮点测试不含 NaN，因此 PartialEq 可直接验证；已补无效radix/block0 panic与ZST测试，以及逐元素转换key比较，因此±0的PartialEq不会掩盖次序错误。浮点NaN bit payload、自定义extract panic和异常安全没有验证。debug、release与AddressSanitizer均通过6个测试函数，包含超过一万次默认/纯block路径与oracle比较。ASan复现命令：`RUSTC_BOOTSTRAP=1 RUSTFLAGS='-Zsanitizer=address' cargo test --manifest-path experiments/block_msd/Cargo.toml --target x86_64-unknown-linux-gnu --test correctness`。未运行Miri或独立证明审查，也未覆盖极大分配溢出或allocation failure。实现中的 unchecked usize 算术仍须生产化处理。

benchmark 的生成/clone/稳定参考/输出验证都在计时外。计时3次取中位数，allocator 计数关闭；额外做一次独立排序开启 allocator 计数，测 requested heap bytes 的增量峰值，包含排序内部全部 scratch/Vec 与祖先 retained buffers，排除输入、参考和 clone。不含 allocator header、线程栈和 RSS。当前 benchmark 使用自定义 wrapper 的轻量 atomic branch，即使计数关闭仍有 branch 开销；没有跨机器或大样本置信区间。算法顺序固定 dense MSD→block LSD→现有 stable MSD。

负载为 uniform、95% zero + 5% random，以及共享高位前缀只变低24bits。类型是 u32、u128、u128-key32B record、u32-key128B record。注意把同一 u128 随机数据截为 u32 后，共享前缀负载对 u32 只有24bit活动键，没有实际高64bit共同前缀。radix=8，b=16/64/256；这些点是验证模型的测量样本，没有导出库内查表。

## 本机结果

测量机器 AMD Ryzen 7 8845H（8 cores / 16 threads），Linux x86_64；`rustc 1.99.0 (b940084d7 2026-09-28)`，release默认目标，没有native target-cpu。CPU0绑定，3次中位数，主agent同时停止计时/编译/绘图。全部216条算法/配置结果通过完整record oracle；这并不保证环境没有其他进程波动。

n=1,000,000、r=8、b=64，以下每格为“毫秒 / 额外峰值MiB”。

|元素类型|负载|dense MSD|block LSD|现有 stable MSD|
|---|---|---:|---:|---:|
|u32|uniform|45.63 / 0.342|7.22 / 0.275|10.98 / 3.846|
|u32|skew95|22.81 / 0.359|6.88 / 0.275|6.88 / 14.719|
|u32|shared_prefix|46.18 / 0.342|5.65 / 0.275|11.12 / 3.846|
|u128|uniform|58.85 / 0.562|77.19 / 0.650|36.45 / 15.337|
|u128|skew95|38.84 / 0.587|41.29 / 0.650|182.60 / 232.825|
|u128|shared_prefix|56.68 / 0.562|14.77 / 0.650|154.34 / 213.802|
|wide32|uniform|65.16 / 0.847|126.36 / 1.150|36.71 / 30.659|
|wide32|skew95|49.87 / 0.872|60.51 / 1.150|349.77 / 465.525|
|wide32|shared_prefix|63.53 / 0.847|24.87 / 1.150|372.07 / 427.487|
|large128|uniform|156.18 / 2.371|146.31 / 4.150|145.26 / 122.592|
|large128|skew95|84.43 / 2.387|75.33 / 4.150|376.71 / 470.029|
|large128|shared_prefix|159.90 / 2.371|108.88 / 4.150|146.81 / 122.586|

u32-uniform 下原型比 block LSD慢约6.3倍；32B宽键uniform下约快1.9倍，但仍比现有MSD慢约1.8倍。这直接否定“只测u32可代表泛型性能”。95%重复宽键记录下原型相对现有MSD大幅降低祖先buffer占用：465.525 MiB降至0.872 MiB，并且349.77 ms降至49.87 ms。shared-prefix记录也降低了现有MSD的祖先buffer内存，但block LSD跳过共同digit之后速度依然更快。内存改善并不蕴含速度全面改善。

三个b候选对原型的影响（n=1m；每格毫秒/峰值MiB）：

|类型|负载|b16|b64|b256|
|---|---|---:|---:|---:|
|u32|uniform|47.60 / 1.088|45.63 / 0.342|45.27 / 0.340|
|u32|skew95|24.15 / 1.128|22.81 / 0.359|24.56 / 0.350|
|wide32|uniform|71.37 / 1.216|65.16 / 0.847|64.22 / 2.360|
|wide32|skew95|53.91 / 1.262|49.87 / 0.872|47.27 / 2.377|
|large128|uniform|166.49 / 1.595|156.18 / 2.371|172.42 / 8.453|
|large128|skew95|79.72 / 1.635|84.43 / 2.387|85.85 / 8.463|

该扫描只是少量候选样本，不能定位连续最优点；测量没有固化为类型/负载超参表。较大块使metadata减少，但较宽记录下scratch和head活动集增加很快，测得的速度/内存曲线不同。因此可实施的参数设计应先接受明确额外内存预算，再根据理论模型求可行b区间；缓存上界作为另一条约束。两条约束冲突时必须向调用者表达，而不能偷偷用负载标签查表。

## 未解决工作

- 把只读tail stream的每层2b碎片常数降至作者设想的1b，需要在消费过程中维护密集尾块或更复杂的分段/共享边界所有权。这里只提出需保留已消费首块与未满末块两种空隙的计数，没有声称1b不可达到。
- 原型完成单线程可运行算法与有限验证，没有实现并行block MSD、共享池并发调度或跨度界。
- 需要独立审查arena容量证明与raw-pointer别名证明；ASan检测不到所有Rust别名违规，Miri仍未运行。
- 尚未优化σ-way节点setup、leaf allocator和full-ID Vec容量。可复用库traits/key conversion、mask操作和现有稳定oracle；当前LSD Sorter封装假设单一σ partial数组，不能直接把它的step变成MSD recurse。共享Arena/stream应先在实验中稳定，不能为了复用而让LSD生产代码承担未验证的状态。
- 需要用checked算术处理scratch/总block数、根metadata容量，澄清极大分配与panic行为，完成公共函数文档与生产接口审查。此研究不建议现在把MSD一起纳入LSD PR。
