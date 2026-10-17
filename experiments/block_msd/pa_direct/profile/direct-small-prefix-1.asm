
experiments/block_msd/target/pa-direct/time:     file format elf64-x86-64


Disassembly of section .text:

0000000000203dd0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>>:
  203dd0:	push   %rbp
  203dd1:	push   %r15
  203dd3:	push   %r14
  203dd5:	push   %r13
  203dd7:	push   %r12
  203dd9:	push   %rbx
  203dda:	sub    $0x88,%rsp
  203de1:	mov    %r9,0x10(%rsp)
  203de6:	mov    %r8,0x38(%rsp)
  203deb:	mov    %rsi,%r11
  203dee:	mov    0x80(%rdi),%rax
  203df5:	mov    0xa8(%rdi),%rsi
  203dfc:	mov    %rsi,0x70(%rsp)
  203e01:	cmp    %rsi,%rax
  203e04:	jae    204392 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x5c2>
  203e0a:	mov    0x20(%rdi),%rsi
  203e0e:	mov    %rsi,0x28(%rsp)
  203e13:	mov    0x28(%rdi),%rsi
  203e17:	mov    0x88(%rdi),%r12
  203e1e:	mov    0xa0(%rdi),%r8
  203e25:	mov    %r8,0x20(%rsp)
  203e2a:	mov    0x90(%rdi),%r8
  203e31:	mov    %r8,0x18(%rsp)
  203e36:	mov    0x78(%rdi),%r14
  203e3a:	mov    0x70(%rdi),%r8
  203e3e:	mov    %r8,0x68(%rsp)
  203e43:	mov    0x68(%rdi),%r9
  203e47:	mov    0x58(%rdi),%r8
  203e4b:	mov    %r8,0x8(%rsp)
  203e50:	mov    0x50(%rdi),%rdi
  203e54:	mov    %rdi,0x30(%rsp)
  203e59:	cmp    %rsi,%rax
  203e5c:	mov    %rsi,%rdi
  203e5f:	cmova  %rax,%rdi
  203e63:	mov    %rdi,0x48(%rsp)
  203e68:	xor    %r8d,%r8d
  203e6b:	mov    %rax,%rdi
  203e6e:	mov    %r9,0x60(%rsp)
  203e73:	jmp    203ea0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0xd0>
  203e75:	data16 cs nopw 0x0(%rax,%rax,1)
  203e80:	mov    0x58(%rsp),%rdi
  203e85:	inc    %rdi
  203e88:	cmp    0x70(%rsp),%rdi
  203e8d:	mov    0x60(%rsp),%r9
  203e92:	mov    0x80(%rsp),%r8
  203e9a:	je     204392 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x5c2>
  203ea0:	cmp    0x48(%rsp),%rdi
  203ea5:	je     204457 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x687>
  203eab:	mov    %rdi,%r10
  203eae:	mov    0x28(%rsp),%rdi
  203eb3:	mov    (%rdi,%r10,4),%edi
  203eb7:	cmp    %rdi,%rsi
  203eba:	jbe    2043a4 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x5d4>
  203ec0:	mov    %r10,0x58(%rsp)
  203ec5:	mov    %rdi,%r15
  203ec8:	cmp    %rdi,%r12
  203ecb:	mov    $0x0,%edi
  203ed0:	cmovbe %r12,%rdi
  203ed4:	mov    0x18(%rsp),%r10
  203ed9:	cmova  0x20(%rsp),%r10
  203edf:	mov    %r10,0x50(%rsp)
  203ee4:	cmp    0x68(%rsp),%r8
  203ee9:	jae    203f10 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x140>
  203eeb:	mov    %r8,%r10
  203eee:	shl    $0x4,%r8
  203ef2:	mov    0x58(%rsp),%rbx
  203ef7:	cmp    %rbx,(%r9,%r8,1)
  203efb:	jne    203f20 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x150>
  203efd:	add    %r9,%r8
  203f00:	mov    0x8(%r8),%rbx
  203f04:	inc    %r10
  203f07:	jmp    203f23 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x153>
  203f09:	nopl   0x0(%rax)
  203f10:	mov    %r14,%rbx
  203f13:	jmp    203f26 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x156>
  203f15:	data16 cs nopw 0x0(%rax,%rax,1)
  203f20:	mov    %r14,%rbx
  203f23:	mov    %r10,%r8
  203f26:	mov    %r8,0x80(%rsp)
  203f2e:	sub    %rdi,%r15
  203f31:	mov    %rbx,0x40(%rsp)
  203f36:	mov    %rbx,%rdi
  203f39:	shr    $0x2,%rdi
  203f3d:	mov    %r15,0x78(%rsp)
  203f42:	je     204290 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x4c0>
  203f48:	lea    0x0(,%r14,8),%r8
  203f50:	imul   %r15,%r8
  203f54:	mov    0x50(%rsp),%r9
  203f59:	add    %r8,%r9
  203f5c:	add    $0x18,%r9
  203f60:	jmp    203f8c <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x1bc>
  203f62:	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  203f70:	mov    0x38(%rsp),%r8
  203f75:	incq   (%r8,%rbx,8)
  203f79:	inc    %rax
  203f7c:	dec    %rdi
  203f7f:	add    $0x20,%r9
  203f83:	test   %rdi,%rdi
  203f86:	je     204290 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x4c0>
  203f8c:	mov    (%r11),%r8
  203f8f:	movzbl (%r8),%r10d
  203f93:	shrx   %r10d,-0x18(%r9),%r10d
  203f99:	and    0x8(%r8),%r10d
  203f9d:	shr    $0x8,%r10d
  203fa1:	movzbl %r10b,%ebx
  203fa5:	cmp    %rbx,%rcx
  203fa8:	jbe    2043bd <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x5ed>
  203fae:	mov    %ebx,%r8d
  203fb1:	shl    $0x4,%r8d
  203fb5:	mov    (%rdx,%r8,1),%r15
  203fb9:	mov    -0x18(%r9),%r13
  203fbd:	lea    0x8(%r15),%rbp
  203fc1:	cmp    0x8(%rdx,%r8,1),%rbp
  203fc6:	mov    %r13,(%r15)
  203fc9:	mov    %rbp,(%rdx,%r8,1)
  203fcd:	jne    20404d <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x27d>
  203fcf:	cmp    %rsi,%rax
  203fd2:	jae    2043d0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x600>
  203fd8:	mov    0x28(%rsp),%r15
  203fdd:	mov    (%r15,%rax,4),%r15d
  203fe1:	cmp    %r15,%rsi
  203fe4:	jbe    2043a4 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x5d4>
  203fea:	add    %rdx,%r8
  203fed:	cmp    %r15,%r12
  203ff0:	mov    $0x0,%r13d
  203ff6:	cmovbe %r12,%r13
  203ffa:	mov    0x18(%rsp),%rbp
  203fff:	cmova  0x20(%rsp),%rbp
  204005:	sub    %r13,%r15
  204008:	imul   %r14,%r15
  20400c:	lea    0x0(,%r15,8),%r15
  204014:	add    %rbp,%r15
  204017:	lea    (%r15,%r14,8),%r13
  20401b:	mov    %r15,(%r8)
  20401e:	mov    %r13,0x8(%r8)
  204022:	cmp    0x8(%rsp),%rax
  204027:	jae    2043e0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x610>
  20402d:	mov    0x30(%rsp),%r8
  204032:	mov    %r10b,(%r8,%rax,1)
  204036:	cmp    %rbx,0x10(%rsp)
  20403b:	jbe    2043f5 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x625>
  204041:	mov    0x38(%rsp),%r8
  204046:	incq   (%r8,%rbx,8)
  20404a:	inc    %rax
  20404d:	mov    (%r11),%r8
  204050:	movzbl (%r8),%r10d
  204054:	shrx   %r10d,-0x10(%r9),%r10d
  20405a:	and    0x8(%r8),%r10d
  20405e:	shr    $0x8,%r10d
  204062:	movzbl %r10b,%ebx
  204066:	cmp    %rbx,%rcx
  204069:	jbe    2043bd <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x5ed>
  20406f:	mov    %ebx,%r8d
  204072:	shl    $0x4,%r8d
  204076:	mov    (%rdx,%r8,1),%r15
  20407a:	mov    -0x10(%r9),%r13
  20407e:	lea    0x8(%r15),%rbp
  204082:	cmp    0x8(%rdx,%r8,1),%rbp
  204087:	mov    %r13,(%r15)
  20408a:	mov    %rbp,(%rdx,%r8,1)
  20408e:	jne    20410e <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x33e>
  204090:	cmp    %rsi,%rax
  204093:	jae    2043d0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x600>
  204099:	mov    0x28(%rsp),%r15
  20409e:	mov    (%r15,%rax,4),%r15d
  2040a2:	cmp    %r15,%rsi
  2040a5:	jbe    2043a4 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x5d4>
  2040ab:	add    %rdx,%r8
  2040ae:	cmp    %r15,%r12
  2040b1:	mov    $0x0,%r13d
  2040b7:	cmovbe %r12,%r13
  2040bb:	mov    0x18(%rsp),%rbp
  2040c0:	cmova  0x20(%rsp),%rbp
  2040c6:	sub    %r13,%r15
  2040c9:	imul   %r14,%r15
  2040cd:	lea    0x0(,%r15,8),%r15
  2040d5:	add    %rbp,%r15
  2040d8:	lea    (%r15,%r14,8),%r13
  2040dc:	mov    %r15,(%r8)
  2040df:	mov    %r13,0x8(%r8)
  2040e3:	cmp    0x8(%rsp),%rax
  2040e8:	jae    2043e0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x610>
  2040ee:	mov    0x30(%rsp),%r8
  2040f3:	mov    %r10b,(%r8,%rax,1)
  2040f7:	cmp    %rbx,0x10(%rsp)
  2040fc:	jbe    2043f5 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x625>
  204102:	mov    0x38(%rsp),%r8
  204107:	incq   (%r8,%rbx,8)
  20410b:	inc    %rax
  20410e:	mov    (%r11),%r8
  204111:	movzbl (%r8),%r10d
  204115:	shrx   %r10d,-0x8(%r9),%r10d
  20411b:	and    0x8(%r8),%r10d
  20411f:	shr    $0x8,%r10d
  204123:	movzbl %r10b,%ebx
  204127:	cmp    %rbx,%rcx
  20412a:	jbe    2043bd <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x5ed>
  204130:	mov    %ebx,%r8d
  204133:	shl    $0x4,%r8d
  204137:	mov    (%rdx,%r8,1),%r15
  20413b:	mov    -0x8(%r9),%r13
  20413f:	lea    0x8(%r15),%rbp
  204143:	cmp    0x8(%rdx,%r8,1),%rbp
  204148:	mov    %r13,(%r15)
  20414b:	mov    %rbp,(%rdx,%r8,1)
  20414f:	jne    2041cf <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x3ff>
  204151:	cmp    %rsi,%rax
  204154:	jae    2043d0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x600>
  20415a:	mov    0x28(%rsp),%r15
  20415f:	mov    (%r15,%rax,4),%r15d
  204163:	cmp    %r15,%rsi
  204166:	jbe    2043a4 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x5d4>
  20416c:	add    %rdx,%r8
  20416f:	cmp    %r15,%r12
  204172:	mov    $0x0,%r13d
  204178:	cmovbe %r12,%r13
  20417c:	mov    0x18(%rsp),%rbp
  204181:	cmova  0x20(%rsp),%rbp
  204187:	sub    %r13,%r15
  20418a:	imul   %r14,%r15
  20418e:	lea    0x0(,%r15,8),%r15
  204196:	add    %rbp,%r15
  204199:	lea    (%r15,%r14,8),%r13
  20419d:	mov    %r15,(%r8)
  2041a0:	mov    %r13,0x8(%r8)
  2041a4:	cmp    0x8(%rsp),%rax
  2041a9:	jae    2043e0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x610>
  2041af:	mov    0x30(%rsp),%r8
  2041b4:	mov    %r10b,(%r8,%rax,1)
  2041b8:	cmp    %rbx,0x10(%rsp)
  2041bd:	jbe    2043f5 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x625>
  2041c3:	mov    0x38(%rsp),%r8
  2041c8:	incq   (%r8,%rbx,8)
  2041cc:	inc    %rax
  2041cf:	mov    (%r11),%r8
  2041d2:	movzbl (%r8),%r10d
  2041d6:	shrx   %r10d,(%r9),%r10d
  2041db:	and    0x8(%r8),%r10d
  2041df:	shr    $0x8,%r10d
  2041e3:	movzbl %r10b,%ebx
  2041e7:	cmp    %rbx,%rcx
  2041ea:	jbe    2043bd <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x5ed>
  2041f0:	mov    %ebx,%r8d
  2041f3:	shl    $0x4,%r8d
  2041f7:	mov    (%rdx,%r8,1),%r15
  2041fb:	mov    (%r9),%r13
  2041fe:	lea    0x8(%r15),%rbp
  204202:	cmp    0x8(%rdx,%r8,1),%rbp
  204207:	mov    %r13,(%r15)
  20420a:	mov    %rbp,(%rdx,%r8,1)
  20420e:	jne    203f7c <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x1ac>
  204214:	cmp    %rsi,%rax
  204217:	jae    2043d0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x600>
  20421d:	mov    0x28(%rsp),%r15
  204222:	mov    (%r15,%rax,4),%r15d
  204226:	cmp    %r15,%rsi
  204229:	jbe    2043a4 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x5d4>
  20422f:	add    %rdx,%r8
  204232:	cmp    %r15,%r12
  204235:	mov    $0x0,%r13d
  20423b:	cmovbe %r12,%r13
  20423f:	mov    0x18(%rsp),%rbp
  204244:	cmova  0x20(%rsp),%rbp
  20424a:	sub    %r13,%r15
  20424d:	imul   %r14,%r15
  204251:	lea    0x0(,%r15,8),%r15
  204259:	add    %rbp,%r15
  20425c:	lea    (%r15,%r14,8),%r13
  204260:	mov    %r15,(%r8)
  204263:	mov    %r13,0x8(%r8)
  204267:	cmp    0x8(%rsp),%rax
  20426c:	jae    2043e0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x610>
  204272:	mov    0x30(%rsp),%r8
  204277:	mov    %r10b,(%r8,%rax,1)
  20427b:	cmp    %rbx,0x10(%rsp)
  204280:	ja     203f70 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x1a0>
  204286:	jmp    2043f5 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x625>
  20428b:	nopl   0x0(%rax,%rax,1)
  204290:	mov    0x40(%rsp),%r8
  204295:	mov    %r8,%rdi
  204298:	and    $0xfffffffffffffffc,%rdi
  20429c:	cmp    %r8,%rdi
  20429f:	je     203e80 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0xb0>
  2042a5:	mov    0x78(%rsp),%r8
  2042aa:	imul   %r14,%r8
  2042ae:	mov    0x50(%rsp),%r9
  2042b3:	lea    (%r9,%r8,8),%r9
  2042b7:	jmp    2042d1 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x501>
  2042b9:	nopl   0x0(%rax)
  2042c0:	mov    0x40(%rsp),%r8
  2042c5:	inc    %rdi
  2042c8:	cmp    %r8,%rdi
  2042cb:	jae    203e80 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0xb0>
  2042d1:	mov    (%r11),%r8
  2042d4:	movzbl (%r8),%r10d
  2042d8:	shrx   %r10d,(%r9,%rdi,8),%r10d
  2042de:	and    0x8(%r8),%r10d
  2042e2:	shr    $0x8,%r10d
  2042e6:	movzbl %r10b,%r8d
  2042ea:	cmp    %r8,%rcx
  2042ed:	jbe    20440a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x63a>
  2042f3:	mov    %r8d,%ebx
  2042f6:	shl    $0x4,%ebx
  2042f9:	mov    (%rdx,%rbx,1),%r15
  2042fd:	mov    (%r9,%rdi,8),%r13
  204301:	lea    0x8(%r15),%rbp
  204305:	cmp    0x8(%rdx,%rbx,1),%rbp
  20430a:	mov    %r13,(%r15)
  20430d:	mov    %rbp,(%rdx,%rbx,1)
  204311:	jne    2042c0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x4f0>
  204313:	cmp    %rsi,%rax
  204316:	jae    20441d <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x64d>
  20431c:	mov    0x28(%rsp),%r15
  204321:	mov    (%r15,%rax,4),%r15d
  204325:	cmp    %r15,%rsi
  204328:	jbe    2043a4 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x5d4>
  20432a:	add    %rdx,%rbx
  20432d:	cmp    %r15,%r12
  204330:	mov    $0x0,%r13d
  204336:	cmovbe %r12,%r13
  20433a:	mov    0x18(%rsp),%rbp
  20433f:	cmova  0x20(%rsp),%rbp
  204345:	sub    %r13,%r15
  204348:	imul   %r14,%r15
  20434c:	lea    0x0(,%r15,8),%r15
  204354:	add    %rbp,%r15
  204357:	lea    (%r15,%r14,8),%r13
  20435b:	mov    %r15,(%rbx)
  20435e:	mov    %r13,0x8(%rbx)
  204362:	cmp    0x8(%rsp),%rax
  204367:	jae    20442d <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x65d>
  20436d:	mov    0x30(%rsp),%rbx
  204372:	mov    %r10b,(%rbx,%rax,1)
  204376:	cmp    %r8,0x10(%rsp)
  20437b:	jbe    204442 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x672>
  204381:	mov    0x38(%rsp),%r10
  204386:	incq   (%r10,%r8,8)
  20438a:	inc    %rax
  20438d:	jmp    2042c0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_direct::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}, 1>+0x4f0>
  204392:	add    $0x88,%rsp
  204399:	pop    %rbx
  20439a:	pop    %r12
  20439c:	pop    %r13
  20439e:	pop    %r14
  2043a0:	pop    %r15
  2043a2:	pop    %rbp
  2043a3:	ret
  2043a4:	lea    -0x1ee37b(%rip),%rdi        # 16030 <anon.7fa33eb33931318ee6b6568b4abff869.3.llvm.17153750559840045314+0xf3>
  2043ab:	lea    0x1da3f6(%rip),%rdx        # 3de7a8 <anon.7fa33eb33931318ee6b6568b4abff869.4.llvm.17153750559840045314+0x3b8>
  2043b2:	mov    $0x2c,%esi
  2043b7:	call   *0x1dd1cb(%rip)        # 3e1588 <_DYNAMIC+0x2f0>
  2043bd:	lea    0x1da074(%rip),%rdx        # 3de438 <anon.7fa33eb33931318ee6b6568b4abff869.4.llvm.17153750559840045314+0x48>
  2043c4:	mov    %rbx,%rdi
  2043c7:	mov    %rcx,%rsi
  2043ca:	call   *0x1dd148(%rip)        # 3e1518 <_DYNAMIC+0x280>
  2043d0:	lea    0x1da061(%rip),%rdx        # 3de438 <anon.7fa33eb33931318ee6b6568b4abff869.4.llvm.17153750559840045314+0x48>
  2043d7:	mov    %rax,%rdi
  2043da:	call   *0x1dd138(%rip)        # 3e1518 <_DYNAMIC+0x280>
  2043e0:	lea    0x1da051(%rip),%rdx        # 3de438 <anon.7fa33eb33931318ee6b6568b4abff869.4.llvm.17153750559840045314+0x48>
  2043e7:	mov    %rax,%rdi
  2043ea:	mov    0x8(%rsp),%rsi
  2043ef:	call   *0x1dd123(%rip)        # 3e1518 <_DYNAMIC+0x280>
  2043f5:	lea    0x1da03c(%rip),%rdx        # 3de438 <anon.7fa33eb33931318ee6b6568b4abff869.4.llvm.17153750559840045314+0x48>
  2043fc:	mov    %rbx,%rdi
  2043ff:	mov    0x10(%rsp),%rsi
  204404:	call   *0x1dd10e(%rip)        # 3e1518 <_DYNAMIC+0x280>
  20440a:	lea    0x1da00f(%rip),%rdx        # 3de420 <anon.7fa33eb33931318ee6b6568b4abff869.4.llvm.17153750559840045314+0x30>
  204411:	mov    %r8,%rdi
  204414:	mov    %rcx,%rsi
  204417:	call   *0x1dd0fb(%rip)        # 3e1518 <_DYNAMIC+0x280>
  20441d:	lea    0x1d9ffc(%rip),%rdx        # 3de420 <anon.7fa33eb33931318ee6b6568b4abff869.4.llvm.17153750559840045314+0x30>
  204424:	mov    %rax,%rdi
  204427:	call   *0x1dd0eb(%rip)        # 3e1518 <_DYNAMIC+0x280>
  20442d:	lea    0x1d9fec(%rip),%rdx        # 3de420 <anon.7fa33eb33931318ee6b6568b4abff869.4.llvm.17153750559840045314+0x30>
  204434:	mov    %rax,%rdi
  204437:	mov    0x8(%rsp),%rsi
  20443c:	call   *0x1dd0d6(%rip)        # 3e1518 <_DYNAMIC+0x280>
  204442:	lea    0x1d9fd7(%rip),%rdx        # 3de420 <anon.7fa33eb33931318ee6b6568b4abff869.4.llvm.17153750559840045314+0x30>
  204449:	mov    %r8,%rdi
  20444c:	mov    0x10(%rsp),%rsi
  204451:	call   *0x1dd0c1(%rip)        # 3e1518 <_DYNAMIC+0x280>
  204457:	lea    0x1d9faa(%rip),%rdx        # 3de408 <anon.7fa33eb33931318ee6b6568b4abff869.4.llvm.17153750559840045314+0x18>
  20445e:	mov    0x48(%rsp),%rdi
  204463:	call   *0x1dd0af(%rip)        # 3e1518 <_DYNAMIC+0x280>
