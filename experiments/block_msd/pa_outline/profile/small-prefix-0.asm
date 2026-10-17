
experiments/block_msd/target/pa-outline/time:     file format elf64-x86-64


Disassembly of section .text:

00000000001e3a30 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>>:
  1e3a30:	push   %rbp
  1e3a31:	push   %r15
  1e3a33:	push   %r14
  1e3a35:	push   %r13
  1e3a37:	push   %r12
  1e3a39:	push   %rbx
  1e3a3a:	sub    $0x88,%rsp
  1e3a41:	mov    %r9,0x10(%rsp)
  1e3a46:	mov    %r8,0x38(%rsp)
  1e3a4b:	mov    %rsi,%r10
  1e3a4e:	mov    0x80(%rdi),%rax
  1e3a55:	mov    0xa8(%rdi),%rsi
  1e3a5c:	mov    %rsi,0x78(%rsp)
  1e3a61:	cmp    %rsi,%rax
  1e3a64:	jae    1e3fc8 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x598>
  1e3a6a:	mov    0x20(%rdi),%rsi
  1e3a6e:	mov    %rsi,0x28(%rsp)
  1e3a73:	mov    0x28(%rdi),%rsi
  1e3a77:	mov    0x88(%rdi),%r15
  1e3a7e:	mov    0xa0(%rdi),%r8
  1e3a85:	mov    %r8,0x20(%rsp)
  1e3a8a:	mov    0x90(%rdi),%r8
  1e3a91:	mov    %r8,0x18(%rsp)
  1e3a96:	mov    0x78(%rdi),%rbp
  1e3a9a:	mov    0x70(%rdi),%r8
  1e3a9e:	mov    %r8,0x70(%rsp)
  1e3aa3:	mov    0x68(%rdi),%r9
  1e3aa7:	mov    (%r10),%rbx
  1e3aaa:	mov    0x58(%rdi),%r8
  1e3aae:	mov    %r8,0x8(%rsp)
  1e3ab3:	mov    0x50(%rdi),%rdi
  1e3ab7:	mov    %rdi,0x30(%rsp)
  1e3abc:	cmp    %rsi,%rax
  1e3abf:	mov    %rsi,%rdi
  1e3ac2:	cmova  %rax,%rdi
  1e3ac6:	mov    %rdi,0x48(%rsp)
  1e3acb:	xor    %r10d,%r10d
  1e3ace:	mov    %rax,%r8
  1e3ad1:	mov    %r9,0x68(%rsp)
  1e3ad6:	jmp    1e3afd <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0xcd>
  1e3ad8:	nopl   0x0(%rax,%rax,1)
  1e3ae0:	mov    0x58(%rsp),%r8
  1e3ae5:	inc    %r8
  1e3ae8:	cmp    0x78(%rsp),%r8
  1e3aed:	mov    0x68(%rsp),%r9
  1e3af2:	mov    0x40(%rsp),%r10
  1e3af7:	je     1e3fc8 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x598>
  1e3afd:	cmp    0x48(%rsp),%r8
  1e3b02:	je     1e404d <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x61d>
  1e3b08:	mov    0x28(%rsp),%rdi
  1e3b0d:	mov    (%rdi,%r8,4),%edi
  1e3b11:	cmp    %rdi,%rsi
  1e3b14:	jbe    1e3fda <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x5aa>
  1e3b1a:	mov    %r8,0x58(%rsp)
  1e3b1f:	mov    %rdi,%r14
  1e3b22:	cmp    %rdi,%r15
  1e3b25:	mov    $0x0,%edi
  1e3b2a:	cmovbe %r15,%rdi
  1e3b2e:	mov    0x18(%rsp),%r8
  1e3b33:	cmova  0x20(%rsp),%r8
  1e3b39:	mov    %r8,0x50(%rsp)
  1e3b3e:	cmp    0x70(%rsp),%r10
  1e3b43:	jae    1e3b70 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x140>
  1e3b45:	mov    %r10,%r8
  1e3b48:	shl    $0x4,%r8
  1e3b4c:	mov    0x58(%rsp),%r11
  1e3b51:	cmp    %r11,(%r9,%r8,1)
  1e3b55:	jne    1e3b70 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x140>
  1e3b57:	add    %r9,%r8
  1e3b5a:	mov    0x8(%r8),%r8
  1e3b5e:	inc    %r10
  1e3b61:	mov    %r10,0x40(%rsp)
  1e3b66:	jmp    1e3b78 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x148>
  1e3b68:	nopl   0x0(%rax,%rax,1)
  1e3b70:	mov    %r10,0x40(%rsp)
  1e3b75:	mov    %rbp,%r8
  1e3b78:	sub    %rdi,%r14
  1e3b7b:	mov    %r8,0x60(%rsp)
  1e3b80:	shr    $0x2,%r8
  1e3b84:	mov    %r14,0x80(%rsp)
  1e3b8c:	je     1e3ec0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x490>
  1e3b92:	lea    0x0(,%rbp,8),%rdi
  1e3b9a:	imul   %r14,%rdi
  1e3b9e:	mov    0x50(%rsp),%r9
  1e3ba3:	add    %rdi,%r9
  1e3ba6:	add    $0x18,%r9
  1e3baa:	jmp    1e3bc9 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x199>
  1e3bac:	nopl   0x0(%rax)
  1e3bb0:	mov    0x38(%rsp),%rdi
  1e3bb5:	incq   (%rdi,%r11,8)
  1e3bb9:	inc    %rax
  1e3bbc:	add    $0x20,%r9
  1e3bc0:	dec    %r8
  1e3bc3:	je     1e3ec0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x490>
  1e3bc9:	mov    (%rbx),%rdi
  1e3bcc:	movzbl (%rdi),%r10d
  1e3bd0:	shrx   %r10d,-0x18(%r9),%r10d
  1e3bd6:	and    0x8(%rdi),%r10d
  1e3bda:	movzbl %r10b,%edi
  1e3bde:	cmp    %rdi,%rcx
  1e3be1:	jbe    1e402b <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x5fb>
  1e3be7:	mov    %edi,%r11d
  1e3bea:	shl    $0x4,%r11d
  1e3bee:	mov    (%rdx,%r11,1),%r14
  1e3bf2:	mov    -0x18(%r9),%r12
  1e3bf6:	lea    0x8(%r14),%r13
  1e3bfa:	cmp    0x8(%rdx,%r11,1),%r13
  1e3bff:	mov    %r12,(%r14)
  1e3c02:	mov    %r13,(%rdx,%r11,1)
  1e3c06:	jne    1e3c86 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x256>
  1e3c08:	cmp    %rsi,%rax
  1e3c0b:	jae    1e4006 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x5d6>
  1e3c11:	mov    0x28(%rsp),%r14
  1e3c16:	mov    (%r14,%rax,4),%r14d
  1e3c1a:	cmp    %r14,%rsi
  1e3c1d:	jbe    1e3fda <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x5aa>
  1e3c23:	add    %rdx,%r11
  1e3c26:	cmp    %r14,%r15
  1e3c29:	mov    $0x0,%r12d
  1e3c2f:	cmovbe %r15,%r12
  1e3c33:	mov    0x18(%rsp),%r13
  1e3c38:	cmova  0x20(%rsp),%r13
  1e3c3e:	sub    %r12,%r14
  1e3c41:	imul   %rbp,%r14
  1e3c45:	lea    0x0(,%r14,8),%r14
  1e3c4d:	add    %r13,%r14
  1e3c50:	lea    (%r14,%rbp,8),%r12
  1e3c54:	mov    %r14,(%r11)
  1e3c57:	mov    %r12,0x8(%r11)
  1e3c5b:	cmp    0x8(%rsp),%rax
  1e3c60:	jae    1e4016 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x5e6>
  1e3c66:	mov    0x30(%rsp),%r11
  1e3c6b:	mov    %r10b,(%r11,%rax,1)
  1e3c6f:	cmp    %rdi,0x10(%rsp)
  1e3c74:	jbe    1e403b <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x60b>
  1e3c7a:	mov    0x38(%rsp),%r10
  1e3c7f:	incq   (%r10,%rdi,8)
  1e3c83:	inc    %rax
  1e3c86:	mov    (%rbx),%rdi
  1e3c89:	movzbl (%rdi),%r10d
  1e3c8d:	shrx   %r10d,-0x10(%r9),%r10d
  1e3c93:	and    0x8(%rdi),%r10d
  1e3c97:	movzbl %r10b,%r11d
  1e3c9b:	cmp    %r11,%rcx
  1e3c9e:	jbe    1e3ff3 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x5c3>
  1e3ca4:	mov    %r11d,%edi
  1e3ca7:	shl    $0x4,%edi
  1e3caa:	mov    (%rdx,%rdi,1),%r14
  1e3cae:	mov    -0x10(%r9),%r12
  1e3cb2:	lea    0x8(%r14),%r13
  1e3cb6:	cmp    0x8(%rdx,%rdi,1),%r13
  1e3cbb:	mov    %r12,(%r14)
  1e3cbe:	mov    %r13,(%rdx,%rdi,1)
  1e3cc2:	jne    1e3d42 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x312>
  1e3cc4:	cmp    %rsi,%rax
  1e3cc7:	jae    1e4006 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x5d6>
  1e3ccd:	mov    0x28(%rsp),%r14
  1e3cd2:	mov    (%r14,%rax,4),%r14d
  1e3cd6:	cmp    %r14,%rsi
  1e3cd9:	jbe    1e3fda <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x5aa>
  1e3cdf:	add    %rdx,%rdi
  1e3ce2:	cmp    %r14,%r15
  1e3ce5:	mov    $0x0,%r12d
  1e3ceb:	cmovbe %r15,%r12
  1e3cef:	mov    0x18(%rsp),%r13
  1e3cf4:	cmova  0x20(%rsp),%r13
  1e3cfa:	sub    %r12,%r14
  1e3cfd:	imul   %rbp,%r14
  1e3d01:	lea    0x0(,%r14,8),%r14
  1e3d09:	add    %r13,%r14
  1e3d0c:	lea    (%r14,%rbp,8),%r12
  1e3d10:	mov    %r14,(%rdi)
  1e3d13:	mov    %r12,0x8(%rdi)
  1e3d17:	cmp    0x8(%rsp),%rax
  1e3d1c:	jae    1e4016 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x5e6>
  1e3d22:	mov    0x30(%rsp),%rdi
  1e3d27:	mov    %r10b,(%rdi,%rax,1)
  1e3d2b:	cmp    %r11,0x10(%rsp)
  1e3d30:	jbe    1e3fb3 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x583>
  1e3d36:	mov    0x38(%rsp),%rdi
  1e3d3b:	incq   (%rdi,%r11,8)
  1e3d3f:	inc    %rax
  1e3d42:	mov    (%rbx),%rdi
  1e3d45:	movzbl (%rdi),%r10d
  1e3d49:	shrx   %r10d,-0x8(%r9),%r10d
  1e3d4f:	and    0x8(%rdi),%r10d
  1e3d53:	movzbl %r10b,%r11d
  1e3d57:	cmp    %r11,%rcx
  1e3d5a:	jbe    1e3ff3 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x5c3>
  1e3d60:	mov    %r11d,%edi
  1e3d63:	shl    $0x4,%edi
  1e3d66:	mov    (%rdx,%rdi,1),%r14
  1e3d6a:	mov    -0x8(%r9),%r12
  1e3d6e:	lea    0x8(%r14),%r13
  1e3d72:	cmp    0x8(%rdx,%rdi,1),%r13
  1e3d77:	mov    %r12,(%r14)
  1e3d7a:	mov    %r13,(%rdx,%rdi,1)
  1e3d7e:	jne    1e3dfe <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x3ce>
  1e3d80:	cmp    %rsi,%rax
  1e3d83:	jae    1e4006 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x5d6>
  1e3d89:	mov    0x28(%rsp),%r14
  1e3d8e:	mov    (%r14,%rax,4),%r14d
  1e3d92:	cmp    %r14,%rsi
  1e3d95:	jbe    1e3fda <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x5aa>
  1e3d9b:	add    %rdx,%rdi
  1e3d9e:	cmp    %r14,%r15
  1e3da1:	mov    $0x0,%r12d
  1e3da7:	cmovbe %r15,%r12
  1e3dab:	mov    0x18(%rsp),%r13
  1e3db0:	cmova  0x20(%rsp),%r13
  1e3db6:	sub    %r12,%r14
  1e3db9:	imul   %rbp,%r14
  1e3dbd:	lea    0x0(,%r14,8),%r14
  1e3dc5:	add    %r13,%r14
  1e3dc8:	lea    (%r14,%rbp,8),%r12
  1e3dcc:	mov    %r14,(%rdi)
  1e3dcf:	mov    %r12,0x8(%rdi)
  1e3dd3:	cmp    0x8(%rsp),%rax
  1e3dd8:	jae    1e4016 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x5e6>
  1e3dde:	mov    0x30(%rsp),%rdi
  1e3de3:	mov    %r10b,(%rdi,%rax,1)
  1e3de7:	cmp    %r11,0x10(%rsp)
  1e3dec:	jbe    1e3fb3 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x583>
  1e3df2:	mov    0x38(%rsp),%rdi
  1e3df7:	incq   (%rdi,%r11,8)
  1e3dfb:	inc    %rax
  1e3dfe:	mov    (%rbx),%rdi
  1e3e01:	movzbl (%rdi),%r10d
  1e3e05:	shrx   %r10d,(%r9),%r10d
  1e3e0a:	and    0x8(%rdi),%r10d
  1e3e0e:	movzbl %r10b,%r11d
  1e3e12:	cmp    %r11,%rcx
  1e3e15:	jbe    1e3ff3 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x5c3>
  1e3e1b:	mov    %r11d,%edi
  1e3e1e:	shl    $0x4,%edi
  1e3e21:	mov    (%rdx,%rdi,1),%r14
  1e3e25:	mov    (%r9),%r12
  1e3e28:	lea    0x8(%r14),%r13
  1e3e2c:	cmp    0x8(%rdx,%rdi,1),%r13
  1e3e31:	mov    %r12,(%r14)
  1e3e34:	mov    %r13,(%rdx,%rdi,1)
  1e3e38:	jne    1e3bbc <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x18c>
  1e3e3e:	cmp    %rsi,%rax
  1e3e41:	jae    1e4006 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x5d6>
  1e3e47:	mov    0x28(%rsp),%r14
  1e3e4c:	mov    (%r14,%rax,4),%r14d
  1e3e50:	cmp    %r14,%rsi
  1e3e53:	jbe    1e3fda <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x5aa>
  1e3e59:	add    %rdx,%rdi
  1e3e5c:	cmp    %r14,%r15
  1e3e5f:	mov    $0x0,%r12d
  1e3e65:	cmovbe %r15,%r12
  1e3e69:	mov    0x18(%rsp),%r13
  1e3e6e:	cmova  0x20(%rsp),%r13
  1e3e74:	sub    %r12,%r14
  1e3e77:	imul   %rbp,%r14
  1e3e7b:	lea    0x0(,%r14,8),%r14
  1e3e83:	add    %r13,%r14
  1e3e86:	lea    (%r14,%rbp,8),%r12
  1e3e8a:	mov    %r14,(%rdi)
  1e3e8d:	mov    %r12,0x8(%rdi)
  1e3e91:	cmp    0x8(%rsp),%rax
  1e3e96:	jae    1e4016 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x5e6>
  1e3e9c:	mov    0x30(%rsp),%rdi
  1e3ea1:	mov    %r10b,(%rdi,%rax,1)
  1e3ea5:	cmp    %r11,0x10(%rsp)
  1e3eaa:	ja     1e3bb0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x180>
  1e3eb0:	jmp    1e3fb3 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x583>
  1e3eb5:	data16 cs nopw 0x0(%rax,%rax,1)
  1e3ec0:	mov    0x60(%rsp),%r8
  1e3ec5:	mov    %r8,%rdi
  1e3ec8:	and    $0xfffffffffffffffc,%rdi
  1e3ecc:	cmp    %r8,%rdi
  1e3ecf:	je     1e3ae0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0xb0>
  1e3ed5:	mov    0x80(%rsp),%r8
  1e3edd:	imul   %rbp,%r8
  1e3ee1:	mov    0x50(%rsp),%r9
  1e3ee6:	lea    (%r9,%r8,8),%r9
  1e3eea:	jmp    1e3f0a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x4da>
  1e3eec:	nopl   0x0(%rax)
  1e3ef0:	mov    0x38(%rsp),%r8
  1e3ef5:	incq   (%r8,%r11,8)
  1e3ef9:	inc    %rax
  1e3efc:	inc    %rdi
  1e3eff:	cmp    0x60(%rsp),%rdi
  1e3f04:	jae    1e3ae0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0xb0>
  1e3f0a:	mov    (%rbx),%r8
  1e3f0d:	movzbl (%r8),%r10d
  1e3f11:	shrx   %r10d,(%r9,%rdi,8),%r10d
  1e3f17:	and    0x8(%r8),%r10d
  1e3f1b:	movzbl %r10b,%r11d
  1e3f1f:	cmp    %r11,%rcx
  1e3f22:	jbe    1e3ff3 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x5c3>
  1e3f28:	mov    %r11d,%r8d
  1e3f2b:	shl    $0x4,%r8d
  1e3f2f:	mov    (%rdx,%r8,1),%r14
  1e3f33:	mov    (%r9,%rdi,8),%r12
  1e3f37:	lea    0x8(%r14),%r13
  1e3f3b:	cmp    0x8(%rdx,%r8,1),%r13
  1e3f40:	mov    %r12,(%r14)
  1e3f43:	mov    %r13,(%rdx,%r8,1)
  1e3f47:	jne    1e3efc <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x4cc>
  1e3f49:	cmp    %rsi,%rax
  1e3f4c:	jae    1e4006 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x5d6>
  1e3f52:	mov    0x28(%rsp),%r14
  1e3f57:	mov    (%r14,%rax,4),%r14d
  1e3f5b:	cmp    %r14,%rsi
  1e3f5e:	jbe    1e3fda <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x5aa>
  1e3f60:	add    %rdx,%r8
  1e3f63:	cmp    %r14,%r15
  1e3f66:	mov    $0x0,%r12d
  1e3f6c:	cmovbe %r15,%r12
  1e3f70:	mov    0x18(%rsp),%r13
  1e3f75:	cmova  0x20(%rsp),%r13
  1e3f7b:	sub    %r12,%r14
  1e3f7e:	imul   %rbp,%r14
  1e3f82:	lea    0x0(,%r14,8),%r14
  1e3f8a:	add    %r13,%r14
  1e3f8d:	lea    (%r14,%rbp,8),%r12
  1e3f91:	mov    %r14,(%r8)
  1e3f94:	mov    %r12,0x8(%r8)
  1e3f98:	cmp    0x8(%rsp),%rax
  1e3f9d:	jae    1e4016 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x5e6>
  1e3f9f:	mov    0x30(%rsp),%r8
  1e3fa4:	mov    %r10b,(%r8,%rax,1)
  1e3fa8:	cmp    %r11,0x10(%rsp)
  1e3fad:	ja     1e3ef0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x4c0>
  1e3fb3:	lea    0x155986(%rip),%rdx        # 339940 <anon.0154b0ae4e43a031cafbc3dbea9bcf13.2.llvm.11444141577931038052+0x2e0>
  1e3fba:	mov    %r11,%rdi
  1e3fbd:	mov    0x10(%rsp),%rsi
  1e3fc2:	call   *0x158bd0(%rip)        # 33cb98 <_DYNAMIC+0x278>
  1e3fc8:	add    $0x88,%rsp
  1e3fcf:	pop    %rbx
  1e3fd0:	pop    %r12
  1e3fd2:	pop    %r13
  1e3fd4:	pop    %r14
  1e3fd6:	pop    %r15
  1e3fd8:	pop    %rbp
  1e3fd9:	ret
  1e3fda:	lea    -0x1cea2e(%rip),%rdi        # 155b3 <anon.0154b0ae4e43a031cafbc3dbea9bcf13.0.llvm.11444141577931038052+0xf3>
  1e3fe1:	lea    0x1559e8(%rip),%rdx        # 3399d0 <anon.0154b0ae4e43a031cafbc3dbea9bcf13.2.llvm.11444141577931038052+0x370>
  1e3fe8:	mov    $0x2c,%esi
  1e3fed:	call   *0x158c8d(%rip)        # 33cc80 <_DYNAMIC+0x360>
  1e3ff3:	lea    0x1558fe(%rip),%rdx        # 3398f8 <anon.0154b0ae4e43a031cafbc3dbea9bcf13.2.llvm.11444141577931038052+0x298>
  1e3ffa:	mov    %r11,%rdi
  1e3ffd:	mov    %rcx,%rsi
  1e4000:	call   *0x158b92(%rip)        # 33cb98 <_DYNAMIC+0x278>
  1e4006:	lea    0x155903(%rip),%rdx        # 339910 <anon.0154b0ae4e43a031cafbc3dbea9bcf13.2.llvm.11444141577931038052+0x2b0>
  1e400d:	mov    %rax,%rdi
  1e4010:	call   *0x158b82(%rip)        # 33cb98 <_DYNAMIC+0x278>
  1e4016:	lea    0x15590b(%rip),%rdx        # 339928 <anon.0154b0ae4e43a031cafbc3dbea9bcf13.2.llvm.11444141577931038052+0x2c8>
  1e401d:	mov    %rax,%rdi
  1e4020:	mov    0x8(%rsp),%rsi
  1e4025:	call   *0x158b6d(%rip)        # 33cb98 <_DYNAMIC+0x278>
  1e402b:	lea    0x1558c6(%rip),%rdx        # 3398f8 <anon.0154b0ae4e43a031cafbc3dbea9bcf13.2.llvm.11444141577931038052+0x298>
  1e4032:	mov    %rcx,%rsi
  1e4035:	call   *0x158b5d(%rip)        # 33cb98 <_DYNAMIC+0x278>
  1e403b:	lea    0x1558fe(%rip),%rdx        # 339940 <anon.0154b0ae4e43a031cafbc3dbea9bcf13.2.llvm.11444141577931038052+0x2e0>
  1e4042:	mov    0x10(%rsp),%rsi
  1e4047:	call   *0x158b4b(%rip)        # 33cb98 <_DYNAMIC+0x278>
  1e404d:	lea    0x1556b4(%rip),%rdx        # 339708 <anon.0154b0ae4e43a031cafbc3dbea9bcf13.2.llvm.11444141577931038052+0xa8>
  1e4054:	mov    0x48(%rsp),%rdi
  1e4059:	call   *0x158b39(%rip)        # 33cb98 <_DYNAMIC+0x278>
