# 复核散射循环失败首屏

在仓库根目录执行。固定源码提交见source-commit.txt（8fc91c0），156项源码清单由validate.py使用git show核对，后续撤回活动实现不会改变本轮来源。冻结ELF为experiments/block_msd/target/pa-scatter/time，禁止覆盖。

以下只核对现有证据，不编译或计时：

```bash
sha256sum -c experiments/block_msd/pa_scatter/evidence-sha256.txt
PYTHONDONTWRITEBYTECODE=1 python3 experiments/block_msd/pa_scatter/validate.py
PYTHONDONTWRITEBYTECODE=1 python3 experiments/block_msd/pa_scatter/review_screen.py
```

review_screen.py严格读取screen-*.csv、每cell4rep×8固定slot，逐rep计算独立比值与CPU比值；A/A固定为Pa slot7/0。summary/noise使用analyze.py和noise.py，示例：

```bash
PYTHONDONTWRITEBYTECODE=1 python3 experiments/block_msd/pa_scatter/analyze.py experiments/block_msd/pa_scatter/measurements/screen-narrow-b64-s42.csv --out summary-screen-narrow-b64-s42.csv
PYTHONDONTWRITEBYTECODE=1 python3 experiments/block_msd/pa_scatter/noise.py experiments/block_msd/pa_scatter/measurements/screen-narrow-b64-s42.csv
```

统计按文件/n/B/seed/layout/case分开；四次分位数是描述，不是置信区间。report中的比值先逐rep相除再取中位数。原始CSV的Oracle由runner强制，不由分析脚本补做。

若重跑时间，先核对ELF hash并停掉编译及其他基准，参考screen.sh的四条命令，将名称改为rerun-*。runner拒绝覆盖旧CSV。四条命令预期256+96+288+32行；新结果单独保存、分析，不加入历史重复。原始命令与资源快照见对应JSON。

历史构建使用CARGO_INCREMENTAL=0、RUSTFLAGS='-C target-cpu=native'、release opt3/debug=true、默认codegen-units，无frontier_work；同一research target复用依赖产物。Debug测试使用target/pa-guard-debug和frontier_work。构建、测试日志完整保留；若需重建，在新的持久工作树检出固定提交并使用这些历史参数，写新ELF及新hash。未来增量筛选设置不反向套用历史证据。

静态汇编复核只读取冻结ELF：profile/extract_dwarf.py、nm -C -S --defined-only筛选及四个objdump半开区间（original 0x37eab0..0x37f0d7、preload 0x37f0e0..0x37f86a、fixed 0x3d17d0..0x3d72b4、combined 0x3cb920..0x3d17cf）见profile/README.md与导出文件。该目录没有新perf采样或profile时间。

本轮只冻结time ELF。没有work/ASan ELF、独立work/heap/ASan结果；final/heldout/review_matrix属于未执行预案。
