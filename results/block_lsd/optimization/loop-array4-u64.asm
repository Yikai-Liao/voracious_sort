
tools/block_lsd_bench/target/release/block_lsd_bench:	file format elf64-x86-64

Disassembly of section .text:

00000000002081f0 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_>:
  2081f0:      	pushq	%rbp
  2081f1:      	pushq	%r15
  2081f3:      	pushq	%r14
  2081f5:      	pushq	%r13
  2081f7:      	pushq	%r12
  2081f9:      	pushq	%rbx
  2081fa:      	subq	$0xe8, %rsp
  208201:      	movq	%rsi, %r14
  208204:      	movq	%rdi, %r12
  208207:      	cmpq	$0x81, %rsi
  20820e:      	jae	0x208248 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x58>
  208210:      	leaq	0xf(%rsp), %rax
  208215:      	movq	%rax, 0x78(%rsp)
  20821a:      	cmpq	$0x2, %r14
  20821e:      	jb	0x2089c4 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x7d4>
  208224:      	cmpq	$0x15, %r14
  208228:      	jae	0x208a34 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x844>
  20822e:      	leaq	0x78(%rsp), %rcx
  208233:      	movl	$0x1, %edx
  208238:      	movq	%r12, %rdi
  20823b:      	movq	%r14, %rsi
  20823e:      	callq	0x1c16a0 <_RINvNtNtNtNtCs3sPX1WnuliO_4core5slice4sort6shared9smallsort25insertion_sort_shift_leftINtCs9j6qJjDxNX3_15block_lsd_bench6RecordyKj2_ENCINvMB8_SB1m_16sort_unstable_byNCINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts8lsd_sort17lsd_radixsort_auxB1m_yE0E0EB1p_>
  208243:      	jmp	0x2089c4 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x7d4>
  208248:      	vpbroadcastq	(%r12), %zmm0
  20824f:      	vmovdqa64	-0x1e2399(%rip), %zmm1 # 0x25ec0 <anon.d1e91ee184a9d34e3fc049130aa707f2.36.llvm.13573234348233770204+0x127b>
  208259:      	movabsq	$0xfffffffffffffff, %rsi # imm = 0xFFFFFFFFFFFFFFF
  208263:      	movb	$0x3c, %al
  208265:      	movl	$0x20, %edx
  20826a:      	leaq	0x190(%r12), %rdi
  208272:      	addq	%r14, %rsi
  208275:      	bzhiq	%rax, %rsi, %rax
  20827a:      	movl	%esi, %ecx
  20827c:      	andl	$0x1f, %ecx
  20827f:      	cmovneq	%rcx, %rdx
  208283:      	movq	%rax, %rcx
  208286:      	movq	%rax, %r8
  208289:      	subq	%rdx, %rcx
  20828c:      	vmovdqa64	%zmm0, %zmm2
  208292:      	vmovdqa64	%zmm0, %zmm3
  208298:      	vmovdqa64	%zmm0, %zmm4
  20829e:      	nop
  2082a0:      	vmovdqu64	-0x180(%rdi), %zmm5
  2082a7:      	vmovdqu64	-0x100(%rdi), %zmm6
  2082ae:      	vmovdqu64	-0x80(%rdi), %zmm7
  2082b5:      	vmovdqu64	(%rdi), %zmm8
  2082bb:      	addq	$-0x20, %r8
  2082bf:      	vpermt2q	-0x140(%rdi), %zmm1, %zmm5
  2082c6:      	vpermt2q	-0xc0(%rdi), %zmm1, %zmm6
  2082cd:      	vpermt2q	-0x40(%rdi), %zmm1, %zmm7
  2082d4:      	vpermt2q	0x40(%rdi), %zmm1, %zmm8
  2082db:      	addq	$0x200, %rdi            # imm = 0x200
  2082e2:      	vpmaxuq	%zmm5, %zmm0, %zmm0
  2082e8:      	vpmaxuq	%zmm6, %zmm2, %zmm2
  2082ee:      	vpmaxuq	%zmm7, %zmm3, %zmm3
  2082f4:      	vpmaxuq	%zmm8, %zmm4, %zmm4
  2082fa:      	cmpq	%r8, %rdx
  2082fd:      	jne	0x2082a0 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0xb0>
  2082ff:      	vpmaxuq	%zmm2, %zmm0, %zmm0
  208305:      	vpmaxuq	%zmm4, %zmm3, %zmm1
  20830b:      	vpmaxuq	%zmm1, %zmm0, %zmm0
  208311:      	vextracti64x4	$0x1, %zmm0, %ymm1
  208318:      	vpmaxuq	%ymm1, %ymm0, %ymm0
  20831e:      	vextracti128	$0x1, %ymm0, %xmm1
  208324:      	vpmaxuq	%xmm1, %xmm0, %xmm0
  20832a:      	vpshufd	$0xee, %xmm0, %xmm1     # xmm1 = xmm0[2,3,2,3]
  20832f:      	vpmaxuq	%xmm1, %xmm0, %xmm0
  208335:      	vmovq	%xmm0, %rdi
  20833a:      	cmpl	$0x5, %edx
  20833d:      	jb	0x2083ab <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x1bb>
  20833f:      	andl	$0x3, %esi
  208342:      	movl	$0x4, %r8d
  208348:      	vpbroadcastq	%rdi, %ymm0
  20834e:      	movq	%rax, %rdi
  208351:      	movq	%rax, %rcx
  208354:      	cmovneq	%rsi, %r8
  208358:      	movq	%rdx, %rsi
  20835b:      	shlq	$0x4, %rdi
  20835f:      	shll	$0x4, %edx
  208362:      	subq	%rdx, %rdi
  208365:      	subq	%r8, %rcx
  208368:      	subq	%r8, %rsi
  20836b:      	leaq	0x10(%rdi,%r12), %rdx
  208370:      	vmovdqu	(%rdx), %ymm1
  208374:      	vpunpcklqdq	0x20(%rdx), %ymm1, %ymm1 # ymm1 = ymm1[0],mem[0],ymm1[2],mem[2]
  208379:      	addq	$0x40, %rdx
  20837d:      	addq	$-0x4, %rsi
  208381:      	vpermq	$0xd8, %ymm1, %ymm1     # ymm1 = ymm1[0,2,1,3]
  208387:      	vpmaxuq	%ymm1, %ymm0, %ymm0
  20838d:      	jne	0x208370 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x180>
  20838f:      	vextracti128	$0x1, %ymm0, %xmm1
  208395:      	vpmaxuq	%xmm1, %xmm0, %xmm0
  20839b:      	vpshufd	$0xee, %xmm0, %xmm1     # xmm1 = xmm0[2,3,2,3]
  2083a0:      	vpmaxuq	%xmm1, %xmm0, %xmm0
  2083a6:      	vmovq	%xmm0, %rdi
  2083ab:      	subq	%rcx, %rax
  2083ae:      	shlq	$0x4, %rcx
  2083b2:      	leaq	0x10(%rcx,%r12), %rcx
  2083b7:      	nopw	(%rax,%rax)
  2083c0:      	movq	%rdi, %rdx
  2083c3:      	movq	(%rcx), %rdi
  2083c6:      	cmpq	%rdi, %rdx
  2083c9:      	cmovaq	%rdx, %rdi
  2083cd:      	addq	$0x10, %rcx
  2083d1:      	decq	%rax
  2083d4:      	jne	0x2083c0 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x1d0>
  2083d6:      	lzcntq	%rdi, %rbx
  2083db:      	movl	$0x40, %ecx
  2083e0:      	movl	$0x40, %eax
  2083e5:      	subq	%rbx, %rcx
  2083e8:      	testb	$0x7, %cl
  2083eb:      	je	0x2083fd <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x20d>
  2083ed:      	andl	$-0x8, %ecx
  2083f0:      	xorl	%ebx, %ebx
  2083f2:      	addq	$0x8, %rcx
  2083f6:      	subq	%rcx, %rax
  2083f9:      	cmovaeq	%rax, %rbx
  2083fd:      	movl	$0x40, %edi
  208402:      	movl	$0x8, %edx
  208407:      	movq	%rbx, %rsi
  20840a:      	vzeroupper
  20840d:      	callq	*0x1c6b05(%rip)         # 0x3cef18 <writev+0x3cef18>
  208413:      	testq	%rax, %rax
  208416:      	je	0x2089c4 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x7d4>
  20841c:      	movq	$0x0, 0xc0(%rsp)
  208428:      	movq	$0x8, 0xc8(%rsp)
  208434:      	movq	%rbx, 0xd0(%rsp)
  20843c:      	movq	%r14, %rbx
  20843f:      	movq	%rax, 0xd8(%rsp)
  208447:      	movq	%rax, 0x18(%rsp)
  20844c:      	movq	$0x100, 0xe0(%rsp)      # imm = 0x100
  208458:      	shlq	$0x4, %rbx
  20845c:      	callq	*0x1c6a46(%rip)         # 0x3ceea8 <writev+0x3ceea8>
  208462:      	movq	%rbx, %rdi
  208465:      	movq	%rbx, 0x10(%rsp)
  20846a:      	callq	*0x1c6a68(%rip)         # 0x3ceed8 <writev+0x3ceed8>
  208470:      	movq	%rax, (%rsp)
  208474:      	testq	%rax, %rax
  208477:      	je	0x208a24 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x834>
  20847d:      	movzbl	0x1c8e54(%rip), %eax    # 0x3d12d8 <_RNvCs9j6qJjDxNX3_15block_lsd_bench5TRACK.0.llvm.13354737551727885710>
  208484:      	testb	%al, %al
  208486:      	je	0x2084c5 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x2d5>
  208488:      	movq	0x10(%rsp), %rax
  20848d:      	movq	%rax, %rcx
  208490:      	lock
  208491:      	xaddq	%rcx, 0x1c8e2f(%rip)    # 0x3d12c8 <_RNvCs9j6qJjDxNX3_15block_lsd_bench4LIVE.llvm.13354737551727885710>
  208499:      	addq	%rax, %rcx
  20849c:      	movq	0x1c8e2d(%rip), %rax    # 0x3d12d0 <_RNvCs9j6qJjDxNX3_15block_lsd_bench4PEAK.llvm.13354737551727885710>
  2084a3:      	nopw	%cs:(%rax,%rax)
  2084b0:      	cmpq	%rcx, %rax
  2084b3:      	movq	%rcx, %rdx
  2084b6:      	cmovaq	%rax, %rdx
  2084ba:      	lock
  2084bb:      	cmpxchgq	%rdx, 0x1c8e0d(%rip)    # 0x3d12d0 <_RNvCs9j6qJjDxNX3_15block_lsd_bench4PEAK.llvm.13354737551727885710>
  2084c3:      	jne	0x2084b0 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x2c0>
  2084c5:      	vmovdqu	(%r12), %xmm0
  2084cb:      	movq	(%rsp), %rax
  2084cf:      	leaq	-0x1(%r14), %rcx
  2084d3:      	movl	$0x1, %esi
  2084d8:      	cmpq	$0x4, %rcx
  2084dc:      	jb	0x2085b5 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x3c5>
  2084e2:      	cmpq	$0x20, %rcx
  2084e6:      	jae	0x2084ef <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x2ff>
  2084e8:      	xorl	%edx, %edx
  2084ea:      	jmp	0x20856e <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x37e>
  2084ef:      	movq	(%rsp), %rdi
  2084f3:      	movq	%rcx, %rdx
  2084f6:      	andq	$-0x20, %rdx
  2084fa:      	vshufi64x2	$0x0, %zmm0, %zmm0, %zmm1 # zmm1 = zmm0[0,1,0,1,0,1,0,1]
  208501:      	movq	%rdx, %rax
  208504:      	shlq	$0x4, %rax
  208508:      	leaq	0x1(%rdx), %rsi
  20850c:      	movq	%rdx, %r8
  20850f:      	addq	%rdi, %rax
  208512:      	addq	$0x180, %rdi            # imm = 0x180
  208519:      	nopl	(%rax)
  208520:      	vmovdqu64	%zmm1, -0x180(%rdi)
  208527:      	vmovdqu64	%zmm1, -0x140(%rdi)
  20852e:      	vmovdqu64	%zmm1, -0x100(%rdi)
  208535:      	vmovdqu64	%zmm1, -0xc0(%rdi)
  20853c:      	vmovdqu64	%zmm1, -0x80(%rdi)
  208543:      	vmovdqu64	%zmm1, -0x40(%rdi)
  20854a:      	vmovdqu64	%zmm1, (%rdi)
  208550:      	vmovdqu64	%zmm1, 0x40(%rdi)
  208557:      	addq	$0x200, %rdi            # imm = 0x200
  20855e:      	addq	$-0x20, %r8
  208562:      	jne	0x208520 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x330>
  208564:      	cmpq	%rdx, %rcx
  208567:      	je	0x2085cd <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x3dd>
  208569:      	testb	$0x1c, %cl
  20856c:      	je	0x2085b5 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x3c5>
  20856e:      	movq	(%rsp), %r9
  208572:      	movq	%rcx, %rdi
  208575:      	andq	$-0x4, %rdi
  208579:      	movq	%rdx, %r8
  20857c:      	shlq	$0x4, %rdx
  208580:      	vshufi64x2	$0x0, %zmm0, %zmm0, %zmm1 # zmm1 = zmm0[0,1,0,1,0,1,0,1]
  208587:      	movq	%rdi, %rax
  20858a:      	shlq	$0x4, %rax
  20858e:      	leaq	0x1(%rdi), %rsi
  208592:      	subq	%rdi, %r8
  208595:      	addq	%r9, %rax
  208598:      	addq	%r9, %rdx
  20859b:      	nopl	(%rax,%rax)
  2085a0:      	vmovdqu64	%zmm1, (%rdx)
  2085a6:      	addq	$0x40, %rdx
  2085aa:      	addq	$0x4, %r8
  2085ae:      	jne	0x2085a0 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x3b0>
  2085b0:      	cmpq	%rdi, %rcx
  2085b3:      	je	0x2085cd <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x3dd>
  2085b5:      	movq	%r14, %rcx
  2085b8:      	subq	%rsi, %rcx
  2085bb:      	nopl	(%rax,%rax)
  2085c0:      	vmovdqu	%xmm0, (%rax)
  2085c4:      	addq	$0x10, %rax
  2085c8:      	decq	%rcx
  2085cb:      	jne	0x2085c0 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x3d0>
  2085cd:      	vmovdqu	(%r12), %xmm0
  2085d3:      	vmovdqu	%xmm0, (%rax)
  2085d7:      	leaq	0x60(%rsp), %rdi
  2085dc:      	leaq	0xc0(%rsp), %rcx
  2085e4:      	movq	%r12, %rsi
  2085e7:      	movq	%r14, %rdx
  2085ea:      	vzeroupper
  2085ed:      	callq	0x19f080 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared5utils19get_full_histogramsINtB6_6RecordyKj2_EyEB6_>
  2085f2:      	movq	0x10(%rsp), %rax
  2085f7:      	movq	0x68(%rsp), %r15
  2085fc:      	movq	0x70(%rsp), %r13
  208601:      	movq	0x18(%rsp), %r9
  208606:      	movabsq	$0x7fffffffffffffc0, %rcx # imm = 0x7FFFFFFFFFFFFFC0
  208610:      	xorl	%ebx, %ebx
  208612:      	movq	%r12, 0x30(%rsp)
  208617:      	movl	%eax, %ebp
  208619:      	andq	%rax, %rcx
  20861c:      	andl	$0x30, %ebp
  20861f:      	movq	%r15, 0x28(%rsp)
  208624:      	movq	%r13, 0x38(%rsp)
  208629:      	movq	%rcx, 0x48(%rsp)
  20862e:      	movq	%rbp, 0x40(%rsp)
  208633:      	jmp	0x20865f <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x46f>
  208635:      	nopw	%cs:(%rax,%rax)
  208640:      	movq	%r12, %rdi
  208643:      	callq	*0x1c684f(%rip)         # 0x3cee98 <writev+0x3cee98>
  208649:      	movq	0x50(%rsp), %r9
  20864e:      	movq	0x30(%rsp), %r12
  208653:      	xorl	$0x1, %ebx
  208656:      	testq	%r9, %r9
  208659:      	je	0x20891b <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x72b>
  20865f:      	leaq	-0x1(%r9), %rax
  208663:      	jmp	0x208679 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x489>
  208665:      	nopw	%cs:(%rax,%rax)
  208670:      	testq	%r9, %r9
  208673:      	je	0x20891b <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x72b>
  208679:      	movq	%r9, %rbp
  20867c:      	decq	%r9
  20867f:      	cmpq	%r13, %rax
  208682:      	jae	0x208a0f <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x81f>
  208688:      	leaq	(%r9,%r9,2), %rcx
  20868c:      	movq	0x10(%r15,%rcx,8), %rdx
  208691:      	testq	%rdx, %rdx
  208694:      	je	0x208670 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x480>
  208696:      	movq	0x8(%r15,%rcx,8), %rsi
  20869b:      	leaq	(,%rdx,8), %rcx
  2086a3:      	xorl	%edi, %edi
  2086a5:      	xorl	%r8d, %r8d
  2086a8:      	nopl	(%rax,%rax)
  2086b0:      	cmpq	$0x1, (%rsi,%r8)
  2086b5:      	sbbl	$-0x1, %edi
  2086b8:      	cmpl	$0x1, %edi
  2086bb:      	ja	0x2086d0 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x4e0>
  2086bd:      	addq	$0x8, %r8
  2086c1:      	cmpq	%r8, %rcx
  2086c4:      	jne	0x2086b0 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x4c0>
  2086c6:      	jmp	0x208670 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x480>
  2086c8:      	nopl	(%rax,%rax)
  2086d0:      	movq	(%rsp), %r13
  2086d4:      	testl	%ebx, %ebx
  2086d6:      	movq	%r12, %r15
  2086d9:      	movq	%r9, 0x50(%rsp)
  2086de:      	movq	%rbx, 0x58(%rsp)
  2086e3:      	cmoveq	%r13, %r15
  2086e7:      	cmoveq	%r12, %r13
  2086eb:      	leaq	0x78(%rsp), %rdi
  2086f0:      	callq	0x1b0810 <_RNvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared5utils11prefix_sums>
  2086f5:      	movq	0x90(%rsp), %rcx
  2086fd:      	movq	0x78(%rsp), %rax
  208702:      	movq	0x98(%rsp), %r12
  20870a:      	movq	0xa0(%rsp), %rbx
  208712:      	leaq	-0x1(%rbp), %r9
  208716:      	movq	%rcx, 0x20(%rsp)
  20871b:      	testq	%rax, %rax
  20871e:      	je	0x208749 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x559>
  208720:      	movq	0x80(%rsp), %rdi
  208728:      	movzbl	0x1c8ba9(%rip), %ecx    # 0x3d12d8 <_RNvCs9j6qJjDxNX3_15block_lsd_bench5TRACK.0.llvm.13354737551727885710>
  20872f:      	testb	%cl, %cl
  208731:      	je	0x20873f <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x54f>
  208733:      	shlq	$0x3, %rax
  208737:      	lock
  208738:      	subq	%rax, 0x1c8b89(%rip)    # 0x3d12c8 <_RNvCs9j6qJjDxNX3_15block_lsd_bench4LIVE.llvm.13354737551727885710>
  20873f:      	callq	*0x1c6753(%rip)         # 0x3cee98 <writev+0x3cee98>
  208745:      	leaq	-0x1(%rbp), %r9
  208749:      	movq	0xa8(%rsp), %rax
  208751:      	testq	%rax, %rax
  208754:      	je	0x20877f <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x58f>
  208756:      	movq	0xb0(%rsp), %rdi
  20875e:      	movzbl	0x1c8b73(%rip), %ecx    # 0x3d12d8 <_RNvCs9j6qJjDxNX3_15block_lsd_bench5TRACK.0.llvm.13354737551727885710>
  208765:      	testb	%cl, %cl
  208767:      	je	0x208775 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x585>
  208769:      	shlq	$0x3, %rax
  20876d:      	lock
  20876e:      	subq	%rax, 0x1c8b53(%rip)    # 0x3d12c8 <_RNvCs9j6qJjDxNX3_15block_lsd_bench4LIVE.llvm.13354737551727885710>
  208775:      	callq	*0x1c671d(%rip)         # 0x3cee98 <writev+0x3cee98>
  20877b:      	leaq	-0x1(%rbp), %r9
  20877f:      	movq	0x48(%rsp), %rcx
  208784:      	movq	0x18(%rsp), %rax
  208789:      	subl	%ebp, %eax
  20878b:      	movq	0x40(%rsp), %rbp
  208790:      	shll	$0x3, %eax
  208793:      	andl	$0x38, %eax
  208796:      	addq	%r13, %rcx
  208799:      	nopl	(%rax)
  2087a0:      	shrxq	%rax, (%r13), %rdx
  2087a6:      	movzbl	%dl, %edi
  2087a9:      	cmpq	%rbx, %rdi
  2087ac:      	jae	0x2089d6 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x7e6>
  2087b2:      	movq	(%r12,%rdi,8), %rdx
  2087b6:      	leaq	0x1(%rdx), %rsi
  2087ba:      	movq	%rsi, (%r12,%rdi,8)
  2087be:      	cmpq	%r14, %rdx
  2087c1:      	jae	0x2089df <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x7ef>
  2087c7:      	vmovdqu	(%r13), %xmm0
  2087cd:      	shlq	$0x4, %rdx
  2087d1:      	vmovdqu	%xmm0, (%r15,%rdx)
  2087d7:      	shrxq	%rax, 0x10(%r13), %rdx
  2087dd:      	movzbl	%dl, %edi
  2087e0:      	cmpq	%rbx, %rdi
  2087e3:      	jae	0x2089d6 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x7e6>
  2087e9:      	movq	(%r12,%rdi,8), %rdx
  2087ed:      	leaq	0x1(%rdx), %rsi
  2087f1:      	movq	%rsi, (%r12,%rdi,8)
  2087f5:      	cmpq	%r14, %rdx
  2087f8:      	jae	0x2089df <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x7ef>
  2087fe:      	vmovdqu	0x10(%r13), %xmm0
  208804:      	shlq	$0x4, %rdx
  208808:      	vmovdqu	%xmm0, (%r15,%rdx)
  20880e:      	shrxq	%rax, 0x20(%r13), %rdx
  208814:      	movzbl	%dl, %edi
  208817:      	cmpq	%rbx, %rdi
  20881a:      	jae	0x2089d6 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x7e6>
  208820:      	movq	(%r12,%rdi,8), %rdx
  208824:      	leaq	0x1(%rdx), %rsi
  208828:      	movq	%rsi, (%r12,%rdi,8)
  20882c:      	cmpq	%r14, %rdx
  20882f:      	jae	0x2089df <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x7ef>
  208835:      	vmovdqu	0x20(%r13), %xmm0
  20883b:      	shlq	$0x4, %rdx
  20883f:      	vmovdqu	%xmm0, (%r15,%rdx)
  208845:      	shrxq	%rax, 0x30(%r13), %rdx
  20884b:      	movzbl	%dl, %edi
  20884e:      	cmpq	%rbx, %rdi
  208851:      	jae	0x2089d6 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x7e6>
  208857:      	movq	(%r12,%rdi,8), %rdx
  20885b:      	leaq	0x1(%rdx), %rsi
  20885f:      	movq	%rsi, (%r12,%rdi,8)
  208863:      	cmpq	%r14, %rdx
  208866:      	jae	0x2089df <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x7ef>
  20886c:      	vmovdqu	0x30(%r13), %xmm0
  208872:      	shlq	$0x4, %rdx
  208876:      	addq	$0x40, %r13
  20887a:      	vmovdqu	%xmm0, (%r15,%rdx)
  208880:      	cmpq	%rcx, %r13
  208883:      	jne	0x2087a0 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x5b0>
  208889:      	movq	0x38(%rsp), %r13
  20888e:      	testq	%rbp, %rbp
  208891:      	je	0x2088e3 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x6f3>
  208893:      	xorl	%edx, %edx
  208895:      	nopw	%cs:(%rax,%rax)
  2088a0:      	shrxq	%rax, (%rcx,%rdx), %rsi
  2088a6:      	movzbl	%sil, %edi
  2088aa:      	cmpq	%rbx, %rdi
  2088ad:      	jae	0x208a06 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x816>
  2088b3:      	movq	(%r12,%rdi,8), %rsi
  2088b7:      	leaq	0x1(%rsi), %r8
  2088bb:      	movq	%r8, (%r12,%rdi,8)
  2088bf:      	cmpq	%r14, %rsi
  2088c2:      	jae	0x2089f7 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x807>
  2088c8:      	leaq	(%rcx,%rdx), %rdi
  2088cc:      	shlq	$0x4, %rsi
  2088d0:      	addq	$0x10, %rdx
  2088d4:      	vmovdqu	(%rdi), %xmm0
  2088d8:      	vmovdqu	%xmm0, (%r15,%rsi)
  2088de:      	cmpq	%rdx, %rbp
  2088e1:      	jne	0x2088a0 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x6b0>
  2088e3:      	movq	0x20(%rsp), %rcx
  2088e8:      	movq	0x28(%rsp), %r15
  2088ed:      	movq	0x58(%rsp), %rbx
  2088f2:      	testq	%rcx, %rcx
  2088f5:      	je	0x20864e <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x45e>
  2088fb:      	movzbl	0x1c89d6(%rip), %eax    # 0x3d12d8 <_RNvCs9j6qJjDxNX3_15block_lsd_bench5TRACK.0.llvm.13354737551727885710>
  208902:      	testb	%al, %al
  208904:      	je	0x208640 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x450>
  20890a:      	shlq	$0x3, %rcx
  20890e:      	lock
  20890f:      	subq	%rcx, 0x1c89b2(%rip)    # 0x3d12c8 <_RNvCs9j6qJjDxNX3_15block_lsd_bench4LIVE.llvm.13354737551727885710>
  208916:      	jmp	0x208640 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x450>
  20891b:      	testl	%ebx, %ebx
  20891d:      	je	0x208931 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x741>
  20891f:      	movq	(%rsp), %rsi
  208923:      	movq	0x10(%rsp), %rdx
  208928:      	movq	%r12, %rdi
  20892b:      	callq	*0x1c65b7(%rip)         # 0x3ceee8 <writev+0x3ceee8>
  208931:      	leaq	0x8(%r15), %rbx
  208935:      	jmp	0x20894f <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x75f>
  208937:      	nopw	(%rax,%rax)
  208940:      	callq	*0x1c6552(%rip)         # 0x3cee98 <writev+0x3cee98>
  208946:      	addq	$0x18, %rbx
  20894a:      	decq	%r13
  20894d:      	je	0x208974 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x784>
  20894f:      	movq	-0x8(%rbx), %rax
  208953:      	testq	%rax, %rax
  208956:      	je	0x208946 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x756>
  208958:      	movq	(%rbx), %rdi
  20895b:      	movzbl	0x1c8976(%rip), %ecx    # 0x3d12d8 <_RNvCs9j6qJjDxNX3_15block_lsd_bench5TRACK.0.llvm.13354737551727885710>
  208962:      	testb	%cl, %cl
  208964:      	je	0x208940 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x750>
  208966:      	shlq	$0x3, %rax
  20896a:      	lock
  20896b:      	subq	%rax, 0x1c8956(%rip)    # 0x3d12c8 <_RNvCs9j6qJjDxNX3_15block_lsd_bench4LIVE.llvm.13354737551727885710>
  208972:      	jmp	0x208940 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x750>
  208974:      	movq	0x60(%rsp), %rax
  208979:      	testq	%rax, %rax
  20897c:      	je	0x2089a2 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x7b2>
  20897e:      	movzbl	0x1c8953(%rip), %ecx    # 0x3d12d8 <_RNvCs9j6qJjDxNX3_15block_lsd_bench5TRACK.0.llvm.13354737551727885710>
  208985:      	testb	%cl, %cl
  208987:      	je	0x208999 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x7a9>
  208989:      	shlq	$0x3, %rax
  20898d:      	leaq	(%rax,%rax,2), %rax
  208991:      	lock
  208992:      	subq	%rax, 0x1c892f(%rip)    # 0x3d12c8 <_RNvCs9j6qJjDxNX3_15block_lsd_bench4LIVE.llvm.13354737551727885710>
  208999:      	movq	%r15, %rdi
  20899c:      	callq	*0x1c64f6(%rip)         # 0x3cee98 <writev+0x3cee98>
  2089a2:      	movzbl	0x1c892f(%rip), %eax    # 0x3d12d8 <_RNvCs9j6qJjDxNX3_15block_lsd_bench5TRACK.0.llvm.13354737551727885710>
  2089a9:      	testb	%al, %al
  2089ab:      	je	0x2089ba <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x7ca>
  2089ad:      	movq	0x10(%rsp), %rax
  2089b2:      	lock
  2089b3:      	subq	%rax, 0x1c890e(%rip)    # 0x3d12c8 <_RNvCs9j6qJjDxNX3_15block_lsd_bench4LIVE.llvm.13354737551727885710>
  2089ba:      	movq	(%rsp), %rdi
  2089be:      	callq	*0x1c64d4(%rip)         # 0x3cee98 <writev+0x3cee98>
  2089c4:      	addq	$0xe8, %rsp
  2089cb:      	popq	%rbx
  2089cc:      	popq	%r12
  2089ce:      	popq	%r13
  2089d0:      	popq	%r14
  2089d2:      	popq	%r15
  2089d4:      	popq	%rbp
  2089d5:      	retq
  2089d6:      	leaq	0x1c1c93(%rip), %rdx    # 0x3ca670 <anon.624aa100f296a21f1c5c6d547a0f7a35.15.llvm.14768152166618875051+0x120>
  2089dd:      	jmp	0x2089ec <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x7fc>
  2089df:      	movq	%rdx, %rdi
  2089e2:      	leaq	0x1c1c9f(%rip), %rdx    # 0x3ca688 <anon.624aa100f296a21f1c5c6d547a0f7a35.15.llvm.14768152166618875051+0x138>
  2089e9:      	movq	%r14, %rbx
  2089ec:      	movq	%rbx, %rsi
  2089ef:      	callq	*0x1c64c3(%rip)         # 0x3ceeb8 <writev+0x3ceeb8>
  2089f5:      	jmp	0x208a22 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x832>
  2089f7:      	movq	%rsi, %rdi
  2089fa:      	movq	%r14, %rbx
  2089fd:      	leaq	0x1c1cb4(%rip), %rdx    # 0x3ca6b8 <anon.624aa100f296a21f1c5c6d547a0f7a35.15.llvm.14768152166618875051+0x168>
  208a04:      	jmp	0x2089ec <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x7fc>
  208a06:      	leaq	0x1c1c93(%rip), %rdx    # 0x3ca6a0 <anon.624aa100f296a21f1c5c6d547a0f7a35.15.llvm.14768152166618875051+0x150>
  208a0d:      	jmp	0x2089ec <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x7fc>
  208a0f:      	leaq	0x1c1cea(%rip), %rdx    # 0x3ca700 <anon.624aa100f296a21f1c5c6d547a0f7a35.15.llvm.14768152166618875051+0x1b0>
  208a16:      	movq	%r9, %rdi
  208a19:      	movq	%r13, %rsi
  208a1c:      	callq	*0x1c6496(%rip)         # 0x3ceeb8 <writev+0x3ceeb8>
  208a22:      	ud2
  208a24:      	movq	0x10(%rsp), %rsi
  208a29:      	movl	$0x8, %edi
  208a2e:      	callq	*0x1c646c(%rip)         # 0x3ceea0 <writev+0x3ceea0>
  208a34:      	leaq	0x78(%rsp), %rdx
  208a39:      	movq	%r12, %rdi
  208a3c:      	movq	%r14, %rsi
  208a3f:      	callq	0x32c2c0 <_RINvNtNtNtCs3sPX1WnuliO_4core5slice4sort8unstable7ipnsortINtCs9j6qJjDxNX3_15block_lsd_bench6RecordyKj2_ENCINvMB6_SBT_16sort_unstable_byNCINvNtNtBW_6shared4core4sortBT_yKB1A_E0E0EBW_>
  208a44:      	jmp	0x2089c4 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x7d4>
  208a49:      	movq	%rax, %rbx
  208a4c:      	jmp	0x208a8c <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x89c>
  208a4e:      	jmp	0x208a50 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x860>
  208a50:      	movq	%rax, %rbx
  208a53:      	jmp	0x208a82 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x892>
  208a55:      	movq	0x20(%rsp), %rcx
  208a5a:      	movq	%rax, %rbx
  208a5d:      	testq	%rcx, %rcx
  208a60:      	je	0x208a82 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x892>
  208a62:      	movzbl	0x1c886f(%rip), %eax    # 0x3d12d8 <_RNvCs9j6qJjDxNX3_15block_lsd_bench5TRACK.0.llvm.13354737551727885710>
  208a69:      	testb	%al, %al
  208a6b:      	je	0x208a79 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x889>
  208a6d:      	shlq	$0x3, %rcx
  208a71:      	lock
  208a72:      	subq	%rcx, 0x1c884f(%rip)    # 0x3d12c8 <_RNvCs9j6qJjDxNX3_15block_lsd_bench4LIVE.llvm.13354737551727885710>
  208a79:      	movq	%r12, %rdi
  208a7c:      	callq	*0x1c6416(%rip)         # 0x3cee98 <writev+0x3cee98>
  208a82:      	leaq	0x60(%rsp), %rdi
  208a87:      	callq	0x1ec8a0 <_RINvNtCs3sPX1WnuliO_4core3ptr9drop_glueINtNtCs5xahNnzoIEW_5alloc3vec3VecIBC_jEEECs9j6qJjDxNX3_15block_lsd_bench>
  208a8c:      	movzbl	0x1c8845(%rip), %eax    # 0x3d12d8 <_RNvCs9j6qJjDxNX3_15block_lsd_bench5TRACK.0.llvm.13354737551727885710>
  208a93:      	testb	%al, %al
  208a95:      	je	0x208aa4 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKB17_EB6_+0x8b4>
  208a97:      	movq	0x10(%rsp), %rax
  208a9c:      	lock
  208a9d:      	subq	%rax, 0x1c8824(%rip)    # 0x3d12c8 <_RNvCs9j6qJjDxNX3_15block_lsd_bench4LIVE.llvm.13354737551727885710>
  208aa4:      	movq	(%rsp), %rdi
  208aa8:      	callq	*0x1c63ea(%rip)         # 0x3cee98 <writev+0x3cee98>
  208aae:      	movq	%rbx, %rdi
  208ab1:      	callq	0x3b9430 <_Unwind_Resume@plt>
