0000000000077a70 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>>:
   77a70:	push   %rbp
   77a71:	push   %r15
   77a73:	push   %r14
   77a75:	push   %r13
   77a77:	push   %r12
   77a79:	push   %rbx
   77a7a:	sub    $0x218,%rsp
   77a81:	lea    -0x1(%rcx),%rax
   77a85:	cmp    $0x8,%rax
   77a89:	jae    7864d <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0xbdd>
   77a8f:	test   %r8,%r8
   77a92:	je     78666 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0xbf6>
   77a98:	cmp    $0x81,%r9
   77a9f:	jae    7867f <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0xc0f>
   77aa5:	mov    %rdi,%r13
   77aa8:	cmp    $0x1,%rdx
   77aac:	ja     77ad1 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x61>
   77aae:	vpxor  %xmm0,%xmm0,%xmm0
   77ab2:	vmovdqu64 %zmm0,0x0(%r13)
   77ab9:	mov    %r13,%rax
   77abc:	add    $0x218,%rsp
   77ac3:	pop    %rbx
   77ac4:	pop    %r12
   77ac6:	pop    %r13
   77ac8:	pop    %r14
   77aca:	pop    %r15
   77acc:	pop    %rbp
   77acd:	vzeroupper
   77ad0:	ret
   77ad1:	cmp    %r9,%rdx
   77ad4:	jbe    77b0b <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x9b>
   77ad6:	mov    (%rsi),%r11d
   77ad9:	lea    -0x4(,%rdx,4),%rdi
   77ae1:	mov    $0x1,%eax
   77ae6:	xor    %ebx,%ebx
   77ae8:	nopl   0x0(%rax,%rax,1)
   77af0:	mov    0x4(%rsi,%rbx,1),%ebp
   77af4:	cmp    %r11d,%ebp
   77af7:	jne    77d01 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x291>
   77afd:	inc    %rax
   77b00:	add    $0x4,%rbx
   77b04:	cmp    %rbx,%rdi
   77b07:	jne    77af0 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x80>
   77b09:	jmp    77aae <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x3e>
   77b0b:	lea    0x77(%rsp),%rax
   77b10:	mov    %rax,0xd8(%rsp)
   77b18:	cmp    $0x15,%rdx
   77b1c:	jae    786ae <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0xc3e>
   77b22:	movabs $0x3ffffffffffffffe,%rcx
   77b2c:	mov    $0x3e,%dil
   77b2f:	lea    -0x1(%rdx),%r8d
   77b33:	lea    0x4(%rsi),%rax
   77b37:	add    %rdx,%rcx
   77b3a:	bzhi   %rdi,%rcx,%rcx
   77b3f:	and    $0x3,%r8d
   77b43:	je     77b97 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x127>
   77b45:	xor    %r9d,%r9d
   77b48:	xor    %r10d,%r10d
   77b4b:	jmp    77b63 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0xf3>
   77b4d:	add    %rsi,%rdi
   77b50:	mov    %r11d,(%rdi)
   77b53:	add    $0x4,%rax
   77b57:	inc    %r10
   77b5a:	add    $0x4,%r9
   77b5e:	cmp    %r8,%r10
   77b61:	je     77b97 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x127>
   77b63:	mov    -0x4(%rax),%edi
   77b66:	mov    (%rax),%r11d
   77b69:	cmp    %edi,%r11d
   77b6c:	jae    77b53 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0xe3>
   77b6e:	lea    -0x4(%rax),%rbx
   77b72:	mov    %edi,(%rax)
   77b74:	mov    %rsi,%rdi
   77b77:	cmp    %rsi,%rbx
   77b7a:	je     77b50 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0xe0>
   77b7c:	mov    %r9,%rdi
   77b7f:	nop
   77b80:	mov    -0x4(%rsi,%rdi,1),%ebx
   77b84:	cmp    %ebx,%r11d
   77b87:	jae    77b4d <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0xdd>
   77b89:	mov    %ebx,(%rsi,%rdi,1)
   77b8c:	add    $0xfffffffffffffffc,%rdi
   77b90:	jne    77b80 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x110>
   77b92:	mov    %rsi,%rdi
   77b95:	jmp    77b50 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0xe0>
   77b97:	cmp    $0x3,%rcx
   77b9b:	jb     77aae <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x3e>
   77ba1:	lea    (%rsi,%rdx,4),%rcx
   77ba5:	jmp    77bba <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x14a>
   77ba7:	mov    %rdi,%r8
   77baa:	mov    %edx,(%r8)
   77bad:	add    $0x10,%rax
   77bb1:	cmp    %rcx,%rax
   77bb4:	je     77aae <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x3e>
   77bba:	mov    -0x4(%rax),%r8d
   77bbe:	mov    (%rax),%edx
   77bc0:	cmp    %r8d,%edx
   77bc3:	jae    77c00 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x190>
   77bc5:	lea    -0x4(%rax),%rdi
   77bc9:	mov    %r8d,(%rax)
   77bcc:	mov    %rsi,%r8
   77bcf:	cmp    %rsi,%rdi
   77bd2:	je     77c5b <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1eb>
   77bd8:	nopl   0x0(%rax,%rax,1)
   77be0:	mov    -0x4(%rdi),%r8d
   77be4:	cmp    %r8d,%edx
   77be7:	jae    77c58 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1e8>
   77be9:	mov    %r8d,(%rdi)
   77bec:	add    $0xfffffffffffffffc,%rdi
   77bf0:	cmp    %rsi,%rdi
   77bf3:	jne    77be0 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x170>
   77bf5:	mov    %rsi,%r8
   77bf8:	jmp    77c5b <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1eb>
   77bfa:	nopw   0x0(%rax,%rax,1)
   77c00:	mov    (%rax),%edi
   77c02:	mov    0x4(%rax),%edx
   77c05:	cmp    %edi,%edx
   77c07:	jae    77c67 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1f7>
   77c09:	mov    %edi,0x4(%rax)
   77c0c:	mov    %rsi,%rdi
   77c0f:	cmp    %rsi,%rax
   77c12:	je     77c38 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1c8>
   77c14:	mov    %rax,%rdi
   77c17:	nopw   0x0(%rax,%rax,1)
   77c20:	mov    -0x4(%rdi),%r8d
   77c24:	cmp    %r8d,%edx
   77c27:	jae    77c38 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1c8>
   77c29:	mov    %r8d,(%rdi)
   77c2c:	add    $0xfffffffffffffffc,%rdi
   77c30:	cmp    %rsi,%rdi
   77c33:	jne    77c20 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1b0>
   77c35:	mov    %rsi,%rdi
   77c38:	mov    %edx,(%rdi)
   77c3a:	mov    0x4(%rax),%r8d
   77c3e:	mov    0x8(%rax),%edx
   77c41:	cmp    %r8d,%edx
   77c44:	jb     77c73 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x203>
   77c46:	mov    0x8(%rax),%r8d
   77c4a:	mov    0xc(%rax),%edx
   77c4d:	cmp    %r8d,%edx
   77c50:	jae    77bad <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x13d>
   77c56:	jmp    77cc0 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x250>
   77c58:	mov    %rdi,%r8
   77c5b:	mov    %edx,(%r8)
   77c5e:	mov    (%rax),%edi
   77c60:	mov    0x4(%rax),%edx
   77c63:	cmp    %edi,%edx
   77c65:	jb     77c09 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x199>
   77c67:	mov    0x4(%rax),%r8d
   77c6b:	mov    0x8(%rax),%edx
   77c6e:	cmp    %r8d,%edx
   77c71:	jae    77c46 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1d6>
   77c73:	lea    0x4(%rax),%rdi
   77c77:	mov    %r8d,0x8(%rax)
   77c7b:	mov    %rsi,%r8
   77c7e:	cmp    %rsi,%rdi
   77c81:	je     77cad <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x23d>
   77c83:	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   77c90:	mov    -0x4(%rdi),%r8d
   77c94:	cmp    %r8d,%edx
   77c97:	jae    77caa <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x23a>
   77c99:	mov    %r8d,(%rdi)
   77c9c:	add    $0xfffffffffffffffc,%rdi
   77ca0:	cmp    %rsi,%rdi
   77ca3:	jne    77c90 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x220>
   77ca5:	mov    %rsi,%r8
   77ca8:	jmp    77cad <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x23d>
   77caa:	mov    %rdi,%r8
   77cad:	mov    %edx,(%r8)
   77cb0:	mov    0x8(%rax),%r8d
   77cb4:	mov    0xc(%rax),%edx
   77cb7:	cmp    %r8d,%edx
   77cba:	jae    77bad <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x13d>
   77cc0:	lea    0x8(%rax),%rdi
   77cc4:	mov    %r8d,0xc(%rax)
   77cc8:	mov    %rsi,%r8
   77ccb:	cmp    %rsi,%rdi
   77cce:	je     77baa <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x13a>
   77cd4:	data16 data16 cs nopw 0x0(%rax,%rax,1)
   77ce0:	mov    -0x4(%rdi),%r8d
   77ce4:	cmp    %r8d,%edx
   77ce7:	jae    77ba7 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x137>
   77ced:	mov    %r8d,(%rdi)
   77cf0:	add    $0xfffffffffffffffc,%rdi
   77cf4:	cmp    %rsi,%rdi
   77cf7:	jne    77ce0 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x270>
   77cf9:	mov    %rsi,%r8
   77cfc:	jmp    77baa <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x13a>
   77d01:	cmp    $0x2,%rax
   77d05:	lea    0x0(,%rdx,4),%r12
   77d0d:	lea    -0x8(,%rdx,4),%rdi
   77d15:	setae  %al
   77d18:	cmp    %rbx,%rdi
   77d1b:	jne    77d3e <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x2ce>
   77d1d:	cmp    %ebp,%r11d
   77d20:	jb     77aae <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x3e>
   77d26:	mov    %rdx,%rcx
   77d29:	shr    $1,%rcx
   77d2c:	cmp    $0x10,%rdx
   77d30:	jae    77dc8 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x358>
   77d36:	xor    %r8d,%r8d
   77d39:	jmp    78004 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x594>
   77d3e:	add    $0x8,%rbx
   77d42:	mov    %ebp,%edi
   77d44:	cmp    %ebp,%r11d
   77d47:	jae    77d70 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x300>
   77d49:	nopl   0x0(%rax)
   77d50:	mov    %edi,%r10d
   77d53:	mov    (%rsi,%rbx,1),%edi
   77d56:	cmp    %edi,%r10d
   77d59:	ja     77d8d <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x31d>
   77d5b:	add    $0x4,%rbx
   77d5f:	cmp    %rbx,%r12
   77d62:	jne    77d50 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x2e0>
   77d64:	jmp    77d1d <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x2ad>
   77d66:	cs nopw 0x0(%rax,%rax,1)
   77d70:	mov    %edi,%r10d
   77d73:	mov    (%rsi,%rbx,1),%edi
   77d76:	cmp    %edi,%r10d
   77d79:	jb     77d8d <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x31d>
   77d7b:	sete   %r10b
   77d7f:	add    $0x4,%rbx
   77d83:	or     %r10b,%al
   77d86:	cmp    %rbx,%r12
   77d89:	jne    77d70 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x300>
   77d8b:	jmp    77d1d <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x2ad>
   77d8d:	test   %rcx,%rcx
   77d90:	je     786ec <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0xc7c>
   77d96:	mov    %rdx,%rax
   77d99:	or     %r8,%rax
   77d9c:	mov    %rdx,0x10(%rsp)
   77da1:	shr    $0x20,%rax
   77da5:	je     77de4 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x374>
   77da7:	mov    %rdx,%rax
   77daa:	xor    %edx,%edx
   77dac:	div    %r8
   77daf:	mov    %rdx,%rdi
   77db2:	mov    %rax,%r15
   77db5:	cmp    $0x20,%rcx
   77db9:	ja     77df6 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x386>
   77dbb:	mov    $0x20,%eax
   77dc0:	xor    %edx,%edx
   77dc2:	div    %ecx
   77dc4:	mov    %eax,%ebx
   77dc6:	jmp    77dfd <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x38d>
   77dc8:	movabs $0xfffffffffffffe0,%r9
   77dd2:	cmp    $0x40,%rdx
   77dd6:	jae    77f0f <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x49f>
   77ddc:	xor    %r8d,%r8d
   77ddf:	jmp    77fa3 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x533>
   77de4:	mov    %edx,%eax
   77de6:	xor    %edx,%edx
   77de8:	div    %r8d
   77deb:	mov    %edx,%edi
   77ded:	mov    %eax,%r15d
   77df0:	cmp    $0x20,%rcx
   77df4:	jbe    77dbb <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x34b>
   77df6:	mov    $0x20,%edx
   77dfb:	xor    %ebx,%ebx
   77dfd:	cmp    $0x1,%rdx
   77e01:	mov    $0x2,%eax
   77e06:	mov    %r15,%r14
   77e09:	mov    %rdi,0x48(%rsp)
   77e0e:	sbb    $0xffffffffffffffff,%rbx
   77e12:	cmp    $0x1,%rdi
   77e16:	shlx   %rcx,%rax,%rax
   77e1b:	sbb    $0xffffffffffffffff,%r14
   77e1f:	cmp    %rax,%r14
   77e22:	cmovae %rax,%r14
   77e26:	lea    0x8(%r14,%rbx,2),%rbp
   77e2b:	mov    %rbp,%rax
   77e2e:	mul    %r8
   77e31:	jo     786c9 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0xc59>
   77e37:	mov    %rax,%rdi
   77e3a:	lea    0x0(,%rax,4),%r12
   77e42:	movabs $0x3ffffffffffffffe,%rax
   77e4c:	movabs $0x7ffffffffffffff8,%r10
   77e56:	inc    %rax
   77e59:	lea    0x4(%r10),%rdx
   77e5d:	cmp    %rax,%rdi
   77e60:	seta   %al
   77e63:	cmp    %rdx,%r12
   77e66:	seta   %dl
   77e69:	or     %al,%dl
   77e6b:	je     77e78 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x408>
   77e6d:	xor    %edi,%edi
   77e6f:	mov    %r12,%rsi
   77e72:	call   *0x8d6a8(%rip)        # 105520 <_DYNAMIC+0x2b8>
   77e78:	mov    %r9,0x88(%rsp)
   77e80:	mov    %rcx,0x68(%rsp)
   77e85:	mov    %r8,0x28(%rsp)
   77e8a:	mov    %rdi,0x40(%rsp)
   77e8f:	test   %r12,%r12
   77e92:	je     78260 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x7f0>
   77e98:	mov    %r15,0x18(%rsp)
   77e9d:	mov    %rsi,%r15
   77ea0:	call   *0x8d682(%rip)        # 105528 <_DYNAMIC+0x2c0>
   77ea6:	mov    %r12,%rdi
   77ea9:	call   *0x8d681(%rip)        # 105530 <malloc@GLIBC_2.2.5>
   77eaf:	mov    %rax,0x30(%rsp)
   77eb4:	test   %rax,%rax
   77eb7:	je     786f9 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0xc89>
   77ebd:	movzbl 0x8f9f4(%rip),%eax        # 1078b8 <scan_experiment::TRACK>
   77ec4:	movabs $0x7ffffffffffffff8,%r10
   77ece:	test   %al,%al
   77ed0:	je     78287 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x817>
   77ed6:	mov    %r12,%rdx
   77ed9:	lock xadd %rdx,0x8f9c6(%rip)        # 1078a8 <scan_experiment::LIVE>
   77ee2:	mov    %r15,%rsi
   77ee5:	mov    0x8f9c4(%rip),%rax        # 1078b0 <scan_experiment::PEAK>
   77eec:	add    %r12,%rdx
   77eef:	nop
   77ef0:	cmp    %rdx,%rax
   77ef3:	mov    %rdx,%rdi
   77ef6:	cmova  %rax,%rdi
   77efa:	lock cmpxchg %rdi,0x8f9ad(%rip)        # 1078b0 <scan_experiment::PEAK>
   77f03:	jne    77ef0 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x480>
   77f05:	mov    0x40(%rsp),%rdi
   77f0a:	jmp    7828f <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x81f>
   77f0f:	mov    %rdx,%r11
   77f12:	shr    $0x6,%r11
   77f16:	lea    -0x40(%r12,%rsi,1),%r14
   77f1b:	mov    %rcx,%r8
   77f1e:	and    %r9,%r8
   77f21:	lea    0x40(%rsi),%rbx
   77f25:	xor    %r15d,%r15d
   77f28:	shl    $0x5,%r11
   77f2c:	neg    %r11
   77f2f:	nop
   77f30:	vpshufd $0x1b,(%r14,%r15,4),%zmm0
   77f38:	vpshufd $0x1b,-0x40(%r14,%r15,4),%zmm1
   77f41:	vpshufd $0x1b,-0x40(%rbx),%zmm2
   77f49:	vshufi64x2 $0x1b,%zmm0,%zmm0,%zmm0
   77f50:	vshufi64x2 $0x1b,%zmm1,%zmm1,%zmm1
   77f57:	vmovdqu64 %zmm0,-0x40(%rbx)
   77f5e:	vpshufd $0x1b,(%rbx),%zmm0
   77f65:	vmovdqu64 %zmm1,(%rbx)
   77f6b:	vshufi64x2 $0x1b,%zmm2,%zmm2,%zmm1
   77f72:	sub    $0xffffffffffffff80,%rbx
   77f76:	vmovdqu64 %zmm1,(%r14,%r15,4)
   77f7d:	vshufi64x2 $0x1b,%zmm0,%zmm0,%zmm0
   77f84:	vmovdqu64 %zmm0,-0x40(%r14,%r15,4)
   77f8c:	add    $0xffffffffffffffe0,%r15
   77f90:	cmp    %r15,%r11
   77f93:	jne    77f30 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x4c0>
   77f95:	cmp    %r8,%rcx
   77f98:	je     7803a <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x5ca>
   77f9e:	test   $0x30,%dl
   77fa1:	je     78004 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x594>
   77fa3:	add    $0x18,%r9
   77fa7:	mov    %r8,%r11
   77faa:	lea    (%rsi,%r11,4),%rdi
   77fae:	lea    -0x20(%r12,%rsi,1),%r10
   77fb3:	neg    %r11
   77fb6:	mov    %r9,%r8
   77fb9:	mov    %rdx,%r9
   77fbc:	shr    $0x4,%r9
   77fc0:	and    %rcx,%r8
   77fc3:	shl    $0x3,%r9
   77fc7:	neg    %r9
   77fca:	nopw   0x0(%rax,%rax,1)
   77fd0:	vpshufd $0x1b,(%r10,%r11,4),%ymm0
   77fd7:	vpshufd $0x1b,(%rdi),%ymm1
   77fdc:	vpermq $0x4e,%ymm0,%ymm0
   77fe2:	vpermq $0x4e,%ymm1,%ymm1
   77fe8:	vmovdqu %ymm0,(%rdi)
   77fec:	vmovdqu %ymm1,(%r10,%r11,4)
   77ff2:	add    $0xfffffffffffffff8,%r11
   77ff6:	add    $0x20,%rdi
   77ffa:	cmp    %r11,%r9
   77ffd:	jne    77fd0 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x560>
   77fff:	cmp    %r8,%rcx
   78002:	je     7803a <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x5ca>
   78004:	lea    (%rsi,%r8,4),%rdi
   78008:	lea    -0x4(%r12,%rsi,1),%r9
   7800d:	neg    %rcx
   78010:	neg    %r8
   78013:	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   78020:	mov    (%rdi),%r10d
   78023:	mov    (%r9,%r8,4),%r11d
   78027:	mov    %r11d,(%rdi)
   7802a:	mov    %r10d,(%r9,%r8,4)
   7802e:	dec    %r8
   78031:	add    $0x4,%rdi
   78035:	cmp    %r8,%rcx
   78038:	jne    78020 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x5b0>
   7803a:	test   $0x1,%al
   7803c:	je     77aae <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x3e>
   78042:	mov    (%rsi),%ebp
   78044:	lea    -0x3c(%rsi),%rbx
   78048:	lea    -0x1c(%rsi),%r14
   7804c:	mov    $0x1,%eax
   78051:	mov    %r13,0x38(%rsp)
   78056:	xor    %r8d,%r8d
   78059:	mov    %rsi,%r15
   7805c:	jmp    7807b <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x60b>
   7805e:	xchg   %ax,%ax
   78060:	mov    %r9,%r8
   78063:	inc    %rax
   78066:	add    $0x4,%rbx
   7806a:	add    $0x4,%r14
   7806e:	add    $0x4,%r15
   78072:	cmp    %rdx,%rax
   78075:	je     78222 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x7b2>
   7807b:	mov    %ebp,%ecx
   7807d:	mov    (%rsi,%rax,4),%ebp
   78080:	mov    %r8,%r9
   78083:	cmp    %ecx,%ebp
   78085:	je     78060 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x5f0>
   78087:	mov    %rax,%r11
   7808a:	sub    %r9,%r11
   7808d:	mov    %rax,%r8
   78090:	cmp    $0x1,%r11
   78094:	jbe    78063 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x5f3>
   78096:	mov    %rax,%r12
   78099:	sub    %r9,%r12
   7809c:	jb     78698 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0xc28>
   780a2:	cmp    $0x10,%r11
   780a6:	jae    780b0 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x640>
   780a8:	xor    %r13d,%r13d
   780ab:	jmp    781dd <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x76d>
   780b0:	mov    %r11,%rcx
   780b3:	shr    $1,%rcx
   780b6:	cmp    $0x40,%r11
   780ba:	jae    780c4 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x654>
   780bc:	xor    %r13d,%r13d
   780bf:	jmp    78167 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x6f7>
   780c4:	movabs $0x7ffffffffffffff8,%rdi
   780ce:	mov    %r12,%r8
   780d1:	shr    $0x6,%r8
   780d5:	lea    -0x18(%rdi),%r13
   780d9:	lea    0x40(%rsi),%rdi
   780dd:	shl    $0x5,%r8
   780e1:	lea    (%rdi,%r9,4),%r10
   780e5:	and    %rcx,%r13
   780e8:	neg    %r8
   780eb:	xor    %edi,%edi
   780ed:	nopl   (%rax)
   780f0:	vpshufd $0x1b,(%rbx,%rdi,4),%zmm0
   780f8:	vpshufd $0x1b,-0x40(%rbx,%rdi,4),%zmm1
   78101:	vpshufd $0x1b,-0x40(%r10),%zmm2
   78109:	vshufi64x2 $0x1b,%zmm0,%zmm0,%zmm0
   78110:	vshufi64x2 $0x1b,%zmm1,%zmm1,%zmm1
   78117:	vmovdqu64 %zmm0,-0x40(%r10)
   7811e:	vpshufd $0x1b,(%r10),%zmm0
   78125:	vmovdqu64 %zmm1,(%r10)
   7812b:	vshufi64x2 $0x1b,%zmm2,%zmm2,%zmm1
   78132:	sub    $0xffffffffffffff80,%r10
   78136:	vmovdqu64 %zmm1,(%rbx,%rdi,4)
   7813d:	vshufi64x2 $0x1b,%zmm0,%zmm0,%zmm0
   78144:	vmovdqu64 %zmm0,-0x40(%rbx,%rdi,4)
   7814c:	add    $0xffffffffffffffe0,%rdi
   78150:	cmp    %rdi,%r8
   78153:	jne    780f0 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x680>
   78155:	mov    %rax,%r8
   78158:	cmp    %r13,%rcx
   7815b:	je     78063 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x5f3>
   78161:	test   $0x30,%r11b
   78165:	je     781dd <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x76d>
   78167:	mov    %r13,%r8
   7816a:	shl    $0x2,%r13
   7816e:	mov    %r12,%r10
   78171:	shr    $0x4,%r10
   78175:	movabs $0x7ffffffffffffff8,%rdi
   7817f:	neg    %r8
   78182:	lea    0x0(%r13,%r9,4),%r11
   78187:	shl    $0x3,%r10
   7818b:	mov    %rcx,%r13
   7818e:	and    %rdi,%r13
   78191:	neg    %r10
   78194:	add    %rsi,%r11
   78197:	nopw   0x0(%rax,%rax,1)
   781a0:	vpshufd $0x1b,(%r14,%r8,4),%ymm0
   781a7:	vpshufd $0x1b,(%r11),%ymm1
   781ad:	vpermq $0x4e,%ymm0,%ymm0
   781b3:	vpermq $0x4e,%ymm1,%ymm1
   781b9:	vmovdqu %ymm0,(%r11)
   781be:	vmovdqu %ymm1,(%r14,%r8,4)
   781c4:	add    $0xfffffffffffffff8,%r8
   781c8:	add    $0x20,%r11
   781cc:	cmp    %r8,%r10
   781cf:	jne    781a0 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x730>
   781d1:	mov    %rax,%r8
   781d4:	cmp    %r13,%rcx
   781d7:	je     78063 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x5f3>
   781dd:	lea    0x0(,%r13,4),%r8
   781e5:	lea    (%rsi,%r9,4),%rcx
   781e9:	mov    %r15,%rdi
   781ec:	shr    $1,%r12
   781ef:	sub    %r8,%rdi
   781f2:	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   78200:	mov    (%rcx,%r13,4),%r8d
   78204:	mov    (%rdi),%r9d
   78207:	mov    %r9d,(%rcx,%r13,4)
   7820b:	mov    %r8d,(%rdi)
   7820e:	inc    %r13
   78211:	add    $0xfffffffffffffffc,%rdi
   78215:	cmp    %r13,%r12
   78218:	jne    78200 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x790>
   7821a:	mov    %rax,%r8
   7821d:	jmp    78063 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x5f3>
   78222:	mov    0x38(%rsp),%r13
   78227:	lea    0x0(,%rdx,4),%r10
   7822f:	mov    %rdx,%rcx
   78232:	sub    %r8,%rcx
   78235:	cmp    $0x1,%rcx
   78239:	jbe    77aae <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x3e>
   7823f:	cmp    %r8,%rdx
   78242:	jb     786d6 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0xc66>
   78248:	lea    (%rsi,%r8,4),%rax
   7824c:	mov    %rcx,%rdx
   7824f:	shr    $1,%rdx
   78252:	cmp    $0x10,%rcx
   78256:	jae    78275 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x805>
   78258:	xor    %r9d,%r9d
   7825b:	jmp    78611 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0xba1>
   78260:	mov    $0x4,%eax
   78265:	movq   $0x0,0x50(%rsp)
   7826e:	mov    %rax,0x30(%rsp)
   78273:	jmp    78299 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x829>
   78275:	cmp    $0x40,%rcx
   78279:	jae    78517 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0xaa7>
   7827f:	xor    %r9d,%r9d
   78282:	jmp    785b6 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0xb46>
   78287:	mov    0x40(%rsp),%rdi
   7828c:	mov    %r15,%rsi
   7828f:	mov    %rdi,0x50(%rsp)
   78294:	mov    0x18(%rsp),%r15
   78299:	lea    (%r14,%rbx,2),%rax
   7829d:	lea    0x8(%r15,%rax,1),%r12
   782a2:	lea    0x0(,%r12,8),%r9
   782aa:	mov    %r12,%rax
   782ad:	shr    $0x3d,%rax
   782b1:	setne  %al
   782b4:	cmp    %r10,%r9
   782b7:	seta   %dl
   782ba:	or     %al,%dl
   782bc:	je     782d3 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x863>
   782be:	xor    %edi,%edi
   782c0:	mov    0x50(%rsp),%rbx
   782c5:	mov    %r9,%rsi
   782c8:	call   *0x8d252(%rip)        # 105520 <_DYNAMIC+0x2b8>
   782ce:	jmp    7873e <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0xcce>
   782d3:	mov    %r13,0x38(%rsp)
   782d8:	mov    %rsi,0x18(%rsp)
   782dd:	mov    %r9,%r13
   782e0:	call   *0x8d242(%rip)        # 105528 <_DYNAMIC+0x2c0>
   782e6:	mov    %r13,%rdi
   782e9:	mov    %r13,0x20(%rsp)
   782ee:	call   *0x8d23c(%rip)        # 105530 <malloc@GLIBC_2.2.5>
   782f4:	test   %rax,%rax
   782f7:	je     78707 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0xc97>
   782fd:	movzbl 0x8f5b4(%rip),%ecx        # 1078b8 <scan_experiment::TRACK>
   78304:	mov    %rax,%r13
   78307:	lea    0x0(,%r12,8),%rax
   7830f:	add    %rbx,%rbx
   78312:	test   %cl,%cl
   78314:	je     78341 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x8d1>
   78316:	mov    %rax,%rcx
   78319:	lock xadd %rcx,0x8f586(%rip)        # 1078a8 <scan_experiment::LIVE>
   78322:	add    %rax,%rcx
   78325:	mov    0x8f584(%rip),%rax        # 1078b0 <scan_experiment::PEAK>
   7832c:	cmp    %rcx,%rax
   7832f:	mov    %rcx,%rdx
   78332:	cmova  %rax,%rdx
   78336:	lock cmpxchg %rdx,0x8f571(%rip)        # 1078b0 <scan_experiment::PEAK>
   7833f:	jne    7832c <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x8bc>
   78341:	add    %r15,%r14
   78344:	lea    0x7(%rbx,%r14,1),%rdx
   78349:	lea    (%r14,%rbx,1),%rax
   7834d:	cmp    $0x19,%rax
   78351:	jae    78357 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x8e7>
   78353:	xor    %eax,%eax
   78355:	jmp    7839f <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x92f>
   78357:	mov    %rdx,%rax
   7835a:	and    $0xffffffffffffffe0,%rax
   7835e:	vpternlogd $0xff,%zmm0,%zmm0,%zmm0
   78365:	xor    %esi,%esi
   78367:	lea    0x0(%r13,%rax,8),%rcx
   7836c:	vmovdqu64 %zmm0,0x0(%r13,%rsi,8)
   78374:	vmovdqu64 %zmm0,0x40(%r13,%rsi,8)
   7837c:	vmovdqu64 %zmm0,0x80(%r13,%rsi,8)
   78384:	vmovdqu64 %zmm0,0xc0(%r13,%rsi,8)
   7838c:	add    $0x20,%rsi
   78390:	cmp    %rsi,%rax
   78393:	jne    7836c <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x8fc>
   78395:	cmp    %rax,%rdx
   78398:	je     783e1 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x971>
   7839a:	test   $0x18,%dl
   7839d:	je     783cb <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x95b>
   7839f:	mov    %rax,%rsi
   783a2:	mov    %rdx,%rax
   783a5:	and    $0xfffffffffffffff8,%rax
   783a9:	vpternlogd $0xff,%zmm0,%zmm0,%zmm0
   783b0:	lea    0x0(%r13,%rax,8),%rcx
   783b5:	vmovdqu64 %zmm0,0x0(%r13,%rsi,8)
   783bd:	add    $0x8,%rsi
   783c1:	cmp    %rsi,%rax
   783c4:	jne    783b5 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x945>
   783c6:	cmp    %rax,%rdx
   783c9:	je     783e1 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x971>
   783cb:	not    %rax
   783ce:	add    %r12,%rax
   783d1:	movq   $0xffffffffffffffff,(%rcx)
   783d8:	add    $0x8,%rcx
   783dc:	dec    %rax
   783df:	jne    783d1 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x961>
   783e1:	movq   $0xffffffffffffffff,(%rcx)
   783e8:	lea    0x0(,%rbp,8),%r14
   783f0:	vzeroupper
   783f3:	call   *0x8d12f(%rip)        # 105528 <_DYNAMIC+0x2c0>
   783f9:	mov    %r14,%rdi
   783fc:	call   *0x8d12e(%rip)        # 105530 <malloc@GLIBC_2.2.5>
   78402:	test   %rax,%rax
   78405:	je     78716 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0xca6>
   7840b:	movzbl 0x8f4a6(%rip),%ecx        # 1078b8 <scan_experiment::TRACK>
   78412:	mov    %rax,%rbx
   78415:	test   %cl,%cl
   78417:	je     78444 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x9d4>
   78419:	mov    %r14,%rcx
   7841c:	lock xadd %rcx,0x8f483(%rip)        # 1078a8 <scan_experiment::LIVE>
   78425:	mov    0x8f484(%rip),%rax        # 1078b0 <scan_experiment::PEAK>
   7842c:	add    %r14,%rcx
   7842f:	cmp    %rcx,%rax
   78432:	mov    %rcx,%rdx
   78435:	cmova  %rax,%rdx
   78439:	lock cmpxchg %rdx,0x8f46e(%rip)        # 1078b0 <scan_experiment::PEAK>
   78442:	jne    7842f <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x9bf>
   78444:	cmp    $0x20,%rbp
   78448:	jae    78451 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x9e1>
   7844a:	xor    %eax,%eax
   7844c:	jmp    784df <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0xa6f>
   78451:	vmovdqa64 -0x6809b(%rip),%zmm0        # 103c0 <anon.590c1ca00e458323ccaf1fde3a917a11.1522.llvm.18282150582867169823+0x400>
   7845b:	vpbroadcastq -0x685e5(%rip),%zmm1        # fe80 <anon.396a22046db73490f85649c540301092.0.llvm.5713125445139818657+0x8cb>
   78465:	vpbroadcastq -0x68577(%rip),%zmm2        # fef8 <anon.396a22046db73490f85649c540301092.0.llvm.5713125445139818657+0x943>
   7846f:	vpbroadcastq -0x685a9(%rip),%zmm3        # fed0 <anon.396a22046db73490f85649c540301092.0.llvm.5713125445139818657+0x91b>
   78479:	vpbroadcastq -0x685c3(%rip),%zmm4        # fec0 <anon.396a22046db73490f85649c540301092.0.llvm.5713125445139818657+0x90b>
   78483:	mov    %ebp,%eax
   78485:	and    $0x7ffe0,%eax
   7848a:	xor    %ecx,%ecx
   7848c:	vpaddq %zmm1,%zmm0,%zmm5
   78492:	vpaddq %zmm2,%zmm0,%zmm6
   78498:	vpaddq %zmm3,%zmm0,%zmm7
   7849e:	vmovdqu64 %zmm0,(%rbx,%rcx,8)
   784a5:	vpaddq %zmm4,%zmm0,%zmm0
   784ab:	vmovdqu64 %zmm5,0x40(%rbx,%rcx,8)
   784b3:	vmovdqu64 %zmm6,0x80(%rbx,%rcx,8)
   784bb:	vmovdqu64 %zmm7,0xc0(%rbx,%rcx,8)
   784c3:	add    $0x20,%rcx
   784c7:	cmp    %rcx,%rax
   784ca:	jne    7848c <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0xa1c>
   784cc:	cmp    %rax,%rbp
   784cf:	je     78776 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0xd06>
   784d5:	test   $0x1c,%bpl
   784d9:	je     7876a <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0xcfa>
   784df:	mov    %rax,%rcx
   784e2:	vpbroadcastq %rcx,%ymm0
   784e8:	vpor   -0x68590(%rip),%ymm0,%ymm0        # ff60 <anon.396a22046db73490f85649c540301092.0.llvm.5713125445139818657+0x9ab>
   784f0:	vpbroadcastq -0x68609(%rip),%ymm1        # fef0 <anon.396a22046db73490f85649c540301092.0.llvm.5713125445139818657+0x93b>
   784f9:	mov    %ebp,%eax
   784fb:	and    $0x7fffc,%eax
   78500:	vmovdqu %ymm0,(%rbx,%rcx,8)
   78505:	add    $0x4,%rcx
   78509:	vpaddq %ymm1,%ymm0,%ymm0
   7850d:	cmp    %rcx,%rax
   78510:	jne    78500 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0xa90>
   78512:	jmp    78771 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0xd01>
   78517:	mov    %rcx,%r11
   7851a:	shr    $0x6,%r11
   7851e:	movabs $0x7ffffffffffffff8,%rdi
   78528:	lea    0x40(%rsi,%r8,4),%r8
   7852d:	lea    -0x40(%r10,%rsi,1),%rbx
   78532:	xor    %r14d,%r14d
   78535:	lea    -0x18(%rdi),%r9
   78539:	shl    $0x5,%r11
   7853d:	and    %rdx,%r9
   78540:	neg    %r11
   78543:	vpshufd $0x1b,(%rbx,%r14,4),%zmm0
   7854b:	vpshufd $0x1b,-0x40(%rbx,%r14,4),%zmm1
   78554:	vpshufd $0x1b,-0x40(%r8),%zmm2
   7855c:	vshufi64x2 $0x1b,%zmm0,%zmm0,%zmm0
   78563:	vshufi64x2 $0x1b,%zmm1,%zmm1,%zmm1
   7856a:	vmovdqu64 %zmm0,-0x40(%r8)
   78571:	vpshufd $0x1b,(%r8),%zmm0
   78578:	vmovdqu64 %zmm1,(%r8)
   7857e:	vshufi64x2 $0x1b,%zmm2,%zmm2,%zmm1
   78585:	sub    $0xffffffffffffff80,%r8
   78589:	vmovdqu64 %zmm1,(%rbx,%r14,4)
   78590:	vshufi64x2 $0x1b,%zmm0,%zmm0,%zmm0
   78597:	vmovdqu64 %zmm0,-0x40(%rbx,%r14,4)
   7859f:	add    $0xffffffffffffffe0,%r14
   785a3:	cmp    %r14,%r11
   785a6:	jne    78543 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0xad3>
   785a8:	cmp    %r9,%rdx
   785ab:	je     77aae <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x3e>
   785b1:	test   $0x30,%cl
   785b4:	je     78611 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0xba1>
   785b6:	lea    0x0(,%r9,4),%rcx
   785be:	mov    %r10,%rdi
   785c1:	movabs $0x7ffffffffffffff8,%r8
   785cb:	and    %rdx,%r8
   785ce:	sub    %rcx,%rdi
   785d1:	lea    -0x20(%rdi,%rsi,1),%rcx
   785d6:	vpshufd $0x1b,(%rcx),%ymm0
   785db:	vpshufd $0x1b,(%rax,%r9,4),%ymm1
   785e2:	vpermq $0x4e,%ymm0,%ymm0
   785e8:	vpermq $0x4e,%ymm1,%ymm1
   785ee:	vmovdqu %ymm0,(%rax,%r9,4)
   785f4:	vmovdqu %ymm1,(%rcx)
   785f8:	add    $0x8,%r9
   785fc:	add    $0xffffffffffffffe0,%rcx
   78600:	cmp    %r9,%r8
   78603:	jne    785d6 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0xb66>
   78605:	mov    %r8,%r9
   78608:	cmp    %r8,%rdx
   7860b:	je     77aae <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x3e>
   78611:	lea    0x0(,%r9,4),%rcx
   78619:	sub    %rcx,%r10
   7861c:	lea    -0x4(%r10,%rsi,1),%rcx
   78621:	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   78630:	mov    (%rax,%r9,4),%esi
   78634:	mov    (%rcx),%edi
   78636:	mov    %edi,(%rax,%r9,4)
   7863a:	mov    %esi,(%rcx)
   7863c:	inc    %r9
   7863f:	add    $0xfffffffffffffffc,%rcx
   78643:	cmp    %r9,%rdx
   78646:	jne    78630 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0xbc0>
   78648:	jmp    77aae <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x3e>
   7864d:	lea    -0x68014(%rip),%rdi        # 10640 <anon.590c1ca00e458323ccaf1fde3a917a11.1522.llvm.18282150582867169823+0x680>
   78654:	lea    0x89845(%rip),%rdx        # 101ea0 <__frame_dummy_init_array_entry+0x5e0>
   7865b:	mov    $0x2a,%esi
   78660:	call   *0x8cea2(%rip)        # 105508 <_DYNAMIC+0x2a0>
   78666:	lea    -0x686cd(%rip),%rdi        # ffa0 <anon.396a22046db73490f85649c540301092.0.llvm.5713125445139818657+0x9eb>
   7866d:	lea    0x89844(%rip),%rdx        # 101eb8 <__frame_dummy_init_array_entry+0x5f8>
   78674:	mov    $0x20,%esi
   78679:	call   *0x8ce89(%rip)        # 105508 <_DYNAMIC+0x2a0>
   7867f:	lea    -0x6801c(%rip),%rdi        # 1066a <anon.590c1ca00e458323ccaf1fde3a917a11.1522.llvm.18282150582867169823+0x6aa>
   78686:	lea    0x89843(%rip),%rdx        # 101ed0 <__frame_dummy_init_array_entry+0x610>
   7868d:	mov    $0x23,%esi
   78692:	call   *0x8ce70(%rip)        # 105508 <_DYNAMIC+0x2a0>
   78698:	lea    0x898f1(%rip),%rcx        # 101f90 <__frame_dummy_init_array_entry+0x6d0>
   7869f:	mov    %r9,%rdi
   786a2:	mov    %rax,%rsi
   786a5:	vzeroupper
   786a8:	call   *0x8ce32(%rip)        # 1054e0 <_DYNAMIC+0x278>
   786ae:	lea    0xd8(%rsp),%rax
   786b6:	mov    %rsi,%rdi
   786b9:	mov    %rdx,%rsi
   786bc:	mov    %rax,%rdx
   786bf:	call   a9f90 <core::slice::sort::stable::driftsort_main::<u32, <[u32]>::sort_by_key<u32, block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body<u32, u32>::{closure#0}>::{closure#0}, alloc::vec::Vec<u32>>>
   786c4:	jmp    77aae <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x3e>
   786c9:	lea    0x89890(%rip),%rdi        # 101f60 <__frame_dummy_init_array_entry+0x6a0>
   786d0:	call   *0x8ce2a(%rip)        # 105500 <_DYNAMIC+0x298>
   786d6:	lea    0x8989b(%rip),%rcx        # 101f78 <__frame_dummy_init_array_entry+0x6b8>
   786dd:	mov    %r8,%rdi
   786e0:	mov    %rdx,%rsi
   786e3:	vzeroupper
   786e6:	call   *0x8cdf4(%rip)        # 1054e0 <_DYNAMIC+0x278>
   786ec:	lea    0x897f5(%rip),%rdi        # 101ee8 <__frame_dummy_init_array_entry+0x628>
   786f3:	call   *0x8ce3f(%rip)        # 105538 <_DYNAMIC+0x2d0>
   786f9:	mov    $0x4,%edi
   786fe:	mov    %r12,%rsi
   78701:	call   *0x8ce19(%rip)        # 105520 <_DYNAMIC+0x2b8>
   78707:	mov    0x20(%rsp),%r9
   7870c:	mov    $0x8,%edi
   78711:	jmp    782c0 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x850>
   78716:	mov    $0x8,%edi
   7871b:	mov    %r14,%rsi
   7871e:	call   *0x8cdfc(%rip)        # 105520 <_DYNAMIC+0x2b8>
   78724:	jmp    7873e <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0xcce>
   78726:	mov    %rax,%r15
   78729:	jmp    79a73 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x2003>
   7872e:	mov    %rax,%r15
   78731:	test   %rbx,%rbx
   78734:	jne    78740 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0xcd0>
   78736:	mov    %r15,%rdi
   78739:	call   100870 <_Unwind_Resume@plt>
   7873e:	ud2
   78740:	movzbl 0x8f171(%rip),%eax        # 1078b8 <scan_experiment::TRACK>
   78747:	test   %al,%al
   78749:	je     78757 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0xce7>
   7874b:	shl    $0x2,%rbx
   7874f:	lock sub %rbx,0x8f151(%rip)        # 1078a8 <scan_experiment::LIVE>
   78757:	mov    0x30(%rsp),%rdi
   7875c:	call   *0x8cdb6(%rip)        # 105518 <free@GLIBC_2.2.5>
   78762:	mov    %r15,%rdi
   78765:	call   100870 <_Unwind_Resume@plt>
   7876a:	mov    %rax,(%rbx,%rax,8)
   7876e:	inc    %rax
   78771:	cmp    %rax,%rbp
   78774:	jne    7876a <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0xcfa>
   78776:	mov    %r14,0x78(%rsp)
   7877b:	vzeroupper
   7877e:	call   *0x8cda4(%rip)        # 105528 <_DYNAMIC+0x2c0>
   78784:	mov    %r12,%rdi
   78787:	call   *0x8cda3(%rip)        # 105530 <malloc@GLIBC_2.2.5>
   7878d:	test   %rax,%rax
   78790:	je     799d8 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1f68>
   78796:	movzbl 0x8f11b(%rip),%ecx        # 1078b8 <scan_experiment::TRACK>
   7879d:	mov    %rax,%r14
   787a0:	test   %cl,%cl
   787a2:	je     787cf <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0xd5f>
   787a4:	mov    %r12,%rcx
   787a7:	lock xadd %rcx,0x8f0f8(%rip)        # 1078a8 <scan_experiment::LIVE>
   787b0:	mov    0x8f0f9(%rip),%rax        # 1078b0 <scan_experiment::PEAK>
   787b7:	add    %r12,%rcx
   787ba:	cmp    %rcx,%rax
   787bd:	mov    %rcx,%rdx
   787c0:	cmova  %rax,%rdx
   787c4:	lock cmpxchg %rdx,0x8f0e3(%rip)        # 1078b0 <scan_experiment::PEAK>
   787cd:	jne    787ba <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0xd4a>
   787cf:	mov    %r14,%rdi
   787d2:	xor    %esi,%esi
   787d4:	mov    %r12,%rdx
   787d7:	call   *0x8cd63(%rip)        # 105540 <memset@GLIBC_2.2.5>
   787dd:	mov    0x18(%rsp),%rcx
   787e2:	mov    0x50(%rsp),%rax
   787e7:	mov    0x30(%rsp),%rdx
   787ec:	mov    0x10(%rsp),%r8
   787f1:	mov    0x88(%rsp),%r9
   787f9:	vpxor  %xmm0,%xmm0,%xmm0
   787fd:	mov    %rcx,0x138(%rsp)
   78805:	mov    %rax,0xd8(%rsp)
   7880d:	mov    %rdx,0xe0(%rsp)
   78815:	mov    0x40(%rsp),%rdx
   7881a:	mov    0x28(%rsp),%rax
   7881f:	mov    %rdx,0xe8(%rsp)
   78827:	mov    %rbp,0x140(%rsp)
   7882f:	mov    %rax,0x148(%rsp)
   78837:	mov    %r12,0xf0(%rsp)
   7883f:	mov    %r13,0xf8(%rsp)
   78847:	mov    %r12,0x100(%rsp)
   7884f:	mov    %rbp,0x108(%rsp)
   78857:	mov    %rbx,0x110(%rsp)
   7885f:	mov    %rbp,0x118(%rsp)
   78867:	mov    %r12,0x120(%rsp)
   7886f:	mov    %r14,0x128(%rsp)
   78877:	mov    $0xffffffffffffffff,%rbx
   7887e:	mov    $0xffffffffffffffff,%r14
   78885:	mov    %r12,0x130(%rsp)
   7888d:	vmovdqu %ymm0,0x150(%rsp)
   78896:	vmovdqu %ymm0,0x168(%rsp)
   7889f:	mov    %rdx,0x188(%rsp)
   788a7:	cmp    %r8,%rax
   788aa:	ja     7892b <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0xebb>
   788ac:	mov    0x128(%rsp),%rdx
   788b4:	movb   $0x1,(%rdx,%rbp,1)
   788b8:	cmp    $0x2,%r15
   788bc:	jb     78928 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0xeb8>
   788be:	lea    0x1(%rbp),%rsi
   788c2:	lea    0x8967f(%rip),%rdx        # 101f48 <__frame_dummy_init_array_entry+0x688>
   788c9:	lea    0x89660(%rip),%rdi        # 101f30 <__frame_dummy_init_array_entry+0x670>
   788d0:	mov    %r15,%r13
   788d3:	mov    %rbp,%r15
   788d6:	mov    %rsi,%r10
   788d9:	mov    0x100(%rsp),%rsi
   788e1:	cmp    %rsi,%r15
   788e4:	jae    79951 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1ee1>
   788ea:	mov    0xf8(%rsp),%rsi
   788f2:	mov    %r10,(%rsi,%r15,8)
   788f6:	mov    0x130(%rsp),%rsi
   788fe:	cmp    %rsi,%r10
   78901:	jae    7994b <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1edb>
   78907:	mov    0x128(%rsp),%r11
   7890f:	lea    0x1(%r10),%rsi
   78913:	mov    %r10,%r15
   78916:	movb   $0x1,(%r11,%r10,1)
   7891b:	cmp    %r12,%rsi
   7891e:	jb     788d6 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0xe66>
   78920:	mov    %rbp,%r14
   78923:	mov    %r13,%r15
   78926:	jmp    7892b <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0xebb>
   78928:	mov    %rbp,%r14
   7892b:	mov    0x48(%rsp),%rbp
   78930:	mov    %r15,%r10
   78933:	lea    -0x1(%r12),%r15
   78938:	cmp    %r8,%rax
   7893b:	cmovbe %r15,%rbx
   7893f:	test   %rbp,%rbp
   78942:	je     78a42 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0xfd2>
   78948:	mov    0x118(%rsp),%rdi
   78950:	test   %rdi,%rdi
   78953:	je     798f1 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1e81>
   78959:	lea    -0x1(%rdi),%rdx
   7895d:	mov    %rdx,0x118(%rsp)
   78965:	mov    0x110(%rsp),%r8
   7896d:	mov    0x130(%rsp),%rsi
   78975:	mov    -0x8(%r8,%rdi,8),%rbx
   7897a:	cmp    %rsi,%rbx
   7897d:	jae    79a00 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1f90>
   78983:	mov    0x128(%rsp),%rdi
   7898b:	cmpb   $0x1,(%rdi,%rbx,1)
   7898f:	je     79912 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1ea2>
   78995:	movb   $0x1,(%rdi,%rbx,1)
   78999:	mov    0x100(%rsp),%rdi
   789a1:	cmp    %rdi,%rbx
   789a4:	jae    79a09 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1f99>
   789aa:	mov    0xf8(%rsp),%rdi
   789b2:	sub    %rdx,%rsi
   789b5:	lea    0xe0(%rsp),%rdx
   789bd:	mov    %rax,%r13
   789c0:	movq   $0xffffffffffffffff,(%rdi,%rbx,8)
   789c8:	mov    0x180(%rsp),%r8
   789d0:	mov    0x140(%rsp),%rdi
   789d8:	cmp    %r8,%rsi
   789db:	cmovbe %r8,%rsi
   789df:	imul   %rax,%r10
   789e3:	lea    0x138(%rsp),%r8
   789eb:	mov    %rsi,0x180(%rsp)
   789f3:	lea    (%rcx,%r10,4),%rsi
   789f7:	xor    %ecx,%ecx
   789f9:	cmp    %rdi,%rbx
   789fc:	cmovae %rdi,%rcx
   78a00:	cmovb  %rdx,%r8
   78a04:	mov    %rbx,%rdi
   78a07:	lea    0x0(,%rbp,4),%rdx
   78a0f:	sub    %rcx,%rdi
   78a12:	imul   0x148(%rsp),%rdi
   78a1b:	shl    $0x2,%rdi
   78a1f:	add    (%r8),%rdi
   78a22:	vzeroupper
   78a25:	call   *0x8caa5(%rip)        # 1054d0 <memcpy@GLIBC_2.14>
   78a2b:	mov    0x10(%rsp),%r8
   78a30:	cmp    %r8,%r13
   78a33:	jbe    78a47 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0xfd7>
   78a35:	mov    0x88(%rsp),%r9
   78a3d:	mov    %rbx,%r14
   78a40:	jmp    78a6d <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0xffd>
   78a42:	mov    %rax,%rbp
   78a45:	jmp    78a6d <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0xffd>
   78a47:	mov    0x100(%rsp),%rsi
   78a4f:	mov    0x88(%rsp),%r9
   78a57:	cmp    %rsi,%r15
   78a5a:	jae    79a43 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1fd3>
   78a60:	mov    0xf8(%rsp),%rax
   78a68:	mov    %rbx,-0x8(%rax,%r12,8)
   78a6d:	vmovdqa -0x68b35(%rip),%ymm0        # ff40 <anon.396a22046db73490f85649c540301092.0.llvm.5713125445139818657+0x98b>
   78a75:	mov    %r14,0x1c8(%rsp)
   78a7d:	mov    %rbx,0x1d0(%rsp)
   78a85:	movq   $0x0,0x1d8(%rsp)
   78a91:	mov    %rbp,0x1e0(%rsp)
   78a99:	mov    %r8,0x1e8(%rsp)
   78aa1:	vmovdqu %ymm0,0x1f0(%rsp)
   78aaa:	movq   $0x0,0x210(%rsp)
   78ab6:	mov    %r8,%rdx
   78ab9:	mov    0x68(%rsp),%r8
   78abe:	lea    0x1f0(%rsp),%rax
   78ac6:	lea    0xd8(%rsp),%rdi
   78ace:	lea    0x1c8(%rsp),%rsi
   78ad6:	mov    $0x20,%ecx
   78adb:	mov    %rax,(%rsp)
   78adf:	vzeroupper
   78ae2:	call   81d60 <block_msd_research::count_first_full_scan::recurse::<u32, u32>>
   78ae7:	cmpq   $0x0,0x1e8(%rsp)
   78af0:	jne    798a3 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1e33>
   78af6:	vmovdqu 0x1f0(%rsp),%ymm0
   78aff:	mov    0x210(%rsp),%rcx
   78b07:	mov    0x10(%rsp),%rax
   78b0c:	mov    %rcx,0x1c0(%rsp)
   78b14:	mov    %rax,0x198(%rsp)
   78b1c:	vmovdqu %ymm0,0x1a0(%rsp)
   78b25:	cmp    %rax,%rcx
   78b28:	jne    798c8 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1e58>
   78b2e:	mov    0x148(%rsp),%rsi
   78b36:	test   %rsi,%rsi
   78b39:	je     799eb <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1f7b>
   78b3f:	mov    %rax,%rcx
   78b42:	or     %rsi,%rcx
   78b45:	mov    %rsi,0x30(%rsp)
   78b4a:	shr    $0x20,%rcx
   78b4e:	je     78b5a <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x10ea>
   78b50:	xor    %edx,%edx
   78b52:	div    %rsi
   78b55:	mov    %rdx,%r15
   78b58:	jmp    78b61 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x10f1>
   78b5a:	xor    %edx,%edx
   78b5c:	div    %esi
   78b5e:	mov    %edx,%r15d
   78b61:	mov    0x100(%rsp),%r12
   78b69:	mov    %rax,0x20(%rsp)
   78b6e:	test   %r12,%r12
   78b71:	je     78c15 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x11a5>
   78b77:	lea    0x0(,%r12,8),%r14
   78b7f:	vzeroupper
   78b82:	call   *0x8c9a0(%rip)        # 105528 <_DYNAMIC+0x2c0>
   78b88:	mov    %r14,%rdi
   78b8b:	call   *0x8c99f(%rip)        # 105530 <malloc@GLIBC_2.2.5>
   78b91:	test   %rax,%rax
   78b94:	je     79a24 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1fb4>
   78b9a:	movzbl 0x8ed17(%rip),%ecx        # 1078b8 <scan_experiment::TRACK>
   78ba1:	mov    %rax,%r10
   78ba4:	test   %cl,%cl
   78ba6:	je     78bd3 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1163>
   78ba8:	mov    %r14,%rcx
   78bab:	lock xadd %rcx,0x8ecf4(%rip)        # 1078a8 <scan_experiment::LIVE>
   78bb4:	mov    0x8ecf5(%rip),%rax        # 1078b0 <scan_experiment::PEAK>
   78bbb:	add    %r14,%rcx
   78bbe:	cmp    %rcx,%rax
   78bc1:	mov    %rcx,%rdx
   78bc4:	cmova  %rax,%rdx
   78bc8:	lock cmpxchg %rdx,0x8ecdf(%rip)        # 1078b0 <scan_experiment::PEAK>
   78bd1:	jne    78bbe <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x114e>
   78bd3:	mov    $0x1,%r8d
   78bd9:	mov    %r10,%rax
   78bdc:	cmp    $0x1,%r12
   78be0:	je     78c02 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1192>
   78be2:	lea    -0x8(%r14),%rdx
   78be6:	mov    $0xff,%esi
   78beb:	mov    %r10,%rdi
   78bee:	mov    %r10,%rbx
   78bf1:	call   *0x8c949(%rip)        # 105540 <memset@GLIBC_2.2.5>
   78bf7:	lea    -0x8(%rbx,%r14,1),%rax
   78bfc:	mov    %rbx,%r10
   78bff:	mov    %r12,%r8
   78c02:	movq   $0xffffffffffffffff,(%rax)
   78c09:	mov    0x10(%rsp),%rdi
   78c0e:	mov    0x20(%rsp),%rax
   78c13:	jmp    78c26 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x11b6>
   78c15:	mov    0x10(%rsp),%rdi
   78c1a:	mov    $0x8,%r10d
   78c20:	xor    %r8d,%r8d
   78c23:	xor    %r12d,%r12d
   78c26:	mov    0x1a8(%rsp),%r9
   78c2e:	mov    0x1b0(%rsp),%rdx
   78c36:	mov    %r10,0x80(%rsp)
   78c3e:	mov    %r8,0x98(%rsp)
   78c46:	mov    %rdx,0x28(%rsp)
   78c4b:	mov    %r9,0x18(%rsp)
   78c50:	test   %rdx,%rdx
   78c53:	je     78c85 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1215>
   78c55:	mov    0x28(%rsp),%rcx
   78c5a:	lea    0x89587(%rip),%rbx        # 1021e8 <__frame_dummy_init_array_entry+0x928>
   78c61:	xor    %edx,%edx
   78c63:	lea    0x0(,%rcx,8),%rcx
   78c6b:	mov    (%r9,%rdx,8),%rsi
   78c6f:	cmp    %r12,%rsi
   78c72:	jae    79933 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1ec3>
   78c78:	mov    %rdx,(%r10,%rsi,8)
   78c7c:	inc    %rdx
   78c7f:	add    $0xfffffffffffffff8,%rcx
   78c83:	jne    78c6b <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x11fb>
   78c85:	mov    0x28(%rsp),%r8
   78c8a:	mov    %r12,0x40(%rsp)
   78c8f:	mov    %r15,0x190(%rsp)
   78c97:	cmp    %rdi,0x30(%rsp)
   78c9c:	jbe    78cfc <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x128c>
   78c9e:	mov    0x190(%rsp),%rdx
   78ca6:	mov    0x38(%rsp),%r13
   78cab:	mov    0x98(%rsp),%rbx
   78cb3:	test   %rdx,%rdx
   78cb6:	je     7973a <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1cca>
   78cbc:	cmp    %r8,%rax
   78cbf:	jae    79a37 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1fc7>
   78cc5:	mov    (%r9,%rax,8),%rsi
   78cc9:	mov    %rsi,%rcx
   78ccc:	sub    0x140(%rsp),%rcx
   78cd4:	jae    796fe <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1c8e>
   78cda:	mov    0x30(%rsp),%rdi
   78cdf:	mov    0x138(%rsp),%r8
   78ce7:	imul   %rdi,%rsi
   78ceb:	shl    $0x2,%rsi
   78cef:	add    0xe0(%rsp),%rsi
   78cf7:	jmp    79713 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1ca3>
   78cfc:	mov    0x30(%rsp),%rdi
   78d01:	mov    0x140(%rsp),%r11
   78d09:	mov    0x138(%rsp),%r14
   78d11:	mov    0xe0(%rsp),%rbx
   78d19:	lea    0x0(,%rdi,4),%rcx
   78d21:	mov    %r11,%rsi
   78d24:	imul   %rdi,%rsi
   78d28:	cmp    $0x1,%rax
   78d2c:	mov    %rdi,%rdx
   78d2f:	lea    0x40(%rbx),%r13
   78d33:	lea    0x1c(%r14),%r12
   78d37:	mov    %rbx,0x78(%rsp)
   78d3c:	mov    %r14,0x68(%rsp)
   78d41:	mov    %r13,0xa0(%rsp)
   78d49:	mov    %r12,0xc8(%rsp)
   78d51:	lea    0x1c(%rbx),%r12
   78d55:	mov    %rcx,0x10(%rsp)
   78d5a:	mov    %rax,%rcx
   78d5d:	adc    $0x0,%rcx
   78d61:	mov    %r12,0xc0(%rsp)
   78d69:	imul   %rcx,%rdx
   78d6d:	add    %r11,%rcx
   78d70:	lea    (%rbx,%rsi,4),%r15
   78d74:	lea    0x40(%rbx,%rsi,4),%r13
   78d79:	lea    0x893f0(%rip),%rsi        # 102170 <__frame_dummy_init_array_entry+0x8b0>
   78d80:	imul   %rdi,%rcx
   78d84:	mov    %rsi,0x60(%rsp)
   78d89:	mov    %r15,0xd0(%rsp)
   78d91:	lea    (%r14,%rdx,4),%rdx
   78d95:	lea    (%rbx,%rcx,4),%rcx
   78d99:	mov    %r15,%rbx
   78d9c:	mov    %rdx,0xb8(%rsp)
   78da4:	mov    %rdi,%rdx
   78da7:	and    $0xffffffffffffffe0,%rdx
   78dab:	mov    %rdx,0x58(%rsp)
   78db0:	mov    %rdi,%rdx
   78db3:	and    $0xfffffffffffffffc,%rdx
   78db7:	mov    %r11,%rdi
   78dba:	mov    %rcx,0xb0(%rsp)
   78dc2:	xor    %r11d,%r11d
   78dc5:	mov    %rdi,0x50(%rsp)
   78dca:	mov    %rdx,0x90(%rsp)
   78dd2:	lea    0x40(%r14),%rdx
   78dd6:	mov    %rdx,%r15
   78dd9:	mov    %rdx,0xa8(%rsp)
   78de1:	jmp    78eb4 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1444>
   78de6:	mov    0x68(%rsp),%r9
   78deb:	cmp    %rdi,%rsi
   78dee:	mov    $0x0,%eax
   78df3:	mov    0x78(%rsp),%r8
   78df8:	mov    %rsi,%rdx
   78dfb:	mov    %r15,%rbp
   78dfe:	mov    %r13,%r15
   78e01:	mov    %r12,%r13
   78e04:	cmovae %rdi,%rax
   78e08:	mov    0x30(%rsp),%rdi
   78e0d:	mov    %r9,%rcx
   78e10:	cmovb  %r8,%rcx
   78e14:	sub    %rax,%rdx
   78e17:	mov    %r12,%rax
   78e1a:	imul   %rdi,%rdx
   78e1e:	imul   %rdi,%rax
   78e22:	lea    (%rcx,%rdx,4),%rsi
   78e26:	mov    %r11,%rcx
   78e29:	imul   %rdi,%rcx
   78e2d:	cmp    0x50(%rsp),%r12
   78e32:	mov    0x10(%rsp),%rdx
   78e37:	lea    (%r8,%rax,4),%rax
   78e3b:	mov    %r11,%r12
   78e3e:	lea    (%r9,%rcx,4),%rdi
   78e42:	cmovb  %rax,%rdi
   78e46:	vzeroupper
   78e49:	call   *0x8c681(%rip)        # 1054d0 <memcpy@GLIBC_2.14>
   78e4f:	mov    %r12,%r11
   78e52:	mov    0x48(%rsp),%r12
   78e57:	mov    0x50(%rsp),%rdi
   78e5c:	mov    0x28(%rsp),%r8
   78e61:	mov    0x20(%rsp),%rax
   78e66:	mov    0x18(%rsp),%r9
   78e6b:	mov    0x80(%rsp),%r10
   78e73:	mov    $0xffffffffffffffff,%rcx
   78e7a:	cmp    0x40(%rsp),%r12
   78e7f:	jae    7997a <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1f0a>
   78e85:	mov    %rcx,(%r10,%r12,8)
   78e89:	mov    %r13,(%r9,%r11,8)
   78e8d:	mov    %r11,(%r10,%r13,8)
   78e91:	mov    %r15,%r13
   78e94:	mov    %rbp,%r15
   78e97:	mov    0x10(%rsp),%rcx
   78e9c:	inc    %r11
   78e9f:	add    %rcx,%r15
   78ea2:	add    %rcx,%r14
   78ea5:	add    %rcx,%r13
   78ea8:	add    %rcx,%rbx
   78eab:	cmp    %rax,%r11
   78eae:	jae    78c9e <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x122e>
   78eb4:	cmp    %r8,%r11
   78eb7:	je     79944 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1ed4>
   78ebd:	mov    (%r9,%r11,8),%rsi
   78ec1:	lea    (%r11,%rdi,1),%r12
   78ec5:	cmp    %r12,%rsi
   78ec8:	je     78e97 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1427>
   78eca:	cmp    0x40(%rsp),%r12
   78ecf:	jae    79962 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1ef2>
   78ed5:	mov    (%r10,%r12,8),%rax
   78ed9:	mov    %rsi,0x48(%rsp)
   78ede:	cmp    $0xffffffffffffffff,%rax
   78ee2:	mov    %rax,0x88(%rsp)
   78eea:	sete   %cl
   78eed:	cmp    %r11,%rax
   78ef0:	setbe  %dl
   78ef3:	or     %cl,%dl
   78ef5:	jne    78de6 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1376>
   78efb:	mov    0x30(%rsp),%rax
   78f00:	mov    0x68(%rsp),%r8
   78f05:	mov    %rsi,%rcx
   78f08:	sub    %rdi,%rcx
   78f0b:	mov    %r11,%rbp
   78f0e:	mov    %rsi,%r11
   78f11:	mov    %rcx,%rdx
   78f14:	imul   %rax,%rdx
   78f18:	imul   %rax,%rsi
   78f1c:	lea    (%r8,%rdx,4),%rdx
   78f20:	mov    0x78(%rsp),%r8
   78f25:	lea    (%r8,%rsi,4),%rsi
   78f29:	mov    %rdi,%r8
   78f2c:	cmp    %rdi,%r12
   78f2f:	mov    %r11,%rdi
   78f32:	jae    79059 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x15e9>
   78f38:	sub    %r8,%rdi
   78f3b:	jae    79187 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1717>
   78f41:	mov    %rbp,%r11
   78f44:	cmp    $0x4,%rax
   78f48:	jb     78f7c <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x150c>
   78f4a:	mov    0x48(%rsp),%rcx
   78f4f:	lea    0x4(,%rcx,4),%rcx
   78f57:	imul   %rax,%rcx
   78f5b:	add    0x78(%rsp),%rcx
   78f60:	cmp    %rcx,0xd0(%rsp)
   78f68:	jae    79402 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1992>
   78f6e:	cmp    0xb0(%rsp),%rsi
   78f76:	jae    79402 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1992>
   78f7c:	xor    %edx,%edx
   78f7e:	mov    %eax,%edi
   78f80:	sub    %edx,%edi
   78f82:	mov    %rdx,%rcx
   78f85:	and    $0x7,%edi
   78f88:	je     78fa6 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1536>
   78f8a:	mov    %rdx,%rcx
   78f8d:	mov    (%rbx,%rcx,4),%r8d
   78f91:	mov    (%rsi,%rcx,4),%r9d
   78f95:	dec    %rdi
   78f98:	mov    %r9d,(%rbx,%rcx,4)
   78f9c:	mov    %r8d,(%rsi,%rcx,4)
   78fa0:	lea    0x1(%rcx),%rcx
   78fa4:	jne    78f8d <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x151d>
   78fa6:	mov    0x18(%rsp),%r9
   78fab:	sub    %rax,%rdx
   78fae:	cmp    $0xfffffffffffffff8,%rdx
   78fb2:	ja     793c0 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1950>
   78fb8:	mov    0x10(%rsp),%rdx
   78fbd:	imul   0x48(%rsp),%rdx
   78fc3:	add    0xc0(%rsp),%rdx
   78fcb:	mov    (%rbx,%rcx,4),%esi
   78fce:	mov    -0x1c(%rdx,%rcx,4),%edi
   78fd2:	mov    %edi,(%rbx,%rcx,4)
   78fd5:	mov    %esi,-0x1c(%rdx,%rcx,4)
   78fd9:	mov    0x4(%rbx,%rcx,4),%esi
   78fdd:	mov    -0x18(%rdx,%rcx,4),%edi
   78fe1:	mov    %edi,0x4(%rbx,%rcx,4)
   78fe5:	mov    %esi,-0x18(%rdx,%rcx,4)
   78fe9:	mov    0x8(%rbx,%rcx,4),%esi
   78fed:	mov    -0x14(%rdx,%rcx,4),%edi
   78ff1:	mov    %edi,0x8(%rbx,%rcx,4)
   78ff5:	mov    %esi,-0x14(%rdx,%rcx,4)
   78ff9:	mov    0xc(%rbx,%rcx,4),%esi
   78ffd:	mov    -0x10(%rdx,%rcx,4),%edi
   79001:	mov    %edi,0xc(%rbx,%rcx,4)
   79005:	mov    %esi,-0x10(%rdx,%rcx,4)
   79009:	mov    0x10(%rbx,%rcx,4),%esi
   7900d:	mov    -0xc(%rdx,%rcx,4),%edi
   79011:	mov    %edi,0x10(%rbx,%rcx,4)
   79015:	mov    %esi,-0xc(%rdx,%rcx,4)
   79019:	mov    0x14(%rbx,%rcx,4),%esi
   7901d:	mov    -0x8(%rdx,%rcx,4),%edi
   79021:	mov    %edi,0x14(%rbx,%rcx,4)
   79025:	mov    %esi,-0x8(%rdx,%rcx,4)
   79029:	mov    0x18(%rbx,%rcx,4),%esi
   7902d:	mov    -0x4(%rdx,%rcx,4),%edi
   79031:	mov    %edi,0x18(%rbx,%rcx,4)
   79035:	mov    %esi,-0x4(%rdx,%rcx,4)
   79039:	mov    0x1c(%rbx,%rcx,4),%esi
   7903d:	mov    (%rdx,%rcx,4),%edi
   79040:	mov    %edi,0x1c(%rbx,%rcx,4)
   79044:	mov    %esi,(%rdx,%rcx,4)
   79047:	add    $0x8,%rcx
   7904b:	cmp    %rcx,%rax
   7904e:	jne    78fcb <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x155b>
   79054:	jmp    793c0 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1950>
   79059:	sub    %r8,%rdi
   7905c:	jae    7929f <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x182f>
   79062:	mov    %rbp,%r11
   79065:	cmp    $0x4,%rax
   79069:	jb     7909a <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x162a>
   7906b:	mov    0x48(%rsp),%rcx
   79070:	lea    0x4(,%rcx,4),%rcx
   79078:	imul   %rax,%rcx
   7907c:	add    0x78(%rsp),%rcx
   79081:	cmp    %rcx,0x68(%rsp)
   79086:	jae    7940f <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x199f>
   7908c:	cmp    0xb8(%rsp),%rsi
   79094:	jae    7940f <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x199f>
   7909a:	xor    %edx,%edx
   7909c:	mov    %eax,%edi
   7909e:	sub    %edx,%edi
   790a0:	mov    %rdx,%rcx
   790a3:	and    $0x7,%edi
   790a6:	je     790c4 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1654>
   790a8:	mov    %rdx,%rcx
   790ab:	mov    (%r14,%rcx,4),%r8d
   790af:	mov    (%rsi,%rcx,4),%r9d
   790b3:	dec    %rdi
   790b6:	mov    %r9d,(%r14,%rcx,4)
   790ba:	mov    %r8d,(%rsi,%rcx,4)
   790be:	lea    0x1(%rcx),%rcx
   790c2:	jne    790ab <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x163b>
   790c4:	mov    0x18(%rsp),%r9
   790c9:	sub    %rax,%rdx
   790cc:	cmp    $0xfffffffffffffff8,%rdx
   790d0:	ja     793c0 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1950>
   790d6:	mov    0x10(%rsp),%rdx
   790db:	imul   0x48(%rsp),%rdx
   790e1:	add    0xc0(%rsp),%rdx
   790e9:	mov    (%r14,%rcx,4),%esi
   790ed:	mov    -0x1c(%rdx,%rcx,4),%edi
   790f1:	mov    %edi,(%r14,%rcx,4)
   790f5:	mov    %esi,-0x1c(%rdx,%rcx,4)
   790f9:	mov    0x4(%r14,%rcx,4),%esi
   790fe:	mov    -0x18(%rdx,%rcx,4),%edi
   79102:	mov    %edi,0x4(%r14,%rcx,4)
   79107:	mov    %esi,-0x18(%rdx,%rcx,4)
   7910b:	mov    0x8(%r14,%rcx,4),%esi
   79110:	mov    -0x14(%rdx,%rcx,4),%edi
   79114:	mov    %edi,0x8(%r14,%rcx,4)
   79119:	mov    %esi,-0x14(%rdx,%rcx,4)
   7911d:	mov    0xc(%r14,%rcx,4),%esi
   79122:	mov    -0x10(%rdx,%rcx,4),%edi
   79126:	mov    %edi,0xc(%r14,%rcx,4)
   7912b:	mov    %esi,-0x10(%rdx,%rcx,4)
   7912f:	mov    0x10(%r14,%rcx,4),%esi
   79134:	mov    -0xc(%rdx,%rcx,4),%edi
   79138:	mov    %edi,0x10(%r14,%rcx,4)
   7913d:	mov    %esi,-0xc(%rdx,%rcx,4)
   79141:	mov    0x14(%r14,%rcx,4),%esi
   79146:	mov    -0x8(%rdx,%rcx,4),%edi
   7914a:	mov    %edi,0x14(%r14,%rcx,4)
   7914f:	mov    %esi,-0x8(%rdx,%rcx,4)
   79153:	mov    0x18(%r14,%rcx,4),%esi
   79158:	mov    -0x4(%rdx,%rcx,4),%edi
   7915c:	mov    %edi,0x18(%r14,%rcx,4)
   79161:	mov    %esi,-0x4(%rdx,%rcx,4)
   79165:	mov    0x1c(%r14,%rcx,4),%esi
   7916a:	mov    (%rdx,%rcx,4),%edi
   7916d:	mov    %edi,0x1c(%r14,%rcx,4)
   79172:	mov    %esi,(%rdx,%rcx,4)
   79175:	add    $0x8,%rcx
   79179:	cmp    %rcx,%rax
   7917c:	jne    790e9 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1679>
   79182:	jmp    793c0 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1950>
   79187:	mov    %rbp,%r11
   7918a:	cmp    $0x4,%rax
   7918e:	jb     791bd <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x174d>
   79190:	lea    0x4(,%rdi,4),%rsi
   79198:	imul   %rax,%rsi
   7919c:	add    0x68(%rsp),%rsi
   791a1:	cmp    %rsi,0xd0(%rsp)
   791a9:	jae    79420 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x19b0>
   791af:	cmp    0xb0(%rsp),%rdx
   791b7:	jae    79420 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x19b0>
   791bd:	xor    %r8d,%r8d
   791c0:	mov    %eax,%edi
   791c2:	sub    %r8d,%edi
   791c5:	mov    %r8,%rsi
   791c8:	and    $0x7,%edi
   791cb:	je     791e9 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1779>
   791cd:	mov    %r8,%rsi
   791d0:	mov    (%rbx,%rsi,4),%r9d
   791d4:	mov    (%rdx,%rsi,4),%r10d
   791d8:	dec    %rdi
   791db:	mov    %r10d,(%rbx,%rsi,4)
   791df:	mov    %r9d,(%rdx,%rsi,4)
   791e3:	lea    0x1(%rsi),%rsi
   791e7:	jne    791d0 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1760>
   791e9:	mov    0x80(%rsp),%r10
   791f1:	mov    0x18(%rsp),%r9
   791f6:	sub    %rax,%r8
   791f9:	cmp    $0xfffffffffffffff8,%r8
   791fd:	ja     793c0 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1950>
   79203:	imul   0x10(%rsp),%rcx
   79209:	add    0xc8(%rsp),%rcx
   79211:	mov    (%rbx,%rsi,4),%edx
   79214:	mov    -0x1c(%rcx,%rsi,4),%edi
   79218:	mov    %edi,(%rbx,%rsi,4)
   7921b:	mov    %edx,-0x1c(%rcx,%rsi,4)
   7921f:	mov    0x4(%rbx,%rsi,4),%edx
   79223:	mov    -0x18(%rcx,%rsi,4),%edi
   79227:	mov    %edi,0x4(%rbx,%rsi,4)
   7922b:	mov    %edx,-0x18(%rcx,%rsi,4)
   7922f:	mov    0x8(%rbx,%rsi,4),%edx
   79233:	mov    -0x14(%rcx,%rsi,4),%edi
   79237:	mov    %edi,0x8(%rbx,%rsi,4)
   7923b:	mov    %edx,-0x14(%rcx,%rsi,4)
   7923f:	mov    0xc(%rbx,%rsi,4),%edx
   79243:	mov    -0x10(%rcx,%rsi,4),%edi
   79247:	mov    %edi,0xc(%rbx,%rsi,4)
   7924b:	mov    %edx,-0x10(%rcx,%rsi,4)
   7924f:	mov    0x10(%rbx,%rsi,4),%edx
   79253:	mov    -0xc(%rcx,%rsi,4),%edi
   79257:	mov    %edi,0x10(%rbx,%rsi,4)
   7925b:	mov    %edx,-0xc(%rcx,%rsi,4)
   7925f:	mov    0x14(%rbx,%rsi,4),%edx
   79263:	mov    -0x8(%rcx,%rsi,4),%edi
   79267:	mov    %edi,0x14(%rbx,%rsi,4)
   7926b:	mov    %edx,-0x8(%rcx,%rsi,4)
   7926f:	mov    0x18(%rbx,%rsi,4),%edx
   79273:	mov    -0x4(%rcx,%rsi,4),%edi
   79277:	mov    %edi,0x18(%rbx,%rsi,4)
   7927b:	mov    %edx,-0x4(%rcx,%rsi,4)
   7927f:	mov    0x1c(%rbx,%rsi,4),%edx
   79283:	mov    (%rcx,%rsi,4),%edi
   79286:	mov    %edi,0x1c(%rbx,%rsi,4)
   7928a:	mov    %edx,(%rcx,%rsi,4)
   7928d:	add    $0x8,%rsi
   79291:	cmp    %rsi,%rax
   79294:	jne    79211 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x17a1>
   7929a:	jmp    793c0 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1950>
   7929f:	mov    %rbp,%r11
   792a2:	cmp    $0x4,%rax
   792a6:	jb     792d3 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1863>
   792a8:	lea    0x4(,%rdi,4),%rsi
   792b0:	mov    0x68(%rsp),%r8
   792b5:	imul   %rax,%rsi
   792b9:	add    %r8,%rsi
   792bc:	cmp    %rsi,%r8
   792bf:	jae    79431 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x19c1>
   792c5:	cmp    0xb8(%rsp),%rdx
   792cd:	jae    79431 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x19c1>
   792d3:	xor    %r8d,%r8d
   792d6:	mov    %eax,%edi
   792d8:	sub    %r8d,%edi
   792db:	mov    %r8,%rsi
   792de:	and    $0x7,%edi
   792e1:	je     792ff <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x188f>
   792e3:	mov    %r8,%rsi
   792e6:	mov    (%r14,%rsi,4),%r9d
   792ea:	mov    (%rdx,%rsi,4),%r10d
   792ee:	dec    %rdi
   792f1:	mov    %r10d,(%r14,%rsi,4)
   792f5:	mov    %r9d,(%rdx,%rsi,4)
   792f9:	lea    0x1(%rsi),%rsi
   792fd:	jne    792e6 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1876>
   792ff:	mov    0x80(%rsp),%r10
   79307:	mov    0x18(%rsp),%r9
   7930c:	sub    %rax,%r8
   7930f:	cmp    $0xfffffffffffffff8,%r8
   79313:	ja     793c0 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1950>
   79319:	imul   0x10(%rsp),%rcx
   7931f:	add    0xc8(%rsp),%rcx
   79327:	mov    (%r14,%rsi,4),%edx
   7932b:	mov    -0x1c(%rcx,%rsi,4),%edi
   7932f:	mov    %edi,(%r14,%rsi,4)
   79333:	mov    %edx,-0x1c(%rcx,%rsi,4)
   79337:	mov    0x4(%r14,%rsi,4),%edx
   7933c:	mov    -0x18(%rcx,%rsi,4),%edi
   79340:	mov    %edi,0x4(%r14,%rsi,4)
   79345:	mov    %edx,-0x18(%rcx,%rsi,4)
   79349:	mov    0x8(%r14,%rsi,4),%edx
   7934e:	mov    -0x14(%rcx,%rsi,4),%edi
   79352:	mov    %edi,0x8(%r14,%rsi,4)
   79357:	mov    %edx,-0x14(%rcx,%rsi,4)
   7935b:	mov    0xc(%r14,%rsi,4),%edx
   79360:	mov    -0x10(%rcx,%rsi,4),%edi
   79364:	mov    %edi,0xc(%r14,%rsi,4)
   79369:	mov    %edx,-0x10(%rcx,%rsi,4)
   7936d:	mov    0x10(%r14,%rsi,4),%edx
   79372:	mov    -0xc(%rcx,%rsi,4),%edi
   79376:	mov    %edi,0x10(%r14,%rsi,4)
   7937b:	mov    %edx,-0xc(%rcx,%rsi,4)
   7937f:	mov    0x14(%r14,%rsi,4),%edx
   79384:	mov    -0x8(%rcx,%rsi,4),%edi
   79388:	mov    %edi,0x14(%r14,%rsi,4)
   7938d:	mov    %edx,-0x8(%rcx,%rsi,4)
   79391:	mov    0x18(%r14,%rsi,4),%edx
   79396:	mov    -0x4(%rcx,%rsi,4),%edi
   7939a:	mov    %edi,0x18(%r14,%rsi,4)
   7939f:	mov    %edx,-0x4(%rcx,%rsi,4)
   793a3:	mov    0x1c(%r14,%rsi,4),%edx
   793a8:	mov    (%rcx,%rsi,4),%edi
   793ab:	mov    %edi,0x1c(%r14,%rsi,4)
   793b0:	mov    %edx,(%rcx,%rsi,4)
   793b3:	add    $0x8,%rsi
   793b7:	cmp    %rsi,%rax
   793ba:	jne    79327 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x18b7>
   793c0:	mov    0x28(%rsp),%r8
   793c5:	mov    0x88(%rsp),%rcx
   793cd:	cmp    %r8,%rcx
   793d0:	jae    79992 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1f22>
   793d6:	mov    %r15,%rbp
   793d9:	mov    %r13,%r15
   793dc:	mov    %r12,%r13
   793df:	mov    0x48(%rsp),%r12
   793e4:	mov    0x20(%rsp),%rax
   793e9:	mov    0x50(%rsp),%rdi
   793ee:	mov    %r12,(%r9,%rcx,8)
   793f2:	cmp    0x40(%rsp),%r12
   793f7:	jb     78e85 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1415>
   793fd:	jmp    799a0 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1f30>
   79402:	cmp    $0x20,%rax
   79406:	jae    79442 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x19d2>
   79408:	xor    %ecx,%ecx
   7940a:	jmp    794bc <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1a4c>
   7940f:	cmp    $0x20,%rax
   79413:	jae    794f2 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1a82>
   79419:	xor    %ecx,%ecx
   7941b:	jmp    7956a <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1afa>
   79420:	cmp    $0x20,%rax
   79424:	jae    795a2 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1b32>
   7942a:	xor    %esi,%esi
   7942c:	jmp    7961a <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1baa>
   79431:	cmp    $0x20,%rax
   79435:	jae    79650 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1be0>
   7943b:	xor    %esi,%esi
   7943d:	jmp    796c6 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1c56>
   79442:	mov    0x10(%rsp),%rcx
   79447:	mov    0x58(%rsp),%rdi
   7944c:	xor    %edx,%edx
   7944e:	imul   0x48(%rsp),%rcx
   79454:	add    0xa0(%rsp),%rcx
   7945c:	vmovdqu64 -0x40(%r13,%rdx,4),%zmm0
   79464:	vmovdqu64 0x0(%r13,%rdx,4),%zmm1
   7946c:	vmovdqu64 -0x40(%rcx,%rdx,4),%zmm2
   79474:	vmovdqu64 (%rcx,%rdx,4),%zmm3
   7947b:	vmovdqu64 %zmm2,-0x40(%r13,%rdx,4)
   79483:	vmovdqu64 %zmm3,0x0(%r13,%rdx,4)
   7948b:	vmovdqu64 %zmm0,-0x40(%rcx,%rdx,4)
   79493:	vmovdqu64 %zmm1,(%rcx,%rdx,4)
   7949a:	add    $0x20,%rdx
   7949e:	cmp    %rdx,%rdi
   794a1:	jne    7945c <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x19ec>
   794a3:	cmp    %rdi,%rax
   794a6:	je     793c0 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1950>
   794ac:	mov    0x58(%rsp),%rdx
   794b1:	mov    %rdx,%rcx
   794b4:	test   $0x1c,%al
   794b6:	je     78f7e <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x150e>
   794bc:	mov    0x90(%rsp),%rdi
   794c4:	vmovdqu (%rbx,%rcx,4),%xmm0
   794c9:	vmovdqu (%rsi,%rcx,4),%xmm1
   794ce:	vmovdqu %xmm1,(%rbx,%rcx,4)
   794d3:	vmovdqu %xmm0,(%rsi,%rcx,4)
   794d8:	add    $0x4,%rcx
   794dc:	cmp    %rcx,%rdi
   794df:	jne    794c4 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1a54>
   794e1:	mov    %rdi,%rdx
   794e4:	cmp    %rdi,%rax
   794e7:	je     793c0 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1950>
   794ed:	jmp    78f7e <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x150e>
   794f2:	mov    0x10(%rsp),%rcx
   794f7:	mov    0x58(%rsp),%rdi
   794fc:	xor    %edx,%edx
   794fe:	imul   0x48(%rsp),%rcx
   79504:	add    0xa0(%rsp),%rcx
   7950c:	vmovdqu64 -0x40(%r15,%rdx,4),%zmm0
   79514:	vmovdqu64 (%r15,%rdx,4),%zmm1
   7951b:	vmovdqu64 -0x40(%rcx,%rdx,4),%zmm2
   79523:	vmovdqu64 (%rcx,%rdx,4),%zmm3
   7952a:	vmovdqu64 %zmm2,-0x40(%r15,%rdx,4)
   79532:	vmovdqu64 %zmm3,(%r15,%rdx,4)
   79539:	vmovdqu64 %zmm0,-0x40(%rcx,%rdx,4)
   79541:	vmovdqu64 %zmm1,(%rcx,%rdx,4)
   79548:	add    $0x20,%rdx
   7954c:	cmp    %rdx,%rdi
   7954f:	jne    7950c <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1a9c>
   79551:	cmp    %rdi,%rax
   79554:	je     793c0 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1950>
   7955a:	mov    0x58(%rsp),%rdx
   7955f:	mov    %rdx,%rcx
   79562:	test   $0x1c,%al
   79564:	je     7909c <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x162c>
   7956a:	mov    0x90(%rsp),%rdi
   79572:	vmovdqu (%r14,%rcx,4),%xmm0
   79578:	vmovdqu (%rsi,%rcx,4),%xmm1
   7957d:	vmovdqu %xmm1,(%r14,%rcx,4)
   79583:	vmovdqu %xmm0,(%rsi,%rcx,4)
   79588:	add    $0x4,%rcx
   7958c:	cmp    %rcx,%rdi
   7958f:	jne    79572 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1b02>
   79591:	mov    %rdi,%rdx
   79594:	cmp    %rdi,%rax
   79597:	je     793c0 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1950>
   7959d:	jmp    7909c <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x162c>
   795a2:	mov    0x10(%rsp),%rsi
   795a7:	mov    0x58(%rsp),%r8
   795ac:	xor    %edi,%edi
   795ae:	imul   %rcx,%rsi
   795b2:	add    0xa8(%rsp),%rsi
   795ba:	vmovdqu64 -0x40(%r13,%rdi,4),%zmm0
   795c2:	vmovdqu64 0x0(%r13,%rdi,4),%zmm1
   795ca:	vmovdqu64 -0x40(%rsi,%rdi,4),%zmm2
   795d2:	vmovdqu64 (%rsi,%rdi,4),%zmm3
   795d9:	vmovdqu64 %zmm2,-0x40(%r13,%rdi,4)
   795e1:	vmovdqu64 %zmm3,0x0(%r13,%rdi,4)
   795e9:	vmovdqu64 %zmm0,-0x40(%rsi,%rdi,4)
   795f1:	vmovdqu64 %zmm1,(%rsi,%rdi,4)
   795f8:	add    $0x20,%rdi
   795fc:	cmp    %rdi,%r8
   795ff:	jne    795ba <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1b4a>
   79601:	cmp    %r8,%rax
   79604:	je     793c0 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1950>
   7960a:	mov    0x58(%rsp),%r8
   7960f:	mov    %r8,%rsi
   79612:	test   $0x1c,%al
   79614:	je     791c0 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1750>
   7961a:	mov    0x90(%rsp),%rdi
   79622:	vmovdqu (%rbx,%rsi,4),%xmm0
   79627:	vmovdqu (%rdx,%rsi,4),%xmm1
   7962c:	vmovdqu %xmm1,(%rbx,%rsi,4)
   79631:	vmovdqu %xmm0,(%rdx,%rsi,4)
   79636:	add    $0x4,%rsi
   7963a:	cmp    %rsi,%rdi
   7963d:	jne    79622 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1bb2>
   7963f:	mov    %rdi,%r8
   79642:	cmp    %rdi,%rax
   79645:	je     793c0 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1950>
   7964b:	jmp    791c0 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1750>
   79650:	mov    0x10(%rsp),%rsi
   79655:	mov    0x58(%rsp),%r8
   7965a:	xor    %edi,%edi
   7965c:	imul   %rcx,%rsi
   79660:	add    0xa8(%rsp),%rsi
   79668:	vmovdqu64 -0x40(%r15,%rdi,4),%zmm0
   79670:	vmovdqu64 (%r15,%rdi,4),%zmm1
   79677:	vmovdqu64 -0x40(%rsi,%rdi,4),%zmm2
   7967f:	vmovdqu64 (%rsi,%rdi,4),%zmm3
   79686:	vmovdqu64 %zmm2,-0x40(%r15,%rdi,4)
   7968e:	vmovdqu64 %zmm3,(%r15,%rdi,4)
   79695:	vmovdqu64 %zmm0,-0x40(%rsi,%rdi,4)
   7969d:	vmovdqu64 %zmm1,(%rsi,%rdi,4)
   796a4:	add    $0x20,%rdi
   796a8:	cmp    %rdi,%r8
   796ab:	jne    79668 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1bf8>
   796ad:	cmp    %r8,%rax
   796b0:	je     793c0 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1950>
   796b6:	mov    0x58(%rsp),%r8
   796bb:	mov    %r8,%rsi
   796be:	test   $0x1c,%al
   796c0:	je     792d6 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1866>
   796c6:	mov    0x90(%rsp),%rdi
   796ce:	vmovdqu (%r14,%rsi,4),%xmm0
   796d4:	vmovdqu (%rdx,%rsi,4),%xmm1
   796d9:	vmovdqu %xmm1,(%r14,%rsi,4)
   796df:	vmovdqu %xmm0,(%rdx,%rsi,4)
   796e4:	add    $0x4,%rsi
   796e8:	cmp    %rsi,%rdi
   796eb:	jne    796ce <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1c5e>
   796ed:	mov    %rdi,%r8
   796f0:	cmp    %rdi,%rax
   796f3:	je     793c0 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1950>
   796f9:	jmp    792d6 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1866>
   796fe:	mov    0x30(%rsp),%rdi
   79703:	mov    0x138(%rsp),%r8
   7970b:	imul   %rdi,%rcx
   7970f:	lea    (%r8,%rcx,4),%rsi
   79713:	imul   %rdi,%rax
   79717:	shl    $0x2,%rdx
   7971b:	lea    (%r8,%rax,4),%rdi
   7971f:	vzeroupper
   79722:	call   *0x8bdc8(%rip)        # 1054f0 <memmove@GLIBC_2.2.5>
   79728:	mov    0x38(%rsp),%r13
   7972d:	mov    0x80(%rsp),%r10
   79735:	mov    0x18(%rsp),%r9
   7973a:	test   %rbx,%rbx
   7973d:	je     7976c <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1cfc>
   7973f:	movzbl 0x8e172(%rip),%eax        # 1078b8 <scan_experiment::TRACK>
   79746:	test   %al,%al
   79748:	je     79756 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1ce6>
   7974a:	shl    $0x3,%rbx
   7974e:	lock sub %rbx,0x8e152(%rip)        # 1078a8 <scan_experiment::LIVE>
   79756:	mov    %r10,%rdi
   79759:	vzeroupper
   7975c:	call   *0x8bdb6(%rip)        # 105518 <free@GLIBC_2.2.5>
   79762:	mov    0x38(%rsp),%r13
   79767:	mov    0x18(%rsp),%r9
   7976c:	mov    0x1a0(%rsp),%rax
   79774:	lea    0x150(%rsp),%rbx
   7977c:	test   %rax,%rax
   7977f:	je     797a9 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1d39>
   79781:	movzbl 0x8e130(%rip),%ecx        # 1078b8 <scan_experiment::TRACK>
   79788:	test   %cl,%cl
   7978a:	je     79798 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1d28>
   7978c:	shl    $0x3,%rax
   79790:	lock sub %rax,0x8e110(%rip)        # 1078a8 <scan_experiment::LIVE>
   79798:	mov    %r9,%rdi
   7979b:	vzeroupper
   7979e:	call   *0x8bd74(%rip)        # 105518 <free@GLIBC_2.2.5>
   797a4:	mov    0x38(%rsp),%r13
   797a9:	vmovups (%rbx),%zmm0
   797af:	mov    0xd8(%rsp),%rax
   797b7:	vmovups %zmm0,0x0(%r13)
   797be:	test   %rax,%rax
   797c1:	je     797f0 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1d80>
   797c3:	mov    0xe0(%rsp),%rdi
   797cb:	movzbl 0x8e0e6(%rip),%ecx        # 1078b8 <scan_experiment::TRACK>
   797d2:	test   %cl,%cl
   797d4:	je     797e2 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1d72>
   797d6:	shl    $0x2,%rax
   797da:	lock sub %rax,0x8e0c6(%rip)        # 1078a8 <scan_experiment::LIVE>
   797e2:	vzeroupper
   797e5:	call   *0x8bd2d(%rip)        # 105518 <free@GLIBC_2.2.5>
   797eb:	mov    0x38(%rsp),%r13
   797f0:	mov    0xf0(%rsp),%rax
   797f8:	test   %rax,%rax
   797fb:	je     7982a <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1dba>
   797fd:	mov    0xf8(%rsp),%rdi
   79805:	movzbl 0x8e0ac(%rip),%ecx        # 1078b8 <scan_experiment::TRACK>
   7980c:	test   %cl,%cl
   7980e:	je     7981c <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1dac>
   79810:	shl    $0x3,%rax
   79814:	lock sub %rax,0x8e08c(%rip)        # 1078a8 <scan_experiment::LIVE>
   7981c:	vzeroupper
   7981f:	call   *0x8bcf3(%rip)        # 105518 <free@GLIBC_2.2.5>
   79825:	mov    0x38(%rsp),%r13
   7982a:	mov    0x108(%rsp),%rax
   79832:	test   %rax,%rax
   79835:	je     79864 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1df4>
   79837:	mov    0x110(%rsp),%rdi
   7983f:	movzbl 0x8e072(%rip),%ecx        # 1078b8 <scan_experiment::TRACK>
   79846:	test   %cl,%cl
   79848:	je     79856 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1de6>
   7984a:	shl    $0x3,%rax
   7984e:	lock sub %rax,0x8e052(%rip)        # 1078a8 <scan_experiment::LIVE>
   79856:	vzeroupper
   79859:	call   *0x8bcb9(%rip)        # 105518 <free@GLIBC_2.2.5>
   7985f:	mov    0x38(%rsp),%r13
   79864:	mov    0x120(%rsp),%rax
   7986c:	test   %rax,%rax
   7986f:	je     77ab9 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x49>
   79875:	mov    0x128(%rsp),%rdi
   7987d:	movzbl 0x8e034(%rip),%ecx        # 1078b8 <scan_experiment::TRACK>
   79884:	test   %cl,%cl
   79886:	je     79890 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1e20>
   79888:	lock sub %rax,0x8e018(%rip)        # 1078a8 <scan_experiment::LIVE>
   79890:	vzeroupper
   79893:	call   *0x8bc7f(%rip)        # 105518 <free@GLIBC_2.2.5>
   79899:	mov    0x38(%rsp),%r13
   7989e:	jmp    77ab9 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x49>
   798a3:	lea    0x1e8(%rsp),%rsi
   798ab:	lea    -0x699ea(%rip),%rdx        # fec8 <anon.396a22046db73490f85649c540301092.0.llvm.5713125445139818657+0x913>
   798b2:	lea    0x8865f(%rip),%r9        # 101f18 <__frame_dummy_init_array_entry+0x658>
   798b9:	xor    %edi,%edi
   798bb:	xor    %ecx,%ecx
   798bd:	call   *0x8bc85(%rip)        # 105548 <_DYNAMIC+0x2e0>
   798c3:	jmp    7873e <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0xcce>
   798c8:	lea    0x1c0(%rsp),%rsi
   798d0:	lea    0x88851(%rip),%r9        # 102128 <__frame_dummy_init_array_entry+0x868>
   798d7:	lea    0x198(%rsp),%rdx
   798df:	xor    %edi,%edi
   798e1:	xor    %ecx,%ecx
   798e3:	vzeroupper
   798e6:	call   *0x8bc5c(%rip)        # 105548 <_DYNAMIC+0x2e0>
   798ec:	jmp    7873e <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0xcce>
   798f1:	lea    -0x69202(%rip),%rdi        # 106f6 <anon.590c1ca00e458323ccaf1fde3a917a11.1522.llvm.18282150582867169823+0x736>
   798f8:	lea    0x88981(%rip),%rdx        # 102280 <__frame_dummy_init_array_entry+0x9c0>
   798ff:	mov    $0x22,%esi
   79904:	vzeroupper
   79907:	call   *0x8bc43(%rip)        # 105550 <_DYNAMIC+0x2e8>
   7990d:	jmp    7873e <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0xcce>
   79912:	lea    -0x699f9(%rip),%rdi        # ff20 <anon.396a22046db73490f85649c540301092.0.llvm.5713125445139818657+0x96b>
   79919:	lea    0x889a8(%rip),%rdx        # 1022c8 <__frame_dummy_init_array_entry+0xa08>
   79920:	mov    $0x20,%esi
   79925:	vzeroupper
   79928:	call   *0x8bbda(%rip)        # 105508 <_DYNAMIC+0x2a0>
   7992e:	jmp    7873e <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0xcce>
   79933:	mov    %rbx,0x60(%rsp)
   79938:	mov    %rsi,0x20(%rsp)
   7993d:	mov    %r12,0x28(%rsp)
   79942:	jmp    799bb <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1f4b>
   79944:	mov    %r8,0x20(%rsp)
   79949:	jmp    799bb <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1f4b>
   7994b:	mov    %r10,%r15
   7994e:	mov    %rdi,%rdx
   79951:	mov    %r15,%rdi
   79954:	vzeroupper
   79957:	call   *0x8bbb3(%rip)        # 105510 <_DYNAMIC+0x2a8>
   7995d:	jmp    7873e <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0xcce>
   79962:	mov    0x40(%rsp),%rax
   79967:	mov    %r12,0x20(%rsp)
   7996c:	mov    %rax,0x28(%rsp)
   79971:	lea    0x88810(%rip),%rax        # 102188 <__frame_dummy_init_array_entry+0x8c8>
   79978:	jmp    799b6 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1f46>
   7997a:	mov    0x40(%rsp),%rax
   7997f:	mov    %r12,0x20(%rsp)
   79984:	mov    %rax,0x28(%rsp)
   79989:	lea    0x88810(%rip),%rax        # 1021a0 <__frame_dummy_init_array_entry+0x8e0>
   79990:	jmp    799b6 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1f46>
   79992:	mov    %rcx,0x20(%rsp)
   79997:	lea    0x8881a(%rip),%rax        # 1021b8 <__frame_dummy_init_array_entry+0x8f8>
   7999e:	jmp    799b6 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1f46>
   799a0:	mov    0x40(%rsp),%rax
   799a5:	mov    %r12,0x20(%rsp)
   799aa:	mov    %rax,0x28(%rsp)
   799af:	lea    0x8881a(%rip),%rax        # 1021d0 <__frame_dummy_init_array_entry+0x910>
   799b6:	mov    %rax,0x60(%rsp)
   799bb:	mov    0x20(%rsp),%rdi
   799c0:	mov    0x28(%rsp),%rsi
   799c5:	mov    0x60(%rsp),%rdx
   799ca:	vzeroupper
   799cd:	call   *0x8bb3d(%rip)        # 105510 <_DYNAMIC+0x2a8>
   799d3:	jmp    7873e <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0xcce>
   799d8:	mov    $0x1,%edi
   799dd:	mov    %r12,%rsi
   799e0:	call   *0x8bb3a(%rip)        # 105520 <_DYNAMIC+0x2b8>
   799e6:	jmp    7873e <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0xcce>
   799eb:	lea    0x8874e(%rip),%rdi        # 102140 <__frame_dummy_init_array_entry+0x880>
   799f2:	vzeroupper
   799f5:	call   *0x8bb3d(%rip)        # 105538 <_DYNAMIC+0x2d0>
   799fb:	jmp    7873e <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0xcce>
   79a00:	lea    0x88891(%rip),%rdx        # 102298 <__frame_dummy_init_array_entry+0x9d8>
   79a07:	jmp    79a13 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1fa3>
   79a09:	lea    0x888a0(%rip),%rdx        # 1022b0 <__frame_dummy_init_array_entry+0x9f0>
   79a10:	mov    %rdi,%rsi
   79a13:	mov    %rbx,%rdi
   79a16:	vzeroupper
   79a19:	call   *0x8baf1(%rip)        # 105510 <_DYNAMIC+0x2a8>
   79a1f:	jmp    7873e <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0xcce>
   79a24:	mov    $0x8,%edi
   79a29:	mov    %r14,%rsi
   79a2c:	call   *0x8baee(%rip)        # 105520 <_DYNAMIC+0x2b8>
   79a32:	jmp    7873e <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0xcce>
   79a37:	lea    0x8871a(%rip),%rax        # 102158 <__frame_dummy_init_array_entry+0x898>
   79a3e:	jmp    799b6 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1f46>
   79a43:	lea    0x884b6(%rip),%rdx        # 101f00 <__frame_dummy_init_array_entry+0x640>
   79a4a:	jmp    79951 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1ee1>
   79a4f:	movzbl 0x8de62(%rip),%ecx        # 1078b8 <scan_experiment::TRACK>
   79a56:	mov    %rax,%r15
   79a59:	test   %cl,%cl
   79a5b:	je     79a6a <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x1ffa>
   79a5d:	mov    0x78(%rsp),%rax
   79a62:	lock sub %rax,0x8de3e(%rip)        # 1078a8 <scan_experiment::LIVE>
   79a6a:	mov    %rbx,%rdi
   79a6d:	call   *0x8baa5(%rip)        # 105518 <free@GLIBC_2.2.5>
   79a73:	movzbl 0x8de3e(%rip),%eax        # 1078b8 <scan_experiment::TRACK>
   79a7a:	test   %al,%al
   79a7c:	je     79a8b <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x201b>
   79a7e:	mov    0x20(%rsp),%rax
   79a83:	lock sub %rax,0x8de1d(%rip)        # 1078a8 <scan_experiment::LIVE>
   79a8b:	mov    %r13,%rdi
   79a8e:	call   *0x8ba84(%rip)        # 105518 <free@GLIBC_2.2.5>
   79a94:	mov    0x50(%rsp),%rbx
   79a99:	test   %rbx,%rbx
   79a9c:	je     78736 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0xcc6>
   79aa2:	jmp    78740 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0xcd0>
   79aa7:	cmpq   $0x0,0x98(%rsp)
   79ab0:	mov    %rax,%r15
   79ab3:	je     79b25 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x20b5>
   79ab5:	movzbl 0x8ddfc(%rip),%eax        # 1078b8 <scan_experiment::TRACK>
   79abc:	test   %al,%al
   79abe:	je     79ad4 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x2064>
   79ac0:	mov    0x98(%rsp),%rax
   79ac8:	shl    $0x3,%rax
   79acc:	lock sub %rax,0x8ddd4(%rip)        # 1078a8 <scan_experiment::LIVE>
   79ad4:	mov    0x80(%rsp),%rdi
   79adc:	call   *0x8ba36(%rip)        # 105518 <free@GLIBC_2.2.5>
   79ae2:	jmp    79b25 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x20b5>
   79ae4:	mov    %rax,%r15
   79ae7:	mov    0x1f0(%rsp),%rax
   79aef:	test   %rax,%rax
   79af2:	je     79b6c <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x20fc>
   79af4:	mov    0x1f8(%rsp),%rdi
   79afc:	movzbl 0x8ddb5(%rip),%ecx        # 1078b8 <scan_experiment::TRACK>
   79b03:	test   %cl,%cl
   79b05:	je     79b4e <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x20de>
   79b07:	shl    $0x3,%rax
   79b0b:	lock sub %rax,0x8dd95(%rip)        # 1078a8 <scan_experiment::LIVE>
   79b13:	jmp    79b4e <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x20de>
   79b15:	mov    0x1a8(%rsp),%rcx
   79b1d:	mov    %rax,%r15
   79b20:	mov    %rcx,0x18(%rsp)
   79b25:	mov    0x1a0(%rsp),%rax
   79b2d:	test   %rax,%rax
   79b30:	je     79b6c <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x20fc>
   79b32:	movzbl 0x8dd7f(%rip),%ecx        # 1078b8 <scan_experiment::TRACK>
   79b39:	test   %cl,%cl
   79b3b:	je     79b49 <block_msd_research::count_first_full_scan::block_msd_stable_radixsort_body::<u32, u32>+0x20d9>
   79b3d:	shl    $0x3,%rax
   79b41:	lock sub %rax,0x8dd5f(%rip)        # 1078a8 <scan_experiment::LIVE>
   79b49:	mov    0x18(%rsp),%rdi
   79b4e:	call   *0x8b9c4(%rip)        # 105518 <free@GLIBC_2.2.5>
   79b54:	lea    0xd8(%rsp),%rdi
   79b5c:	call   727a0 <core::ptr::drop_glue::<block_msd_research::count_first_full_scan::Arena<u32>>>
   79b61:	mov    %r15,%rdi
   79b64:	call   100870 <_Unwind_Resume@plt>
   79b69:	mov    %rax,%r15
   79b6c:	lea    0xd8(%rsp),%rdi
   79b74:	call   727a0 <core::ptr::drop_glue::<block_msd_research::count_first_full_scan::Arena<u32>>>
   79b79:	mov    %r15,%rdi
   79b7c:	call   100870 <_Unwind_Resume@plt>
   79b81:	int3
   79b82:	int3
   79b83:	int3
   79b84:	int3
   79b85:	int3
   79b86:	int3
   79b87:	int3
   79b88:	int3
   79b89:	int3
   79b8a:	int3
   79b8b:	int3
   79b8c:	int3
   79b8d:	int3
   79b8e:	int3
   79b8f:	int3
