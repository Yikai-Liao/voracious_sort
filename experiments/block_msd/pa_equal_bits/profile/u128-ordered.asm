
experiments/block_msd/target/pa-equal-bits/time:     file format elf64-x86-64


Disassembly of section .text:

00000000000ec430 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>>:
   ec430:	push   %rbp
   ec431:	push   %r15
   ec433:	push   %r14
   ec435:	push   %r13
   ec437:	push   %r12
   ec439:	push   %rbx
   ec43a:	sub    $0x48,%rsp
   ec43e:	mov    $0x1,%r8b
   ec441:	cmp    $0x2,%rsi
   ec445:	jb     ece79 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0xa49>
   ec44b:	mov    (%rdi),%rdx
   ec44e:	mov    %rdi,(%rsp)
   ec452:	mov    0x8(%rdi),%rcx
   ec456:	lea    -0x1(%rsi),%r9
   ec45a:	movabs $0x7ffffffffffff80,%r10
   ec464:	and    %r9,%r10
   ec467:	je     ec604 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x1d4>
   ec46d:	mov    (%rsp),%rax
   ec471:	lea    0x10(%rax),%r11
   ec475:	lea    -0x80(%r10),%rbx
   ec479:	shr    $0x7,%rbx
   ec47d:	xor    %r8d,%r8d
   ec480:	jmp    ec4a4 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x74>
   ec482:	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   ec490:	add    $0x800,%r11
   ec497:	cmp    %rbx,%r8
   ec49a:	lea    0x1(%r8),%r8
   ec49e:	je     ec604 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x1d4>
   ec4a4:	xor    %r15d,%r15d
   ec4a7:	xor    %eax,%eax
   ec4a9:	xor    %r14d,%r14d
   ec4ac:	nopl   0x0(%rax)
   ec4b0:	mov    (%r11,%r14,1),%rdi
   ec4b4:	xor    %rdx,%rdi
   ec4b7:	or     %r15,%rdi
   ec4ba:	mov    0x8(%r11,%r14,1),%r15
   ec4bf:	xor    %rcx,%r15
   ec4c2:	or     %rax,%r15
   ec4c5:	mov    0x18(%r11,%r14,1),%r12
   ec4ca:	xor    %rcx,%r12
   ec4cd:	mov    0x10(%r11,%r14,1),%r13
   ec4d2:	xor    %rdx,%r13
   ec4d5:	mov    0x20(%r11,%r14,1),%rax
   ec4da:	xor    %rdx,%rax
   ec4dd:	or     %r13,%rax
   ec4e0:	or     %rdi,%rax
   ec4e3:	mov    0x28(%r11,%r14,1),%r13
   ec4e8:	xor    %rcx,%r13
   ec4eb:	or     %r12,%r13
   ec4ee:	or     %r15,%r13
   ec4f1:	mov    0x38(%r11,%r14,1),%rdi
   ec4f6:	xor    %rcx,%rdi
   ec4f9:	mov    0x30(%r11,%r14,1),%r15
   ec4fe:	xor    %rdx,%r15
   ec501:	mov    0x40(%r11,%r14,1),%rbp
   ec506:	xor    %rdx,%rbp
   ec509:	or     %r15,%rbp
   ec50c:	mov    0x48(%r11,%r14,1),%r15
   ec511:	xor    %rcx,%r15
   ec514:	or     %rdi,%r15
   ec517:	mov    0x58(%r11,%r14,1),%rdi
   ec51c:	xor    %rcx,%rdi
   ec51f:	or     %r15,%rdi
   ec522:	or     %r13,%rdi
   ec525:	mov    0x50(%r11,%r14,1),%r12
   ec52a:	xor    %rdx,%r12
   ec52d:	or     %rbp,%r12
   ec530:	or     %rax,%r12
   ec533:	mov    0x60(%r11,%r14,1),%r13
   ec538:	xor    %rdx,%r13
   ec53b:	mov    0x68(%r11,%r14,1),%rbp
   ec540:	xor    %rcx,%rbp
   ec543:	mov    0x78(%r11,%r14,1),%rax
   ec548:	mov    0x70(%r11,%r14,1),%r15
   ec54d:	add    $0x80,%r14
   ec554:	xor    %rcx,%rax
   ec557:	or     %rbp,%rax
   ec55a:	or     %rdi,%rax
   ec55d:	xor    %rdx,%r15
   ec560:	or     %r13,%r15
   ec563:	or     %r12,%r15
   ec566:	cmp    $0x800,%r14
   ec56d:	jne    ec4b0 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x80>
   ec573:	or     %rax,%r15
   ec576:	je     ec490 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x60>
   ec57c:	xor    %eax,%eax
   ec57e:	xor    %r12d,%r12d
   ec581:	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   ec590:	mov    (%r11,%rax,1),%r14
   ec594:	mov    0x8(%r11,%rax,1),%r15
   ec599:	mov    %r15,%rdi
   ec59c:	xor    %rcx,%rdi
   ec59f:	mov    %r14,%r13
   ec5a2:	xor    %rdx,%r13
   ec5a5:	or     %rdi,%r13
   ec5a8:	jne    ec872 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x442>
   ec5ae:	mov    0x10(%r11,%rax,1),%r14
   ec5b3:	mov    0x18(%r11,%rax,1),%r15
   ec5b8:	mov    %r15,%rdi
   ec5bb:	xor    %rcx,%rdi
   ec5be:	mov    %r14,%r13
   ec5c1:	xor    %rdx,%r13
   ec5c4:	or     %rdi,%r13
   ec5c7:	jne    ec86f <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x43f>
   ec5cd:	cmp    $0x7e0,%rax
   ec5d3:	je     ec490 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x60>
   ec5d9:	mov    0x20(%r11,%rax,1),%r14
   ec5de:	mov    0x28(%r11,%rax,1),%r15
   ec5e3:	add    $0x30,%rax
   ec5e7:	add    $0x3,%r12
   ec5eb:	mov    %r15,%rdi
   ec5ee:	xor    %rcx,%rdi
   ec5f1:	mov    %r14,%r13
   ec5f4:	xor    %rdx,%r13
   ec5f7:	or     %rdi,%r13
   ec5fa:	je     ec590 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x160>
   ec5fc:	dec    %r12
   ec5ff:	jmp    ec872 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x442>
   ec604:	shl    $0x4,%r10
   ec608:	mov    (%rsp),%rax
   ec60c:	add    %r10,%rax
   ec60f:	add    $0x10,%rax
   ec613:	and    $0x7f,%r9d
   ec617:	mov    %r9d,%edi
   ec61a:	shl    $0x4,%edi
   ec61d:	not    %r9
   ec620:	add    %rsi,%r9
   ec623:	xor    %r8d,%r8d
   ec626:	cs nopw 0x0(%rax,%rax,1)
   ec630:	cmp    %r8,%rdi
   ec633:	je     ece76 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0xa46>
   ec639:	mov    (%rax,%r8,1),%r14
   ec63d:	mov    0x8(%rax,%r8,1),%r15
   ec642:	mov    %r15,%r10
   ec645:	xor    %rcx,%r10
   ec648:	mov    %r14,%r11
   ec64b:	xor    %rdx,%r11
   ec64e:	add    $0x10,%r8
   ec652:	inc    %r9
   ec655:	or     %r10,%r11
   ec658:	je     ec630 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x200>
   ec65a:	cmp    %rdx,%r14
   ec65d:	mov    %rsi,%rax
   ec660:	sbb    %rcx,%r15
   ec663:	jae    ec88c <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x45c>
   ec669:	sub    %r9,%rax
   ec66c:	jb     ece9e <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0xa6e>
   ec672:	mov    %rsi,%rcx
   ec675:	lea    -0x1(%rax),%rsi
   ec679:	mov    %rcx,0x8(%rsp)
   ec67e:	mov    %rcx,%rax
   ec681:	sub    %r9,%rax
   ec684:	je     ecec4 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0xa94>
   ec68a:	mov    %r9,%rdx
   ec68d:	shl    $0x4,%rdx
   ec691:	mov    (%rsp),%rcx
   ec695:	lea    (%rcx,%rdx,1),%rdi
   ec699:	mov    %rdi,0x28(%rsp)
   ec69e:	mov    %rsi,%rdi
   ec6a1:	and    $0xffffffffffffff80,%rdi
   ec6a5:	mov    %rdi,0x40(%rsp)
   ec6aa:	mov    %rax,0x18(%rsp)
   ec6af:	mov    %rax,0x20(%rsp)
   ec6b4:	shr    $0x7,%rsi
   ec6b8:	mov    $0x34,%al
   ec6ba:	mov    %rsi,0x38(%rsp)
   ec6bf:	bzhi   %rax,%rsi,%rax
   ec6c4:	mov    %rax,0x10(%rsp)
   ec6c9:	mov    %rdx,0x30(%rsp)
   ec6ce:	lea    (%rdx,%rcx,1),%r12
   ec6d2:	add    $0x30,%r12
   ec6d6:	xor    %r13d,%r13d
   ec6d9:	xor    %ebx,%ebx
   ec6db:	nopl   0x0(%rax,%rax,1)
   ec6e0:	cmp    0x10(%rsp),%r13
   ec6e5:	je     eca67 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x637>
   ec6eb:	kmovd  %ebx,%k0
   ec6ef:	kshiftlb $0x7,%k0,%k0
   ec6f5:	kshiftrb $0x7,%k0,%k0
   ec6fb:	kxnorw %k0,%k0,%k2
   ec6ff:	kxorw  %k0,%k0,%k1
   ec703:	xor    %ebx,%ebx
   ec705:	kxnorw %k0,%k0,%k3
   ec709:	nopl   0x0(%rax)
   ec710:	mov    -0x30(%r12,%rbx,1),%r15
   ec715:	mov    -0x28(%r12,%rbx,1),%rsi
   ec71a:	mov    -0x10(%r12,%rbx,1),%rbp
   ec71f:	mov    -0x8(%r12,%rbx,1),%r14
   ec724:	mov    -0x18(%r12,%rbx,1),%rcx
   ec729:	mov    -0x20(%r12,%rbx,1),%rax
   ec72e:	mov    0x18(%r12,%rbx,1),%r8
   ec733:	mov    0x8(%r12,%rbx,1),%r10
   ec738:	mov    0x10(%r12,%rbx,1),%r11
   ec73d:	mov    (%r12,%rbx,1),%rdx
   ec741:	cmp    %rbp,%rax
   ec744:	mov    %rcx,%rdi
   ec747:	sbb    %r14,%rdi
   ec74a:	setae  %dil
   ec74e:	kmovd  %edi,%k4
   ec752:	kshiftlb $0x1,%k4,%k4
   ec758:	cmp    %rax,%r15
   ec75b:	mov    %rsi,%rdi
   ec75e:	sbb    %rcx,%rdi
   ec761:	setae  %dil
   ec765:	kmovd  %edi,%k5
   ec769:	kshiftlb $0x7,%k5,%k5
   ec76f:	kshiftrb $0x7,%k5,%k5
   ec775:	korw   %k4,%k5,%k4
   ec779:	cmp    %r11,%rdx
   ec77c:	mov    %r10,%rdi
   ec77f:	sbb    %r8,%rdi
   ec782:	setae  %dil
   ec786:	kmovd  %edi,%k5
   ec78a:	kshiftlb $0x1,%k5,%k5
   ec790:	cmp    %rdx,%rbp
   ec793:	mov    %r14,%rdi
   ec796:	sbb    %r10,%rdi
   ec799:	setae  %dil
   ec79d:	kmovd  %edi,%k6
   ec7a1:	kshiftlb $0x7,%k6,%k6
   ec7a7:	kshiftrb $0x7,%k6,%k6
   ec7ad:	korw   %k5,%k6,%k5
   ec7b1:	kandw  %k4,%k2,%k2
   ec7b5:	kandw  %k5,%k3,%k3
   ec7b9:	xor    %rcx,%rsi
   ec7bc:	xor    %r14,%rcx
   ec7bf:	xor    %rax,%r15
   ec7c2:	xor    %rbp,%rax
   ec7c5:	or     %rcx,%rax
   ec7c8:	sete   %al
   ec7cb:	kmovd  %eax,%k4
   ec7cf:	kshiftlb $0x1,%k4,%k4
   ec7d5:	or     %rsi,%r15
   ec7d8:	sete   %al
   ec7db:	kmovd  %eax,%k5
   ec7df:	kshiftlb $0x7,%k5,%k5
   ec7e5:	kshiftrb $0x7,%k5,%k5
   ec7eb:	korw   %k4,%k5,%k4
   ec7ef:	xor    %r10,%r8
   ec7f2:	xor    %rdx,%r11
   ec7f5:	or     %r8,%r11
   ec7f8:	sete   %al
   ec7fb:	kmovd  %eax,%k5
   ec7ff:	kshiftlb $0x1,%k5,%k5
   ec805:	xor    %r10,%r14
   ec808:	xor    %rdx,%rbp
   ec80b:	or     %r14,%rbp
   ec80e:	sete   %al
   ec811:	kmovd  %eax,%k6
   ec815:	kshiftlb $0x7,%k6,%k6
   ec81b:	kshiftrb $0x7,%k6,%k6
   ec821:	korw   %k5,%k6,%k5
   ec825:	korw   %k4,%k0,%k0
   ec829:	korw   %k5,%k1,%k1
   ec82d:	add    $0x40,%rbx
   ec831:	cmp    $0x800,%rbx
   ec838:	jne    ec710 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x2e0>
   ec83e:	kandw  %k2,%k3,%k2
   ec842:	knotw  %k2,%k2
   ec846:	kmovd  %k2,%eax
   ec84a:	korw   %k0,%k1,%k0
   ec84e:	kmovd  %k0,%ecx
   ec852:	test   $0x3,%cl
   ec855:	setne  %bl
   ec858:	inc    %r13
   ec85b:	add    $0x800,%r12
   ec862:	test   $0x3,%al
   ec864:	je     ec6e0 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x2b0>
   ec86a:	jmp    eca5f <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x62f>
   ec86f:	inc    %r12
   ec872:	shl    $0x7,%r8
   ec876:	lea    (%r12,%r8,1),%r9
   ec87a:	inc    %r9
   ec87d:	cmp    %rdx,%r14
   ec880:	mov    %rsi,%rax
   ec883:	sbb    %rcx,%r15
   ec886:	jb     ec669 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x239>
   ec88c:	sub    %r9,%rax
   ec88f:	jb     eceb1 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0xa81>
   ec895:	dec    %rax
   ec898:	sub    %r9,%rsi
   ec89b:	je     eced5 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0xaa5>
   ec8a1:	mov    %rax,%rcx
   ec8a4:	and    $0xffffffffffffff80,%rcx
   ec8a8:	mov    %rcx,0x8(%rsp)
   ec8ad:	shr    $0x7,%rax
   ec8b1:	mov    $0x34,%cl
   ec8b3:	mov    %rax,0x18(%rsp)
   ec8b8:	bzhi   %rcx,%rax,%rax
   ec8bd:	mov    %rax,0x10(%rsp)
   ec8c2:	shl    $0x4,%r9
   ec8c6:	mov    (%rsp),%rax
   ec8ca:	lea    (%r9,%rax,1),%r8
   ec8ce:	add    $0x70,%r8
   ec8d2:	xor    %r10d,%r10d
   ec8d5:	data16 cs nopw 0x0(%rax,%rax,1)
   ec8e0:	cmp    0x10(%rsp),%r10
   ec8e5:	je     eca8a <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x65a>
   ec8eb:	kxnorw %k0,%k0,%k0
   ec8ef:	xor    %r11d,%r11d
   ec8f2:	kxnorw %k0,%k0,%k1
   ec8f6:	cs nopw 0x0(%rax,%rax,1)
   ec900:	mov    -0x50(%r8,%r11,1),%r15
   ec905:	mov    -0x48(%r8,%r11,1),%r14
   ec90a:	mov    -0x60(%r8,%r11,1),%rdi
   ec90f:	mov    -0x58(%r8,%r11,1),%rbx
   ec914:	mov    -0x38(%r8,%r11,1),%r12
   ec919:	mov    -0x40(%r8,%r11,1),%r13
   ec91e:	cmp    %rdi,%r15
   ec921:	mov    %r14,%rbp
   ec924:	sbb    %rbx,%rbp
   ec927:	setae  %bpl
   ec92b:	kmovd  %ebp,%k2
   ec92f:	kshiftlb $0x1,%k2,%k2
   ec935:	cmp    -0x70(%r8,%r11,1),%rdi
   ec93a:	sbb    -0x68(%r8,%r11,1),%rbx
   ec93f:	setae  %dil
   ec943:	kmovd  %edi,%k3
   ec947:	kshiftlb $0x7,%k3,%k3
   ec94d:	kshiftrb $0x7,%k3,%k3
   ec953:	korw   %k2,%k3,%k2
   ec957:	mov    -0x30(%r8,%r11,1),%rdi
   ec95c:	cmp    %r13,%rdi
   ec95f:	mov    -0x28(%r8,%r11,1),%rbx
   ec964:	mov    %rbx,%rbp
   ec967:	sbb    %r12,%rbp
   ec96a:	setae  %bpl
   ec96e:	kmovd  %ebp,%k3
   ec972:	kshiftlb $0x1,%k3,%k3
   ec978:	cmp    %r15,%r13
   ec97b:	sbb    %r14,%r12
   ec97e:	setae  %bpl
   ec982:	kmovd  %ebp,%k4
   ec986:	kshiftlb $0x7,%k4,%k4
   ec98c:	kshiftrb $0x7,%k4,%k4
   ec992:	korw   %k3,%k4,%k3
   ec996:	kandw  %k2,%k0,%k0
   ec99a:	kandw  %k3,%k1,%k1
   ec99e:	mov    -0x10(%r8,%r11,1),%r14
   ec9a3:	mov    -0x18(%r8,%r11,1),%r13
   ec9a8:	mov    -0x8(%r8,%r11,1),%rcx
   ec9ad:	mov    -0x20(%r8,%r11,1),%rbp
   ec9b2:	mov    0x8(%r8,%r11,1),%r12
   ec9b7:	mov    0x18(%r8,%r11,1),%rdx
   ec9bc:	mov    (%r8,%r11,1),%rax
   ec9c0:	cmp    %rbp,%r14
   ec9c3:	mov    %rcx,%r15
   ec9c6:	sbb    %r13,%r15
   ec9c9:	setae  %r15b
   ec9cd:	kmovd  %r15d,%k2
   ec9d2:	kshiftlb $0x1,%k2,%k2
   ec9d8:	cmp    %rdi,%rbp
   ec9db:	sbb    %rbx,%r13
   ec9de:	setae  %dil
   ec9e2:	kmovd  %edi,%k3
   ec9e6:	kshiftlb $0x7,%k3,%k3
   ec9ec:	kshiftrb $0x7,%k3,%k3
   ec9f2:	korw   %k2,%k3,%k2
   ec9f6:	cmp    %rax,0x10(%r8,%r11,1)
   ec9fb:	sbb    %r12,%rdx
   ec9fe:	setae  %dl
   eca01:	kmovd  %edx,%k3
   eca05:	kshiftlb $0x1,%k3,%k3
   eca0b:	cmp    %r14,%rax
   eca0e:	sbb    %rcx,%r12
   eca11:	setae  %al
   eca14:	kmovd  %eax,%k4
   eca18:	kshiftlb $0x7,%k4,%k4
   eca1e:	kshiftrb $0x7,%k4,%k4
   eca24:	korw   %k3,%k4,%k3
   eca28:	kandw  %k2,%k0,%k0
   eca2c:	kandw  %k3,%k1,%k1
   eca30:	sub    $0xffffffffffffff80,%r11
   eca34:	cmp    $0x800,%r11
   eca3b:	jne    ec900 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x4d0>
   eca41:	kandw  %k0,%k1,%k0
   eca45:	knotw  %k0,%k0
   eca49:	kmovd  %k0,%eax
   eca4d:	inc    %r10
   eca50:	add    $0x800,%r8
   eca57:	test   $0x3,%al
   eca59:	je     ec8e0 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x4b0>
   eca5f:	xor    %r8d,%r8d
   eca62:	jmp    ece79 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0xa49>
   eca67:	mov    0x18(%rsp),%r11
   eca6c:	mov    0x40(%rsp),%rdi
   eca71:	sub    %rdi,%r11
   eca74:	jb     ecee9 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0xab9>
   eca7a:	cmp    $0x2,%r11
   eca7e:	jae    ecaeb <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x6bb>
   eca80:	mov    0x8(%rsp),%r8
   eca85:	jmp    ecb57 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x727>
   eca8a:	mov    0x8(%rsp),%rdi
   eca8f:	cmp    %rsi,%rdi
   eca92:	ja     ecefe <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0xace>
   eca98:	mov    0x18(%rsp),%rcx
   eca9d:	shl    $0xb,%rcx
   ecaa1:	add    %r9,%rcx
   ecaa4:	mov    (%rsp),%rax
   ecaa8:	add    %rcx,%rax
   ecaab:	add    $0x10,%rax
   ecaaf:	sub    %rdi,%rsi
   ecab2:	inc    %rsi
   ecab5:	data16 cs nopw 0x0(%rax,%rax,1)
   ecac0:	dec    %rsi
   ecac3:	cmp    $0x2,%rsi
   ecac7:	setb   %r8b
   ecacb:	jb     ece79 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0xa49>
   ecad1:	mov    (%rax),%rcx
   ecad4:	mov    0x8(%rax),%rdx
   ecad8:	cmp    -0x10(%rax),%rcx
   ecadc:	sbb    -0x8(%rax),%rdx
   ecae0:	lea    0x10(%rax),%rax
   ecae4:	jae    ecac0 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x690>
   ecae6:	jmp    ece79 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0xa49>
   ecaeb:	shl    $0x4,%rdi
   ecaef:	mov    0x28(%rsp),%rax
   ecaf4:	mov    (%rax,%rdi,1),%rdx
   ecaf8:	mov    0x8(%rax,%rdi,1),%rsi
   ecafd:	inc    %r11
   ecb00:	mov    0x38(%rsp),%rcx
   ecb05:	shl    $0xb,%rcx
   ecb09:	add    0x30(%rsp),%rcx
   ecb0e:	mov    (%rsp),%rax
   ecb12:	add    %rcx,%rax
   ecb15:	add    $0x10,%rax
   ecb19:	mov    0x8(%rsp),%r8
   ecb1e:	xchg   %ax,%ax
   ecb20:	mov    (%rax),%rdi
   ecb23:	mov    0x8(%rax),%r10
   ecb27:	cmp    %rdi,%rdx
   ecb2a:	mov    %rsi,%rcx
   ecb2d:	sbb    %r10,%rcx
   ecb30:	jb     eca5f <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x62f>
   ecb36:	xor    %rdi,%rdx
   ecb39:	xor    %r10,%rsi
   ecb3c:	or     %rdx,%rsi
   ecb3f:	sete   %cl
   ecb42:	or     %cl,%bl
   ecb44:	dec    %r11
   ecb47:	add    $0x10,%rax
   ecb4b:	mov    %rdi,%rdx
   ecb4e:	mov    %r10,%rsi
   ecb51:	cmp    $0x3,%r11
   ecb55:	jae    ecb20 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x6f0>
   ecb57:	mov    %r8,%rsi
   ecb5a:	shr    $1,%rsi
   ecb5d:	mov    %r8,%rdx
   ecb60:	shl    $0x4,%rdx
   ecb64:	lea    -0x1(%rsi),%rax
   ecb68:	mov    %esi,%ecx
   ecb6a:	and    $0x3,%ecx
   ecb6d:	cmp    $0x3,%rax
   ecb71:	jae    ecb7a <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x74a>
   ecb73:	xor    %edi,%edi
   ecb75:	jmp    ecc4c <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x81c>
   ecb7a:	mov    (%rsp),%rdi
   ecb7e:	lea    (%rdi,%rdx,1),%r10
   ecb82:	movabs $0x3fffffffffffffc,%rax
   ecb8c:	and    %rax,%rsi
   ecb8f:	lea    0x30(%rdi),%rax
   ecb93:	lea    (%rdx,%rdi,1),%r11
   ecb97:	add    $0xfffffffffffffff0,%r11
   ecb9b:	xor    %edi,%edi
   ecb9d:	movabs $0xffffffffffffffe,%r14
   ecba7:	movabs $0xffffffffffffffd,%r15
   ecbb1:	movabs $0xffffffffffffffc,%r12
   ecbbb:	nopl   0x0(%rax,%rax,1)
   ecbc0:	vmovaps -0x30(%rax),%xmm0
   ecbc5:	vmovaps (%r11),%xmm1
   ecbca:	vmovaps %xmm1,-0x30(%rax)
   ecbcf:	vmovaps %xmm0,(%r11)
   ecbd4:	mov    %rdi,%r13
   ecbd7:	xor    %r14,%r13
   ecbda:	shl    $0x4,%r13
   ecbde:	vmovaps -0x20(%rax),%xmm0
   ecbe3:	vmovaps (%r10,%r13,1),%xmm1
   ecbe9:	vmovaps %xmm1,-0x20(%rax)
   ecbee:	vmovaps %xmm0,(%r10,%r13,1)
   ecbf4:	mov    %rdi,%r13
   ecbf7:	xor    %r15,%r13
   ecbfa:	shl    $0x4,%r13
   ecbfe:	vmovaps -0x10(%rax),%xmm0
   ecc03:	vmovaps (%r10,%r13,1),%xmm1
   ecc09:	vmovaps %xmm1,-0x10(%rax)
   ecc0e:	vmovaps %xmm0,(%r10,%r13,1)
   ecc14:	mov    %rdi,%r13
   ecc17:	xor    %r12,%r13
   ecc1a:	shl    $0x4,%r13
   ecc1e:	vmovaps (%rax),%xmm0
   ecc22:	vmovaps (%r10,%r13,1),%xmm1
   ecc28:	vmovaps %xmm1,(%rax)
   ecc2c:	vmovaps %xmm0,(%r10,%r13,1)
   ecc32:	add    $0x4,%rdi
   ecc36:	add    $0x40,%rax
   ecc3a:	add    $0xffffffffffffffc0,%r11
   ecc3e:	cmp    %rdi,%rsi
   ecc41:	jne    ecbc0 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x790>
   ecc47:	test   %rcx,%rcx
   ecc4a:	je     ecc8f <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x85f>
   ecc4c:	shl    $0x4,%rdi
   ecc50:	mov    (%rsp),%rsi
   ecc54:	lea    (%rsi,%rdi,1),%rax
   ecc58:	sub    %rdi,%rdx
   ecc5b:	add    %rsi,%rdx
   ecc5e:	add    $0xfffffffffffffff0,%rdx
   ecc62:	shl    $0x4,%ecx
   ecc65:	xor    %esi,%esi
   ecc67:	nopw   0x0(%rax,%rax,1)
   ecc70:	vmovaps (%rax,%rsi,1),%xmm0
   ecc75:	vmovaps (%rdx),%xmm1
   ecc79:	vmovaps %xmm1,(%rax,%rsi,1)
   ecc7e:	vmovaps %xmm0,(%rdx)
   ecc82:	add    $0x10,%rsi
   ecc86:	add    $0xfffffffffffffff0,%rdx
   ecc8a:	cmp    %rsi,%rcx
   ecc8d:	jne    ecc70 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x840>
   ecc8f:	cmp    $0x2,%r9
   ecc93:	setae  %al
   ecc96:	or     %bl,%al
   ecc98:	test   $0x1,%al
   ecc9a:	je     ece76 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0xa46>
   ecca0:	mov    (%rsp),%r9
   ecca4:	lea    0x10(%r9),%rcx
   ecca8:	lea    0x30(%r9),%rax
   eccac:	mov    %rax,0x8(%rsp)
   eccb1:	lea    -0x10(%r9),%rax
   eccb5:	mov    %rax,0x10(%rsp)
   eccba:	xor    %esi,%esi
   eccbc:	movabs $0xffffffffffffffe,%r11
   eccc6:	movabs $0xffffffffffffffd,%rbx
   eccd0:	movabs $0xffffffffffffffc,%r14
   eccda:	jmp    ecce9 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x8b9>
   eccdc:	nopl   0x0(%rax)
   ecce0:	cmp    %r8,%rsi
   ecce3:	jae    ece76 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0xa46>
   ecce9:	mov    %rsi,%rdx
   eccec:	mov    %rsi,%r15
   eccef:	shl    $0x4,%r15
   eccf3:	mov    (%r9,%r15,1),%rax
   eccf7:	mov    0x8(%r9,%r15,1),%r9
   eccfc:	lea    0x1(%rsi),%rdi
   ecd00:	cmp    %rdi,%r8
   ecd03:	cmova  %r8,%rdi
   ecd07:	lea    -0x1(%rdi),%r12
   ecd0b:	lea    (%rcx,%r15,1),%r13
   ecd0f:	nop
   ecd10:	cmp    %rsi,%r12
   ecd13:	je     ecd40 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x910>
   ecd15:	inc    %rsi
   ecd18:	mov    0x0(%r13),%rbp
   ecd1c:	xor    %rax,%rbp
   ecd1f:	mov    0x8(%r13),%r10
   ecd23:	xor    %r9,%r10
   ecd26:	add    $0x10,%r13
   ecd2a:	or     %rbp,%r10
   ecd2d:	je     ecd10 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x8e0>
   ecd2f:	jmp    ecd43 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x913>
   ecd31:	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   ecd40:	mov    %rdi,%rsi
   ecd43:	mov    %rsi,%rax
   ecd46:	sub    %rdx,%rax
   ecd49:	jb     ece8b <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0xa5b>
   ecd4f:	mov    %rax,%rdi
   ecd52:	shr    $1,%rdi
   ecd55:	mov    (%rsp),%r9
   ecd59:	je     ecce0 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x8b0>
   ecd5b:	mov    %rsi,%rdx
   ecd5e:	shl    $0x4,%rdx
   ecd62:	mov    %edi,%r12d
   ecd65:	and    $0x3,%r12d
   ecd69:	cmp    $0x8,%rax
   ecd6d:	jae    ecd80 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x950>
   ecd6f:	xor    %r13d,%r13d
   ecd72:	jmp    ece36 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0xa06>
   ecd77:	nopw   0x0(%rax,%rax,1)
   ecd80:	lea    (%r9,%rdx,1),%rax
   ecd84:	and    $0xfffffffffffffffc,%rdi
   ecd88:	mov    0x8(%rsp),%r9
   ecd8d:	lea    (%r9,%r15,1),%rbp
   ecd91:	mov    0x10(%rsp),%r9
   ecd96:	add    %rdx,%r9
   ecd99:	xor    %r13d,%r13d
   ecd9c:	nopl   0x0(%rax)
   ecda0:	vmovaps -0x30(%rbp),%xmm0
   ecda5:	vmovaps (%r9),%xmm1
   ecdaa:	vmovaps %xmm1,-0x30(%rbp)
   ecdaf:	vmovaps %xmm0,(%r9)
   ecdb4:	mov    %r13,%r10
   ecdb7:	xor    %r11,%r10
   ecdba:	shl    $0x4,%r10
   ecdbe:	vmovaps -0x20(%rbp),%xmm0
   ecdc3:	vmovaps (%rax,%r10,1),%xmm1
   ecdc9:	vmovaps %xmm1,-0x20(%rbp)
   ecdce:	vmovaps %xmm0,(%rax,%r10,1)
   ecdd4:	mov    %r13,%r10
   ecdd7:	xor    %rbx,%r10
   ecdda:	shl    $0x4,%r10
   ecdde:	vmovaps -0x10(%rbp),%xmm0
   ecde3:	vmovaps (%rax,%r10,1),%xmm1
   ecde9:	vmovaps %xmm1,-0x10(%rbp)
   ecdee:	vmovaps %xmm0,(%rax,%r10,1)
   ecdf4:	mov    %r13,%r10
   ecdf7:	xor    %r14,%r10
   ecdfa:	shl    $0x4,%r10
   ecdfe:	vmovaps 0x0(%rbp),%xmm0
   ece03:	vmovaps (%rax,%r10,1),%xmm1
   ece09:	vmovaps %xmm1,0x0(%rbp)
   ece0e:	vmovaps %xmm0,(%rax,%r10,1)
   ece14:	add    $0x4,%r13
   ece18:	add    $0x40,%rbp
   ece1c:	add    $0xffffffffffffffc0,%r9
   ece20:	cmp    %r13,%rdi
   ece23:	jne    ecda0 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x970>
   ece29:	test   %r12,%r12
   ece2c:	mov    (%rsp),%r9
   ece30:	je     ecce0 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x8b0>
   ece36:	shl    $0x4,%r13
   ece3a:	add    %r9,%r15
   ece3d:	add    %r13,%r15
   ece40:	sub    %r13,%rdx
   ece43:	add    0x10(%rsp),%rdx
   ece48:	shl    $0x4,%r12d
   ece4c:	xor    %eax,%eax
   ece4e:	xchg   %ax,%ax
   ece50:	vmovaps (%r15,%rax,1),%xmm0
   ece56:	vmovaps (%rdx),%xmm1
   ece5a:	vmovaps %xmm1,(%r15,%rax,1)
   ece60:	vmovaps %xmm0,(%rdx)
   ece64:	add    $0x10,%rax
   ece68:	add    $0xfffffffffffffff0,%rdx
   ece6c:	cmp    %rax,%r12
   ece6f:	jne    ece50 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0xa20>
   ece71:	jmp    ecce0 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x8b0>
   ece76:	mov    $0x1,%r8b
   ece79:	mov    %r8d,%eax
   ece7c:	add    $0x48,%rsp
   ece80:	pop    %rbx
   ece81:	pop    %r12
   ece83:	pop    %r13
   ece85:	pop    %r14
   ece87:	pop    %r15
   ece89:	pop    %rbp
   ece8a:	ret
   ece8b:	lea    0x3cb57e(%rip),%rcx        # 4b8410 <anon.005357b6259aec7dbb5efeaf9c6c1e46.1.llvm.5840278210049151275>
   ece92:	mov    %rdx,%rdi
   ece95:	mov    %r8,%rdx
   ece98:	call   *0x3ce1da(%rip)        # 4bb078 <_DYNAMIC+0x298>
   ece9e:	lea    0x3c23d3(%rip),%rcx        # 4af278 <anon.3d84203c20d4cfb8601923c71fa1d189.0.llvm.9770386453263282830+0x48>
   ecea5:	mov    %r9,%rdi
   ecea8:	mov    %rsi,%rdx
   eceab:	call   *0x3ce1c7(%rip)        # 4bb078 <_DYNAMIC+0x298>
   eceb1:	lea    0x3c23a8(%rip),%rcx        # 4af260 <anon.3d84203c20d4cfb8601923c71fa1d189.0.llvm.9770386453263282830+0x30>
   eceb8:	mov    %r9,%rdi
   ecebb:	mov    %rsi,%rdx
   ecebe:	call   *0x3ce1b4(%rip)        # 4bb078 <_DYNAMIC+0x298>
   ecec4:	lea    0x3c23c5(%rip),%rcx        # 4af290 <anon.3d84203c20d4cfb8601923c71fa1d189.0.llvm.9770386453263282830+0x60>
   ececb:	xor    %edi,%edi
   ececd:	xor    %edx,%edx
   ececf:	call   *0x3ce1a3(%rip)        # 4bb078 <_DYNAMIC+0x298>
   eced5:	lea    0x3c23b4(%rip),%rcx        # 4af290 <anon.3d84203c20d4cfb8601923c71fa1d189.0.llvm.9770386453263282830+0x60>
   ecedc:	xor    %edi,%edi
   ecede:	mov    %rax,%rsi
   ecee1:	xor    %edx,%edx
   ecee3:	call   *0x3ce18f(%rip)        # 4bb078 <_DYNAMIC+0x298>
   ecee9:	lea    0x3c23b8(%rip),%rcx        # 4af2a8 <anon.3d84203c20d4cfb8601923c71fa1d189.0.llvm.9770386453263282830+0x78>
   ecef0:	mov    0x20(%rsp),%rdx
   ecef5:	mov    %rdx,%rsi
   ecef8:	call   *0x3ce17a(%rip)        # 4bb078 <_DYNAMIC+0x298>
   ecefe:	lea    0x3c23a3(%rip),%rcx        # 4af2a8 <anon.3d84203c20d4cfb8601923c71fa1d189.0.llvm.9770386453263282830+0x78>
   ecf05:	mov    %rsi,%rdx
   ecf08:	call   *0x3ce16a(%rip)        # 4bb078 <_DYNAMIC+0x298>
