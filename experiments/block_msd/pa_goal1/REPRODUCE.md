# 复现独立首屏

源码提交见source-commit.txt；156个源码/Cargo文件与time ELF已冻结。旧实验不跟踪ELF，binary-sha256记录本机已测文件。新工作树按同样Rust 1.98.1、native flags构建，路径和debug信息可能导致ELF hash变化，应记录新hash。

```bash
git worktree add --detach /root/code/voracious-sort-goal1-reproduce 1de8000
cp -a /root/code/voracious_sort-pa-unified/experiments/block_msd/pa_goal1 /root/code/voracious-sort-goal1-reproduce/experiments/block_msd/
cd /root/code/voracious-sort-goal1-reproduce
mkdir -p experiments/block_msd/target/pa-goal1
RUSTFLAGS='-C target-cpu=native' /root/.cargo/bin/cargo build --manifest-path experiments/block_msd/Cargo.toml --release --bin frontier_experiment
cp experiments/block_msd/target/release/frontier_experiment experiments/block_msd/target/pa-goal1/time
RUSTFLAGS='-C target-cpu=native' /root/.cargo/bin/cargo test --manifest-path experiments/block_msd/Cargo.toml --lib --features frontier_work frontier::
```

先完成全部构建和测试，再执行计时。screen.sh给出首屏命令；run.py拒绝覆盖文件，因此应换新的name或将新副本measurements移到另处保留。每个原始文件的JSON给出实际命令、起止时间、资源快照和child rusage。CPU2单工作线程，工作区申请/释放在计时内，输入恢复/oracle在外；不混用插桩time。这个首屏没有work/ASan/heap结果，不能当作后续最终变体的完整证据。

```bash
python3 experiments/block_msd/pa_goal1/validate.py
python3 experiments/block_msd/pa_goal1/analyze.py experiments/block_msd/pa_goal1/measurements/skew-regression-1048576.csv --out rerun-summary.csv
```

后续参数化改动不影响此源码快照；不要用当前源码重建后覆盖旧time ELF。
