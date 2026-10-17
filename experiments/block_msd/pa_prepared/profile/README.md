# u16稀疏输入的诊断采样

本目录记录冻结提交`609e8c0cde4812d18d2cec2701a035f13d1dffca`及`../binary-sha256.txt`中的time ELF。软件事件`cpu-clock:u`、997Hz、DWARF调用栈8192字节，固定CPU2，对1,048,576条/B64/seed42/u16/sparse的prepared方法执行128次。完整参数见`metadata.json`。

采样覆盖进程中的输入生成、warmup、输入恢复、排序和完整oracle。649个样本、无丢样；`perf-symbols.txt`给出step 53.00%、compact 7.09%、visit 2.31%的全进程用户态采样份额。它们不是排序phase比例，也不表示硬件cycles或IPC。`u16-sparse.csv`是在perf下产生的诊断时间，排除在正式672行时间、summary和noise之外。

`u16-sparse.data`原始文件保留5,509,014字节，纳入总证据hash。`block-source.rs`逐字节等于固定提交的`experiments/block_msd/src/frontier/block.rs`；旧ELF的DWARF行号和`step-objdump.txt`只配合此快照阅读，不能对照随后变化的工作树block.rs。

两次`perf annotate`（第二次加`--no-source`）都以SIGSEGV/139退出，留下零字节`perf-step.txt`及`perf-step-asm.txt`。崩溃的是分析工具，未发生排序器崩溃。停止重试后使用成功的perf report与ELF objdump；失败参数及状态保存在`status.json`。

以下是已执行的历史采样命令，保存用于审计，不要覆盖原件重新执行：

```bash
perf record -o experiments/block_msd/pa_prepared/profile/u16-sparse.data -e cpu-clock:u -F 997 --call-graph dwarf,8192 -- taskset -c 2 experiments/block_msd/target/pa-prepared/time 1048576 128 Pa_unified_prepared_t16777216 sparse u16 time 64 42 > experiments/block_msd/pa_prepared/profile/u16-sparse.csv 2> experiments/block_msd/pa_prepared/profile/perf-record.log
```

以下只分析已存数据/ELF，不运行排序。输出到终端可与保存的`perf-symbols.txt`、`perf-lines.txt`、`step-objdump.txt`比较；不调用失败的annotate。使用前核对ELF和证据清单hash。

```bash
perf report -i experiments/block_msd/pa_prepared/profile/u16-sparse.data --stdio --no-children --sort symbol --percent-limit 0.5 --call-graph none
perf report -i experiments/block_msd/pa_prepared/profile/u16-sparse.data --stdio --no-children --sort symbol,srcline --percent-limit 1 --call-graph none
objdump -d -C --start-address=0x1922f0 --stop-address=0x192c50 experiments/block_msd/target/pa-prepared/time
```

原报告中的源码行号来自冻结ELF的调试信息，源码正文以本目录快照为准。样本数量有限，只能定位后续研究方向；本目录没有产生ASan、work、heap或新性能通过结论。
