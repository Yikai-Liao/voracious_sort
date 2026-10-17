
experiments/block_msd/target/pa-outline-final/time:     file format elf64-x86-64


Disassembly of section .text:

0000000000141780 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>>:
  141780:	push   %rbp
  141781:	push   %r15
  141783:	push   %r14
  141785:	push   %r13
  141787:	push   %r12
  141789:	push   %rbx
  14178a:	sub    $0x88,%rsp
  141791:	mov    %r9,0x10(%rsp)
  141796:	mov    %r8,0x38(%rsp)
  14179b:	mov    %rsi,%r10
  14179e:	mov    0x80(%rdi),%rax
  1417a5:	mov    0xa8(%rdi),%rsi
  1417ac:	mov    %rsi,0x78(%rsp)
  1417b1:	cmp    %rsi,%rax
  1417b4:	jae    141d18 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x598>
  1417ba:	mov    0x20(%rdi),%rsi
  1417be:	mov    %rsi,0x28(%rsp)
  1417c3:	mov    0x28(%rdi),%rsi
  1417c7:	mov    0x88(%rdi),%r15
  1417ce:	mov    0xa0(%rdi),%r8
  1417d5:	mov    %r8,0x20(%rsp)
  1417da:	mov    0x90(%rdi),%r8
  1417e1:	mov    %r8,0x18(%rsp)
  1417e6:	mov    0x78(%rdi),%rbp
  1417ea:	mov    0x70(%rdi),%r8
  1417ee:	mov    %r8,0x70(%rsp)
  1417f3:	mov    0x68(%rdi),%r9
  1417f7:	mov    (%r10),%rbx
  1417fa:	mov    0x58(%rdi),%r8
  1417fe:	mov    %r8,0x8(%rsp)
  141803:	mov    0x50(%rdi),%rdi
  141807:	mov    %rdi,0x30(%rsp)
  14180c:	cmp    %rsi,%rax
  14180f:	mov    %rsi,%rdi
  141812:	cmova  %rax,%rdi
  141816:	mov    %rdi,0x48(%rsp)
  14181b:	xor    %r10d,%r10d
  14181e:	mov    %rax,%r8
  141821:	mov    %r9,0x68(%rsp)
  141826:	jmp    14184d <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0xcd>
  141828:	nopl   0x0(%rax,%rax,1)
  141830:	mov    0x58(%rsp),%r8
  141835:	inc    %r8
  141838:	cmp    0x78(%rsp),%r8
  14183d:	mov    0x68(%rsp),%r9
  141842:	mov    0x40(%rsp),%r10
  141847:	je     141d18 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x598>
  14184d:	cmp    0x48(%rsp),%r8
  141852:	je     141d9d <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x61d>
  141858:	mov    0x28(%rsp),%rdi
  14185d:	mov    (%rdi,%r8,4),%edi
  141861:	cmp    %rdi,%rsi
  141864:	jbe    141d2a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x5aa>
  14186a:	mov    %r8,0x58(%rsp)
  14186f:	mov    %rdi,%r14
  141872:	cmp    %rdi,%r15
  141875:	mov    $0x0,%edi
  14187a:	cmovbe %r15,%rdi
  14187e:	mov    0x18(%rsp),%r8
  141883:	cmova  0x20(%rsp),%r8
  141889:	mov    %r8,0x50(%rsp)
  14188e:	cmp    0x70(%rsp),%r10
  141893:	jae    1418c0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x140>
  141895:	mov    %r10,%r8
  141898:	shl    $0x4,%r8
  14189c:	mov    0x58(%rsp),%r11
  1418a1:	cmp    %r11,(%r9,%r8,1)
  1418a5:	jne    1418c0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x140>
  1418a7:	add    %r9,%r8
  1418aa:	mov    0x8(%r8),%r8
  1418ae:	inc    %r10
  1418b1:	mov    %r10,0x40(%rsp)
  1418b6:	jmp    1418c8 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x148>
  1418b8:	nopl   0x0(%rax,%rax,1)
  1418c0:	mov    %r10,0x40(%rsp)
  1418c5:	mov    %rbp,%r8
  1418c8:	sub    %rdi,%r14
  1418cb:	mov    %r8,0x60(%rsp)
  1418d0:	shr    $0x2,%r8
  1418d4:	mov    %r14,0x80(%rsp)
  1418dc:	je     141c10 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x490>
  1418e2:	lea    0x0(,%rbp,8),%rdi
  1418ea:	imul   %r14,%rdi
  1418ee:	mov    0x50(%rsp),%r9
  1418f3:	add    %rdi,%r9
  1418f6:	add    $0x18,%r9
  1418fa:	jmp    141919 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x199>
  1418fc:	nopl   0x0(%rax)
  141900:	mov    0x38(%rsp),%rdi
  141905:	incq   (%rdi,%r11,8)
  141909:	inc    %rax
  14190c:	add    $0x20,%r9
  141910:	dec    %r8
  141913:	je     141c10 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x490>
  141919:	mov    (%rbx),%rdi
  14191c:	movzbl (%rdi),%r10d
  141920:	shrx   %r10d,-0x18(%r9),%r10d
  141926:	and    0x8(%rdi),%r10d
  14192a:	movzbl %r10b,%edi
  14192e:	cmp    %rdi,%rcx
  141931:	jbe    141d7b <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x5fb>
  141937:	mov    %edi,%r11d
  14193a:	shl    $0x4,%r11d
  14193e:	mov    (%rdx,%r11,1),%r14
  141942:	mov    -0x18(%r9),%r12
  141946:	lea    0x8(%r14),%r13
  14194a:	cmp    0x8(%rdx,%r11,1),%r13
  14194f:	mov    %r12,(%r14)
  141952:	mov    %r13,(%rdx,%r11,1)
  141956:	jne    1419d6 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x256>
  141958:	cmp    %rsi,%rax
  14195b:	jae    141d56 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x5d6>
  141961:	mov    0x28(%rsp),%r14
  141966:	mov    (%r14,%rax,4),%r14d
  14196a:	cmp    %r14,%rsi
  14196d:	jbe    141d2a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x5aa>
  141973:	add    %rdx,%r11
  141976:	cmp    %r14,%r15
  141979:	mov    $0x0,%r12d
  14197f:	cmovbe %r15,%r12
  141983:	mov    0x18(%rsp),%r13
  141988:	cmova  0x20(%rsp),%r13
  14198e:	sub    %r12,%r14
  141991:	imul   %rbp,%r14
  141995:	lea    0x0(,%r14,8),%r14
  14199d:	add    %r13,%r14
  1419a0:	lea    (%r14,%rbp,8),%r12
  1419a4:	mov    %r14,(%r11)
  1419a7:	mov    %r12,0x8(%r11)
  1419ab:	cmp    0x8(%rsp),%rax
  1419b0:	jae    141d66 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x5e6>
  1419b6:	mov    0x30(%rsp),%r11
  1419bb:	mov    %r10b,(%r11,%rax,1)
  1419bf:	cmp    %rdi,0x10(%rsp)
  1419c4:	jbe    141d8b <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x60b>
  1419ca:	mov    0x38(%rsp),%r10
  1419cf:	incq   (%r10,%rdi,8)
  1419d3:	inc    %rax
  1419d6:	mov    (%rbx),%rdi
  1419d9:	movzbl (%rdi),%r10d
  1419dd:	shrx   %r10d,-0x10(%r9),%r10d
  1419e3:	and    0x8(%rdi),%r10d
  1419e7:	movzbl %r10b,%r11d
  1419eb:	cmp    %r11,%rcx
  1419ee:	jbe    141d43 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x5c3>
  1419f4:	mov    %r11d,%edi
  1419f7:	shl    $0x4,%edi
  1419fa:	mov    (%rdx,%rdi,1),%r14
  1419fe:	mov    -0x10(%r9),%r12
  141a02:	lea    0x8(%r14),%r13
  141a06:	cmp    0x8(%rdx,%rdi,1),%r13
  141a0b:	mov    %r12,(%r14)
  141a0e:	mov    %r13,(%rdx,%rdi,1)
  141a12:	jne    141a92 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x312>
  141a14:	cmp    %rsi,%rax
  141a17:	jae    141d56 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x5d6>
  141a1d:	mov    0x28(%rsp),%r14
  141a22:	mov    (%r14,%rax,4),%r14d
  141a26:	cmp    %r14,%rsi
  141a29:	jbe    141d2a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x5aa>
  141a2f:	add    %rdx,%rdi
  141a32:	cmp    %r14,%r15
  141a35:	mov    $0x0,%r12d
  141a3b:	cmovbe %r15,%r12
  141a3f:	mov    0x18(%rsp),%r13
  141a44:	cmova  0x20(%rsp),%r13
  141a4a:	sub    %r12,%r14
  141a4d:	imul   %rbp,%r14
  141a51:	lea    0x0(,%r14,8),%r14
  141a59:	add    %r13,%r14
  141a5c:	lea    (%r14,%rbp,8),%r12
  141a60:	mov    %r14,(%rdi)
  141a63:	mov    %r12,0x8(%rdi)
  141a67:	cmp    0x8(%rsp),%rax
  141a6c:	jae    141d66 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x5e6>
  141a72:	mov    0x30(%rsp),%rdi
  141a77:	mov    %r10b,(%rdi,%rax,1)
  141a7b:	cmp    %r11,0x10(%rsp)
  141a80:	jbe    141d03 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x583>
  141a86:	mov    0x38(%rsp),%rdi
  141a8b:	incq   (%rdi,%r11,8)
  141a8f:	inc    %rax
  141a92:	mov    (%rbx),%rdi
  141a95:	movzbl (%rdi),%r10d
  141a99:	shrx   %r10d,-0x8(%r9),%r10d
  141a9f:	and    0x8(%rdi),%r10d
  141aa3:	movzbl %r10b,%r11d
  141aa7:	cmp    %r11,%rcx
  141aaa:	jbe    141d43 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x5c3>
  141ab0:	mov    %r11d,%edi
  141ab3:	shl    $0x4,%edi
  141ab6:	mov    (%rdx,%rdi,1),%r14
  141aba:	mov    -0x8(%r9),%r12
  141abe:	lea    0x8(%r14),%r13
  141ac2:	cmp    0x8(%rdx,%rdi,1),%r13
  141ac7:	mov    %r12,(%r14)
  141aca:	mov    %r13,(%rdx,%rdi,1)
  141ace:	jne    141b4e <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x3ce>
  141ad0:	cmp    %rsi,%rax
  141ad3:	jae    141d56 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x5d6>
  141ad9:	mov    0x28(%rsp),%r14
  141ade:	mov    (%r14,%rax,4),%r14d
  141ae2:	cmp    %r14,%rsi
  141ae5:	jbe    141d2a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x5aa>
  141aeb:	add    %rdx,%rdi
  141aee:	cmp    %r14,%r15
  141af1:	mov    $0x0,%r12d
  141af7:	cmovbe %r15,%r12
  141afb:	mov    0x18(%rsp),%r13
  141b00:	cmova  0x20(%rsp),%r13
  141b06:	sub    %r12,%r14
  141b09:	imul   %rbp,%r14
  141b0d:	lea    0x0(,%r14,8),%r14
  141b15:	add    %r13,%r14
  141b18:	lea    (%r14,%rbp,8),%r12
  141b1c:	mov    %r14,(%rdi)
  141b1f:	mov    %r12,0x8(%rdi)
  141b23:	cmp    0x8(%rsp),%rax
  141b28:	jae    141d66 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x5e6>
  141b2e:	mov    0x30(%rsp),%rdi
  141b33:	mov    %r10b,(%rdi,%rax,1)
  141b37:	cmp    %r11,0x10(%rsp)
  141b3c:	jbe    141d03 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x583>
  141b42:	mov    0x38(%rsp),%rdi
  141b47:	incq   (%rdi,%r11,8)
  141b4b:	inc    %rax
  141b4e:	mov    (%rbx),%rdi
  141b51:	movzbl (%rdi),%r10d
  141b55:	shrx   %r10d,(%r9),%r10d
  141b5a:	and    0x8(%rdi),%r10d
  141b5e:	movzbl %r10b,%r11d
  141b62:	cmp    %r11,%rcx
  141b65:	jbe    141d43 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x5c3>
  141b6b:	mov    %r11d,%edi
  141b6e:	shl    $0x4,%edi
  141b71:	mov    (%rdx,%rdi,1),%r14
  141b75:	mov    (%r9),%r12
  141b78:	lea    0x8(%r14),%r13
  141b7c:	cmp    0x8(%rdx,%rdi,1),%r13
  141b81:	mov    %r12,(%r14)
  141b84:	mov    %r13,(%rdx,%rdi,1)
  141b88:	jne    14190c <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x18c>
  141b8e:	cmp    %rsi,%rax
  141b91:	jae    141d56 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x5d6>
  141b97:	mov    0x28(%rsp),%r14
  141b9c:	mov    (%r14,%rax,4),%r14d
  141ba0:	cmp    %r14,%rsi
  141ba3:	jbe    141d2a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x5aa>
  141ba9:	add    %rdx,%rdi
  141bac:	cmp    %r14,%r15
  141baf:	mov    $0x0,%r12d
  141bb5:	cmovbe %r15,%r12
  141bb9:	mov    0x18(%rsp),%r13
  141bbe:	cmova  0x20(%rsp),%r13
  141bc4:	sub    %r12,%r14
  141bc7:	imul   %rbp,%r14
  141bcb:	lea    0x0(,%r14,8),%r14
  141bd3:	add    %r13,%r14
  141bd6:	lea    (%r14,%rbp,8),%r12
  141bda:	mov    %r14,(%rdi)
  141bdd:	mov    %r12,0x8(%rdi)
  141be1:	cmp    0x8(%rsp),%rax
  141be6:	jae    141d66 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x5e6>
  141bec:	mov    0x30(%rsp),%rdi
  141bf1:	mov    %r10b,(%rdi,%rax,1)
  141bf5:	cmp    %r11,0x10(%rsp)
  141bfa:	ja     141900 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x180>
  141c00:	jmp    141d03 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x583>
  141c05:	data16 cs nopw 0x0(%rax,%rax,1)
  141c10:	mov    0x60(%rsp),%r8
  141c15:	mov    %r8,%rdi
  141c18:	and    $0xfffffffffffffffc,%rdi
  141c1c:	cmp    %r8,%rdi
  141c1f:	je     141830 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0xb0>
  141c25:	mov    0x80(%rsp),%r8
  141c2d:	imul   %rbp,%r8
  141c31:	mov    0x50(%rsp),%r9
  141c36:	lea    (%r9,%r8,8),%r9
  141c3a:	jmp    141c5a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x4da>
  141c3c:	nopl   0x0(%rax)
  141c40:	mov    0x38(%rsp),%r8
  141c45:	incq   (%r8,%r11,8)
  141c49:	inc    %rax
  141c4c:	inc    %rdi
  141c4f:	cmp    0x60(%rsp),%rdi
  141c54:	jae    141830 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0xb0>
  141c5a:	mov    (%rbx),%r8
  141c5d:	movzbl (%r8),%r10d
  141c61:	shrx   %r10d,(%r9,%rdi,8),%r10d
  141c67:	and    0x8(%r8),%r10d
  141c6b:	movzbl %r10b,%r11d
  141c6f:	cmp    %r11,%rcx
  141c72:	jbe    141d43 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x5c3>
  141c78:	mov    %r11d,%r8d
  141c7b:	shl    $0x4,%r8d
  141c7f:	mov    (%rdx,%r8,1),%r14
  141c83:	mov    (%r9,%rdi,8),%r12
  141c87:	lea    0x8(%r14),%r13
  141c8b:	cmp    0x8(%rdx,%r8,1),%r13
  141c90:	mov    %r12,(%r14)
  141c93:	mov    %r13,(%rdx,%r8,1)
  141c97:	jne    141c4c <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x4cc>
  141c99:	cmp    %rsi,%rax
  141c9c:	jae    141d56 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x5d6>
  141ca2:	mov    0x28(%rsp),%r14
  141ca7:	mov    (%r14,%rax,4),%r14d
  141cab:	cmp    %r14,%rsi
  141cae:	jbe    141d2a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x5aa>
  141cb0:	add    %rdx,%r8
  141cb3:	cmp    %r14,%r15
  141cb6:	mov    $0x0,%r12d
  141cbc:	cmovbe %r15,%r12
  141cc0:	mov    0x18(%rsp),%r13
  141cc5:	cmova  0x20(%rsp),%r13
  141ccb:	sub    %r12,%r14
  141cce:	imul   %rbp,%r14
  141cd2:	lea    0x0(,%r14,8),%r14
  141cda:	add    %r13,%r14
  141cdd:	lea    (%r14,%rbp,8),%r12
  141ce1:	mov    %r14,(%r8)
  141ce4:	mov    %r12,0x8(%r8)
  141ce8:	cmp    0x8(%rsp),%rax
  141ced:	jae    141d66 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x5e6>
  141cef:	mov    0x30(%rsp),%r8
  141cf4:	mov    %r10b,(%r8,%rax,1)
  141cf8:	cmp    %r11,0x10(%rsp)
  141cfd:	ja     141c40 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>+0x4c0>
  141d03:	lea    0x36e18e(%rip),%rdx        # 4afe98 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.4211023910758936617+0x2e0>
  141d0a:	mov    %r11,%rdi
  141d0d:	mov    0x10(%rsp),%rsi
  141d12:	call   *0x379480(%rip)        # 4bb198 <_DYNAMIC+0x2a8>
  141d18:	add    $0x88,%rsp
  141d1f:	pop    %rbx
  141d20:	pop    %r12
  141d22:	pop    %r13
  141d24:	pop    %r14
  141d26:	pop    %r15
  141d28:	pop    %rbp
  141d29:	ret
  141d2a:	lea    -0x12bbbe(%rip),%rdi        # 16173 <anon.8f17df2f0ddc4723825c0f55871536dc.0.llvm.4211023910758936617+0xf3>
  141d31:	lea    0x36e1f0(%rip),%rdx        # 4aff28 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.4211023910758936617+0x370>
  141d38:	mov    $0x2c,%esi
  141d3d:	call   *0x37943d(%rip)        # 4bb180 <_DYNAMIC+0x290>
  141d43:	lea    0x36e106(%rip),%rdx        # 4afe50 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.4211023910758936617+0x298>
  141d4a:	mov    %r11,%rdi
  141d4d:	mov    %rcx,%rsi
  141d50:	call   *0x379442(%rip)        # 4bb198 <_DYNAMIC+0x2a8>
  141d56:	lea    0x36e10b(%rip),%rdx        # 4afe68 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.4211023910758936617+0x2b0>
  141d5d:	mov    %rax,%rdi
  141d60:	call   *0x379432(%rip)        # 4bb198 <_DYNAMIC+0x2a8>
  141d66:	lea    0x36e113(%rip),%rdx        # 4afe80 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.4211023910758936617+0x2c8>
  141d6d:	mov    %rax,%rdi
  141d70:	mov    0x8(%rsp),%rsi
  141d75:	call   *0x37941d(%rip)        # 4bb198 <_DYNAMIC+0x2a8>
  141d7b:	lea    0x36e0ce(%rip),%rdx        # 4afe50 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.4211023910758936617+0x298>
  141d82:	mov    %rcx,%rsi
  141d85:	call   *0x37940d(%rip)        # 4bb198 <_DYNAMIC+0x2a8>
  141d8b:	lea    0x36e106(%rip),%rdx        # 4afe98 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.4211023910758936617+0x2e0>
  141d92:	mov    0x10(%rsp),%rsi
  141d97:	call   *0x3793fb(%rip)        # 4bb198 <_DYNAMIC+0x2a8>
  141d9d:	lea    0x36debc(%rip),%rdx        # 4afc60 <anon.8f17df2f0ddc4723825c0f55871536dc.2.llvm.4211023910758936617+0xa8>
  141da4:	mov    0x48(%rsp),%rdi
  141da9:	call   *0x3793e9(%rip)        # 4bb198 <_DYNAMIC+0x2a8>
