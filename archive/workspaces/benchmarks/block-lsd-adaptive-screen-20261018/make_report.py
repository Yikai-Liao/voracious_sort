#!/usr/bin/env python3
"""Describe the final decision without combining candidate versions."""
import csv
import hashlib
import json
from pathlib import Path
import re

ROOT=Path(__file__).resolve().parent


def main():
    decision=json.loads((ROOT/'FINAL-DECISION.json').read_text())
    stage=ROOT/decision['final_stage']
    rows=list(csv.DictReader((stage/'comparison.csv').open()))
    raw={mode:[json.loads(x) for x in (stage/f'{mode}.jsonl').read_text().splitlines()]
         for mode in ['time','memory']}
    assert len(raw['time'])==18*len(rows) and len(raw['memory'])==9*len(rows)
    assert all(r['valid'] and r['ordered'] and r['preserved'] for rs in raw.values() for r in rs)
    heap_equal=all(int(r['before_peak_bytes'])==int(r['after_peak_bytes']) for r in rows)
    procs=[json.loads(x) for mode in ['time','memory'] for x in (stage/f'{mode}-processes.jsonl').read_text().splitlines()]
    assert len(procs)==2*len(rows)
    assert all(p['returncode']==0 and int(re.search(r'VmSwap:\s+(\d+)',p['stderr'])[1])==0 for p in procs)
    audit=dict(conditions=len(rows),time_observations=len(raw['time']),memory_observations=len(raw['memory']),
               all_full_outputs_equal=True,all_peak_heap_equal=heap_equal,
               all_process_end_VmSwap_zero=True,
               source_sha256=hashlib.sha256((stage/'harness/source/pr/src/sorts/block_lsd_stable_sort.rs').read_bytes()).hexdigest(),
               decision=decision,
               files={str(p.relative_to(ROOT)):hashlib.sha256(p.read_bytes()).hexdigest()
                      for p in [stage/'manifest.json',stage/'time.jsonl',stage/'memory.jsonl',stage/'comparison.csv',ROOT/'final-tests.log']})
    (ROOT/'verification.json').write_text(json.dumps(audit,indent=2)+'\n')
    relevant=[r for r in rows if r['dist'] in ['all_equal','late_difference']]
    table='\n'.join(f"| {r['kind']} | {r['dist']} | {int(r['n']):,} | {float(r['paired_ratio']):.3f} | {float(r['ratio_min']):.3f}–{float(r['ratio_max']):.3f} | {float(r['aa_min']):.3f}–{float(r['aa_max']):.3f} |" for r in relevant)
    old=list(csv.DictReader((ROOT/'prefix-confirmation/comparison.csv').open()))
    old_floats=[r for r in old if r['kind'] in ['f32','f64'] and r['dist']=='all_equal']
    old_text='、'.join(f"{r['kind']} 全相等慢 {(float(r['paired_ratio'])-1)*100:.1f}%" for r in old_floats)
    outcome='仅接受前缀扫描复用。' if decision['status']=='accepted_prefix_only' else '不采用本轮任何生产补丁，恢复原版。'
    text=f'''# Block LSD 改进评估结果

{outcome} {decision['reason']}

单元素错位识别、固定两段归并草稿都已撤回。其余慢场景的通用方案需要新增有序段调度与空间受限的稳定归并，当前没有足够证据支持引入这套机制，见 [判断依据](ASSESSMENT.md)。不宣称修复 push-front、push-middle 或 organ-pipe。

原版始终保存在 `origin/archive/block-lsd-original-20261018`，commit `e649c6af49d6bfdde896ca40cad387235fce4bfa`。原工作区未修改；实验工作区和原始数据独立保留。

## 候选版本与拒绝依据

最初通过短筛查的前缀复用版本，在 109 条件确认中暴露了 {old_text}；两项六次配对均比同条件 A/A 完整对称包络更慢，因此拒绝。完整时间观测保留，内存测量在拒绝后停止，不算完成验收。该轮数据不能当作后续实现的成绩。

最后的局部尝试只把索引计算移到发现差异后的出口，根据迭代器剩余长度计算位置。没有新增类型分支、单元素识别或特定分布分支。其冻结版本为 `{decision['final_stage']}`。

## 最后版本的逐条件观察

after/before 小于 1 表示候选快。范围均是同一类型、分布、规模下的六次配对观测，不混合数据类型，也不是置信区间。

| 类型 | 分布 | n | 中位 after/before | 六次配对范围 | 同函数 A/A 范围 |
| --- | --- | ---: | ---: | ---: | ---: |
{table}

全部条件，包括普通输入的损失，见 [{decision['final_stage']}/comparison.csv]({decision['final_stage']}/comparison.csv)。这里只描述重复观测及 A/A，不把几个百分点的差别当作已证实的收益。

## 验证与复现

最后版本覆盖 {len(rows)} 个条件，{len(raw['time']):,} 条时间观测和 {len(raw['memory']):,} 条独立内存观测，全部通过 converted-key 稳定完整输出 oracle，包括 payload 与相等键顺序。两版的峰值请求堆内存{'全部相同' if heap_equal else '逐条件保留在 CSV 中'}，都通过原始 Block LSD 堆上界。所有进程正常退出且结束时 VmSwap=0。源码与数据摘要见 [verification.json](verification.json)，正确性测试见 [final-tests.log](final-tests.log)。

两版都使用 radix 8、相同 `max(1, floor(1024/s), ceil(4*sqrt(9*n/(512*s))))` 块长。每条件 3 seed 各作正反顺序，固定 CPU 2、单线程。整次排序、探测和排序内部的分配计时；输入复制、策略计算和完整 oracle 排除。逐观测热身，独立预复制输入，3 ms 目标批次和 64 MiB/2048 个输入缓冲上限；不代表冷缓存。计时与分配追踪是两个独立构建的程序。`block_before_aa` 调用与原版相同的函数。

源码、二进制摘要和调度在 [{decision['final_stage']}/manifest.json]({decision['final_stage']}/manifest.json)。历史候选各有独立目录与状态，不混合观测。重算最后的表格无需重跑排序：

```sh
python3 analyze_screen.py {decision['final_stage']}
python3 make_report.py
```

此前原版与其他算法的图、块长研究和数据归档保持不变。新主图按九种类型分面，不再把跨类型差异画成误差范围，见 [原版研究报告](../block-lsd-pr-20261018-story/REPORT.md)。
'''
    (ROOT/'RESULTS.md').write_text(text)
    print(json.dumps(audit,indent=2))


if __name__=='__main__':main()
