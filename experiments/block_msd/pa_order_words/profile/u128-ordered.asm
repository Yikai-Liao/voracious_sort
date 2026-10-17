
experiments/block_msd/target/pa-order-words/time:     file format elf64-x86-64


Disassembly of section .text:

00000000004641a0 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>>:
  4641a0:	push   %rbp
  4641a1:	push   %r15
  4641a3:	push   %r14
  4641a5:	push   %r13
  4641a7:	push   %r12
  4641a9:	push   %rbx
  4641aa:	sub    $0x68,%rsp
  4641ae:	mov    %rsi,%r10
  4641b1:	mov    $0x1,%sil
  4641b4:	cmp    $0x2,%r10
  4641b8:	jb     464ab9 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x919>
  4641be:	mov    (%rdi),%rdx
  4641c1:	mov    0x8(%rdi),%rcx
  4641c5:	lea    -0x1(%r10),%rax
  4641c9:	movabs $0x7ffffffffffff80,%r8
  4641d3:	mov    %rax,%rbp
  4641d6:	and    %rax,%r8
  4641d9:	mov    %rdi,0x8(%rsp)
  4641de:	je     464384 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x1e4>
  4641e4:	lea    0x10(%rdi),%r11
  4641e8:	lea    -0x80(%r8),%rbx
  4641ec:	shr    $0x7,%rbx
  4641f0:	xor    %esi,%esi
  4641f2:	jmp    464219 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x79>
  4641f4:	data16 data16 cs nopw 0x0(%rax,%rax,1)
  464200:	add    $0x800,%r11
  464207:	cmp    %rbx,%rsi
  46420a:	lea    0x1(%rsi),%rsi
  46420e:	mov    0x8(%rsp),%rdi
  464213:	je     464384 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x1e4>
  464219:	xor    %r9d,%r9d
  46421c:	xor    %eax,%eax
  46421e:	xor    %r14d,%r14d
  464221:	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  464230:	mov    (%r11,%r14,1),%rdi
  464234:	xor    %rdx,%rdi
  464237:	or     %r9,%rdi
  46423a:	mov    0x8(%r11,%r14,1),%r9
  46423f:	xor    %rcx,%r9
  464242:	or     %rax,%r9
  464245:	mov    0x18(%r11,%r14,1),%r15
  46424a:	xor    %rcx,%r15
  46424d:	mov    0x10(%r11,%r14,1),%r12
  464252:	xor    %rdx,%r12
  464255:	mov    0x20(%r11,%r14,1),%rax
  46425a:	xor    %rdx,%rax
  46425d:	or     %r12,%rax
  464260:	or     %rdi,%rax
  464263:	mov    0x28(%r11,%r14,1),%r12
  464268:	xor    %rcx,%r12
  46426b:	or     %r15,%r12
  46426e:	or     %r9,%r12
  464271:	mov    0x38(%r11,%r14,1),%rdi
  464276:	xor    %rcx,%rdi
  464279:	mov    0x30(%r11,%r14,1),%r9
  46427e:	xor    %rdx,%r9
  464281:	mov    0x40(%r11,%r14,1),%r13
  464286:	xor    %rdx,%r13
  464289:	or     %r9,%r13
  46428c:	mov    0x48(%r11,%r14,1),%r9
  464291:	xor    %rcx,%r9
  464294:	or     %rdi,%r9
  464297:	mov    0x58(%r11,%r14,1),%rdi
  46429c:	xor    %rcx,%rdi
  46429f:	or     %r9,%rdi
  4642a2:	or     %r12,%rdi
  4642a5:	mov    0x50(%r11,%r14,1),%r15
  4642aa:	xor    %rdx,%r15
  4642ad:	or     %r13,%r15
  4642b0:	or     %rax,%r15
  4642b3:	mov    0x60(%r11,%r14,1),%r12
  4642b8:	xor    %rdx,%r12
  4642bb:	mov    0x68(%r11,%r14,1),%r13
  4642c0:	xor    %rcx,%r13
  4642c3:	mov    0x78(%r11,%r14,1),%rax
  4642c8:	mov    0x70(%r11,%r14,1),%r9
  4642cd:	add    $0x80,%r14
  4642d4:	xor    %rcx,%rax
  4642d7:	or     %r13,%rax
  4642da:	or     %rdi,%rax
  4642dd:	xor    %rdx,%r9
  4642e0:	or     %r12,%r9
  4642e3:	or     %r15,%r9
  4642e6:	cmp    $0x800,%r14
  4642ed:	jne    464230 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x90>
  4642f3:	or     %rax,%r9
  4642f6:	je     464200 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x60>
  4642fc:	xor    %eax,%eax
  4642fe:	xor    %r12d,%r12d
  464301:	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  464310:	mov    (%r11,%rax,1),%r14
  464314:	mov    0x8(%r11,%rax,1),%r15
  464319:	mov    %r15,%rdi
  46431c:	xor    %rcx,%rdi
  46431f:	mov    %r14,%r9
  464322:	xor    %rdx,%r9
  464325:	or     %rdi,%r9
  464328:	jne    4645ab <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x40b>
  46432e:	mov    0x10(%r11,%rax,1),%r14
  464333:	mov    0x18(%r11,%rax,1),%r15
  464338:	mov    %r15,%rdi
  46433b:	xor    %rcx,%rdi
  46433e:	mov    %r14,%r9
  464341:	xor    %rdx,%r9
  464344:	or     %rdi,%r9
  464347:	jne    4645a8 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x408>
  46434d:	cmp    $0x7e0,%rax
  464353:	je     464200 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x60>
  464359:	mov    0x20(%r11,%rax,1),%r14
  46435e:	mov    0x28(%r11,%rax,1),%r15
  464363:	add    $0x30,%rax
  464367:	add    $0x3,%r12
  46436b:	mov    %r15,%rdi
  46436e:	xor    %rcx,%rdi
  464371:	mov    %r14,%r9
  464374:	xor    %rdx,%r9
  464377:	or     %rdi,%r9
  46437a:	je     464310 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x170>
  46437c:	dec    %r12
  46437f:	jmp    4645ab <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x40b>
  464384:	shl    $0x4,%r8
  464388:	lea    (%rdi,%r8,1),%rax
  46438c:	add    $0x10,%rax
  464390:	mov    %rbp,%r11
  464393:	and    $0x7f,%r11d
  464397:	mov    %r11d,%esi
  46439a:	shl    $0x4,%esi
  46439d:	not    %r11
  4643a0:	add    %r10,%r11
  4643a3:	xor    %edi,%edi
  4643a5:	data16 cs nopw 0x0(%rax,%rax,1)
  4643b0:	cmp    %rdi,%rsi
  4643b3:	je     464ab6 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x916>
  4643b9:	mov    (%rax,%rdi,1),%r14
  4643bd:	mov    0x8(%rax,%rdi,1),%r15
  4643c2:	mov    %r15,%r8
  4643c5:	xor    %rcx,%r8
  4643c8:	mov    %r14,%r9
  4643cb:	xor    %rdx,%r9
  4643ce:	add    $0x10,%rdi
  4643d2:	inc    %r11
  4643d5:	or     %r8,%r9
  4643d8:	je     4643b0 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x210>
  4643da:	cmp    %rdx,%r14
  4643dd:	mov    %r10,%rax
  4643e0:	sbb    %rcx,%r15
  4643e3:	jae    4645c5 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x425>
  4643e9:	sub    %r11,%rax
  4643ec:	mov    0x8(%rsp),%rcx
  4643f1:	jb     464af6 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x956>
  4643f7:	lea    -0x1(%rax),%rsi
  4643fb:	mov    %r10,%rax
  4643fe:	sub    %r11,%rax
  464401:	je     464ae5 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x945>
  464407:	mov    %r11,0x48(%rsp)
  46440c:	shl    $0x4,%r11
  464410:	mov    %r11,0x38(%rsp)
  464415:	lea    (%rcx,%r11,1),%rdi
  464419:	mov    %rsi,%rdx
  46441c:	and    $0xffffffffffffff80,%rdx
  464420:	mov    %rdx,0x50(%rsp)
  464425:	mov    %rax,0x58(%rsp)
  46442a:	mov    %rax,0x28(%rsp)
  46442f:	mov    %rdi,0x30(%rsp)
  464434:	add    $0x10,%rdi
  464438:	shr    $0x7,%rsi
  46443c:	mov    $0x34,%al
  46443e:	mov    %rsi,0x40(%rsp)
  464443:	bzhi   %rax,%rsi,%rax
  464448:	mov    %rax,0x60(%rsp)
  46444d:	xor    %eax,%eax
  46444f:	xor    %r11d,%r11d
  464452:	mov    %r10,0x18(%rsp)
  464457:	nopw   0x0(%rax,%rax,1)
  464460:	cmp    0x60(%rsp),%rax
  464465:	je     4646b7 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x517>
  46446b:	mov    %rax,0x20(%rsp)
  464470:	kmovd  %r11d,%k0
  464475:	kshiftlb $0x7,%k0,%k0
  46447b:	kshiftrb $0x7,%k0,%k0
  464481:	xor    %r14d,%r14d
  464484:	xor    %edx,%edx
  464486:	xor    %ebx,%ebx
  464488:	xor    %r11d,%r11d
  46448b:	xor    %ebp,%ebp
  46448d:	mov    %rdi,0x10(%rsp)
  464492:	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  4644a0:	mov    -0x10(%rdi,%r14,1),%r15
  4644a5:	mov    -0x8(%rdi,%r14,1),%r13
  4644aa:	mov    0x18(%rdi,%r14,1),%r12
  4644af:	mov    0x8(%rdi,%r14,1),%rcx
  4644b4:	mov    0x10(%rdi,%r14,1),%rsi
  4644b9:	mov    (%rdi,%r14,1),%r10
  4644bd:	cmp    %rsi,%r10
  4644c0:	mov    %rcx,%rdi
  4644c3:	sbb    %r12,%rdi
  4644c6:	mov    %rcx,%rdi
  4644c9:	cmovb  %r12,%rdi
  4644cd:	mov    %r10,%rax
  4644d0:	cmovb  %rsi,%rax
  4644d4:	cmp    %r10,%r15
  4644d7:	mov    %r13,%r9
  4644da:	sbb    %rcx,%r9
  4644dd:	mov    %r13,%r9
  4644e0:	cmovb  %rcx,%r9
  4644e4:	mov    %r15,%r8
  4644e7:	cmovb  %r10,%r8
  4644eb:	xor    %r15,%r8
  4644ee:	or     %r8,%rdx
  4644f1:	xor    %r13,%r9
  4644f4:	or     %r9,%rbx
  4644f7:	xor    %r10,%rax
  4644fa:	or     %rax,%r11
  4644fd:	xor    %rcx,%rdi
  464500:	or     %rdi,%rbp
  464503:	mov    0x10(%rsp),%rdi
  464508:	xor    %rcx,%r12
  46450b:	xor    %r10,%rsi
  46450e:	or     %r12,%rsi
  464511:	sete   %al
  464514:	xor    %rcx,%r13
  464517:	xor    %r10,%r15
  46451a:	or     %r13,%r15
  46451d:	kmovd  %eax,%k1
  464521:	sete   %al
  464524:	kmovd  %eax,%k2
  464528:	kshiftlb $0x1,%k1,%k1
  46452e:	kshiftlb $0x7,%k2,%k2
  464534:	kshiftrb $0x7,%k2,%k2
  46453a:	korw   %k1,%k2,%k1
  46453e:	korw   %k1,%k0,%k0
  464542:	add    $0x20,%r14
  464546:	cmp    $0x800,%r14
  46454d:	jne    4644a0 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x300>
  464553:	vmovq  %rdx,%xmm0
  464558:	vmovq  %rbx,%xmm1
  46455d:	vpunpcklqdq %xmm1,%xmm0,%xmm0
  464561:	vmovq  %r11,%xmm1
  464566:	vmovq  %rbp,%xmm2
  46456b:	vpunpcklqdq %xmm2,%xmm1,%xmm1
  46456f:	vinserti128 $0x1,%xmm1,%ymm0,%ymm0
  464575:	kmovd  %k0,%eax
  464579:	test   $0x3,%al
  46457b:	setne  %r11b
  46457f:	mov    0x20(%rsp),%rax
  464584:	inc    %rax
  464587:	add    $0x800,%rdi
  46458e:	vptest %ymm0,%ymm0
  464593:	mov    0x18(%rsp),%r10
  464598:	mov    0x8(%rsp),%rcx
  46459d:	je     464460 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x2c0>
  4645a3:	jmp    4646b0 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x510>
  4645a8:	inc    %r12
  4645ab:	shl    $0x7,%rsi
  4645af:	lea    (%r12,%rsi,1),%r11
  4645b3:	inc    %r11
  4645b6:	cmp    %rdx,%r14
  4645b9:	mov    %r10,%rax
  4645bc:	sbb    %rcx,%r15
  4645bf:	jb     4643e9 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x249>
  4645c5:	sub    %r11,%rax
  4645c8:	jb     464b0c <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x96c>
  4645ce:	lea    -0x1(%rax),%rsi
  4645d2:	sub    %r11,%r10
  4645d5:	je     464ae5 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x945>
  4645db:	mov    %rsi,%rax
  4645de:	and    $0xffffffffffffff80,%rax
  4645e2:	mov    %rax,0x10(%rsp)
  4645e7:	shr    $0x7,%rsi
  4645eb:	mov    $0x34,%al
  4645ed:	bzhi   %rax,%rsi,%rdi
  4645f2:	shl    $0x4,%r11
  4645f6:	mov    0x8(%rsp),%rax
  4645fb:	lea    (%r11,%rax,1),%rdx
  4645ff:	add    $0x20,%rdx
  464603:	xor    %r8d,%r8d
  464606:	cs nopw 0x0(%rax,%rax,1)
  464610:	cmp    %rdi,%r8
  464613:	je     464763 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x5c3>
  464619:	mov    %r11,%rcx
  46461c:	xor    %ebx,%ebx
  46461e:	xor    %r11d,%r11d
  464621:	xor    %r9d,%r9d
  464624:	data16 data16 cs nopw 0x0(%rax,%rax,1)
  464630:	mov    -0x20(%rdx,%rbx,1),%r14
  464635:	mov    -0x18(%rdx,%rbx,1),%r15
  46463a:	mov    -0x8(%rdx,%rbx,1),%rax
  46463f:	mov    -0x10(%rdx,%rbx,1),%r12
  464644:	cmp    %r14,%r12
  464647:	mov    %rax,%r13
  46464a:	sbb    %r15,%r13
  46464d:	mov    %r14,%r13
  464650:	cmovb  %r12,%r13
  464654:	mov    %r15,%rbp
  464657:	cmovb  %rax,%rbp
  46465b:	xor    %r15,%rbp
  46465e:	or     %r9,%rbp
  464661:	xor    %r14,%r13
  464664:	or     %r11,%r13
  464667:	mov    0x8(%rdx,%rbx,1),%r9
  46466c:	mov    (%rdx,%rbx,1),%r11
  464670:	cmp    %r12,%r11
  464673:	mov    %r9,%r14
  464676:	sbb    %rax,%r14
  464679:	cmovae %rax,%r9
  46467d:	cmovae %r12,%r11
  464681:	xor    %r12,%r11
  464684:	or     %r13,%r11
  464687:	xor    %rax,%r9
  46468a:	or     %rbp,%r9
  46468d:	add    $0x20,%rbx
  464691:	cmp    $0x800,%rbx
  464698:	jne    464630 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x490>
  46469a:	inc    %r8
  46469d:	add    $0x800,%rdx
  4646a4:	or     %r9,%r11
  4646a7:	mov    %rcx,%r11
  4646aa:	je     464610 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x470>
  4646b0:	xor    %esi,%esi
  4646b2:	jmp    464ab9 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x919>
  4646b7:	mov    0x58(%rsp),%r9
  4646bc:	mov    0x50(%rsp),%rdi
  4646c1:	sub    %rdi,%r9
  4646c4:	jb     464b22 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x982>
  4646ca:	cmp    $0x2,%r9
  4646ce:	jb     46473a <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x59a>
  4646d0:	shl    $0x4,%rdi
  4646d4:	mov    0x30(%rsp),%rax
  4646d9:	mov    (%rax,%rdi,1),%rdx
  4646dd:	mov    0x8(%rax,%rdi,1),%rsi
  4646e2:	inc    %r9
  4646e5:	mov    0x40(%rsp),%rax
  4646ea:	shl    $0xb,%rax
  4646ee:	add    0x38(%rsp),%rax
  4646f3:	add    %rcx,%rax
  4646f6:	add    $0x10,%rax
  4646fa:	nopw   0x0(%rax,%rax,1)
  464700:	mov    (%rax),%rdi
  464703:	mov    0x8(%rax),%r8
  464707:	cmp    %rdi,%rdx
  46470a:	mov    %rsi,%rcx
  46470d:	sbb    %r8,%rcx
  464710:	jb     4646b0 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x510>
  464712:	xor    %rdi,%rdx
  464715:	xor    %r8,%rsi
  464718:	or     %rdx,%rsi
  46471b:	sete   %cl
  46471e:	or     %cl,%r11b
  464721:	mov    %r9,%rcx
  464724:	dec    %rcx
  464727:	add    $0x10,%rax
  46472b:	mov    %rdi,%rdx
  46472e:	mov    %r8,%rsi
  464731:	mov    %rcx,%r9
  464734:	cmp    $0x3,%rcx
  464738:	jae    464700 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x560>
  46473a:	mov    %r10,%rsi
  46473d:	shr    $1,%rsi
  464740:	mov    %r10,%rdx
  464743:	shl    $0x4,%rdx
  464747:	lea    -0x1(%rsi),%rax
  46474b:	mov    %esi,%ecx
  46474d:	and    $0x3,%ecx
  464750:	cmp    $0x3,%rax
  464754:	jae    4647bb <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x61b>
  464756:	xor    %r8d,%r8d
  464759:	mov    0x8(%rsp),%rdi
  46475e:	jmp    46488e <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x6ee>
  464763:	mov    0x10(%rsp),%rdi
  464768:	cmp    %r10,%rdi
  46476b:	ja     464b3a <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x99a>
  464771:	shl    $0xb,%rsi
  464775:	add    %r11,%rsi
  464778:	mov    0x8(%rsp),%rax
  46477d:	add    %rsi,%rax
  464780:	add    $0x10,%rax
  464784:	sub    %rdi,%r10
  464787:	inc    %r10
  46478a:	nopw   0x0(%rax,%rax,1)
  464790:	dec    %r10
  464793:	cmp    $0x2,%r10
  464797:	setb   %sil
  46479b:	jb     464ab9 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x919>
  4647a1:	mov    (%rax),%rcx
  4647a4:	mov    0x8(%rax),%rdx
  4647a8:	cmp    -0x10(%rax),%rcx
  4647ac:	sbb    -0x8(%rax),%rdx
  4647b0:	lea    0x10(%rax),%rax
  4647b4:	jae    464790 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x5f0>
  4647b6:	jmp    464ab9 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x919>
  4647bb:	mov    0x8(%rsp),%rdi
  4647c0:	lea    (%rdi,%rdx,1),%rbx
  4647c4:	movabs $0x3fffffffffffffc,%rax
  4647ce:	and    %rax,%rsi
  4647d1:	lea    0x30(%rdi),%r14
  4647d5:	lea    (%rdx,%rdi,1),%r15
  4647d9:	add    $0xfffffffffffffff0,%r15
  4647dd:	xor    %r8d,%r8d
  4647e0:	movabs $0xffffffffffffffe,%r9
  4647ea:	movabs $0xffffffffffffffd,%r12
  4647f4:	movabs $0xffffffffffffffc,%r13
  4647fe:	xchg   %ax,%ax
  464800:	vmovaps -0x30(%r14),%xmm0
  464806:	vmovaps (%r15),%xmm1
  46480b:	vmovaps %xmm1,-0x30(%r14)
  464811:	vmovaps %xmm0,(%r15)
  464816:	mov    %r8,%rax
  464819:	xor    %r9,%rax
  46481c:	shl    $0x4,%rax
  464820:	vmovaps -0x20(%r14),%xmm0
  464826:	vmovaps (%rbx,%rax,1),%xmm1
  46482b:	vmovaps %xmm1,-0x20(%r14)
  464831:	vmovaps %xmm0,(%rbx,%rax,1)
  464836:	mov    %r8,%rax
  464839:	xor    %r12,%rax
  46483c:	shl    $0x4,%rax
  464840:	vmovaps -0x10(%r14),%xmm0
  464846:	vmovaps (%rbx,%rax,1),%xmm1
  46484b:	vmovaps %xmm1,-0x10(%r14)
  464851:	vmovaps %xmm0,(%rbx,%rax,1)
  464856:	mov    %r8,%rax
  464859:	xor    %r13,%rax
  46485c:	shl    $0x4,%rax
  464860:	vmovdqa (%r14),%xmm0
  464865:	vmovdqa (%rbx,%rax,1),%xmm1
  46486a:	vmovdqa %xmm1,(%r14)
  46486f:	vmovdqa %xmm0,(%rbx,%rax,1)
  464874:	add    $0x4,%r8
  464878:	add    $0x40,%r14
  46487c:	add    $0xffffffffffffffc0,%r15
  464880:	cmp    %r8,%rsi
  464883:	jne    464800 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x660>
  464889:	test   %rcx,%rcx
  46488c:	je     4648cf <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x72f>
  46488e:	shl    $0x4,%r8
  464892:	lea    (%rdi,%r8,1),%rax
  464896:	sub    %r8,%rdx
  464899:	add    %rdi,%rdx
  46489c:	add    $0xfffffffffffffff0,%rdx
  4648a0:	shl    $0x4,%ecx
  4648a3:	xor    %esi,%esi
  4648a5:	data16 cs nopw 0x0(%rax,%rax,1)
  4648b0:	vmovdqa (%rax,%rsi,1),%xmm0
  4648b5:	vmovdqa (%rdx),%xmm1
  4648b9:	vmovdqa %xmm1,(%rax,%rsi,1)
  4648be:	vmovdqa %xmm0,(%rdx)
  4648c2:	add    $0x10,%rsi
  4648c6:	add    $0xfffffffffffffff0,%rdx
  4648ca:	cmp    %rsi,%rcx
  4648cd:	jne    4648b0 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x710>
  4648cf:	cmpq   $0x2,0x48(%rsp)
  4648d5:	setae  %al
  4648d8:	or     %r11b,%al
  4648db:	test   $0x1,%al
  4648dd:	je     464ab6 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x916>
  4648e3:	lea    0x10(%rdi),%rcx
  4648e7:	lea    0x30(%rdi),%rax
  4648eb:	mov    %rax,0x20(%rsp)
  4648f0:	lea    -0x10(%rdi),%rax
  4648f4:	mov    %rax,0x10(%rsp)
  4648f9:	xor    %esi,%esi
  4648fb:	movabs $0xffffffffffffffe,%r11
  464905:	movabs $0xffffffffffffffd,%rbx
  46490f:	movabs $0xffffffffffffffc,%r14
  464919:	jmp    464929 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x789>
  46491b:	nopl   0x0(%rax,%rax,1)
  464920:	cmp    %r10,%rsi
  464923:	jae    464ab6 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x916>
  464929:	mov    %rsi,%rdx
  46492c:	mov    %rsi,%r15
  46492f:	shl    $0x4,%r15
  464933:	mov    (%rdi,%r15,1),%rax
  464937:	mov    0x8(%rdi,%r15,1),%r8
  46493c:	lea    0x1(%rsi),%rdi
  464940:	cmp    %rdi,%r10
  464943:	cmova  %r10,%rdi
  464947:	lea    -0x1(%rdi),%r9
  46494b:	lea    (%rcx,%r15,1),%r10
  46494f:	nop
  464950:	cmp    %rsi,%r9
  464953:	je     464970 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x7d0>
  464955:	inc    %rsi
  464958:	mov    (%r10),%r12
  46495b:	xor    %rax,%r12
  46495e:	mov    0x8(%r10),%r13
  464962:	xor    %r8,%r13
  464965:	add    $0x10,%r10
  464969:	or     %r12,%r13
  46496c:	je     464950 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x7b0>
  46496e:	jmp    464973 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x7d3>
  464970:	mov    %rdi,%rsi
  464973:	mov    %rsi,%rax
  464976:	sub    %rdx,%rax
  464979:	jb     464acd <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x92d>
  46497f:	mov    %rax,%r13
  464982:	shr    $1,%r13
  464985:	mov    0x18(%rsp),%r10
  46498a:	mov    0x8(%rsp),%rdi
  46498f:	je     464920 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x780>
  464991:	mov    %rsi,%rdx
  464994:	shl    $0x4,%rdx
  464998:	mov    %r13d,%r12d
  46499b:	and    $0x3,%r12d
  46499f:	cmp    $0x8,%rax
  4649a3:	jae    4649b0 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x810>
  4649a5:	xor    %ebp,%ebp
  4649a7:	jmp    464a6d <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x8cd>
  4649ac:	nopl   0x0(%rax)
  4649b0:	lea    (%rdi,%rdx,1),%r8
  4649b4:	and    $0xfffffffffffffffc,%r13
  4649b8:	mov    0x20(%rsp),%rax
  4649bd:	lea    (%rax,%r15,1),%r9
  4649c1:	mov    0x10(%rsp),%rax
  4649c6:	lea    (%rax,%rdx,1),%r10
  4649ca:	xor    %ebp,%ebp
  4649cc:	nopl   0x0(%rax)
  4649d0:	vmovaps -0x30(%r9),%xmm0
  4649d6:	vmovaps (%r10),%xmm1
  4649db:	vmovaps %xmm1,-0x30(%r9)
  4649e1:	vmovaps %xmm0,(%r10)
  4649e6:	mov    %rbp,%rax
  4649e9:	xor    %r11,%rax
  4649ec:	shl    $0x4,%rax
  4649f0:	vmovaps -0x20(%r9),%xmm0
  4649f6:	vmovaps (%r8,%rax,1),%xmm1
  4649fc:	vmovaps %xmm1,-0x20(%r9)
  464a02:	vmovaps %xmm0,(%r8,%rax,1)
  464a08:	mov    %rbp,%rax
  464a0b:	xor    %rbx,%rax
  464a0e:	shl    $0x4,%rax
  464a12:	vmovaps -0x10(%r9),%xmm0
  464a18:	vmovaps (%r8,%rax,1),%xmm1
  464a1e:	vmovaps %xmm1,-0x10(%r9)
  464a24:	vmovaps %xmm0,(%r8,%rax,1)
  464a2a:	mov    %rbp,%rax
  464a2d:	xor    %r14,%rax
  464a30:	shl    $0x4,%rax
  464a34:	vmovdqa (%r9),%xmm0
  464a39:	vmovdqa (%r8,%rax,1),%xmm1
  464a3f:	vmovdqa %xmm1,(%r9)
  464a44:	vmovdqa %xmm0,(%r8,%rax,1)
  464a4a:	add    $0x4,%rbp
  464a4e:	add    $0x40,%r9
  464a52:	add    $0xffffffffffffffc0,%r10
  464a56:	cmp    %rbp,%r13
  464a59:	jne    4649d0 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x830>
  464a5f:	test   %r12,%r12
  464a62:	mov    0x18(%rsp),%r10
  464a67:	je     464920 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x780>
  464a6d:	shl    $0x4,%rbp
  464a71:	add    %rdi,%r15
  464a74:	add    %rbp,%r15
  464a77:	sub    %rbp,%rdx
  464a7a:	add    0x10(%rsp),%rdx
  464a7f:	shl    $0x4,%r12d
  464a83:	xor    %eax,%eax
  464a85:	data16 cs nopw 0x0(%rax,%rax,1)
  464a90:	vmovdqa (%r15,%rax,1),%xmm0
  464a96:	vmovdqa (%rdx),%xmm1
  464a9a:	vmovdqa %xmm1,(%r15,%rax,1)
  464aa0:	vmovdqa %xmm0,(%rdx)
  464aa4:	add    $0x10,%rax
  464aa8:	add    $0xfffffffffffffff0,%rdx
  464aac:	cmp    %rax,%r12
  464aaf:	jne    464a90 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x8f0>
  464ab1:	jmp    464920 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x780>
  464ab6:	mov    $0x1,%sil
  464ab9:	mov    %esi,%eax
  464abb:	add    $0x68,%rsp
  464abf:	pop    %rbx
  464ac0:	pop    %r12
  464ac2:	pop    %r13
  464ac4:	pop    %r14
  464ac6:	pop    %r15
  464ac8:	pop    %rbp
  464ac9:	vzeroupper
  464acc:	ret
  464acd:	lea    0x53dd4(%rip),%rcx        # 4b88a8 <anon.005357b6259aec7dbb5efeaf9c6c1e46.1.llvm.5840278210049151275>
  464ad4:	mov    %rdx,%rdi
  464ad7:	mov    0x18(%rsp),%rdx
  464adc:	vzeroupper
  464adf:	call   *0x56673(%rip)        # 4bb158 <_DYNAMIC+0x260>
  464ae5:	lea    0x540cc(%rip),%rcx        # 4b8bb8 <anon.fc147e135d8089a06b86996a95238ad4.1.llvm.1002553242461103667+0x1a8>
  464aec:	xor    %edi,%edi
  464aee:	xor    %edx,%edx
  464af0:	call   *0x56662(%rip)        # 4bb158 <_DYNAMIC+0x260>
  464af6:	lea    0x540a3(%rip),%rcx        # 4b8ba0 <anon.fc147e135d8089a06b86996a95238ad4.1.llvm.1002553242461103667+0x190>
  464afd:	mov    %r11,%rdi
  464b00:	mov    %r10,%rsi
  464b03:	mov    %r10,%rdx
  464b06:	call   *0x5664c(%rip)        # 4bb158 <_DYNAMIC+0x260>
  464b0c:	lea    0x54075(%rip),%rcx        # 4b8b88 <anon.fc147e135d8089a06b86996a95238ad4.1.llvm.1002553242461103667+0x178>
  464b13:	mov    %r11,%rdi
  464b16:	mov    %r10,%rsi
  464b19:	mov    %r10,%rdx
  464b1c:	call   *0x56636(%rip)        # 4bb158 <_DYNAMIC+0x260>
  464b22:	lea    0x540a7(%rip),%rcx        # 4b8bd0 <anon.fc147e135d8089a06b86996a95238ad4.1.llvm.1002553242461103667+0x1c0>
  464b29:	mov    0x28(%rsp),%rdx
  464b2e:	mov    %rdx,%rsi
  464b31:	vzeroupper
  464b34:	call   *0x5661e(%rip)        # 4bb158 <_DYNAMIC+0x260>
  464b3a:	lea    0x5408f(%rip),%rcx        # 4b8bd0 <anon.fc147e135d8089a06b86996a95238ad4.1.llvm.1002553242461103667+0x1c0>
  464b41:	mov    %r10,%rsi
  464b44:	mov    %r10,%rdx
  464b47:	call   *0x5660b(%rip)        # 4bb158 <_DYNAMIC+0x260>
