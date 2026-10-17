# 复现Pa成本门槛阶段

在仓库根目录执行。源码固定为 `6c66dd970fb33f842c7eff0c70f8cd97c1ceed33`，156项源码/Cargo文件由`source-sha256.txt`固定；`validate.py`使用该提交的`git show`核对，不依赖当前工作树。计时ELF为`experiments/block_msd/target/pa-cache/time`，hash见`binary-sha256.txt`。后续实现与本阶段源码不同，不要用当前源码覆盖该ELF。

## 只核对和分析现有证据

以下命令不编译、不运行排序。`validate.py`同时检查四份测量的完成状态、行数、slot/rep、输入地址和源码/ELF hash。证据总清单的路径相对仓库根目录。

```bash
sha256sum -c experiments/block_msd/pa_cache/evidence-sha256.txt
PYTHONDONTWRITEBYTECODE=1 python3 experiments/block_msd/pa_cache/validate.py

for pa_cache_stem in tune-262144-block64-seed42 tune-1048576-block512-seed42 small-ordered-priority-16384 guards-priority-1048576
do
  PYTHONDONTWRITEBYTECODE=1 python3 experiments/block_msd/pa_cache/analyze.py "experiments/block_msd/pa_cache/measurements/${pa_cache_stem}.csv" --out "summary-${pa_cache_stem}.csv"
  PYTHONDONTWRITEBYTECODE=1 python3 experiments/block_msd/pa_cache/noise.py "experiments/block_msd/pa_cache/measurements/${pa_cache_stem}.csv" > "experiments/block_msd/pa_cache/noise-${pa_cache_stem}.csv"
done
```

摘要逐文件、逐layout/case/n/B分组；同seed/rep的两处Pa取均值作为配对分母。与Stable或off比较时，使用同rep该方法的时间；先逐rep相除，再取中位数。Pa A/A按固定method-list前后slot相除。分位数采用排序后线性插值，完整定义见`analyze.py`和`noise.py`。off在两份调参CSV中为`Pa_unified_cache_toff`，保持统一组合的其他机制。

## 使用冻结ELF重新计时

下面命令会运行排序。先确认ELF hash和CPU2可用，按顺序执行；不要同时编译、跑其他基准或分析大文件。新名称使用`rerun-`前缀，runner拒绝覆盖已有CSV。JSON会记录实际命令、起止时刻、load/memory快照和child rusage。每个方法先warmup，计时包含工作区申请/释放，输入恢复和完整稳定oracle在计时外。

```bash
pa_cache_tune_methods=Pa,Pa_band,Pa_unified_cache_t0,Pa_unified_cache_t262144,Pa_unified_cache_t1048576,Pa_unified_cache_t4194304,Pa_unified_cache_t16777216,Pa_unified_cache_toff,stable_msd,Pa
python3 experiments/block_msd/pa_cache/run.py rerun-tune-262144-block64-seed42 --n 262144 --reps 4 --seed 42 --block 64 --layouts u64,u128,wide32,large128 --cases uniform,majority_prefix,deep_unique90 --methods "$pa_cache_tune_methods"
python3 experiments/block_msd/pa_cache/run.py rerun-tune-1048576-block512-seed42 --n 1048576 --reps 4 --seed 42 --block 512 --layouts u64,u128,wide32,large128 --cases uniform,majority_prefix,deep_unique90 --methods "$pa_cache_tune_methods"

pa_cache_guard_methods=Pa,Pa_band,Pa_unified_cache_t16777216,L_frozen,stable_msd,Pa
python3 experiments/block_msd/pa_cache/run.py rerun-small-ordered-priority-16384 --n 16384 --reps 12 --seed 42 --block 64 --layouts u8,u16,u128,wide32 --cases equal,sorted,reverse --methods "$pa_cache_guard_methods"
python3 experiments/block_msd/pa_cache/run.py rerun-guards-priority-1048576 --n 1048576 --reps 12 --seed 42 --block 64 --layouts u8,u16,u32,u64,u128,u8_id8,u16_id8,small8,wide32,large128 --cases uniform,sparse --methods "$pa_cache_guard_methods"
```

两份调参各480行，顺序保护864行，普通/稀疏保护1,440行。复测文件应单独汇总，不与历史rep合并，也不加入本阶段冻结清单。历史`screen.sh`记录早期计划，本轮实际执行以四份原始JSON命令及上述命令为准。

若需重建，在独立持久工作树检出固定提交，用[环境记录](environment.json)中的Rust/Cargo、release配置及`-C target-cpu=native`构建到新路径，核对新ELF后另建测量目录；不要覆盖历史源码清单、time ELF或测量。此阶段没有冻结work ELF，不能据此运行`--kind work`或声称已有工作量/内存/ASan验证。
