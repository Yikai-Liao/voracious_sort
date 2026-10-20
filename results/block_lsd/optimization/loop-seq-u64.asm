
tools/block_lsd_bench/target/release/block_lsd_bench:	file format elf64-x86-64

Disassembly of section .text:

0000000000209af0 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_>:
  209af0:      	pushq	%rbp
  209af1:      	pushq	%r15
  209af3:      	pushq	%r14
  209af5:      	pushq	%r13
  209af7:      	pushq	%r12
  209af9:      	pushq	%rbx
  209afa:      	subq	$0xe8, %rsp
  209b01:      	movq	%rsi, %r14
  209b04:      	movq	%rdi, %r12
  209b07:      	cmpq	$0x81, %rsi
  209b0e:      	jae	0x209b48 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x58>
  209b10:      	leaq	0xf(%rsp), %rax
  209b15:      	movq	%rax, 0x78(%rsp)
  209b1a:      	cmpq	$0x2, %r14
  209b1e:      	jb	0x20a2c4 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x7d4>
  209b24:      	cmpq	$0x15, %r14
  209b28:      	jae	0x20a341 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x851>
  209b2e:      	leaq	0x78(%rsp), %rcx
  209b33:      	movl	$0x1, %edx
  209b38:      	movq	%r12, %rdi
  209b3b:      	movq	%r14, %rsi
  209b3e:      	callq	0x1c16a0 <_RINvNtNtNtNtCs3sPX1WnuliO_4core5slice4sort6shared9smallsort25insertion_sort_shift_leftINtCs9j6qJjDxNX3_15block_lsd_bench6RecordyKj2_ENCINvMB8_SB1m_16sort_unstable_byNCINvNtNtCs3zlmsdLo2C0_20voracious_radix_sort5sorts8lsd_sort17lsd_radixsort_auxB1m_yE0E0EB1p_>
  209b43:      	jmp	0x20a2c4 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x7d4>
  209b48:      	vpbroadcastq	(%r12), %zmm0
  209b4f:      	vmovdqa64	-0x1e3bd9(%rip), %zmm1 # 0x25f80 <anon.d1e91ee184a9d34e3fc049130aa707f2.36.llvm.13573234348233770204+0x133b>
  209b59:      	movabsq	$0xfffffffffffffff, %rsi # imm = 0xFFFFFFFFFFFFFFF
  209b63:      	movb	$0x3c, %al
  209b65:      	movl	$0x20, %edx
  209b6a:      	leaq	0x190(%r12), %rdi
  209b72:      	addq	%r14, %rsi
  209b75:      	bzhiq	%rax, %rsi, %rax
  209b7a:      	movl	%esi, %ecx
  209b7c:      	andl	$0x1f, %ecx
  209b7f:      	cmovneq	%rcx, %rdx
  209b83:      	movq	%rax, %rcx
  209b86:      	movq	%rax, %r8
  209b89:      	subq	%rdx, %rcx
  209b8c:      	vmovdqa64	%zmm0, %zmm2
  209b92:      	vmovdqa64	%zmm0, %zmm3
  209b98:      	vmovdqa64	%zmm0, %zmm4
  209b9e:      	nop
  209ba0:      	vmovdqu64	-0x180(%rdi), %zmm5
  209ba7:      	vmovdqu64	-0x100(%rdi), %zmm6
  209bae:      	vmovdqu64	-0x80(%rdi), %zmm7
  209bb5:      	vmovdqu64	(%rdi), %zmm8
  209bbb:      	addq	$-0x20, %r8
  209bbf:      	vpermt2q	-0x140(%rdi), %zmm1, %zmm5
  209bc6:      	vpermt2q	-0xc0(%rdi), %zmm1, %zmm6
  209bcd:      	vpermt2q	-0x40(%rdi), %zmm1, %zmm7
  209bd4:      	vpermt2q	0x40(%rdi), %zmm1, %zmm8
  209bdb:      	addq	$0x200, %rdi            # imm = 0x200
  209be2:      	vpmaxuq	%zmm5, %zmm0, %zmm0
  209be8:      	vpmaxuq	%zmm6, %zmm2, %zmm2
  209bee:      	vpmaxuq	%zmm7, %zmm3, %zmm3
  209bf4:      	vpmaxuq	%zmm8, %zmm4, %zmm4
  209bfa:      	cmpq	%r8, %rdx
  209bfd:      	jne	0x209ba0 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0xb0>
  209bff:      	vpmaxuq	%zmm2, %zmm0, %zmm0
  209c05:      	vpmaxuq	%zmm4, %zmm3, %zmm1
  209c0b:      	vpmaxuq	%zmm1, %zmm0, %zmm0
  209c11:      	vextracti64x4	$0x1, %zmm0, %ymm1
  209c18:      	vpmaxuq	%ymm1, %ymm0, %ymm0
  209c1e:      	vextracti128	$0x1, %ymm0, %xmm1
  209c24:      	vpmaxuq	%xmm1, %xmm0, %xmm0
  209c2a:      	vpshufd	$0xee, %xmm0, %xmm1     # xmm1 = xmm0[2,3,2,3]
  209c2f:      	vpmaxuq	%xmm1, %xmm0, %xmm0
  209c35:      	vmovq	%xmm0, %rdi
  209c3a:      	cmpl	$0x5, %edx
  209c3d:      	jb	0x209cab <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x1bb>
  209c3f:      	andl	$0x3, %esi
  209c42:      	movl	$0x4, %r8d
  209c48:      	vpbroadcastq	%rdi, %ymm0
  209c4e:      	movq	%rax, %rdi
  209c51:      	movq	%rax, %rcx
  209c54:      	cmovneq	%rsi, %r8
  209c58:      	movq	%rdx, %rsi
  209c5b:      	shlq	$0x4, %rdi
  209c5f:      	shll	$0x4, %edx
  209c62:      	subq	%rdx, %rdi
  209c65:      	subq	%r8, %rcx
  209c68:      	subq	%r8, %rsi
  209c6b:      	leaq	0x10(%rdi,%r12), %rdx
  209c70:      	vmovdqu	(%rdx), %ymm1
  209c74:      	vpunpcklqdq	0x20(%rdx), %ymm1, %ymm1 # ymm1 = ymm1[0],mem[0],ymm1[2],mem[2]
  209c79:      	addq	$0x40, %rdx
  209c7d:      	addq	$-0x4, %rsi
  209c81:      	vpermq	$0xd8, %ymm1, %ymm1     # ymm1 = ymm1[0,2,1,3]
  209c87:      	vpmaxuq	%ymm1, %ymm0, %ymm0
  209c8d:      	jne	0x209c70 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x180>
  209c8f:      	vextracti128	$0x1, %ymm0, %xmm1
  209c95:      	vpmaxuq	%xmm1, %xmm0, %xmm0
  209c9b:      	vpshufd	$0xee, %xmm0, %xmm1     # xmm1 = xmm0[2,3,2,3]
  209ca0:      	vpmaxuq	%xmm1, %xmm0, %xmm0
  209ca6:      	vmovq	%xmm0, %rdi
  209cab:      	subq	%rcx, %rax
  209cae:      	shlq	$0x4, %rcx
  209cb2:      	leaq	0x10(%rcx,%r12), %rcx
  209cb7:      	nopw	(%rax,%rax)
  209cc0:      	movq	%rdi, %rdx
  209cc3:      	movq	(%rcx), %rdi
  209cc6:      	cmpq	%rdi, %rdx
  209cc9:      	cmovaq	%rdx, %rdi
  209ccd:      	addq	$0x10, %rcx
  209cd1:      	decq	%rax
  209cd4:      	jne	0x209cc0 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x1d0>
  209cd6:      	lzcntq	%rdi, %rbx
  209cdb:      	movl	$0x40, %ecx
  209ce0:      	movl	$0x40, %eax
  209ce5:      	subq	%rbx, %rcx
  209ce8:      	testb	$0x7, %cl
  209ceb:      	je	0x209cfd <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x20d>
  209ced:      	andl	$-0x8, %ecx
  209cf0:      	xorl	%ebx, %ebx
  209cf2:      	addq	$0x8, %rcx
  209cf6:      	subq	%rcx, %rax
  209cf9:      	cmovaeq	%rax, %rbx
  209cfd:      	movl	$0x40, %edi
  209d02:      	movl	$0x8, %edx
  209d07:      	movq	%rbx, %rsi
  209d0a:      	vzeroupper
  209d0d:      	callq	*0x1c5205(%rip)         # 0x3cef18 <writev+0x3cef18>
  209d13:      	testq	%rax, %rax
  209d16:      	je	0x20a2c4 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x7d4>
  209d1c:      	movq	$0x0, 0xc0(%rsp)
  209d28:      	movq	$0x8, 0xc8(%rsp)
  209d34:      	movq	%rbx, 0xd0(%rsp)
  209d3c:      	movq	%r14, %rbx
  209d3f:      	movq	%rax, 0xd8(%rsp)
  209d47:      	movq	%rax, 0x18(%rsp)
  209d4c:      	movq	$0x100, 0xe0(%rsp)      # imm = 0x100
  209d58:      	shlq	$0x4, %rbx
  209d5c:      	callq	*0x1c5146(%rip)         # 0x3ceea8 <writev+0x3ceea8>
  209d62:      	movq	%rbx, %rdi
  209d65:      	movq	%rbx, 0x10(%rsp)
  209d6a:      	callq	*0x1c5168(%rip)         # 0x3ceed8 <writev+0x3ceed8>
  209d70:      	movq	%rax, (%rsp)
  209d74:      	testq	%rax, %rax
  209d77:      	je	0x20a331 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x841>
  209d7d:      	movzbl	0x1c7554(%rip), %eax    # 0x3d12d8 <_RNvCs9j6qJjDxNX3_15block_lsd_bench5TRACK.0.llvm.13354737551727885710>
  209d84:      	testb	%al, %al
  209d86:      	je	0x209dc5 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x2d5>
  209d88:      	movq	0x10(%rsp), %rax
  209d8d:      	movq	%rax, %rcx
  209d90:      	lock
  209d91:      	xaddq	%rcx, 0x1c752f(%rip)    # 0x3d12c8 <_RNvCs9j6qJjDxNX3_15block_lsd_bench4LIVE.llvm.13354737551727885710>
  209d99:      	addq	%rax, %rcx
  209d9c:      	movq	0x1c752d(%rip), %rax    # 0x3d12d0 <_RNvCs9j6qJjDxNX3_15block_lsd_bench4PEAK.llvm.13354737551727885710>
  209da3:      	nopw	%cs:(%rax,%rax)
  209db0:      	cmpq	%rcx, %rax
  209db3:      	movq	%rcx, %rdx
  209db6:      	cmovaq	%rax, %rdx
  209dba:      	lock
  209dbb:      	cmpxchgq	%rdx, 0x1c750d(%rip)    # 0x3d12d0 <_RNvCs9j6qJjDxNX3_15block_lsd_bench4PEAK.llvm.13354737551727885710>
  209dc3:      	jne	0x209db0 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x2c0>
  209dc5:      	vmovdqu	(%r12), %xmm0
  209dcb:      	movq	(%rsp), %rax
  209dcf:      	leaq	-0x1(%r14), %rcx
  209dd3:      	movl	$0x1, %esi
  209dd8:      	cmpq	$0x4, %rcx
  209ddc:      	jb	0x209eb5 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x3c5>
  209de2:      	cmpq	$0x20, %rcx
  209de6:      	jae	0x209def <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x2ff>
  209de8:      	xorl	%edx, %edx
  209dea:      	jmp	0x209e6e <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x37e>
  209def:      	movq	(%rsp), %rdi
  209df3:      	movq	%rcx, %rdx
  209df6:      	andq	$-0x20, %rdx
  209dfa:      	vshufi64x2	$0x0, %zmm0, %zmm0, %zmm1 # zmm1 = zmm0[0,1,0,1,0,1,0,1]
  209e01:      	movq	%rdx, %rax
  209e04:      	shlq	$0x4, %rax
  209e08:      	leaq	0x1(%rdx), %rsi
  209e0c:      	movq	%rdx, %r8
  209e0f:      	addq	%rdi, %rax
  209e12:      	addq	$0x180, %rdi            # imm = 0x180
  209e19:      	nopl	(%rax)
  209e20:      	vmovdqu64	%zmm1, -0x180(%rdi)
  209e27:      	vmovdqu64	%zmm1, -0x140(%rdi)
  209e2e:      	vmovdqu64	%zmm1, -0x100(%rdi)
  209e35:      	vmovdqu64	%zmm1, -0xc0(%rdi)
  209e3c:      	vmovdqu64	%zmm1, -0x80(%rdi)
  209e43:      	vmovdqu64	%zmm1, -0x40(%rdi)
  209e4a:      	vmovdqu64	%zmm1, (%rdi)
  209e50:      	vmovdqu64	%zmm1, 0x40(%rdi)
  209e57:      	addq	$0x200, %rdi            # imm = 0x200
  209e5e:      	addq	$-0x20, %r8
  209e62:      	jne	0x209e20 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x330>
  209e64:      	cmpq	%rdx, %rcx
  209e67:      	je	0x209ecd <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x3dd>
  209e69:      	testb	$0x1c, %cl
  209e6c:      	je	0x209eb5 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x3c5>
  209e6e:      	movq	(%rsp), %r9
  209e72:      	movq	%rcx, %rdi
  209e75:      	andq	$-0x4, %rdi
  209e79:      	movq	%rdx, %r8
  209e7c:      	shlq	$0x4, %rdx
  209e80:      	vshufi64x2	$0x0, %zmm0, %zmm0, %zmm1 # zmm1 = zmm0[0,1,0,1,0,1,0,1]
  209e87:      	movq	%rdi, %rax
  209e8a:      	shlq	$0x4, %rax
  209e8e:      	leaq	0x1(%rdi), %rsi
  209e92:      	subq	%rdi, %r8
  209e95:      	addq	%r9, %rax
  209e98:      	addq	%r9, %rdx
  209e9b:      	nopl	(%rax,%rax)
  209ea0:      	vmovdqu64	%zmm1, (%rdx)
  209ea6:      	addq	$0x40, %rdx
  209eaa:      	addq	$0x4, %r8
  209eae:      	jne	0x209ea0 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x3b0>
  209eb0:      	cmpq	%rdi, %rcx
  209eb3:      	je	0x209ecd <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x3dd>
  209eb5:      	movq	%r14, %rcx
  209eb8:      	subq	%rsi, %rcx
  209ebb:      	nopl	(%rax,%rax)
  209ec0:      	vmovdqu	%xmm0, (%rax)
  209ec4:      	addq	$0x10, %rax
  209ec8:      	decq	%rcx
  209ecb:      	jne	0x209ec0 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x3d0>
  209ecd:      	vmovdqu	(%r12), %xmm0
  209ed3:      	vmovdqu	%xmm0, (%rax)
  209ed7:      	leaq	0x60(%rsp), %rdi
  209edc:      	leaq	0xc0(%rsp), %rcx
  209ee4:      	movq	%r12, %rsi
  209ee7:      	movq	%r14, %rdx
  209eea:      	vzeroupper
  209eed:      	callq	0x19f080 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared5utils19get_full_histogramsINtB6_6RecordyKj2_EyEB6_>
  209ef2:      	movq	0x10(%rsp), %rax
  209ef7:      	movq	0x68(%rsp), %r15
  209efc:      	movq	0x70(%rsp), %r13
  209f01:      	movq	0x18(%rsp), %r11
  209f06:      	movabsq	$0x7fffffffffffffc0, %rcx # imm = 0x7FFFFFFFFFFFFFC0
  209f10:      	xorl	%ebx, %ebx
  209f12:      	movq	%r12, 0x30(%rsp)
  209f17:      	movl	%eax, %ebp
  209f19:      	andq	%rax, %rcx
  209f1c:      	andl	$0x30, %ebp
  209f1f:      	movq	%r15, 0x28(%rsp)
  209f24:      	movq	%r13, 0x38(%rsp)
  209f29:      	movq	%rcx, 0x48(%rsp)
  209f2e:      	movq	%rbp, 0x40(%rsp)
  209f33:      	jmp	0x209f5f <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x46f>
  209f35:      	nopw	%cs:(%rax,%rax)
  209f40:      	movq	%r12, %rdi
  209f43:      	callq	*0x1c4f4f(%rip)         # 0x3cee98 <writev+0x3cee98>
  209f49:      	movq	0x50(%rsp), %r11
  209f4e:      	movq	0x30(%rsp), %r12
  209f53:      	xorl	$0x1, %ebx
  209f56:      	testq	%r11, %r11
  209f59:      	je	0x20a21b <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x72b>
  209f5f:      	leaq	-0x1(%r11), %rax
  209f63:      	jmp	0x209f79 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x489>
  209f65:      	nopw	%cs:(%rax,%rax)
  209f70:      	testq	%r11, %r11
  209f73:      	je	0x20a21b <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x72b>
  209f79:      	movq	%r11, %rbp
  209f7c:      	decq	%r11
  209f7f:      	cmpq	%r13, %rax
  209f82:      	jae	0x20a31c <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x82c>
  209f88:      	leaq	(%r11,%r11,2), %rcx
  209f8c:      	movq	0x10(%r15,%rcx,8), %rdx
  209f91:      	testq	%rdx, %rdx
  209f94:      	je	0x209f70 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x480>
  209f96:      	movq	0x8(%r15,%rcx,8), %rsi
  209f9b:      	leaq	(,%rdx,8), %rcx
  209fa3:      	xorl	%edi, %edi
  209fa5:      	xorl	%r8d, %r8d
  209fa8:      	nopl	(%rax,%rax)
  209fb0:      	cmpq	$0x1, (%rsi,%r8)
  209fb5:      	sbbl	$-0x1, %edi
  209fb8:      	cmpl	$0x1, %edi
  209fbb:      	ja	0x209fd0 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x4e0>
  209fbd:      	addq	$0x8, %r8
  209fc1:      	cmpq	%r8, %rcx
  209fc4:      	jne	0x209fb0 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x4c0>
  209fc6:      	jmp	0x209f70 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x480>
  209fc8:      	nopl	(%rax,%rax)
  209fd0:      	movq	(%rsp), %r13
  209fd4:      	testl	%ebx, %ebx
  209fd6:      	movq	%r12, %r15
  209fd9:      	movq	%r11, 0x50(%rsp)
  209fde:      	movq	%rbx, 0x58(%rsp)
  209fe3:      	cmoveq	%r13, %r15
  209fe7:      	cmoveq	%r12, %r13
  209feb:      	leaq	0x78(%rsp), %rdi
  209ff0:      	callq	0x1b0810 <_RNvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared5utils11prefix_sums>
  209ff5:      	movq	0x90(%rsp), %rcx
  209ffd:      	movq	0x78(%rsp), %rax
  20a002:      	movq	0x98(%rsp), %r12
  20a00a:      	movq	0xa0(%rsp), %rbx
  20a012:      	leaq	-0x1(%rbp), %r11
  20a016:      	movq	%rcx, 0x20(%rsp)
  20a01b:      	testq	%rax, %rax
  20a01e:      	je	0x20a049 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x559>
  20a020:      	movq	0x80(%rsp), %rdi
  20a028:      	movzbl	0x1c72a9(%rip), %ecx    # 0x3d12d8 <_RNvCs9j6qJjDxNX3_15block_lsd_bench5TRACK.0.llvm.13354737551727885710>
  20a02f:      	testb	%cl, %cl
  20a031:      	je	0x20a03f <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x54f>
  20a033:      	shlq	$0x3, %rax
  20a037:      	lock
  20a038:      	subq	%rax, 0x1c7289(%rip)    # 0x3d12c8 <_RNvCs9j6qJjDxNX3_15block_lsd_bench4LIVE.llvm.13354737551727885710>
  20a03f:      	callq	*0x1c4e53(%rip)         # 0x3cee98 <writev+0x3cee98>
  20a045:      	leaq	-0x1(%rbp), %r11
  20a049:      	movq	0xa8(%rsp), %rax
  20a051:      	testq	%rax, %rax
  20a054:      	je	0x20a07f <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x58f>
  20a056:      	movq	0xb0(%rsp), %rdi
  20a05e:      	movzbl	0x1c7273(%rip), %ecx    # 0x3d12d8 <_RNvCs9j6qJjDxNX3_15block_lsd_bench5TRACK.0.llvm.13354737551727885710>
  20a065:      	testb	%cl, %cl
  20a067:      	je	0x20a075 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x585>
  20a069:      	shlq	$0x3, %rax
  20a06d:      	lock
  20a06e:      	subq	%rax, 0x1c7253(%rip)    # 0x3d12c8 <_RNvCs9j6qJjDxNX3_15block_lsd_bench4LIVE.llvm.13354737551727885710>
  20a075:      	callq	*0x1c4e1d(%rip)         # 0x3cee98 <writev+0x3cee98>
  20a07b:      	leaq	-0x1(%rbp), %r11
  20a07f:      	movq	0x48(%rsp), %rcx
  20a084:      	movq	0x18(%rsp), %rax
  20a089:      	subl	%ebp, %eax
  20a08b:      	movq	0x40(%rsp), %rbp
  20a090:      	shll	$0x3, %eax
  20a093:      	andl	$0x38, %eax
  20a096:      	addq	%r13, %rcx
  20a099:      	nopl	(%rax)
  20a0a0:      	shrxq	%rax, (%r13), %rdx
  20a0a6:      	movzbl	%dl, %edi
  20a0a9:      	cmpq	%rbx, %rdi
  20a0ac:      	jae	0x20a2d9 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x7e9>
  20a0b2:      	shrxq	%rax, 0x10(%r13), %rdx
  20a0b8:      	shrxq	%rax, 0x20(%r13), %rsi
  20a0be:      	shrxq	%rax, 0x30(%r13), %r8
  20a0c4:      	movzbl	%dl, %r9d
  20a0c8:      	movq	(%r12,%rdi,8), %rdx
  20a0cc:      	leaq	0x1(%rdx), %r10
  20a0d0:      	movq	%r10, (%r12,%rdi,8)
  20a0d4:      	cmpq	%rbx, %r9
  20a0d7:      	jae	0x20a2d6 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x7e6>
  20a0dd:      	movzbl	%sil, %edi
  20a0e1:      	movq	(%r12,%r9,8), %rsi
  20a0e5:      	leaq	0x1(%rsi), %r10
  20a0e9:      	movq	%r10, (%r12,%r9,8)
  20a0ed:      	cmpq	%rbx, %rdi
  20a0f0:      	jae	0x20a2d9 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x7e9>
  20a0f6:      	movzbl	%r8b, %r9d
  20a0fa:      	movq	(%r12,%rdi,8), %r8
  20a0fe:      	leaq	0x1(%r8), %r10
  20a102:      	movq	%r10, (%r12,%rdi,8)
  20a106:      	cmpq	%rbx, %r9
  20a109:      	jae	0x20a2d6 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x7e6>
  20a10f:      	movq	(%r12,%r9,8), %rdi
  20a113:      	leaq	0x1(%rdi), %r10
  20a117:      	movq	%r10, (%r12,%r9,8)
  20a11b:      	cmpq	%r14, %rdx
  20a11e:      	jae	0x20a2ec <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x7fc>
  20a124:      	vmovdqu	(%r13), %xmm0
  20a12a:      	shlq	$0x4, %rdx
  20a12e:      	vmovdqu	%xmm0, (%r15,%rdx)
  20a134:      	cmpq	%r14, %rsi
  20a137:      	jae	0x20a2e7 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x7f7>
  20a13d:      	vmovdqu	0x10(%r13), %xmm0
  20a143:      	shlq	$0x4, %rsi
  20a147:      	vmovdqu	%xmm0, (%r15,%rsi)
  20a14d:      	cmpq	%r14, %r8
  20a150:      	jae	0x20a2e2 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x7f2>
  20a156:      	vmovdqu	0x20(%r13), %xmm0
  20a15c:      	shlq	$0x4, %r8
  20a160:      	vmovdqu	%xmm0, (%r15,%r8)
  20a166:      	cmpq	%r14, %rdi
  20a169:      	jae	0x20a2ef <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x7ff>
  20a16f:      	vmovdqu	0x30(%r13), %xmm0
  20a175:      	shlq	$0x4, %rdi
  20a179:      	addq	$0x40, %r13
  20a17d:      	vmovdqu	%xmm0, (%r15,%rdi)
  20a183:      	cmpq	%rcx, %r13
  20a186:      	jne	0x20a0a0 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x5b0>
  20a18c:      	movq	0x38(%rsp), %r13
  20a191:      	testq	%rbp, %rbp
  20a194:      	je	0x20a1e3 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x6f3>
  20a196:      	xorl	%edx, %edx
  20a198:      	nopl	(%rax,%rax)
  20a1a0:      	shrxq	%rax, (%rcx,%rdx), %rsi
  20a1a6:      	movzbl	%sil, %edi
  20a1aa:      	cmpq	%rbx, %rdi
  20a1ad:      	jae	0x20a313 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x823>
  20a1b3:      	movq	(%r12,%rdi,8), %rsi
  20a1b7:      	leaq	0x1(%rsi), %r8
  20a1bb:      	movq	%r8, (%r12,%rdi,8)
  20a1bf:      	cmpq	%r14, %rsi
  20a1c2:      	jae	0x20a304 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x814>
  20a1c8:      	leaq	(%rcx,%rdx), %rdi
  20a1cc:      	shlq	$0x4, %rsi
  20a1d0:      	addq	$0x10, %rdx
  20a1d4:      	vmovdqu	(%rdi), %xmm0
  20a1d8:      	vmovdqu	%xmm0, (%r15,%rsi)
  20a1de:      	cmpq	%rdx, %rbp
  20a1e1:      	jne	0x20a1a0 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x6b0>
  20a1e3:      	movq	0x20(%rsp), %rcx
  20a1e8:      	movq	0x28(%rsp), %r15
  20a1ed:      	movq	0x58(%rsp), %rbx
  20a1f2:      	testq	%rcx, %rcx
  20a1f5:      	je	0x209f4e <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x45e>
  20a1fb:      	movzbl	0x1c70d6(%rip), %eax    # 0x3d12d8 <_RNvCs9j6qJjDxNX3_15block_lsd_bench5TRACK.0.llvm.13354737551727885710>
  20a202:      	testb	%al, %al
  20a204:      	je	0x209f40 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x450>
  20a20a:      	shlq	$0x3, %rcx
  20a20e:      	lock
  20a20f:      	subq	%rcx, 0x1c70b2(%rip)    # 0x3d12c8 <_RNvCs9j6qJjDxNX3_15block_lsd_bench4LIVE.llvm.13354737551727885710>
  20a216:      	jmp	0x209f40 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x450>
  20a21b:      	testl	%ebx, %ebx
  20a21d:      	je	0x20a231 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x741>
  20a21f:      	movq	(%rsp), %rsi
  20a223:      	movq	0x10(%rsp), %rdx
  20a228:      	movq	%r12, %rdi
  20a22b:      	callq	*0x1c4cb7(%rip)         # 0x3ceee8 <writev+0x3ceee8>
  20a231:      	leaq	0x8(%r15), %rbx
  20a235:      	jmp	0x20a24f <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x75f>
  20a237:      	nopw	(%rax,%rax)
  20a240:      	callq	*0x1c4c52(%rip)         # 0x3cee98 <writev+0x3cee98>
  20a246:      	addq	$0x18, %rbx
  20a24a:      	decq	%r13
  20a24d:      	je	0x20a274 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x784>
  20a24f:      	movq	-0x8(%rbx), %rax
  20a253:      	testq	%rax, %rax
  20a256:      	je	0x20a246 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x756>
  20a258:      	movq	(%rbx), %rdi
  20a25b:      	movzbl	0x1c7076(%rip), %ecx    # 0x3d12d8 <_RNvCs9j6qJjDxNX3_15block_lsd_bench5TRACK.0.llvm.13354737551727885710>
  20a262:      	testb	%cl, %cl
  20a264:      	je	0x20a240 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x750>
  20a266:      	shlq	$0x3, %rax
  20a26a:      	lock
  20a26b:      	subq	%rax, 0x1c7056(%rip)    # 0x3d12c8 <_RNvCs9j6qJjDxNX3_15block_lsd_bench4LIVE.llvm.13354737551727885710>
  20a272:      	jmp	0x20a240 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x750>
  20a274:      	movq	0x60(%rsp), %rax
  20a279:      	testq	%rax, %rax
  20a27c:      	je	0x20a2a2 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x7b2>
  20a27e:      	movzbl	0x1c7053(%rip), %ecx    # 0x3d12d8 <_RNvCs9j6qJjDxNX3_15block_lsd_bench5TRACK.0.llvm.13354737551727885710>
  20a285:      	testb	%cl, %cl
  20a287:      	je	0x20a299 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x7a9>
  20a289:      	shlq	$0x3, %rax
  20a28d:      	leaq	(%rax,%rax,2), %rax
  20a291:      	lock
  20a292:      	subq	%rax, 0x1c702f(%rip)    # 0x3d12c8 <_RNvCs9j6qJjDxNX3_15block_lsd_bench4LIVE.llvm.13354737551727885710>
  20a299:      	movq	%r15, %rdi
  20a29c:      	callq	*0x1c4bf6(%rip)         # 0x3cee98 <writev+0x3cee98>
  20a2a2:      	movzbl	0x1c702f(%rip), %eax    # 0x3d12d8 <_RNvCs9j6qJjDxNX3_15block_lsd_bench5TRACK.0.llvm.13354737551727885710>
  20a2a9:      	testb	%al, %al
  20a2ab:      	je	0x20a2ba <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x7ca>
  20a2ad:      	movq	0x10(%rsp), %rax
  20a2b2:      	lock
  20a2b3:      	subq	%rax, 0x1c700e(%rip)    # 0x3d12c8 <_RNvCs9j6qJjDxNX3_15block_lsd_bench4LIVE.llvm.13354737551727885710>
  20a2ba:      	movq	(%rsp), %rdi
  20a2be:      	callq	*0x1c4bd4(%rip)         # 0x3cee98 <writev+0x3cee98>
  20a2c4:      	addq	$0xe8, %rsp
  20a2cb:      	popq	%rbx
  20a2cc:      	popq	%r12
  20a2ce:      	popq	%r13
  20a2d0:      	popq	%r14
  20a2d2:      	popq	%r15
  20a2d4:      	popq	%rbp
  20a2d5:      	retq
  20a2d6:      	movq	%r9, %rdi
  20a2d9:      	leaq	0x1c0330(%rip), %rdx    # 0x3ca610 <anon.624aa100f296a21f1c5c6d547a0f7a35.15.llvm.14768152166618875051+0xc0>
  20a2e0:      	jmp	0x20a2f9 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x809>
  20a2e2:      	movq	%r8, %rdi
  20a2e5:      	jmp	0x20a2ef <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x7ff>
  20a2e7:      	movq	%rsi, %rdi
  20a2ea:      	jmp	0x20a2ef <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x7ff>
  20a2ec:      	movq	%rdx, %rdi
  20a2ef:      	movq	%r14, %rbx
  20a2f2:      	leaq	0x1c032f(%rip), %rdx    # 0x3ca628 <anon.624aa100f296a21f1c5c6d547a0f7a35.15.llvm.14768152166618875051+0xd8>
  20a2f9:      	movq	%rbx, %rsi
  20a2fc:      	callq	*0x1c4bb6(%rip)         # 0x3ceeb8 <writev+0x3ceeb8>
  20a302:      	jmp	0x20a32f <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x83f>
  20a304:      	movq	%rsi, %rdi
  20a307:      	movq	%r14, %rbx
  20a30a:      	leaq	0x1c0347(%rip), %rdx    # 0x3ca658 <anon.624aa100f296a21f1c5c6d547a0f7a35.15.llvm.14768152166618875051+0x108>
  20a311:      	jmp	0x20a2f9 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x809>
  20a313:      	leaq	0x1c0326(%rip), %rdx    # 0x3ca640 <anon.624aa100f296a21f1c5c6d547a0f7a35.15.llvm.14768152166618875051+0xf0>
  20a31a:      	jmp	0x20a2f9 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x809>
  20a31c:      	leaq	0x1c03dd(%rip), %rdx    # 0x3ca700 <anon.624aa100f296a21f1c5c6d547a0f7a35.15.llvm.14768152166618875051+0x1b0>
  20a323:      	movq	%r11, %rdi
  20a326:      	movq	%r13, %rsi
  20a329:      	callq	*0x1c4b89(%rip)         # 0x3ceeb8 <writev+0x3ceeb8>
  20a32f:      	ud2
  20a331:      	movq	0x10(%rsp), %rsi
  20a336:      	movl	$0x8, %edi
  20a33b:      	callq	*0x1c4b5f(%rip)         # 0x3ceea0 <writev+0x3ceea0>
  20a341:      	leaq	0x78(%rsp), %rdx
  20a346:      	movq	%r12, %rdi
  20a349:      	movq	%r14, %rsi
  20a34c:      	callq	0x32ca70 <_RINvNtNtNtCs3sPX1WnuliO_4core5slice4sort8unstable7ipnsortINtCs9j6qJjDxNX3_15block_lsd_bench6RecordyKj2_ENCINvMB6_SBT_16sort_unstable_byNCINvNtNtBW_6shared4core4sortBT_yKj3_E0E0EBW_>
  20a351:      	jmp	0x20a2c4 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x7d4>
  20a356:      	movq	%rax, %rbx
  20a359:      	jmp	0x20a399 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x8a9>
  20a35b:      	jmp	0x20a35d <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x86d>
  20a35d:      	movq	%rax, %rbx
  20a360:      	jmp	0x20a38f <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x89f>
  20a362:      	movq	0x20(%rsp), %rcx
  20a367:      	movq	%rax, %rbx
  20a36a:      	testq	%rcx, %rcx
  20a36d:      	je	0x20a38f <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x89f>
  20a36f:      	movzbl	0x1c6f62(%rip), %eax    # 0x3d12d8 <_RNvCs9j6qJjDxNX3_15block_lsd_bench5TRACK.0.llvm.13354737551727885710>
  20a376:      	testb	%al, %al
  20a378:      	je	0x20a386 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x896>
  20a37a:      	shlq	$0x3, %rcx
  20a37e:      	lock
  20a37f:      	subq	%rcx, 0x1c6f42(%rip)    # 0x3d12c8 <_RNvCs9j6qJjDxNX3_15block_lsd_bench4LIVE.llvm.13354737551727885710>
  20a386:      	movq	%r12, %rdi
  20a389:      	callq	*0x1c4b09(%rip)         # 0x3cee98 <writev+0x3cee98>
  20a38f:      	leaq	0x60(%rsp), %rdi
  20a394:      	callq	0x1ec8a0 <_RINvNtCs3sPX1WnuliO_4core3ptr9drop_glueINtNtCs5xahNnzoIEW_5alloc3vec3VecIBC_jEEECs9j6qJjDxNX3_15block_lsd_bench>
  20a399:      	movzbl	0x1c6f38(%rip), %eax    # 0x3d12d8 <_RNvCs9j6qJjDxNX3_15block_lsd_bench5TRACK.0.llvm.13354737551727885710>
  20a3a0:      	testb	%al, %al
  20a3a2:      	je	0x20a3b1 <_RINvNtNtCs9j6qJjDxNX3_15block_lsd_bench6shared4core4sortINtB6_6RecordyKj2_EyKj3_EB6_+0x8c1>
  20a3a4:      	movq	0x10(%rsp), %rax
  20a3a9:      	lock
  20a3aa:      	subq	%rax, 0x1c6f17(%rip)    # 0x3d12c8 <_RNvCs9j6qJjDxNX3_15block_lsd_bench4LIVE.llvm.13354737551727885710>
  20a3b1:      	movq	(%rsp), %rdi
  20a3b5:      	callq	*0x1c4add(%rip)         # 0x3cee98 <writev+0x3cee98>
  20a3bb:      	movq	%rbx, %rdi
  20a3be:      	callq	0x3b9430 <_Unwind_Resume@plt>
