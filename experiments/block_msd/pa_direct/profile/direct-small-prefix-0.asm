
experiments/block_msd/target/pa-direct/time:     file format elf64-x86-64


Disassembly of section .text:

0000000000203740 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>>:
  203740:	push   %rbp
  203741:	push   %r15
  203743:	push   %r14
  203745:	push   %r13
  203747:	push   %r12
  203749:	push   %rbx
  20374a:	sub    $0x88,%rsp
  203751:	mov    %r9,0x10(%rsp)
  203756:	mov    %r8,0x38(%rsp)
  20375b:	mov    %rsi,%r11
  20375e:	mov    0x80(%rdi),%rax
  203765:	mov    0xa8(%rdi),%rsi
  20376c:	mov    %rsi,0x70(%rsp)
  203771:	cmp    %rsi,%rax
  203774:	jae    203cee <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x5ae>
  20377a:	mov    0x20(%rdi),%rsi
  20377e:	mov    %rsi,0x28(%rsp)
  203783:	mov    0x28(%rdi),%rsi
  203787:	mov    0x88(%rdi),%r12
  20378e:	mov    0xa0(%rdi),%r8
  203795:	mov    %r8,0x20(%rsp)
  20379a:	mov    0x90(%rdi),%r8
  2037a1:	mov    %r8,0x18(%rsp)
  2037a6:	mov    0x78(%rdi),%r14
  2037aa:	mov    0x70(%rdi),%r8
  2037ae:	mov    %r8,0x68(%rsp)
  2037b3:	mov    0x68(%rdi),%r9
  2037b7:	mov    0x58(%rdi),%r8
  2037bb:	mov    %r8,0x8(%rsp)
  2037c0:	mov    0x50(%rdi),%rdi
  2037c4:	mov    %rdi,0x30(%rsp)
  2037c9:	cmp    %rsi,%rax
  2037cc:	mov    %rsi,%rdi
  2037cf:	cmova  %rax,%rdi
  2037d3:	mov    %rdi,0x48(%rsp)
  2037d8:	xor    %r8d,%r8d
  2037db:	mov    %rax,%rdi
  2037de:	mov    %r9,0x60(%rsp)
  2037e3:	jmp    203810 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0xd0>
  2037e5:	data16 cs nopw 0x0(%rax,%rax,1)
  2037f0:	mov    0x58(%rsp),%rdi
  2037f5:	inc    %rdi
  2037f8:	cmp    0x70(%rsp),%rdi
  2037fd:	mov    0x60(%rsp),%r9
  203802:	mov    0x80(%rsp),%r8
  20380a:	je     203cee <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x5ae>
  203810:	cmp    0x48(%rsp),%rdi
  203815:	je     203db3 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x673>
  20381b:	mov    %rdi,%r10
  20381e:	mov    0x28(%rsp),%rdi
  203823:	mov    (%rdi,%r10,4),%edi
  203827:	cmp    %rdi,%rsi
  20382a:	jbe    203d00 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x5c0>
  203830:	mov    %r10,0x58(%rsp)
  203835:	mov    %rdi,%r15
  203838:	cmp    %rdi,%r12
  20383b:	mov    $0x0,%edi
  203840:	cmovbe %r12,%rdi
  203844:	mov    0x18(%rsp),%r10
  203849:	cmova  0x20(%rsp),%r10
  20384f:	mov    %r10,0x50(%rsp)
  203854:	cmp    0x68(%rsp),%r8
  203859:	jae    203880 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x140>
  20385b:	mov    %r8,%r10
  20385e:	shl    $0x4,%r8
  203862:	mov    0x58(%rsp),%rbx
  203867:	cmp    %rbx,(%r9,%r8,1)
  20386b:	jne    203890 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x150>
  20386d:	add    %r9,%r8
  203870:	mov    0x8(%r8),%rbx
  203874:	inc    %r10
  203877:	jmp    203893 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x153>
  203879:	nopl   0x0(%rax)
  203880:	mov    %r14,%rbx
  203883:	jmp    203896 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x156>
  203885:	data16 cs nopw 0x0(%rax,%rax,1)
  203890:	mov    %r14,%rbx
  203893:	mov    %r10,%r8
  203896:	mov    %r8,0x80(%rsp)
  20389e:	sub    %rdi,%r15
  2038a1:	mov    %rbx,0x40(%rsp)
  2038a6:	mov    %rbx,%rdi
  2038a9:	shr    $0x2,%rdi
  2038ad:	mov    %r15,0x78(%rsp)
  2038b2:	je     203bf0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x4b0>
  2038b8:	lea    0x0(,%r14,8),%r8
  2038c0:	imul   %r15,%r8
  2038c4:	mov    0x50(%rsp),%r9
  2038c9:	add    %r8,%r9
  2038cc:	add    $0x18,%r9
  2038d0:	jmp    2038fc <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x1bc>
  2038d2:	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  2038e0:	mov    0x38(%rsp),%r8
  2038e5:	incq   (%r8,%rbx,8)
  2038e9:	inc    %rax
  2038ec:	dec    %rdi
  2038ef:	add    $0x20,%r9
  2038f3:	test   %rdi,%rdi
  2038f6:	je     203bf0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x4b0>
  2038fc:	mov    (%r11),%r8
  2038ff:	movzbl (%r8),%r10d
  203903:	shrx   %r10d,-0x18(%r9),%r10d
  203909:	and    0x8(%r8),%r10d
  20390d:	movzbl %r10b,%ebx
  203911:	cmp    %rbx,%rcx
  203914:	jbe    203d19 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x5d9>
  20391a:	mov    %ebx,%r8d
  20391d:	shl    $0x4,%r8d
  203921:	mov    (%rdx,%r8,1),%r15
  203925:	mov    -0x18(%r9),%r13
  203929:	lea    0x8(%r15),%rbp
  20392d:	cmp    0x8(%rdx,%r8,1),%rbp
  203932:	mov    %r13,(%r15)
  203935:	mov    %rbp,(%rdx,%r8,1)
  203939:	jne    2039b9 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x279>
  20393b:	cmp    %rsi,%rax
  20393e:	jae    203d2c <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x5ec>
  203944:	mov    0x28(%rsp),%r15
  203949:	mov    (%r15,%rax,4),%r15d
  20394d:	cmp    %r15,%rsi
  203950:	jbe    203d00 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x5c0>
  203956:	add    %rdx,%r8
  203959:	cmp    %r15,%r12
  20395c:	mov    $0x0,%r13d
  203962:	cmovbe %r12,%r13
  203966:	mov    0x18(%rsp),%rbp
  20396b:	cmova  0x20(%rsp),%rbp
  203971:	sub    %r13,%r15
  203974:	imul   %r14,%r15
  203978:	lea    0x0(,%r15,8),%r15
  203980:	add    %rbp,%r15
  203983:	lea    (%r15,%r14,8),%r13
  203987:	mov    %r15,(%r8)
  20398a:	mov    %r13,0x8(%r8)
  20398e:	cmp    0x8(%rsp),%rax
  203993:	jae    203d3c <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x5fc>
  203999:	mov    0x30(%rsp),%r8
  20399e:	mov    %r10b,(%r8,%rax,1)
  2039a2:	cmp    %rbx,0x10(%rsp)
  2039a7:	jbe    203d51 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x611>
  2039ad:	mov    0x38(%rsp),%r8
  2039b2:	incq   (%r8,%rbx,8)
  2039b6:	inc    %rax
  2039b9:	mov    (%r11),%r8
  2039bc:	movzbl (%r8),%r10d
  2039c0:	shrx   %r10d,-0x10(%r9),%r10d
  2039c6:	and    0x8(%r8),%r10d
  2039ca:	movzbl %r10b,%ebx
  2039ce:	cmp    %rbx,%rcx
  2039d1:	jbe    203d19 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x5d9>
  2039d7:	mov    %ebx,%r8d
  2039da:	shl    $0x4,%r8d
  2039de:	mov    (%rdx,%r8,1),%r15
  2039e2:	mov    -0x10(%r9),%r13
  2039e6:	lea    0x8(%r15),%rbp
  2039ea:	cmp    0x8(%rdx,%r8,1),%rbp
  2039ef:	mov    %r13,(%r15)
  2039f2:	mov    %rbp,(%rdx,%r8,1)
  2039f6:	jne    203a76 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x336>
  2039f8:	cmp    %rsi,%rax
  2039fb:	jae    203d2c <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x5ec>
  203a01:	mov    0x28(%rsp),%r15
  203a06:	mov    (%r15,%rax,4),%r15d
  203a0a:	cmp    %r15,%rsi
  203a0d:	jbe    203d00 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x5c0>
  203a13:	add    %rdx,%r8
  203a16:	cmp    %r15,%r12
  203a19:	mov    $0x0,%r13d
  203a1f:	cmovbe %r12,%r13
  203a23:	mov    0x18(%rsp),%rbp
  203a28:	cmova  0x20(%rsp),%rbp
  203a2e:	sub    %r13,%r15
  203a31:	imul   %r14,%r15
  203a35:	lea    0x0(,%r15,8),%r15
  203a3d:	add    %rbp,%r15
  203a40:	lea    (%r15,%r14,8),%r13
  203a44:	mov    %r15,(%r8)
  203a47:	mov    %r13,0x8(%r8)
  203a4b:	cmp    0x8(%rsp),%rax
  203a50:	jae    203d3c <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x5fc>
  203a56:	mov    0x30(%rsp),%r8
  203a5b:	mov    %r10b,(%r8,%rax,1)
  203a5f:	cmp    %rbx,0x10(%rsp)
  203a64:	jbe    203d51 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x611>
  203a6a:	mov    0x38(%rsp),%r8
  203a6f:	incq   (%r8,%rbx,8)
  203a73:	inc    %rax
  203a76:	mov    (%r11),%r8
  203a79:	movzbl (%r8),%r10d
  203a7d:	shrx   %r10d,-0x8(%r9),%r10d
  203a83:	and    0x8(%r8),%r10d
  203a87:	movzbl %r10b,%ebx
  203a8b:	cmp    %rbx,%rcx
  203a8e:	jbe    203d19 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x5d9>
  203a94:	mov    %ebx,%r8d
  203a97:	shl    $0x4,%r8d
  203a9b:	mov    (%rdx,%r8,1),%r15
  203a9f:	mov    -0x8(%r9),%r13
  203aa3:	lea    0x8(%r15),%rbp
  203aa7:	cmp    0x8(%rdx,%r8,1),%rbp
  203aac:	mov    %r13,(%r15)
  203aaf:	mov    %rbp,(%rdx,%r8,1)
  203ab3:	jne    203b33 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x3f3>
  203ab5:	cmp    %rsi,%rax
  203ab8:	jae    203d2c <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x5ec>
  203abe:	mov    0x28(%rsp),%r15
  203ac3:	mov    (%r15,%rax,4),%r15d
  203ac7:	cmp    %r15,%rsi
  203aca:	jbe    203d00 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x5c0>
  203ad0:	add    %rdx,%r8
  203ad3:	cmp    %r15,%r12
  203ad6:	mov    $0x0,%r13d
  203adc:	cmovbe %r12,%r13
  203ae0:	mov    0x18(%rsp),%rbp
  203ae5:	cmova  0x20(%rsp),%rbp
  203aeb:	sub    %r13,%r15
  203aee:	imul   %r14,%r15
  203af2:	lea    0x0(,%r15,8),%r15
  203afa:	add    %rbp,%r15
  203afd:	lea    (%r15,%r14,8),%r13
  203b01:	mov    %r15,(%r8)
  203b04:	mov    %r13,0x8(%r8)
  203b08:	cmp    0x8(%rsp),%rax
  203b0d:	jae    203d3c <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x5fc>
  203b13:	mov    0x30(%rsp),%r8
  203b18:	mov    %r10b,(%r8,%rax,1)
  203b1c:	cmp    %rbx,0x10(%rsp)
  203b21:	jbe    203d51 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x611>
  203b27:	mov    0x38(%rsp),%r8
  203b2c:	incq   (%r8,%rbx,8)
  203b30:	inc    %rax
  203b33:	mov    (%r11),%r8
  203b36:	movzbl (%r8),%r10d
  203b3a:	shrx   %r10d,(%r9),%r10d
  203b3f:	and    0x8(%r8),%r10d
  203b43:	movzbl %r10b,%ebx
  203b47:	cmp    %rbx,%rcx
  203b4a:	jbe    203d19 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x5d9>
  203b50:	mov    %ebx,%r8d
  203b53:	shl    $0x4,%r8d
  203b57:	mov    (%rdx,%r8,1),%r15
  203b5b:	mov    (%r9),%r13
  203b5e:	lea    0x8(%r15),%rbp
  203b62:	cmp    0x8(%rdx,%r8,1),%rbp
  203b67:	mov    %r13,(%r15)
  203b6a:	mov    %rbp,(%rdx,%r8,1)
  203b6e:	jne    2038ec <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x1ac>
  203b74:	cmp    %rsi,%rax
  203b77:	jae    203d2c <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x5ec>
  203b7d:	mov    0x28(%rsp),%r15
  203b82:	mov    (%r15,%rax,4),%r15d
  203b86:	cmp    %r15,%rsi
  203b89:	jbe    203d00 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x5c0>
  203b8f:	add    %rdx,%r8
  203b92:	cmp    %r15,%r12
  203b95:	mov    $0x0,%r13d
  203b9b:	cmovbe %r12,%r13
  203b9f:	mov    0x18(%rsp),%rbp
  203ba4:	cmova  0x20(%rsp),%rbp
  203baa:	sub    %r13,%r15
  203bad:	imul   %r14,%r15
  203bb1:	lea    0x0(,%r15,8),%r15
  203bb9:	add    %rbp,%r15
  203bbc:	lea    (%r15,%r14,8),%r13
  203bc0:	mov    %r15,(%r8)
  203bc3:	mov    %r13,0x8(%r8)
  203bc7:	cmp    0x8(%rsp),%rax
  203bcc:	jae    203d3c <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x5fc>
  203bd2:	mov    0x30(%rsp),%r8
  203bd7:	mov    %r10b,(%r8,%rax,1)
  203bdb:	cmp    %rbx,0x10(%rsp)
  203be0:	ja     2038e0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x1a0>
  203be6:	jmp    203d51 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x611>
  203beb:	nopl   0x0(%rax,%rax,1)
  203bf0:	mov    0x40(%rsp),%r8
  203bf5:	mov    %r8,%rdi
  203bf8:	and    $0xfffffffffffffffc,%rdi
  203bfc:	cmp    %r8,%rdi
  203bff:	je     2037f0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0xb0>
  203c05:	mov    0x78(%rsp),%r8
  203c0a:	imul   %r14,%r8
  203c0e:	mov    0x50(%rsp),%r9
  203c13:	lea    (%r9,%r8,8),%r9
  203c17:	jmp    203c31 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x4f1>
  203c19:	nopl   0x0(%rax)
  203c20:	mov    0x40(%rsp),%r8
  203c25:	inc    %rdi
  203c28:	cmp    %r8,%rdi
  203c2b:	jae    2037f0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0xb0>
  203c31:	mov    (%r11),%r8
  203c34:	movzbl (%r8),%r10d
  203c38:	shrx   %r10d,(%r9,%rdi,8),%r10d
  203c3e:	and    0x8(%r8),%r10d
  203c42:	movzbl %r10b,%r8d
  203c46:	cmp    %r8,%rcx
  203c49:	jbe    203d66 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x626>
  203c4f:	mov    %r8d,%ebx
  203c52:	shl    $0x4,%ebx
  203c55:	mov    (%rdx,%rbx,1),%r15
  203c59:	mov    (%r9,%rdi,8),%r13
  203c5d:	lea    0x8(%r15),%rbp
  203c61:	cmp    0x8(%rdx,%rbx,1),%rbp
  203c66:	mov    %r13,(%r15)
  203c69:	mov    %rbp,(%rdx,%rbx,1)
  203c6d:	jne    203c20 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x4e0>
  203c6f:	cmp    %rsi,%rax
  203c72:	jae    203d79 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x639>
  203c78:	mov    0x28(%rsp),%r15
  203c7d:	mov    (%r15,%rax,4),%r15d
  203c81:	cmp    %r15,%rsi
  203c84:	jbe    203d00 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x5c0>
  203c86:	add    %rdx,%rbx
  203c89:	cmp    %r15,%r12
  203c8c:	mov    $0x0,%r13d
  203c92:	cmovbe %r12,%r13
  203c96:	mov    0x18(%rsp),%rbp
  203c9b:	cmova  0x20(%rsp),%rbp
  203ca1:	sub    %r13,%r15
  203ca4:	imul   %r14,%r15
  203ca8:	lea    0x0(,%r15,8),%r15
  203cb0:	add    %rbp,%r15
  203cb3:	lea    (%r15,%r14,8),%r13
  203cb7:	mov    %r15,(%rbx)
  203cba:	mov    %r13,0x8(%rbx)
  203cbe:	cmp    0x8(%rsp),%rax
  203cc3:	jae    203d89 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x649>
  203cc9:	mov    0x30(%rsp),%rbx
  203cce:	mov    %r10b,(%rbx,%rax,1)
  203cd2:	cmp    %r8,0x10(%rsp)
  203cd7:	jbe    203d9e <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x65e>
  203cdd:	mov    0x38(%rsp),%r10
  203ce2:	incq   (%r10,%r8,8)
  203ce6:	inc    %rax
  203ce9:	jmp    203c20 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 0>+0x4e0>
  203cee:	add    $0x88,%rsp
  203cf5:	pop    %rbx
  203cf6:	pop    %r12
  203cf8:	pop    %r13
  203cfa:	pop    %r14
  203cfc:	pop    %r15
  203cfe:	pop    %rbp
  203cff:	ret
  203d00:	lea    -0x1edcd7(%rip),%rdi        # 16030 <anon.7fa33eb33931318ee6b6568b4abff869.3.llvm.17153750559840045314+0xf3>
  203d07:	lea    0x1daa9a(%rip),%rdx        # 3de7a8 <anon.7fa33eb33931318ee6b6568b4abff869.4.llvm.17153750559840045314+0x3b8>
  203d0e:	mov    $0x2c,%esi
  203d13:	call   *0x1dd86f(%rip)        # 3e1588 <_DYNAMIC+0x2f0>
  203d19:	lea    0x1da718(%rip),%rdx        # 3de438 <anon.7fa33eb33931318ee6b6568b4abff869.4.llvm.17153750559840045314+0x48>
  203d20:	mov    %rbx,%rdi
  203d23:	mov    %rcx,%rsi
  203d26:	call   *0x1dd7ec(%rip)        # 3e1518 <_DYNAMIC+0x280>
  203d2c:	lea    0x1da705(%rip),%rdx        # 3de438 <anon.7fa33eb33931318ee6b6568b4abff869.4.llvm.17153750559840045314+0x48>
  203d33:	mov    %rax,%rdi
  203d36:	call   *0x1dd7dc(%rip)        # 3e1518 <_DYNAMIC+0x280>
  203d3c:	lea    0x1da6f5(%rip),%rdx        # 3de438 <anon.7fa33eb33931318ee6b6568b4abff869.4.llvm.17153750559840045314+0x48>
  203d43:	mov    %rax,%rdi
  203d46:	mov    0x8(%rsp),%rsi
  203d4b:	call   *0x1dd7c7(%rip)        # 3e1518 <_DYNAMIC+0x280>
  203d51:	lea    0x1da6e0(%rip),%rdx        # 3de438 <anon.7fa33eb33931318ee6b6568b4abff869.4.llvm.17153750559840045314+0x48>
  203d58:	mov    %rbx,%rdi
  203d5b:	mov    0x10(%rsp),%rsi
  203d60:	call   *0x1dd7b2(%rip)        # 3e1518 <_DYNAMIC+0x280>
  203d66:	lea    0x1da6b3(%rip),%rdx        # 3de420 <anon.7fa33eb33931318ee6b6568b4abff869.4.llvm.17153750559840045314+0x30>
  203d6d:	mov    %r8,%rdi
  203d70:	mov    %rcx,%rsi
  203d73:	call   *0x1dd79f(%rip)        # 3e1518 <_DYNAMIC+0x280>
  203d79:	lea    0x1da6a0(%rip),%rdx        # 3de420 <anon.7fa33eb33931318ee6b6568b4abff869.4.llvm.17153750559840045314+0x30>
  203d80:	mov    %rax,%rdi
  203d83:	call   *0x1dd78f(%rip)        # 3e1518 <_DYNAMIC+0x280>
  203d89:	lea    0x1da690(%rip),%rdx        # 3de420 <anon.7fa33eb33931318ee6b6568b4abff869.4.llvm.17153750559840045314+0x30>
  203d90:	mov    %rax,%rdi
  203d93:	mov    0x8(%rsp),%rsi
  203d98:	call   *0x1dd77a(%rip)        # 3e1518 <_DYNAMIC+0x280>
  203d9e:	lea    0x1da67b(%rip),%rdx        # 3de420 <anon.7fa33eb33931318ee6b6568b4abff869.4.llvm.17153750559840045314+0x30>
  203da5:	mov    %r8,%rdi
  203da8:	mov    0x10(%rsp),%rsi
  203dad:	call   *0x1dd765(%rip)        # 3e1518 <_DYNAMIC+0x280>
  203db3:	lea    0x1da64e(%rip),%rdx        # 3de408 <anon.7fa33eb33931318ee6b6568b4abff869.4.llvm.17153750559840045314+0x18>
  203dba:	mov    0x48(%rsp),%rdi
  203dbf:	call   *0x1dd753(%rip)        # 3e1518 <_DYNAMIC+0x280>
