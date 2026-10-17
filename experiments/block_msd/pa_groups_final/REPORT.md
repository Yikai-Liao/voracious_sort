# Pa：分组内稳定写入的完整已见种子验证

**Goal 未通过。** 分组方案修复了 u8/u16 稀疏差距，完整重复/全异共享前缀、B512 大记录和中等规模旧负例均保留了相对 Stable MSD 的优势；但普通 u32 键/8 字节记录（small8）在 B64/B512 下仍分别慢约27%/32%。两项都是12/12更慢，线程CPU时间有同样差距。候选保留为下一轮受控基线，主库默认入口未改变，新seed20261018没有执行。

源码固定为 `2513fa5`，156项源码/Cargo文件与4份独立ELF均由清单冻结。排序机制与前一分组首屏相同，只改了等价的私有byte边界断言和旧测试注释。最终构建使用完整10种布局、native CPU、opt3、CGU16、incremental、jobs6、line-tables-only调试信息，未启用窄键screen feature。构建设置变化单列于 BUILD-SETTINGS.md；所有本轮对照来自相同最终ELF，不与旧首屏拼接计时。

## 代表结果

| n / B / layout / case | Groups ms | Stable ms | 配对 Groups/Stable | 更慢次数 |
| --- | ---: | ---: | ---: | ---: |
| 1048576/64/u8/sparse | 3.084 | 3.554 | 0.842 | 1/12 |
| 1048576/64/u16/sparse | 3.133 | 3.617 | 0.858 | 2/12 |
| 1048576/64/small8/uniform | 39.249 | 30.535 | 1.272 | 12/12 |
| 1048576/512/small8/uniform | 40.677 | 29.743 | 1.321 | 12/12 |
| 1048576/512/large128/uniform | 190.804 | 215.824 | 0.904 | 1/12 |
| 1048576/512/large128/majority_prefix | 199.764 | 368.177 | 0.537 | 0/12 |
| 1048576/64/u64/deep_unique90 | 30.248 | 58.756 | 0.496 | 0/12 |
| 1048576/64/wide32/deep_unique98 | 80.703 | 392.670 | 0.206 | 0/12 |
| 262144/64/u128/deep_unique90 | 19.647 | 44.749 | 0.458 | 0/12 |

时间单位ms。配对比按同文件/场景/rep先相除，再取中位数，不是两列中位数相除。主矩阵使用 Pa、Band、Groups、Frozen LSD、Stable MSD、Pa；12次覆盖完整旋转和相邻反向，Pa两个slot提供逐场景A/A。每次恢复同一输入分配，workspace分配包含在sort计时内，输入恢复和完整稳定oracle在计时外。

small8/B64 的 Groups/Stable p10/p90为1.183/1.417，Pa A/A为0.915/1.003，thread-CPU配对中位数1.272。B512对应为1.157/1.417、0.964/1.121和约1.32。两个独立B结构均出现明确缺口，足以阻止验收。Pa和Band在相同cell也有类似耗时，因此这是尚未解决的普通记录成本，不能写成分组修复已覆盖所有普通输入。

宽键顺序/全等还有小差距信号，不能直接判定持平：16384条u128/equal的配对中位比1.251，但p10/p90为0.655/4.551，A/A为0.828/2.141；wide32/sorted为1.112，0.963/1.149，A/A为0.975/1.329。百万条对应u128/equal和wide32/sorted为1.055/1.067，分布仍跨1。这些原始样本全部保留为未解决项，没有以跨场景平均覆盖。

## 独立分组对照与资源

额外的完整ELF窄键表有8个cell、576行。u16/u8 sparse 的 Groups/Prepared配对比为0.746/0.763，Groups/Stable为0.887/0.903；先前u8_id8 sparse的回退信号没有稳定复现，当前为0.963，5/12更慢；u8_id8 uniform为1.049，7/12更慢，p10/p90为0.904/1.261，A/A为0.924/1.131，仍保留噪声边界。这份对照与主表分开分析。

50个工作量cell共200行，逻辑遍历、pass、leaf和record工作与Prepared一致。每个适用block pass增加一次label探针，实际总增量0..10；压紧复制量差异为-256..+128条。62个requested-heap cell共372行，全部峰值与分配次数和Prepared完全相同。大记录B512均匀峰值33589760字节，对照Stable为134784664字节；没有新增整记录输入buffer。完整资源边界与表见 RESOURCES.md，requested heap不等于stack/RSS。

## 正确性和证据

- 当前源码31项debug ASan测试通过（184.00秒，断言/overflow/计数器开启）。
- 当前源码31项release-work测试通过（5.14秒），runner两项方法注册/输入生成测试通过，全部target/feature检查通过。
- 优化ASan程序关闭工作量计数器，7种适用布局、B3/17/64/129/512、n262145，共70行完整稳定oracle通过，stderr全部为空。它们是诊断数据，不进入时间摘要。
- 主表91个cell、6552行，窄键576行、work200行、heap372行，共7700行测量全部完成且通过oracle、slot/rep、输入地址及源码/ELF核验。
- 独立从raw重建8+91个cell的3168个数值字段，与review表全部一致；每份时间CSV各自保留summary和A/A表，不合并不同文件/种子/布局/B。

优化ASan构建本身成功，后续复制归档因磁盘满失败；不完整副本删除后，将成功ELF在同一文件系统移动归档并验证hash，没有重编译或重跑替代失败排序。debug ASan的最初归档脚本也因verbose格式正则不匹配失败，已从成功测试日志定位实际ELF并验证归档。所有失败和恢复记录均保留于validation。磁盘清理仅覆盖本实验已完成的非引用debug缓存、旧调试profile缓存及独立sanitizer构建缓存，当前native release缓存和历史冻结ELF均保留。

## 慢速普通输入的诊断

正式计时全部结束后，对冻结Groups做64次small8/uniform/B64诊断，采集cpu-clock:u、1999Hz、DWARF4096，共6470样本、零丢失。三个逐记录scatter闭包合计4209样本，flat报告约65.06%；汇编确认热循环逐记录调用闭包，并在调用内重载捕获状态。这里的份额覆盖整个进程，包括生成、恢复和oracle，不能解释为sort phase百分比或硬件cycles/IPC。

最初带inline/source解析的perf report出现addr2line sentinel错误，其line/callchain报告不用于归因。关闭inline和callgraph后的flat符号报告stderr为空；实际符号经nm原始名/完整类型匹配，再用objdump验证调用者和callee。profile/small8-uniform保存原始perf、所有工具输出及汇编。下一步是保留原始闭包对照，仅把写入语句直接展开到循环，检验实际消除调用后能否修复这个缺口；尚未实现或宣称收益。

额外机制表mechanisms.sh和heldout.sh均未执行。已见主表失败后不使用新seed挑选代码，也不将历史安全验证等同当前新的优化交付。共享KVM宿主无法保证独占/固定频率，所有分位数均为描述性样本分位数，不是置信区间。
