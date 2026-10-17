# 复现Pa变化位复用阶段

在仓库根目录执行。源码固定为 `609e8c0cde4812d18d2cec2701a035f13d1dffca`，156项源码/Cargo文件见`source-sha256.txt`；`validate.py`使用该提交的`git show`核对，不依赖当前工作树。time ELF为`experiments/block_msd/target/pa-prepared/time`，hash见`binary-sha256.txt`。后续源码可能已改变，不要覆盖历史ELF或用当前源码解释旧汇编。

## 核对和分析现有证据

下面命令不编译、不运行排序。证据清单路径相对仓库根目录，包含原始perf.data、冻结block快照和工具失败记录。`validate.py`核对正式测量的行数、slot/rep、输入地址及源码/ELF；profile的额外核对记录在`validation/evidence-final.log`。

```bash
sha256sum -c experiments/block_msd/pa_prepared/evidence-sha256.txt
PYTHONDONTWRITEBYTECODE=1 python3 experiments/block_msd/pa_prepared/validate.py

for pa_prepared_stem in screen-narrow-b64-s42 screen-large-b512-s42 screen-medium-b64-s42 screen-known-skew-b64-s42
do
  PYTHONDONTWRITEBYTECODE=1 python3 experiments/block_msd/pa_prepared/analyze.py "experiments/block_msd/pa_prepared/measurements/${pa_prepared_stem}.csv" --out "summary-${pa_prepared_stem}.csv"
  PYTHONDONTWRITEBYTECODE=1 python3 experiments/block_msd/pa_prepared/noise.py "experiments/block_msd/pa_prepared/measurements/${pa_prepared_stem}.csv" > "experiments/block_msd/pa_prepared/noise-${pa_prepared_stem}.csv"
done
```

摘要按文件、layout/case/n/B分组；本轮各文件只有seed42。Pa的配对分母为同rep两个固定slot时间的均值，A/A为固定后slot/前slot，与实际执行先后无关。其他对照使用同rep单slot时间。报告中的prepared/cache、prepared/reuse等先逐rep相除，再取中位数，完整复算值见`validation/report-check.log`。线性插值分位数采用`analyze.py`的定义，不跨文件、n、B或seed合并rep。既有analyze控制台的跨case摘要不作为Goal验收结论。

## 使用冻结ELF重新计时

以下命令会运行排序。先核对ELF hash和CPU2可用，按顺序执行，计时期间不要同时编译或跑其他基准。runner拒绝覆盖已有CSV，复测使用`rerun-`名称。warmup、输入恢复和完整稳定oracle在计时外；排序内部工作区申请/释放在计时内。JSON保存命令、起止时刻、load/memory快照及child rusage。

```bash
pa_prepared_methods=Pa,Pa_band,Pa_unified_cache_t16777216,Pa_unified_sample_t16777216,Pa_unified_reuse_t16777216,Pa_unified_prepared_t16777216,stable_msd,Pa
python3 experiments/block_msd/pa_prepared/run.py rerun-screen-narrow-b64-s42 --n 1048576 --reps 4 --seed 42 --block 64 --layouts u8,u16,u8_id8,u16_id8 --cases uniform,sparse --methods "$pa_prepared_methods"
python3 experiments/block_msd/pa_prepared/run.py rerun-screen-large-b512-s42 --n 1048576 --reps 4 --seed 42 --block 512 --layouts large128 --cases uniform,majority_prefix,deep_unique90 --methods "$pa_prepared_methods"
python3 experiments/block_msd/pa_prepared/run.py rerun-screen-medium-b64-s42 --n 262144 --reps 4 --seed 42 --block 64 --layouts u64,u128,wide32 --cases uniform,majority_prefix,deep_unique90 --methods "$pa_prepared_methods"
python3 experiments/block_msd/pa_prepared/run.py rerun-screen-known-skew-b64-s42 --n 1048576 --reps 4 --seed 42 --block 64 --layouts u64 --cases deep_unique90 --methods "$pa_prepared_methods"
```

预期依次256、96、288、32行，共672行。复测单独汇总，不与历史rep合并，也不加入这次冻结清单。`final.sh`、`heldout.sh`和`review_matrix.py`是尚未执行的后续预案；不能把执行预案称为复现已经完成的验证。

若需重建，在独立持久工作树检出固定提交，使用[环境](environment.json)中的Rust/Cargo、release配置和`-C target-cpu=native`，构建到新路径并保存新hash和测量目录。本阶段只冻结time ELF，没有work或ASan二进制及独立work/heap/ASan结果。诊断profile的历史采样、只读分析命令与两次工具失败见[profile说明](profile/README.md)及`profile/status.json`，profile CSV不得加入正式时间摘要。
