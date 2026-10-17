
experiments/block_msd/target/pa-outline-final/time:     file format elf64-x86-64


Disassembly of section .text:

0000000000142400 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>>:
  142400:	push   %rbp
  142401:	push   %r15
  142403:	push   %r14
  142405:	push   %r13
  142407:	push   %r12
  142409:	push   %rbx
  14240a:	sub    $0x88,%rsp
  142411:	mov    %r9,0x10(%rsp)
  142416:	mov    %r8,0x38(%rsp)
  14241b:	mov    %rsi,%r10
  14241e:	mov    0x80(%rdi),%rax
  142425:	mov    0xa8(%rdi),%rsi
  14242c:	mov    %rsi,0x78(%rsp)
  142431:	cmp    %rsi,%rax
  142434:	jae    1429ac <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x5ac>
  14243a:	mov    0x20(%rdi),%rsi
  14243e:	mov    %rsi,0x28(%rsp)
  142443:	mov    0x28(%rdi),%rsi
  142447:	mov    0x88(%rdi),%r15
  14244e:	mov    0xa0(%rdi),%r8
  142455:	mov    %r8,0x20(%rsp)
  14245a:	mov    0x90(%rdi),%r8
  142461:	mov    %r8,0x18(%rsp)
  142466:	mov    0x78(%rdi),%rbp
  14246a:	mov    0x70(%rdi),%r8
  14246e:	mov    %r8,0x70(%rsp)
  142473:	mov    0x68(%rdi),%r9
  142477:	mov    (%r10),%rbx
  14247a:	mov    0x58(%rdi),%r8
  14247e:	mov    %r8,0x8(%rsp)
  142483:	mov    0x50(%rdi),%rdi
  142487:	mov    %rdi,0x30(%rsp)
  14248c:	cmp    %rsi,%rax
  14248f:	mov    %rsi,%rdi
  142492:	cmova  %rax,%rdi
  142496:	mov    %rdi,0x48(%rsp)
  14249b:	xor    %r10d,%r10d
  14249e:	mov    %rax,%r8
  1424a1:	mov    %r9,0x68(%rsp)
  1424a6:	jmp    1424cd <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0xcd>
  1424a8:	nopl   0x0(%rax,%rax,1)
  1424b0:	mov    0x58(%rsp),%r8
  1424b5:	inc    %r8
  1424b8:	cmp    0x78(%rsp),%r8
  1424bd:	mov    0x68(%rsp),%r9
  1424c2:	mov    0x40(%rsp),%r10
  1424c7:	je     1429ac <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x5ac>
  1424cd:	cmp    0x48(%rsp),%r8
  1424d2:	je     142a31 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x631>
  1424d8:	mov    0x28(%rsp),%rdi
  1424dd:	mov    (%rdi,%r8,4),%edi
  1424e1:	cmp    %rdi,%rsi
  1424e4:	jbe    1429be <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x5be>
  1424ea:	mov    %r8,0x58(%rsp)
  1424ef:	mov    %rdi,%r14
  1424f2:	cmp    %rdi,%r15
  1424f5:	mov    $0x0,%edi
  1424fa:	cmovbe %r15,%rdi
  1424fe:	mov    0x18(%rsp),%r8
  142503:	cmova  0x20(%rsp),%r8
  142509:	mov    %r8,0x50(%rsp)
  14250e:	cmp    0x70(%rsp),%r10
  142513:	jae    142540 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x140>
  142515:	mov    %r10,%r8
  142518:	shl    $0x4,%r8
  14251c:	mov    0x58(%rsp),%r11
  142521:	cmp    %r11,(%r9,%r8,1)
  142525:	jne    142540 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x140>
  142527:	add    %r9,%r8
  14252a:	mov    0x8(%r8),%r8
  14252e:	inc    %r10
  142531:	mov    %r10,0x40(%rsp)
  142536:	jmp    142548 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x148>
  142538:	nopl   0x0(%rax,%rax,1)
  142540:	mov    %r10,0x40(%rsp)
  142545:	mov    %rbp,%r8
  142548:	sub    %rdi,%r14
  14254b:	mov    %r8,0x60(%rsp)
  142550:	shr    $0x2,%r8
  142554:	mov    %r14,0x80(%rsp)
  14255c:	je     1428a0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x4a0>
  142562:	lea    0x0(,%rbp,8),%rdi
  14256a:	imul   %r14,%rdi
  14256e:	mov    0x50(%rsp),%r9
  142573:	add    %rdi,%r9
  142576:	add    $0x18,%r9
  14257a:	jmp    142599 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x199>
  14257c:	nopl   0x0(%rax)
  142580:	mov    0x38(%rsp),%rdi
  142585:	incq   (%rdi,%r11,8)
  142589:	inc    %rax
  14258c:	add    $0x20,%r9
  142590:	dec    %r8
  142593:	je     1428a0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x4a0>
  142599:	mov    (%rbx),%rdi
  14259c:	movzbl (%rdi),%r10d
  1425a0:	shrx   %r10d,-0x18(%r9),%r10d
  1425a6:	and    0x8(%rdi),%r10d
  1425aa:	shr    $0x10,%r10d
  1425ae:	movzbl %r10b,%edi
  1425b2:	cmp    %rdi,%rcx
  1425b5:	jbe    142a0f <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x60f>
  1425bb:	mov    %edi,%r11d
  1425be:	shl    $0x4,%r11d
  1425c2:	mov    (%rdx,%r11,1),%r14
  1425c6:	mov    -0x18(%r9),%r12
  1425ca:	lea    0x8(%r14),%r13
  1425ce:	cmp    0x8(%rdx,%r11,1),%r13
  1425d3:	mov    %r12,(%r14)
  1425d6:	mov    %r13,(%rdx,%r11,1)
  1425da:	jne    14265a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x25a>
  1425dc:	cmp    %rsi,%rax
  1425df:	jae    1429ea <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x5ea>
  1425e5:	mov    0x28(%rsp),%r14
  1425ea:	mov    (%r14,%rax,4),%r14d
  1425ee:	cmp    %r14,%rsi
  1425f1:	jbe    1429be <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x5be>
  1425f7:	add    %rdx,%r11
  1425fa:	cmp    %r14,%r15
  1425fd:	mov    $0x0,%r12d
  142603:	cmovbe %r15,%r12
  142607:	mov    0x18(%rsp),%r13
  14260c:	cmova  0x20(%rsp),%r13
  142612:	sub    %r12,%r14
  142615:	imul   %rbp,%r14
  142619:	lea    0x0(,%r14,8),%r14
  142621:	add    %r13,%r14
  142624:	lea    (%r14,%rbp,8),%r12
  142628:	mov    %r14,(%r11)
  14262b:	mov    %r12,0x8(%r11)
  14262f:	cmp    0x8(%rsp),%rax
  142634:	jae    1429fa <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x5fa>
  14263a:	mov    0x30(%rsp),%r11
  14263f:	mov    %r10b,(%r11,%rax,1)
  142643:	cmp    %rdi,0x10(%rsp)
  142648:	jbe    142a1f <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x61f>
  14264e:	mov    0x38(%rsp),%r10
  142653:	incq   (%r10,%rdi,8)
  142657:	inc    %rax
  14265a:	mov    (%rbx),%rdi
  14265d:	movzbl (%rdi),%r10d
  142661:	shrx   %r10d,-0x10(%r9),%r10d
  142667:	and    0x8(%rdi),%r10d
  14266b:	shr    $0x10,%r10d
  14266f:	movzbl %r10b,%r11d
  142673:	cmp    %r11,%rcx
  142676:	jbe    1429d7 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x5d7>
  14267c:	mov    %r11d,%edi
  14267f:	shl    $0x4,%edi
  142682:	mov    (%rdx,%rdi,1),%r14
  142686:	mov    -0x10(%r9),%r12
  14268a:	lea    0x8(%r14),%r13
  14268e:	cmp    0x8(%rdx,%rdi,1),%r13
  142693:	mov    %r12,(%r14)
  142696:	mov    %r13,(%rdx,%rdi,1)
  14269a:	jne    14271a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x31a>
  14269c:	cmp    %rsi,%rax
  14269f:	jae    1429ea <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x5ea>
  1426a5:	mov    0x28(%rsp),%r14
  1426aa:	mov    (%r14,%rax,4),%r14d
  1426ae:	cmp    %r14,%rsi
  1426b1:	jbe    1429be <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x5be>
  1426b7:	add    %rdx,%rdi
  1426ba:	cmp    %r14,%r15
  1426bd:	mov    $0x0,%r12d
  1426c3:	cmovbe %r15,%r12
  1426c7:	mov    0x18(%rsp),%r13
  1426cc:	cmova  0x20(%rsp),%r13
  1426d2:	sub    %r12,%r14
  1426d5:	imul   %rbp,%r14
  1426d9:	lea    0x0(,%r14,8),%r14
  1426e1:	add    %r13,%r14
  1426e4:	lea    (%r14,%rbp,8),%r12
  1426e8:	mov    %r14,(%rdi)
  1426eb:	mov    %r12,0x8(%rdi)
  1426ef:	cmp    0x8(%rsp),%rax
  1426f4:	jae    1429fa <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x5fa>
  1426fa:	mov    0x30(%rsp),%rdi
  1426ff:	mov    %r10b,(%rdi,%rax,1)
  142703:	cmp    %r11,0x10(%rsp)
  142708:	jbe    142997 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x597>
  14270e:	mov    0x38(%rsp),%rdi
  142713:	incq   (%rdi,%r11,8)
  142717:	inc    %rax
  14271a:	mov    (%rbx),%rdi
  14271d:	movzbl (%rdi),%r10d
  142721:	shrx   %r10d,-0x8(%r9),%r10d
  142727:	and    0x8(%rdi),%r10d
  14272b:	shr    $0x10,%r10d
  14272f:	movzbl %r10b,%r11d
  142733:	cmp    %r11,%rcx
  142736:	jbe    1429d7 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x5d7>
  14273c:	mov    %r11d,%edi
  14273f:	shl    $0x4,%edi
  142742:	mov    (%rdx,%rdi,1),%r14
  142746:	mov    -0x8(%r9),%r12
  14274a:	lea    0x8(%r14),%r13
  14274e:	cmp    0x8(%rdx,%rdi,1),%r13
  142753:	mov    %r12,(%r14)
  142756:	mov    %r13,(%rdx,%rdi,1)
  14275a:	jne    1427da <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x3da>
  14275c:	cmp    %rsi,%rax
  14275f:	jae    1429ea <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x5ea>
  142765:	mov    0x28(%rsp),%r14
  14276a:	mov    (%r14,%rax,4),%r14d
  14276e:	cmp    %r14,%rsi
  142771:	jbe    1429be <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x5be>
  142777:	add    %rdx,%rdi
  14277a:	cmp    %r14,%r15
  14277d:	mov    $0x0,%r12d
  142783:	cmovbe %r15,%r12
  142787:	mov    0x18(%rsp),%r13
  14278c:	cmova  0x20(%rsp),%r13
  142792:	sub    %r12,%r14
  142795:	imul   %rbp,%r14
  142799:	lea    0x0(,%r14,8),%r14
  1427a1:	add    %r13,%r14
  1427a4:	lea    (%r14,%rbp,8),%r12
  1427a8:	mov    %r14,(%rdi)
  1427ab:	mov    %r12,0x8(%rdi)
  1427af:	cmp    0x8(%rsp),%rax
  1427b4:	jae    1429fa <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x5fa>
  1427ba:	mov    0x30(%rsp),%rdi
  1427bf:	mov    %r10b,(%rdi,%rax,1)
  1427c3:	cmp    %r11,0x10(%rsp)
  1427c8:	jbe    142997 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x597>
  1427ce:	mov    0x38(%rsp),%rdi
  1427d3:	incq   (%rdi,%r11,8)
  1427d7:	inc    %rax
  1427da:	mov    (%rbx),%rdi
  1427dd:	movzbl (%rdi),%r10d
  1427e1:	shrx   %r10d,(%r9),%r10d
  1427e6:	and    0x8(%rdi),%r10d
  1427ea:	shr    $0x10,%r10d
  1427ee:	movzbl %r10b,%r11d
  1427f2:	cmp    %r11,%rcx
  1427f5:	jbe    1429d7 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x5d7>
  1427fb:	mov    %r11d,%edi
  1427fe:	shl    $0x4,%edi
  142801:	mov    (%rdx,%rdi,1),%r14
  142805:	mov    (%r9),%r12
  142808:	lea    0x8(%r14),%r13
  14280c:	cmp    0x8(%rdx,%rdi,1),%r13
  142811:	mov    %r12,(%r14)
  142814:	mov    %r13,(%rdx,%rdi,1)
  142818:	jne    14258c <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x18c>
  14281e:	cmp    %rsi,%rax
  142821:	jae    1429ea <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x5ea>
  142827:	mov    0x28(%rsp),%r14
  14282c:	mov    (%r14,%rax,4),%r14d
  142830:	cmp    %r14,%rsi
  142833:	jbe    1429be <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x5be>
  142839:	add    %rdx,%rdi
  14283c:	cmp    %r14,%r15
  14283f:	mov    $0x0,%r12d
  142845:	cmovbe %r15,%r12
  142849:	mov    0x18(%rsp),%r13
  14284e:	cmova  0x20(%rsp),%r13
  142854:	sub    %r12,%r14
  142857:	imul   %rbp,%r14
  14285b:	lea    0x0(,%r14,8),%r14
  142863:	add    %r13,%r14
  142866:	lea    (%r14,%rbp,8),%r12
  14286a:	mov    %r14,(%rdi)
  14286d:	mov    %r12,0x8(%rdi)
  142871:	cmp    0x8(%rsp),%rax
  142876:	jae    1429fa <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x5fa>
  14287c:	mov    0x30(%rsp),%rdi
  142881:	mov    %r10b,(%rdi,%rax,1)
  142885:	cmp    %r11,0x10(%rsp)
  14288a:	ja     142580 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x180>
  142890:	jmp    142997 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x597>
  142895:	data16 cs nopw 0x0(%rax,%rax,1)
  1428a0:	mov    0x60(%rsp),%r8
  1428a5:	mov    %r8,%rdi
  1428a8:	and    $0xfffffffffffffffc,%rdi
  1428ac:	cmp    %r8,%rdi
  1428af:	je     1424b0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0xb0>
  1428b5:	mov    0x80(%rsp),%r8
  1428bd:	imul   %rbp,%r8
  1428c1:	mov    0x50(%rsp),%r9
  1428c6:	lea    (%r9,%r8,8),%r9
  1428ca:	jmp    1428ea <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x4ea>
  1428cc:	nopl   0x0(%rax)
  1428d0:	mov    0x38(%rsp),%r8
  1428d5:	incq   (%r8,%r11,8)
  1428d9:	inc    %rax
  1428dc:	inc    %rdi
  1428df:	cmp    0x60(%rsp),%rdi
  1428e4:	jae    1424b0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0xb0>
  1428ea:	mov    (%rbx),%r8
  1428ed:	movzbl (%r8),%r10d
  1428f1:	shrx   %r10d,(%r9,%rdi,8),%r10d
  1428f7:	and    0x8(%r8),%r10d
  1428fb:	shr    $0x10,%r10d
  1428ff:	movzbl %r10b,%r11d
  142903:	cmp    %r11,%rcx
  142906:	jbe    1429d7 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x5d7>
  14290c:	mov    %r11d,%r8d
  14290f:	shl    $0x4,%r8d
  142913:	mov    (%rdx,%r8,1),%r14
  142917:	mov    (%r9,%rdi,8),%r12
  14291b:	lea    0x8(%r14),%r13
  14291f:	cmp    0x8(%rdx,%r8,1),%r13
  142924:	mov    %r12,(%r14)
  142927:	mov    %r13,(%rdx,%r8,1)
  14292b:	jne    1428dc <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x4dc>
  14292d:	cmp    %rsi,%rax
  142930:	jae    1429ea <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x5ea>
  142936:	mov    0x28(%rsp),%r14
  14293b:	mov    (%r14,%rax,4),%r14d
  14293f:	cmp    %r14,%rsi
  142942:	jbe    1429be <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x5be>
  142944:	add    %rdx,%r8
  142947:	cmp    %r14,%r15
  14294a:	mov    $0x0,%r12d
  142950:	cmovbe %r15,%r12
  142954:	mov    0x18(%rsp),%r13
  142959:	cmova  0x20(%rsp),%r13
  14295f:	sub    %r12,%r14
  142962:	imul   %rbp,%r14
  142966:	lea    0x0(,%r14,8),%r14
  14296e:	add    %r13,%r14
  142971:	lea    (%r14,%rbp,8),%r12
  142975:	mov    %r14,(%r8)
  142978:	mov    %r12,0x8(%r8)
  14297c:	cmp    0x8(%rsp),%rax
  142981:	jae    1429fa <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x5fa>
  142983:	mov    0x30(%rsp),%r8
  142988:	mov    %r10b,(%r8,%rax,1)
  14298c:	cmp    %r11,0x10(%rsp)
  142991:	ja     1428d0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x4d0>
  142997:	lea    0x36d4fa(%rip),%rdx        # 4afe98 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.4211023910758936617+0x2e0>
  14299e:	mov    %r11,%rdi
  1429a1:	mov    0x10(%rsp),%rsi
  1429a6:	call   *0x3787ec(%rip)        # 4bb198 <_DYNAMIC+0x2a8>
  1429ac:	add    $0x88,%rsp
  1429b3:	pop    %rbx
  1429b4:	pop    %r12
  1429b6:	pop    %r13
  1429b8:	pop    %r14
  1429ba:	pop    %r15
  1429bc:	pop    %rbp
  1429bd:	ret
  1429be:	lea    -0x12c852(%rip),%rdi        # 16173 <anon.8f17df2f0ddc4723825c0f55871536dc.0.llvm.4211023910758936617+0xf3>
  1429c5:	lea    0x36d55c(%rip),%rdx        # 4aff28 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.4211023910758936617+0x370>
  1429cc:	mov    $0x2c,%esi
  1429d1:	call   *0x3787a9(%rip)        # 4bb180 <_DYNAMIC+0x290>
  1429d7:	lea    0x36d472(%rip),%rdx        # 4afe50 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.4211023910758936617+0x298>
  1429de:	mov    %r11,%rdi
  1429e1:	mov    %rcx,%rsi
  1429e4:	call   *0x3787ae(%rip)        # 4bb198 <_DYNAMIC+0x2a8>
  1429ea:	lea    0x36d477(%rip),%rdx        # 4afe68 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.4211023910758936617+0x2b0>
  1429f1:	mov    %rax,%rdi
  1429f4:	call   *0x37879e(%rip)        # 4bb198 <_DYNAMIC+0x2a8>
  1429fa:	lea    0x36d47f(%rip),%rdx        # 4afe80 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.4211023910758936617+0x2c8>
  142a01:	mov    %rax,%rdi
  142a04:	mov    0x8(%rsp),%rsi
  142a09:	call   *0x378789(%rip)        # 4bb198 <_DYNAMIC+0x2a8>
  142a0f:	lea    0x36d43a(%rip),%rdx        # 4afe50 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.4211023910758936617+0x298>
  142a16:	mov    %rcx,%rsi
  142a19:	call   *0x378779(%rip)        # 4bb198 <_DYNAMIC+0x2a8>
  142a1f:	lea    0x36d472(%rip),%rdx        # 4afe98 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.4211023910758936617+0x2e0>
  142a26:	mov    0x10(%rsp),%rsi
  142a2b:	call   *0x378767(%rip)        # 4bb198 <_DYNAMIC+0x2a8>
  142a31:	lea    0x36d228(%rip),%rdx        # 4afc60 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.4211023910758936617+0xa8>
  142a38:	mov    0x48(%rsp),%rdi
  142a3d:	call   *0x378755(%rip)        # 4bb198 <_DYNAMIC+0x2a8>
