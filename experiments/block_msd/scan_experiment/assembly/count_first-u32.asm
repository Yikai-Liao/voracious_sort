0000000000062c50 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>>:
   62c50:	push   %rbp
   62c51:	push   %r15
   62c53:	push   %r14
   62c55:	push   %r13
   62c57:	push   %r12
   62c59:	push   %rbx
   62c5a:	sub    $0x218,%rsp
   62c61:	lea    -0x1(%rcx),%rax
   62c65:	cmp    $0x8,%rax
   62c69:	jae    6382d <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0xbdd>
   62c6f:	test   %r8,%r8
   62c72:	je     63846 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0xbf6>
   62c78:	cmp    $0x81,%r9
   62c7f:	jae    6385f <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0xc0f>
   62c85:	mov    %rdi,%r13
   62c88:	cmp    $0x1,%rdx
   62c8c:	ja     62cb1 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x61>
   62c8e:	vpxor  %xmm0,%xmm0,%xmm0
   62c92:	vmovdqu64 %zmm0,0x0(%r13)
   62c99:	mov    %r13,%rax
   62c9c:	add    $0x218,%rsp
   62ca3:	pop    %rbx
   62ca4:	pop    %r12
   62ca6:	pop    %r13
   62ca8:	pop    %r14
   62caa:	pop    %r15
   62cac:	pop    %rbp
   62cad:	vzeroupper
   62cb0:	ret
   62cb1:	cmp    %r9,%rdx
   62cb4:	jbe    62ceb <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x9b>
   62cb6:	mov    (%rsi),%r11d
   62cb9:	lea    -0x4(,%rdx,4),%rdi
   62cc1:	mov    $0x1,%eax
   62cc6:	xor    %ebx,%ebx
   62cc8:	nopl   0x0(%rax,%rax,1)
   62cd0:	mov    0x4(%rsi,%rbx,1),%ebp
   62cd4:	cmp    %r11d,%ebp
   62cd7:	jne    62ee1 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x291>
   62cdd:	inc    %rax
   62ce0:	add    $0x4,%rbx
   62ce4:	cmp    %rbx,%rdi
   62ce7:	jne    62cd0 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x80>
   62ce9:	jmp    62c8e <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x3e>
   62ceb:	lea    0x77(%rsp),%rax
   62cf0:	mov    %rax,0xd8(%rsp)
   62cf8:	cmp    $0x15,%rdx
   62cfc:	jae    6388e <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0xc3e>
   62d02:	movabs $0x3ffffffffffffffe,%rcx
   62d0c:	mov    $0x3e,%dil
   62d0f:	lea    -0x1(%rdx),%r8d
   62d13:	lea    0x4(%rsi),%rax
   62d17:	add    %rdx,%rcx
   62d1a:	bzhi   %rdi,%rcx,%rcx
   62d1f:	and    $0x3,%r8d
   62d23:	je     62d77 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x127>
   62d25:	xor    %r9d,%r9d
   62d28:	xor    %r10d,%r10d
   62d2b:	jmp    62d43 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0xf3>
   62d2d:	add    %rsi,%rdi
   62d30:	mov    %r11d,(%rdi)
   62d33:	add    $0x4,%rax
   62d37:	inc    %r10
   62d3a:	add    $0x4,%r9
   62d3e:	cmp    %r8,%r10
   62d41:	je     62d77 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x127>
   62d43:	mov    -0x4(%rax),%edi
   62d46:	mov    (%rax),%r11d
   62d49:	cmp    %edi,%r11d
   62d4c:	jae    62d33 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0xe3>
   62d4e:	lea    -0x4(%rax),%rbx
   62d52:	mov    %edi,(%rax)
   62d54:	mov    %rsi,%rdi
   62d57:	cmp    %rsi,%rbx
   62d5a:	je     62d30 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0xe0>
   62d5c:	mov    %r9,%rdi
   62d5f:	nop
   62d60:	mov    -0x4(%rsi,%rdi,1),%ebx
   62d64:	cmp    %ebx,%r11d
   62d67:	jae    62d2d <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0xdd>
   62d69:	mov    %ebx,(%rsi,%rdi,1)
   62d6c:	add    $0xfffffffffffffffc,%rdi
   62d70:	jne    62d60 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x110>
   62d72:	mov    %rsi,%rdi
   62d75:	jmp    62d30 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0xe0>
   62d77:	cmp    $0x3,%rcx
   62d7b:	jb     62c8e <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x3e>
   62d81:	lea    (%rsi,%rdx,4),%rcx
   62d85:	jmp    62d9a <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x14a>
   62d87:	mov    %rdi,%r8
   62d8a:	mov    %edx,(%r8)
   62d8d:	add    $0x10,%rax
   62d91:	cmp    %rcx,%rax
   62d94:	je     62c8e <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x3e>
   62d9a:	mov    -0x4(%rax),%r8d
   62d9e:	mov    (%rax),%edx
   62da0:	cmp    %r8d,%edx
   62da3:	jae    62de0 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x190>
   62da5:	lea    -0x4(%rax),%rdi
   62da9:	mov    %r8d,(%rax)
   62dac:	mov    %rsi,%r8
   62daf:	cmp    %rsi,%rdi
   62db2:	je     62e3b <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1eb>
   62db8:	nopl   0x0(%rax,%rax,1)
   62dc0:	mov    -0x4(%rdi),%r8d
   62dc4:	cmp    %r8d,%edx
   62dc7:	jae    62e38 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1e8>
   62dc9:	mov    %r8d,(%rdi)
   62dcc:	add    $0xfffffffffffffffc,%rdi
   62dd0:	cmp    %rsi,%rdi
   62dd3:	jne    62dc0 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x170>
   62dd5:	mov    %rsi,%r8
   62dd8:	jmp    62e3b <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1eb>
   62dda:	nopw   0x0(%rax,%rax,1)
   62de0:	mov    (%rax),%edi
   62de2:	mov    0x4(%rax),%edx
   62de5:	cmp    %edi,%edx
   62de7:	jae    62e47 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1f7>
   62de9:	mov    %edi,0x4(%rax)
   62dec:	mov    %rsi,%rdi
   62def:	cmp    %rsi,%rax
   62df2:	je     62e18 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1c8>
   62df4:	mov    %rax,%rdi
   62df7:	nopw   0x0(%rax,%rax,1)
   62e00:	mov    -0x4(%rdi),%r8d
   62e04:	cmp    %r8d,%edx
   62e07:	jae    62e18 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1c8>
   62e09:	mov    %r8d,(%rdi)
   62e0c:	add    $0xfffffffffffffffc,%rdi
   62e10:	cmp    %rsi,%rdi
   62e13:	jne    62e00 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1b0>
   62e15:	mov    %rsi,%rdi
   62e18:	mov    %edx,(%rdi)
   62e1a:	mov    0x4(%rax),%r8d
   62e1e:	mov    0x8(%rax),%edx
   62e21:	cmp    %r8d,%edx
   62e24:	jb     62e53 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x203>
   62e26:	mov    0x8(%rax),%r8d
   62e2a:	mov    0xc(%rax),%edx
   62e2d:	cmp    %r8d,%edx
   62e30:	jae    62d8d <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x13d>
   62e36:	jmp    62ea0 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x250>
   62e38:	mov    %rdi,%r8
   62e3b:	mov    %edx,(%r8)
   62e3e:	mov    (%rax),%edi
   62e40:	mov    0x4(%rax),%edx
   62e43:	cmp    %edi,%edx
   62e45:	jb     62de9 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x199>
   62e47:	mov    0x4(%rax),%r8d
   62e4b:	mov    0x8(%rax),%edx
   62e4e:	cmp    %r8d,%edx
   62e51:	jae    62e26 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1d6>
   62e53:	lea    0x4(%rax),%rdi
   62e57:	mov    %r8d,0x8(%rax)
   62e5b:	mov    %rsi,%r8
   62e5e:	cmp    %rsi,%rdi
   62e61:	je     62e8d <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x23d>
   62e63:	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   62e70:	mov    -0x4(%rdi),%r8d
   62e74:	cmp    %r8d,%edx
   62e77:	jae    62e8a <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x23a>
   62e79:	mov    %r8d,(%rdi)
   62e7c:	add    $0xfffffffffffffffc,%rdi
   62e80:	cmp    %rsi,%rdi
   62e83:	jne    62e70 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x220>
   62e85:	mov    %rsi,%r8
   62e88:	jmp    62e8d <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x23d>
   62e8a:	mov    %rdi,%r8
   62e8d:	mov    %edx,(%r8)
   62e90:	mov    0x8(%rax),%r8d
   62e94:	mov    0xc(%rax),%edx
   62e97:	cmp    %r8d,%edx
   62e9a:	jae    62d8d <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x13d>
   62ea0:	lea    0x8(%rax),%rdi
   62ea4:	mov    %r8d,0xc(%rax)
   62ea8:	mov    %rsi,%r8
   62eab:	cmp    %rsi,%rdi
   62eae:	je     62d8a <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x13a>
   62eb4:	data16 data16 cs nopw 0x0(%rax,%rax,1)
   62ec0:	mov    -0x4(%rdi),%r8d
   62ec4:	cmp    %r8d,%edx
   62ec7:	jae    62d87 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x137>
   62ecd:	mov    %r8d,(%rdi)
   62ed0:	add    $0xfffffffffffffffc,%rdi
   62ed4:	cmp    %rsi,%rdi
   62ed7:	jne    62ec0 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x270>
   62ed9:	mov    %rsi,%r8
   62edc:	jmp    62d8a <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x13a>
   62ee1:	cmp    $0x2,%rax
   62ee5:	lea    0x0(,%rdx,4),%r12
   62eed:	lea    -0x8(,%rdx,4),%rdi
   62ef5:	setae  %al
   62ef8:	cmp    %rbx,%rdi
   62efb:	jne    62f1e <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x2ce>
   62efd:	cmp    %ebp,%r11d
   62f00:	jb     62c8e <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x3e>
   62f06:	mov    %rdx,%rcx
   62f09:	shr    $1,%rcx
   62f0c:	cmp    $0x10,%rdx
   62f10:	jae    62fa8 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x358>
   62f16:	xor    %r8d,%r8d
   62f19:	jmp    631e4 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x594>
   62f1e:	add    $0x8,%rbx
   62f22:	mov    %ebp,%edi
   62f24:	cmp    %ebp,%r11d
   62f27:	jae    62f50 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x300>
   62f29:	nopl   0x0(%rax)
   62f30:	mov    %edi,%r10d
   62f33:	mov    (%rsi,%rbx,1),%edi
   62f36:	cmp    %edi,%r10d
   62f39:	ja     62f6d <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x31d>
   62f3b:	add    $0x4,%rbx
   62f3f:	cmp    %rbx,%r12
   62f42:	jne    62f30 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x2e0>
   62f44:	jmp    62efd <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x2ad>
   62f46:	cs nopw 0x0(%rax,%rax,1)
   62f50:	mov    %edi,%r10d
   62f53:	mov    (%rsi,%rbx,1),%edi
   62f56:	cmp    %edi,%r10d
   62f59:	jb     62f6d <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x31d>
   62f5b:	sete   %r10b
   62f5f:	add    $0x4,%rbx
   62f63:	or     %r10b,%al
   62f66:	cmp    %rbx,%r12
   62f69:	jne    62f50 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x300>
   62f6b:	jmp    62efd <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x2ad>
   62f6d:	test   %rcx,%rcx
   62f70:	je     638cc <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0xc7c>
   62f76:	mov    %rdx,%rax
   62f79:	or     %r8,%rax
   62f7c:	mov    %rdx,0x10(%rsp)
   62f81:	shr    $0x20,%rax
   62f85:	je     62fc4 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x374>
   62f87:	mov    %rdx,%rax
   62f8a:	xor    %edx,%edx
   62f8c:	div    %r8
   62f8f:	mov    %rdx,%rdi
   62f92:	mov    %rax,%r15
   62f95:	cmp    $0x20,%rcx
   62f99:	ja     62fd6 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x386>
   62f9b:	mov    $0x20,%eax
   62fa0:	xor    %edx,%edx
   62fa2:	div    %ecx
   62fa4:	mov    %eax,%ebx
   62fa6:	jmp    62fdd <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x38d>
   62fa8:	movabs $0xfffffffffffffe0,%r9
   62fb2:	cmp    $0x40,%rdx
   62fb6:	jae    630ef <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x49f>
   62fbc:	xor    %r8d,%r8d
   62fbf:	jmp    63183 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x533>
   62fc4:	mov    %edx,%eax
   62fc6:	xor    %edx,%edx
   62fc8:	div    %r8d
   62fcb:	mov    %edx,%edi
   62fcd:	mov    %eax,%r15d
   62fd0:	cmp    $0x20,%rcx
   62fd4:	jbe    62f9b <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x34b>
   62fd6:	mov    $0x20,%edx
   62fdb:	xor    %ebx,%ebx
   62fdd:	cmp    $0x1,%rdx
   62fe1:	mov    $0x2,%eax
   62fe6:	mov    %r15,%r14
   62fe9:	mov    %rdi,0x48(%rsp)
   62fee:	sbb    $0xffffffffffffffff,%rbx
   62ff2:	cmp    $0x1,%rdi
   62ff6:	shlx   %rcx,%rax,%rax
   62ffb:	sbb    $0xffffffffffffffff,%r14
   62fff:	cmp    %rax,%r14
   63002:	cmovae %rax,%r14
   63006:	lea    0x8(%r14,%rbx,2),%rbp
   6300b:	mov    %rbp,%rax
   6300e:	mul    %r8
   63011:	jo     638a9 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0xc59>
   63017:	mov    %rax,%rdi
   6301a:	lea    0x0(,%rax,4),%r12
   63022:	movabs $0x3ffffffffffffffe,%rax
   6302c:	movabs $0x7ffffffffffffff8,%r10
   63036:	inc    %rax
   63039:	lea    0x4(%r10),%rdx
   6303d:	cmp    %rax,%rdi
   63040:	seta   %al
   63043:	cmp    %rdx,%r12
   63046:	seta   %dl
   63049:	or     %al,%dl
   6304b:	je     63058 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x408>
   6304d:	xor    %edi,%edi
   6304f:	mov    %r12,%rsi
   63052:	call   *0xa24c8(%rip)        # 105520 <_DYNAMIC+0x2b8>
   63058:	mov    %r9,0x88(%rsp)
   63060:	mov    %rcx,0x68(%rsp)
   63065:	mov    %r8,0x28(%rsp)
   6306a:	mov    %rdi,0x40(%rsp)
   6306f:	test   %r12,%r12
   63072:	je     63440 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x7f0>
   63078:	mov    %r15,0x18(%rsp)
   6307d:	mov    %rsi,%r15
   63080:	call   *0xa24a2(%rip)        # 105528 <_DYNAMIC+0x2c0>
   63086:	mov    %r12,%rdi
   63089:	call   *0xa24a1(%rip)        # 105530 <malloc@GLIBC_2.2.5>
   6308f:	mov    %rax,0x30(%rsp)
   63094:	test   %rax,%rax
   63097:	je     638d9 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0xc89>
   6309d:	movzbl 0xa4814(%rip),%eax        # 1078b8 <scan_experiment::TRACK>
   630a4:	movabs $0x7ffffffffffffff8,%r10
   630ae:	test   %al,%al
   630b0:	je     63467 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x817>
   630b6:	mov    %r12,%rdx
   630b9:	lock xadd %rdx,0xa47e6(%rip)        # 1078a8 <scan_experiment::LIVE>
   630c2:	mov    %r15,%rsi
   630c5:	mov    0xa47e4(%rip),%rax        # 1078b0 <scan_experiment::PEAK>
   630cc:	add    %r12,%rdx
   630cf:	nop
   630d0:	cmp    %rdx,%rax
   630d3:	mov    %rdx,%rdi
   630d6:	cmova  %rax,%rdi
   630da:	lock cmpxchg %rdi,0xa47cd(%rip)        # 1078b0 <scan_experiment::PEAK>
   630e3:	jne    630d0 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x480>
   630e5:	mov    0x40(%rsp),%rdi
   630ea:	jmp    6346f <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x81f>
   630ef:	mov    %rdx,%r11
   630f2:	shr    $0x6,%r11
   630f6:	lea    -0x40(%r12,%rsi,1),%r14
   630fb:	mov    %rcx,%r8
   630fe:	and    %r9,%r8
   63101:	lea    0x40(%rsi),%rbx
   63105:	xor    %r15d,%r15d
   63108:	shl    $0x5,%r11
   6310c:	neg    %r11
   6310f:	nop
   63110:	vpshufd $0x1b,(%r14,%r15,4),%zmm0
   63118:	vpshufd $0x1b,-0x40(%r14,%r15,4),%zmm1
   63121:	vpshufd $0x1b,-0x40(%rbx),%zmm2
   63129:	vshufi64x2 $0x1b,%zmm0,%zmm0,%zmm0
   63130:	vshufi64x2 $0x1b,%zmm1,%zmm1,%zmm1
   63137:	vmovdqu64 %zmm0,-0x40(%rbx)
   6313e:	vpshufd $0x1b,(%rbx),%zmm0
   63145:	vmovdqu64 %zmm1,(%rbx)
   6314b:	vshufi64x2 $0x1b,%zmm2,%zmm2,%zmm1
   63152:	sub    $0xffffffffffffff80,%rbx
   63156:	vmovdqu64 %zmm1,(%r14,%r15,4)
   6315d:	vshufi64x2 $0x1b,%zmm0,%zmm0,%zmm0
   63164:	vmovdqu64 %zmm0,-0x40(%r14,%r15,4)
   6316c:	add    $0xffffffffffffffe0,%r15
   63170:	cmp    %r15,%r11
   63173:	jne    63110 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x4c0>
   63175:	cmp    %r8,%rcx
   63178:	je     6321a <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x5ca>
   6317e:	test   $0x30,%dl
   63181:	je     631e4 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x594>
   63183:	add    $0x18,%r9
   63187:	mov    %r8,%r11
   6318a:	lea    (%rsi,%r11,4),%rdi
   6318e:	lea    -0x20(%r12,%rsi,1),%r10
   63193:	neg    %r11
   63196:	mov    %r9,%r8
   63199:	mov    %rdx,%r9
   6319c:	shr    $0x4,%r9
   631a0:	and    %rcx,%r8
   631a3:	shl    $0x3,%r9
   631a7:	neg    %r9
   631aa:	nopw   0x0(%rax,%rax,1)
   631b0:	vpshufd $0x1b,(%r10,%r11,4),%ymm0
   631b7:	vpshufd $0x1b,(%rdi),%ymm1
   631bc:	vpermq $0x4e,%ymm0,%ymm0
   631c2:	vpermq $0x4e,%ymm1,%ymm1
   631c8:	vmovdqu %ymm0,(%rdi)
   631cc:	vmovdqu %ymm1,(%r10,%r11,4)
   631d2:	add    $0xfffffffffffffff8,%r11
   631d6:	add    $0x20,%rdi
   631da:	cmp    %r11,%r9
   631dd:	jne    631b0 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x560>
   631df:	cmp    %r8,%rcx
   631e2:	je     6321a <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x5ca>
   631e4:	lea    (%rsi,%r8,4),%rdi
   631e8:	lea    -0x4(%r12,%rsi,1),%r9
   631ed:	neg    %rcx
   631f0:	neg    %r8
   631f3:	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   63200:	mov    (%rdi),%r10d
   63203:	mov    (%r9,%r8,4),%r11d
   63207:	mov    %r11d,(%rdi)
   6320a:	mov    %r10d,(%r9,%r8,4)
   6320e:	dec    %r8
   63211:	add    $0x4,%rdi
   63215:	cmp    %r8,%rcx
   63218:	jne    63200 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x5b0>
   6321a:	test   $0x1,%al
   6321c:	je     62c8e <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x3e>
   63222:	mov    (%rsi),%ebp
   63224:	lea    -0x3c(%rsi),%rbx
   63228:	lea    -0x1c(%rsi),%r14
   6322c:	mov    $0x1,%eax
   63231:	mov    %r13,0x38(%rsp)
   63236:	xor    %r8d,%r8d
   63239:	mov    %rsi,%r15
   6323c:	jmp    6325b <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x60b>
   6323e:	xchg   %ax,%ax
   63240:	mov    %r9,%r8
   63243:	inc    %rax
   63246:	add    $0x4,%rbx
   6324a:	add    $0x4,%r14
   6324e:	add    $0x4,%r15
   63252:	cmp    %rdx,%rax
   63255:	je     63402 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x7b2>
   6325b:	mov    %ebp,%ecx
   6325d:	mov    (%rsi,%rax,4),%ebp
   63260:	mov    %r8,%r9
   63263:	cmp    %ecx,%ebp
   63265:	je     63240 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x5f0>
   63267:	mov    %rax,%r11
   6326a:	sub    %r9,%r11
   6326d:	mov    %rax,%r8
   63270:	cmp    $0x1,%r11
   63274:	jbe    63243 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x5f3>
   63276:	mov    %rax,%r12
   63279:	sub    %r9,%r12
   6327c:	jb     63878 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0xc28>
   63282:	cmp    $0x10,%r11
   63286:	jae    63290 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x640>
   63288:	xor    %r13d,%r13d
   6328b:	jmp    633bd <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x76d>
   63290:	mov    %r11,%rcx
   63293:	shr    $1,%rcx
   63296:	cmp    $0x40,%r11
   6329a:	jae    632a4 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x654>
   6329c:	xor    %r13d,%r13d
   6329f:	jmp    63347 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x6f7>
   632a4:	movabs $0x7ffffffffffffff8,%rdi
   632ae:	mov    %r12,%r8
   632b1:	shr    $0x6,%r8
   632b5:	lea    -0x18(%rdi),%r13
   632b9:	lea    0x40(%rsi),%rdi
   632bd:	shl    $0x5,%r8
   632c1:	lea    (%rdi,%r9,4),%r10
   632c5:	and    %rcx,%r13
   632c8:	neg    %r8
   632cb:	xor    %edi,%edi
   632cd:	nopl   (%rax)
   632d0:	vpshufd $0x1b,(%rbx,%rdi,4),%zmm0
   632d8:	vpshufd $0x1b,-0x40(%rbx,%rdi,4),%zmm1
   632e1:	vpshufd $0x1b,-0x40(%r10),%zmm2
   632e9:	vshufi64x2 $0x1b,%zmm0,%zmm0,%zmm0
   632f0:	vshufi64x2 $0x1b,%zmm1,%zmm1,%zmm1
   632f7:	vmovdqu64 %zmm0,-0x40(%r10)
   632fe:	vpshufd $0x1b,(%r10),%zmm0
   63305:	vmovdqu64 %zmm1,(%r10)
   6330b:	vshufi64x2 $0x1b,%zmm2,%zmm2,%zmm1
   63312:	sub    $0xffffffffffffff80,%r10
   63316:	vmovdqu64 %zmm1,(%rbx,%rdi,4)
   6331d:	vshufi64x2 $0x1b,%zmm0,%zmm0,%zmm0
   63324:	vmovdqu64 %zmm0,-0x40(%rbx,%rdi,4)
   6332c:	add    $0xffffffffffffffe0,%rdi
   63330:	cmp    %rdi,%r8
   63333:	jne    632d0 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x680>
   63335:	mov    %rax,%r8
   63338:	cmp    %r13,%rcx
   6333b:	je     63243 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x5f3>
   63341:	test   $0x30,%r11b
   63345:	je     633bd <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x76d>
   63347:	mov    %r13,%r8
   6334a:	shl    $0x2,%r13
   6334e:	mov    %r12,%r10
   63351:	shr    $0x4,%r10
   63355:	movabs $0x7ffffffffffffff8,%rdi
   6335f:	neg    %r8
   63362:	lea    0x0(%r13,%r9,4),%r11
   63367:	shl    $0x3,%r10
   6336b:	mov    %rcx,%r13
   6336e:	and    %rdi,%r13
   63371:	neg    %r10
   63374:	add    %rsi,%r11
   63377:	nopw   0x0(%rax,%rax,1)
   63380:	vpshufd $0x1b,(%r14,%r8,4),%ymm0
   63387:	vpshufd $0x1b,(%r11),%ymm1
   6338d:	vpermq $0x4e,%ymm0,%ymm0
   63393:	vpermq $0x4e,%ymm1,%ymm1
   63399:	vmovdqu %ymm0,(%r11)
   6339e:	vmovdqu %ymm1,(%r14,%r8,4)
   633a4:	add    $0xfffffffffffffff8,%r8
   633a8:	add    $0x20,%r11
   633ac:	cmp    %r8,%r10
   633af:	jne    63380 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x730>
   633b1:	mov    %rax,%r8
   633b4:	cmp    %r13,%rcx
   633b7:	je     63243 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x5f3>
   633bd:	lea    0x0(,%r13,4),%r8
   633c5:	lea    (%rsi,%r9,4),%rcx
   633c9:	mov    %r15,%rdi
   633cc:	shr    $1,%r12
   633cf:	sub    %r8,%rdi
   633d2:	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   633e0:	mov    (%rcx,%r13,4),%r8d
   633e4:	mov    (%rdi),%r9d
   633e7:	mov    %r9d,(%rcx,%r13,4)
   633eb:	mov    %r8d,(%rdi)
   633ee:	inc    %r13
   633f1:	add    $0xfffffffffffffffc,%rdi
   633f5:	cmp    %r13,%r12
   633f8:	jne    633e0 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x790>
   633fa:	mov    %rax,%r8
   633fd:	jmp    63243 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x5f3>
   63402:	mov    0x38(%rsp),%r13
   63407:	lea    0x0(,%rdx,4),%r10
   6340f:	mov    %rdx,%rcx
   63412:	sub    %r8,%rcx
   63415:	cmp    $0x1,%rcx
   63419:	jbe    62c8e <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x3e>
   6341f:	cmp    %r8,%rdx
   63422:	jb     638b6 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0xc66>
   63428:	lea    (%rsi,%r8,4),%rax
   6342c:	mov    %rcx,%rdx
   6342f:	shr    $1,%rdx
   63432:	cmp    $0x10,%rcx
   63436:	jae    63455 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x805>
   63438:	xor    %r9d,%r9d
   6343b:	jmp    637f1 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0xba1>
   63440:	mov    $0x4,%eax
   63445:	movq   $0x0,0x50(%rsp)
   6344e:	mov    %rax,0x30(%rsp)
   63453:	jmp    63479 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x829>
   63455:	cmp    $0x40,%rcx
   63459:	jae    636f7 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0xaa7>
   6345f:	xor    %r9d,%r9d
   63462:	jmp    63796 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0xb46>
   63467:	mov    0x40(%rsp),%rdi
   6346c:	mov    %r15,%rsi
   6346f:	mov    %rdi,0x50(%rsp)
   63474:	mov    0x18(%rsp),%r15
   63479:	lea    (%r14,%rbx,2),%rax
   6347d:	lea    0x8(%r15,%rax,1),%r12
   63482:	lea    0x0(,%r12,8),%r9
   6348a:	mov    %r12,%rax
   6348d:	shr    $0x3d,%rax
   63491:	setne  %al
   63494:	cmp    %r10,%r9
   63497:	seta   %dl
   6349a:	or     %al,%dl
   6349c:	je     634b3 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x863>
   6349e:	xor    %edi,%edi
   634a0:	mov    0x50(%rsp),%rbx
   634a5:	mov    %r9,%rsi
   634a8:	call   *0xa2072(%rip)        # 105520 <_DYNAMIC+0x2b8>
   634ae:	jmp    6391e <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0xcce>
   634b3:	mov    %r13,0x38(%rsp)
   634b8:	mov    %rsi,0x18(%rsp)
   634bd:	mov    %r9,%r13
   634c0:	call   *0xa2062(%rip)        # 105528 <_DYNAMIC+0x2c0>
   634c6:	mov    %r13,%rdi
   634c9:	mov    %r13,0x20(%rsp)
   634ce:	call   *0xa205c(%rip)        # 105530 <malloc@GLIBC_2.2.5>
   634d4:	test   %rax,%rax
   634d7:	je     638e7 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0xc97>
   634dd:	movzbl 0xa43d4(%rip),%ecx        # 1078b8 <scan_experiment::TRACK>
   634e4:	mov    %rax,%r13
   634e7:	lea    0x0(,%r12,8),%rax
   634ef:	add    %rbx,%rbx
   634f2:	test   %cl,%cl
   634f4:	je     63521 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x8d1>
   634f6:	mov    %rax,%rcx
   634f9:	lock xadd %rcx,0xa43a6(%rip)        # 1078a8 <scan_experiment::LIVE>
   63502:	add    %rax,%rcx
   63505:	mov    0xa43a4(%rip),%rax        # 1078b0 <scan_experiment::PEAK>
   6350c:	cmp    %rcx,%rax
   6350f:	mov    %rcx,%rdx
   63512:	cmova  %rax,%rdx
   63516:	lock cmpxchg %rdx,0xa4391(%rip)        # 1078b0 <scan_experiment::PEAK>
   6351f:	jne    6350c <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x8bc>
   63521:	add    %r15,%r14
   63524:	lea    0x7(%rbx,%r14,1),%rdx
   63529:	lea    (%r14,%rbx,1),%rax
   6352d:	cmp    $0x19,%rax
   63531:	jae    63537 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x8e7>
   63533:	xor    %eax,%eax
   63535:	jmp    6357f <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x92f>
   63537:	mov    %rdx,%rax
   6353a:	and    $0xffffffffffffffe0,%rax
   6353e:	vpternlogd $0xff,%zmm0,%zmm0,%zmm0
   63545:	xor    %esi,%esi
   63547:	lea    0x0(%r13,%rax,8),%rcx
   6354c:	vmovdqu64 %zmm0,0x0(%r13,%rsi,8)
   63554:	vmovdqu64 %zmm0,0x40(%r13,%rsi,8)
   6355c:	vmovdqu64 %zmm0,0x80(%r13,%rsi,8)
   63564:	vmovdqu64 %zmm0,0xc0(%r13,%rsi,8)
   6356c:	add    $0x20,%rsi
   63570:	cmp    %rsi,%rax
   63573:	jne    6354c <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x8fc>
   63575:	cmp    %rax,%rdx
   63578:	je     635c1 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x971>
   6357a:	test   $0x18,%dl
   6357d:	je     635ab <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x95b>
   6357f:	mov    %rax,%rsi
   63582:	mov    %rdx,%rax
   63585:	and    $0xfffffffffffffff8,%rax
   63589:	vpternlogd $0xff,%zmm0,%zmm0,%zmm0
   63590:	lea    0x0(%r13,%rax,8),%rcx
   63595:	vmovdqu64 %zmm0,0x0(%r13,%rsi,8)
   6359d:	add    $0x8,%rsi
   635a1:	cmp    %rsi,%rax
   635a4:	jne    63595 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x945>
   635a6:	cmp    %rax,%rdx
   635a9:	je     635c1 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x971>
   635ab:	not    %rax
   635ae:	add    %r12,%rax
   635b1:	movq   $0xffffffffffffffff,(%rcx)
   635b8:	add    $0x8,%rcx
   635bc:	dec    %rax
   635bf:	jne    635b1 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x961>
   635c1:	movq   $0xffffffffffffffff,(%rcx)
   635c8:	lea    0x0(,%rbp,8),%r14
   635d0:	vzeroupper
   635d3:	call   *0xa1f4f(%rip)        # 105528 <_DYNAMIC+0x2c0>
   635d9:	mov    %r14,%rdi
   635dc:	call   *0xa1f4e(%rip)        # 105530 <malloc@GLIBC_2.2.5>
   635e2:	test   %rax,%rax
   635e5:	je     638f6 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0xca6>
   635eb:	movzbl 0xa42c6(%rip),%ecx        # 1078b8 <scan_experiment::TRACK>
   635f2:	mov    %rax,%rbx
   635f5:	test   %cl,%cl
   635f7:	je     63624 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x9d4>
   635f9:	mov    %r14,%rcx
   635fc:	lock xadd %rcx,0xa42a3(%rip)        # 1078a8 <scan_experiment::LIVE>
   63605:	mov    0xa42a4(%rip),%rax        # 1078b0 <scan_experiment::PEAK>
   6360c:	add    %r14,%rcx
   6360f:	cmp    %rcx,%rax
   63612:	mov    %rcx,%rdx
   63615:	cmova  %rax,%rdx
   63619:	lock cmpxchg %rdx,0xa428e(%rip)        # 1078b0 <scan_experiment::PEAK>
   63622:	jne    6360f <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x9bf>
   63624:	cmp    $0x20,%rbp
   63628:	jae    63631 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x9e1>
   6362a:	xor    %eax,%eax
   6362c:	jmp    636bf <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0xa6f>
   63631:	vmovdqa64 -0x53a3b(%rip),%zmm0        # fc00 <anon.396a22046db73490f85649c540301092.0.llvm.5713125445139818657+0x64b>
   6363b:	vpbroadcastq -0x537c5(%rip),%zmm1        # fe80 <anon.396a22046db73490f85649c540301092.0.llvm.5713125445139818657+0x8cb>
   63645:	vpbroadcastq -0x53757(%rip),%zmm2        # fef8 <anon.396a22046db73490f85649c540301092.0.llvm.5713125445139818657+0x943>
   6364f:	vpbroadcastq -0x53789(%rip),%zmm3        # fed0 <anon.396a22046db73490f85649c540301092.0.llvm.5713125445139818657+0x91b>
   63659:	vpbroadcastq -0x537a3(%rip),%zmm4        # fec0 <anon.396a22046db73490f85649c540301092.0.llvm.5713125445139818657+0x90b>
   63663:	mov    %ebp,%eax
   63665:	and    $0x7ffe0,%eax
   6366a:	xor    %ecx,%ecx
   6366c:	vpaddq %zmm1,%zmm0,%zmm5
   63672:	vpaddq %zmm2,%zmm0,%zmm6
   63678:	vpaddq %zmm3,%zmm0,%zmm7
   6367e:	vmovdqu64 %zmm0,(%rbx,%rcx,8)
   63685:	vpaddq %zmm4,%zmm0,%zmm0
   6368b:	vmovdqu64 %zmm5,0x40(%rbx,%rcx,8)
   63693:	vmovdqu64 %zmm6,0x80(%rbx,%rcx,8)
   6369b:	vmovdqu64 %zmm7,0xc0(%rbx,%rcx,8)
   636a3:	add    $0x20,%rcx
   636a7:	cmp    %rcx,%rax
   636aa:	jne    6366c <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0xa1c>
   636ac:	cmp    %rax,%rbp
   636af:	je     63956 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0xd06>
   636b5:	test   $0x1c,%bpl
   636b9:	je     6394a <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0xcfa>
   636bf:	mov    %rax,%rcx
   636c2:	vpbroadcastq %rcx,%ymm0
   636c8:	vpor   -0x53770(%rip),%ymm0,%ymm0        # ff60 <anon.396a22046db73490f85649c540301092.0.llvm.5713125445139818657+0x9ab>
   636d0:	vpbroadcastq -0x537e9(%rip),%ymm1        # fef0 <anon.396a22046db73490f85649c540301092.0.llvm.5713125445139818657+0x93b>
   636d9:	mov    %ebp,%eax
   636db:	and    $0x7fffc,%eax
   636e0:	vmovdqu %ymm0,(%rbx,%rcx,8)
   636e5:	add    $0x4,%rcx
   636e9:	vpaddq %ymm1,%ymm0,%ymm0
   636ed:	cmp    %rcx,%rax
   636f0:	jne    636e0 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0xa90>
   636f2:	jmp    63951 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0xd01>
   636f7:	mov    %rcx,%r11
   636fa:	shr    $0x6,%r11
   636fe:	movabs $0x7ffffffffffffff8,%rdi
   63708:	lea    0x40(%rsi,%r8,4),%r8
   6370d:	lea    -0x40(%r10,%rsi,1),%rbx
   63712:	xor    %r14d,%r14d
   63715:	lea    -0x18(%rdi),%r9
   63719:	shl    $0x5,%r11
   6371d:	and    %rdx,%r9
   63720:	neg    %r11
   63723:	vpshufd $0x1b,(%rbx,%r14,4),%zmm0
   6372b:	vpshufd $0x1b,-0x40(%rbx,%r14,4),%zmm1
   63734:	vpshufd $0x1b,-0x40(%r8),%zmm2
   6373c:	vshufi64x2 $0x1b,%zmm0,%zmm0,%zmm0
   63743:	vshufi64x2 $0x1b,%zmm1,%zmm1,%zmm1
   6374a:	vmovdqu64 %zmm0,-0x40(%r8)
   63751:	vpshufd $0x1b,(%r8),%zmm0
   63758:	vmovdqu64 %zmm1,(%r8)
   6375e:	vshufi64x2 $0x1b,%zmm2,%zmm2,%zmm1
   63765:	sub    $0xffffffffffffff80,%r8
   63769:	vmovdqu64 %zmm1,(%rbx,%r14,4)
   63770:	vshufi64x2 $0x1b,%zmm0,%zmm0,%zmm0
   63777:	vmovdqu64 %zmm0,-0x40(%rbx,%r14,4)
   6377f:	add    $0xffffffffffffffe0,%r14
   63783:	cmp    %r14,%r11
   63786:	jne    63723 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0xad3>
   63788:	cmp    %r9,%rdx
   6378b:	je     62c8e <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x3e>
   63791:	test   $0x30,%cl
   63794:	je     637f1 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0xba1>
   63796:	lea    0x0(,%r9,4),%rcx
   6379e:	mov    %r10,%rdi
   637a1:	movabs $0x7ffffffffffffff8,%r8
   637ab:	and    %rdx,%r8
   637ae:	sub    %rcx,%rdi
   637b1:	lea    -0x20(%rdi,%rsi,1),%rcx
   637b6:	vpshufd $0x1b,(%rcx),%ymm0
   637bb:	vpshufd $0x1b,(%rax,%r9,4),%ymm1
   637c2:	vpermq $0x4e,%ymm0,%ymm0
   637c8:	vpermq $0x4e,%ymm1,%ymm1
   637ce:	vmovdqu %ymm0,(%rax,%r9,4)
   637d4:	vmovdqu %ymm1,(%rcx)
   637d8:	add    $0x8,%r9
   637dc:	add    $0xffffffffffffffe0,%rcx
   637e0:	cmp    %r9,%r8
   637e3:	jne    637b6 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0xb66>
   637e5:	mov    %r8,%r9
   637e8:	cmp    %r8,%rdx
   637eb:	je     62c8e <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x3e>
   637f1:	lea    0x0(,%r9,4),%rcx
   637f9:	sub    %rcx,%r10
   637fc:	lea    -0x4(%r10,%rsi,1),%rcx
   63801:	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   63810:	mov    (%rax,%r9,4),%esi
   63814:	mov    (%rcx),%edi
   63816:	mov    %edi,(%rax,%r9,4)
   6381a:	mov    %esi,(%rcx)
   6381c:	inc    %r9
   6381f:	add    $0xfffffffffffffffc,%rcx
   63823:	cmp    %r9,%rdx
   63826:	jne    63810 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0xbc0>
   63828:	jmp    62c8e <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x3e>
   6382d:	lea    -0x53604(%rip),%rdi        # 10230 <anon.590c1ca00e458323ccaf1fde3a917a11.1522.llvm.18282150582867169823+0x270>
   63834:	lea    0x9e165(%rip),%rdx        # 1019a0 <__frame_dummy_init_array_entry+0xe0>
   6383b:	mov    $0x2a,%esi
   63840:	call   *0xa1cc2(%rip)        # 105508 <_DYNAMIC+0x2a0>
   63846:	lea    -0x538ad(%rip),%rdi        # ffa0 <anon.396a22046db73490f85649c540301092.0.llvm.5713125445139818657+0x9eb>
   6384d:	lea    0x9e164(%rip),%rdx        # 1019b8 <__frame_dummy_init_array_entry+0xf8>
   63854:	mov    $0x20,%esi
   63859:	call   *0xa1ca9(%rip)        # 105508 <_DYNAMIC+0x2a0>
   6385f:	lea    -0x5360c(%rip),%rdi        # 1025a <anon.590c1ca00e458323ccaf1fde3a917a11.1522.llvm.18282150582867169823+0x29a>
   63866:	lea    0x9e163(%rip),%rdx        # 1019d0 <__frame_dummy_init_array_entry+0x110>
   6386d:	mov    $0x23,%esi
   63872:	call   *0xa1c90(%rip)        # 105508 <_DYNAMIC+0x2a0>
   63878:	lea    0x9e211(%rip),%rcx        # 101a90 <__frame_dummy_init_array_entry+0x1d0>
   6387f:	mov    %r9,%rdi
   63882:	mov    %rax,%rsi
   63885:	vzeroupper
   63888:	call   *0xa1c52(%rip)        # 1054e0 <_DYNAMIC+0x278>
   6388e:	lea    0xd8(%rsp),%rax
   63896:	mov    %rsi,%rdi
   63899:	mov    %rdx,%rsi
   6389c:	mov    %rax,%rdx
   6389f:	call   a9c70 <core::slice::sort::stable::driftsort_main::<u32, <[u32]>::sort_by_key<u32, block_msd_research::count_first::block_msd_stable_radixsort_body<u32, u32>::{closure#0}>::{closure#0}, alloc::vec::Vec<u32>>>
   638a4:	jmp    62c8e <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x3e>
   638a9:	lea    0x9e1b0(%rip),%rdi        # 101a60 <__frame_dummy_init_array_entry+0x1a0>
   638b0:	call   *0xa1c4a(%rip)        # 105500 <_DYNAMIC+0x298>
   638b6:	lea    0x9e1bb(%rip),%rcx        # 101a78 <__frame_dummy_init_array_entry+0x1b8>
   638bd:	mov    %r8,%rdi
   638c0:	mov    %rdx,%rsi
   638c3:	vzeroupper
   638c6:	call   *0xa1c14(%rip)        # 1054e0 <_DYNAMIC+0x278>
   638cc:	lea    0x9e115(%rip),%rdi        # 1019e8 <__frame_dummy_init_array_entry+0x128>
   638d3:	call   *0xa1c5f(%rip)        # 105538 <_DYNAMIC+0x2d0>
   638d9:	mov    $0x4,%edi
   638de:	mov    %r12,%rsi
   638e1:	call   *0xa1c39(%rip)        # 105520 <_DYNAMIC+0x2b8>
   638e7:	mov    0x20(%rsp),%r9
   638ec:	mov    $0x8,%edi
   638f1:	jmp    634a0 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x850>
   638f6:	mov    $0x8,%edi
   638fb:	mov    %r14,%rsi
   638fe:	call   *0xa1c1c(%rip)        # 105520 <_DYNAMIC+0x2b8>
   63904:	jmp    6391e <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0xcce>
   63906:	mov    %rax,%r15
   63909:	jmp    64c53 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x2003>
   6390e:	mov    %rax,%r15
   63911:	test   %rbx,%rbx
   63914:	jne    63920 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0xcd0>
   63916:	mov    %r15,%rdi
   63919:	call   100870 <_Unwind_Resume@plt>
   6391e:	ud2
   63920:	movzbl 0xa3f91(%rip),%eax        # 1078b8 <scan_experiment::TRACK>
   63927:	test   %al,%al
   63929:	je     63937 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0xce7>
   6392b:	shl    $0x2,%rbx
   6392f:	lock sub %rbx,0xa3f71(%rip)        # 1078a8 <scan_experiment::LIVE>
   63937:	mov    0x30(%rsp),%rdi
   6393c:	call   *0xa1bd6(%rip)        # 105518 <free@GLIBC_2.2.5>
   63942:	mov    %r15,%rdi
   63945:	call   100870 <_Unwind_Resume@plt>
   6394a:	mov    %rax,(%rbx,%rax,8)
   6394e:	inc    %rax
   63951:	cmp    %rax,%rbp
   63954:	jne    6394a <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0xcfa>
   63956:	mov    %r14,0x78(%rsp)
   6395b:	vzeroupper
   6395e:	call   *0xa1bc4(%rip)        # 105528 <_DYNAMIC+0x2c0>
   63964:	mov    %r12,%rdi
   63967:	call   *0xa1bc3(%rip)        # 105530 <malloc@GLIBC_2.2.5>
   6396d:	test   %rax,%rax
   63970:	je     64bb8 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1f68>
   63976:	movzbl 0xa3f3b(%rip),%ecx        # 1078b8 <scan_experiment::TRACK>
   6397d:	mov    %rax,%r14
   63980:	test   %cl,%cl
   63982:	je     639af <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0xd5f>
   63984:	mov    %r12,%rcx
   63987:	lock xadd %rcx,0xa3f18(%rip)        # 1078a8 <scan_experiment::LIVE>
   63990:	mov    0xa3f19(%rip),%rax        # 1078b0 <scan_experiment::PEAK>
   63997:	add    %r12,%rcx
   6399a:	cmp    %rcx,%rax
   6399d:	mov    %rcx,%rdx
   639a0:	cmova  %rax,%rdx
   639a4:	lock cmpxchg %rdx,0xa3f03(%rip)        # 1078b0 <scan_experiment::PEAK>
   639ad:	jne    6399a <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0xd4a>
   639af:	mov    %r14,%rdi
   639b2:	xor    %esi,%esi
   639b4:	mov    %r12,%rdx
   639b7:	call   *0xa1b83(%rip)        # 105540 <memset@GLIBC_2.2.5>
   639bd:	mov    0x18(%rsp),%rcx
   639c2:	mov    0x50(%rsp),%rax
   639c7:	mov    0x30(%rsp),%rdx
   639cc:	mov    0x10(%rsp),%r8
   639d1:	mov    0x88(%rsp),%r9
   639d9:	vpxor  %xmm0,%xmm0,%xmm0
   639dd:	mov    %rcx,0x138(%rsp)
   639e5:	mov    %rax,0xd8(%rsp)
   639ed:	mov    %rdx,0xe0(%rsp)
   639f5:	mov    0x40(%rsp),%rdx
   639fa:	mov    0x28(%rsp),%rax
   639ff:	mov    %rdx,0xe8(%rsp)
   63a07:	mov    %rbp,0x140(%rsp)
   63a0f:	mov    %rax,0x148(%rsp)
   63a17:	mov    %r12,0xf0(%rsp)
   63a1f:	mov    %r13,0xf8(%rsp)
   63a27:	mov    %r12,0x100(%rsp)
   63a2f:	mov    %rbp,0x108(%rsp)
   63a37:	mov    %rbx,0x110(%rsp)
   63a3f:	mov    %rbp,0x118(%rsp)
   63a47:	mov    %r12,0x120(%rsp)
   63a4f:	mov    %r14,0x128(%rsp)
   63a57:	mov    $0xffffffffffffffff,%rbx
   63a5e:	mov    $0xffffffffffffffff,%r14
   63a65:	mov    %r12,0x130(%rsp)
   63a6d:	vmovdqu %ymm0,0x150(%rsp)
   63a76:	vmovdqu %ymm0,0x168(%rsp)
   63a7f:	mov    %rdx,0x188(%rsp)
   63a87:	cmp    %r8,%rax
   63a8a:	ja     63b0b <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0xebb>
   63a8c:	mov    0x128(%rsp),%rdx
   63a94:	movb   $0x1,(%rdx,%rbp,1)
   63a98:	cmp    $0x2,%r15
   63a9c:	jb     63b08 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0xeb8>
   63a9e:	lea    0x1(%rbp),%rsi
   63aa2:	lea    0x9df9f(%rip),%rdx        # 101a48 <__frame_dummy_init_array_entry+0x188>
   63aa9:	lea    0x9df80(%rip),%rdi        # 101a30 <__frame_dummy_init_array_entry+0x170>
   63ab0:	mov    %r15,%r13
   63ab3:	mov    %rbp,%r15
   63ab6:	mov    %rsi,%r10
   63ab9:	mov    0x100(%rsp),%rsi
   63ac1:	cmp    %rsi,%r15
   63ac4:	jae    64b31 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1ee1>
   63aca:	mov    0xf8(%rsp),%rsi
   63ad2:	mov    %r10,(%rsi,%r15,8)
   63ad6:	mov    0x130(%rsp),%rsi
   63ade:	cmp    %rsi,%r10
   63ae1:	jae    64b2b <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1edb>
   63ae7:	mov    0x128(%rsp),%r11
   63aef:	lea    0x1(%r10),%rsi
   63af3:	mov    %r10,%r15
   63af6:	movb   $0x1,(%r11,%r10,1)
   63afb:	cmp    %r12,%rsi
   63afe:	jb     63ab6 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0xe66>
   63b00:	mov    %rbp,%r14
   63b03:	mov    %r13,%r15
   63b06:	jmp    63b0b <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0xebb>
   63b08:	mov    %rbp,%r14
   63b0b:	mov    0x48(%rsp),%rbp
   63b10:	mov    %r15,%r10
   63b13:	lea    -0x1(%r12),%r15
   63b18:	cmp    %r8,%rax
   63b1b:	cmovbe %r15,%rbx
   63b1f:	test   %rbp,%rbp
   63b22:	je     63c22 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0xfd2>
   63b28:	mov    0x118(%rsp),%rdi
   63b30:	test   %rdi,%rdi
   63b33:	je     64ad1 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1e81>
   63b39:	lea    -0x1(%rdi),%rdx
   63b3d:	mov    %rdx,0x118(%rsp)
   63b45:	mov    0x110(%rsp),%r8
   63b4d:	mov    0x130(%rsp),%rsi
   63b55:	mov    -0x8(%r8,%rdi,8),%rbx
   63b5a:	cmp    %rsi,%rbx
   63b5d:	jae    64be0 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1f90>
   63b63:	mov    0x128(%rsp),%rdi
   63b6b:	cmpb   $0x1,(%rdi,%rbx,1)
   63b6f:	je     64af2 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1ea2>
   63b75:	movb   $0x1,(%rdi,%rbx,1)
   63b79:	mov    0x100(%rsp),%rdi
   63b81:	cmp    %rdi,%rbx
   63b84:	jae    64be9 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1f99>
   63b8a:	mov    0xf8(%rsp),%rdi
   63b92:	sub    %rdx,%rsi
   63b95:	lea    0xe0(%rsp),%rdx
   63b9d:	mov    %rax,%r13
   63ba0:	movq   $0xffffffffffffffff,(%rdi,%rbx,8)
   63ba8:	mov    0x180(%rsp),%r8
   63bb0:	mov    0x140(%rsp),%rdi
   63bb8:	cmp    %r8,%rsi
   63bbb:	cmovbe %r8,%rsi
   63bbf:	imul   %rax,%r10
   63bc3:	lea    0x138(%rsp),%r8
   63bcb:	mov    %rsi,0x180(%rsp)
   63bd3:	lea    (%rcx,%r10,4),%rsi
   63bd7:	xor    %ecx,%ecx
   63bd9:	cmp    %rdi,%rbx
   63bdc:	cmovae %rdi,%rcx
   63be0:	cmovb  %rdx,%r8
   63be4:	mov    %rbx,%rdi
   63be7:	lea    0x0(,%rbp,4),%rdx
   63bef:	sub    %rcx,%rdi
   63bf2:	imul   0x148(%rsp),%rdi
   63bfb:	shl    $0x2,%rdi
   63bff:	add    (%r8),%rdi
   63c02:	vzeroupper
   63c05:	call   *0xa18c5(%rip)        # 1054d0 <memcpy@GLIBC_2.14>
   63c0b:	mov    0x10(%rsp),%r8
   63c10:	cmp    %r8,%r13
   63c13:	jbe    63c27 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0xfd7>
   63c15:	mov    0x88(%rsp),%r9
   63c1d:	mov    %rbx,%r14
   63c20:	jmp    63c4d <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0xffd>
   63c22:	mov    %rax,%rbp
   63c25:	jmp    63c4d <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0xffd>
   63c27:	mov    0x100(%rsp),%rsi
   63c2f:	mov    0x88(%rsp),%r9
   63c37:	cmp    %rsi,%r15
   63c3a:	jae    64c23 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1fd3>
   63c40:	mov    0xf8(%rsp),%rax
   63c48:	mov    %rbx,-0x8(%rax,%r12,8)
   63c4d:	vmovdqa -0x53d15(%rip),%ymm0        # ff40 <anon.396a22046db73490f85649c540301092.0.llvm.5713125445139818657+0x98b>
   63c55:	mov    %r14,0x1c8(%rsp)
   63c5d:	mov    %rbx,0x1d0(%rsp)
   63c65:	movq   $0x0,0x1d8(%rsp)
   63c71:	mov    %rbp,0x1e0(%rsp)
   63c79:	mov    %r8,0x1e8(%rsp)
   63c81:	vmovdqu %ymm0,0x1f0(%rsp)
   63c8a:	movq   $0x0,0x210(%rsp)
   63c96:	mov    %r8,%rdx
   63c99:	mov    0x68(%rsp),%r8
   63c9e:	lea    0x1f0(%rsp),%rax
   63ca6:	lea    0xd8(%rsp),%rdi
   63cae:	lea    0x1c8(%rsp),%rsi
   63cb6:	mov    $0x20,%ecx
   63cbb:	mov    %rax,(%rsp)
   63cbf:	vzeroupper
   63cc2:	call   6d0b0 <block_msd_research::count_first::recurse::<u32, u32>>
   63cc7:	cmpq   $0x0,0x1e8(%rsp)
   63cd0:	jne    64a83 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1e33>
   63cd6:	vmovdqu 0x1f0(%rsp),%ymm0
   63cdf:	mov    0x210(%rsp),%rcx
   63ce7:	mov    0x10(%rsp),%rax
   63cec:	mov    %rcx,0x1c0(%rsp)
   63cf4:	mov    %rax,0x198(%rsp)
   63cfc:	vmovdqu %ymm0,0x1a0(%rsp)
   63d05:	cmp    %rax,%rcx
   63d08:	jne    64aa8 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1e58>
   63d0e:	mov    0x148(%rsp),%rsi
   63d16:	test   %rsi,%rsi
   63d19:	je     64bcb <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1f7b>
   63d1f:	mov    %rax,%rcx
   63d22:	or     %rsi,%rcx
   63d25:	mov    %rsi,0x30(%rsp)
   63d2a:	shr    $0x20,%rcx
   63d2e:	je     63d3a <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x10ea>
   63d30:	xor    %edx,%edx
   63d32:	div    %rsi
   63d35:	mov    %rdx,%r15
   63d38:	jmp    63d41 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x10f1>
   63d3a:	xor    %edx,%edx
   63d3c:	div    %esi
   63d3e:	mov    %edx,%r15d
   63d41:	mov    0x100(%rsp),%r12
   63d49:	mov    %rax,0x20(%rsp)
   63d4e:	test   %r12,%r12
   63d51:	je     63df5 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x11a5>
   63d57:	lea    0x0(,%r12,8),%r14
   63d5f:	vzeroupper
   63d62:	call   *0xa17c0(%rip)        # 105528 <_DYNAMIC+0x2c0>
   63d68:	mov    %r14,%rdi
   63d6b:	call   *0xa17bf(%rip)        # 105530 <malloc@GLIBC_2.2.5>
   63d71:	test   %rax,%rax
   63d74:	je     64c04 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1fb4>
   63d7a:	movzbl 0xa3b37(%rip),%ecx        # 1078b8 <scan_experiment::TRACK>
   63d81:	mov    %rax,%r10
   63d84:	test   %cl,%cl
   63d86:	je     63db3 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1163>
   63d88:	mov    %r14,%rcx
   63d8b:	lock xadd %rcx,0xa3b14(%rip)        # 1078a8 <scan_experiment::LIVE>
   63d94:	mov    0xa3b15(%rip),%rax        # 1078b0 <scan_experiment::PEAK>
   63d9b:	add    %r14,%rcx
   63d9e:	cmp    %rcx,%rax
   63da1:	mov    %rcx,%rdx
   63da4:	cmova  %rax,%rdx
   63da8:	lock cmpxchg %rdx,0xa3aff(%rip)        # 1078b0 <scan_experiment::PEAK>
   63db1:	jne    63d9e <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x114e>
   63db3:	mov    $0x1,%r8d
   63db9:	mov    %r10,%rax
   63dbc:	cmp    $0x1,%r12
   63dc0:	je     63de2 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1192>
   63dc2:	lea    -0x8(%r14),%rdx
   63dc6:	mov    $0xff,%esi
   63dcb:	mov    %r10,%rdi
   63dce:	mov    %r10,%rbx
   63dd1:	call   *0xa1769(%rip)        # 105540 <memset@GLIBC_2.2.5>
   63dd7:	lea    -0x8(%rbx,%r14,1),%rax
   63ddc:	mov    %rbx,%r10
   63ddf:	mov    %r12,%r8
   63de2:	movq   $0xffffffffffffffff,(%rax)
   63de9:	mov    0x10(%rsp),%rdi
   63dee:	mov    0x20(%rsp),%rax
   63df3:	jmp    63e06 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x11b6>
   63df5:	mov    0x10(%rsp),%rdi
   63dfa:	mov    $0x8,%r10d
   63e00:	xor    %r8d,%r8d
   63e03:	xor    %r12d,%r12d
   63e06:	mov    0x1a8(%rsp),%r9
   63e0e:	mov    0x1b0(%rsp),%rdx
   63e16:	mov    %r10,0x80(%rsp)
   63e1e:	mov    %r8,0x98(%rsp)
   63e26:	mov    %rdx,0x28(%rsp)
   63e2b:	mov    %r9,0x18(%rsp)
   63e30:	test   %rdx,%rdx
   63e33:	je     63e65 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1215>
   63e35:	mov    0x28(%rsp),%rcx
   63e3a:	lea    0x9debf(%rip),%rbx        # 101d00 <__frame_dummy_init_array_entry+0x440>
   63e41:	xor    %edx,%edx
   63e43:	lea    0x0(,%rcx,8),%rcx
   63e4b:	mov    (%r9,%rdx,8),%rsi
   63e4f:	cmp    %r12,%rsi
   63e52:	jae    64b13 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1ec3>
   63e58:	mov    %rdx,(%r10,%rsi,8)
   63e5c:	inc    %rdx
   63e5f:	add    $0xfffffffffffffff8,%rcx
   63e63:	jne    63e4b <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x11fb>
   63e65:	mov    0x28(%rsp),%r8
   63e6a:	mov    %r12,0x40(%rsp)
   63e6f:	mov    %r15,0x190(%rsp)
   63e77:	cmp    %rdi,0x30(%rsp)
   63e7c:	jbe    63edc <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x128c>
   63e7e:	mov    0x190(%rsp),%rdx
   63e86:	mov    0x38(%rsp),%r13
   63e8b:	mov    0x98(%rsp),%rbx
   63e93:	test   %rdx,%rdx
   63e96:	je     6491a <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1cca>
   63e9c:	cmp    %r8,%rax
   63e9f:	jae    64c17 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1fc7>
   63ea5:	mov    (%r9,%rax,8),%rsi
   63ea9:	mov    %rsi,%rcx
   63eac:	sub    0x140(%rsp),%rcx
   63eb4:	jae    648de <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1c8e>
   63eba:	mov    0x30(%rsp),%rdi
   63ebf:	mov    0x138(%rsp),%r8
   63ec7:	imul   %rdi,%rsi
   63ecb:	shl    $0x2,%rsi
   63ecf:	add    0xe0(%rsp),%rsi
   63ed7:	jmp    648f3 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1ca3>
   63edc:	mov    0x30(%rsp),%rdi
   63ee1:	mov    0x140(%rsp),%r11
   63ee9:	mov    0x138(%rsp),%r14
   63ef1:	mov    0xe0(%rsp),%rbx
   63ef9:	lea    0x0(,%rdi,4),%rcx
   63f01:	mov    %r11,%rsi
   63f04:	imul   %rdi,%rsi
   63f08:	cmp    $0x1,%rax
   63f0c:	mov    %rdi,%rdx
   63f0f:	lea    0x40(%rbx),%r13
   63f13:	lea    0x1c(%r14),%r12
   63f17:	mov    %rbx,0x78(%rsp)
   63f1c:	mov    %r14,0x68(%rsp)
   63f21:	mov    %r13,0xa0(%rsp)
   63f29:	mov    %r12,0xc8(%rsp)
   63f31:	lea    0x1c(%rbx),%r12
   63f35:	mov    %rcx,0x10(%rsp)
   63f3a:	mov    %rax,%rcx
   63f3d:	adc    $0x0,%rcx
   63f41:	mov    %r12,0xc0(%rsp)
   63f49:	imul   %rcx,%rdx
   63f4d:	add    %r11,%rcx
   63f50:	lea    (%rbx,%rsi,4),%r15
   63f54:	lea    0x40(%rbx,%rsi,4),%r13
   63f59:	lea    0x9dd28(%rip),%rsi        # 101c88 <__frame_dummy_init_array_entry+0x3c8>
   63f60:	imul   %rdi,%rcx
   63f64:	mov    %rsi,0x60(%rsp)
   63f69:	mov    %r15,0xd0(%rsp)
   63f71:	lea    (%r14,%rdx,4),%rdx
   63f75:	lea    (%rbx,%rcx,4),%rcx
   63f79:	mov    %r15,%rbx
   63f7c:	mov    %rdx,0xb8(%rsp)
   63f84:	mov    %rdi,%rdx
   63f87:	and    $0xffffffffffffffe0,%rdx
   63f8b:	mov    %rdx,0x58(%rsp)
   63f90:	mov    %rdi,%rdx
   63f93:	and    $0xfffffffffffffffc,%rdx
   63f97:	mov    %r11,%rdi
   63f9a:	mov    %rcx,0xb0(%rsp)
   63fa2:	xor    %r11d,%r11d
   63fa5:	mov    %rdi,0x50(%rsp)
   63faa:	mov    %rdx,0x90(%rsp)
   63fb2:	lea    0x40(%r14),%rdx
   63fb6:	mov    %rdx,%r15
   63fb9:	mov    %rdx,0xa8(%rsp)
   63fc1:	jmp    64094 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1444>
   63fc6:	mov    0x68(%rsp),%r9
   63fcb:	cmp    %rdi,%rsi
   63fce:	mov    $0x0,%eax
   63fd3:	mov    0x78(%rsp),%r8
   63fd8:	mov    %rsi,%rdx
   63fdb:	mov    %r15,%rbp
   63fde:	mov    %r13,%r15
   63fe1:	mov    %r12,%r13
   63fe4:	cmovae %rdi,%rax
   63fe8:	mov    0x30(%rsp),%rdi
   63fed:	mov    %r9,%rcx
   63ff0:	cmovb  %r8,%rcx
   63ff4:	sub    %rax,%rdx
   63ff7:	mov    %r12,%rax
   63ffa:	imul   %rdi,%rdx
   63ffe:	imul   %rdi,%rax
   64002:	lea    (%rcx,%rdx,4),%rsi
   64006:	mov    %r11,%rcx
   64009:	imul   %rdi,%rcx
   6400d:	cmp    0x50(%rsp),%r12
   64012:	mov    0x10(%rsp),%rdx
   64017:	lea    (%r8,%rax,4),%rax
   6401b:	mov    %r11,%r12
   6401e:	lea    (%r9,%rcx,4),%rdi
   64022:	cmovb  %rax,%rdi
   64026:	vzeroupper
   64029:	call   *0xa14a1(%rip)        # 1054d0 <memcpy@GLIBC_2.14>
   6402f:	mov    %r12,%r11
   64032:	mov    0x48(%rsp),%r12
   64037:	mov    0x50(%rsp),%rdi
   6403c:	mov    0x28(%rsp),%r8
   64041:	mov    0x20(%rsp),%rax
   64046:	mov    0x18(%rsp),%r9
   6404b:	mov    0x80(%rsp),%r10
   64053:	mov    $0xffffffffffffffff,%rcx
   6405a:	cmp    0x40(%rsp),%r12
   6405f:	jae    64b5a <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1f0a>
   64065:	mov    %rcx,(%r10,%r12,8)
   64069:	mov    %r13,(%r9,%r11,8)
   6406d:	mov    %r11,(%r10,%r13,8)
   64071:	mov    %r15,%r13
   64074:	mov    %rbp,%r15
   64077:	mov    0x10(%rsp),%rcx
   6407c:	inc    %r11
   6407f:	add    %rcx,%r15
   64082:	add    %rcx,%r14
   64085:	add    %rcx,%r13
   64088:	add    %rcx,%rbx
   6408b:	cmp    %rax,%r11
   6408e:	jae    63e7e <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x122e>
   64094:	cmp    %r8,%r11
   64097:	je     64b24 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1ed4>
   6409d:	mov    (%r9,%r11,8),%rsi
   640a1:	lea    (%r11,%rdi,1),%r12
   640a5:	cmp    %r12,%rsi
   640a8:	je     64077 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1427>
   640aa:	cmp    0x40(%rsp),%r12
   640af:	jae    64b42 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1ef2>
   640b5:	mov    (%r10,%r12,8),%rax
   640b9:	mov    %rsi,0x48(%rsp)
   640be:	cmp    $0xffffffffffffffff,%rax
   640c2:	mov    %rax,0x88(%rsp)
   640ca:	sete   %cl
   640cd:	cmp    %r11,%rax
   640d0:	setbe  %dl
   640d3:	or     %cl,%dl
   640d5:	jne    63fc6 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1376>
   640db:	mov    0x30(%rsp),%rax
   640e0:	mov    0x68(%rsp),%r8
   640e5:	mov    %rsi,%rcx
   640e8:	sub    %rdi,%rcx
   640eb:	mov    %r11,%rbp
   640ee:	mov    %rsi,%r11
   640f1:	mov    %rcx,%rdx
   640f4:	imul   %rax,%rdx
   640f8:	imul   %rax,%rsi
   640fc:	lea    (%r8,%rdx,4),%rdx
   64100:	mov    0x78(%rsp),%r8
   64105:	lea    (%r8,%rsi,4),%rsi
   64109:	mov    %rdi,%r8
   6410c:	cmp    %rdi,%r12
   6410f:	mov    %r11,%rdi
   64112:	jae    64239 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x15e9>
   64118:	sub    %r8,%rdi
   6411b:	jae    64367 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1717>
   64121:	mov    %rbp,%r11
   64124:	cmp    $0x4,%rax
   64128:	jb     6415c <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x150c>
   6412a:	mov    0x48(%rsp),%rcx
   6412f:	lea    0x4(,%rcx,4),%rcx
   64137:	imul   %rax,%rcx
   6413b:	add    0x78(%rsp),%rcx
   64140:	cmp    %rcx,0xd0(%rsp)
   64148:	jae    645e2 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1992>
   6414e:	cmp    0xb0(%rsp),%rsi
   64156:	jae    645e2 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1992>
   6415c:	xor    %edx,%edx
   6415e:	mov    %eax,%edi
   64160:	sub    %edx,%edi
   64162:	mov    %rdx,%rcx
   64165:	and    $0x7,%edi
   64168:	je     64186 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1536>
   6416a:	mov    %rdx,%rcx
   6416d:	mov    (%rbx,%rcx,4),%r8d
   64171:	mov    (%rsi,%rcx,4),%r9d
   64175:	dec    %rdi
   64178:	mov    %r9d,(%rbx,%rcx,4)
   6417c:	mov    %r8d,(%rsi,%rcx,4)
   64180:	lea    0x1(%rcx),%rcx
   64184:	jne    6416d <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x151d>
   64186:	mov    0x18(%rsp),%r9
   6418b:	sub    %rax,%rdx
   6418e:	cmp    $0xfffffffffffffff8,%rdx
   64192:	ja     645a0 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1950>
   64198:	mov    0x10(%rsp),%rdx
   6419d:	imul   0x48(%rsp),%rdx
   641a3:	add    0xc0(%rsp),%rdx
   641ab:	mov    (%rbx,%rcx,4),%esi
   641ae:	mov    -0x1c(%rdx,%rcx,4),%edi
   641b2:	mov    %edi,(%rbx,%rcx,4)
   641b5:	mov    %esi,-0x1c(%rdx,%rcx,4)
   641b9:	mov    0x4(%rbx,%rcx,4),%esi
   641bd:	mov    -0x18(%rdx,%rcx,4),%edi
   641c1:	mov    %edi,0x4(%rbx,%rcx,4)
   641c5:	mov    %esi,-0x18(%rdx,%rcx,4)
   641c9:	mov    0x8(%rbx,%rcx,4),%esi
   641cd:	mov    -0x14(%rdx,%rcx,4),%edi
   641d1:	mov    %edi,0x8(%rbx,%rcx,4)
   641d5:	mov    %esi,-0x14(%rdx,%rcx,4)
   641d9:	mov    0xc(%rbx,%rcx,4),%esi
   641dd:	mov    -0x10(%rdx,%rcx,4),%edi
   641e1:	mov    %edi,0xc(%rbx,%rcx,4)
   641e5:	mov    %esi,-0x10(%rdx,%rcx,4)
   641e9:	mov    0x10(%rbx,%rcx,4),%esi
   641ed:	mov    -0xc(%rdx,%rcx,4),%edi
   641f1:	mov    %edi,0x10(%rbx,%rcx,4)
   641f5:	mov    %esi,-0xc(%rdx,%rcx,4)
   641f9:	mov    0x14(%rbx,%rcx,4),%esi
   641fd:	mov    -0x8(%rdx,%rcx,4),%edi
   64201:	mov    %edi,0x14(%rbx,%rcx,4)
   64205:	mov    %esi,-0x8(%rdx,%rcx,4)
   64209:	mov    0x18(%rbx,%rcx,4),%esi
   6420d:	mov    -0x4(%rdx,%rcx,4),%edi
   64211:	mov    %edi,0x18(%rbx,%rcx,4)
   64215:	mov    %esi,-0x4(%rdx,%rcx,4)
   64219:	mov    0x1c(%rbx,%rcx,4),%esi
   6421d:	mov    (%rdx,%rcx,4),%edi
   64220:	mov    %edi,0x1c(%rbx,%rcx,4)
   64224:	mov    %esi,(%rdx,%rcx,4)
   64227:	add    $0x8,%rcx
   6422b:	cmp    %rcx,%rax
   6422e:	jne    641ab <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x155b>
   64234:	jmp    645a0 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1950>
   64239:	sub    %r8,%rdi
   6423c:	jae    6447f <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x182f>
   64242:	mov    %rbp,%r11
   64245:	cmp    $0x4,%rax
   64249:	jb     6427a <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x162a>
   6424b:	mov    0x48(%rsp),%rcx
   64250:	lea    0x4(,%rcx,4),%rcx
   64258:	imul   %rax,%rcx
   6425c:	add    0x78(%rsp),%rcx
   64261:	cmp    %rcx,0x68(%rsp)
   64266:	jae    645ef <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x199f>
   6426c:	cmp    0xb8(%rsp),%rsi
   64274:	jae    645ef <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x199f>
   6427a:	xor    %edx,%edx
   6427c:	mov    %eax,%edi
   6427e:	sub    %edx,%edi
   64280:	mov    %rdx,%rcx
   64283:	and    $0x7,%edi
   64286:	je     642a4 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1654>
   64288:	mov    %rdx,%rcx
   6428b:	mov    (%r14,%rcx,4),%r8d
   6428f:	mov    (%rsi,%rcx,4),%r9d
   64293:	dec    %rdi
   64296:	mov    %r9d,(%r14,%rcx,4)
   6429a:	mov    %r8d,(%rsi,%rcx,4)
   6429e:	lea    0x1(%rcx),%rcx
   642a2:	jne    6428b <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x163b>
   642a4:	mov    0x18(%rsp),%r9
   642a9:	sub    %rax,%rdx
   642ac:	cmp    $0xfffffffffffffff8,%rdx
   642b0:	ja     645a0 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1950>
   642b6:	mov    0x10(%rsp),%rdx
   642bb:	imul   0x48(%rsp),%rdx
   642c1:	add    0xc0(%rsp),%rdx
   642c9:	mov    (%r14,%rcx,4),%esi
   642cd:	mov    -0x1c(%rdx,%rcx,4),%edi
   642d1:	mov    %edi,(%r14,%rcx,4)
   642d5:	mov    %esi,-0x1c(%rdx,%rcx,4)
   642d9:	mov    0x4(%r14,%rcx,4),%esi
   642de:	mov    -0x18(%rdx,%rcx,4),%edi
   642e2:	mov    %edi,0x4(%r14,%rcx,4)
   642e7:	mov    %esi,-0x18(%rdx,%rcx,4)
   642eb:	mov    0x8(%r14,%rcx,4),%esi
   642f0:	mov    -0x14(%rdx,%rcx,4),%edi
   642f4:	mov    %edi,0x8(%r14,%rcx,4)
   642f9:	mov    %esi,-0x14(%rdx,%rcx,4)
   642fd:	mov    0xc(%r14,%rcx,4),%esi
   64302:	mov    -0x10(%rdx,%rcx,4),%edi
   64306:	mov    %edi,0xc(%r14,%rcx,4)
   6430b:	mov    %esi,-0x10(%rdx,%rcx,4)
   6430f:	mov    0x10(%r14,%rcx,4),%esi
   64314:	mov    -0xc(%rdx,%rcx,4),%edi
   64318:	mov    %edi,0x10(%r14,%rcx,4)
   6431d:	mov    %esi,-0xc(%rdx,%rcx,4)
   64321:	mov    0x14(%r14,%rcx,4),%esi
   64326:	mov    -0x8(%rdx,%rcx,4),%edi
   6432a:	mov    %edi,0x14(%r14,%rcx,4)
   6432f:	mov    %esi,-0x8(%rdx,%rcx,4)
   64333:	mov    0x18(%r14,%rcx,4),%esi
   64338:	mov    -0x4(%rdx,%rcx,4),%edi
   6433c:	mov    %edi,0x18(%r14,%rcx,4)
   64341:	mov    %esi,-0x4(%rdx,%rcx,4)
   64345:	mov    0x1c(%r14,%rcx,4),%esi
   6434a:	mov    (%rdx,%rcx,4),%edi
   6434d:	mov    %edi,0x1c(%r14,%rcx,4)
   64352:	mov    %esi,(%rdx,%rcx,4)
   64355:	add    $0x8,%rcx
   64359:	cmp    %rcx,%rax
   6435c:	jne    642c9 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1679>
   64362:	jmp    645a0 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1950>
   64367:	mov    %rbp,%r11
   6436a:	cmp    $0x4,%rax
   6436e:	jb     6439d <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x174d>
   64370:	lea    0x4(,%rdi,4),%rsi
   64378:	imul   %rax,%rsi
   6437c:	add    0x68(%rsp),%rsi
   64381:	cmp    %rsi,0xd0(%rsp)
   64389:	jae    64600 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x19b0>
   6438f:	cmp    0xb0(%rsp),%rdx
   64397:	jae    64600 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x19b0>
   6439d:	xor    %r8d,%r8d
   643a0:	mov    %eax,%edi
   643a2:	sub    %r8d,%edi
   643a5:	mov    %r8,%rsi
   643a8:	and    $0x7,%edi
   643ab:	je     643c9 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1779>
   643ad:	mov    %r8,%rsi
   643b0:	mov    (%rbx,%rsi,4),%r9d
   643b4:	mov    (%rdx,%rsi,4),%r10d
   643b8:	dec    %rdi
   643bb:	mov    %r10d,(%rbx,%rsi,4)
   643bf:	mov    %r9d,(%rdx,%rsi,4)
   643c3:	lea    0x1(%rsi),%rsi
   643c7:	jne    643b0 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1760>
   643c9:	mov    0x80(%rsp),%r10
   643d1:	mov    0x18(%rsp),%r9
   643d6:	sub    %rax,%r8
   643d9:	cmp    $0xfffffffffffffff8,%r8
   643dd:	ja     645a0 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1950>
   643e3:	imul   0x10(%rsp),%rcx
   643e9:	add    0xc8(%rsp),%rcx
   643f1:	mov    (%rbx,%rsi,4),%edx
   643f4:	mov    -0x1c(%rcx,%rsi,4),%edi
   643f8:	mov    %edi,(%rbx,%rsi,4)
   643fb:	mov    %edx,-0x1c(%rcx,%rsi,4)
   643ff:	mov    0x4(%rbx,%rsi,4),%edx
   64403:	mov    -0x18(%rcx,%rsi,4),%edi
   64407:	mov    %edi,0x4(%rbx,%rsi,4)
   6440b:	mov    %edx,-0x18(%rcx,%rsi,4)
   6440f:	mov    0x8(%rbx,%rsi,4),%edx
   64413:	mov    -0x14(%rcx,%rsi,4),%edi
   64417:	mov    %edi,0x8(%rbx,%rsi,4)
   6441b:	mov    %edx,-0x14(%rcx,%rsi,4)
   6441f:	mov    0xc(%rbx,%rsi,4),%edx
   64423:	mov    -0x10(%rcx,%rsi,4),%edi
   64427:	mov    %edi,0xc(%rbx,%rsi,4)
   6442b:	mov    %edx,-0x10(%rcx,%rsi,4)
   6442f:	mov    0x10(%rbx,%rsi,4),%edx
   64433:	mov    -0xc(%rcx,%rsi,4),%edi
   64437:	mov    %edi,0x10(%rbx,%rsi,4)
   6443b:	mov    %edx,-0xc(%rcx,%rsi,4)
   6443f:	mov    0x14(%rbx,%rsi,4),%edx
   64443:	mov    -0x8(%rcx,%rsi,4),%edi
   64447:	mov    %edi,0x14(%rbx,%rsi,4)
   6444b:	mov    %edx,-0x8(%rcx,%rsi,4)
   6444f:	mov    0x18(%rbx,%rsi,4),%edx
   64453:	mov    -0x4(%rcx,%rsi,4),%edi
   64457:	mov    %edi,0x18(%rbx,%rsi,4)
   6445b:	mov    %edx,-0x4(%rcx,%rsi,4)
   6445f:	mov    0x1c(%rbx,%rsi,4),%edx
   64463:	mov    (%rcx,%rsi,4),%edi
   64466:	mov    %edi,0x1c(%rbx,%rsi,4)
   6446a:	mov    %edx,(%rcx,%rsi,4)
   6446d:	add    $0x8,%rsi
   64471:	cmp    %rsi,%rax
   64474:	jne    643f1 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x17a1>
   6447a:	jmp    645a0 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1950>
   6447f:	mov    %rbp,%r11
   64482:	cmp    $0x4,%rax
   64486:	jb     644b3 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1863>
   64488:	lea    0x4(,%rdi,4),%rsi
   64490:	mov    0x68(%rsp),%r8
   64495:	imul   %rax,%rsi
   64499:	add    %r8,%rsi
   6449c:	cmp    %rsi,%r8
   6449f:	jae    64611 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x19c1>
   644a5:	cmp    0xb8(%rsp),%rdx
   644ad:	jae    64611 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x19c1>
   644b3:	xor    %r8d,%r8d
   644b6:	mov    %eax,%edi
   644b8:	sub    %r8d,%edi
   644bb:	mov    %r8,%rsi
   644be:	and    $0x7,%edi
   644c1:	je     644df <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x188f>
   644c3:	mov    %r8,%rsi
   644c6:	mov    (%r14,%rsi,4),%r9d
   644ca:	mov    (%rdx,%rsi,4),%r10d
   644ce:	dec    %rdi
   644d1:	mov    %r10d,(%r14,%rsi,4)
   644d5:	mov    %r9d,(%rdx,%rsi,4)
   644d9:	lea    0x1(%rsi),%rsi
   644dd:	jne    644c6 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1876>
   644df:	mov    0x80(%rsp),%r10
   644e7:	mov    0x18(%rsp),%r9
   644ec:	sub    %rax,%r8
   644ef:	cmp    $0xfffffffffffffff8,%r8
   644f3:	ja     645a0 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1950>
   644f9:	imul   0x10(%rsp),%rcx
   644ff:	add    0xc8(%rsp),%rcx
   64507:	mov    (%r14,%rsi,4),%edx
   6450b:	mov    -0x1c(%rcx,%rsi,4),%edi
   6450f:	mov    %edi,(%r14,%rsi,4)
   64513:	mov    %edx,-0x1c(%rcx,%rsi,4)
   64517:	mov    0x4(%r14,%rsi,4),%edx
   6451c:	mov    -0x18(%rcx,%rsi,4),%edi
   64520:	mov    %edi,0x4(%r14,%rsi,4)
   64525:	mov    %edx,-0x18(%rcx,%rsi,4)
   64529:	mov    0x8(%r14,%rsi,4),%edx
   6452e:	mov    -0x14(%rcx,%rsi,4),%edi
   64532:	mov    %edi,0x8(%r14,%rsi,4)
   64537:	mov    %edx,-0x14(%rcx,%rsi,4)
   6453b:	mov    0xc(%r14,%rsi,4),%edx
   64540:	mov    -0x10(%rcx,%rsi,4),%edi
   64544:	mov    %edi,0xc(%r14,%rsi,4)
   64549:	mov    %edx,-0x10(%rcx,%rsi,4)
   6454d:	mov    0x10(%r14,%rsi,4),%edx
   64552:	mov    -0xc(%rcx,%rsi,4),%edi
   64556:	mov    %edi,0x10(%r14,%rsi,4)
   6455b:	mov    %edx,-0xc(%rcx,%rsi,4)
   6455f:	mov    0x14(%r14,%rsi,4),%edx
   64564:	mov    -0x8(%rcx,%rsi,4),%edi
   64568:	mov    %edi,0x14(%r14,%rsi,4)
   6456d:	mov    %edx,-0x8(%rcx,%rsi,4)
   64571:	mov    0x18(%r14,%rsi,4),%edx
   64576:	mov    -0x4(%rcx,%rsi,4),%edi
   6457a:	mov    %edi,0x18(%r14,%rsi,4)
   6457f:	mov    %edx,-0x4(%rcx,%rsi,4)
   64583:	mov    0x1c(%r14,%rsi,4),%edx
   64588:	mov    (%rcx,%rsi,4),%edi
   6458b:	mov    %edi,0x1c(%r14,%rsi,4)
   64590:	mov    %edx,(%rcx,%rsi,4)
   64593:	add    $0x8,%rsi
   64597:	cmp    %rsi,%rax
   6459a:	jne    64507 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x18b7>
   645a0:	mov    0x28(%rsp),%r8
   645a5:	mov    0x88(%rsp),%rcx
   645ad:	cmp    %r8,%rcx
   645b0:	jae    64b72 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1f22>
   645b6:	mov    %r15,%rbp
   645b9:	mov    %r13,%r15
   645bc:	mov    %r12,%r13
   645bf:	mov    0x48(%rsp),%r12
   645c4:	mov    0x20(%rsp),%rax
   645c9:	mov    0x50(%rsp),%rdi
   645ce:	mov    %r12,(%r9,%rcx,8)
   645d2:	cmp    0x40(%rsp),%r12
   645d7:	jb     64065 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1415>
   645dd:	jmp    64b80 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1f30>
   645e2:	cmp    $0x20,%rax
   645e6:	jae    64622 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x19d2>
   645e8:	xor    %ecx,%ecx
   645ea:	jmp    6469c <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1a4c>
   645ef:	cmp    $0x20,%rax
   645f3:	jae    646d2 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1a82>
   645f9:	xor    %ecx,%ecx
   645fb:	jmp    6474a <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1afa>
   64600:	cmp    $0x20,%rax
   64604:	jae    64782 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1b32>
   6460a:	xor    %esi,%esi
   6460c:	jmp    647fa <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1baa>
   64611:	cmp    $0x20,%rax
   64615:	jae    64830 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1be0>
   6461b:	xor    %esi,%esi
   6461d:	jmp    648a6 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1c56>
   64622:	mov    0x10(%rsp),%rcx
   64627:	mov    0x58(%rsp),%rdi
   6462c:	xor    %edx,%edx
   6462e:	imul   0x48(%rsp),%rcx
   64634:	add    0xa0(%rsp),%rcx
   6463c:	vmovdqu64 -0x40(%r13,%rdx,4),%zmm0
   64644:	vmovdqu64 0x0(%r13,%rdx,4),%zmm1
   6464c:	vmovdqu64 -0x40(%rcx,%rdx,4),%zmm2
   64654:	vmovdqu64 (%rcx,%rdx,4),%zmm3
   6465b:	vmovdqu64 %zmm2,-0x40(%r13,%rdx,4)
   64663:	vmovdqu64 %zmm3,0x0(%r13,%rdx,4)
   6466b:	vmovdqu64 %zmm0,-0x40(%rcx,%rdx,4)
   64673:	vmovdqu64 %zmm1,(%rcx,%rdx,4)
   6467a:	add    $0x20,%rdx
   6467e:	cmp    %rdx,%rdi
   64681:	jne    6463c <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x19ec>
   64683:	cmp    %rdi,%rax
   64686:	je     645a0 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1950>
   6468c:	mov    0x58(%rsp),%rdx
   64691:	mov    %rdx,%rcx
   64694:	test   $0x1c,%al
   64696:	je     6415e <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x150e>
   6469c:	mov    0x90(%rsp),%rdi
   646a4:	vmovdqu (%rbx,%rcx,4),%xmm0
   646a9:	vmovdqu (%rsi,%rcx,4),%xmm1
   646ae:	vmovdqu %xmm1,(%rbx,%rcx,4)
   646b3:	vmovdqu %xmm0,(%rsi,%rcx,4)
   646b8:	add    $0x4,%rcx
   646bc:	cmp    %rcx,%rdi
   646bf:	jne    646a4 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1a54>
   646c1:	mov    %rdi,%rdx
   646c4:	cmp    %rdi,%rax
   646c7:	je     645a0 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1950>
   646cd:	jmp    6415e <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x150e>
   646d2:	mov    0x10(%rsp),%rcx
   646d7:	mov    0x58(%rsp),%rdi
   646dc:	xor    %edx,%edx
   646de:	imul   0x48(%rsp),%rcx
   646e4:	add    0xa0(%rsp),%rcx
   646ec:	vmovdqu64 -0x40(%r15,%rdx,4),%zmm0
   646f4:	vmovdqu64 (%r15,%rdx,4),%zmm1
   646fb:	vmovdqu64 -0x40(%rcx,%rdx,4),%zmm2
   64703:	vmovdqu64 (%rcx,%rdx,4),%zmm3
   6470a:	vmovdqu64 %zmm2,-0x40(%r15,%rdx,4)
   64712:	vmovdqu64 %zmm3,(%r15,%rdx,4)
   64719:	vmovdqu64 %zmm0,-0x40(%rcx,%rdx,4)
   64721:	vmovdqu64 %zmm1,(%rcx,%rdx,4)
   64728:	add    $0x20,%rdx
   6472c:	cmp    %rdx,%rdi
   6472f:	jne    646ec <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1a9c>
   64731:	cmp    %rdi,%rax
   64734:	je     645a0 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1950>
   6473a:	mov    0x58(%rsp),%rdx
   6473f:	mov    %rdx,%rcx
   64742:	test   $0x1c,%al
   64744:	je     6427c <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x162c>
   6474a:	mov    0x90(%rsp),%rdi
   64752:	vmovdqu (%r14,%rcx,4),%xmm0
   64758:	vmovdqu (%rsi,%rcx,4),%xmm1
   6475d:	vmovdqu %xmm1,(%r14,%rcx,4)
   64763:	vmovdqu %xmm0,(%rsi,%rcx,4)
   64768:	add    $0x4,%rcx
   6476c:	cmp    %rcx,%rdi
   6476f:	jne    64752 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1b02>
   64771:	mov    %rdi,%rdx
   64774:	cmp    %rdi,%rax
   64777:	je     645a0 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1950>
   6477d:	jmp    6427c <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x162c>
   64782:	mov    0x10(%rsp),%rsi
   64787:	mov    0x58(%rsp),%r8
   6478c:	xor    %edi,%edi
   6478e:	imul   %rcx,%rsi
   64792:	add    0xa8(%rsp),%rsi
   6479a:	vmovdqu64 -0x40(%r13,%rdi,4),%zmm0
   647a2:	vmovdqu64 0x0(%r13,%rdi,4),%zmm1
   647aa:	vmovdqu64 -0x40(%rsi,%rdi,4),%zmm2
   647b2:	vmovdqu64 (%rsi,%rdi,4),%zmm3
   647b9:	vmovdqu64 %zmm2,-0x40(%r13,%rdi,4)
   647c1:	vmovdqu64 %zmm3,0x0(%r13,%rdi,4)
   647c9:	vmovdqu64 %zmm0,-0x40(%rsi,%rdi,4)
   647d1:	vmovdqu64 %zmm1,(%rsi,%rdi,4)
   647d8:	add    $0x20,%rdi
   647dc:	cmp    %rdi,%r8
   647df:	jne    6479a <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1b4a>
   647e1:	cmp    %r8,%rax
   647e4:	je     645a0 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1950>
   647ea:	mov    0x58(%rsp),%r8
   647ef:	mov    %r8,%rsi
   647f2:	test   $0x1c,%al
   647f4:	je     643a0 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1750>
   647fa:	mov    0x90(%rsp),%rdi
   64802:	vmovdqu (%rbx,%rsi,4),%xmm0
   64807:	vmovdqu (%rdx,%rsi,4),%xmm1
   6480c:	vmovdqu %xmm1,(%rbx,%rsi,4)
   64811:	vmovdqu %xmm0,(%rdx,%rsi,4)
   64816:	add    $0x4,%rsi
   6481a:	cmp    %rsi,%rdi
   6481d:	jne    64802 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1bb2>
   6481f:	mov    %rdi,%r8
   64822:	cmp    %rdi,%rax
   64825:	je     645a0 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1950>
   6482b:	jmp    643a0 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1750>
   64830:	mov    0x10(%rsp),%rsi
   64835:	mov    0x58(%rsp),%r8
   6483a:	xor    %edi,%edi
   6483c:	imul   %rcx,%rsi
   64840:	add    0xa8(%rsp),%rsi
   64848:	vmovdqu64 -0x40(%r15,%rdi,4),%zmm0
   64850:	vmovdqu64 (%r15,%rdi,4),%zmm1
   64857:	vmovdqu64 -0x40(%rsi,%rdi,4),%zmm2
   6485f:	vmovdqu64 (%rsi,%rdi,4),%zmm3
   64866:	vmovdqu64 %zmm2,-0x40(%r15,%rdi,4)
   6486e:	vmovdqu64 %zmm3,(%r15,%rdi,4)
   64875:	vmovdqu64 %zmm0,-0x40(%rsi,%rdi,4)
   6487d:	vmovdqu64 %zmm1,(%rsi,%rdi,4)
   64884:	add    $0x20,%rdi
   64888:	cmp    %rdi,%r8
   6488b:	jne    64848 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1bf8>
   6488d:	cmp    %r8,%rax
   64890:	je     645a0 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1950>
   64896:	mov    0x58(%rsp),%r8
   6489b:	mov    %r8,%rsi
   6489e:	test   $0x1c,%al
   648a0:	je     644b6 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1866>
   648a6:	mov    0x90(%rsp),%rdi
   648ae:	vmovdqu (%r14,%rsi,4),%xmm0
   648b4:	vmovdqu (%rdx,%rsi,4),%xmm1
   648b9:	vmovdqu %xmm1,(%r14,%rsi,4)
   648bf:	vmovdqu %xmm0,(%rdx,%rsi,4)
   648c4:	add    $0x4,%rsi
   648c8:	cmp    %rsi,%rdi
   648cb:	jne    648ae <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1c5e>
   648cd:	mov    %rdi,%r8
   648d0:	cmp    %rdi,%rax
   648d3:	je     645a0 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1950>
   648d9:	jmp    644b6 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1866>
   648de:	mov    0x30(%rsp),%rdi
   648e3:	mov    0x138(%rsp),%r8
   648eb:	imul   %rdi,%rcx
   648ef:	lea    (%r8,%rcx,4),%rsi
   648f3:	imul   %rdi,%rax
   648f7:	shl    $0x2,%rdx
   648fb:	lea    (%r8,%rax,4),%rdi
   648ff:	vzeroupper
   64902:	call   *0xa0be8(%rip)        # 1054f0 <memmove@GLIBC_2.2.5>
   64908:	mov    0x38(%rsp),%r13
   6490d:	mov    0x80(%rsp),%r10
   64915:	mov    0x18(%rsp),%r9
   6491a:	test   %rbx,%rbx
   6491d:	je     6494c <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1cfc>
   6491f:	movzbl 0xa2f92(%rip),%eax        # 1078b8 <scan_experiment::TRACK>
   64926:	test   %al,%al
   64928:	je     64936 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1ce6>
   6492a:	shl    $0x3,%rbx
   6492e:	lock sub %rbx,0xa2f72(%rip)        # 1078a8 <scan_experiment::LIVE>
   64936:	mov    %r10,%rdi
   64939:	vzeroupper
   6493c:	call   *0xa0bd6(%rip)        # 105518 <free@GLIBC_2.2.5>
   64942:	mov    0x38(%rsp),%r13
   64947:	mov    0x18(%rsp),%r9
   6494c:	mov    0x1a0(%rsp),%rax
   64954:	lea    0x150(%rsp),%rbx
   6495c:	test   %rax,%rax
   6495f:	je     64989 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1d39>
   64961:	movzbl 0xa2f50(%rip),%ecx        # 1078b8 <scan_experiment::TRACK>
   64968:	test   %cl,%cl
   6496a:	je     64978 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1d28>
   6496c:	shl    $0x3,%rax
   64970:	lock sub %rax,0xa2f30(%rip)        # 1078a8 <scan_experiment::LIVE>
   64978:	mov    %r9,%rdi
   6497b:	vzeroupper
   6497e:	call   *0xa0b94(%rip)        # 105518 <free@GLIBC_2.2.5>
   64984:	mov    0x38(%rsp),%r13
   64989:	vmovups (%rbx),%zmm0
   6498f:	mov    0xd8(%rsp),%rax
   64997:	vmovups %zmm0,0x0(%r13)
   6499e:	test   %rax,%rax
   649a1:	je     649d0 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1d80>
   649a3:	mov    0xe0(%rsp),%rdi
   649ab:	movzbl 0xa2f06(%rip),%ecx        # 1078b8 <scan_experiment::TRACK>
   649b2:	test   %cl,%cl
   649b4:	je     649c2 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1d72>
   649b6:	shl    $0x2,%rax
   649ba:	lock sub %rax,0xa2ee6(%rip)        # 1078a8 <scan_experiment::LIVE>
   649c2:	vzeroupper
   649c5:	call   *0xa0b4d(%rip)        # 105518 <free@GLIBC_2.2.5>
   649cb:	mov    0x38(%rsp),%r13
   649d0:	mov    0xf0(%rsp),%rax
   649d8:	test   %rax,%rax
   649db:	je     64a0a <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1dba>
   649dd:	mov    0xf8(%rsp),%rdi
   649e5:	movzbl 0xa2ecc(%rip),%ecx        # 1078b8 <scan_experiment::TRACK>
   649ec:	test   %cl,%cl
   649ee:	je     649fc <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1dac>
   649f0:	shl    $0x3,%rax
   649f4:	lock sub %rax,0xa2eac(%rip)        # 1078a8 <scan_experiment::LIVE>
   649fc:	vzeroupper
   649ff:	call   *0xa0b13(%rip)        # 105518 <free@GLIBC_2.2.5>
   64a05:	mov    0x38(%rsp),%r13
   64a0a:	mov    0x108(%rsp),%rax
   64a12:	test   %rax,%rax
   64a15:	je     64a44 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1df4>
   64a17:	mov    0x110(%rsp),%rdi
   64a1f:	movzbl 0xa2e92(%rip),%ecx        # 1078b8 <scan_experiment::TRACK>
   64a26:	test   %cl,%cl
   64a28:	je     64a36 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1de6>
   64a2a:	shl    $0x3,%rax
   64a2e:	lock sub %rax,0xa2e72(%rip)        # 1078a8 <scan_experiment::LIVE>
   64a36:	vzeroupper
   64a39:	call   *0xa0ad9(%rip)        # 105518 <free@GLIBC_2.2.5>
   64a3f:	mov    0x38(%rsp),%r13
   64a44:	mov    0x120(%rsp),%rax
   64a4c:	test   %rax,%rax
   64a4f:	je     62c99 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x49>
   64a55:	mov    0x128(%rsp),%rdi
   64a5d:	movzbl 0xa2e54(%rip),%ecx        # 1078b8 <scan_experiment::TRACK>
   64a64:	test   %cl,%cl
   64a66:	je     64a70 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1e20>
   64a68:	lock sub %rax,0xa2e38(%rip)        # 1078a8 <scan_experiment::LIVE>
   64a70:	vzeroupper
   64a73:	call   *0xa0a9f(%rip)        # 105518 <free@GLIBC_2.2.5>
   64a79:	mov    0x38(%rsp),%r13
   64a7e:	jmp    62c99 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x49>
   64a83:	lea    0x1e8(%rsp),%rsi
   64a8b:	lea    -0x54bca(%rip),%rdx        # fec8 <anon.396a22046db73490f85649c540301092.0.llvm.5713125445139818657+0x913>
   64a92:	lea    0x9cf7f(%rip),%r9        # 101a18 <__frame_dummy_init_array_entry+0x158>
   64a99:	xor    %edi,%edi
   64a9b:	xor    %ecx,%ecx
   64a9d:	call   *0xa0aa5(%rip)        # 105548 <_DYNAMIC+0x2e0>
   64aa3:	jmp    6391e <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0xcce>
   64aa8:	lea    0x1c0(%rsp),%rsi
   64ab0:	lea    0x9d189(%rip),%r9        # 101c40 <__frame_dummy_init_array_entry+0x380>
   64ab7:	lea    0x198(%rsp),%rdx
   64abf:	xor    %edi,%edi
   64ac1:	xor    %ecx,%ecx
   64ac3:	vzeroupper
   64ac6:	call   *0xa0a7c(%rip)        # 105548 <_DYNAMIC+0x2e0>
   64acc:	jmp    6391e <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0xcce>
   64ad1:	lea    -0x547f2(%rip),%rdi        # 102e6 <anon.590c1ca00e458323ccaf1fde3a917a11.1522.llvm.18282150582867169823+0x326>
   64ad8:	lea    0x9d2b9(%rip),%rdx        # 101d98 <__frame_dummy_init_array_entry+0x4d8>
   64adf:	mov    $0x22,%esi
   64ae4:	vzeroupper
   64ae7:	call   *0xa0a63(%rip)        # 105550 <_DYNAMIC+0x2e8>
   64aed:	jmp    6391e <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0xcce>
   64af2:	lea    -0x54bd9(%rip),%rdi        # ff20 <anon.396a22046db73490f85649c540301092.0.llvm.5713125445139818657+0x96b>
   64af9:	lea    0x9d2e0(%rip),%rdx        # 101de0 <__frame_dummy_init_array_entry+0x520>
   64b00:	mov    $0x20,%esi
   64b05:	vzeroupper
   64b08:	call   *0xa09fa(%rip)        # 105508 <_DYNAMIC+0x2a0>
   64b0e:	jmp    6391e <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0xcce>
   64b13:	mov    %rbx,0x60(%rsp)
   64b18:	mov    %rsi,0x20(%rsp)
   64b1d:	mov    %r12,0x28(%rsp)
   64b22:	jmp    64b9b <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1f4b>
   64b24:	mov    %r8,0x20(%rsp)
   64b29:	jmp    64b9b <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1f4b>
   64b2b:	mov    %r10,%r15
   64b2e:	mov    %rdi,%rdx
   64b31:	mov    %r15,%rdi
   64b34:	vzeroupper
   64b37:	call   *0xa09d3(%rip)        # 105510 <_DYNAMIC+0x2a8>
   64b3d:	jmp    6391e <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0xcce>
   64b42:	mov    0x40(%rsp),%rax
   64b47:	mov    %r12,0x20(%rsp)
   64b4c:	mov    %rax,0x28(%rsp)
   64b51:	lea    0x9d148(%rip),%rax        # 101ca0 <__frame_dummy_init_array_entry+0x3e0>
   64b58:	jmp    64b96 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1f46>
   64b5a:	mov    0x40(%rsp),%rax
   64b5f:	mov    %r12,0x20(%rsp)
   64b64:	mov    %rax,0x28(%rsp)
   64b69:	lea    0x9d148(%rip),%rax        # 101cb8 <__frame_dummy_init_array_entry+0x3f8>
   64b70:	jmp    64b96 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1f46>
   64b72:	mov    %rcx,0x20(%rsp)
   64b77:	lea    0x9d152(%rip),%rax        # 101cd0 <__frame_dummy_init_array_entry+0x410>
   64b7e:	jmp    64b96 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1f46>
   64b80:	mov    0x40(%rsp),%rax
   64b85:	mov    %r12,0x20(%rsp)
   64b8a:	mov    %rax,0x28(%rsp)
   64b8f:	lea    0x9d152(%rip),%rax        # 101ce8 <__frame_dummy_init_array_entry+0x428>
   64b96:	mov    %rax,0x60(%rsp)
   64b9b:	mov    0x20(%rsp),%rdi
   64ba0:	mov    0x28(%rsp),%rsi
   64ba5:	mov    0x60(%rsp),%rdx
   64baa:	vzeroupper
   64bad:	call   *0xa095d(%rip)        # 105510 <_DYNAMIC+0x2a8>
   64bb3:	jmp    6391e <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0xcce>
   64bb8:	mov    $0x1,%edi
   64bbd:	mov    %r12,%rsi
   64bc0:	call   *0xa095a(%rip)        # 105520 <_DYNAMIC+0x2b8>
   64bc6:	jmp    6391e <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0xcce>
   64bcb:	lea    0x9d086(%rip),%rdi        # 101c58 <__frame_dummy_init_array_entry+0x398>
   64bd2:	vzeroupper
   64bd5:	call   *0xa095d(%rip)        # 105538 <_DYNAMIC+0x2d0>
   64bdb:	jmp    6391e <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0xcce>
   64be0:	lea    0x9d1c9(%rip),%rdx        # 101db0 <__frame_dummy_init_array_entry+0x4f0>
   64be7:	jmp    64bf3 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1fa3>
   64be9:	lea    0x9d1d8(%rip),%rdx        # 101dc8 <__frame_dummy_init_array_entry+0x508>
   64bf0:	mov    %rdi,%rsi
   64bf3:	mov    %rbx,%rdi
   64bf6:	vzeroupper
   64bf9:	call   *0xa0911(%rip)        # 105510 <_DYNAMIC+0x2a8>
   64bff:	jmp    6391e <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0xcce>
   64c04:	mov    $0x8,%edi
   64c09:	mov    %r14,%rsi
   64c0c:	call   *0xa090e(%rip)        # 105520 <_DYNAMIC+0x2b8>
   64c12:	jmp    6391e <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0xcce>
   64c17:	lea    0x9d052(%rip),%rax        # 101c70 <__frame_dummy_init_array_entry+0x3b0>
   64c1e:	jmp    64b96 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1f46>
   64c23:	lea    0x9cdd6(%rip),%rdx        # 101a00 <__frame_dummy_init_array_entry+0x140>
   64c2a:	jmp    64b31 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1ee1>
   64c2f:	movzbl 0xa2c82(%rip),%ecx        # 1078b8 <scan_experiment::TRACK>
   64c36:	mov    %rax,%r15
   64c39:	test   %cl,%cl
   64c3b:	je     64c4a <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x1ffa>
   64c3d:	mov    0x78(%rsp),%rax
   64c42:	lock sub %rax,0xa2c5e(%rip)        # 1078a8 <scan_experiment::LIVE>
   64c4a:	mov    %rbx,%rdi
   64c4d:	call   *0xa08c5(%rip)        # 105518 <free@GLIBC_2.2.5>
   64c53:	movzbl 0xa2c5e(%rip),%eax        # 1078b8 <scan_experiment::TRACK>
   64c5a:	test   %al,%al
   64c5c:	je     64c6b <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x201b>
   64c5e:	mov    0x20(%rsp),%rax
   64c63:	lock sub %rax,0xa2c3d(%rip)        # 1078a8 <scan_experiment::LIVE>
   64c6b:	mov    %r13,%rdi
   64c6e:	call   *0xa08a4(%rip)        # 105518 <free@GLIBC_2.2.5>
   64c74:	mov    0x50(%rsp),%rbx
   64c79:	test   %rbx,%rbx
   64c7c:	je     63916 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0xcc6>
   64c82:	jmp    63920 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0xcd0>
   64c87:	cmpq   $0x0,0x98(%rsp)
   64c90:	mov    %rax,%r15
   64c93:	je     64d05 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x20b5>
   64c95:	movzbl 0xa2c1c(%rip),%eax        # 1078b8 <scan_experiment::TRACK>
   64c9c:	test   %al,%al
   64c9e:	je     64cb4 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x2064>
   64ca0:	mov    0x98(%rsp),%rax
   64ca8:	shl    $0x3,%rax
   64cac:	lock sub %rax,0xa2bf4(%rip)        # 1078a8 <scan_experiment::LIVE>
   64cb4:	mov    0x80(%rsp),%rdi
   64cbc:	call   *0xa0856(%rip)        # 105518 <free@GLIBC_2.2.5>
   64cc2:	jmp    64d05 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x20b5>
   64cc4:	mov    %rax,%r15
   64cc7:	mov    0x1f0(%rsp),%rax
   64ccf:	test   %rax,%rax
   64cd2:	je     64d4c <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x20fc>
   64cd4:	mov    0x1f8(%rsp),%rdi
   64cdc:	movzbl 0xa2bd5(%rip),%ecx        # 1078b8 <scan_experiment::TRACK>
   64ce3:	test   %cl,%cl
   64ce5:	je     64d2e <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x20de>
   64ce7:	shl    $0x3,%rax
   64ceb:	lock sub %rax,0xa2bb5(%rip)        # 1078a8 <scan_experiment::LIVE>
   64cf3:	jmp    64d2e <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x20de>
   64cf5:	mov    0x1a8(%rsp),%rcx
   64cfd:	mov    %rax,%r15
   64d00:	mov    %rcx,0x18(%rsp)
   64d05:	mov    0x1a0(%rsp),%rax
   64d0d:	test   %rax,%rax
   64d10:	je     64d4c <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x20fc>
   64d12:	movzbl 0xa2b9f(%rip),%ecx        # 1078b8 <scan_experiment::TRACK>
   64d19:	test   %cl,%cl
   64d1b:	je     64d29 <block_msd_research::count_first::block_msd_stable_radixsort_body::<u32, u32>+0x20d9>
   64d1d:	shl    $0x3,%rax
   64d21:	lock sub %rax,0xa2b7f(%rip)        # 1078a8 <scan_experiment::LIVE>
   64d29:	mov    0x18(%rsp),%rdi
   64d2e:	call   *0xa07e4(%rip)        # 105518 <free@GLIBC_2.2.5>
   64d34:	lea    0xd8(%rsp),%rdi
   64d3c:	call   5d980 <core::ptr::drop_glue::<block_msd_research::count_first::Arena<u32>>>
   64d41:	mov    %r15,%rdi
   64d44:	call   100870 <_Unwind_Resume@plt>
   64d49:	mov    %rax,%r15
   64d4c:	lea    0xd8(%rsp),%rdi
   64d54:	call   5d980 <core::ptr::drop_glue::<block_msd_research::count_first::Arena<u32>>>
   64d59:	mov    %r15,%rdi
   64d5c:	call   100870 <_Unwind_Resume@plt>
   64d61:	int3
   64d62:	int3
   64d63:	int3
   64d64:	int3
   64d65:	int3
   64d66:	int3
   64d67:	int3
   64d68:	int3
   64d69:	int3
   64d6a:	int3
   64d6b:	int3
   64d6c:	int3
   64d6d:	int3
   64d6e:	int3
   64d6f:	int3
