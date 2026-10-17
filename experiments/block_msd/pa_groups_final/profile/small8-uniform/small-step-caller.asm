
experiments/block_msd/target/pa-groups-final/time:     file format elf64-x86-64


Disassembly of section .text:

00000000001773b0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>>:
  1773b0:	55                   	push   %rbp
  1773b1:	41 57                	push   %r15
  1773b3:	41 56                	push   %r14
  1773b5:	41 55                	push   %r13
  1773b7:	41 54                	push   %r12
  1773b9:	53                   	push   %rbx
  1773ba:	48 81 ec c8 00 00 00 	sub    $0xc8,%rsp
  1773c1:	49 89 ff             	mov    %rdi,%r15
  1773c4:	48 bb f8 ff ff ff ff 	movabs $0x7ffffffffffffff8,%rbx
  1773cb:	ff ff 7f 
  1773ce:	4c 8b af 80 00 00 00 	mov    0x80(%rdi),%r13
  1773d5:	4d 89 ee             	mov    %r13,%r14
  1773d8:	49 c1 e6 04          	shl    $0x4,%r14
  1773dc:	4c 89 e8             	mov    %r13,%rax
  1773df:	48 c1 e8 3c          	shr    $0x3c,%rax
  1773e3:	0f 95 c0             	setne  %al
  1773e6:	49 39 de             	cmp    %rbx,%r14
  1773e9:	40 0f 97 c7          	seta   %dil
  1773ed:	40 08 c7             	or     %al,%dil
  1773f0:	74 0b                	je     1773fd <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x4d>
  1773f2:	31 ff                	xor    %edi,%edi
  1773f4:	4c 89 f6             	mov    %r14,%rsi
  1773f7:	ff 15 83 b4 45 00    	call   *0x45b483(%rip)        # 5d2880 <_DYNAMIC+0x260>
  1773fd:	48 89 54 24 20       	mov    %rdx,0x20(%rsp)
  177402:	41 89 cc             	mov    %ecx,%r12d
  177405:	44 89 04 24          	mov    %r8d,(%rsp)
  177409:	4d 85 f6             	test   %r14,%r14
  17740c:	0f 84 a9 00 00 00    	je     1774bb <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x10b>
  177412:	48 89 f5             	mov    %rsi,%rbp
  177415:	ff 15 6d b4 45 00    	call   *0x45b46d(%rip)        # 5d2888 <_DYNAMIC+0x268>
  17741b:	4c 89 f7             	mov    %r14,%rdi
  17741e:	ff 15 6c b4 45 00    	call   *0x45b46c(%rip)        # 5d2890 <malloc@GLIBC_2.2.5>
  177424:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
  177429:	48 85 c0             	test   %rax,%rax
  17742c:	0f 84 0e 27 00 00    	je     179b40 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2790>
  177432:	0f b6 05 af d7 45 00 	movzbl 0x45d7af(%rip),%eax        # 5d4be8 <frontier_experiment::TRACK>
  177439:	84 c0                	test   %al,%al
  17743b:	74 48                	je     177485 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xd5>
  17743d:	f0 48 ff 05 ab d7 45 	lock incq 0x45d7ab(%rip)        # 5d4bf0 <frontier_experiment::ALLOCS>
  177444:	00 
  177445:	f0 4c 01 35 ab d7 45 	lock add %r14,0x45d7ab(%rip)        # 5d4bf8 <frontier_experiment::REQUESTED>
  17744c:	00 
  17744d:	4c 89 f1             	mov    %r14,%rcx
  177450:	f0 48 0f c1 0d 7f d7 	lock xadd %rcx,0x45d77f(%rip)        # 5d4bd8 <frontier_experiment::LIVE>
  177457:	45 00 
  177459:	4c 01 f1             	add    %r14,%rcx
  17745c:	48 8b 05 7d d7 45 00 	mov    0x45d77d(%rip),%rax        # 5d4be0 <frontier_experiment::PEAK>
  177463:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  17746a:	84 00 00 00 00 00 
  177470:	48 39 c8             	cmp    %rcx,%rax
  177473:	48 89 ca             	mov    %rcx,%rdx
  177476:	48 0f 47 d0          	cmova  %rax,%rdx
  17747a:	f0 48 0f b1 15 5d d7 	lock cmpxchg %rdx,0x45d75d(%rip)        # 5d4be0 <frontier_experiment::PEAK>
  177481:	45 00 
  177483:	75 eb                	jne    177470 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xc0>
  177485:	4c 89 6c 24 28       	mov    %r13,0x28(%rsp)
  17748a:	48 89 ee             	mov    %rbp,%rsi
  17748d:	49 83 fd 02          	cmp    $0x2,%r13
  177491:	4c 89 6c 24 78       	mov    %r13,0x78(%rsp)
  177496:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
  17749b:	72 41                	jb     1774de <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x12e>
  17749d:	49 8d 56 f0          	lea    -0x10(%r14),%rdx
  1774a1:	4c 8b 6c 24 50       	mov    0x50(%rsp),%r13
  1774a6:	4c 89 ef             	mov    %r13,%rdi
  1774a9:	31 f6                	xor    %esi,%esi
  1774ab:	ff 15 e7 b3 45 00    	call   *0x45b3e7(%rip)        # 5d2898 <memset@GLIBC_2.2.5>
  1774b1:	4b 8d 04 2e          	lea    (%r14,%r13,1),%rax
  1774b5:	48 83 c0 f0          	add    $0xfffffffffffffff0,%rax
  1774b9:	eb 2d                	jmp    1774e8 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x138>
  1774bb:	b8 08 00 00 00       	mov    $0x8,%eax
  1774c0:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
  1774c5:	48 c7 44 24 28 00 00 	movq   $0x0,0x28(%rsp)
  1774cc:	00 00 
  1774ce:	49 83 fd 02          	cmp    $0x2,%r13
  1774d2:	4c 89 6c 24 78       	mov    %r13,0x78(%rsp)
  1774d7:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
  1774dc:	73 bf                	jae    17749d <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xed>
  1774de:	48 8b 44 24 50       	mov    0x50(%rsp),%rax
  1774e3:	4d 85 ed             	test   %r13,%r13
  1774e6:	74 08                	je     1774f0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x140>
  1774e8:	c5 f8 57 c0          	vxorps %xmm0,%xmm0,%xmm0
  1774ec:	c5 f8 11 00          	vmovups %xmm0,(%rax)
  1774f0:	4d 8b af 80 00 00 00 	mov    0x80(%r15),%r13
  1774f7:	4a 8d 2c ed 00 00 00 	lea    0x0(,%r13,8),%rbp
  1774fe:	00 
  1774ff:	48 b8 00 00 00 00 00 	movabs $0x2000000000000000,%rax
  177506:	00 00 20 
  177509:	48 ff c8             	dec    %rax
  17750c:	49 39 c5             	cmp    %rax,%r13
  17750f:	0f 97 c0             	seta   %al
  177512:	48 39 dd             	cmp    %rbx,%rbp
  177515:	0f 97 c1             	seta   %cl
  177518:	08 c1                	or     %al,%cl
  17751a:	74 15                	je     177531 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x181>
  17751c:	31 ff                	xor    %edi,%edi
  17751e:	48 89 ee             	mov    %rbp,%rsi
  177521:	4c 8b 74 24 28       	mov    0x28(%rsp),%r14
  177526:	ff 15 54 b3 45 00    	call   *0x45b354(%rip)        # 5d2880 <_DYNAMIC+0x260>
  17752c:	e9 2f 26 00 00       	jmp    179b60 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x27b0>
  177531:	48 85 ed             	test   %rbp,%rbp
  177534:	0f 84 91 00 00 00    	je     1775cb <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x21b>
  17753a:	ff 15 48 b3 45 00    	call   *0x45b348(%rip)        # 5d2888 <_DYNAMIC+0x268>
  177540:	48 89 ef             	mov    %rbp,%rdi
  177543:	ff 15 47 b3 45 00    	call   *0x45b347(%rip)        # 5d2890 <malloc@GLIBC_2.2.5>
  177549:	48 85 c0             	test   %rax,%rax
  17754c:	0f 84 fc 25 00 00    	je     179b4e <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x279e>
  177552:	49 89 c0             	mov    %rax,%r8
  177555:	0f b6 05 8c d6 45 00 	movzbl 0x45d68c(%rip),%eax        # 5d4be8 <frontier_experiment::TRACK>
  17755c:	84 c0                	test   %al,%al
  17755e:	48 8b 54 24 20       	mov    0x20(%rsp),%rdx
  177563:	74 40                	je     1775a5 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x1f5>
  177565:	f0 48 ff 05 83 d6 45 	lock incq 0x45d683(%rip)        # 5d4bf0 <frontier_experiment::ALLOCS>
  17756c:	00 
  17756d:	f0 48 01 2d 83 d6 45 	lock add %rbp,0x45d683(%rip)        # 5d4bf8 <frontier_experiment::REQUESTED>
  177574:	00 
  177575:	48 89 e9             	mov    %rbp,%rcx
  177578:	f0 48 0f c1 0d 57 d6 	lock xadd %rcx,0x45d657(%rip)        # 5d4bd8 <frontier_experiment::LIVE>
  17757f:	45 00 
  177581:	48 01 e9             	add    %rbp,%rcx
  177584:	48 8b 05 55 d6 45 00 	mov    0x45d655(%rip),%rax        # 5d4be0 <frontier_experiment::PEAK>
  17758b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  177590:	48 39 c8             	cmp    %rcx,%rax
  177593:	48 89 ce             	mov    %rcx,%rsi
  177596:	48 0f 47 f0          	cmova  %rax,%rsi
  17759a:	f0 48 0f b1 35 3d d6 	lock cmpxchg %rsi,0x45d63d(%rip)        # 5d4be0 <frontier_experiment::PEAK>
  1775a1:	45 00 
  1775a3:	75 eb                	jne    177590 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x1e0>
  1775a5:	4c 89 ac 24 c0 00 00 	mov    %r13,0xc0(%rsp)
  1775ac:	00 
  1775ad:	49 83 fd 02          	cmp    $0x2,%r13
  1775b1:	4c 89 44 24 20       	mov    %r8,0x20(%rsp)
  1775b6:	72 35                	jb     1775ed <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x23d>
  1775b8:	49 83 fd 11          	cmp    $0x11,%r13
  1775bc:	73 44                	jae    177602 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x252>
  1775be:	b9 01 00 00 00       	mov    $0x1,%ecx
  1775c3:	4c 89 c0             	mov    %r8,%rax
  1775c6:	e9 7e 00 00 00       	jmp    177649 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x299>
  1775cb:	41 b8 08 00 00 00    	mov    $0x8,%r8d
  1775d1:	48 c7 84 24 c0 00 00 	movq   $0x0,0xc0(%rsp)
  1775d8:	00 00 00 00 00 
  1775dd:	48 8b 54 24 20       	mov    0x20(%rsp),%rdx
  1775e2:	49 83 fd 02          	cmp    $0x2,%r13
  1775e6:	4c 89 44 24 20       	mov    %r8,0x20(%rsp)
  1775eb:	73 cb                	jae    1775b8 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x208>
  1775ed:	4c 89 c0             	mov    %r8,%rax
  1775f0:	4d 85 ed             	test   %r13,%r13
  1775f3:	75 6b                	jne    177660 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2b0>
  1775f5:	48 83 7c 24 78 00    	cmpq   $0x0,0x78(%rsp)
  1775fb:	75 76                	jne    177673 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2c3>
  1775fd:	e9 1e 01 00 00       	jmp    177720 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x370>
  177602:	4d 8d 4d ff          	lea    -0x1(%r13),%r9
  177606:	4c 89 ce             	mov    %r9,%rsi
  177609:	48 83 e6 f0          	and    $0xfffffffffffffff0,%rsi
  17760d:	49 8d 04 f0          	lea    (%r8,%rsi,8),%rax
  177611:	48 8d 4e 01          	lea    0x1(%rsi),%rcx
  177615:	31 ff                	xor    %edi,%edi
  177617:	c4 e2 7d 19 05 00 8d 	vbroadcastsd -0x167300(%rip),%ymm0        # 10320 <__abi_tag+0x10024>
  17761e:	e9 ff 
  177620:	c4 c1 7c 11 04 f8    	vmovups %ymm0,(%r8,%rdi,8)
  177626:	c4 c1 7c 11 44 f8 20 	vmovups %ymm0,0x20(%r8,%rdi,8)
  17762d:	c4 c1 7c 11 44 f8 40 	vmovups %ymm0,0x40(%r8,%rdi,8)
  177634:	c4 c1 7c 11 44 f8 60 	vmovups %ymm0,0x60(%r8,%rdi,8)
  17763b:	48 83 c7 10          	add    $0x10,%rdi
  17763f:	48 39 fe             	cmp    %rdi,%rsi
  177642:	75 dc                	jne    177620 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x270>
  177644:	49 39 f1             	cmp    %rsi,%r9
  177647:	74 17                	je     177660 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2b0>
  177649:	4c 89 ee             	mov    %r13,%rsi
  17764c:	48 29 ce             	sub    %rcx,%rsi
  17764f:	90                   	nop
  177650:	48 c7 00 01 00 00 00 	movq   $0x1,(%rax)
  177657:	48 83 c0 08          	add    $0x8,%rax
  17765b:	48 ff ce             	dec    %rsi
  17765e:	75 f0                	jne    177650 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2a0>
  177660:	48 c7 00 01 00 00 00 	movq   $0x1,(%rax)
  177667:	48 83 7c 24 78 00    	cmpq   $0x0,0x78(%rsp)
  17766d:	0f 84 ad 00 00 00    	je     177720 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x370>
  177673:	48 8b 4c 24 50       	mov    0x50(%rsp),%rcx
  177678:	49 01 ce             	add    %rcx,%r14
  17767b:	31 ed                	xor    %ebp,%ebp
  17767d:	48 8d 05 cc fe 44 00 	lea    0x44fecc(%rip),%rax        # 5c7550 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0x268>
  177684:	48 89 84 24 b8 00 00 	mov    %rax,0xb8(%rsp)
  17768b:	00 
  17768c:	48 8d 05 d5 fe 44 00 	lea    0x44fed5(%rip),%rax        # 5c7568 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0x280>
  177693:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  17769a:	84 00 00 00 00 00 
  1776a0:	49 8b 77 28          	mov    0x28(%r15),%rsi
  1776a4:	48 39 f5             	cmp    %rsi,%rbp
  1776a7:	0f 83 22 24 00 00    	jae    179acf <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x271f>
  1776ad:	49 8b 7f 20          	mov    0x20(%r15),%rdi
  1776b1:	44 8b 1c af          	mov    (%rdi,%rbp,4),%r11d
  1776b5:	4c 39 de             	cmp    %r11,%rsi
  1776b8:	0f 86 52 23 00 00    	jbe    179a10 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2660>
  1776be:	49 8b 77 78          	mov    0x78(%r15),%rsi
  1776c2:	49 8b bf 88 00 00 00 	mov    0x88(%r15),%rdi
  1776c9:	45 31 c0             	xor    %r8d,%r8d
  1776cc:	4c 39 df             	cmp    %r11,%rdi
  1776cf:	41 0f 97 c0          	seta   %r8b
  1776d3:	41 b9 00 00 00 00    	mov    $0x0,%r9d
  1776d9:	4c 0f 46 cf          	cmovbe %rdi,%r9
  1776dd:	4d 29 cb             	sub    %r9,%r11
  1776e0:	41 c1 e0 04          	shl    $0x4,%r8d
  1776e4:	4c 0f af de          	imul   %rsi,%r11
  1776e8:	49 c1 e3 03          	shl    $0x3,%r11
  1776ec:	4f 03 9c 38 90 00 00 	add    0x90(%r8,%r15,1),%r11
  1776f3:	00 
  1776f4:	49 8d 34 f3          	lea    (%r11,%rsi,8),%rsi
  1776f8:	4c 89 19             	mov    %r11,(%rcx)
  1776fb:	48 89 71 08          	mov    %rsi,0x8(%rcx)
  1776ff:	49 8b 77 58          	mov    0x58(%r15),%rsi
  177703:	48 39 f5             	cmp    %rsi,%rbp
  177706:	0f 83 bb 23 00 00    	jae    179ac7 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2717>
  17770c:	49 8b 77 50          	mov    0x50(%r15),%rsi
  177710:	40 88 2c 2e          	mov    %bpl,(%rsi,%rbp,1)
  177714:	48 83 c1 10          	add    $0x10,%rcx
  177718:	48 ff c5             	inc    %rbp
  17771b:	4c 39 f1             	cmp    %r14,%rcx
  17771e:	75 80                	jne    1776a0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2f0>
  177720:	45 84 e4             	test   %r12b,%r12b
  177723:	8b 0c 24             	mov    (%rsp),%ecx
  177726:	74 32                	je     17775a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x3aa>
  177728:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
  17772d:	48 8b 30             	mov    (%rax),%rsi
  177730:	0f b6 c9             	movzbl %cl,%ecx
  177733:	4c 89 ff             	mov    %r15,%rdi
  177736:	4c 8b 44 24 50       	mov    0x50(%rsp),%r8
  17773b:	4c 8b 4c 24 78       	mov    0x78(%rsp),%r9
  177740:	41 55                	push   %r13
  177742:	ff 74 24 28          	push   0x28(%rsp)
  177746:	c5 f8 77             	vzeroupper
  177749:	e8 42 fb fd ff       	call   157290 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_grouped::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>>
  17774e:	48 83 c4 10          	add    $0x10,%rsp
  177752:	48 89 c5             	mov    %rax,%rbp
  177755:	e9 27 1f 00 00       	jmp    179681 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x22d1>
  17775a:	48 83 fa 0f          	cmp    $0xf,%rdx
  17775e:	48 8b 7c 24 20       	mov    0x20(%rsp),%rdi
  177763:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
  177768:	0f 87 ea 23 00 00    	ja     179b58 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x27a8>
  17776e:	48 8d 05 27 cf e9 ff 	lea    -0x1630d9(%rip),%rax        # 1469c <anon.1b06fbe60509ae926a49330b91708f0a.11.llvm.11709953318905502329+0x17b0>
  177775:	48 63 0c 90          	movslq (%rax,%rdx,4),%rcx
  177779:	48 01 c1             	add    %rax,%rcx
  17777c:	ff e1                	jmp    *%rcx
  17777e:	4c 89 7c 24 10       	mov    %r15,0x10(%rsp)
  177783:	48 89 74 24 38       	mov    %rsi,0x38(%rsp)
  177788:	48 8b 44 24 50       	mov    0x50(%rsp),%rax
  17778d:	48 89 44 24 58       	mov    %rax,0x58(%rsp)
  177792:	48 8b 44 24 78       	mov    0x78(%rsp),%rax
  177797:	48 89 44 24 60       	mov    %rax,0x60(%rsp)
  17779c:	48 89 7c 24 68       	mov    %rdi,0x68(%rsp)
  1777a1:	4c 89 6c 24 70       	mov    %r13,0x70(%rsp)
  1777a6:	49 8b af 80 00 00 00 	mov    0x80(%r15),%rbp
  1777ad:	48 89 6c 24 18       	mov    %rbp,0x18(%rsp)
  1777b2:	49 8b 87 a8 00 00 00 	mov    0xa8(%r15),%rax
  1777b9:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
  1777be:	48 39 c5             	cmp    %rax,%rbp
  1777c1:	0f 83 ba 1e 00 00    	jae    179681 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x22d1>
  1777c7:	45 31 e4             	xor    %r12d,%r12d
  1777ca:	48 8d 05 bf fb 44 00 	lea    0x44fbbf(%rip),%rax        # 5c7390 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0xa8>
  1777d1:	48 89 84 24 b8 00 00 	mov    %rax,0xb8(%rsp)
  1777d8:	00 
  1777d9:	48 8d 9c 24 80 00 00 	lea    0x80(%rsp),%rbx
  1777e0:	00 
  1777e1:	eb 0e                	jmp    1777f1 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x441>
  1777e3:	48 ff c5             	inc    %rbp
  1777e6:	48 3b 6c 24 30       	cmp    0x30(%rsp),%rbp
  1777eb:	0f 84 8b 1e 00 00    	je     17967c <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x22cc>
  1777f1:	48 89 6c 24 40       	mov    %rbp,0x40(%rsp)
  1777f6:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
  1777fb:	48 8b 70 28          	mov    0x28(%rax),%rsi
  1777ff:	48 39 f5             	cmp    %rsi,%rbp
  177802:	0f 83 c7 22 00 00    	jae    179acf <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x271f>
  177808:	48 8b 48 20          	mov    0x20(%rax),%rcx
  17780c:	8b 0c a9             	mov    (%rcx,%rbp,4),%ecx
  17780f:	48 39 ce             	cmp    %rcx,%rsi
  177812:	0f 86 f8 21 00 00    	jbe    179a10 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2660>
  177818:	4c 8b 40 78          	mov    0x78(%rax),%r8
  17781c:	48 8b 90 88 00 00 00 	mov    0x88(%rax),%rdx
  177823:	31 f6                	xor    %esi,%esi
  177825:	48 39 ca             	cmp    %rcx,%rdx
  177828:	40 0f 97 c6          	seta   %sil
  17782c:	bf 00 00 00 00       	mov    $0x0,%edi
  177831:	48 0f 46 fa          	cmovbe %rdx,%rdi
  177835:	48 29 f9             	sub    %rdi,%rcx
  177838:	c1 e6 04             	shl    $0x4,%esi
  17783b:	4c 89 04 24          	mov    %r8,(%rsp)
  17783f:	49 0f af c8          	imul   %r8,%rcx
  177843:	48 c1 e1 03          	shl    $0x3,%rcx
  177847:	48 03 8c 06 90 00 00 	add    0x90(%rsi,%rax,1),%rcx
  17784e:	00 
  17784f:	48 89 4c 24 48       	mov    %rcx,0x48(%rsp)
  177854:	4c 3b 60 70          	cmp    0x70(%rax),%r12
  177858:	73 1f                	jae    177879 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x4c9>
  17785a:	48 8b 40 68          	mov    0x68(%rax),%rax
  17785e:	4c 89 e1             	mov    %r12,%rcx
  177861:	48 c1 e1 04          	shl    $0x4,%rcx
  177865:	48 39 2c 08          	cmp    %rbp,(%rax,%rcx,1)
  177869:	75 0e                	jne    177879 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x4c9>
  17786b:	48 01 c8             	add    %rcx,%rax
  17786e:	48 8b 40 08          	mov    0x8(%rax),%rax
  177872:	48 89 04 24          	mov    %rax,(%rsp)
  177876:	49 ff c4             	inc    %r12
  177879:	4c 89 64 24 08       	mov    %r12,0x8(%rsp)
  17787e:	48 8d 44 24 48       	lea    0x48(%rsp),%rax
  177883:	48 89 84 24 80 00 00 	mov    %rax,0x80(%rsp)
  17788a:	00 
  17788b:	48 8d 44 24 38       	lea    0x38(%rsp),%rax
  177890:	48 89 84 24 88 00 00 	mov    %rax,0x88(%rsp)
  177897:	00 
  177898:	48 8d 44 24 58       	lea    0x58(%rsp),%rax
  17789d:	48 89 84 24 90 00 00 	mov    %rax,0x90(%rsp)
  1778a4:	00 
  1778a5:	48 8d 44 24 18       	lea    0x18(%rsp),%rax
  1778aa:	48 89 84 24 98 00 00 	mov    %rax,0x98(%rsp)
  1778b1:	00 
  1778b2:	48 8d 44 24 40       	lea    0x40(%rsp),%rax
  1778b7:	48 89 84 24 a0 00 00 	mov    %rax,0xa0(%rsp)
  1778be:	00 
  1778bf:	48 8d 44 24 10       	lea    0x10(%rsp),%rax
  1778c4:	48 89 84 24 a8 00 00 	mov    %rax,0xa8(%rsp)
  1778cb:	00 
  1778cc:	48 8d 44 24 68       	lea    0x68(%rsp),%rax
  1778d1:	48 89 84 24 b0 00 00 	mov    %rax,0xb0(%rsp)
  1778d8:	00 
  1778d9:	4c 8b 24 24          	mov    (%rsp),%r12
  1778dd:	49 c1 ec 02          	shr    $0x2,%r12
  1778e1:	74 4d                	je     177930 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x580>
  1778e3:	45 31 f6             	xor    %r14d,%r14d
  1778e6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  1778ed:	00 00 00 
  1778f0:	48 89 df             	mov    %rbx,%rdi
  1778f3:	4c 89 f6             	mov    %r14,%rsi
  1778f6:	c5 f8 77             	vzeroupper
  1778f9:	e8 42 6c 18 00       	call   2fe540 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>::{closure#0}>
  1778fe:	49 ff c6             	inc    %r14
  177901:	48 89 df             	mov    %rbx,%rdi
  177904:	4c 89 f6             	mov    %r14,%rsi
  177907:	e8 34 6c 18 00       	call   2fe540 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>::{closure#0}>
  17790c:	49 ff c6             	inc    %r14
  17790f:	48 89 df             	mov    %rbx,%rdi
  177912:	4c 89 f6             	mov    %r14,%rsi
  177915:	e8 26 6c 18 00       	call   2fe540 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>::{closure#0}>
  17791a:	49 ff c6             	inc    %r14
  17791d:	48 89 df             	mov    %rbx,%rdi
  177920:	4c 89 f6             	mov    %r14,%rsi
  177923:	e8 18 6c 18 00       	call   2fe540 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>::{closure#0}>
  177928:	49 ff c6             	inc    %r14
  17792b:	49 ff cc             	dec    %r12
  17792e:	75 c0                	jne    1778f0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x540>
  177930:	48 8b 04 24          	mov    (%rsp),%rax
  177934:	49 89 c6             	mov    %rax,%r14
  177937:	49 83 e6 fc          	and    $0xfffffffffffffffc,%r14
  17793b:	49 39 c6             	cmp    %rax,%r14
  17793e:	4c 8b 64 24 08       	mov    0x8(%rsp),%r12
  177943:	0f 84 9a fe ff ff    	je     1777e3 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x433>
  177949:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  177950:	48 89 df             	mov    %rbx,%rdi
  177953:	4c 89 f6             	mov    %r14,%rsi
  177956:	c5 f8 77             	vzeroupper
  177959:	e8 e2 6b 18 00       	call   2fe540 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>::{closure#0}>
  17795e:	49 ff c6             	inc    %r14
  177961:	4c 3b 34 24          	cmp    (%rsp),%r14
  177965:	72 e9                	jb     177950 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x5a0>
  177967:	e9 77 fe ff ff       	jmp    1777e3 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x433>
  17796c:	4c 89 7c 24 10       	mov    %r15,0x10(%rsp)
  177971:	48 89 74 24 38       	mov    %rsi,0x38(%rsp)
  177976:	48 8b 44 24 50       	mov    0x50(%rsp),%rax
  17797b:	48 89 44 24 58       	mov    %rax,0x58(%rsp)
  177980:	48 8b 44 24 78       	mov    0x78(%rsp),%rax
  177985:	48 89 44 24 60       	mov    %rax,0x60(%rsp)
  17798a:	48 89 7c 24 68       	mov    %rdi,0x68(%rsp)
  17798f:	4c 89 6c 24 70       	mov    %r13,0x70(%rsp)
  177994:	49 8b af 80 00 00 00 	mov    0x80(%r15),%rbp
  17799b:	48 89 6c 24 18       	mov    %rbp,0x18(%rsp)
  1779a0:	49 8b 87 a8 00 00 00 	mov    0xa8(%r15),%rax
  1779a7:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
  1779ac:	48 39 c5             	cmp    %rax,%rbp
  1779af:	0f 83 cc 1c 00 00    	jae    179681 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x22d1>
  1779b5:	45 31 e4             	xor    %r12d,%r12d
  1779b8:	48 8d 05 d1 f9 44 00 	lea    0x44f9d1(%rip),%rax        # 5c7390 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0xa8>
  1779bf:	48 89 84 24 b8 00 00 	mov    %rax,0xb8(%rsp)
  1779c6:	00 
  1779c7:	48 8d 9c 24 80 00 00 	lea    0x80(%rsp),%rbx
  1779ce:	00 
  1779cf:	eb 0e                	jmp    1779df <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x62f>
  1779d1:	48 ff c5             	inc    %rbp
  1779d4:	48 3b 6c 24 30       	cmp    0x30(%rsp),%rbp
  1779d9:	0f 84 9d 1c 00 00    	je     17967c <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x22cc>
  1779df:	48 89 6c 24 40       	mov    %rbp,0x40(%rsp)
  1779e4:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
  1779e9:	48 8b 70 28          	mov    0x28(%rax),%rsi
  1779ed:	48 39 f5             	cmp    %rsi,%rbp
  1779f0:	0f 83 d9 20 00 00    	jae    179acf <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x271f>
  1779f6:	48 8b 48 20          	mov    0x20(%rax),%rcx
  1779fa:	8b 0c a9             	mov    (%rcx,%rbp,4),%ecx
  1779fd:	48 39 ce             	cmp    %rcx,%rsi
  177a00:	0f 86 0a 20 00 00    	jbe    179a10 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2660>
  177a06:	4c 8b 40 78          	mov    0x78(%rax),%r8
  177a0a:	48 8b 90 88 00 00 00 	mov    0x88(%rax),%rdx
  177a11:	31 f6                	xor    %esi,%esi
  177a13:	48 39 ca             	cmp    %rcx,%rdx
  177a16:	40 0f 97 c6          	seta   %sil
  177a1a:	bf 00 00 00 00       	mov    $0x0,%edi
  177a1f:	48 0f 46 fa          	cmovbe %rdx,%rdi
  177a23:	48 29 f9             	sub    %rdi,%rcx
  177a26:	c1 e6 04             	shl    $0x4,%esi
  177a29:	4c 89 04 24          	mov    %r8,(%rsp)
  177a2d:	49 0f af c8          	imul   %r8,%rcx
  177a31:	48 c1 e1 03          	shl    $0x3,%rcx
  177a35:	48 03 8c 06 90 00 00 	add    0x90(%rsi,%rax,1),%rcx
  177a3c:	00 
  177a3d:	48 89 4c 24 48       	mov    %rcx,0x48(%rsp)
  177a42:	4c 3b 60 70          	cmp    0x70(%rax),%r12
  177a46:	73 1f                	jae    177a67 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x6b7>
  177a48:	48 8b 40 68          	mov    0x68(%rax),%rax
  177a4c:	4c 89 e1             	mov    %r12,%rcx
  177a4f:	48 c1 e1 04          	shl    $0x4,%rcx
  177a53:	48 39 2c 08          	cmp    %rbp,(%rax,%rcx,1)
  177a57:	75 0e                	jne    177a67 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x6b7>
  177a59:	48 01 c8             	add    %rcx,%rax
  177a5c:	48 8b 40 08          	mov    0x8(%rax),%rax
  177a60:	48 89 04 24          	mov    %rax,(%rsp)
  177a64:	49 ff c4             	inc    %r12
  177a67:	4c 89 64 24 08       	mov    %r12,0x8(%rsp)
  177a6c:	48 8d 44 24 48       	lea    0x48(%rsp),%rax
  177a71:	48 89 84 24 80 00 00 	mov    %rax,0x80(%rsp)
  177a78:	00 
  177a79:	48 8d 44 24 38       	lea    0x38(%rsp),%rax
  177a7e:	48 89 84 24 88 00 00 	mov    %rax,0x88(%rsp)
  177a85:	00 
  177a86:	48 8d 44 24 58       	lea    0x58(%rsp),%rax
  177a8b:	48 89 84 24 90 00 00 	mov    %rax,0x90(%rsp)
  177a92:	00 
  177a93:	48 8d 44 24 18       	lea    0x18(%rsp),%rax
  177a98:	48 89 84 24 98 00 00 	mov    %rax,0x98(%rsp)
  177a9f:	00 
  177aa0:	48 8d 44 24 40       	lea    0x40(%rsp),%rax
  177aa5:	48 89 84 24 a0 00 00 	mov    %rax,0xa0(%rsp)
  177aac:	00 
  177aad:	48 8d 44 24 10       	lea    0x10(%rsp),%rax
  177ab2:	48 89 84 24 a8 00 00 	mov    %rax,0xa8(%rsp)
  177ab9:	00 
  177aba:	48 8d 44 24 68       	lea    0x68(%rsp),%rax
  177abf:	48 89 84 24 b0 00 00 	mov    %rax,0xb0(%rsp)
  177ac6:	00 
  177ac7:	4c 8b 24 24          	mov    (%rsp),%r12
  177acb:	49 c1 ec 02          	shr    $0x2,%r12
  177acf:	74 4f                	je     177b20 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x770>
  177ad1:	45 31 f6             	xor    %r14d,%r14d
  177ad4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
  177adb:	00 00 00 00 00 
  177ae0:	48 89 df             	mov    %rbx,%rdi
  177ae3:	4c 89 f6             	mov    %r14,%rsi
  177ae6:	c5 f8 77             	vzeroupper
  177ae9:	e8 12 6d 18 00       	call   2fe800 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>::{closure#0}>
  177aee:	49 ff c6             	inc    %r14
  177af1:	48 89 df             	mov    %rbx,%rdi
  177af4:	4c 89 f6             	mov    %r14,%rsi
  177af7:	e8 04 6d 18 00       	call   2fe800 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>::{closure#0}>
  177afc:	49 ff c6             	inc    %r14
  177aff:	48 89 df             	mov    %rbx,%rdi
  177b02:	4c 89 f6             	mov    %r14,%rsi
  177b05:	e8 f6 6c 18 00       	call   2fe800 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>::{closure#0}>
  177b0a:	49 ff c6             	inc    %r14
  177b0d:	48 89 df             	mov    %rbx,%rdi
  177b10:	4c 89 f6             	mov    %r14,%rsi
  177b13:	e8 e8 6c 18 00       	call   2fe800 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>::{closure#0}>
  177b18:	49 ff c6             	inc    %r14
  177b1b:	49 ff cc             	dec    %r12
  177b1e:	75 c0                	jne    177ae0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x730>
  177b20:	48 8b 04 24          	mov    (%rsp),%rax
  177b24:	49 89 c6             	mov    %rax,%r14
  177b27:	49 83 e6 fc          	and    $0xfffffffffffffffc,%r14
  177b2b:	49 39 c6             	cmp    %rax,%r14
  177b2e:	4c 8b 64 24 08       	mov    0x8(%rsp),%r12
  177b33:	0f 84 98 fe ff ff    	je     1779d1 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x621>
  177b39:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  177b40:	48 89 df             	mov    %rbx,%rdi
  177b43:	4c 89 f6             	mov    %r14,%rsi
  177b46:	c5 f8 77             	vzeroupper
  177b49:	e8 b2 6c 18 00       	call   2fe800 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>::{closure#0}>
  177b4e:	49 ff c6             	inc    %r14
  177b51:	4c 3b 34 24          	cmp    (%rsp),%r14
  177b55:	72 e9                	jb     177b40 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x790>
  177b57:	e9 75 fe ff ff       	jmp    1779d1 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x621>
  177b5c:	4c 89 7c 24 10       	mov    %r15,0x10(%rsp)
  177b61:	48 89 74 24 38       	mov    %rsi,0x38(%rsp)
  177b66:	48 8b 44 24 50       	mov    0x50(%rsp),%rax
  177b6b:	48 89 44 24 58       	mov    %rax,0x58(%rsp)
  177b70:	48 8b 44 24 78       	mov    0x78(%rsp),%rax
  177b75:	48 89 44 24 60       	mov    %rax,0x60(%rsp)
  177b7a:	48 89 7c 24 68       	mov    %rdi,0x68(%rsp)
  177b7f:	4c 89 6c 24 70       	mov    %r13,0x70(%rsp)
  177b84:	49 8b af 80 00 00 00 	mov    0x80(%r15),%rbp
  177b8b:	48 89 6c 24 18       	mov    %rbp,0x18(%rsp)
  177b90:	49 8b 87 a8 00 00 00 	mov    0xa8(%r15),%rax
  177b97:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
  177b9c:	48 39 c5             	cmp    %rax,%rbp
  177b9f:	0f 83 dc 1a 00 00    	jae    179681 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x22d1>
  177ba5:	45 31 e4             	xor    %r12d,%r12d
  177ba8:	48 8d 05 e1 f7 44 00 	lea    0x44f7e1(%rip),%rax        # 5c7390 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0xa8>
  177baf:	48 89 84 24 b8 00 00 	mov    %rax,0xb8(%rsp)
  177bb6:	00 
  177bb7:	48 8d 9c 24 80 00 00 	lea    0x80(%rsp),%rbx
  177bbe:	00 
  177bbf:	eb 0e                	jmp    177bcf <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x81f>
  177bc1:	48 ff c5             	inc    %rbp
  177bc4:	48 3b 6c 24 30       	cmp    0x30(%rsp),%rbp
  177bc9:	0f 84 ad 1a 00 00    	je     17967c <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x22cc>
  177bcf:	48 89 6c 24 40       	mov    %rbp,0x40(%rsp)
  177bd4:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
  177bd9:	48 8b 70 28          	mov    0x28(%rax),%rsi
  177bdd:	48 39 f5             	cmp    %rsi,%rbp
  177be0:	0f 83 e9 1e 00 00    	jae    179acf <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x271f>
  177be6:	48 8b 48 20          	mov    0x20(%rax),%rcx
  177bea:	8b 0c a9             	mov    (%rcx,%rbp,4),%ecx
  177bed:	48 39 ce             	cmp    %rcx,%rsi
  177bf0:	0f 86 1a 1e 00 00    	jbe    179a10 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2660>
  177bf6:	4c 8b 40 78          	mov    0x78(%rax),%r8
  177bfa:	48 8b 90 88 00 00 00 	mov    0x88(%rax),%rdx
  177c01:	31 f6                	xor    %esi,%esi
  177c03:	48 39 ca             	cmp    %rcx,%rdx
  177c06:	40 0f 97 c6          	seta   %sil
  177c0a:	bf 00 00 00 00       	mov    $0x0,%edi
  177c0f:	48 0f 46 fa          	cmovbe %rdx,%rdi
  177c13:	48 29 f9             	sub    %rdi,%rcx
  177c16:	c1 e6 04             	shl    $0x4,%esi
  177c19:	4c 89 04 24          	mov    %r8,(%rsp)
  177c1d:	49 0f af c8          	imul   %r8,%rcx
  177c21:	48 c1 e1 03          	shl    $0x3,%rcx
  177c25:	48 03 8c 06 90 00 00 	add    0x90(%rsi,%rax,1),%rcx
  177c2c:	00 
  177c2d:	48 89 4c 24 48       	mov    %rcx,0x48(%rsp)
  177c32:	4c 3b 60 70          	cmp    0x70(%rax),%r12
  177c36:	73 1f                	jae    177c57 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x8a7>
  177c38:	48 8b 40 68          	mov    0x68(%rax),%rax
  177c3c:	4c 89 e1             	mov    %r12,%rcx
  177c3f:	48 c1 e1 04          	shl    $0x4,%rcx
  177c43:	48 39 2c 08          	cmp    %rbp,(%rax,%rcx,1)
  177c47:	75 0e                	jne    177c57 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x8a7>
  177c49:	48 01 c8             	add    %rcx,%rax
  177c4c:	48 8b 40 08          	mov    0x8(%rax),%rax
  177c50:	48 89 04 24          	mov    %rax,(%rsp)
  177c54:	49 ff c4             	inc    %r12
  177c57:	4c 89 64 24 08       	mov    %r12,0x8(%rsp)
  177c5c:	48 8d 44 24 48       	lea    0x48(%rsp),%rax
  177c61:	48 89 84 24 80 00 00 	mov    %rax,0x80(%rsp)
  177c68:	00 
  177c69:	48 8d 44 24 38       	lea    0x38(%rsp),%rax
  177c6e:	48 89 84 24 88 00 00 	mov    %rax,0x88(%rsp)
  177c75:	00 
  177c76:	48 8d 44 24 58       	lea    0x58(%rsp),%rax
  177c7b:	48 89 84 24 90 00 00 	mov    %rax,0x90(%rsp)
  177c82:	00 
  177c83:	48 8d 44 24 18       	lea    0x18(%rsp),%rax
  177c88:	48 89 84 24 98 00 00 	mov    %rax,0x98(%rsp)
  177c8f:	00 
  177c90:	48 8d 44 24 40       	lea    0x40(%rsp),%rax
  177c95:	48 89 84 24 a0 00 00 	mov    %rax,0xa0(%rsp)
  177c9c:	00 
  177c9d:	48 8d 44 24 10       	lea    0x10(%rsp),%rax
  177ca2:	48 89 84 24 a8 00 00 	mov    %rax,0xa8(%rsp)
  177ca9:	00 
  177caa:	48 8d 44 24 68       	lea    0x68(%rsp),%rax
  177caf:	48 89 84 24 b0 00 00 	mov    %rax,0xb0(%rsp)
  177cb6:	00 
  177cb7:	4c 8b 24 24          	mov    (%rsp),%r12
  177cbb:	49 c1 ec 02          	shr    $0x2,%r12
  177cbf:	74 4f                	je     177d10 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x960>
  177cc1:	45 31 f6             	xor    %r14d,%r14d
  177cc4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
  177ccb:	00 00 00 00 00 
  177cd0:	48 89 df             	mov    %rbx,%rdi
  177cd3:	4c 89 f6             	mov    %r14,%rsi
  177cd6:	c5 f8 77             	vzeroupper
  177cd9:	e8 82 6c 18 00       	call   2fe960 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 3>::{closure#0}>
  177cde:	49 ff c6             	inc    %r14
  177ce1:	48 89 df             	mov    %rbx,%rdi
  177ce4:	4c 89 f6             	mov    %r14,%rsi
  177ce7:	e8 74 6c 18 00       	call   2fe960 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 3>::{closure#0}>
  177cec:	49 ff c6             	inc    %r14
  177cef:	48 89 df             	mov    %rbx,%rdi
  177cf2:	4c 89 f6             	mov    %r14,%rsi
  177cf5:	e8 66 6c 18 00       	call   2fe960 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 3>::{closure#0}>
  177cfa:	49 ff c6             	inc    %r14
  177cfd:	48 89 df             	mov    %rbx,%rdi
  177d00:	4c 89 f6             	mov    %r14,%rsi
  177d03:	e8 58 6c 18 00       	call   2fe960 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 3>::{closure#0}>
  177d08:	49 ff c6             	inc    %r14
  177d0b:	49 ff cc             	dec    %r12
  177d0e:	75 c0                	jne    177cd0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x920>
  177d10:	48 8b 04 24          	mov    (%rsp),%rax
  177d14:	49 89 c6             	mov    %rax,%r14
  177d17:	49 83 e6 fc          	and    $0xfffffffffffffffc,%r14
  177d1b:	49 39 c6             	cmp    %rax,%r14
  177d1e:	4c 8b 64 24 08       	mov    0x8(%rsp),%r12
  177d23:	0f 84 98 fe ff ff    	je     177bc1 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x811>
  177d29:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  177d30:	48 89 df             	mov    %rbx,%rdi
  177d33:	4c 89 f6             	mov    %r14,%rsi
  177d36:	c5 f8 77             	vzeroupper
  177d39:	e8 22 6c 18 00       	call   2fe960 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 3>::{closure#0}>
  177d3e:	49 ff c6             	inc    %r14
  177d41:	4c 3b 34 24          	cmp    (%rsp),%r14
  177d45:	72 e9                	jb     177d30 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x980>
  177d47:	e9 75 fe ff ff       	jmp    177bc1 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x811>
  177d4c:	4c 89 7c 24 10       	mov    %r15,0x10(%rsp)
  177d51:	48 89 74 24 38       	mov    %rsi,0x38(%rsp)
  177d56:	48 8b 44 24 50       	mov    0x50(%rsp),%rax
  177d5b:	48 89 44 24 58       	mov    %rax,0x58(%rsp)
  177d60:	48 8b 44 24 78       	mov    0x78(%rsp),%rax
  177d65:	48 89 44 24 60       	mov    %rax,0x60(%rsp)
  177d6a:	48 89 7c 24 68       	mov    %rdi,0x68(%rsp)
  177d6f:	4c 89 6c 24 70       	mov    %r13,0x70(%rsp)
  177d74:	49 8b af 80 00 00 00 	mov    0x80(%r15),%rbp
  177d7b:	48 89 6c 24 18       	mov    %rbp,0x18(%rsp)
  177d80:	49 8b 87 a8 00 00 00 	mov    0xa8(%r15),%rax
  177d87:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
  177d8c:	48 39 c5             	cmp    %rax,%rbp
  177d8f:	0f 83 ec 18 00 00    	jae    179681 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x22d1>
  177d95:	45 31 e4             	xor    %r12d,%r12d
  177d98:	48 8d 05 f1 f5 44 00 	lea    0x44f5f1(%rip),%rax        # 5c7390 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0xa8>
  177d9f:	48 89 84 24 b8 00 00 	mov    %rax,0xb8(%rsp)
  177da6:	00 
  177da7:	48 8d 9c 24 80 00 00 	lea    0x80(%rsp),%rbx
  177dae:	00 
  177daf:	eb 0e                	jmp    177dbf <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xa0f>
  177db1:	48 ff c5             	inc    %rbp
  177db4:	48 3b 6c 24 30       	cmp    0x30(%rsp),%rbp
  177db9:	0f 84 bd 18 00 00    	je     17967c <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x22cc>
  177dbf:	48 89 6c 24 40       	mov    %rbp,0x40(%rsp)
  177dc4:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
  177dc9:	48 8b 70 28          	mov    0x28(%rax),%rsi
  177dcd:	48 39 f5             	cmp    %rsi,%rbp
  177dd0:	0f 83 f9 1c 00 00    	jae    179acf <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x271f>
  177dd6:	48 8b 48 20          	mov    0x20(%rax),%rcx
  177dda:	8b 0c a9             	mov    (%rcx,%rbp,4),%ecx
  177ddd:	48 39 ce             	cmp    %rcx,%rsi
  177de0:	0f 86 2a 1c 00 00    	jbe    179a10 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2660>
  177de6:	4c 8b 40 78          	mov    0x78(%rax),%r8
  177dea:	48 8b 90 88 00 00 00 	mov    0x88(%rax),%rdx
  177df1:	31 f6                	xor    %esi,%esi
  177df3:	48 39 ca             	cmp    %rcx,%rdx
  177df6:	40 0f 97 c6          	seta   %sil
  177dfa:	bf 00 00 00 00       	mov    $0x0,%edi
  177dff:	48 0f 46 fa          	cmovbe %rdx,%rdi
  177e03:	48 29 f9             	sub    %rdi,%rcx
  177e06:	c1 e6 04             	shl    $0x4,%esi
  177e09:	4c 89 04 24          	mov    %r8,(%rsp)
  177e0d:	49 0f af c8          	imul   %r8,%rcx
  177e11:	48 c1 e1 03          	shl    $0x3,%rcx
  177e15:	48 03 8c 06 90 00 00 	add    0x90(%rsi,%rax,1),%rcx
  177e1c:	00 
  177e1d:	48 89 4c 24 48       	mov    %rcx,0x48(%rsp)
  177e22:	4c 3b 60 70          	cmp    0x70(%rax),%r12
  177e26:	73 1f                	jae    177e47 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xa97>
  177e28:	48 8b 40 68          	mov    0x68(%rax),%rax
  177e2c:	4c 89 e1             	mov    %r12,%rcx
  177e2f:	48 c1 e1 04          	shl    $0x4,%rcx
  177e33:	48 39 2c 08          	cmp    %rbp,(%rax,%rcx,1)
  177e37:	75 0e                	jne    177e47 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xa97>
  177e39:	48 01 c8             	add    %rcx,%rax
  177e3c:	48 8b 40 08          	mov    0x8(%rax),%rax
  177e40:	48 89 04 24          	mov    %rax,(%rsp)
  177e44:	49 ff c4             	inc    %r12
  177e47:	4c 89 64 24 08       	mov    %r12,0x8(%rsp)
  177e4c:	48 8d 44 24 48       	lea    0x48(%rsp),%rax
  177e51:	48 89 84 24 80 00 00 	mov    %rax,0x80(%rsp)
  177e58:	00 
  177e59:	48 8d 44 24 38       	lea    0x38(%rsp),%rax
  177e5e:	48 89 84 24 88 00 00 	mov    %rax,0x88(%rsp)
  177e65:	00 
  177e66:	48 8d 44 24 58       	lea    0x58(%rsp),%rax
  177e6b:	48 89 84 24 90 00 00 	mov    %rax,0x90(%rsp)
  177e72:	00 
  177e73:	48 8d 44 24 18       	lea    0x18(%rsp),%rax
  177e78:	48 89 84 24 98 00 00 	mov    %rax,0x98(%rsp)
  177e7f:	00 
  177e80:	48 8d 44 24 40       	lea    0x40(%rsp),%rax
  177e85:	48 89 84 24 a0 00 00 	mov    %rax,0xa0(%rsp)
  177e8c:	00 
  177e8d:	48 8d 44 24 10       	lea    0x10(%rsp),%rax
  177e92:	48 89 84 24 a8 00 00 	mov    %rax,0xa8(%rsp)
  177e99:	00 
  177e9a:	48 8d 44 24 68       	lea    0x68(%rsp),%rax
  177e9f:	48 89 84 24 b0 00 00 	mov    %rax,0xb0(%rsp)
  177ea6:	00 
  177ea7:	4c 8b 24 24          	mov    (%rsp),%r12
  177eab:	49 c1 ec 02          	shr    $0x2,%r12
  177eaf:	74 4f                	je     177f00 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xb50>
  177eb1:	45 31 f6             	xor    %r14d,%r14d
  177eb4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
  177ebb:	00 00 00 00 00 
  177ec0:	48 89 df             	mov    %rbx,%rdi
  177ec3:	4c 89 f6             	mov    %r14,%rsi
  177ec6:	c5 f8 77             	vzeroupper
  177ec9:	e8 72 66 18 00       	call   2fe540 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>::{closure#0}>
  177ece:	49 ff c6             	inc    %r14
  177ed1:	48 89 df             	mov    %rbx,%rdi
  177ed4:	4c 89 f6             	mov    %r14,%rsi
  177ed7:	e8 64 66 18 00       	call   2fe540 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>::{closure#0}>
  177edc:	49 ff c6             	inc    %r14
  177edf:	48 89 df             	mov    %rbx,%rdi
  177ee2:	4c 89 f6             	mov    %r14,%rsi
  177ee5:	e8 56 66 18 00       	call   2fe540 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>::{closure#0}>
  177eea:	49 ff c6             	inc    %r14
  177eed:	48 89 df             	mov    %rbx,%rdi
  177ef0:	4c 89 f6             	mov    %r14,%rsi
  177ef3:	e8 48 66 18 00       	call   2fe540 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>::{closure#0}>
  177ef8:	49 ff c6             	inc    %r14
  177efb:	49 ff cc             	dec    %r12
  177efe:	75 c0                	jne    177ec0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xb10>
  177f00:	48 8b 04 24          	mov    (%rsp),%rax
  177f04:	49 89 c6             	mov    %rax,%r14
  177f07:	49 83 e6 fc          	and    $0xfffffffffffffffc,%r14
  177f0b:	49 39 c6             	cmp    %rax,%r14
  177f0e:	4c 8b 64 24 08       	mov    0x8(%rsp),%r12
  177f13:	0f 84 98 fe ff ff    	je     177db1 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xa01>
  177f19:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  177f20:	48 89 df             	mov    %rbx,%rdi
  177f23:	4c 89 f6             	mov    %r14,%rsi
  177f26:	c5 f8 77             	vzeroupper
  177f29:	e8 12 66 18 00       	call   2fe540 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>::{closure#0}>
  177f2e:	49 ff c6             	inc    %r14
  177f31:	4c 3b 34 24          	cmp    (%rsp),%r14
  177f35:	72 e9                	jb     177f20 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xb70>
  177f37:	e9 75 fe ff ff       	jmp    177db1 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xa01>
  177f3c:	4c 89 7c 24 10       	mov    %r15,0x10(%rsp)
  177f41:	48 89 74 24 38       	mov    %rsi,0x38(%rsp)
  177f46:	48 8b 44 24 50       	mov    0x50(%rsp),%rax
  177f4b:	48 89 44 24 58       	mov    %rax,0x58(%rsp)
  177f50:	48 8b 44 24 78       	mov    0x78(%rsp),%rax
  177f55:	48 89 44 24 60       	mov    %rax,0x60(%rsp)
  177f5a:	48 89 7c 24 68       	mov    %rdi,0x68(%rsp)
  177f5f:	4c 89 6c 24 70       	mov    %r13,0x70(%rsp)
  177f64:	49 8b af 80 00 00 00 	mov    0x80(%r15),%rbp
  177f6b:	48 89 6c 24 18       	mov    %rbp,0x18(%rsp)
  177f70:	49 8b 87 a8 00 00 00 	mov    0xa8(%r15),%rax
  177f77:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
  177f7c:	48 39 c5             	cmp    %rax,%rbp
  177f7f:	0f 83 fc 16 00 00    	jae    179681 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x22d1>
  177f85:	45 31 e4             	xor    %r12d,%r12d
  177f88:	48 8d 05 01 f4 44 00 	lea    0x44f401(%rip),%rax        # 5c7390 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0xa8>
  177f8f:	48 89 84 24 b8 00 00 	mov    %rax,0xb8(%rsp)
  177f96:	00 
  177f97:	48 8d 9c 24 80 00 00 	lea    0x80(%rsp),%rbx
  177f9e:	00 
  177f9f:	eb 0e                	jmp    177faf <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xbff>
  177fa1:	48 ff c5             	inc    %rbp
  177fa4:	48 3b 6c 24 30       	cmp    0x30(%rsp),%rbp
  177fa9:	0f 84 cd 16 00 00    	je     17967c <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x22cc>
  177faf:	48 89 6c 24 40       	mov    %rbp,0x40(%rsp)
  177fb4:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
  177fb9:	48 8b 70 28          	mov    0x28(%rax),%rsi
  177fbd:	48 39 f5             	cmp    %rsi,%rbp
  177fc0:	0f 83 09 1b 00 00    	jae    179acf <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x271f>
  177fc6:	48 8b 48 20          	mov    0x20(%rax),%rcx
  177fca:	8b 0c a9             	mov    (%rcx,%rbp,4),%ecx
  177fcd:	48 39 ce             	cmp    %rcx,%rsi
  177fd0:	0f 86 3a 1a 00 00    	jbe    179a10 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2660>
  177fd6:	4c 8b 40 78          	mov    0x78(%rax),%r8
  177fda:	48 8b 90 88 00 00 00 	mov    0x88(%rax),%rdx
  177fe1:	31 f6                	xor    %esi,%esi
  177fe3:	48 39 ca             	cmp    %rcx,%rdx
  177fe6:	40 0f 97 c6          	seta   %sil
  177fea:	bf 00 00 00 00       	mov    $0x0,%edi
  177fef:	48 0f 46 fa          	cmovbe %rdx,%rdi
  177ff3:	48 29 f9             	sub    %rdi,%rcx
  177ff6:	c1 e6 04             	shl    $0x4,%esi
  177ff9:	4c 89 04 24          	mov    %r8,(%rsp)
  177ffd:	49 0f af c8          	imul   %r8,%rcx
  178001:	48 c1 e1 03          	shl    $0x3,%rcx
  178005:	48 03 8c 06 90 00 00 	add    0x90(%rsi,%rax,1),%rcx
  17800c:	00 
  17800d:	48 89 4c 24 48       	mov    %rcx,0x48(%rsp)
  178012:	4c 3b 60 70          	cmp    0x70(%rax),%r12
  178016:	73 1f                	jae    178037 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xc87>
  178018:	48 8b 40 68          	mov    0x68(%rax),%rax
  17801c:	4c 89 e1             	mov    %r12,%rcx
  17801f:	48 c1 e1 04          	shl    $0x4,%rcx
  178023:	48 39 2c 08          	cmp    %rbp,(%rax,%rcx,1)
  178027:	75 0e                	jne    178037 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xc87>
  178029:	48 01 c8             	add    %rcx,%rax
  17802c:	48 8b 40 08          	mov    0x8(%rax),%rax
  178030:	48 89 04 24          	mov    %rax,(%rsp)
  178034:	49 ff c4             	inc    %r12
  178037:	4c 89 64 24 08       	mov    %r12,0x8(%rsp)
  17803c:	48 8d 44 24 48       	lea    0x48(%rsp),%rax
  178041:	48 89 84 24 80 00 00 	mov    %rax,0x80(%rsp)
  178048:	00 
  178049:	48 8d 44 24 38       	lea    0x38(%rsp),%rax
  17804e:	48 89 84 24 88 00 00 	mov    %rax,0x88(%rsp)
  178055:	00 
  178056:	48 8d 44 24 58       	lea    0x58(%rsp),%rax
  17805b:	48 89 84 24 90 00 00 	mov    %rax,0x90(%rsp)
  178062:	00 
  178063:	48 8d 44 24 18       	lea    0x18(%rsp),%rax
  178068:	48 89 84 24 98 00 00 	mov    %rax,0x98(%rsp)
  17806f:	00 
  178070:	48 8d 44 24 40       	lea    0x40(%rsp),%rax
  178075:	48 89 84 24 a0 00 00 	mov    %rax,0xa0(%rsp)
  17807c:	00 
  17807d:	48 8d 44 24 10       	lea    0x10(%rsp),%rax
  178082:	48 89 84 24 a8 00 00 	mov    %rax,0xa8(%rsp)
  178089:	00 
  17808a:	48 8d 44 24 68       	lea    0x68(%rsp),%rax
  17808f:	48 89 84 24 b0 00 00 	mov    %rax,0xb0(%rsp)
  178096:	00 
  178097:	4c 8b 24 24          	mov    (%rsp),%r12
  17809b:	49 c1 ec 02          	shr    $0x2,%r12
  17809f:	74 4f                	je     1780f0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xd40>
  1780a1:	45 31 f6             	xor    %r14d,%r14d
  1780a4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
  1780ab:	00 00 00 00 00 
  1780b0:	48 89 df             	mov    %rbx,%rdi
  1780b3:	4c 89 f6             	mov    %r14,%rsi
  1780b6:	c5 f8 77             	vzeroupper
  1780b9:	e8 82 64 18 00       	call   2fe540 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>::{closure#0}>
  1780be:	49 ff c6             	inc    %r14
  1780c1:	48 89 df             	mov    %rbx,%rdi
  1780c4:	4c 89 f6             	mov    %r14,%rsi
  1780c7:	e8 74 64 18 00       	call   2fe540 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>::{closure#0}>
  1780cc:	49 ff c6             	inc    %r14
  1780cf:	48 89 df             	mov    %rbx,%rdi
  1780d2:	4c 89 f6             	mov    %r14,%rsi
  1780d5:	e8 66 64 18 00       	call   2fe540 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>::{closure#0}>
  1780da:	49 ff c6             	inc    %r14
  1780dd:	48 89 df             	mov    %rbx,%rdi
  1780e0:	4c 89 f6             	mov    %r14,%rsi
  1780e3:	e8 58 64 18 00       	call   2fe540 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>::{closure#0}>
  1780e8:	49 ff c6             	inc    %r14
  1780eb:	49 ff cc             	dec    %r12
  1780ee:	75 c0                	jne    1780b0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xd00>
  1780f0:	48 8b 04 24          	mov    (%rsp),%rax
  1780f4:	49 89 c6             	mov    %rax,%r14
  1780f7:	49 83 e6 fc          	and    $0xfffffffffffffffc,%r14
  1780fb:	49 39 c6             	cmp    %rax,%r14
  1780fe:	4c 8b 64 24 08       	mov    0x8(%rsp),%r12
  178103:	0f 84 98 fe ff ff    	je     177fa1 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xbf1>
  178109:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  178110:	48 89 df             	mov    %rbx,%rdi
  178113:	4c 89 f6             	mov    %r14,%rsi
  178116:	c5 f8 77             	vzeroupper
  178119:	e8 22 64 18 00       	call   2fe540 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>::{closure#0}>
  17811e:	49 ff c6             	inc    %r14
  178121:	4c 3b 34 24          	cmp    (%rsp),%r14
  178125:	72 e9                	jb     178110 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xd60>
  178127:	e9 75 fe ff ff       	jmp    177fa1 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xbf1>
  17812c:	4c 89 7c 24 10       	mov    %r15,0x10(%rsp)
  178131:	48 89 74 24 38       	mov    %rsi,0x38(%rsp)
  178136:	48 8b 44 24 50       	mov    0x50(%rsp),%rax
  17813b:	48 89 44 24 58       	mov    %rax,0x58(%rsp)
  178140:	48 8b 44 24 78       	mov    0x78(%rsp),%rax
  178145:	48 89 44 24 60       	mov    %rax,0x60(%rsp)
  17814a:	48 89 7c 24 68       	mov    %rdi,0x68(%rsp)
  17814f:	4c 89 6c 24 70       	mov    %r13,0x70(%rsp)
  178154:	49 8b af 80 00 00 00 	mov    0x80(%r15),%rbp
  17815b:	48 89 6c 24 18       	mov    %rbp,0x18(%rsp)
  178160:	49 8b 87 a8 00 00 00 	mov    0xa8(%r15),%rax
  178167:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
  17816c:	48 39 c5             	cmp    %rax,%rbp
  17816f:	0f 83 0c 15 00 00    	jae    179681 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x22d1>
  178175:	45 31 e4             	xor    %r12d,%r12d
  178178:	48 8d 05 11 f2 44 00 	lea    0x44f211(%rip),%rax        # 5c7390 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0xa8>
  17817f:	48 89 84 24 b8 00 00 	mov    %rax,0xb8(%rsp)
  178186:	00 
  178187:	48 8d 9c 24 80 00 00 	lea    0x80(%rsp),%rbx
  17818e:	00 
  17818f:	eb 0e                	jmp    17819f <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xdef>
  178191:	48 ff c5             	inc    %rbp
  178194:	48 3b 6c 24 30       	cmp    0x30(%rsp),%rbp
  178199:	0f 84 dd 14 00 00    	je     17967c <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x22cc>
  17819f:	48 89 6c 24 40       	mov    %rbp,0x40(%rsp)
  1781a4:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
  1781a9:	48 8b 70 28          	mov    0x28(%rax),%rsi
  1781ad:	48 39 f5             	cmp    %rsi,%rbp
  1781b0:	0f 83 19 19 00 00    	jae    179acf <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x271f>
  1781b6:	48 8b 48 20          	mov    0x20(%rax),%rcx
  1781ba:	8b 0c a9             	mov    (%rcx,%rbp,4),%ecx
  1781bd:	48 39 ce             	cmp    %rcx,%rsi
  1781c0:	0f 86 4a 18 00 00    	jbe    179a10 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2660>
  1781c6:	4c 8b 40 78          	mov    0x78(%rax),%r8
  1781ca:	48 8b 90 88 00 00 00 	mov    0x88(%rax),%rdx
  1781d1:	31 f6                	xor    %esi,%esi
  1781d3:	48 39 ca             	cmp    %rcx,%rdx
  1781d6:	40 0f 97 c6          	seta   %sil
  1781da:	bf 00 00 00 00       	mov    $0x0,%edi
  1781df:	48 0f 46 fa          	cmovbe %rdx,%rdi
  1781e3:	48 29 f9             	sub    %rdi,%rcx
  1781e6:	c1 e6 04             	shl    $0x4,%esi
  1781e9:	4c 89 04 24          	mov    %r8,(%rsp)
  1781ed:	49 0f af c8          	imul   %r8,%rcx
  1781f1:	48 c1 e1 03          	shl    $0x3,%rcx
  1781f5:	48 03 8c 06 90 00 00 	add    0x90(%rsi,%rax,1),%rcx
  1781fc:	00 
  1781fd:	48 89 4c 24 48       	mov    %rcx,0x48(%rsp)
  178202:	4c 3b 60 70          	cmp    0x70(%rax),%r12
  178206:	73 1f                	jae    178227 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xe77>
  178208:	48 8b 40 68          	mov    0x68(%rax),%rax
  17820c:	4c 89 e1             	mov    %r12,%rcx
  17820f:	48 c1 e1 04          	shl    $0x4,%rcx
  178213:	48 39 2c 08          	cmp    %rbp,(%rax,%rcx,1)
  178217:	75 0e                	jne    178227 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xe77>
  178219:	48 01 c8             	add    %rcx,%rax
  17821c:	48 8b 40 08          	mov    0x8(%rax),%rax
  178220:	48 89 04 24          	mov    %rax,(%rsp)
  178224:	49 ff c4             	inc    %r12
  178227:	4c 89 64 24 08       	mov    %r12,0x8(%rsp)
  17822c:	48 8d 44 24 48       	lea    0x48(%rsp),%rax
  178231:	48 89 84 24 80 00 00 	mov    %rax,0x80(%rsp)
  178238:	00 
  178239:	48 8d 44 24 38       	lea    0x38(%rsp),%rax
  17823e:	48 89 84 24 88 00 00 	mov    %rax,0x88(%rsp)
  178245:	00 
  178246:	48 8d 44 24 58       	lea    0x58(%rsp),%rax
  17824b:	48 89 84 24 90 00 00 	mov    %rax,0x90(%rsp)
  178252:	00 
  178253:	48 8d 44 24 18       	lea    0x18(%rsp),%rax
  178258:	48 89 84 24 98 00 00 	mov    %rax,0x98(%rsp)
  17825f:	00 
  178260:	48 8d 44 24 40       	lea    0x40(%rsp),%rax
  178265:	48 89 84 24 a0 00 00 	mov    %rax,0xa0(%rsp)
  17826c:	00 
  17826d:	48 8d 44 24 10       	lea    0x10(%rsp),%rax
  178272:	48 89 84 24 a8 00 00 	mov    %rax,0xa8(%rsp)
  178279:	00 
  17827a:	48 8d 44 24 68       	lea    0x68(%rsp),%rax
  17827f:	48 89 84 24 b0 00 00 	mov    %rax,0xb0(%rsp)
  178286:	00 
  178287:	4c 8b 24 24          	mov    (%rsp),%r12
  17828b:	49 c1 ec 02          	shr    $0x2,%r12
  17828f:	74 4f                	je     1782e0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xf30>
  178291:	45 31 f6             	xor    %r14d,%r14d
  178294:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
  17829b:	00 00 00 00 00 
  1782a0:	48 89 df             	mov    %rbx,%rdi
  1782a3:	4c 89 f6             	mov    %r14,%rsi
  1782a6:	c5 f8 77             	vzeroupper
  1782a9:	e8 f2 63 18 00       	call   2fe6a0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>::{closure#0}>
  1782ae:	49 ff c6             	inc    %r14
  1782b1:	48 89 df             	mov    %rbx,%rdi
  1782b4:	4c 89 f6             	mov    %r14,%rsi
  1782b7:	e8 e4 63 18 00       	call   2fe6a0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>::{closure#0}>
  1782bc:	49 ff c6             	inc    %r14
  1782bf:	48 89 df             	mov    %rbx,%rdi
  1782c2:	4c 89 f6             	mov    %r14,%rsi
  1782c5:	e8 d6 63 18 00       	call   2fe6a0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>::{closure#0}>
  1782ca:	49 ff c6             	inc    %r14
  1782cd:	48 89 df             	mov    %rbx,%rdi
  1782d0:	4c 89 f6             	mov    %r14,%rsi
  1782d3:	e8 c8 63 18 00       	call   2fe6a0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>::{closure#0}>
  1782d8:	49 ff c6             	inc    %r14
  1782db:	49 ff cc             	dec    %r12
  1782de:	75 c0                	jne    1782a0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xef0>
  1782e0:	48 8b 04 24          	mov    (%rsp),%rax
  1782e4:	49 89 c6             	mov    %rax,%r14
  1782e7:	49 83 e6 fc          	and    $0xfffffffffffffffc,%r14
  1782eb:	49 39 c6             	cmp    %rax,%r14
  1782ee:	4c 8b 64 24 08       	mov    0x8(%rsp),%r12
  1782f3:	0f 84 98 fe ff ff    	je     178191 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xde1>
  1782f9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  178300:	48 89 df             	mov    %rbx,%rdi
  178303:	4c 89 f6             	mov    %r14,%rsi
  178306:	c5 f8 77             	vzeroupper
  178309:	e8 92 63 18 00       	call   2fe6a0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>::{closure#0}>
  17830e:	49 ff c6             	inc    %r14
  178311:	4c 3b 34 24          	cmp    (%rsp),%r14
  178315:	72 e9                	jb     178300 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xf50>
  178317:	e9 75 fe ff ff       	jmp    178191 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xde1>
  17831c:	4c 89 7c 24 10       	mov    %r15,0x10(%rsp)
  178321:	48 89 74 24 38       	mov    %rsi,0x38(%rsp)
  178326:	48 8b 44 24 50       	mov    0x50(%rsp),%rax
  17832b:	48 89 44 24 58       	mov    %rax,0x58(%rsp)
  178330:	48 8b 44 24 78       	mov    0x78(%rsp),%rax
  178335:	48 89 44 24 60       	mov    %rax,0x60(%rsp)
  17833a:	48 89 7c 24 68       	mov    %rdi,0x68(%rsp)
  17833f:	4c 89 6c 24 70       	mov    %r13,0x70(%rsp)
  178344:	49 8b af 80 00 00 00 	mov    0x80(%r15),%rbp
  17834b:	48 89 6c 24 18       	mov    %rbp,0x18(%rsp)
  178350:	49 8b 87 a8 00 00 00 	mov    0xa8(%r15),%rax
  178357:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
  17835c:	48 39 c5             	cmp    %rax,%rbp
  17835f:	0f 83 1c 13 00 00    	jae    179681 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x22d1>
  178365:	45 31 e4             	xor    %r12d,%r12d
  178368:	48 8d 05 21 f0 44 00 	lea    0x44f021(%rip),%rax        # 5c7390 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0xa8>
  17836f:	48 89 84 24 b8 00 00 	mov    %rax,0xb8(%rsp)
  178376:	00 
  178377:	48 8d 9c 24 80 00 00 	lea    0x80(%rsp),%rbx
  17837e:	00 
  17837f:	eb 0e                	jmp    17838f <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xfdf>
  178381:	48 ff c5             	inc    %rbp
  178384:	48 3b 6c 24 30       	cmp    0x30(%rsp),%rbp
  178389:	0f 84 ed 12 00 00    	je     17967c <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x22cc>
  17838f:	48 89 6c 24 40       	mov    %rbp,0x40(%rsp)
  178394:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
  178399:	48 8b 70 28          	mov    0x28(%rax),%rsi
  17839d:	48 39 f5             	cmp    %rsi,%rbp
  1783a0:	0f 83 29 17 00 00    	jae    179acf <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x271f>
  1783a6:	48 8b 48 20          	mov    0x20(%rax),%rcx
  1783aa:	8b 0c a9             	mov    (%rcx,%rbp,4),%ecx
  1783ad:	48 39 ce             	cmp    %rcx,%rsi
  1783b0:	0f 86 5a 16 00 00    	jbe    179a10 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2660>
  1783b6:	4c 8b 40 78          	mov    0x78(%rax),%r8
  1783ba:	48 8b 90 88 00 00 00 	mov    0x88(%rax),%rdx
  1783c1:	31 f6                	xor    %esi,%esi
  1783c3:	48 39 ca             	cmp    %rcx,%rdx
  1783c6:	40 0f 97 c6          	seta   %sil
  1783ca:	bf 00 00 00 00       	mov    $0x0,%edi
  1783cf:	48 0f 46 fa          	cmovbe %rdx,%rdi
  1783d3:	48 29 f9             	sub    %rdi,%rcx
  1783d6:	c1 e6 04             	shl    $0x4,%esi
  1783d9:	4c 89 04 24          	mov    %r8,(%rsp)
  1783dd:	49 0f af c8          	imul   %r8,%rcx
  1783e1:	48 c1 e1 03          	shl    $0x3,%rcx
  1783e5:	48 03 8c 06 90 00 00 	add    0x90(%rsi,%rax,1),%rcx
  1783ec:	00 
  1783ed:	48 89 4c 24 48       	mov    %rcx,0x48(%rsp)
  1783f2:	4c 3b 60 70          	cmp    0x70(%rax),%r12
  1783f6:	73 1f                	jae    178417 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x1067>
  1783f8:	48 8b 40 68          	mov    0x68(%rax),%rax
  1783fc:	4c 89 e1             	mov    %r12,%rcx
  1783ff:	48 c1 e1 04          	shl    $0x4,%rcx
  178403:	48 39 2c 08          	cmp    %rbp,(%rax,%rcx,1)
  178407:	75 0e                	jne    178417 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x1067>
  178409:	48 01 c8             	add    %rcx,%rax
  17840c:	48 8b 40 08          	mov    0x8(%rax),%rax
  178410:	48 89 04 24          	mov    %rax,(%rsp)
  178414:	49 ff c4             	inc    %r12
  178417:	4c 89 64 24 08       	mov    %r12,0x8(%rsp)
  17841c:	48 8d 44 24 48       	lea    0x48(%rsp),%rax
  178421:	48 89 84 24 80 00 00 	mov    %rax,0x80(%rsp)
  178428:	00 
  178429:	48 8d 44 24 38       	lea    0x38(%rsp),%rax
  17842e:	48 89 84 24 88 00 00 	mov    %rax,0x88(%rsp)
  178435:	00 
  178436:	48 8d 44 24 58       	lea    0x58(%rsp),%rax
  17843b:	48 89 84 24 90 00 00 	mov    %rax,0x90(%rsp)
  178442:	00 
  178443:	48 8d 44 24 18       	lea    0x18(%rsp),%rax
  178448:	48 89 84 24 98 00 00 	mov    %rax,0x98(%rsp)
  17844f:	00 
  178450:	48 8d 44 24 40       	lea    0x40(%rsp),%rax
  178455:	48 89 84 24 a0 00 00 	mov    %rax,0xa0(%rsp)
  17845c:	00 
  17845d:	48 8d 44 24 10       	lea    0x10(%rsp),%rax
  178462:	48 89 84 24 a8 00 00 	mov    %rax,0xa8(%rsp)
  178469:	00 
  17846a:	48 8d 44 24 68       	lea    0x68(%rsp),%rax
  17846f:	48 89 84 24 b0 00 00 	mov    %rax,0xb0(%rsp)
  178476:	00 
  178477:	4c 8b 24 24          	mov    (%rsp),%r12
  17847b:	49 c1 ec 02          	shr    $0x2,%r12
  17847f:	74 4f                	je     1784d0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x1120>
  178481:	45 31 f6             	xor    %r14d,%r14d
  178484:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
  17848b:	00 00 00 00 00 
  178490:	48 89 df             	mov    %rbx,%rdi
  178493:	4c 89 f6             	mov    %r14,%rsi
  178496:	c5 f8 77             	vzeroupper
  178499:	e8 62 63 18 00       	call   2fe800 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>::{closure#0}>
  17849e:	49 ff c6             	inc    %r14
  1784a1:	48 89 df             	mov    %rbx,%rdi
  1784a4:	4c 89 f6             	mov    %r14,%rsi
  1784a7:	e8 54 63 18 00       	call   2fe800 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>::{closure#0}>
  1784ac:	49 ff c6             	inc    %r14
  1784af:	48 89 df             	mov    %rbx,%rdi
  1784b2:	4c 89 f6             	mov    %r14,%rsi
  1784b5:	e8 46 63 18 00       	call   2fe800 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>::{closure#0}>
  1784ba:	49 ff c6             	inc    %r14
  1784bd:	48 89 df             	mov    %rbx,%rdi
  1784c0:	4c 89 f6             	mov    %r14,%rsi
  1784c3:	e8 38 63 18 00       	call   2fe800 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>::{closure#0}>
  1784c8:	49 ff c6             	inc    %r14
  1784cb:	49 ff cc             	dec    %r12
  1784ce:	75 c0                	jne    178490 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x10e0>
  1784d0:	48 8b 04 24          	mov    (%rsp),%rax
  1784d4:	49 89 c6             	mov    %rax,%r14
  1784d7:	49 83 e6 fc          	and    $0xfffffffffffffffc,%r14
  1784db:	49 39 c6             	cmp    %rax,%r14
  1784de:	4c 8b 64 24 08       	mov    0x8(%rsp),%r12
  1784e3:	0f 84 98 fe ff ff    	je     178381 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xfd1>
  1784e9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  1784f0:	48 89 df             	mov    %rbx,%rdi
  1784f3:	4c 89 f6             	mov    %r14,%rsi
  1784f6:	c5 f8 77             	vzeroupper
  1784f9:	e8 02 63 18 00       	call   2fe800 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>::{closure#0}>
  1784fe:	49 ff c6             	inc    %r14
  178501:	4c 3b 34 24          	cmp    (%rsp),%r14
  178505:	72 e9                	jb     1784f0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x1140>
  178507:	e9 75 fe ff ff       	jmp    178381 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xfd1>
  17850c:	4c 89 7c 24 10       	mov    %r15,0x10(%rsp)
  178511:	48 89 74 24 38       	mov    %rsi,0x38(%rsp)
  178516:	48 8b 44 24 50       	mov    0x50(%rsp),%rax
  17851b:	48 89 44 24 58       	mov    %rax,0x58(%rsp)
  178520:	48 8b 44 24 78       	mov    0x78(%rsp),%rax
  178525:	48 89 44 24 60       	mov    %rax,0x60(%rsp)
  17852a:	48 89 7c 24 68       	mov    %rdi,0x68(%rsp)
  17852f:	4c 89 6c 24 70       	mov    %r13,0x70(%rsp)
  178534:	49 8b af 80 00 00 00 	mov    0x80(%r15),%rbp
  17853b:	48 89 6c 24 18       	mov    %rbp,0x18(%rsp)
  178540:	49 8b 87 a8 00 00 00 	mov    0xa8(%r15),%rax
  178547:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
  17854c:	48 39 c5             	cmp    %rax,%rbp
  17854f:	0f 83 2c 11 00 00    	jae    179681 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x22d1>
  178555:	45 31 e4             	xor    %r12d,%r12d
  178558:	48 8d 05 31 ee 44 00 	lea    0x44ee31(%rip),%rax        # 5c7390 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0xa8>
  17855f:	48 89 84 24 b8 00 00 	mov    %rax,0xb8(%rsp)
  178566:	00 
  178567:	48 8d 9c 24 80 00 00 	lea    0x80(%rsp),%rbx
  17856e:	00 
  17856f:	eb 0e                	jmp    17857f <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x11cf>
  178571:	48 ff c5             	inc    %rbp
  178574:	48 3b 6c 24 30       	cmp    0x30(%rsp),%rbp
  178579:	0f 84 fd 10 00 00    	je     17967c <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x22cc>
  17857f:	48 89 6c 24 40       	mov    %rbp,0x40(%rsp)
  178584:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
  178589:	48 8b 70 28          	mov    0x28(%rax),%rsi
  17858d:	48 39 f5             	cmp    %rsi,%rbp
  178590:	0f 83 39 15 00 00    	jae    179acf <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x271f>
  178596:	48 8b 48 20          	mov    0x20(%rax),%rcx
  17859a:	8b 0c a9             	mov    (%rcx,%rbp,4),%ecx
  17859d:	48 39 ce             	cmp    %rcx,%rsi
  1785a0:	0f 86 6a 14 00 00    	jbe    179a10 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2660>
  1785a6:	4c 8b 40 78          	mov    0x78(%rax),%r8
  1785aa:	48 8b 90 88 00 00 00 	mov    0x88(%rax),%rdx
  1785b1:	31 f6                	xor    %esi,%esi
  1785b3:	48 39 ca             	cmp    %rcx,%rdx
  1785b6:	40 0f 97 c6          	seta   %sil
  1785ba:	bf 00 00 00 00       	mov    $0x0,%edi
  1785bf:	48 0f 46 fa          	cmovbe %rdx,%rdi
  1785c3:	48 29 f9             	sub    %rdi,%rcx
  1785c6:	c1 e6 04             	shl    $0x4,%esi
  1785c9:	4c 89 04 24          	mov    %r8,(%rsp)
  1785cd:	49 0f af c8          	imul   %r8,%rcx
  1785d1:	48 c1 e1 03          	shl    $0x3,%rcx
  1785d5:	48 03 8c 06 90 00 00 	add    0x90(%rsi,%rax,1),%rcx
  1785dc:	00 
  1785dd:	48 89 4c 24 48       	mov    %rcx,0x48(%rsp)
  1785e2:	4c 3b 60 70          	cmp    0x70(%rax),%r12
  1785e6:	73 1f                	jae    178607 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x1257>
  1785e8:	48 8b 40 68          	mov    0x68(%rax),%rax
  1785ec:	4c 89 e1             	mov    %r12,%rcx
  1785ef:	48 c1 e1 04          	shl    $0x4,%rcx
  1785f3:	48 39 2c 08          	cmp    %rbp,(%rax,%rcx,1)
  1785f7:	75 0e                	jne    178607 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x1257>
  1785f9:	48 01 c8             	add    %rcx,%rax
  1785fc:	48 8b 40 08          	mov    0x8(%rax),%rax
  178600:	48 89 04 24          	mov    %rax,(%rsp)
  178604:	49 ff c4             	inc    %r12
  178607:	4c 89 64 24 08       	mov    %r12,0x8(%rsp)
  17860c:	48 8d 44 24 48       	lea    0x48(%rsp),%rax
  178611:	48 89 84 24 80 00 00 	mov    %rax,0x80(%rsp)
  178618:	00 
  178619:	48 8d 44 24 38       	lea    0x38(%rsp),%rax
  17861e:	48 89 84 24 88 00 00 	mov    %rax,0x88(%rsp)
  178625:	00 
  178626:	48 8d 44 24 58       	lea    0x58(%rsp),%rax
  17862b:	48 89 84 24 90 00 00 	mov    %rax,0x90(%rsp)
  178632:	00 
  178633:	48 8d 44 24 18       	lea    0x18(%rsp),%rax
  178638:	48 89 84 24 98 00 00 	mov    %rax,0x98(%rsp)
  17863f:	00 
  178640:	48 8d 44 24 40       	lea    0x40(%rsp),%rax
  178645:	48 89 84 24 a0 00 00 	mov    %rax,0xa0(%rsp)
  17864c:	00 
  17864d:	48 8d 44 24 10       	lea    0x10(%rsp),%rax
  178652:	48 89 84 24 a8 00 00 	mov    %rax,0xa8(%rsp)
  178659:	00 
  17865a:	48 8d 44 24 68       	lea    0x68(%rsp),%rax
  17865f:	48 89 84 24 b0 00 00 	mov    %rax,0xb0(%rsp)
  178666:	00 
  178667:	4c 8b 24 24          	mov    (%rsp),%r12
  17866b:	49 c1 ec 02          	shr    $0x2,%r12
  17866f:	74 4f                	je     1786c0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x1310>
  178671:	45 31 f6             	xor    %r14d,%r14d
  178674:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
  17867b:	00 00 00 00 00 
  178680:	48 89 df             	mov    %rbx,%rdi
  178683:	4c 89 f6             	mov    %r14,%rsi
  178686:	c5 f8 77             	vzeroupper
  178689:	e8 d2 62 18 00       	call   2fe960 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 3>::{closure#0}>
  17868e:	49 ff c6             	inc    %r14
  178691:	48 89 df             	mov    %rbx,%rdi
  178694:	4c 89 f6             	mov    %r14,%rsi
  178697:	e8 c4 62 18 00       	call   2fe960 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 3>::{closure#0}>
  17869c:	49 ff c6             	inc    %r14
  17869f:	48 89 df             	mov    %rbx,%rdi
  1786a2:	4c 89 f6             	mov    %r14,%rsi
  1786a5:	e8 b6 62 18 00       	call   2fe960 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 3>::{closure#0}>
  1786aa:	49 ff c6             	inc    %r14
  1786ad:	48 89 df             	mov    %rbx,%rdi
  1786b0:	4c 89 f6             	mov    %r14,%rsi
  1786b3:	e8 a8 62 18 00       	call   2fe960 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 3>::{closure#0}>
  1786b8:	49 ff c6             	inc    %r14
  1786bb:	49 ff cc             	dec    %r12
  1786be:	75 c0                	jne    178680 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x12d0>
  1786c0:	48 8b 04 24          	mov    (%rsp),%rax
  1786c4:	49 89 c6             	mov    %rax,%r14
  1786c7:	49 83 e6 fc          	and    $0xfffffffffffffffc,%r14
  1786cb:	49 39 c6             	cmp    %rax,%r14
  1786ce:	4c 8b 64 24 08       	mov    0x8(%rsp),%r12
  1786d3:	0f 84 98 fe ff ff    	je     178571 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x11c1>
  1786d9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  1786e0:	48 89 df             	mov    %rbx,%rdi
  1786e3:	4c 89 f6             	mov    %r14,%rsi
  1786e6:	c5 f8 77             	vzeroupper
  1786e9:	e8 72 62 18 00       	call   2fe960 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 3>::{closure#0}>
  1786ee:	49 ff c6             	inc    %r14
  1786f1:	4c 3b 34 24          	cmp    (%rsp),%r14
  1786f5:	72 e9                	jb     1786e0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x1330>
  1786f7:	e9 75 fe ff ff       	jmp    178571 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x11c1>
  1786fc:	4c 89 7c 24 10       	mov    %r15,0x10(%rsp)
  178701:	48 89 74 24 38       	mov    %rsi,0x38(%rsp)
  178706:	48 8b 44 24 50       	mov    0x50(%rsp),%rax
  17870b:	48 89 44 24 58       	mov    %rax,0x58(%rsp)
  178710:	48 8b 44 24 78       	mov    0x78(%rsp),%rax
  178715:	48 89 44 24 60       	mov    %rax,0x60(%rsp)
  17871a:	48 89 7c 24 68       	mov    %rdi,0x68(%rsp)
  17871f:	4c 89 6c 24 70       	mov    %r13,0x70(%rsp)
  178724:	49 8b af 80 00 00 00 	mov    0x80(%r15),%rbp
  17872b:	48 89 6c 24 18       	mov    %rbp,0x18(%rsp)
  178730:	49 8b 87 a8 00 00 00 	mov    0xa8(%r15),%rax
  178737:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
  17873c:	48 39 c5             	cmp    %rax,%rbp
  17873f:	0f 83 3c 0f 00 00    	jae    179681 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x22d1>
  178745:	45 31 e4             	xor    %r12d,%r12d
  178748:	48 8d 05 41 ec 44 00 	lea    0x44ec41(%rip),%rax        # 5c7390 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0xa8>
  17874f:	48 89 84 24 b8 00 00 	mov    %rax,0xb8(%rsp)
  178756:	00 
  178757:	48 8d 9c 24 80 00 00 	lea    0x80(%rsp),%rbx
  17875e:	00 
  17875f:	eb 0e                	jmp    17876f <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x13bf>
  178761:	48 ff c5             	inc    %rbp
  178764:	48 3b 6c 24 30       	cmp    0x30(%rsp),%rbp
  178769:	0f 84 0d 0f 00 00    	je     17967c <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x22cc>
  17876f:	48 89 6c 24 40       	mov    %rbp,0x40(%rsp)
  178774:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
  178779:	48 8b 70 28          	mov    0x28(%rax),%rsi
  17877d:	48 39 f5             	cmp    %rsi,%rbp
  178780:	0f 83 49 13 00 00    	jae    179acf <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x271f>
  178786:	48 8b 48 20          	mov    0x20(%rax),%rcx
  17878a:	8b 0c a9             	mov    (%rcx,%rbp,4),%ecx
  17878d:	48 39 ce             	cmp    %rcx,%rsi
  178790:	0f 86 7a 12 00 00    	jbe    179a10 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2660>
  178796:	4c 8b 40 78          	mov    0x78(%rax),%r8
  17879a:	48 8b 90 88 00 00 00 	mov    0x88(%rax),%rdx
  1787a1:	31 f6                	xor    %esi,%esi
  1787a3:	48 39 ca             	cmp    %rcx,%rdx
  1787a6:	40 0f 97 c6          	seta   %sil
  1787aa:	bf 00 00 00 00       	mov    $0x0,%edi
  1787af:	48 0f 46 fa          	cmovbe %rdx,%rdi
  1787b3:	48 29 f9             	sub    %rdi,%rcx
  1787b6:	c1 e6 04             	shl    $0x4,%esi
  1787b9:	4c 89 04 24          	mov    %r8,(%rsp)
  1787bd:	49 0f af c8          	imul   %r8,%rcx
  1787c1:	48 c1 e1 03          	shl    $0x3,%rcx
  1787c5:	48 03 8c 06 90 00 00 	add    0x90(%rsi,%rax,1),%rcx
  1787cc:	00 
  1787cd:	48 89 4c 24 48       	mov    %rcx,0x48(%rsp)
  1787d2:	4c 3b 60 70          	cmp    0x70(%rax),%r12
  1787d6:	73 1f                	jae    1787f7 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x1447>
  1787d8:	48 8b 40 68          	mov    0x68(%rax),%rax
  1787dc:	4c 89 e1             	mov    %r12,%rcx
  1787df:	48 c1 e1 04          	shl    $0x4,%rcx
  1787e3:	48 39 2c 08          	cmp    %rbp,(%rax,%rcx,1)
  1787e7:	75 0e                	jne    1787f7 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x1447>
  1787e9:	48 01 c8             	add    %rcx,%rax
  1787ec:	48 8b 40 08          	mov    0x8(%rax),%rax
  1787f0:	48 89 04 24          	mov    %rax,(%rsp)
  1787f4:	49 ff c4             	inc    %r12
  1787f7:	4c 89 64 24 08       	mov    %r12,0x8(%rsp)
  1787fc:	48 8d 44 24 48       	lea    0x48(%rsp),%rax
  178801:	48 89 84 24 80 00 00 	mov    %rax,0x80(%rsp)
  178808:	00 
  178809:	48 8d 44 24 38       	lea    0x38(%rsp),%rax
  17880e:	48 89 84 24 88 00 00 	mov    %rax,0x88(%rsp)
  178815:	00 
  178816:	48 8d 44 24 58       	lea    0x58(%rsp),%rax
  17881b:	48 89 84 24 90 00 00 	mov    %rax,0x90(%rsp)
  178822:	00 
  178823:	48 8d 44 24 18       	lea    0x18(%rsp),%rax
  178828:	48 89 84 24 98 00 00 	mov    %rax,0x98(%rsp)
  17882f:	00 
  178830:	48 8d 44 24 40       	lea    0x40(%rsp),%rax
  178835:	48 89 84 24 a0 00 00 	mov    %rax,0xa0(%rsp)
  17883c:	00 
  17883d:	48 8d 44 24 10       	lea    0x10(%rsp),%rax
  178842:	48 89 84 24 a8 00 00 	mov    %rax,0xa8(%rsp)
  178849:	00 
  17884a:	48 8d 44 24 68       	lea    0x68(%rsp),%rax
  17884f:	48 89 84 24 b0 00 00 	mov    %rax,0xb0(%rsp)
  178856:	00 
  178857:	4c 8b 24 24          	mov    (%rsp),%r12
  17885b:	49 c1 ec 02          	shr    $0x2,%r12
  17885f:	74 4f                	je     1788b0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x1500>
  178861:	45 31 f6             	xor    %r14d,%r14d
  178864:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
  17886b:	00 00 00 00 00 
  178870:	48 89 df             	mov    %rbx,%rdi
  178873:	4c 89 f6             	mov    %r14,%rsi
  178876:	c5 f8 77             	vzeroupper
  178879:	e8 e2 60 18 00       	call   2fe960 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 3>::{closure#0}>
  17887e:	49 ff c6             	inc    %r14
  178881:	48 89 df             	mov    %rbx,%rdi
  178884:	4c 89 f6             	mov    %r14,%rsi
  178887:	e8 d4 60 18 00       	call   2fe960 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 3>::{closure#0}>
  17888c:	49 ff c6             	inc    %r14
  17888f:	48 89 df             	mov    %rbx,%rdi
  178892:	4c 89 f6             	mov    %r14,%rsi
  178895:	e8 c6 60 18 00       	call   2fe960 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 3>::{closure#0}>
  17889a:	49 ff c6             	inc    %r14
  17889d:	48 89 df             	mov    %rbx,%rdi
  1788a0:	4c 89 f6             	mov    %r14,%rsi
  1788a3:	e8 b8 60 18 00       	call   2fe960 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 3>::{closure#0}>
  1788a8:	49 ff c6             	inc    %r14
  1788ab:	49 ff cc             	dec    %r12
  1788ae:	75 c0                	jne    178870 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x14c0>
  1788b0:	48 8b 04 24          	mov    (%rsp),%rax
  1788b4:	49 89 c6             	mov    %rax,%r14
  1788b7:	49 83 e6 fc          	and    $0xfffffffffffffffc,%r14
  1788bb:	49 39 c6             	cmp    %rax,%r14
  1788be:	4c 8b 64 24 08       	mov    0x8(%rsp),%r12
  1788c3:	0f 84 98 fe ff ff    	je     178761 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x13b1>
  1788c9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  1788d0:	48 89 df             	mov    %rbx,%rdi
  1788d3:	4c 89 f6             	mov    %r14,%rsi
  1788d6:	c5 f8 77             	vzeroupper
  1788d9:	e8 82 60 18 00       	call   2fe960 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 3>::{closure#0}>
  1788de:	49 ff c6             	inc    %r14
  1788e1:	4c 3b 34 24          	cmp    (%rsp),%r14
  1788e5:	72 e9                	jb     1788d0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x1520>
  1788e7:	e9 75 fe ff ff       	jmp    178761 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x13b1>
  1788ec:	4c 89 7c 24 10       	mov    %r15,0x10(%rsp)
  1788f1:	48 89 74 24 38       	mov    %rsi,0x38(%rsp)
  1788f6:	48 8b 44 24 50       	mov    0x50(%rsp),%rax
  1788fb:	48 89 44 24 58       	mov    %rax,0x58(%rsp)
  178900:	48 8b 44 24 78       	mov    0x78(%rsp),%rax
  178905:	48 89 44 24 60       	mov    %rax,0x60(%rsp)
  17890a:	48 89 7c 24 68       	mov    %rdi,0x68(%rsp)
  17890f:	4c 89 6c 24 70       	mov    %r13,0x70(%rsp)
  178914:	49 8b af 80 00 00 00 	mov    0x80(%r15),%rbp
  17891b:	48 89 6c 24 18       	mov    %rbp,0x18(%rsp)
  178920:	49 8b 87 a8 00 00 00 	mov    0xa8(%r15),%rax
  178927:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
  17892c:	48 39 c5             	cmp    %rax,%rbp
  17892f:	0f 83 4c 0d 00 00    	jae    179681 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x22d1>
  178935:	45 31 e4             	xor    %r12d,%r12d
  178938:	48 8d 05 51 ea 44 00 	lea    0x44ea51(%rip),%rax        # 5c7390 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0xa8>
  17893f:	48 89 84 24 b8 00 00 	mov    %rax,0xb8(%rsp)
  178946:	00 
  178947:	48 8d 9c 24 80 00 00 	lea    0x80(%rsp),%rbx
  17894e:	00 
  17894f:	eb 0e                	jmp    17895f <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x15af>
  178951:	48 ff c5             	inc    %rbp
  178954:	48 3b 6c 24 30       	cmp    0x30(%rsp),%rbp
  178959:	0f 84 1d 0d 00 00    	je     17967c <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x22cc>
  17895f:	48 89 6c 24 40       	mov    %rbp,0x40(%rsp)
  178964:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
  178969:	48 8b 70 28          	mov    0x28(%rax),%rsi
  17896d:	48 39 f5             	cmp    %rsi,%rbp
  178970:	0f 83 59 11 00 00    	jae    179acf <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x271f>
  178976:	48 8b 48 20          	mov    0x20(%rax),%rcx
  17897a:	8b 0c a9             	mov    (%rcx,%rbp,4),%ecx
  17897d:	48 39 ce             	cmp    %rcx,%rsi
  178980:	0f 86 8a 10 00 00    	jbe    179a10 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2660>
  178986:	4c 8b 40 78          	mov    0x78(%rax),%r8
  17898a:	48 8b 90 88 00 00 00 	mov    0x88(%rax),%rdx
  178991:	31 f6                	xor    %esi,%esi
  178993:	48 39 ca             	cmp    %rcx,%rdx
  178996:	40 0f 97 c6          	seta   %sil
  17899a:	bf 00 00 00 00       	mov    $0x0,%edi
  17899f:	48 0f 46 fa          	cmovbe %rdx,%rdi
  1789a3:	48 29 f9             	sub    %rdi,%rcx
  1789a6:	c1 e6 04             	shl    $0x4,%esi
  1789a9:	4c 89 04 24          	mov    %r8,(%rsp)
  1789ad:	49 0f af c8          	imul   %r8,%rcx
  1789b1:	48 c1 e1 03          	shl    $0x3,%rcx
  1789b5:	48 03 8c 06 90 00 00 	add    0x90(%rsi,%rax,1),%rcx
  1789bc:	00 
  1789bd:	48 89 4c 24 48       	mov    %rcx,0x48(%rsp)
  1789c2:	4c 3b 60 70          	cmp    0x70(%rax),%r12
  1789c6:	73 1f                	jae    1789e7 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x1637>
  1789c8:	48 8b 40 68          	mov    0x68(%rax),%rax
  1789cc:	4c 89 e1             	mov    %r12,%rcx
  1789cf:	48 c1 e1 04          	shl    $0x4,%rcx
  1789d3:	48 39 2c 08          	cmp    %rbp,(%rax,%rcx,1)
  1789d7:	75 0e                	jne    1789e7 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x1637>
  1789d9:	48 01 c8             	add    %rcx,%rax
  1789dc:	48 8b 40 08          	mov    0x8(%rax),%rax
  1789e0:	48 89 04 24          	mov    %rax,(%rsp)
  1789e4:	49 ff c4             	inc    %r12
  1789e7:	4c 89 64 24 08       	mov    %r12,0x8(%rsp)
  1789ec:	48 8d 44 24 48       	lea    0x48(%rsp),%rax
  1789f1:	48 89 84 24 80 00 00 	mov    %rax,0x80(%rsp)
  1789f8:	00 
  1789f9:	48 8d 44 24 38       	lea    0x38(%rsp),%rax
  1789fe:	48 89 84 24 88 00 00 	mov    %rax,0x88(%rsp)
  178a05:	00 
  178a06:	48 8d 44 24 58       	lea    0x58(%rsp),%rax
  178a0b:	48 89 84 24 90 00 00 	mov    %rax,0x90(%rsp)
  178a12:	00 
  178a13:	48 8d 44 24 18       	lea    0x18(%rsp),%rax
  178a18:	48 89 84 24 98 00 00 	mov    %rax,0x98(%rsp)
  178a1f:	00 
  178a20:	48 8d 44 24 40       	lea    0x40(%rsp),%rax
  178a25:	48 89 84 24 a0 00 00 	mov    %rax,0xa0(%rsp)
  178a2c:	00 
  178a2d:	48 8d 44 24 10       	lea    0x10(%rsp),%rax
  178a32:	48 89 84 24 a8 00 00 	mov    %rax,0xa8(%rsp)
  178a39:	00 
  178a3a:	48 8d 44 24 68       	lea    0x68(%rsp),%rax
  178a3f:	48 89 84 24 b0 00 00 	mov    %rax,0xb0(%rsp)
  178a46:	00 
  178a47:	4c 8b 24 24          	mov    (%rsp),%r12
  178a4b:	49 c1 ec 02          	shr    $0x2,%r12
  178a4f:	74 4f                	je     178aa0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x16f0>
  178a51:	45 31 f6             	xor    %r14d,%r14d
  178a54:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
  178a5b:	00 00 00 00 00 
  178a60:	48 89 df             	mov    %rbx,%rdi
  178a63:	4c 89 f6             	mov    %r14,%rsi
  178a66:	c5 f8 77             	vzeroupper
  178a69:	e8 f2 5e 18 00       	call   2fe960 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 3>::{closure#0}>
  178a6e:	49 ff c6             	inc    %r14
  178a71:	48 89 df             	mov    %rbx,%rdi
  178a74:	4c 89 f6             	mov    %r14,%rsi
  178a77:	e8 e4 5e 18 00       	call   2fe960 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 3>::{closure#0}>
  178a7c:	49 ff c6             	inc    %r14
  178a7f:	48 89 df             	mov    %rbx,%rdi
  178a82:	4c 89 f6             	mov    %r14,%rsi
  178a85:	e8 d6 5e 18 00       	call   2fe960 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 3>::{closure#0}>
  178a8a:	49 ff c6             	inc    %r14
  178a8d:	48 89 df             	mov    %rbx,%rdi
  178a90:	4c 89 f6             	mov    %r14,%rsi
  178a93:	e8 c8 5e 18 00       	call   2fe960 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 3>::{closure#0}>
  178a98:	49 ff c6             	inc    %r14
  178a9b:	49 ff cc             	dec    %r12
  178a9e:	75 c0                	jne    178a60 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x16b0>
  178aa0:	48 8b 04 24          	mov    (%rsp),%rax
  178aa4:	49 89 c6             	mov    %rax,%r14
  178aa7:	49 83 e6 fc          	and    $0xfffffffffffffffc,%r14
  178aab:	49 39 c6             	cmp    %rax,%r14
  178aae:	4c 8b 64 24 08       	mov    0x8(%rsp),%r12
  178ab3:	0f 84 98 fe ff ff    	je     178951 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x15a1>
  178ab9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  178ac0:	48 89 df             	mov    %rbx,%rdi
  178ac3:	4c 89 f6             	mov    %r14,%rsi
  178ac6:	c5 f8 77             	vzeroupper
  178ac9:	e8 92 5e 18 00       	call   2fe960 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 3>::{closure#0}>
  178ace:	49 ff c6             	inc    %r14
  178ad1:	4c 3b 34 24          	cmp    (%rsp),%r14
  178ad5:	72 e9                	jb     178ac0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x1710>
  178ad7:	e9 75 fe ff ff       	jmp    178951 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x15a1>
  178adc:	4c 89 7c 24 10       	mov    %r15,0x10(%rsp)
  178ae1:	48 89 74 24 38       	mov    %rsi,0x38(%rsp)
  178ae6:	48 8b 44 24 50       	mov    0x50(%rsp),%rax
  178aeb:	48 89 44 24 58       	mov    %rax,0x58(%rsp)
  178af0:	48 8b 44 24 78       	mov    0x78(%rsp),%rax
  178af5:	48 89 44 24 60       	mov    %rax,0x60(%rsp)
  178afa:	48 89 7c 24 68       	mov    %rdi,0x68(%rsp)
  178aff:	4c 89 6c 24 70       	mov    %r13,0x70(%rsp)
  178b04:	49 8b af 80 00 00 00 	mov    0x80(%r15),%rbp
  178b0b:	48 89 6c 24 18       	mov    %rbp,0x18(%rsp)
  178b10:	49 8b 87 a8 00 00 00 	mov    0xa8(%r15),%rax
  178b17:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
  178b1c:	48 39 c5             	cmp    %rax,%rbp
  178b1f:	0f 83 5c 0b 00 00    	jae    179681 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x22d1>
  178b25:	45 31 e4             	xor    %r12d,%r12d
  178b28:	48 8d 05 61 e8 44 00 	lea    0x44e861(%rip),%rax        # 5c7390 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0xa8>
  178b2f:	48 89 84 24 b8 00 00 	mov    %rax,0xb8(%rsp)
  178b36:	00 
  178b37:	48 8d 9c 24 80 00 00 	lea    0x80(%rsp),%rbx
  178b3e:	00 
  178b3f:	eb 0e                	jmp    178b4f <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x179f>
  178b41:	48 ff c5             	inc    %rbp
  178b44:	48 3b 6c 24 30       	cmp    0x30(%rsp),%rbp
  178b49:	0f 84 2d 0b 00 00    	je     17967c <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x22cc>
  178b4f:	48 89 6c 24 40       	mov    %rbp,0x40(%rsp)
  178b54:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
  178b59:	48 8b 70 28          	mov    0x28(%rax),%rsi
  178b5d:	48 39 f5             	cmp    %rsi,%rbp
  178b60:	0f 83 69 0f 00 00    	jae    179acf <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x271f>
  178b66:	48 8b 48 20          	mov    0x20(%rax),%rcx
  178b6a:	8b 0c a9             	mov    (%rcx,%rbp,4),%ecx
  178b6d:	48 39 ce             	cmp    %rcx,%rsi
  178b70:	0f 86 9a 0e 00 00    	jbe    179a10 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2660>
  178b76:	4c 8b 40 78          	mov    0x78(%rax),%r8
  178b7a:	48 8b 90 88 00 00 00 	mov    0x88(%rax),%rdx
  178b81:	31 f6                	xor    %esi,%esi
  178b83:	48 39 ca             	cmp    %rcx,%rdx
  178b86:	40 0f 97 c6          	seta   %sil
  178b8a:	bf 00 00 00 00       	mov    $0x0,%edi
  178b8f:	48 0f 46 fa          	cmovbe %rdx,%rdi
  178b93:	48 29 f9             	sub    %rdi,%rcx
  178b96:	c1 e6 04             	shl    $0x4,%esi
  178b99:	4c 89 04 24          	mov    %r8,(%rsp)
  178b9d:	49 0f af c8          	imul   %r8,%rcx
  178ba1:	48 c1 e1 03          	shl    $0x3,%rcx
  178ba5:	48 03 8c 06 90 00 00 	add    0x90(%rsi,%rax,1),%rcx
  178bac:	00 
  178bad:	48 89 4c 24 48       	mov    %rcx,0x48(%rsp)
  178bb2:	4c 3b 60 70          	cmp    0x70(%rax),%r12
  178bb6:	73 1f                	jae    178bd7 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x1827>
  178bb8:	48 8b 40 68          	mov    0x68(%rax),%rax
  178bbc:	4c 89 e1             	mov    %r12,%rcx
  178bbf:	48 c1 e1 04          	shl    $0x4,%rcx
  178bc3:	48 39 2c 08          	cmp    %rbp,(%rax,%rcx,1)
  178bc7:	75 0e                	jne    178bd7 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x1827>
  178bc9:	48 01 c8             	add    %rcx,%rax
  178bcc:	48 8b 40 08          	mov    0x8(%rax),%rax
  178bd0:	48 89 04 24          	mov    %rax,(%rsp)
  178bd4:	49 ff c4             	inc    %r12
  178bd7:	4c 89 64 24 08       	mov    %r12,0x8(%rsp)
  178bdc:	48 8d 44 24 48       	lea    0x48(%rsp),%rax
  178be1:	48 89 84 24 80 00 00 	mov    %rax,0x80(%rsp)
  178be8:	00 
  178be9:	48 8d 44 24 38       	lea    0x38(%rsp),%rax
  178bee:	48 89 84 24 88 00 00 	mov    %rax,0x88(%rsp)
  178bf5:	00 
  178bf6:	48 8d 44 24 58       	lea    0x58(%rsp),%rax
  178bfb:	48 89 84 24 90 00 00 	mov    %rax,0x90(%rsp)
  178c02:	00 
  178c03:	48 8d 44 24 18       	lea    0x18(%rsp),%rax
  178c08:	48 89 84 24 98 00 00 	mov    %rax,0x98(%rsp)
  178c0f:	00 
  178c10:	48 8d 44 24 40       	lea    0x40(%rsp),%rax
  178c15:	48 89 84 24 a0 00 00 	mov    %rax,0xa0(%rsp)
  178c1c:	00 
  178c1d:	48 8d 44 24 10       	lea    0x10(%rsp),%rax
  178c22:	48 89 84 24 a8 00 00 	mov    %rax,0xa8(%rsp)
  178c29:	00 
  178c2a:	48 8d 44 24 68       	lea    0x68(%rsp),%rax
  178c2f:	48 89 84 24 b0 00 00 	mov    %rax,0xb0(%rsp)
  178c36:	00 
  178c37:	4c 8b 24 24          	mov    (%rsp),%r12
  178c3b:	49 c1 ec 02          	shr    $0x2,%r12
  178c3f:	74 4f                	je     178c90 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x18e0>
  178c41:	45 31 f6             	xor    %r14d,%r14d
  178c44:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
  178c4b:	00 00 00 00 00 
  178c50:	48 89 df             	mov    %rbx,%rdi
  178c53:	4c 89 f6             	mov    %r14,%rsi
  178c56:	c5 f8 77             	vzeroupper
  178c59:	e8 42 5a 18 00       	call   2fe6a0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>::{closure#0}>
  178c5e:	49 ff c6             	inc    %r14
  178c61:	48 89 df             	mov    %rbx,%rdi
  178c64:	4c 89 f6             	mov    %r14,%rsi
  178c67:	e8 34 5a 18 00       	call   2fe6a0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>::{closure#0}>
  178c6c:	49 ff c6             	inc    %r14
  178c6f:	48 89 df             	mov    %rbx,%rdi
  178c72:	4c 89 f6             	mov    %r14,%rsi
  178c75:	e8 26 5a 18 00       	call   2fe6a0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>::{closure#0}>
  178c7a:	49 ff c6             	inc    %r14
  178c7d:	48 89 df             	mov    %rbx,%rdi
  178c80:	4c 89 f6             	mov    %r14,%rsi
  178c83:	e8 18 5a 18 00       	call   2fe6a0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>::{closure#0}>
  178c88:	49 ff c6             	inc    %r14
  178c8b:	49 ff cc             	dec    %r12
  178c8e:	75 c0                	jne    178c50 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x18a0>
  178c90:	48 8b 04 24          	mov    (%rsp),%rax
  178c94:	49 89 c6             	mov    %rax,%r14
  178c97:	49 83 e6 fc          	and    $0xfffffffffffffffc,%r14
  178c9b:	49 39 c6             	cmp    %rax,%r14
  178c9e:	4c 8b 64 24 08       	mov    0x8(%rsp),%r12
  178ca3:	0f 84 98 fe ff ff    	je     178b41 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x1791>
  178ca9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  178cb0:	48 89 df             	mov    %rbx,%rdi
  178cb3:	4c 89 f6             	mov    %r14,%rsi
  178cb6:	c5 f8 77             	vzeroupper
  178cb9:	e8 e2 59 18 00       	call   2fe6a0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>::{closure#0}>
  178cbe:	49 ff c6             	inc    %r14
  178cc1:	4c 3b 34 24          	cmp    (%rsp),%r14
  178cc5:	72 e9                	jb     178cb0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x1900>
  178cc7:	e9 75 fe ff ff       	jmp    178b41 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x1791>
  178ccc:	4c 89 7c 24 10       	mov    %r15,0x10(%rsp)
  178cd1:	48 89 74 24 38       	mov    %rsi,0x38(%rsp)
  178cd6:	48 8b 44 24 50       	mov    0x50(%rsp),%rax
  178cdb:	48 89 44 24 58       	mov    %rax,0x58(%rsp)
  178ce0:	48 8b 44 24 78       	mov    0x78(%rsp),%rax
  178ce5:	48 89 44 24 60       	mov    %rax,0x60(%rsp)
  178cea:	48 89 7c 24 68       	mov    %rdi,0x68(%rsp)
  178cef:	4c 89 6c 24 70       	mov    %r13,0x70(%rsp)
  178cf4:	49 8b af 80 00 00 00 	mov    0x80(%r15),%rbp
  178cfb:	48 89 6c 24 18       	mov    %rbp,0x18(%rsp)
  178d00:	49 8b 87 a8 00 00 00 	mov    0xa8(%r15),%rax
  178d07:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
  178d0c:	48 39 c5             	cmp    %rax,%rbp
  178d0f:	0f 83 6c 09 00 00    	jae    179681 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x22d1>
  178d15:	45 31 e4             	xor    %r12d,%r12d
  178d18:	48 8d 05 71 e6 44 00 	lea    0x44e671(%rip),%rax        # 5c7390 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0xa8>
  178d1f:	48 89 84 24 b8 00 00 	mov    %rax,0xb8(%rsp)
  178d26:	00 
  178d27:	48 8d 9c 24 80 00 00 	lea    0x80(%rsp),%rbx
  178d2e:	00 
  178d2f:	eb 0e                	jmp    178d3f <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x198f>
  178d31:	48 ff c5             	inc    %rbp
  178d34:	48 3b 6c 24 30       	cmp    0x30(%rsp),%rbp
  178d39:	0f 84 3d 09 00 00    	je     17967c <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x22cc>
  178d3f:	48 89 6c 24 40       	mov    %rbp,0x40(%rsp)
  178d44:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
  178d49:	48 8b 70 28          	mov    0x28(%rax),%rsi
  178d4d:	48 39 f5             	cmp    %rsi,%rbp
  178d50:	0f 83 79 0d 00 00    	jae    179acf <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x271f>
  178d56:	48 8b 48 20          	mov    0x20(%rax),%rcx
  178d5a:	8b 0c a9             	mov    (%rcx,%rbp,4),%ecx
  178d5d:	48 39 ce             	cmp    %rcx,%rsi
  178d60:	0f 86 aa 0c 00 00    	jbe    179a10 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2660>
  178d66:	4c 8b 40 78          	mov    0x78(%rax),%r8
  178d6a:	48 8b 90 88 00 00 00 	mov    0x88(%rax),%rdx
  178d71:	31 f6                	xor    %esi,%esi
  178d73:	48 39 ca             	cmp    %rcx,%rdx
  178d76:	40 0f 97 c6          	seta   %sil
  178d7a:	bf 00 00 00 00       	mov    $0x0,%edi
  178d7f:	48 0f 46 fa          	cmovbe %rdx,%rdi
  178d83:	48 29 f9             	sub    %rdi,%rcx
  178d86:	c1 e6 04             	shl    $0x4,%esi
  178d89:	4c 89 04 24          	mov    %r8,(%rsp)
  178d8d:	49 0f af c8          	imul   %r8,%rcx
  178d91:	48 c1 e1 03          	shl    $0x3,%rcx
  178d95:	48 03 8c 06 90 00 00 	add    0x90(%rsi,%rax,1),%rcx
  178d9c:	00 
  178d9d:	48 89 4c 24 48       	mov    %rcx,0x48(%rsp)
  178da2:	4c 3b 60 70          	cmp    0x70(%rax),%r12
  178da6:	73 1f                	jae    178dc7 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x1a17>
  178da8:	48 8b 40 68          	mov    0x68(%rax),%rax
  178dac:	4c 89 e1             	mov    %r12,%rcx
  178daf:	48 c1 e1 04          	shl    $0x4,%rcx
  178db3:	48 39 2c 08          	cmp    %rbp,(%rax,%rcx,1)
  178db7:	75 0e                	jne    178dc7 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x1a17>
  178db9:	48 01 c8             	add    %rcx,%rax
  178dbc:	48 8b 40 08          	mov    0x8(%rax),%rax
  178dc0:	48 89 04 24          	mov    %rax,(%rsp)
  178dc4:	49 ff c4             	inc    %r12
  178dc7:	4c 89 64 24 08       	mov    %r12,0x8(%rsp)
  178dcc:	48 8d 44 24 48       	lea    0x48(%rsp),%rax
  178dd1:	48 89 84 24 80 00 00 	mov    %rax,0x80(%rsp)
  178dd8:	00 
  178dd9:	48 8d 44 24 38       	lea    0x38(%rsp),%rax
  178dde:	48 89 84 24 88 00 00 	mov    %rax,0x88(%rsp)
  178de5:	00 
  178de6:	48 8d 44 24 58       	lea    0x58(%rsp),%rax
  178deb:	48 89 84 24 90 00 00 	mov    %rax,0x90(%rsp)
  178df2:	00 
  178df3:	48 8d 44 24 18       	lea    0x18(%rsp),%rax
  178df8:	48 89 84 24 98 00 00 	mov    %rax,0x98(%rsp)
  178dff:	00 
  178e00:	48 8d 44 24 40       	lea    0x40(%rsp),%rax
  178e05:	48 89 84 24 a0 00 00 	mov    %rax,0xa0(%rsp)
  178e0c:	00 
  178e0d:	48 8d 44 24 10       	lea    0x10(%rsp),%rax
  178e12:	48 89 84 24 a8 00 00 	mov    %rax,0xa8(%rsp)
  178e19:	00 
  178e1a:	48 8d 44 24 68       	lea    0x68(%rsp),%rax
  178e1f:	48 89 84 24 b0 00 00 	mov    %rax,0xb0(%rsp)
  178e26:	00 
  178e27:	4c 8b 24 24          	mov    (%rsp),%r12
  178e2b:	49 c1 ec 02          	shr    $0x2,%r12
  178e2f:	74 4f                	je     178e80 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x1ad0>
  178e31:	45 31 f6             	xor    %r14d,%r14d
  178e34:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
  178e3b:	00 00 00 00 00 
  178e40:	48 89 df             	mov    %rbx,%rdi
  178e43:	4c 89 f6             	mov    %r14,%rsi
  178e46:	c5 f8 77             	vzeroupper
  178e49:	e8 52 58 18 00       	call   2fe6a0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>::{closure#0}>
  178e4e:	49 ff c6             	inc    %r14
  178e51:	48 89 df             	mov    %rbx,%rdi
  178e54:	4c 89 f6             	mov    %r14,%rsi
  178e57:	e8 44 58 18 00       	call   2fe6a0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>::{closure#0}>
  178e5c:	49 ff c6             	inc    %r14
  178e5f:	48 89 df             	mov    %rbx,%rdi
  178e62:	4c 89 f6             	mov    %r14,%rsi
  178e65:	e8 36 58 18 00       	call   2fe6a0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>::{closure#0}>
  178e6a:	49 ff c6             	inc    %r14
  178e6d:	48 89 df             	mov    %rbx,%rdi
  178e70:	4c 89 f6             	mov    %r14,%rsi
  178e73:	e8 28 58 18 00       	call   2fe6a0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>::{closure#0}>
  178e78:	49 ff c6             	inc    %r14
  178e7b:	49 ff cc             	dec    %r12
  178e7e:	75 c0                	jne    178e40 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x1a90>
  178e80:	48 8b 04 24          	mov    (%rsp),%rax
  178e84:	49 89 c6             	mov    %rax,%r14
  178e87:	49 83 e6 fc          	and    $0xfffffffffffffffc,%r14
  178e8b:	49 39 c6             	cmp    %rax,%r14
  178e8e:	4c 8b 64 24 08       	mov    0x8(%rsp),%r12
  178e93:	0f 84 98 fe ff ff    	je     178d31 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x1981>
  178e99:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  178ea0:	48 89 df             	mov    %rbx,%rdi
  178ea3:	4c 89 f6             	mov    %r14,%rsi
  178ea6:	c5 f8 77             	vzeroupper
  178ea9:	e8 f2 57 18 00       	call   2fe6a0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>::{closure#0}>
  178eae:	49 ff c6             	inc    %r14
  178eb1:	4c 3b 34 24          	cmp    (%rsp),%r14
  178eb5:	72 e9                	jb     178ea0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x1af0>
  178eb7:	e9 75 fe ff ff       	jmp    178d31 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x1981>
  178ebc:	4c 89 7c 24 10       	mov    %r15,0x10(%rsp)
  178ec1:	48 89 74 24 38       	mov    %rsi,0x38(%rsp)
  178ec6:	48 8b 44 24 50       	mov    0x50(%rsp),%rax
  178ecb:	48 89 44 24 58       	mov    %rax,0x58(%rsp)
  178ed0:	48 8b 44 24 78       	mov    0x78(%rsp),%rax
  178ed5:	48 89 44 24 60       	mov    %rax,0x60(%rsp)
  178eda:	48 89 7c 24 68       	mov    %rdi,0x68(%rsp)
  178edf:	4c 89 6c 24 70       	mov    %r13,0x70(%rsp)
  178ee4:	49 8b af 80 00 00 00 	mov    0x80(%r15),%rbp
  178eeb:	48 89 6c 24 18       	mov    %rbp,0x18(%rsp)
  178ef0:	49 8b 87 a8 00 00 00 	mov    0xa8(%r15),%rax
  178ef7:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
  178efc:	48 39 c5             	cmp    %rax,%rbp
  178eff:	0f 83 7c 07 00 00    	jae    179681 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x22d1>
  178f05:	45 31 e4             	xor    %r12d,%r12d
  178f08:	48 8d 05 81 e4 44 00 	lea    0x44e481(%rip),%rax        # 5c7390 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0xa8>
  178f0f:	48 89 84 24 b8 00 00 	mov    %rax,0xb8(%rsp)
  178f16:	00 
  178f17:	48 8d 9c 24 80 00 00 	lea    0x80(%rsp),%rbx
  178f1e:	00 
  178f1f:	eb 0e                	jmp    178f2f <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x1b7f>
  178f21:	48 ff c5             	inc    %rbp
  178f24:	48 3b 6c 24 30       	cmp    0x30(%rsp),%rbp
  178f29:	0f 84 4d 07 00 00    	je     17967c <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x22cc>
  178f2f:	48 89 6c 24 40       	mov    %rbp,0x40(%rsp)
  178f34:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
  178f39:	48 8b 70 28          	mov    0x28(%rax),%rsi
  178f3d:	48 39 f5             	cmp    %rsi,%rbp
  178f40:	0f 83 89 0b 00 00    	jae    179acf <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x271f>
  178f46:	48 8b 48 20          	mov    0x20(%rax),%rcx
  178f4a:	8b 0c a9             	mov    (%rcx,%rbp,4),%ecx
  178f4d:	48 39 ce             	cmp    %rcx,%rsi
  178f50:	0f 86 ba 0a 00 00    	jbe    179a10 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2660>
  178f56:	4c 8b 40 78          	mov    0x78(%rax),%r8
  178f5a:	48 8b 90 88 00 00 00 	mov    0x88(%rax),%rdx
  178f61:	31 f6                	xor    %esi,%esi
  178f63:	48 39 ca             	cmp    %rcx,%rdx
  178f66:	40 0f 97 c6          	seta   %sil
  178f6a:	bf 00 00 00 00       	mov    $0x0,%edi
  178f6f:	48 0f 46 fa          	cmovbe %rdx,%rdi
  178f73:	48 29 f9             	sub    %rdi,%rcx
  178f76:	c1 e6 04             	shl    $0x4,%esi
  178f79:	4c 89 04 24          	mov    %r8,(%rsp)
  178f7d:	49 0f af c8          	imul   %r8,%rcx
  178f81:	48 c1 e1 03          	shl    $0x3,%rcx
  178f85:	48 03 8c 06 90 00 00 	add    0x90(%rsi,%rax,1),%rcx
  178f8c:	00 
  178f8d:	48 89 4c 24 48       	mov    %rcx,0x48(%rsp)
  178f92:	4c 3b 60 70          	cmp    0x70(%rax),%r12
  178f96:	73 1f                	jae    178fb7 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x1c07>
  178f98:	48 8b 40 68          	mov    0x68(%rax),%rax
  178f9c:	4c 89 e1             	mov    %r12,%rcx
  178f9f:	48 c1 e1 04          	shl    $0x4,%rcx
  178fa3:	48 39 2c 08          	cmp    %rbp,(%rax,%rcx,1)
  178fa7:	75 0e                	jne    178fb7 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x1c07>
  178fa9:	48 01 c8             	add    %rcx,%rax
  178fac:	48 8b 40 08          	mov    0x8(%rax),%rax
  178fb0:	48 89 04 24          	mov    %rax,(%rsp)
  178fb4:	49 ff c4             	inc    %r12
  178fb7:	4c 89 64 24 08       	mov    %r12,0x8(%rsp)
  178fbc:	48 8d 44 24 48       	lea    0x48(%rsp),%rax
  178fc1:	48 89 84 24 80 00 00 	mov    %rax,0x80(%rsp)
  178fc8:	00 
  178fc9:	48 8d 44 24 38       	lea    0x38(%rsp),%rax
  178fce:	48 89 84 24 88 00 00 	mov    %rax,0x88(%rsp)
  178fd5:	00 
  178fd6:	48 8d 44 24 58       	lea    0x58(%rsp),%rax
  178fdb:	48 89 84 24 90 00 00 	mov    %rax,0x90(%rsp)
  178fe2:	00 
  178fe3:	48 8d 44 24 18       	lea    0x18(%rsp),%rax
  178fe8:	48 89 84 24 98 00 00 	mov    %rax,0x98(%rsp)
  178fef:	00 
  178ff0:	48 8d 44 24 40       	lea    0x40(%rsp),%rax
  178ff5:	48 89 84 24 a0 00 00 	mov    %rax,0xa0(%rsp)
  178ffc:	00 
  178ffd:	48 8d 44 24 10       	lea    0x10(%rsp),%rax
  179002:	48 89 84 24 a8 00 00 	mov    %rax,0xa8(%rsp)
  179009:	00 
  17900a:	48 8d 44 24 68       	lea    0x68(%rsp),%rax
  17900f:	48 89 84 24 b0 00 00 	mov    %rax,0xb0(%rsp)
  179016:	00 
  179017:	4c 8b 24 24          	mov    (%rsp),%r12
  17901b:	49 c1 ec 02          	shr    $0x2,%r12
  17901f:	74 4f                	je     179070 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x1cc0>
  179021:	45 31 f6             	xor    %r14d,%r14d
  179024:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
  17902b:	00 00 00 00 00 
  179030:	48 89 df             	mov    %rbx,%rdi
  179033:	4c 89 f6             	mov    %r14,%rsi
  179036:	c5 f8 77             	vzeroupper
  179039:	e8 62 56 18 00       	call   2fe6a0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>::{closure#0}>
  17903e:	49 ff c6             	inc    %r14
  179041:	48 89 df             	mov    %rbx,%rdi
  179044:	4c 89 f6             	mov    %r14,%rsi
  179047:	e8 54 56 18 00       	call   2fe6a0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>::{closure#0}>
  17904c:	49 ff c6             	inc    %r14
  17904f:	48 89 df             	mov    %rbx,%rdi
  179052:	4c 89 f6             	mov    %r14,%rsi
  179055:	e8 46 56 18 00       	call   2fe6a0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>::{closure#0}>
  17905a:	49 ff c6             	inc    %r14
  17905d:	48 89 df             	mov    %rbx,%rdi
  179060:	4c 89 f6             	mov    %r14,%rsi
  179063:	e8 38 56 18 00       	call   2fe6a0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>::{closure#0}>
  179068:	49 ff c6             	inc    %r14
  17906b:	49 ff cc             	dec    %r12
  17906e:	75 c0                	jne    179030 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x1c80>
  179070:	48 8b 04 24          	mov    (%rsp),%rax
  179074:	49 89 c6             	mov    %rax,%r14
  179077:	49 83 e6 fc          	and    $0xfffffffffffffffc,%r14
  17907b:	49 39 c6             	cmp    %rax,%r14
  17907e:	4c 8b 64 24 08       	mov    0x8(%rsp),%r12
  179083:	0f 84 98 fe ff ff    	je     178f21 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x1b71>
  179089:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  179090:	48 89 df             	mov    %rbx,%rdi
  179093:	4c 89 f6             	mov    %r14,%rsi
  179096:	c5 f8 77             	vzeroupper
  179099:	e8 02 56 18 00       	call   2fe6a0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>::{closure#0}>
  17909e:	49 ff c6             	inc    %r14
  1790a1:	4c 3b 34 24          	cmp    (%rsp),%r14
  1790a5:	72 e9                	jb     179090 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x1ce0>
  1790a7:	e9 75 fe ff ff       	jmp    178f21 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x1b71>
  1790ac:	4c 89 7c 24 10       	mov    %r15,0x10(%rsp)
  1790b1:	48 89 74 24 38       	mov    %rsi,0x38(%rsp)
  1790b6:	48 8b 44 24 50       	mov    0x50(%rsp),%rax
  1790bb:	48 89 44 24 58       	mov    %rax,0x58(%rsp)
  1790c0:	48 8b 44 24 78       	mov    0x78(%rsp),%rax
  1790c5:	48 89 44 24 60       	mov    %rax,0x60(%rsp)
  1790ca:	48 89 7c 24 68       	mov    %rdi,0x68(%rsp)
  1790cf:	4c 89 6c 24 70       	mov    %r13,0x70(%rsp)
  1790d4:	49 8b af 80 00 00 00 	mov    0x80(%r15),%rbp
  1790db:	48 89 6c 24 18       	mov    %rbp,0x18(%rsp)
  1790e0:	49 8b 87 a8 00 00 00 	mov    0xa8(%r15),%rax
  1790e7:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
  1790ec:	48 39 c5             	cmp    %rax,%rbp
  1790ef:	0f 83 8c 05 00 00    	jae    179681 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x22d1>
  1790f5:	45 31 e4             	xor    %r12d,%r12d
  1790f8:	48 8d 05 91 e2 44 00 	lea    0x44e291(%rip),%rax        # 5c7390 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0xa8>
  1790ff:	48 89 84 24 b8 00 00 	mov    %rax,0xb8(%rsp)
  179106:	00 
  179107:	48 8d 9c 24 80 00 00 	lea    0x80(%rsp),%rbx
  17910e:	00 
  17910f:	eb 0e                	jmp    17911f <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x1d6f>
  179111:	48 ff c5             	inc    %rbp
  179114:	48 3b 6c 24 30       	cmp    0x30(%rsp),%rbp
  179119:	0f 84 5d 05 00 00    	je     17967c <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x22cc>
  17911f:	48 89 6c 24 40       	mov    %rbp,0x40(%rsp)
  179124:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
  179129:	48 8b 70 28          	mov    0x28(%rax),%rsi
  17912d:	48 39 f5             	cmp    %rsi,%rbp
  179130:	0f 83 99 09 00 00    	jae    179acf <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x271f>
  179136:	48 8b 48 20          	mov    0x20(%rax),%rcx
  17913a:	8b 0c a9             	mov    (%rcx,%rbp,4),%ecx
  17913d:	48 39 ce             	cmp    %rcx,%rsi
  179140:	0f 86 ca 08 00 00    	jbe    179a10 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2660>
  179146:	4c 8b 40 78          	mov    0x78(%rax),%r8
  17914a:	48 8b 90 88 00 00 00 	mov    0x88(%rax),%rdx
  179151:	31 f6                	xor    %esi,%esi
  179153:	48 39 ca             	cmp    %rcx,%rdx
  179156:	40 0f 97 c6          	seta   %sil
  17915a:	bf 00 00 00 00       	mov    $0x0,%edi
  17915f:	48 0f 46 fa          	cmovbe %rdx,%rdi
  179163:	48 29 f9             	sub    %rdi,%rcx
  179166:	c1 e6 04             	shl    $0x4,%esi
  179169:	4c 89 04 24          	mov    %r8,(%rsp)
  17916d:	49 0f af c8          	imul   %r8,%rcx
  179171:	48 c1 e1 03          	shl    $0x3,%rcx
  179175:	48 03 8c 06 90 00 00 	add    0x90(%rsi,%rax,1),%rcx
  17917c:	00 
  17917d:	48 89 4c 24 48       	mov    %rcx,0x48(%rsp)
  179182:	4c 3b 60 70          	cmp    0x70(%rax),%r12
  179186:	73 1f                	jae    1791a7 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x1df7>
  179188:	48 8b 40 68          	mov    0x68(%rax),%rax
  17918c:	4c 89 e1             	mov    %r12,%rcx
  17918f:	48 c1 e1 04          	shl    $0x4,%rcx
  179193:	48 39 2c 08          	cmp    %rbp,(%rax,%rcx,1)
  179197:	75 0e                	jne    1791a7 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x1df7>
  179199:	48 01 c8             	add    %rcx,%rax
  17919c:	48 8b 40 08          	mov    0x8(%rax),%rax
  1791a0:	48 89 04 24          	mov    %rax,(%rsp)
  1791a4:	49 ff c4             	inc    %r12
  1791a7:	4c 89 64 24 08       	mov    %r12,0x8(%rsp)
  1791ac:	48 8d 44 24 48       	lea    0x48(%rsp),%rax
  1791b1:	48 89 84 24 80 00 00 	mov    %rax,0x80(%rsp)
  1791b8:	00 
  1791b9:	48 8d 44 24 38       	lea    0x38(%rsp),%rax
  1791be:	48 89 84 24 88 00 00 	mov    %rax,0x88(%rsp)
  1791c5:	00 
  1791c6:	48 8d 44 24 58       	lea    0x58(%rsp),%rax
  1791cb:	48 89 84 24 90 00 00 	mov    %rax,0x90(%rsp)
  1791d2:	00 
  1791d3:	48 8d 44 24 18       	lea    0x18(%rsp),%rax
  1791d8:	48 89 84 24 98 00 00 	mov    %rax,0x98(%rsp)
  1791df:	00 
  1791e0:	48 8d 44 24 40       	lea    0x40(%rsp),%rax
  1791e5:	48 89 84 24 a0 00 00 	mov    %rax,0xa0(%rsp)
  1791ec:	00 
  1791ed:	48 8d 44 24 10       	lea    0x10(%rsp),%rax
  1791f2:	48 89 84 24 a8 00 00 	mov    %rax,0xa8(%rsp)
  1791f9:	00 
  1791fa:	48 8d 44 24 68       	lea    0x68(%rsp),%rax
  1791ff:	48 89 84 24 b0 00 00 	mov    %rax,0xb0(%rsp)
  179206:	00 
  179207:	4c 8b 24 24          	mov    (%rsp),%r12
  17920b:	49 c1 ec 02          	shr    $0x2,%r12
  17920f:	74 4f                	je     179260 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x1eb0>
  179211:	45 31 f6             	xor    %r14d,%r14d
  179214:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
  17921b:	00 00 00 00 00 
  179220:	48 89 df             	mov    %rbx,%rdi
  179223:	4c 89 f6             	mov    %r14,%rsi
  179226:	c5 f8 77             	vzeroupper
  179229:	e8 d2 55 18 00       	call   2fe800 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>::{closure#0}>
  17922e:	49 ff c6             	inc    %r14
  179231:	48 89 df             	mov    %rbx,%rdi
  179234:	4c 89 f6             	mov    %r14,%rsi
  179237:	e8 c4 55 18 00       	call   2fe800 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>::{closure#0}>
  17923c:	49 ff c6             	inc    %r14
  17923f:	48 89 df             	mov    %rbx,%rdi
  179242:	4c 89 f6             	mov    %r14,%rsi
  179245:	e8 b6 55 18 00       	call   2fe800 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>::{closure#0}>
  17924a:	49 ff c6             	inc    %r14
  17924d:	48 89 df             	mov    %rbx,%rdi
  179250:	4c 89 f6             	mov    %r14,%rsi
  179253:	e8 a8 55 18 00       	call   2fe800 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>::{closure#0}>
  179258:	49 ff c6             	inc    %r14
  17925b:	49 ff cc             	dec    %r12
  17925e:	75 c0                	jne    179220 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x1e70>
  179260:	48 8b 04 24          	mov    (%rsp),%rax
  179264:	49 89 c6             	mov    %rax,%r14
  179267:	49 83 e6 fc          	and    $0xfffffffffffffffc,%r14
  17926b:	49 39 c6             	cmp    %rax,%r14
  17926e:	4c 8b 64 24 08       	mov    0x8(%rsp),%r12
  179273:	0f 84 98 fe ff ff    	je     179111 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x1d61>
  179279:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  179280:	48 89 df             	mov    %rbx,%rdi
  179283:	4c 89 f6             	mov    %r14,%rsi
  179286:	c5 f8 77             	vzeroupper
  179289:	e8 72 55 18 00       	call   2fe800 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>::{closure#0}>
  17928e:	49 ff c6             	inc    %r14
  179291:	4c 3b 34 24          	cmp    (%rsp),%r14
  179295:	72 e9                	jb     179280 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x1ed0>
  179297:	e9 75 fe ff ff       	jmp    179111 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x1d61>
  17929c:	4c 89 7c 24 10       	mov    %r15,0x10(%rsp)
  1792a1:	48 89 74 24 38       	mov    %rsi,0x38(%rsp)
  1792a6:	48 8b 44 24 50       	mov    0x50(%rsp),%rax
  1792ab:	48 89 44 24 58       	mov    %rax,0x58(%rsp)
  1792b0:	48 8b 44 24 78       	mov    0x78(%rsp),%rax
  1792b5:	48 89 44 24 60       	mov    %rax,0x60(%rsp)
  1792ba:	48 89 7c 24 68       	mov    %rdi,0x68(%rsp)
  1792bf:	4c 89 6c 24 70       	mov    %r13,0x70(%rsp)
  1792c4:	49 8b af 80 00 00 00 	mov    0x80(%r15),%rbp
  1792cb:	48 89 6c 24 18       	mov    %rbp,0x18(%rsp)
  1792d0:	49 8b 87 a8 00 00 00 	mov    0xa8(%r15),%rax
  1792d7:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
  1792dc:	48 39 c5             	cmp    %rax,%rbp
  1792df:	0f 83 9c 03 00 00    	jae    179681 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x22d1>
  1792e5:	45 31 e4             	xor    %r12d,%r12d
  1792e8:	48 8d 05 a1 e0 44 00 	lea    0x44e0a1(%rip),%rax        # 5c7390 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0xa8>
  1792ef:	48 89 84 24 b8 00 00 	mov    %rax,0xb8(%rsp)
  1792f6:	00 
  1792f7:	48 8d 9c 24 80 00 00 	lea    0x80(%rsp),%rbx
  1792fe:	00 
  1792ff:	eb 0e                	jmp    17930f <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x1f5f>
  179301:	48 ff c5             	inc    %rbp
  179304:	48 3b 6c 24 30       	cmp    0x30(%rsp),%rbp
  179309:	0f 84 6d 03 00 00    	je     17967c <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x22cc>
  17930f:	48 89 6c 24 40       	mov    %rbp,0x40(%rsp)
  179314:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
  179319:	48 8b 70 28          	mov    0x28(%rax),%rsi
  17931d:	48 39 f5             	cmp    %rsi,%rbp
  179320:	0f 83 a9 07 00 00    	jae    179acf <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x271f>
  179326:	48 8b 48 20          	mov    0x20(%rax),%rcx
  17932a:	8b 0c a9             	mov    (%rcx,%rbp,4),%ecx
  17932d:	48 39 ce             	cmp    %rcx,%rsi
  179330:	0f 86 da 06 00 00    	jbe    179a10 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2660>
  179336:	4c 8b 40 78          	mov    0x78(%rax),%r8
  17933a:	48 8b 90 88 00 00 00 	mov    0x88(%rax),%rdx
  179341:	31 f6                	xor    %esi,%esi
  179343:	48 39 ca             	cmp    %rcx,%rdx
  179346:	40 0f 97 c6          	seta   %sil
  17934a:	bf 00 00 00 00       	mov    $0x0,%edi
  17934f:	48 0f 46 fa          	cmovbe %rdx,%rdi
  179353:	48 29 f9             	sub    %rdi,%rcx
  179356:	c1 e6 04             	shl    $0x4,%esi
  179359:	4c 89 04 24          	mov    %r8,(%rsp)
  17935d:	49 0f af c8          	imul   %r8,%rcx
  179361:	48 c1 e1 03          	shl    $0x3,%rcx
  179365:	48 03 8c 06 90 00 00 	add    0x90(%rsi,%rax,1),%rcx
  17936c:	00 
  17936d:	48 89 4c 24 48       	mov    %rcx,0x48(%rsp)
  179372:	4c 3b 60 70          	cmp    0x70(%rax),%r12
  179376:	73 1f                	jae    179397 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x1fe7>
  179378:	48 8b 40 68          	mov    0x68(%rax),%rax
  17937c:	4c 89 e1             	mov    %r12,%rcx
  17937f:	48 c1 e1 04          	shl    $0x4,%rcx
  179383:	48 39 2c 08          	cmp    %rbp,(%rax,%rcx,1)
  179387:	75 0e                	jne    179397 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x1fe7>
  179389:	48 01 c8             	add    %rcx,%rax
  17938c:	48 8b 40 08          	mov    0x8(%rax),%rax
  179390:	48 89 04 24          	mov    %rax,(%rsp)
  179394:	49 ff c4             	inc    %r12
  179397:	4c 89 64 24 08       	mov    %r12,0x8(%rsp)
  17939c:	48 8d 44 24 48       	lea    0x48(%rsp),%rax
  1793a1:	48 89 84 24 80 00 00 	mov    %rax,0x80(%rsp)
  1793a8:	00 
  1793a9:	48 8d 44 24 38       	lea    0x38(%rsp),%rax
  1793ae:	48 89 84 24 88 00 00 	mov    %rax,0x88(%rsp)
  1793b5:	00 
  1793b6:	48 8d 44 24 58       	lea    0x58(%rsp),%rax
  1793bb:	48 89 84 24 90 00 00 	mov    %rax,0x90(%rsp)
  1793c2:	00 
  1793c3:	48 8d 44 24 18       	lea    0x18(%rsp),%rax
  1793c8:	48 89 84 24 98 00 00 	mov    %rax,0x98(%rsp)
  1793cf:	00 
  1793d0:	48 8d 44 24 40       	lea    0x40(%rsp),%rax
  1793d5:	48 89 84 24 a0 00 00 	mov    %rax,0xa0(%rsp)
  1793dc:	00 
  1793dd:	48 8d 44 24 10       	lea    0x10(%rsp),%rax
  1793e2:	48 89 84 24 a8 00 00 	mov    %rax,0xa8(%rsp)
  1793e9:	00 
  1793ea:	48 8d 44 24 68       	lea    0x68(%rsp),%rax
  1793ef:	48 89 84 24 b0 00 00 	mov    %rax,0xb0(%rsp)
  1793f6:	00 
  1793f7:	4c 8b 24 24          	mov    (%rsp),%r12
  1793fb:	49 c1 ec 02          	shr    $0x2,%r12
  1793ff:	74 4f                	je     179450 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x20a0>
  179401:	45 31 f6             	xor    %r14d,%r14d
  179404:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
  17940b:	00 00 00 00 00 
  179410:	48 89 df             	mov    %rbx,%rdi
  179413:	4c 89 f6             	mov    %r14,%rsi
  179416:	c5 f8 77             	vzeroupper
  179419:	e8 e2 53 18 00       	call   2fe800 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>::{closure#0}>
  17941e:	49 ff c6             	inc    %r14
  179421:	48 89 df             	mov    %rbx,%rdi
  179424:	4c 89 f6             	mov    %r14,%rsi
  179427:	e8 d4 53 18 00       	call   2fe800 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>::{closure#0}>
  17942c:	49 ff c6             	inc    %r14
  17942f:	48 89 df             	mov    %rbx,%rdi
  179432:	4c 89 f6             	mov    %r14,%rsi
  179435:	e8 c6 53 18 00       	call   2fe800 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>::{closure#0}>
  17943a:	49 ff c6             	inc    %r14
  17943d:	48 89 df             	mov    %rbx,%rdi
  179440:	4c 89 f6             	mov    %r14,%rsi
  179443:	e8 b8 53 18 00       	call   2fe800 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>::{closure#0}>
  179448:	49 ff c6             	inc    %r14
  17944b:	49 ff cc             	dec    %r12
  17944e:	75 c0                	jne    179410 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2060>
  179450:	48 8b 04 24          	mov    (%rsp),%rax
  179454:	49 89 c6             	mov    %rax,%r14
  179457:	49 83 e6 fc          	and    $0xfffffffffffffffc,%r14
  17945b:	49 39 c6             	cmp    %rax,%r14
  17945e:	4c 8b 64 24 08       	mov    0x8(%rsp),%r12
  179463:	0f 84 98 fe ff ff    	je     179301 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x1f51>
  179469:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  179470:	48 89 df             	mov    %rbx,%rdi
  179473:	4c 89 f6             	mov    %r14,%rsi
  179476:	c5 f8 77             	vzeroupper
  179479:	e8 82 53 18 00       	call   2fe800 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>::{closure#0}>
  17947e:	49 ff c6             	inc    %r14
  179481:	4c 3b 34 24          	cmp    (%rsp),%r14
  179485:	72 e9                	jb     179470 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x20c0>
  179487:	e9 75 fe ff ff       	jmp    179301 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x1f51>
  17948c:	4c 89 7c 24 10       	mov    %r15,0x10(%rsp)
  179491:	48 89 74 24 38       	mov    %rsi,0x38(%rsp)
  179496:	48 8b 44 24 50       	mov    0x50(%rsp),%rax
  17949b:	48 89 44 24 58       	mov    %rax,0x58(%rsp)
  1794a0:	48 8b 44 24 78       	mov    0x78(%rsp),%rax
  1794a5:	48 89 44 24 60       	mov    %rax,0x60(%rsp)
  1794aa:	48 89 7c 24 68       	mov    %rdi,0x68(%rsp)
  1794af:	4c 89 6c 24 70       	mov    %r13,0x70(%rsp)
  1794b4:	49 8b af 80 00 00 00 	mov    0x80(%r15),%rbp
  1794bb:	48 89 6c 24 18       	mov    %rbp,0x18(%rsp)
  1794c0:	49 8b 87 a8 00 00 00 	mov    0xa8(%r15),%rax
  1794c7:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
  1794cc:	48 39 c5             	cmp    %rax,%rbp
  1794cf:	0f 83 ac 01 00 00    	jae    179681 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x22d1>
  1794d5:	45 31 e4             	xor    %r12d,%r12d
  1794d8:	48 8d 05 b1 de 44 00 	lea    0x44deb1(%rip),%rax        # 5c7390 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0xa8>
  1794df:	48 89 84 24 b8 00 00 	mov    %rax,0xb8(%rsp)
  1794e6:	00 
  1794e7:	48 8d 9c 24 80 00 00 	lea    0x80(%rsp),%rbx
  1794ee:	00 
  1794ef:	eb 0e                	jmp    1794ff <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x214f>
  1794f1:	48 ff c5             	inc    %rbp
  1794f4:	48 3b 6c 24 30       	cmp    0x30(%rsp),%rbp
  1794f9:	0f 84 7d 01 00 00    	je     17967c <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x22cc>
  1794ff:	48 89 6c 24 40       	mov    %rbp,0x40(%rsp)
  179504:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
  179509:	48 8b 70 28          	mov    0x28(%rax),%rsi
  17950d:	48 39 f5             	cmp    %rsi,%rbp
  179510:	0f 83 b9 05 00 00    	jae    179acf <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x271f>
  179516:	48 8b 48 20          	mov    0x20(%rax),%rcx
  17951a:	8b 0c a9             	mov    (%rcx,%rbp,4),%ecx
  17951d:	48 39 ce             	cmp    %rcx,%rsi
  179520:	0f 86 ea 04 00 00    	jbe    179a10 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2660>
  179526:	4c 8b 40 78          	mov    0x78(%rax),%r8
  17952a:	48 8b 90 88 00 00 00 	mov    0x88(%rax),%rdx
  179531:	31 f6                	xor    %esi,%esi
  179533:	48 39 ca             	cmp    %rcx,%rdx
  179536:	40 0f 97 c6          	seta   %sil
  17953a:	bf 00 00 00 00       	mov    $0x0,%edi
  17953f:	48 0f 46 fa          	cmovbe %rdx,%rdi
  179543:	48 29 f9             	sub    %rdi,%rcx
  179546:	c1 e6 04             	shl    $0x4,%esi
  179549:	4c 89 04 24          	mov    %r8,(%rsp)
  17954d:	49 0f af c8          	imul   %r8,%rcx
  179551:	48 c1 e1 03          	shl    $0x3,%rcx
  179555:	48 03 8c 06 90 00 00 	add    0x90(%rsi,%rax,1),%rcx
  17955c:	00 
  17955d:	48 89 4c 24 48       	mov    %rcx,0x48(%rsp)
  179562:	4c 3b 60 70          	cmp    0x70(%rax),%r12
  179566:	73 1f                	jae    179587 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x21d7>
  179568:	48 8b 40 68          	mov    0x68(%rax),%rax
  17956c:	4c 89 e1             	mov    %r12,%rcx
  17956f:	48 c1 e1 04          	shl    $0x4,%rcx
  179573:	48 39 2c 08          	cmp    %rbp,(%rax,%rcx,1)
  179577:	75 0e                	jne    179587 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x21d7>
  179579:	48 01 c8             	add    %rcx,%rax
  17957c:	48 8b 40 08          	mov    0x8(%rax),%rax
  179580:	48 89 04 24          	mov    %rax,(%rsp)
  179584:	49 ff c4             	inc    %r12
  179587:	4c 89 64 24 08       	mov    %r12,0x8(%rsp)
  17958c:	48 8d 44 24 48       	lea    0x48(%rsp),%rax
  179591:	48 89 84 24 80 00 00 	mov    %rax,0x80(%rsp)
  179598:	00 
  179599:	48 8d 44 24 38       	lea    0x38(%rsp),%rax
  17959e:	48 89 84 24 88 00 00 	mov    %rax,0x88(%rsp)
  1795a5:	00 
  1795a6:	48 8d 44 24 58       	lea    0x58(%rsp),%rax
  1795ab:	48 89 84 24 90 00 00 	mov    %rax,0x90(%rsp)
  1795b2:	00 
  1795b3:	48 8d 44 24 18       	lea    0x18(%rsp),%rax
  1795b8:	48 89 84 24 98 00 00 	mov    %rax,0x98(%rsp)
  1795bf:	00 
  1795c0:	48 8d 44 24 40       	lea    0x40(%rsp),%rax
  1795c5:	48 89 84 24 a0 00 00 	mov    %rax,0xa0(%rsp)
  1795cc:	00 
  1795cd:	48 8d 44 24 10       	lea    0x10(%rsp),%rax
  1795d2:	48 89 84 24 a8 00 00 	mov    %rax,0xa8(%rsp)
  1795d9:	00 
  1795da:	48 8d 44 24 68       	lea    0x68(%rsp),%rax
  1795df:	48 89 84 24 b0 00 00 	mov    %rax,0xb0(%rsp)
  1795e6:	00 
  1795e7:	4c 8b 24 24          	mov    (%rsp),%r12
  1795eb:	49 c1 ec 02          	shr    $0x2,%r12
  1795ef:	74 4f                	je     179640 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2290>
  1795f1:	45 31 f6             	xor    %r14d,%r14d
  1795f4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
  1795fb:	00 00 00 00 00 
  179600:	48 89 df             	mov    %rbx,%rdi
  179603:	4c 89 f6             	mov    %r14,%rsi
  179606:	c5 f8 77             	vzeroupper
  179609:	e8 32 4f 18 00       	call   2fe540 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>::{closure#0}>
  17960e:	49 ff c6             	inc    %r14
  179611:	48 89 df             	mov    %rbx,%rdi
  179614:	4c 89 f6             	mov    %r14,%rsi
  179617:	e8 24 4f 18 00       	call   2fe540 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>::{closure#0}>
  17961c:	49 ff c6             	inc    %r14
  17961f:	48 89 df             	mov    %rbx,%rdi
  179622:	4c 89 f6             	mov    %r14,%rsi
  179625:	e8 16 4f 18 00       	call   2fe540 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>::{closure#0}>
  17962a:	49 ff c6             	inc    %r14
  17962d:	48 89 df             	mov    %rbx,%rdi
  179630:	4c 89 f6             	mov    %r14,%rsi
  179633:	e8 08 4f 18 00       	call   2fe540 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>::{closure#0}>
  179638:	49 ff c6             	inc    %r14
  17963b:	49 ff cc             	dec    %r12
  17963e:	75 c0                	jne    179600 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2250>
  179640:	48 8b 04 24          	mov    (%rsp),%rax
  179644:	49 89 c6             	mov    %rax,%r14
  179647:	49 83 e6 fc          	and    $0xfffffffffffffffc,%r14
  17964b:	49 39 c6             	cmp    %rax,%r14
  17964e:	4c 8b 64 24 08       	mov    0x8(%rsp),%r12
  179653:	0f 84 98 fe ff ff    	je     1794f1 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2141>
  179659:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  179660:	48 89 df             	mov    %rbx,%rdi
  179663:	4c 89 f6             	mov    %r14,%rsi
  179666:	c5 f8 77             	vzeroupper
  179669:	e8 d2 4e 18 00       	call   2fe540 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>::{closure#0}>
  17966e:	49 ff c6             	inc    %r14
  179671:	4c 3b 34 24          	cmp    (%rsp),%r14
  179675:	72 e9                	jb     179660 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x22b0>
  179677:	e9 75 fe ff ff       	jmp    1794f1 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2141>
  17967c:	48 8b 6c 24 18       	mov    0x18(%rsp),%rbp
  179681:	49 89 af a8 00 00 00 	mov    %rbp,0xa8(%r15)
  179688:	49 8b 97 80 00 00 00 	mov    0x80(%r15),%rdx
  17968f:	48 8d bc 24 80 00 00 	lea    0x80(%rsp),%rdi
  179696:	00 
  179697:	48 89 d6             	mov    %rdx,%rsi
  17969a:	c5 f8 77             	vzeroupper
  17969d:	e8 2e 65 f3 ff       	call   afbd0 <alloc::vec::from_elem::<usize>>
  1796a2:	49 8b 87 80 00 00 00 	mov    0x80(%r15),%rax
  1796a9:	48 83 f8 02          	cmp    $0x2,%rax
  1796ad:	4c 8b 64 24 20       	mov    0x20(%rsp),%r12
  1796b2:	72 7f                	jb     179733 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2383>
  1796b4:	48 8b b4 24 88 00 00 	mov    0x88(%rsp),%rsi
  1796bb:	00 
  1796bc:	48 8b 8c 24 90 00 00 	mov    0x90(%rsp),%rcx
  1796c3:	00 
  1796c4:	48 83 f9 01          	cmp    $0x1,%rcx
  1796c8:	49 89 c8             	mov    %rcx,%r8
  1796cb:	49 83 d0 00          	adc    $0x0,%r8
  1796cf:	4d 8d 50 ff          	lea    -0x1(%r8),%r10
  1796d3:	48 ff c8             	dec    %rax
  1796d6:	41 b9 01 00 00 00    	mov    $0x1,%r9d
  1796dc:	31 ff                	xor    %edi,%edi
  1796de:	4c 8d 1d fb dd 44 00 	lea    0x44ddfb(%rip),%r11        # 5c74e0 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0x1f8>
  1796e5:	48 8d 15 0c de 44 00 	lea    0x44de0c(%rip),%rdx        # 5c74f8 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0x210>
  1796ec:	48 8d 1d 1d de 44 00 	lea    0x44de1d(%rip),%rbx        # 5c7510 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0x228>
  1796f3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  1796fa:	84 00 00 00 00 00 
  179700:	48 39 f9             	cmp    %rdi,%rcx
  179703:	0f 84 1e 04 00 00    	je     179b27 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2777>
  179709:	49 39 fd             	cmp    %rdi,%r13
  17970c:	0f 84 1d 04 00 00    	je     179b2f <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x277f>
  179712:	49 39 fa             	cmp    %rdi,%r10
  179715:	0f 84 01 04 00 00    	je     179b1c <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x276c>
  17971b:	4c 8b 34 fe          	mov    (%rsi,%rdi,8),%r14
  17971f:	4d 03 34 fc          	add    (%r12,%rdi,8),%r14
  179723:	4c 89 74 fe 08       	mov    %r14,0x8(%rsi,%rdi,8)
  179728:	48 ff c7             	inc    %rdi
  17972b:	49 ff c1             	inc    %r9
  17972e:	48 39 f8             	cmp    %rdi,%rax
  179731:	75 cd                	jne    179700 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2350>
  179733:	49 8b 87 a8 00 00 00 	mov    0xa8(%r15),%rax
  17973a:	48 85 c0             	test   %rax,%rax
  17973d:	0f 84 52 01 00 00    	je     179895 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x24e5>
  179743:	48 8b b4 24 88 00 00 	mov    0x88(%rsp),%rsi
  17974a:	00 
  17974b:	48 8b 8c 24 90 00 00 	mov    0x90(%rsp),%rcx
  179752:	00 
  179753:	31 ff                	xor    %edi,%edi
  179755:	48 8d 15 dc dc 44 00 	lea    0x44dcdc(%rip),%rdx        # 5c7438 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0x150>
  17975c:	48 8d 1d 4d dd 44 00 	lea    0x44dd4d(%rip),%rbx        # 5c74b0 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0x1c8>
  179763:	4c 8d 35 5e dd 44 00 	lea    0x44dd5e(%rip),%r14        # 5c74c8 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0x1e0>
  17976a:	eb 36                	jmp    1797a2 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x23f2>
  17976c:	0f 1f 40 00          	nopl   0x0(%rax)
  179770:	4c 03 64 24 50       	add    0x50(%rsp),%r12
  179775:	4d 8b 57 68          	mov    0x68(%r15),%r10
  179779:	4d 8b 1c 24          	mov    (%r12),%r11
  17977d:	4d 29 c3             	sub    %r8,%r11
  179780:	49 c1 fb 03          	sar    $0x3,%r11
  179784:	41 c1 e1 04          	shl    $0x4,%r9d
  179788:	4b 89 2c 0a          	mov    %rbp,(%r10,%r9,1)
  17978c:	4f 89 5c 0a 08       	mov    %r11,0x8(%r10,%r9,1)
  179791:	48 ff c7             	inc    %rdi
  179794:	48 39 f8             	cmp    %rdi,%rax
  179797:	4c 8b 64 24 20       	mov    0x20(%rsp),%r12
  17979c:	0f 84 ea 00 00 00    	je     17988c <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x24dc>
  1797a2:	4d 8b 6f 58          	mov    0x58(%r15),%r13
  1797a6:	4c 39 ef             	cmp    %r13,%rdi
  1797a9:	0f 83 86 03 00 00    	jae    179b35 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2785>
  1797af:	4d 8b 47 50          	mov    0x50(%r15),%r8
  1797b3:	45 0f b6 0c 38       	movzbl (%r8,%rdi,1),%r9d
  1797b8:	4c 39 c9             	cmp    %r9,%rcx
  1797bb:	0f 86 42 03 00 00    	jbe    179b03 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2753>
  1797c1:	4a 8b 2c ce          	mov    (%rsi,%r9,8),%rbp
  1797c5:	4c 8d 45 01          	lea    0x1(%rbp),%r8
  1797c9:	4e 89 04 ce          	mov    %r8,(%rsi,%r9,8)
  1797cd:	4d 8b 6f 28          	mov    0x28(%r15),%r13
  1797d1:	4c 39 ef             	cmp    %r13,%rdi
  1797d4:	0f 83 20 03 00 00    	jae    179afa <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x274a>
  1797da:	4d 8b 6f 40          	mov    0x40(%r15),%r13
  1797de:	4c 39 ed             	cmp    %r13,%rbp
  1797e1:	0f 83 07 03 00 00    	jae    179aee <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x273e>
  1797e7:	4d 8b 47 20          	mov    0x20(%r15),%r8
  1797eb:	4d 8b 57 38          	mov    0x38(%r15),%r10
  1797ef:	45 8b 04 b8          	mov    (%r8,%rdi,4),%r8d
  1797f3:	45 89 04 aa          	mov    %r8d,(%r10,%rbp,4)
  1797f7:	4d 8b 6f 28          	mov    0x28(%r15),%r13
  1797fb:	4c 39 ef             	cmp    %r13,%rdi
  1797fe:	0f 83 e1 02 00 00    	jae    179ae5 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2735>
  179804:	4d 8b 47 20          	mov    0x20(%r15),%r8
  179808:	45 8b 04 b8          	mov    (%r8,%rdi,4),%r8d
  17980c:	4d 39 c5             	cmp    %r8,%r13
  17980f:	0f 86 1c 02 00 00    	jbe    179a31 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2681>
  179815:	4d 8b 9f 88 00 00 00 	mov    0x88(%r15),%r11
  17981c:	45 31 ed             	xor    %r13d,%r13d
  17981f:	4d 39 c3             	cmp    %r8,%r11
  179822:	41 0f 97 c4          	seta   %r12b
  179826:	41 ba 00 00 00 00    	mov    $0x0,%r10d
  17982c:	4d 0f 46 d3          	cmovbe %r11,%r10
  179830:	4c 39 4c 24 78       	cmp    %r9,0x78(%rsp)
  179835:	0f 86 d7 02 00 00    	jbe    179b12 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2762>
  17983b:	4d 8b 5f 78          	mov    0x78(%r15),%r11
  17983f:	4d 29 d0             	sub    %r10,%r8
  179842:	45 88 e5             	mov    %r12b,%r13b
  179845:	41 c1 e5 04          	shl    $0x4,%r13d
  179849:	4d 0f af c3          	imul   %r11,%r8
  17984d:	49 c1 e0 03          	shl    $0x3,%r8
  179851:	4f 03 84 3d 90 00 00 	add    0x90(%r13,%r15,1),%r8
  179858:	00 
  179859:	4f 8d 14 d8          	lea    (%r8,%r11,8),%r10
  17985d:	45 89 cc             	mov    %r9d,%r12d
  179860:	41 c1 e4 04          	shl    $0x4,%r12d
  179864:	4c 8b 5c 24 50       	mov    0x50(%rsp),%r11
  179869:	4f 3b 54 23 08       	cmp    0x8(%r11,%r12,1),%r10
  17986e:	0f 85 1d ff ff ff    	jne    179791 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x23e1>
  179874:	4d 8b 6f 70          	mov    0x70(%r15),%r13
  179878:	4d 39 cd             	cmp    %r9,%r13
  17987b:	0f 87 ef fe ff ff    	ja     179770 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x23c0>
  179881:	4c 89 cf             	mov    %r9,%rdi
  179884:	4c 89 f2             	mov    %r14,%rdx
  179887:	e9 a9 02 00 00       	jmp    179b35 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2785>
  17988c:	4d 8b 87 a8 00 00 00 	mov    0xa8(%r15),%r8
  179893:	eb 03                	jmp    179898 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x24e8>
  179895:	45 31 c0             	xor    %r8d,%r8d
  179898:	49 8b 77 28          	mov    0x28(%r15),%rsi
  17989c:	49 8b 97 80 00 00 00 	mov    0x80(%r15),%rdx
  1798a3:	4a 8d 3c 02          	lea    (%rdx,%r8,1),%rdi
  1798a7:	48 39 f7             	cmp    %rsi,%rdi
  1798aa:	0f 87 ae 01 00 00    	ja     179a5e <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x26ae>
  1798b0:	49 8b 47 40          	mov    0x40(%r15),%rax
  1798b4:	48 39 c2             	cmp    %rax,%rdx
  1798b7:	0f 87 bf 01 00 00    	ja     179a7c <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x26cc>
  1798bd:	4c 39 c7             	cmp    %r8,%rdi
  1798c0:	0f 82 89 01 00 00    	jb     179a4f <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x269f>
  1798c6:	49 8b 7f 38          	mov    0x38(%r15),%rdi
  1798ca:	49 c1 e0 02          	shl    $0x2,%r8
  1798ce:	4d 03 47 20          	add    0x20(%r15),%r8
  1798d2:	48 c1 e2 02          	shl    $0x2,%rdx
  1798d6:	4c 89 c6             	mov    %r8,%rsi
  1798d9:	ff 15 c1 8f 45 00    	call   *0x458fc1(%rip)        # 5d28a0 <memcpy@GLIBC_2.14>
  1798df:	49 8b 57 40          	mov    0x40(%r15),%rdx
  1798e3:	4d 8b 87 80 00 00 00 	mov    0x80(%r15),%r8
  1798ea:	4d 03 87 a8 00 00 00 	add    0xa8(%r15),%r8
  1798f1:	48 89 d1             	mov    %rdx,%rcx
  1798f4:	4c 29 c1             	sub    %r8,%rcx
  1798f7:	0f 82 8b 01 00 00    	jb     179a88 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x26d8>
  1798fd:	49 8b 47 28          	mov    0x28(%r15),%rax
  179901:	48 89 c6             	mov    %rax,%rsi
  179904:	4c 29 c6             	sub    %r8,%rsi
  179907:	0f 82 87 01 00 00    	jb     179a94 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x26e4>
  17990d:	48 39 c2             	cmp    %rax,%rdx
  179910:	0f 85 9c 01 00 00    	jne    179ab2 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2702>
  179916:	49 c1 e0 02          	shl    $0x2,%r8
  17991a:	49 8b 77 20          	mov    0x20(%r15),%rsi
  17991e:	4c 01 c6             	add    %r8,%rsi
  179921:	4d 03 47 38          	add    0x38(%r15),%r8
  179925:	48 c1 e1 02          	shl    $0x2,%rcx
  179929:	4c 89 c7             	mov    %r8,%rdi
  17992c:	48 89 ca             	mov    %rcx,%rdx
  17992f:	ff 15 6b 8f 45 00    	call   *0x458f6b(%rip)        # 5d28a0 <memcpy@GLIBC_2.14>
  179935:	49 8b 87 80 00 00 00 	mov    0x80(%r15),%rax
  17993c:	49 01 87 a8 00 00 00 	add    %rax,0xa8(%r15)
  179943:	c5 fc 28 05 95 6b e9 	vmovaps -0x16946b(%rip),%ymm0        # 104e0 <__abi_tag+0x101e4>
  17994a:	ff 
  17994b:	62 d2 fd 48 16 87 18 	vpermpd 0x18(%r15),%zmm0,%zmm0
  179952:	00 00 00 
  179955:	c4 c1 78 10 4f 20    	vmovups 0x20(%r15),%xmm1
  17995b:	c4 c1 7c 11 47 18    	vmovups %ymm0,0x18(%r15)
  179961:	c4 c1 78 11 4f 38    	vmovups %xmm1,0x38(%r15)
  179967:	48 8b 84 24 80 00 00 	mov    0x80(%rsp),%rax
  17996e:	00 
  17996f:	48 85 c0             	test   %rax,%rax
  179972:	48 8b 5c 24 28       	mov    0x28(%rsp),%rbx
  179977:	4c 8b b4 24 c0 00 00 	mov    0xc0(%rsp),%r14
  17997e:	00 
  17997f:	74 28                	je     1799a9 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x25f9>
  179981:	48 8b bc 24 88 00 00 	mov    0x88(%rsp),%rdi
  179988:	00 
  179989:	0f b6 0d 58 b2 45 00 	movzbl 0x45b258(%rip),%ecx        # 5d4be8 <frontier_experiment::TRACK>
  179990:	84 c9                	test   %cl,%cl
  179992:	74 0c                	je     1799a0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x25f0>
  179994:	48 c1 e0 03          	shl    $0x3,%rax
  179998:	f0 48 29 05 38 b2 45 	lock sub %rax,0x45b238(%rip)        # 5d4bd8 <frontier_experiment::LIVE>
  17999f:	00 
  1799a0:	c5 f8 77             	vzeroupper
  1799a3:	ff 15 ff 8e 45 00    	call   *0x458eff(%rip)        # 5d28a8 <free@GLIBC_2.2.5>
  1799a9:	4d 85 f6             	test   %r14,%r14
  1799ac:	74 23                	je     1799d1 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2621>
  1799ae:	0f b6 05 33 b2 45 00 	movzbl 0x45b233(%rip),%eax        # 5d4be8 <frontier_experiment::TRACK>
  1799b5:	84 c0                	test   %al,%al
  1799b7:	74 0c                	je     1799c5 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2615>
  1799b9:	49 c1 e6 03          	shl    $0x3,%r14
  1799bd:	f0 4c 29 35 13 b2 45 	lock sub %r14,0x45b213(%rip)        # 5d4bd8 <frontier_experiment::LIVE>
  1799c4:	00 
  1799c5:	4c 89 e7             	mov    %r12,%rdi
  1799c8:	c5 f8 77             	vzeroupper
  1799cb:	ff 15 d7 8e 45 00    	call   *0x458ed7(%rip)        # 5d28a8 <free@GLIBC_2.2.5>
  1799d1:	48 85 db             	test   %rbx,%rbx
  1799d4:	74 25                	je     1799fb <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x264b>
  1799d6:	0f b6 05 0b b2 45 00 	movzbl 0x45b20b(%rip),%eax        # 5d4be8 <frontier_experiment::TRACK>
  1799dd:	84 c0                	test   %al,%al
  1799df:	74 0c                	je     1799ed <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x263d>
  1799e1:	48 c1 e3 04          	shl    $0x4,%rbx
  1799e5:	f0 48 29 1d eb b1 45 	lock sub %rbx,0x45b1eb(%rip)        # 5d4bd8 <frontier_experiment::LIVE>
  1799ec:	00 
  1799ed:	48 8b 7c 24 50       	mov    0x50(%rsp),%rdi
  1799f2:	c5 f8 77             	vzeroupper
  1799f5:	ff 15 ad 8e 45 00    	call   *0x458ead(%rip)        # 5d28a8 <free@GLIBC_2.2.5>
  1799fb:	48 81 c4 c8 00 00 00 	add    $0xc8,%rsp
  179a02:	5b                   	pop    %rbx
  179a03:	41 5c                	pop    %r12
  179a05:	41 5d                	pop    %r13
  179a07:	41 5e                	pop    %r14
  179a09:	41 5f                	pop    %r15
  179a0b:	5d                   	pop    %rbp
  179a0c:	c5 f8 77             	vzeroupper
  179a0f:	c3                   	ret
  179a10:	48 8d 3d 1c c7 e9 ff 	lea    -0x1638e4(%rip),%rdi        # 16133 <anon.8f17df2f0ddc4723825c0f55871536dc.0.llvm.6863592281246770637+0xf3>
  179a17:	48 8d 15 3a dc 44 00 	lea    0x44dc3a(%rip),%rdx        # 5c7658 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0x370>
  179a1e:	be 2c 00 00 00       	mov    $0x2c,%esi
  179a23:	c5 f8 77             	vzeroupper
  179a26:	ff 15 84 8e 45 00    	call   *0x458e84(%rip)        # 5d28b0 <_DYNAMIC+0x290>
  179a2c:	e9 2f 01 00 00       	jmp    179b60 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x27b0>
  179a31:	48 8d 3d fb c6 e9 ff 	lea    -0x163905(%rip),%rdi        # 16133 <anon.8f17df2f0ddc4723825c0f55871536dc.0.llvm.6863592281246770637+0xf3>
  179a38:	48 8d 15 19 dc 44 00 	lea    0x44dc19(%rip),%rdx        # 5c7658 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0x370>
  179a3f:	be 2c 00 00 00       	mov    $0x2c,%esi
  179a44:	ff 15 66 8e 45 00    	call   *0x458e66(%rip)        # 5d28b0 <_DYNAMIC+0x290>
  179a4a:	e9 11 01 00 00       	jmp    179b60 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x27b0>
  179a4f:	48 8d 0d 82 d9 44 00 	lea    0x44d982(%rip),%rcx        # 5c73d8 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0xf0>
  179a56:	48 89 fa             	mov    %rdi,%rdx
  179a59:	48 89 f0             	mov    %rsi,%rax
  179a5c:	eb 40                	jmp    179a9e <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x26ee>
  179a5e:	48 8d 3d 20 c6 e9 ff 	lea    -0x1639e0(%rip),%rdi        # 16085 <anon.8f17df2f0ddc4723825c0f55871536dc.0.llvm.6863592281246770637+0x45>
  179a65:	48 8d 15 3c d9 44 00 	lea    0x44d93c(%rip),%rdx        # 5c73a8 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0xc0>
  179a6c:	be 41 00 00 00       	mov    $0x41,%esi
  179a71:	ff 15 39 8e 45 00    	call   *0x458e39(%rip)        # 5d28b0 <_DYNAMIC+0x290>
  179a77:	e9 e4 00 00 00       	jmp    179b60 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x27b0>
  179a7c:	48 8d 0d 3d d9 44 00 	lea    0x44d93d(%rip),%rcx        # 5c73c0 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0xd8>
  179a83:	45 31 c0             	xor    %r8d,%r8d
  179a86:	eb 16                	jmp    179a9e <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x26ee>
  179a88:	48 8d 0d 61 d9 44 00 	lea    0x44d961(%rip),%rcx        # 5c73f0 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0x108>
  179a8f:	48 89 d0             	mov    %rdx,%rax
  179a92:	eb 0a                	jmp    179a9e <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x26ee>
  179a94:	48 8d 0d 6d d9 44 00 	lea    0x44d96d(%rip),%rcx        # 5c7408 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0x120>
  179a9b:	48 89 c2             	mov    %rax,%rdx
  179a9e:	4c 89 c7             	mov    %r8,%rdi
  179aa1:	48 89 d6             	mov    %rdx,%rsi
  179aa4:	48 89 c2             	mov    %rax,%rdx
  179aa7:	ff 15 0b 8e 45 00    	call   *0x458e0b(%rip)        # 5d28b8 <_DYNAMIC+0x298>
  179aad:	e9 ae 00 00 00       	jmp    179b60 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x27b0>
  179ab2:	48 8d 15 67 d9 44 00 	lea    0x44d967(%rip),%rdx        # 5c7420 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0x138>
  179ab9:	48 89 cf             	mov    %rcx,%rdi
  179abc:	ff 15 fe 8d 45 00    	call   *0x458dfe(%rip)        # 5d28c0 <_DYNAMIC+0x2a0>
  179ac2:	e9 99 00 00 00       	jmp    179b60 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x27b0>
  179ac7:	48 89 84 24 b8 00 00 	mov    %rax,0xb8(%rsp)
  179ace:	00 
  179acf:	48 89 ef             	mov    %rbp,%rdi
  179ad2:	48 8b 94 24 b8 00 00 	mov    0xb8(%rsp),%rdx
  179ad9:	00 
  179ada:	c5 f8 77             	vzeroupper
  179add:	ff 15 e5 8d 45 00    	call   *0x458de5(%rip)        # 5d28c8 <_DYNAMIC+0x2a8>
  179ae3:	eb 7b                	jmp    179b60 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x27b0>
  179ae5:	48 8d 15 ac d9 44 00 	lea    0x44d9ac(%rip),%rdx        # 5c7498 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0x1b0>
  179aec:	eb 47                	jmp    179b35 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2785>
  179aee:	48 89 ef             	mov    %rbp,%rdi
  179af1:	48 8d 15 88 d9 44 00 	lea    0x44d988(%rip),%rdx        # 5c7480 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0x198>
  179af8:	eb 3b                	jmp    179b35 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2785>
  179afa:	48 8d 15 67 d9 44 00 	lea    0x44d967(%rip),%rdx        # 5c7468 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0x180>
  179b01:	eb 32                	jmp    179b35 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2785>
  179b03:	4c 89 cf             	mov    %r9,%rdi
  179b06:	49 89 cd             	mov    %rcx,%r13
  179b09:	48 8d 15 40 d9 44 00 	lea    0x44d940(%rip),%rdx        # 5c7450 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.6863592281246770637+0x168>
  179b10:	eb 23                	jmp    179b35 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2785>
  179b12:	4c 89 cf             	mov    %r9,%rdi
  179b15:	4c 8b 6c 24 78       	mov    0x78(%rsp),%r13
  179b1a:	eb 06                	jmp    179b22 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2772>
  179b1c:	4c 89 c7             	mov    %r8,%rdi
  179b1f:	49 89 cd             	mov    %rcx,%r13
  179b22:	48 89 da             	mov    %rbx,%rdx
  179b25:	eb 0e                	jmp    179b35 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2785>
  179b27:	49 89 cd             	mov    %rcx,%r13
  179b2a:	4c 89 da             	mov    %r11,%rdx
  179b2d:	eb 06                	jmp    179b35 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2785>
  179b2f:	49 ff c9             	dec    %r9
  179b32:	4c 89 cf             	mov    %r9,%rdi
  179b35:	4c 89 ee             	mov    %r13,%rsi
  179b38:	ff 15 8a 8d 45 00    	call   *0x458d8a(%rip)        # 5d28c8 <_DYNAMIC+0x2a8>
  179b3e:	eb 20                	jmp    179b60 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x27b0>
  179b40:	bf 08 00 00 00       	mov    $0x8,%edi
  179b45:	4c 89 f6             	mov    %r14,%rsi
  179b48:	ff 15 32 8d 45 00    	call   *0x458d32(%rip)        # 5d2880 <_DYNAMIC+0x260>
  179b4e:	bf 08 00 00 00       	mov    $0x8,%edi
  179b53:	e9 c6 d9 ff ff       	jmp    17751e <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x16e>
  179b58:	c5 f8 77             	vzeroupper
  179b5b:	e8 a0 49 18 00       	call   2fe500 <core::panicking::unreachable_display::<&str>>
  179b60:	0f 0b                	ud2
  179b62:	eb 7f                	jmp    179be3 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2833>
  179b64:	eb 7d                	jmp    179be3 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2833>
  179b66:	eb 7b                	jmp    179be3 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2833>
  179b68:	eb 79                	jmp    179be3 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2833>
  179b6a:	eb 77                	jmp    179be3 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2833>
  179b6c:	eb 75                	jmp    179be3 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2833>
  179b6e:	eb 73                	jmp    179be3 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2833>
  179b70:	eb 71                	jmp    179be3 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2833>
  179b72:	eb 6f                	jmp    179be3 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2833>
  179b74:	eb 6d                	jmp    179be3 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2833>
  179b76:	eb 6b                	jmp    179be3 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2833>
  179b78:	eb 69                	jmp    179be3 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2833>
  179b7a:	eb 67                	jmp    179be3 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2833>
  179b7c:	eb 65                	jmp    179be3 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2833>
  179b7e:	eb 63                	jmp    179be3 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2833>
  179b80:	eb 61                	jmp    179be3 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2833>
  179b82:	eb 5f                	jmp    179be3 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2833>
  179b84:	eb 5d                	jmp    179be3 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2833>
  179b86:	eb 5b                	jmp    179be3 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2833>
  179b88:	eb 59                	jmp    179be3 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2833>
  179b8a:	eb 57                	jmp    179be3 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2833>
  179b8c:	eb 55                	jmp    179be3 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2833>
  179b8e:	eb 53                	jmp    179be3 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2833>
  179b90:	eb 51                	jmp    179be3 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2833>
  179b92:	eb 4f                	jmp    179be3 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2833>
  179b94:	eb 4d                	jmp    179be3 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2833>
  179b96:	eb 4b                	jmp    179be3 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2833>
  179b98:	eb 49                	jmp    179be3 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2833>
  179b9a:	eb 47                	jmp    179be3 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2833>
  179b9c:	eb 45                	jmp    179be3 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2833>
  179b9e:	eb 43                	jmp    179be3 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2833>
  179ba0:	eb 41                	jmp    179be3 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2833>
  179ba2:	48 89 c3             	mov    %rax,%rbx
  179ba5:	48 8b 84 24 80 00 00 	mov    0x80(%rsp),%rax
  179bac:	00 
  179bad:	48 85 c0             	test   %rax,%rax
  179bb0:	74 34                	je     179be6 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2836>
  179bb2:	48 8b bc 24 88 00 00 	mov    0x88(%rsp),%rdi
  179bb9:	00 
  179bba:	0f b6 0d 27 b0 45 00 	movzbl 0x45b027(%rip),%ecx        # 5d4be8 <frontier_experiment::TRACK>
  179bc1:	84 c9                	test   %cl,%cl
  179bc3:	4c 8b 74 24 28       	mov    0x28(%rsp),%r14
  179bc8:	4c 8b 7c 24 20       	mov    0x20(%rsp),%r15
  179bcd:	74 0c                	je     179bdb <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x282b>
  179bcf:	48 c1 e0 03          	shl    $0x3,%rax
  179bd3:	f0 48 29 05 fd af 45 	lock sub %rax,0x45affd(%rip)        # 5d4bd8 <frontier_experiment::LIVE>
  179bda:	00 
  179bdb:	ff 15 c7 8c 45 00    	call   *0x458cc7(%rip)        # 5d28a8 <free@GLIBC_2.2.5>
  179be1:	eb 0d                	jmp    179bf0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2840>
  179be3:	48 89 c3             	mov    %rax,%rbx
  179be6:	4c 8b 74 24 28       	mov    0x28(%rsp),%r14
  179beb:	4c 8b 7c 24 20       	mov    0x20(%rsp),%r15
  179bf0:	48 83 bc 24 c0 00 00 	cmpq   $0x0,0xc0(%rsp)
  179bf7:	00 00 
  179bf9:	74 2d                	je     179c28 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2878>
  179bfb:	0f b6 05 e6 af 45 00 	movzbl 0x45afe6(%rip),%eax        # 5d4be8 <frontier_experiment::TRACK>
  179c02:	84 c0                	test   %al,%al
  179c04:	74 14                	je     179c1a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x286a>
  179c06:	48 8b 84 24 c0 00 00 	mov    0xc0(%rsp),%rax
  179c0d:	00 
  179c0e:	48 c1 e0 03          	shl    $0x3,%rax
  179c12:	f0 48 29 05 be af 45 	lock sub %rax,0x45afbe(%rip)        # 5d4bd8 <frontier_experiment::LIVE>
  179c19:	00 
  179c1a:	4c 89 ff             	mov    %r15,%rdi
  179c1d:	ff 15 85 8c 45 00    	call   *0x458c85(%rip)        # 5d28a8 <free@GLIBC_2.2.5>
  179c23:	eb 03                	jmp    179c28 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2878>
  179c25:	48 89 c3             	mov    %rax,%rbx
  179c28:	4d 85 f6             	test   %r14,%r14
  179c2b:	74 22                	je     179c4f <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x289f>
  179c2d:	0f b6 05 b4 af 45 00 	movzbl 0x45afb4(%rip),%eax        # 5d4be8 <frontier_experiment::TRACK>
  179c34:	84 c0                	test   %al,%al
  179c36:	74 0c                	je     179c44 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x2894>
  179c38:	49 c1 e6 04          	shl    $0x4,%r14
  179c3c:	f0 4c 29 35 94 af 45 	lock sub %r14,0x45af94(%rip)        # 5d4bd8 <frontier_experiment::LIVE>
  179c43:	00 
  179c44:	48 8b 7c 24 50       	mov    0x50(%rsp),%rdi
  179c49:	ff 15 59 8c 45 00    	call   *0x458c59(%rip)        # 5d28a8 <free@GLIBC_2.2.5>
  179c4f:	48 89 df             	mov    %rbx,%rdi
  179c52:	e8 f9 b1 44 00       	call   5c4e50 <_Unwind_Resume@plt>
