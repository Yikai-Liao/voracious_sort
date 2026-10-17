
experiments/block_msd/target/pa-outline/time:     file format elf64-x86-64


Disassembly of section .text:

00000000001e46b0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>>:
  1e46b0:	push   %rbp
  1e46b1:	push   %r15
  1e46b3:	push   %r14
  1e46b5:	push   %r13
  1e46b7:	push   %r12
  1e46b9:	push   %rbx
  1e46ba:	sub    $0x88,%rsp
  1e46c1:	mov    %r9,0x10(%rsp)
  1e46c6:	mov    %r8,0x38(%rsp)
  1e46cb:	mov    %rsi,%r10
  1e46ce:	mov    0x80(%rdi),%rax
  1e46d5:	mov    0xa8(%rdi),%rsi
  1e46dc:	mov    %rsi,0x78(%rsp)
  1e46e1:	cmp    %rsi,%rax
  1e46e4:	jae    1e4c5c <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x5ac>
  1e46ea:	mov    0x20(%rdi),%rsi
  1e46ee:	mov    %rsi,0x28(%rsp)
  1e46f3:	mov    0x28(%rdi),%rsi
  1e46f7:	mov    0x88(%rdi),%r15
  1e46fe:	mov    0xa0(%rdi),%r8
  1e4705:	mov    %r8,0x20(%rsp)
  1e470a:	mov    0x90(%rdi),%r8
  1e4711:	mov    %r8,0x18(%rsp)
  1e4716:	mov    0x78(%rdi),%rbp
  1e471a:	mov    0x70(%rdi),%r8
  1e471e:	mov    %r8,0x70(%rsp)
  1e4723:	mov    0x68(%rdi),%r9
  1e4727:	mov    (%r10),%rbx
  1e472a:	mov    0x58(%rdi),%r8
  1e472e:	mov    %r8,0x8(%rsp)
  1e4733:	mov    0x50(%rdi),%rdi
  1e4737:	mov    %rdi,0x30(%rsp)
  1e473c:	cmp    %rsi,%rax
  1e473f:	mov    %rsi,%rdi
  1e4742:	cmova  %rax,%rdi
  1e4746:	mov    %rdi,0x48(%rsp)
  1e474b:	xor    %r10d,%r10d
  1e474e:	mov    %rax,%r8
  1e4751:	mov    %r9,0x68(%rsp)
  1e4756:	jmp    1e477d <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0xcd>
  1e4758:	nopl   0x0(%rax,%rax,1)
  1e4760:	mov    0x58(%rsp),%r8
  1e4765:	inc    %r8
  1e4768:	cmp    0x78(%rsp),%r8
  1e476d:	mov    0x68(%rsp),%r9
  1e4772:	mov    0x40(%rsp),%r10
  1e4777:	je     1e4c5c <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x5ac>
  1e477d:	cmp    0x48(%rsp),%r8
  1e4782:	je     1e4ce1 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x631>
  1e4788:	mov    0x28(%rsp),%rdi
  1e478d:	mov    (%rdi,%r8,4),%edi
  1e4791:	cmp    %rdi,%rsi
  1e4794:	jbe    1e4c6e <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x5be>
  1e479a:	mov    %r8,0x58(%rsp)
  1e479f:	mov    %rdi,%r14
  1e47a2:	cmp    %rdi,%r15
  1e47a5:	mov    $0x0,%edi
  1e47aa:	cmovbe %r15,%rdi
  1e47ae:	mov    0x18(%rsp),%r8
  1e47b3:	cmova  0x20(%rsp),%r8
  1e47b9:	mov    %r8,0x50(%rsp)
  1e47be:	cmp    0x70(%rsp),%r10
  1e47c3:	jae    1e47f0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x140>
  1e47c5:	mov    %r10,%r8
  1e47c8:	shl    $0x4,%r8
  1e47cc:	mov    0x58(%rsp),%r11
  1e47d1:	cmp    %r11,(%r9,%r8,1)
  1e47d5:	jne    1e47f0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x140>
  1e47d7:	add    %r9,%r8
  1e47da:	mov    0x8(%r8),%r8
  1e47de:	inc    %r10
  1e47e1:	mov    %r10,0x40(%rsp)
  1e47e6:	jmp    1e47f8 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x148>
  1e47e8:	nopl   0x0(%rax,%rax,1)
  1e47f0:	mov    %r10,0x40(%rsp)
  1e47f5:	mov    %rbp,%r8
  1e47f8:	sub    %rdi,%r14
  1e47fb:	mov    %r8,0x60(%rsp)
  1e4800:	shr    $0x2,%r8
  1e4804:	mov    %r14,0x80(%rsp)
  1e480c:	je     1e4b50 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x4a0>
  1e4812:	lea    0x0(,%rbp,8),%rdi
  1e481a:	imul   %r14,%rdi
  1e481e:	mov    0x50(%rsp),%r9
  1e4823:	add    %rdi,%r9
  1e4826:	add    $0x18,%r9
  1e482a:	jmp    1e4849 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x199>
  1e482c:	nopl   0x0(%rax)
  1e4830:	mov    0x38(%rsp),%rdi
  1e4835:	incq   (%rdi,%r11,8)
  1e4839:	inc    %rax
  1e483c:	add    $0x20,%r9
  1e4840:	dec    %r8
  1e4843:	je     1e4b50 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x4a0>
  1e4849:	mov    (%rbx),%rdi
  1e484c:	movzbl (%rdi),%r10d
  1e4850:	shrx   %r10d,-0x18(%r9),%r10d
  1e4856:	and    0x8(%rdi),%r10d
  1e485a:	shr    $0x10,%r10d
  1e485e:	movzbl %r10b,%edi
  1e4862:	cmp    %rdi,%rcx
  1e4865:	jbe    1e4cbf <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x60f>
  1e486b:	mov    %edi,%r11d
  1e486e:	shl    $0x4,%r11d
  1e4872:	mov    (%rdx,%r11,1),%r14
  1e4876:	mov    -0x18(%r9),%r12
  1e487a:	lea    0x8(%r14),%r13
  1e487e:	cmp    0x8(%rdx,%r11,1),%r13
  1e4883:	mov    %r12,(%r14)
  1e4886:	mov    %r13,(%rdx,%r11,1)
  1e488a:	jne    1e490a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x25a>
  1e488c:	cmp    %rsi,%rax
  1e488f:	jae    1e4c9a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x5ea>
  1e4895:	mov    0x28(%rsp),%r14
  1e489a:	mov    (%r14,%rax,4),%r14d
  1e489e:	cmp    %r14,%rsi
  1e48a1:	jbe    1e4c6e <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x5be>
  1e48a7:	add    %rdx,%r11
  1e48aa:	cmp    %r14,%r15
  1e48ad:	mov    $0x0,%r12d
  1e48b3:	cmovbe %r15,%r12
  1e48b7:	mov    0x18(%rsp),%r13
  1e48bc:	cmova  0x20(%rsp),%r13
  1e48c2:	sub    %r12,%r14
  1e48c5:	imul   %rbp,%r14
  1e48c9:	lea    0x0(,%r14,8),%r14
  1e48d1:	add    %r13,%r14
  1e48d4:	lea    (%r14,%rbp,8),%r12
  1e48d8:	mov    %r14,(%r11)
  1e48db:	mov    %r12,0x8(%r11)
  1e48df:	cmp    0x8(%rsp),%rax
  1e48e4:	jae    1e4caa <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x5fa>
  1e48ea:	mov    0x30(%rsp),%r11
  1e48ef:	mov    %r10b,(%r11,%rax,1)
  1e48f3:	cmp    %rdi,0x10(%rsp)
  1e48f8:	jbe    1e4ccf <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x61f>
  1e48fe:	mov    0x38(%rsp),%r10
  1e4903:	incq   (%r10,%rdi,8)
  1e4907:	inc    %rax
  1e490a:	mov    (%rbx),%rdi
  1e490d:	movzbl (%rdi),%r10d
  1e4911:	shrx   %r10d,-0x10(%r9),%r10d
  1e4917:	and    0x8(%rdi),%r10d
  1e491b:	shr    $0x10,%r10d
  1e491f:	movzbl %r10b,%r11d
  1e4923:	cmp    %r11,%rcx
  1e4926:	jbe    1e4c87 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x5d7>
  1e492c:	mov    %r11d,%edi
  1e492f:	shl    $0x4,%edi
  1e4932:	mov    (%rdx,%rdi,1),%r14
  1e4936:	mov    -0x10(%r9),%r12
  1e493a:	lea    0x8(%r14),%r13
  1e493e:	cmp    0x8(%rdx,%rdi,1),%r13
  1e4943:	mov    %r12,(%r14)
  1e4946:	mov    %r13,(%rdx,%rdi,1)
  1e494a:	jne    1e49ca <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x31a>
  1e494c:	cmp    %rsi,%rax
  1e494f:	jae    1e4c9a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x5ea>
  1e4955:	mov    0x28(%rsp),%r14
  1e495a:	mov    (%r14,%rax,4),%r14d
  1e495e:	cmp    %r14,%rsi
  1e4961:	jbe    1e4c6e <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x5be>
  1e4967:	add    %rdx,%rdi
  1e496a:	cmp    %r14,%r15
  1e496d:	mov    $0x0,%r12d
  1e4973:	cmovbe %r15,%r12
  1e4977:	mov    0x18(%rsp),%r13
  1e497c:	cmova  0x20(%rsp),%r13
  1e4982:	sub    %r12,%r14
  1e4985:	imul   %rbp,%r14
  1e4989:	lea    0x0(,%r14,8),%r14
  1e4991:	add    %r13,%r14
  1e4994:	lea    (%r14,%rbp,8),%r12
  1e4998:	mov    %r14,(%rdi)
  1e499b:	mov    %r12,0x8(%rdi)
  1e499f:	cmp    0x8(%rsp),%rax
  1e49a4:	jae    1e4caa <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x5fa>
  1e49aa:	mov    0x30(%rsp),%rdi
  1e49af:	mov    %r10b,(%rdi,%rax,1)
  1e49b3:	cmp    %r11,0x10(%rsp)
  1e49b8:	jbe    1e4c47 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x597>
  1e49be:	mov    0x38(%rsp),%rdi
  1e49c3:	incq   (%rdi,%r11,8)
  1e49c7:	inc    %rax
  1e49ca:	mov    (%rbx),%rdi
  1e49cd:	movzbl (%rdi),%r10d
  1e49d1:	shrx   %r10d,-0x8(%r9),%r10d
  1e49d7:	and    0x8(%rdi),%r10d
  1e49db:	shr    $0x10,%r10d
  1e49df:	movzbl %r10b,%r11d
  1e49e3:	cmp    %r11,%rcx
  1e49e6:	jbe    1e4c87 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x5d7>
  1e49ec:	mov    %r11d,%edi
  1e49ef:	shl    $0x4,%edi
  1e49f2:	mov    (%rdx,%rdi,1),%r14
  1e49f6:	mov    -0x8(%r9),%r12
  1e49fa:	lea    0x8(%r14),%r13
  1e49fe:	cmp    0x8(%rdx,%rdi,1),%r13
  1e4a03:	mov    %r12,(%r14)
  1e4a06:	mov    %r13,(%rdx,%rdi,1)
  1e4a0a:	jne    1e4a8a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x3da>
  1e4a0c:	cmp    %rsi,%rax
  1e4a0f:	jae    1e4c9a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x5ea>
  1e4a15:	mov    0x28(%rsp),%r14
  1e4a1a:	mov    (%r14,%rax,4),%r14d
  1e4a1e:	cmp    %r14,%rsi
  1e4a21:	jbe    1e4c6e <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x5be>
  1e4a27:	add    %rdx,%rdi
  1e4a2a:	cmp    %r14,%r15
  1e4a2d:	mov    $0x0,%r12d
  1e4a33:	cmovbe %r15,%r12
  1e4a37:	mov    0x18(%rsp),%r13
  1e4a3c:	cmova  0x20(%rsp),%r13
  1e4a42:	sub    %r12,%r14
  1e4a45:	imul   %rbp,%r14
  1e4a49:	lea    0x0(,%r14,8),%r14
  1e4a51:	add    %r13,%r14
  1e4a54:	lea    (%r14,%rbp,8),%r12
  1e4a58:	mov    %r14,(%rdi)
  1e4a5b:	mov    %r12,0x8(%rdi)
  1e4a5f:	cmp    0x8(%rsp),%rax
  1e4a64:	jae    1e4caa <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x5fa>
  1e4a6a:	mov    0x30(%rsp),%rdi
  1e4a6f:	mov    %r10b,(%rdi,%rax,1)
  1e4a73:	cmp    %r11,0x10(%rsp)
  1e4a78:	jbe    1e4c47 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x597>
  1e4a7e:	mov    0x38(%rsp),%rdi
  1e4a83:	incq   (%rdi,%r11,8)
  1e4a87:	inc    %rax
  1e4a8a:	mov    (%rbx),%rdi
  1e4a8d:	movzbl (%rdi),%r10d
  1e4a91:	shrx   %r10d,(%r9),%r10d
  1e4a96:	and    0x8(%rdi),%r10d
  1e4a9a:	shr    $0x10,%r10d
  1e4a9e:	movzbl %r10b,%r11d
  1e4aa2:	cmp    %r11,%rcx
  1e4aa5:	jbe    1e4c87 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x5d7>
  1e4aab:	mov    %r11d,%edi
  1e4aae:	shl    $0x4,%edi
  1e4ab1:	mov    (%rdx,%rdi,1),%r14
  1e4ab5:	mov    (%r9),%r12
  1e4ab8:	lea    0x8(%r14),%r13
  1e4abc:	cmp    0x8(%rdx,%rdi,1),%r13
  1e4ac1:	mov    %r12,(%r14)
  1e4ac4:	mov    %r13,(%rdx,%rdi,1)
  1e4ac8:	jne    1e483c <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x18c>
  1e4ace:	cmp    %rsi,%rax
  1e4ad1:	jae    1e4c9a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x5ea>
  1e4ad7:	mov    0x28(%rsp),%r14
  1e4adc:	mov    (%r14,%rax,4),%r14d
  1e4ae0:	cmp    %r14,%rsi
  1e4ae3:	jbe    1e4c6e <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x5be>
  1e4ae9:	add    %rdx,%rdi
  1e4aec:	cmp    %r14,%r15
  1e4aef:	mov    $0x0,%r12d
  1e4af5:	cmovbe %r15,%r12
  1e4af9:	mov    0x18(%rsp),%r13
  1e4afe:	cmova  0x20(%rsp),%r13
  1e4b04:	sub    %r12,%r14
  1e4b07:	imul   %rbp,%r14
  1e4b0b:	lea    0x0(,%r14,8),%r14
  1e4b13:	add    %r13,%r14
  1e4b16:	lea    (%r14,%rbp,8),%r12
  1e4b1a:	mov    %r14,(%rdi)
  1e4b1d:	mov    %r12,0x8(%rdi)
  1e4b21:	cmp    0x8(%rsp),%rax
  1e4b26:	jae    1e4caa <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x5fa>
  1e4b2c:	mov    0x30(%rsp),%rdi
  1e4b31:	mov    %r10b,(%rdi,%rax,1)
  1e4b35:	cmp    %r11,0x10(%rsp)
  1e4b3a:	ja     1e4830 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x180>
  1e4b40:	jmp    1e4c47 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x597>
  1e4b45:	data16 cs nopw 0x0(%rax,%rax,1)
  1e4b50:	mov    0x60(%rsp),%r8
  1e4b55:	mov    %r8,%rdi
  1e4b58:	and    $0xfffffffffffffffc,%rdi
  1e4b5c:	cmp    %r8,%rdi
  1e4b5f:	je     1e4760 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0xb0>
  1e4b65:	mov    0x80(%rsp),%r8
  1e4b6d:	imul   %rbp,%r8
  1e4b71:	mov    0x50(%rsp),%r9
  1e4b76:	lea    (%r9,%r8,8),%r9
  1e4b7a:	jmp    1e4b9a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x4ea>
  1e4b7c:	nopl   0x0(%rax)
  1e4b80:	mov    0x38(%rsp),%r8
  1e4b85:	incq   (%r8,%r11,8)
  1e4b89:	inc    %rax
  1e4b8c:	inc    %rdi
  1e4b8f:	cmp    0x60(%rsp),%rdi
  1e4b94:	jae    1e4760 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0xb0>
  1e4b9a:	mov    (%rbx),%r8
  1e4b9d:	movzbl (%r8),%r10d
  1e4ba1:	shrx   %r10d,(%r9,%rdi,8),%r10d
  1e4ba7:	and    0x8(%r8),%r10d
  1e4bab:	shr    $0x10,%r10d
  1e4baf:	movzbl %r10b,%r11d
  1e4bb3:	cmp    %r11,%rcx
  1e4bb6:	jbe    1e4c87 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x5d7>
  1e4bbc:	mov    %r11d,%r8d
  1e4bbf:	shl    $0x4,%r8d
  1e4bc3:	mov    (%rdx,%r8,1),%r14
  1e4bc7:	mov    (%r9,%rdi,8),%r12
  1e4bcb:	lea    0x8(%r14),%r13
  1e4bcf:	cmp    0x8(%rdx,%r8,1),%r13
  1e4bd4:	mov    %r12,(%r14)
  1e4bd7:	mov    %r13,(%rdx,%r8,1)
  1e4bdb:	jne    1e4b8c <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x4dc>
  1e4bdd:	cmp    %rsi,%rax
  1e4be0:	jae    1e4c9a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x5ea>
  1e4be6:	mov    0x28(%rsp),%r14
  1e4beb:	mov    (%r14,%rax,4),%r14d
  1e4bef:	cmp    %r14,%rsi
  1e4bf2:	jbe    1e4c6e <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x5be>
  1e4bf4:	add    %rdx,%r8
  1e4bf7:	cmp    %r14,%r15
  1e4bfa:	mov    $0x0,%r12d
  1e4c00:	cmovbe %r15,%r12
  1e4c04:	mov    0x18(%rsp),%r13
  1e4c09:	cmova  0x20(%rsp),%r13
  1e4c0f:	sub    %r12,%r14
  1e4c12:	imul   %rbp,%r14
  1e4c16:	lea    0x0(,%r14,8),%r14
  1e4c1e:	add    %r13,%r14
  1e4c21:	lea    (%r14,%rbp,8),%r12
  1e4c25:	mov    %r14,(%r8)
  1e4c28:	mov    %r12,0x8(%r8)
  1e4c2c:	cmp    0x8(%rsp),%rax
  1e4c31:	jae    1e4caa <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x5fa>
  1e4c33:	mov    0x30(%rsp),%r8
  1e4c38:	mov    %r10b,(%r8,%rax,1)
  1e4c3c:	cmp    %r11,0x10(%rsp)
  1e4c41:	ja     1e4b80 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>+0x4d0>
  1e4c47:	lea    0x154cf2(%rip),%rdx        # 339940 <anon.0154b0ae4e43a031cafbc3dbea9bcf13.2.llvm.11444141577931038052+0x2e0>
  1e4c4e:	mov    %r11,%rdi
  1e4c51:	mov    0x10(%rsp),%rsi
  1e4c56:	call   *0x157f3c(%rip)        # 33cb98 <_DYNAMIC+0x278>
  1e4c5c:	add    $0x88,%rsp
  1e4c63:	pop    %rbx
  1e4c64:	pop    %r12
  1e4c66:	pop    %r13
  1e4c68:	pop    %r14
  1e4c6a:	pop    %r15
  1e4c6c:	pop    %rbp
  1e4c6d:	ret
  1e4c6e:	lea    -0x1cf6c2(%rip),%rdi        # 155b3 <anon.0154b0ae4e43a031cafbc3dbea9bcf13.0.llvm.11444141577931038052+0xf3>
  1e4c75:	lea    0x154d54(%rip),%rdx        # 3399d0 <anon.0154b0ae4e43a031cafbc3dbea9bcf13.2.llvm.11444141577931038052+0x370>
  1e4c7c:	mov    $0x2c,%esi
  1e4c81:	call   *0x157ff9(%rip)        # 33cc80 <_DYNAMIC+0x360>
  1e4c87:	lea    0x154c6a(%rip),%rdx        # 3398f8 <anon.0154b0ae4e43a031cafbc3dbea9bcf13.2.llvm.11444141577931038052+0x298>
  1e4c8e:	mov    %r11,%rdi
  1e4c91:	mov    %rcx,%rsi
  1e4c94:	call   *0x157efe(%rip)        # 33cb98 <_DYNAMIC+0x278>
  1e4c9a:	lea    0x154c6f(%rip),%rdx        # 339910 <anon.0154b0ae4e43a031cafbc3dbea9bcf13.2.llvm.11444141577931038052+0x2b0>
  1e4ca1:	mov    %rax,%rdi
  1e4ca4:	call   *0x157eee(%rip)        # 33cb98 <_DYNAMIC+0x278>
  1e4caa:	lea    0x154c77(%rip),%rdx        # 339928 <anon.0154b0ae4e43a031cafbc3dbea9bcf13.2.llvm.11444141577931038052+0x2c8>
  1e4cb1:	mov    %rax,%rdi
  1e4cb4:	mov    0x8(%rsp),%rsi
  1e4cb9:	call   *0x157ed9(%rip)        # 33cb98 <_DYNAMIC+0x278>
  1e4cbf:	lea    0x154c32(%rip),%rdx        # 3398f8 <anon.0154b0ae4e43a031cafbc3dbea9bcf13.2.llvm.11444141577931038052+0x298>
  1e4cc6:	mov    %rcx,%rsi
  1e4cc9:	call   *0x157ec9(%rip)        # 33cb98 <_DYNAMIC+0x278>
  1e4ccf:	lea    0x154c6a(%rip),%rdx        # 339940 <anon.0154b0ae4e43a031cafbc3dbea9bcf13.2.llvm.11444141577931038052+0x2e0>
  1e4cd6:	mov    0x10(%rsp),%rsi
  1e4cdb:	call   *0x157eb7(%rip)        # 33cb98 <_DYNAMIC+0x278>
  1e4ce1:	lea    0x154a20(%rip),%rdx        # 339708 <anon.0154b0ae4e43a031cafbc3dbea9bcf13.2.llvm.11444141577931038052+0xa8>
  1e4ce8:	mov    0x48(%rsp),%rdi
  1e4ced:	call   *0x157ea5(%rip)        # 33cb98 <_DYNAMIC+0x278>
