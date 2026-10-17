# 复现采样成本门与缩桶首屏

在仓库根目录执行。固定源码为 `a435c728117675abc515463f784d74e14743d7a3`，156项源码/Cargo文件由`source-sha256.txt`固定；`validate.py`通过该提交的`git show`核对，不依赖当前工作树。time ELF为`experiments/block_msd/target/pa-guard/time`，hash见`binary-sha256.txt`。后续源码可能已改变，不要用当前源码覆盖这个ELF。

## 核对和分析现有证据

以下命令不编译、不运行排序。证据总清单的路径相对仓库根目录。`validate.py`同时检查三份测量的完成状态、行数、slot/rep、输入地址和源码/ELF hash。

```bash
sha256sum -c experiments/block_msd/pa_guard/evidence-sha256.txt
PYTHONDONTWRITEBYTECODE=1 python3 experiments/block_msd/pa_guard/validate.py

for pa_guard_stem in screen-narrow-b64-s42 screen-large-b512-s42 screen-medium-b64-s42
do
  PYTHONDONTWRITEBYTECODE=1 python3 experiments/block_msd/pa_guard/analyze.py "experiments/block_msd/pa_guard/measurements/${pa_guard_stem}.csv" --out "summary-${pa_guard_stem}.csv"
  PYTHONDONTWRITEBYTECODE=1 python3 experiments/block_msd/pa_guard/noise.py "experiments/block_msd/pa_guard/measurements/${pa_guard_stem}.csv" > "experiments/block_msd/pa_guard/noise-${pa_guard_stem}.csv"
done
```

摘要按文件、layout/case/n/B分组；同seed/rep两处Pa的均值作为Pa配对分母。与cache、Stable等单slot方法比较时，先逐rep相除，再取中位数。摘要直接给出对Pa、Stable MSD和Frozen LSD的配对统计；报告中的sample/cache、radix/cache、组合/cache从同一原始CSV逐rep计算，复算值见`validation/report-check.log`。Pa A/A按固定method-list后slot/前slot计算。分位数采用排序后的线性插值，定义见`analyze.py`和`noise.py`；不跨文件、n或B合并rep。

## 使用冻结ELF重新计时

下面命令会运行排序。先核对ELF hash和CPU2可用，按顺序执行；计时期间不要同时编译或跑其他基准。runner拒绝覆盖现有CSV，复测使用`rerun-`名称。每项先warmup，正式计时含排序内部工作区申请/释放，输入恢复与完整稳定oracle在计时外。JSON保存实际命令、起止时刻、load/memory快照和child rusage。

```bash
pa_guard_methods=Pa,Pa_unified_cache_t16777216,Pa_unified_sample_t16777216,Pa_unified_radix_t16777216,Pa_unified_candidate_t16777216,L_frozen,stable_msd,Pa
python3 experiments/block_msd/pa_guard/run.py rerun-screen-narrow-b64-s42 --n 1048576 --reps 4 --seed 42 --block 64 --layouts u8,u16,u8_id8,u16_id8 --cases uniform,sparse --methods "$pa_guard_methods"
python3 experiments/block_msd/pa_guard/run.py rerun-screen-large-b512-s42 --n 1048576 --reps 4 --seed 42 --block 512 --layouts large128 --cases uniform,majority_prefix,deep_unique90 --methods "$pa_guard_methods"
python3 experiments/block_msd/pa_guard/run.py rerun-screen-medium-b64-s42 --n 262144 --reps 4 --seed 42 --block 64 --layouts u64,u128,wide32 --cases uniform,majority_prefix,deep_unique90 --methods "$pa_guard_methods"
```

预期分别256、96、288行，共640行。复测文件单独汇总，不与历史rep合并，也不加入这次冻结证据清单。`screen.sh`与原始JSON保存本轮命令；`final.sh`、`heldout.sh`保留未来验收计划，本阶段未运行，不能把重新执行它们称为复现已完成验证。

如需重建，在独立持久工作树检出固定提交，使用[环境记录](environment.json)中的Rust/Cargo、release配置及`-C target-cpu=native`，构建到新路径并保存新hash和测量目录，不覆盖历史ELF与清单。本阶段只冻结time ELF，未冻结work或ASan二进制，也没有work/heap/ASan测量；任何补测均须独立记录，不能由当前640行time CSV推导这些验证结果。
