
experiments/block_msd/target/pa-direct/time:     file format elf64-x86-64


Disassembly of section .text:

000000000021b530 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>>:
  21b530:	push   %rbp
  21b531:	push   %r15
  21b533:	push   %r14
  21b535:	push   %r13
  21b537:	push   %r12
  21b539:	push   %rbx
  21b53a:	sub    $0x88,%rsp
  21b541:	mov    %r9,0x10(%rsp)
  21b546:	mov    %r8,0x38(%rsp)
  21b54b:	mov    %rsi,%r10
  21b54e:	mov    0x80(%rdi),%rax
  21b555:	mov    0xa8(%rdi),%rsi
  21b55c:	mov    %rsi,0x78(%rsp)
  21b561:	cmp    %rsi,%rax
  21b564:	jae    21badc <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x5ac>
  21b56a:	mov    0x20(%rdi),%rsi
  21b56e:	mov    %rsi,0x28(%rsp)
  21b573:	mov    0x28(%rdi),%rsi
  21b577:	mov    0x88(%rdi),%r15
  21b57e:	mov    0xa0(%rdi),%r8
  21b585:	mov    %r8,0x20(%rsp)
  21b58a:	mov    0x90(%rdi),%r8
  21b591:	mov    %r8,0x18(%rsp)
  21b596:	mov    0x78(%rdi),%rbp
  21b59a:	mov    0x70(%rdi),%r8
  21b59e:	mov    %r8,0x70(%rsp)
  21b5a3:	mov    0x68(%rdi),%r9
  21b5a7:	mov    (%r10),%rbx
  21b5aa:	mov    0x58(%rdi),%r8
  21b5ae:	mov    %r8,0x8(%rsp)
  21b5b3:	mov    0x50(%rdi),%rdi
  21b5b7:	mov    %rdi,0x30(%rsp)
  21b5bc:	cmp    %rsi,%rax
  21b5bf:	mov    %rsi,%rdi
  21b5c2:	cmova  %rax,%rdi
  21b5c6:	mov    %rdi,0x48(%rsp)
  21b5cb:	xor    %r10d,%r10d
  21b5ce:	mov    %rax,%r8
  21b5d1:	mov    %r9,0x68(%rsp)
  21b5d6:	jmp    21b5fd <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0xcd>
  21b5d8:	nopl   0x0(%rax,%rax,1)
  21b5e0:	mov    0x58(%rsp),%r8
  21b5e5:	inc    %r8
  21b5e8:	cmp    0x78(%rsp),%r8
  21b5ed:	mov    0x68(%rsp),%r9
  21b5f2:	mov    0x40(%rsp),%r10
  21b5f7:	je     21badc <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x5ac>
  21b5fd:	cmp    0x48(%rsp),%r8
  21b602:	je     21bb61 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x631>
  21b608:	mov    0x28(%rsp),%rdi
  21b60d:	mov    (%rdi,%r8,4),%edi
  21b611:	cmp    %rdi,%rsi
  21b614:	jbe    21baee <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x5be>
  21b61a:	mov    %r8,0x58(%rsp)
  21b61f:	mov    %rdi,%r14
  21b622:	cmp    %rdi,%r15
  21b625:	mov    $0x0,%edi
  21b62a:	cmovbe %r15,%rdi
  21b62e:	mov    0x18(%rsp),%r8
  21b633:	cmova  0x20(%rsp),%r8
  21b639:	mov    %r8,0x50(%rsp)
  21b63e:	cmp    0x70(%rsp),%r10
  21b643:	jae    21b670 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x140>
  21b645:	mov    %r10,%r8
  21b648:	shl    $0x4,%r8
  21b64c:	mov    0x58(%rsp),%r11
  21b651:	cmp    %r11,(%r9,%r8,1)
  21b655:	jne    21b670 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x140>
  21b657:	add    %r9,%r8
  21b65a:	mov    0x8(%r8),%r8
  21b65e:	inc    %r10
  21b661:	mov    %r10,0x40(%rsp)
  21b666:	jmp    21b678 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x148>
  21b668:	nopl   0x0(%rax,%rax,1)
  21b670:	mov    %r10,0x40(%rsp)
  21b675:	mov    %rbp,%r8
  21b678:	sub    %rdi,%r14
  21b67b:	mov    %r8,0x60(%rsp)
  21b680:	shr    $0x2,%r8
  21b684:	mov    %r14,0x80(%rsp)
  21b68c:	je     21b9d0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x4a0>
  21b692:	lea    0x0(,%rbp,8),%rdi
  21b69a:	imul   %r14,%rdi
  21b69e:	mov    0x50(%rsp),%r9
  21b6a3:	add    %rdi,%r9
  21b6a6:	add    $0x18,%r9
  21b6aa:	jmp    21b6c9 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x199>
  21b6ac:	nopl   0x0(%rax)
  21b6b0:	mov    0x38(%rsp),%rdi
  21b6b5:	incq   (%rdi,%r11,8)
  21b6b9:	inc    %rax
  21b6bc:	add    $0x20,%r9
  21b6c0:	dec    %r8
  21b6c3:	je     21b9d0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x4a0>
  21b6c9:	mov    (%rbx),%rdi
  21b6cc:	movzbl (%rdi),%r10d
  21b6d0:	shrx   %r10d,-0x18(%r9),%r10d
  21b6d6:	and    0x8(%rdi),%r10d
  21b6da:	shr    $0x8,%r10d
  21b6de:	movzbl %r10b,%edi
  21b6e2:	cmp    %rdi,%rcx
  21b6e5:	jbe    21bb3f <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x60f>
  21b6eb:	mov    %edi,%r11d
  21b6ee:	shl    $0x4,%r11d
  21b6f2:	mov    (%rdx,%r11,1),%r14
  21b6f6:	mov    -0x18(%r9),%r12
  21b6fa:	lea    0x8(%r14),%r13
  21b6fe:	cmp    0x8(%rdx,%r11,1),%r13
  21b703:	mov    %r12,(%r14)
  21b706:	mov    %r13,(%rdx,%r11,1)
  21b70a:	jne    21b78a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x25a>
  21b70c:	cmp    %rsi,%rax
  21b70f:	jae    21bb1a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x5ea>
  21b715:	mov    0x28(%rsp),%r14
  21b71a:	mov    (%r14,%rax,4),%r14d
  21b71e:	cmp    %r14,%rsi
  21b721:	jbe    21baee <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x5be>
  21b727:	add    %rdx,%r11
  21b72a:	cmp    %r14,%r15
  21b72d:	mov    $0x0,%r12d
  21b733:	cmovbe %r15,%r12
  21b737:	mov    0x18(%rsp),%r13
  21b73c:	cmova  0x20(%rsp),%r13
  21b742:	sub    %r12,%r14
  21b745:	imul   %rbp,%r14
  21b749:	lea    0x0(,%r14,8),%r14
  21b751:	add    %r13,%r14
  21b754:	lea    (%r14,%rbp,8),%r12
  21b758:	mov    %r14,(%r11)
  21b75b:	mov    %r12,0x8(%r11)
  21b75f:	cmp    0x8(%rsp),%rax
  21b764:	jae    21bb2a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x5fa>
  21b76a:	mov    0x30(%rsp),%r11
  21b76f:	mov    %r10b,(%r11,%rax,1)
  21b773:	cmp    %rdi,0x10(%rsp)
  21b778:	jbe    21bb4f <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x61f>
  21b77e:	mov    0x38(%rsp),%r10
  21b783:	incq   (%r10,%rdi,8)
  21b787:	inc    %rax
  21b78a:	mov    (%rbx),%rdi
  21b78d:	movzbl (%rdi),%r10d
  21b791:	shrx   %r10d,-0x10(%r9),%r10d
  21b797:	and    0x8(%rdi),%r10d
  21b79b:	shr    $0x8,%r10d
  21b79f:	movzbl %r10b,%r11d
  21b7a3:	cmp    %r11,%rcx
  21b7a6:	jbe    21bb07 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x5d7>
  21b7ac:	mov    %r11d,%edi
  21b7af:	shl    $0x4,%edi
  21b7b2:	mov    (%rdx,%rdi,1),%r14
  21b7b6:	mov    -0x10(%r9),%r12
  21b7ba:	lea    0x8(%r14),%r13
  21b7be:	cmp    0x8(%rdx,%rdi,1),%r13
  21b7c3:	mov    %r12,(%r14)
  21b7c6:	mov    %r13,(%rdx,%rdi,1)
  21b7ca:	jne    21b84a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x31a>
  21b7cc:	cmp    %rsi,%rax
  21b7cf:	jae    21bb1a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x5ea>
  21b7d5:	mov    0x28(%rsp),%r14
  21b7da:	mov    (%r14,%rax,4),%r14d
  21b7de:	cmp    %r14,%rsi
  21b7e1:	jbe    21baee <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x5be>
  21b7e7:	add    %rdx,%rdi
  21b7ea:	cmp    %r14,%r15
  21b7ed:	mov    $0x0,%r12d
  21b7f3:	cmovbe %r15,%r12
  21b7f7:	mov    0x18(%rsp),%r13
  21b7fc:	cmova  0x20(%rsp),%r13
  21b802:	sub    %r12,%r14
  21b805:	imul   %rbp,%r14
  21b809:	lea    0x0(,%r14,8),%r14
  21b811:	add    %r13,%r14
  21b814:	lea    (%r14,%rbp,8),%r12
  21b818:	mov    %r14,(%rdi)
  21b81b:	mov    %r12,0x8(%rdi)
  21b81f:	cmp    0x8(%rsp),%rax
  21b824:	jae    21bb2a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x5fa>
  21b82a:	mov    0x30(%rsp),%rdi
  21b82f:	mov    %r10b,(%rdi,%rax,1)
  21b833:	cmp    %r11,0x10(%rsp)
  21b838:	jbe    21bac7 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x597>
  21b83e:	mov    0x38(%rsp),%rdi
  21b843:	incq   (%rdi,%r11,8)
  21b847:	inc    %rax
  21b84a:	mov    (%rbx),%rdi
  21b84d:	movzbl (%rdi),%r10d
  21b851:	shrx   %r10d,-0x8(%r9),%r10d
  21b857:	and    0x8(%rdi),%r10d
  21b85b:	shr    $0x8,%r10d
  21b85f:	movzbl %r10b,%r11d
  21b863:	cmp    %r11,%rcx
  21b866:	jbe    21bb07 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x5d7>
  21b86c:	mov    %r11d,%edi
  21b86f:	shl    $0x4,%edi
  21b872:	mov    (%rdx,%rdi,1),%r14
  21b876:	mov    -0x8(%r9),%r12
  21b87a:	lea    0x8(%r14),%r13
  21b87e:	cmp    0x8(%rdx,%rdi,1),%r13
  21b883:	mov    %r12,(%r14)
  21b886:	mov    %r13,(%rdx,%rdi,1)
  21b88a:	jne    21b90a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x3da>
  21b88c:	cmp    %rsi,%rax
  21b88f:	jae    21bb1a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x5ea>
  21b895:	mov    0x28(%rsp),%r14
  21b89a:	mov    (%r14,%rax,4),%r14d
  21b89e:	cmp    %r14,%rsi
  21b8a1:	jbe    21baee <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x5be>
  21b8a7:	add    %rdx,%rdi
  21b8aa:	cmp    %r14,%r15
  21b8ad:	mov    $0x0,%r12d
  21b8b3:	cmovbe %r15,%r12
  21b8b7:	mov    0x18(%rsp),%r13
  21b8bc:	cmova  0x20(%rsp),%r13
  21b8c2:	sub    %r12,%r14
  21b8c5:	imul   %rbp,%r14
  21b8c9:	lea    0x0(,%r14,8),%r14
  21b8d1:	add    %r13,%r14
  21b8d4:	lea    (%r14,%rbp,8),%r12
  21b8d8:	mov    %r14,(%rdi)
  21b8db:	mov    %r12,0x8(%rdi)
  21b8df:	cmp    0x8(%rsp),%rax
  21b8e4:	jae    21bb2a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x5fa>
  21b8ea:	mov    0x30(%rsp),%rdi
  21b8ef:	mov    %r10b,(%rdi,%rax,1)
  21b8f3:	cmp    %r11,0x10(%rsp)
  21b8f8:	jbe    21bac7 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x597>
  21b8fe:	mov    0x38(%rsp),%rdi
  21b903:	incq   (%rdi,%r11,8)
  21b907:	inc    %rax
  21b90a:	mov    (%rbx),%rdi
  21b90d:	movzbl (%rdi),%r10d
  21b911:	shrx   %r10d,(%r9),%r10d
  21b916:	and    0x8(%rdi),%r10d
  21b91a:	shr    $0x8,%r10d
  21b91e:	movzbl %r10b,%r11d
  21b922:	cmp    %r11,%rcx
  21b925:	jbe    21bb07 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x5d7>
  21b92b:	mov    %r11d,%edi
  21b92e:	shl    $0x4,%edi
  21b931:	mov    (%rdx,%rdi,1),%r14
  21b935:	mov    (%r9),%r12
  21b938:	lea    0x8(%r14),%r13
  21b93c:	cmp    0x8(%rdx,%rdi,1),%r13
  21b941:	mov    %r12,(%r14)
  21b944:	mov    %r13,(%rdx,%rdi,1)
  21b948:	jne    21b6bc <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x18c>
  21b94e:	cmp    %rsi,%rax
  21b951:	jae    21bb1a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x5ea>
  21b957:	mov    0x28(%rsp),%r14
  21b95c:	mov    (%r14,%rax,4),%r14d
  21b960:	cmp    %r14,%rsi
  21b963:	jbe    21baee <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x5be>
  21b969:	add    %rdx,%rdi
  21b96c:	cmp    %r14,%r15
  21b96f:	mov    $0x0,%r12d
  21b975:	cmovbe %r15,%r12
  21b979:	mov    0x18(%rsp),%r13
  21b97e:	cmova  0x20(%rsp),%r13
  21b984:	sub    %r12,%r14
  21b987:	imul   %rbp,%r14
  21b98b:	lea    0x0(,%r14,8),%r14
  21b993:	add    %r13,%r14
  21b996:	lea    (%r14,%rbp,8),%r12
  21b99a:	mov    %r14,(%rdi)
  21b99d:	mov    %r12,0x8(%rdi)
  21b9a1:	cmp    0x8(%rsp),%rax
  21b9a6:	jae    21bb2a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x5fa>
  21b9ac:	mov    0x30(%rsp),%rdi
  21b9b1:	mov    %r10b,(%rdi,%rax,1)
  21b9b5:	cmp    %r11,0x10(%rsp)
  21b9ba:	ja     21b6b0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x180>
  21b9c0:	jmp    21bac7 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x597>
  21b9c5:	data16 cs nopw 0x0(%rax,%rax,1)
  21b9d0:	mov    0x60(%rsp),%r8
  21b9d5:	mov    %r8,%rdi
  21b9d8:	and    $0xfffffffffffffffc,%rdi
  21b9dc:	cmp    %r8,%rdi
  21b9df:	je     21b5e0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0xb0>
  21b9e5:	mov    0x80(%rsp),%r8
  21b9ed:	imul   %rbp,%r8
  21b9f1:	mov    0x50(%rsp),%r9
  21b9f6:	lea    (%r9,%r8,8),%r9
  21b9fa:	jmp    21ba1a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x4ea>
  21b9fc:	nopl   0x0(%rax)
  21ba00:	mov    0x38(%rsp),%r8
  21ba05:	incq   (%r8,%r11,8)
  21ba09:	inc    %rax
  21ba0c:	inc    %rdi
  21ba0f:	cmp    0x60(%rsp),%rdi
  21ba14:	jae    21b5e0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0xb0>
  21ba1a:	mov    (%rbx),%r8
  21ba1d:	movzbl (%r8),%r10d
  21ba21:	shrx   %r10d,(%r9,%rdi,8),%r10d
  21ba27:	and    0x8(%r8),%r10d
  21ba2b:	shr    $0x8,%r10d
  21ba2f:	movzbl %r10b,%r11d
  21ba33:	cmp    %r11,%rcx
  21ba36:	jbe    21bb07 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x5d7>
  21ba3c:	mov    %r11d,%r8d
  21ba3f:	shl    $0x4,%r8d
  21ba43:	mov    (%rdx,%r8,1),%r14
  21ba47:	mov    (%r9,%rdi,8),%r12
  21ba4b:	lea    0x8(%r14),%r13
  21ba4f:	cmp    0x8(%rdx,%r8,1),%r13
  21ba54:	mov    %r12,(%r14)
  21ba57:	mov    %r13,(%rdx,%r8,1)
  21ba5b:	jne    21ba0c <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x4dc>
  21ba5d:	cmp    %rsi,%rax
  21ba60:	jae    21bb1a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x5ea>
  21ba66:	mov    0x28(%rsp),%r14
  21ba6b:	mov    (%r14,%rax,4),%r14d
  21ba6f:	cmp    %r14,%rsi
  21ba72:	jbe    21baee <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x5be>
  21ba74:	add    %rdx,%r8
  21ba77:	cmp    %r14,%r15
  21ba7a:	mov    $0x0,%r12d
  21ba80:	cmovbe %r15,%r12
  21ba84:	mov    0x18(%rsp),%r13
  21ba89:	cmova  0x20(%rsp),%r13
  21ba8f:	sub    %r12,%r14
  21ba92:	imul   %rbp,%r14
  21ba96:	lea    0x0(,%r14,8),%r14
  21ba9e:	add    %r13,%r14
  21baa1:	lea    (%r14,%rbp,8),%r12
  21baa5:	mov    %r14,(%r8)
  21baa8:	mov    %r12,0x8(%r8)
  21baac:	cmp    0x8(%rsp),%rax
  21bab1:	jae    21bb2a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x5fa>
  21bab3:	mov    0x30(%rsp),%r8
  21bab8:	mov    %r10b,(%r8,%rax,1)
  21babc:	cmp    %r11,0x10(%rsp)
  21bac1:	ja     21ba00 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x4d0>
  21bac7:	lea    0x1c2c4a(%rip),%rdx        # 3de718 <anon.7fa33eb33931318ee6b6568b4abff869.4.llvm.17153750559840045314+0x328>
  21bace:	mov    %r11,%rdi
  21bad1:	mov    0x10(%rsp),%rsi
  21bad6:	call   *0x1c5a3c(%rip)        # 3e1518 <_DYNAMIC+0x280>
  21badc:	add    $0x88,%rsp
  21bae3:	pop    %rbx
  21bae4:	pop    %r12
  21bae6:	pop    %r13
  21bae8:	pop    %r14
  21baea:	pop    %r15
  21baec:	pop    %rbp
  21baed:	ret
  21baee:	lea    -0x205ac5(%rip),%rdi        # 16030 <anon.7fa33eb33931318ee6b6568b4abff869.3.llvm.17153750559840045314+0xf3>
  21baf5:	lea    0x1c2cac(%rip),%rdx        # 3de7a8 <anon.7fa33eb33931318ee6b6568b4abff869.4.llvm.17153750559840045314+0x3b8>
  21bafc:	mov    $0x2c,%esi
  21bb01:	call   *0x1c5a81(%rip)        # 3e1588 <_DYNAMIC+0x2f0>
  21bb07:	lea    0x1c2bc2(%rip),%rdx        # 3de6d0 <anon.7fa33eb33931318ee6b6568b4abff869.4.llvm.17153750559840045314+0x2e0>
  21bb0e:	mov    %r11,%rdi
  21bb11:	mov    %rcx,%rsi
  21bb14:	call   *0x1c59fe(%rip)        # 3e1518 <_DYNAMIC+0x280>
  21bb1a:	lea    0x1c2bc7(%rip),%rdx        # 3de6e8 <anon.7fa33eb33931318ee6b6568b4abff869.4.llvm.17153750559840045314+0x2f8>
  21bb21:	mov    %rax,%rdi
  21bb24:	call   *0x1c59ee(%rip)        # 3e1518 <_DYNAMIC+0x280>
  21bb2a:	lea    0x1c2bcf(%rip),%rdx        # 3de700 <anon.7fa33eb33931318ee6b6568b4abff869.4.llvm.17153750559840045314+0x310>
  21bb31:	mov    %rax,%rdi
  21bb34:	mov    0x8(%rsp),%rsi
  21bb39:	call   *0x1c59d9(%rip)        # 3e1518 <_DYNAMIC+0x280>
  21bb3f:	lea    0x1c2b8a(%rip),%rdx        # 3de6d0 <anon.7fa33eb33931318ee6b6568b4abff869.4.llvm.17153750559840045314+0x2e0>
  21bb46:	mov    %rcx,%rsi
  21bb49:	call   *0x1c59c9(%rip)        # 3e1518 <_DYNAMIC+0x280>
  21bb4f:	lea    0x1c2bc2(%rip),%rdx        # 3de718 <anon.7fa33eb33931318ee6b6568b4abff869.4.llvm.17153750559840045314+0x328>
  21bb56:	mov    0x10(%rsp),%rsi
  21bb5b:	call   *0x1c59b7(%rip)        # 3e1518 <_DYNAMIC+0x280>
  21bb61:	lea    0x1c2978(%rip),%rdx        # 3de4e0 <anon.7fa33eb33931318ee6b6568b4abff869.4.llvm.17153750559840045314+0xf0>
  21bb68:	mov    0x48(%rsp),%rdi
  21bb6d:	call   *0x1c59a5(%rip)        # 3e1518 <_DYNAMIC+0x280>
