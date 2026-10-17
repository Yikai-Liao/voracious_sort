
experiments/block_msd/target/pa-direct/time:     file format elf64-x86-64


Disassembly of section .text:

0000000000204470 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>>:
  204470:	push   %rbp
  204471:	push   %r15
  204473:	push   %r14
  204475:	push   %r13
  204477:	push   %r12
  204479:	push   %rbx
  20447a:	sub    $0x88,%rsp
  204481:	mov    %r9,0x10(%rsp)
  204486:	mov    %r8,0x38(%rsp)
  20448b:	mov    %rsi,%r11
  20448e:	mov    0x80(%rdi),%rax
  204495:	mov    0xa8(%rdi),%rsi
  20449c:	mov    %rsi,0x70(%rsp)
  2044a1:	cmp    %rsi,%rax
  2044a4:	jae    204a32 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x5c2>
  2044aa:	mov    0x20(%rdi),%rsi
  2044ae:	mov    %rsi,0x28(%rsp)
  2044b3:	mov    0x28(%rdi),%rsi
  2044b7:	mov    0x88(%rdi),%r12
  2044be:	mov    0xa0(%rdi),%r8
  2044c5:	mov    %r8,0x20(%rsp)
  2044ca:	mov    0x90(%rdi),%r8
  2044d1:	mov    %r8,0x18(%rsp)
  2044d6:	mov    0x78(%rdi),%r14
  2044da:	mov    0x70(%rdi),%r8
  2044de:	mov    %r8,0x68(%rsp)
  2044e3:	mov    0x68(%rdi),%r9
  2044e7:	mov    0x58(%rdi),%r8
  2044eb:	mov    %r8,0x8(%rsp)
  2044f0:	mov    0x50(%rdi),%rdi
  2044f4:	mov    %rdi,0x30(%rsp)
  2044f9:	cmp    %rsi,%rax
  2044fc:	mov    %rsi,%rdi
  2044ff:	cmova  %rax,%rdi
  204503:	mov    %rdi,0x48(%rsp)
  204508:	xor    %r8d,%r8d
  20450b:	mov    %rax,%rdi
  20450e:	mov    %r9,0x60(%rsp)
  204513:	jmp    204540 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0xd0>
  204515:	data16 cs nopw 0x0(%rax,%rax,1)
  204520:	mov    0x58(%rsp),%rdi
  204525:	inc    %rdi
  204528:	cmp    0x70(%rsp),%rdi
  20452d:	mov    0x60(%rsp),%r9
  204532:	mov    0x80(%rsp),%r8
  20453a:	je     204a32 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x5c2>
  204540:	cmp    0x48(%rsp),%rdi
  204545:	je     204af7 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x687>
  20454b:	mov    %rdi,%r10
  20454e:	mov    0x28(%rsp),%rdi
  204553:	mov    (%rdi,%r10,4),%edi
  204557:	cmp    %rdi,%rsi
  20455a:	jbe    204a44 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x5d4>
  204560:	mov    %r10,0x58(%rsp)
  204565:	mov    %rdi,%r15
  204568:	cmp    %rdi,%r12
  20456b:	mov    $0x0,%edi
  204570:	cmovbe %r12,%rdi
  204574:	mov    0x18(%rsp),%r10
  204579:	cmova  0x20(%rsp),%r10
  20457f:	mov    %r10,0x50(%rsp)
  204584:	cmp    0x68(%rsp),%r8
  204589:	jae    2045b0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x140>
  20458b:	mov    %r8,%r10
  20458e:	shl    $0x4,%r8
  204592:	mov    0x58(%rsp),%rbx
  204597:	cmp    %rbx,(%r9,%r8,1)
  20459b:	jne    2045c0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x150>
  20459d:	add    %r9,%r8
  2045a0:	mov    0x8(%r8),%rbx
  2045a4:	inc    %r10
  2045a7:	jmp    2045c3 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x153>
  2045a9:	nopl   0x0(%rax)
  2045b0:	mov    %r14,%rbx
  2045b3:	jmp    2045c6 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x156>
  2045b5:	data16 cs nopw 0x0(%rax,%rax,1)
  2045c0:	mov    %r14,%rbx
  2045c3:	mov    %r10,%r8
  2045c6:	mov    %r8,0x80(%rsp)
  2045ce:	sub    %rdi,%r15
  2045d1:	mov    %rbx,0x40(%rsp)
  2045d6:	mov    %rbx,%rdi
  2045d9:	shr    $0x2,%rdi
  2045dd:	mov    %r15,0x78(%rsp)
  2045e2:	je     204930 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x4c0>
  2045e8:	lea    0x0(,%r14,8),%r8
  2045f0:	imul   %r15,%r8
  2045f4:	mov    0x50(%rsp),%r9
  2045f9:	add    %r8,%r9
  2045fc:	add    $0x18,%r9
  204600:	jmp    20462c <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x1bc>
  204602:	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  204610:	mov    0x38(%rsp),%r8
  204615:	incq   (%r8,%rbx,8)
  204619:	inc    %rax
  20461c:	dec    %rdi
  20461f:	add    $0x20,%r9
  204623:	test   %rdi,%rdi
  204626:	je     204930 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x4c0>
  20462c:	mov    (%r11),%r8
  20462f:	movzbl (%r8),%r10d
  204633:	shrx   %r10d,-0x18(%r9),%r10d
  204639:	and    0x8(%r8),%r10d
  20463d:	shr    $0x10,%r10d
  204641:	movzbl %r10b,%ebx
  204645:	cmp    %rbx,%rcx
  204648:	jbe    204a5d <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x5ed>
  20464e:	mov    %ebx,%r8d
  204651:	shl    $0x4,%r8d
  204655:	mov    (%rdx,%r8,1),%r15
  204659:	mov    -0x18(%r9),%r13
  20465d:	lea    0x8(%r15),%rbp
  204661:	cmp    0x8(%rdx,%r8,1),%rbp
  204666:	mov    %r13,(%r15)
  204669:	mov    %rbp,(%rdx,%r8,1)
  20466d:	jne    2046ed <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x27d>
  20466f:	cmp    %rsi,%rax
  204672:	jae    204a70 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x600>
  204678:	mov    0x28(%rsp),%r15
  20467d:	mov    (%r15,%rax,4),%r15d
  204681:	cmp    %r15,%rsi
  204684:	jbe    204a44 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x5d4>
  20468a:	add    %rdx,%r8
  20468d:	cmp    %r15,%r12
  204690:	mov    $0x0,%r13d
  204696:	cmovbe %r12,%r13
  20469a:	mov    0x18(%rsp),%rbp
  20469f:	cmova  0x20(%rsp),%rbp
  2046a5:	sub    %r13,%r15
  2046a8:	imul   %r14,%r15
  2046ac:	lea    0x0(,%r15,8),%r15
  2046b4:	add    %rbp,%r15
  2046b7:	lea    (%r15,%r14,8),%r13
  2046bb:	mov    %r15,(%r8)
  2046be:	mov    %r13,0x8(%r8)
  2046c2:	cmp    0x8(%rsp),%rax
  2046c7:	jae    204a80 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x610>
  2046cd:	mov    0x30(%rsp),%r8
  2046d2:	mov    %r10b,(%r8,%rax,1)
  2046d6:	cmp    %rbx,0x10(%rsp)
  2046db:	jbe    204a95 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x625>
  2046e1:	mov    0x38(%rsp),%r8
  2046e6:	incq   (%r8,%rbx,8)
  2046ea:	inc    %rax
  2046ed:	mov    (%r11),%r8
  2046f0:	movzbl (%r8),%r10d
  2046f4:	shrx   %r10d,-0x10(%r9),%r10d
  2046fa:	and    0x8(%r8),%r10d
  2046fe:	shr    $0x10,%r10d
  204702:	movzbl %r10b,%ebx
  204706:	cmp    %rbx,%rcx
  204709:	jbe    204a5d <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x5ed>
  20470f:	mov    %ebx,%r8d
  204712:	shl    $0x4,%r8d
  204716:	mov    (%rdx,%r8,1),%r15
  20471a:	mov    -0x10(%r9),%r13
  20471e:	lea    0x8(%r15),%rbp
  204722:	cmp    0x8(%rdx,%r8,1),%rbp
  204727:	mov    %r13,(%r15)
  20472a:	mov    %rbp,(%rdx,%r8,1)
  20472e:	jne    2047ae <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x33e>
  204730:	cmp    %rsi,%rax
  204733:	jae    204a70 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x600>
  204739:	mov    0x28(%rsp),%r15
  20473e:	mov    (%r15,%rax,4),%r15d
  204742:	cmp    %r15,%rsi
  204745:	jbe    204a44 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x5d4>
  20474b:	add    %rdx,%r8
  20474e:	cmp    %r15,%r12
  204751:	mov    $0x0,%r13d
  204757:	cmovbe %r12,%r13
  20475b:	mov    0x18(%rsp),%rbp
  204760:	cmova  0x20(%rsp),%rbp
  204766:	sub    %r13,%r15
  204769:	imul   %r14,%r15
  20476d:	lea    0x0(,%r15,8),%r15
  204775:	add    %rbp,%r15
  204778:	lea    (%r15,%r14,8),%r13
  20477c:	mov    %r15,(%r8)
  20477f:	mov    %r13,0x8(%r8)
  204783:	cmp    0x8(%rsp),%rax
  204788:	jae    204a80 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x610>
  20478e:	mov    0x30(%rsp),%r8
  204793:	mov    %r10b,(%r8,%rax,1)
  204797:	cmp    %rbx,0x10(%rsp)
  20479c:	jbe    204a95 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x625>
  2047a2:	mov    0x38(%rsp),%r8
  2047a7:	incq   (%r8,%rbx,8)
  2047ab:	inc    %rax
  2047ae:	mov    (%r11),%r8
  2047b1:	movzbl (%r8),%r10d
  2047b5:	shrx   %r10d,-0x8(%r9),%r10d
  2047bb:	and    0x8(%r8),%r10d
  2047bf:	shr    $0x10,%r10d
  2047c3:	movzbl %r10b,%ebx
  2047c7:	cmp    %rbx,%rcx
  2047ca:	jbe    204a5d <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x5ed>
  2047d0:	mov    %ebx,%r8d
  2047d3:	shl    $0x4,%r8d
  2047d7:	mov    (%rdx,%r8,1),%r15
  2047db:	mov    -0x8(%r9),%r13
  2047df:	lea    0x8(%r15),%rbp
  2047e3:	cmp    0x8(%rdx,%r8,1),%rbp
  2047e8:	mov    %r13,(%r15)
  2047eb:	mov    %rbp,(%rdx,%r8,1)
  2047ef:	jne    20486f <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x3ff>
  2047f1:	cmp    %rsi,%rax
  2047f4:	jae    204a70 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x600>
  2047fa:	mov    0x28(%rsp),%r15
  2047ff:	mov    (%r15,%rax,4),%r15d
  204803:	cmp    %r15,%rsi
  204806:	jbe    204a44 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x5d4>
  20480c:	add    %rdx,%r8
  20480f:	cmp    %r15,%r12
  204812:	mov    $0x0,%r13d
  204818:	cmovbe %r12,%r13
  20481c:	mov    0x18(%rsp),%rbp
  204821:	cmova  0x20(%rsp),%rbp
  204827:	sub    %r13,%r15
  20482a:	imul   %r14,%r15
  20482e:	lea    0x0(,%r15,8),%r15
  204836:	add    %rbp,%r15
  204839:	lea    (%r15,%r14,8),%r13
  20483d:	mov    %r15,(%r8)
  204840:	mov    %r13,0x8(%r8)
  204844:	cmp    0x8(%rsp),%rax
  204849:	jae    204a80 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x610>
  20484f:	mov    0x30(%rsp),%r8
  204854:	mov    %r10b,(%r8,%rax,1)
  204858:	cmp    %rbx,0x10(%rsp)
  20485d:	jbe    204a95 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x625>
  204863:	mov    0x38(%rsp),%r8
  204868:	incq   (%r8,%rbx,8)
  20486c:	inc    %rax
  20486f:	mov    (%r11),%r8
  204872:	movzbl (%r8),%r10d
  204876:	shrx   %r10d,(%r9),%r10d
  20487b:	and    0x8(%r8),%r10d
  20487f:	shr    $0x10,%r10d
  204883:	movzbl %r10b,%ebx
  204887:	cmp    %rbx,%rcx
  20488a:	jbe    204a5d <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x5ed>
  204890:	mov    %ebx,%r8d
  204893:	shl    $0x4,%r8d
  204897:	mov    (%rdx,%r8,1),%r15
  20489b:	mov    (%r9),%r13
  20489e:	lea    0x8(%r15),%rbp
  2048a2:	cmp    0x8(%rdx,%r8,1),%rbp
  2048a7:	mov    %r13,(%r15)
  2048aa:	mov    %rbp,(%rdx,%r8,1)
  2048ae:	jne    20461c <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x1ac>
  2048b4:	cmp    %rsi,%rax
  2048b7:	jae    204a70 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x600>
  2048bd:	mov    0x28(%rsp),%r15
  2048c2:	mov    (%r15,%rax,4),%r15d
  2048c6:	cmp    %r15,%rsi
  2048c9:	jbe    204a44 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x5d4>
  2048cf:	add    %rdx,%r8
  2048d2:	cmp    %r15,%r12
  2048d5:	mov    $0x0,%r13d
  2048db:	cmovbe %r12,%r13
  2048df:	mov    0x18(%rsp),%rbp
  2048e4:	cmova  0x20(%rsp),%rbp
  2048ea:	sub    %r13,%r15
  2048ed:	imul   %r14,%r15
  2048f1:	lea    0x0(,%r15,8),%r15
  2048f9:	add    %rbp,%r15
  2048fc:	lea    (%r15,%r14,8),%r13
  204900:	mov    %r15,(%r8)
  204903:	mov    %r13,0x8(%r8)
  204907:	cmp    0x8(%rsp),%rax
  20490c:	jae    204a80 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x610>
  204912:	mov    0x30(%rsp),%r8
  204917:	mov    %r10b,(%r8,%rax,1)
  20491b:	cmp    %rbx,0x10(%rsp)
  204920:	ja     204610 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x1a0>
  204926:	jmp    204a95 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x625>
  20492b:	nopl   0x0(%rax,%rax,1)
  204930:	mov    0x40(%rsp),%r8
  204935:	mov    %r8,%rdi
  204938:	and    $0xfffffffffffffffc,%rdi
  20493c:	cmp    %r8,%rdi
  20493f:	je     204520 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0xb0>
  204945:	mov    0x78(%rsp),%r8
  20494a:	imul   %r14,%r8
  20494e:	mov    0x50(%rsp),%r9
  204953:	lea    (%r9,%r8,8),%r9
  204957:	jmp    204971 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x501>
  204959:	nopl   0x0(%rax)
  204960:	mov    0x40(%rsp),%r8
  204965:	inc    %rdi
  204968:	cmp    %r8,%rdi
  20496b:	jae    204520 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0xb0>
  204971:	mov    (%r11),%r8
  204974:	movzbl (%r8),%r10d
  204978:	shrx   %r10d,(%r9,%rdi,8),%r10d
  20497e:	and    0x8(%r8),%r10d
  204982:	shr    $0x10,%r10d
  204986:	movzbl %r10b,%r8d
  20498a:	cmp    %r8,%rcx
  20498d:	jbe    204aaa <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x63a>
  204993:	mov    %r8d,%ebx
  204996:	shl    $0x4,%ebx
  204999:	mov    (%rdx,%rbx,1),%r15
  20499d:	mov    (%r9,%rdi,8),%r13
  2049a1:	lea    0x8(%r15),%rbp
  2049a5:	cmp    0x8(%rdx,%rbx,1),%rbp
  2049aa:	mov    %r13,(%r15)
  2049ad:	mov    %rbp,(%rdx,%rbx,1)
  2049b1:	jne    204960 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x4f0>
  2049b3:	cmp    %rsi,%rax
  2049b6:	jae    204abd <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x64d>
  2049bc:	mov    0x28(%rsp),%r15
  2049c1:	mov    (%r15,%rax,4),%r15d
  2049c5:	cmp    %r15,%rsi
  2049c8:	jbe    204a44 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x5d4>
  2049ca:	add    %rdx,%rbx
  2049cd:	cmp    %r15,%r12
  2049d0:	mov    $0x0,%r13d
  2049d6:	cmovbe %r12,%r13
  2049da:	mov    0x18(%rsp),%rbp
  2049df:	cmova  0x20(%rsp),%rbp
  2049e5:	sub    %r13,%r15
  2049e8:	imul   %r14,%r15
  2049ec:	lea    0x0(,%r15,8),%r15
  2049f4:	add    %rbp,%r15
  2049f7:	lea    (%r15,%r14,8),%r13
  2049fb:	mov    %r15,(%rbx)
  2049fe:	mov    %r13,0x8(%rbx)
  204a02:	cmp    0x8(%rsp),%rax
  204a07:	jae    204acd <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x65d>
  204a0d:	mov    0x30(%rsp),%rbx
  204a12:	mov    %r10b,(%rbx,%rax,1)
  204a16:	cmp    %r8,0x10(%rsp)
  204a1b:	jbe    204ae2 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x672>
  204a21:	mov    0x38(%rsp),%r10
  204a26:	incq   (%r10,%r8,8)
  204a2a:	inc    %rax
  204a2d:	jmp    204960 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 2>+0x4f0>
  204a32:	add    $0x88,%rsp
  204a39:	pop    %rbx
  204a3a:	pop    %r12
  204a3c:	pop    %r13
  204a3e:	pop    %r14
  204a40:	pop    %r15
  204a42:	pop    %rbp
  204a43:	ret
  204a44:	lea    -0x1eea1b(%rip),%rdi        # 16030 <anon.7fa33eb33931318ee6b6568b4abff869.3.llvm.17153750559840045314+0xf3>
  204a4b:	lea    0x1d9d56(%rip),%rdx        # 3de7a8 <anon.7fa33eb33931318ee6b6568b4abff869.4.llvm.17153750559840045314+0x3b8>
  204a52:	mov    $0x2c,%esi
  204a57:	call   *0x1dcb2b(%rip)        # 3e1588 <_DYNAMIC+0x2f0>
  204a5d:	lea    0x1d99d4(%rip),%rdx        # 3de438 <anon.7fa33eb33931318ee6b6568b4abff869.4.llvm.17153750559840045314+0x48>
  204a64:	mov    %rbx,%rdi
  204a67:	mov    %rcx,%rsi
  204a6a:	call   *0x1dcaa8(%rip)        # 3e1518 <_DYNAMIC+0x280>
  204a70:	lea    0x1d99c1(%rip),%rdx        # 3de438 <anon.7fa33eb33931318ee6b6568b4abff869.4.llvm.17153750559840045314+0x48>
  204a77:	mov    %rax,%rdi
  204a7a:	call   *0x1dca98(%rip)        # 3e1518 <_DYNAMIC+0x280>
  204a80:	lea    0x1d99b1(%rip),%rdx        # 3de438 <anon.7fa33eb33931318ee6b6568b4abff869.4.llvm.17153750559840045314+0x48>
  204a87:	mov    %rax,%rdi
  204a8a:	mov    0x8(%rsp),%rsi
  204a8f:	call   *0x1dca83(%rip)        # 3e1518 <_DYNAMIC+0x280>
  204a95:	lea    0x1d999c(%rip),%rdx        # 3de438 <anon.7fa33eb33931318ee6b6568b4abff869.4.llvm.17153750559840045314+0x48>
  204a9c:	mov    %rbx,%rdi
  204a9f:	mov    0x10(%rsp),%rsi
  204aa4:	call   *0x1dca6e(%rip)        # 3e1518 <_DYNAMIC+0x280>
  204aaa:	lea    0x1d996f(%rip),%rdx        # 3de420 <anon.7fa33eb33931318ee6b6568b4abff869.4.llvm.17153750559840045314+0x30>
  204ab1:	mov    %r8,%rdi
  204ab4:	mov    %rcx,%rsi
  204ab7:	call   *0x1dca5b(%rip)        # 3e1518 <_DYNAMIC+0x280>
  204abd:	lea    0x1d995c(%rip),%rdx        # 3de420 <anon.7fa33eb33931318ee6b6568b4abff869.4.llvm.17153750559840045314+0x30>
  204ac4:	mov    %rax,%rdi
  204ac7:	call   *0x1dca4b(%rip)        # 3e1518 <_DYNAMIC+0x280>
  204acd:	lea    0x1d994c(%rip),%rdx        # 3de420 <anon.7fa33eb33931318ee6b6568b4abff869.4.llvm.17153750559840045314+0x30>
  204ad4:	mov    %rax,%rdi
  204ad7:	mov    0x8(%rsp),%rsi
  204adc:	call   *0x1dca36(%rip)        # 3e1518 <_DYNAMIC+0x280>
  204ae2:	lea    0x1d9937(%rip),%rdx        # 3de420 <anon.7fa33eb33931318ee6b6568b4abff869.4.llvm.17153750559840045314+0x30>
  204ae9:	mov    %r8,%rdi
  204aec:	mov    0x10(%rsp),%rsi
  204af1:	call   *0x1dca21(%rip)        # 3e1518 <_DYNAMIC+0x280>
  204af7:	lea    0x1d990a(%rip),%rdx        # 3de408 <anon.7fa33eb33931318ee6b6568b4abff869.4.llvm.17153750559840045314+0x18>
  204afe:	mov    0x48(%rsp),%rdi
  204b03:	call   *0x1dca0f(%rip)        # 3e1518 <_DYNAMIC+0x280>
