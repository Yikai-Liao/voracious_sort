
experiments/block_msd/target/pa-outline/time:     file format elf64-x86-64


Disassembly of section .text:

00000000001e4060 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>>:
  1e4060:	push   %rbp
  1e4061:	push   %r15
  1e4063:	push   %r14
  1e4065:	push   %r13
  1e4067:	push   %r12
  1e4069:	push   %rbx
  1e406a:	sub    $0x88,%rsp
  1e4071:	mov    %r9,0x10(%rsp)
  1e4076:	mov    %r8,0x38(%rsp)
  1e407b:	mov    %rsi,%r10
  1e407e:	mov    0x80(%rdi),%rax
  1e4085:	mov    0xa8(%rdi),%rsi
  1e408c:	mov    %rsi,0x78(%rsp)
  1e4091:	cmp    %rsi,%rax
  1e4094:	jae    1e460c <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x5ac>
  1e409a:	mov    0x20(%rdi),%rsi
  1e409e:	mov    %rsi,0x28(%rsp)
  1e40a3:	mov    0x28(%rdi),%rsi
  1e40a7:	mov    0x88(%rdi),%r15
  1e40ae:	mov    0xa0(%rdi),%r8
  1e40b5:	mov    %r8,0x20(%rsp)
  1e40ba:	mov    0x90(%rdi),%r8
  1e40c1:	mov    %r8,0x18(%rsp)
  1e40c6:	mov    0x78(%rdi),%rbp
  1e40ca:	mov    0x70(%rdi),%r8
  1e40ce:	mov    %r8,0x70(%rsp)
  1e40d3:	mov    0x68(%rdi),%r9
  1e40d7:	mov    (%r10),%rbx
  1e40da:	mov    0x58(%rdi),%r8
  1e40de:	mov    %r8,0x8(%rsp)
  1e40e3:	mov    0x50(%rdi),%rdi
  1e40e7:	mov    %rdi,0x30(%rsp)
  1e40ec:	cmp    %rsi,%rax
  1e40ef:	mov    %rsi,%rdi
  1e40f2:	cmova  %rax,%rdi
  1e40f6:	mov    %rdi,0x48(%rsp)
  1e40fb:	xor    %r10d,%r10d
  1e40fe:	mov    %rax,%r8
  1e4101:	mov    %r9,0x68(%rsp)
  1e4106:	jmp    1e412d <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0xcd>
  1e4108:	nopl   0x0(%rax,%rax,1)
  1e4110:	mov    0x58(%rsp),%r8
  1e4115:	inc    %r8
  1e4118:	cmp    0x78(%rsp),%r8
  1e411d:	mov    0x68(%rsp),%r9
  1e4122:	mov    0x40(%rsp),%r10
  1e4127:	je     1e460c <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x5ac>
  1e412d:	cmp    0x48(%rsp),%r8
  1e4132:	je     1e4691 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x631>
  1e4138:	mov    0x28(%rsp),%rdi
  1e413d:	mov    (%rdi,%r8,4),%edi
  1e4141:	cmp    %rdi,%rsi
  1e4144:	jbe    1e461e <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x5be>
  1e414a:	mov    %r8,0x58(%rsp)
  1e414f:	mov    %rdi,%r14
  1e4152:	cmp    %rdi,%r15
  1e4155:	mov    $0x0,%edi
  1e415a:	cmovbe %r15,%rdi
  1e415e:	mov    0x18(%rsp),%r8
  1e4163:	cmova  0x20(%rsp),%r8
  1e4169:	mov    %r8,0x50(%rsp)
  1e416e:	cmp    0x70(%rsp),%r10
  1e4173:	jae    1e41a0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x140>
  1e4175:	mov    %r10,%r8
  1e4178:	shl    $0x4,%r8
  1e417c:	mov    0x58(%rsp),%r11
  1e4181:	cmp    %r11,(%r9,%r8,1)
  1e4185:	jne    1e41a0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x140>
  1e4187:	add    %r9,%r8
  1e418a:	mov    0x8(%r8),%r8
  1e418e:	inc    %r10
  1e4191:	mov    %r10,0x40(%rsp)
  1e4196:	jmp    1e41a8 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x148>
  1e4198:	nopl   0x0(%rax,%rax,1)
  1e41a0:	mov    %r10,0x40(%rsp)
  1e41a5:	mov    %rbp,%r8
  1e41a8:	sub    %rdi,%r14
  1e41ab:	mov    %r8,0x60(%rsp)
  1e41b0:	shr    $0x2,%r8
  1e41b4:	mov    %r14,0x80(%rsp)
  1e41bc:	je     1e4500 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x4a0>
  1e41c2:	lea    0x0(,%rbp,8),%rdi
  1e41ca:	imul   %r14,%rdi
  1e41ce:	mov    0x50(%rsp),%r9
  1e41d3:	add    %rdi,%r9
  1e41d6:	add    $0x18,%r9
  1e41da:	jmp    1e41f9 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x199>
  1e41dc:	nopl   0x0(%rax)
  1e41e0:	mov    0x38(%rsp),%rdi
  1e41e5:	incq   (%rdi,%r11,8)
  1e41e9:	inc    %rax
  1e41ec:	add    $0x20,%r9
  1e41f0:	dec    %r8
  1e41f3:	je     1e4500 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x4a0>
  1e41f9:	mov    (%rbx),%rdi
  1e41fc:	movzbl (%rdi),%r10d
  1e4200:	shrx   %r10d,-0x18(%r9),%r10d
  1e4206:	and    0x8(%rdi),%r10d
  1e420a:	shr    $0x8,%r10d
  1e420e:	movzbl %r10b,%edi
  1e4212:	cmp    %rdi,%rcx
  1e4215:	jbe    1e466f <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x60f>
  1e421b:	mov    %edi,%r11d
  1e421e:	shl    $0x4,%r11d
  1e4222:	mov    (%rdx,%r11,1),%r14
  1e4226:	mov    -0x18(%r9),%r12
  1e422a:	lea    0x8(%r14),%r13
  1e422e:	cmp    0x8(%rdx,%r11,1),%r13
  1e4233:	mov    %r12,(%r14)
  1e4236:	mov    %r13,(%rdx,%r11,1)
  1e423a:	jne    1e42ba <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x25a>
  1e423c:	cmp    %rsi,%rax
  1e423f:	jae    1e464a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x5ea>
  1e4245:	mov    0x28(%rsp),%r14
  1e424a:	mov    (%r14,%rax,4),%r14d
  1e424e:	cmp    %r14,%rsi
  1e4251:	jbe    1e461e <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x5be>
  1e4257:	add    %rdx,%r11
  1e425a:	cmp    %r14,%r15
  1e425d:	mov    $0x0,%r12d
  1e4263:	cmovbe %r15,%r12
  1e4267:	mov    0x18(%rsp),%r13
  1e426c:	cmova  0x20(%rsp),%r13
  1e4272:	sub    %r12,%r14
  1e4275:	imul   %rbp,%r14
  1e4279:	lea    0x0(,%r14,8),%r14
  1e4281:	add    %r13,%r14
  1e4284:	lea    (%r14,%rbp,8),%r12
  1e4288:	mov    %r14,(%r11)
  1e428b:	mov    %r12,0x8(%r11)
  1e428f:	cmp    0x8(%rsp),%rax
  1e4294:	jae    1e465a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x5fa>
  1e429a:	mov    0x30(%rsp),%r11
  1e429f:	mov    %r10b,(%r11,%rax,1)
  1e42a3:	cmp    %rdi,0x10(%rsp)
  1e42a8:	jbe    1e467f <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x61f>
  1e42ae:	mov    0x38(%rsp),%r10
  1e42b3:	incq   (%r10,%rdi,8)
  1e42b7:	inc    %rax
  1e42ba:	mov    (%rbx),%rdi
  1e42bd:	movzbl (%rdi),%r10d
  1e42c1:	shrx   %r10d,-0x10(%r9),%r10d
  1e42c7:	and    0x8(%rdi),%r10d
  1e42cb:	shr    $0x8,%r10d
  1e42cf:	movzbl %r10b,%r11d
  1e42d3:	cmp    %r11,%rcx
  1e42d6:	jbe    1e4637 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x5d7>
  1e42dc:	mov    %r11d,%edi
  1e42df:	shl    $0x4,%edi
  1e42e2:	mov    (%rdx,%rdi,1),%r14
  1e42e6:	mov    -0x10(%r9),%r12
  1e42ea:	lea    0x8(%r14),%r13
  1e42ee:	cmp    0x8(%rdx,%rdi,1),%r13
  1e42f3:	mov    %r12,(%r14)
  1e42f6:	mov    %r13,(%rdx,%rdi,1)
  1e42fa:	jne    1e437a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x31a>
  1e42fc:	cmp    %rsi,%rax
  1e42ff:	jae    1e464a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x5ea>
  1e4305:	mov    0x28(%rsp),%r14
  1e430a:	mov    (%r14,%rax,4),%r14d
  1e430e:	cmp    %r14,%rsi
  1e4311:	jbe    1e461e <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x5be>
  1e4317:	add    %rdx,%rdi
  1e431a:	cmp    %r14,%r15
  1e431d:	mov    $0x0,%r12d
  1e4323:	cmovbe %r15,%r12
  1e4327:	mov    0x18(%rsp),%r13
  1e432c:	cmova  0x20(%rsp),%r13
  1e4332:	sub    %r12,%r14
  1e4335:	imul   %rbp,%r14
  1e4339:	lea    0x0(,%r14,8),%r14
  1e4341:	add    %r13,%r14
  1e4344:	lea    (%r14,%rbp,8),%r12
  1e4348:	mov    %r14,(%rdi)
  1e434b:	mov    %r12,0x8(%rdi)
  1e434f:	cmp    0x8(%rsp),%rax
  1e4354:	jae    1e465a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x5fa>
  1e435a:	mov    0x30(%rsp),%rdi
  1e435f:	mov    %r10b,(%rdi,%rax,1)
  1e4363:	cmp    %r11,0x10(%rsp)
  1e4368:	jbe    1e45f7 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x597>
  1e436e:	mov    0x38(%rsp),%rdi
  1e4373:	incq   (%rdi,%r11,8)
  1e4377:	inc    %rax
  1e437a:	mov    (%rbx),%rdi
  1e437d:	movzbl (%rdi),%r10d
  1e4381:	shrx   %r10d,-0x8(%r9),%r10d
  1e4387:	and    0x8(%rdi),%r10d
  1e438b:	shr    $0x8,%r10d
  1e438f:	movzbl %r10b,%r11d
  1e4393:	cmp    %r11,%rcx
  1e4396:	jbe    1e4637 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x5d7>
  1e439c:	mov    %r11d,%edi
  1e439f:	shl    $0x4,%edi
  1e43a2:	mov    (%rdx,%rdi,1),%r14
  1e43a6:	mov    -0x8(%r9),%r12
  1e43aa:	lea    0x8(%r14),%r13
  1e43ae:	cmp    0x8(%rdx,%rdi,1),%r13
  1e43b3:	mov    %r12,(%r14)
  1e43b6:	mov    %r13,(%rdx,%rdi,1)
  1e43ba:	jne    1e443a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x3da>
  1e43bc:	cmp    %rsi,%rax
  1e43bf:	jae    1e464a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x5ea>
  1e43c5:	mov    0x28(%rsp),%r14
  1e43ca:	mov    (%r14,%rax,4),%r14d
  1e43ce:	cmp    %r14,%rsi
  1e43d1:	jbe    1e461e <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x5be>
  1e43d7:	add    %rdx,%rdi
  1e43da:	cmp    %r14,%r15
  1e43dd:	mov    $0x0,%r12d
  1e43e3:	cmovbe %r15,%r12
  1e43e7:	mov    0x18(%rsp),%r13
  1e43ec:	cmova  0x20(%rsp),%r13
  1e43f2:	sub    %r12,%r14
  1e43f5:	imul   %rbp,%r14
  1e43f9:	lea    0x0(,%r14,8),%r14
  1e4401:	add    %r13,%r14
  1e4404:	lea    (%r14,%rbp,8),%r12
  1e4408:	mov    %r14,(%rdi)
  1e440b:	mov    %r12,0x8(%rdi)
  1e440f:	cmp    0x8(%rsp),%rax
  1e4414:	jae    1e465a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x5fa>
  1e441a:	mov    0x30(%rsp),%rdi
  1e441f:	mov    %r10b,(%rdi,%rax,1)
  1e4423:	cmp    %r11,0x10(%rsp)
  1e4428:	jbe    1e45f7 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x597>
  1e442e:	mov    0x38(%rsp),%rdi
  1e4433:	incq   (%rdi,%r11,8)
  1e4437:	inc    %rax
  1e443a:	mov    (%rbx),%rdi
  1e443d:	movzbl (%rdi),%r10d
  1e4441:	shrx   %r10d,(%r9),%r10d
  1e4446:	and    0x8(%rdi),%r10d
  1e444a:	shr    $0x8,%r10d
  1e444e:	movzbl %r10b,%r11d
  1e4452:	cmp    %r11,%rcx
  1e4455:	jbe    1e4637 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x5d7>
  1e445b:	mov    %r11d,%edi
  1e445e:	shl    $0x4,%edi
  1e4461:	mov    (%rdx,%rdi,1),%r14
  1e4465:	mov    (%r9),%r12
  1e4468:	lea    0x8(%r14),%r13
  1e446c:	cmp    0x8(%rdx,%rdi,1),%r13
  1e4471:	mov    %r12,(%r14)
  1e4474:	mov    %r13,(%rdx,%rdi,1)
  1e4478:	jne    1e41ec <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x18c>
  1e447e:	cmp    %rsi,%rax
  1e4481:	jae    1e464a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x5ea>
  1e4487:	mov    0x28(%rsp),%r14
  1e448c:	mov    (%r14,%rax,4),%r14d
  1e4490:	cmp    %r14,%rsi
  1e4493:	jbe    1e461e <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x5be>
  1e4499:	add    %rdx,%rdi
  1e449c:	cmp    %r14,%r15
  1e449f:	mov    $0x0,%r12d
  1e44a5:	cmovbe %r15,%r12
  1e44a9:	mov    0x18(%rsp),%r13
  1e44ae:	cmova  0x20(%rsp),%r13
  1e44b4:	sub    %r12,%r14
  1e44b7:	imul   %rbp,%r14
  1e44bb:	lea    0x0(,%r14,8),%r14
  1e44c3:	add    %r13,%r14
  1e44c6:	lea    (%r14,%rbp,8),%r12
  1e44ca:	mov    %r14,(%rdi)
  1e44cd:	mov    %r12,0x8(%rdi)
  1e44d1:	cmp    0x8(%rsp),%rax
  1e44d6:	jae    1e465a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x5fa>
  1e44dc:	mov    0x30(%rsp),%rdi
  1e44e1:	mov    %r10b,(%rdi,%rax,1)
  1e44e5:	cmp    %r11,0x10(%rsp)
  1e44ea:	ja     1e41e0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x180>
  1e44f0:	jmp    1e45f7 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x597>
  1e44f5:	data16 cs nopw 0x0(%rax,%rax,1)
  1e4500:	mov    0x60(%rsp),%r8
  1e4505:	mov    %r8,%rdi
  1e4508:	and    $0xfffffffffffffffc,%rdi
  1e450c:	cmp    %r8,%rdi
  1e450f:	je     1e4110 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0xb0>
  1e4515:	mov    0x80(%rsp),%r8
  1e451d:	imul   %rbp,%r8
  1e4521:	mov    0x50(%rsp),%r9
  1e4526:	lea    (%r9,%r8,8),%r9
  1e452a:	jmp    1e454a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x4ea>
  1e452c:	nopl   0x0(%rax)
  1e4530:	mov    0x38(%rsp),%r8
  1e4535:	incq   (%r8,%r11,8)
  1e4539:	inc    %rax
  1e453c:	inc    %rdi
  1e453f:	cmp    0x60(%rsp),%rdi
  1e4544:	jae    1e4110 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0xb0>
  1e454a:	mov    (%rbx),%r8
  1e454d:	movzbl (%r8),%r10d
  1e4551:	shrx   %r10d,(%r9,%rdi,8),%r10d
  1e4557:	and    0x8(%r8),%r10d
  1e455b:	shr    $0x8,%r10d
  1e455f:	movzbl %r10b,%r11d
  1e4563:	cmp    %r11,%rcx
  1e4566:	jbe    1e4637 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x5d7>
  1e456c:	mov    %r11d,%r8d
  1e456f:	shl    $0x4,%r8d
  1e4573:	mov    (%rdx,%r8,1),%r14
  1e4577:	mov    (%r9,%rdi,8),%r12
  1e457b:	lea    0x8(%r14),%r13
  1e457f:	cmp    0x8(%rdx,%r8,1),%r13
  1e4584:	mov    %r12,(%r14)
  1e4587:	mov    %r13,(%rdx,%r8,1)
  1e458b:	jne    1e453c <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x4dc>
  1e458d:	cmp    %rsi,%rax
  1e4590:	jae    1e464a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x5ea>
  1e4596:	mov    0x28(%rsp),%r14
  1e459b:	mov    (%r14,%rax,4),%r14d
  1e459f:	cmp    %r14,%rsi
  1e45a2:	jbe    1e461e <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x5be>
  1e45a4:	add    %rdx,%r8
  1e45a7:	cmp    %r14,%r15
  1e45aa:	mov    $0x0,%r12d
  1e45b0:	cmovbe %r15,%r12
  1e45b4:	mov    0x18(%rsp),%r13
  1e45b9:	cmova  0x20(%rsp),%r13
  1e45bf:	sub    %r12,%r14
  1e45c2:	imul   %rbp,%r14
  1e45c6:	lea    0x0(,%r14,8),%r14
  1e45ce:	add    %r13,%r14
  1e45d1:	lea    (%r14,%rbp,8),%r12
  1e45d5:	mov    %r14,(%r8)
  1e45d8:	mov    %r12,0x8(%r8)
  1e45dc:	cmp    0x8(%rsp),%rax
  1e45e1:	jae    1e465a <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x5fa>
  1e45e3:	mov    0x30(%rsp),%r8
  1e45e8:	mov    %r10b,(%r8,%rax,1)
  1e45ec:	cmp    %r11,0x10(%rsp)
  1e45f1:	ja     1e4530 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>+0x4d0>
  1e45f7:	lea    0x155342(%rip),%rdx        # 339940 <anon.0154b0ae4e43a031cafbc3dbea9bcf13.2.llvm.11444141577931038052+0x2e0>
  1e45fe:	mov    %r11,%rdi
  1e4601:	mov    0x10(%rsp),%rsi
  1e4606:	call   *0x15858c(%rip)        # 33cb98 <_DYNAMIC+0x278>
  1e460c:	add    $0x88,%rsp
  1e4613:	pop    %rbx
  1e4614:	pop    %r12
  1e4616:	pop    %r13
  1e4618:	pop    %r14
  1e461a:	pop    %r15
  1e461c:	pop    %rbp
  1e461d:	ret
  1e461e:	lea    -0x1cf072(%rip),%rdi        # 155b3 <anon.0154b0ae4e43a031cafbc3dbea9bcf13.0.llvm.11444141577931038052+0xf3>
  1e4625:	lea    0x1553a4(%rip),%rdx        # 3399d0 <anon.0154b0ae4e43a031cafbc3dbea9bcf13.2.llvm.11444141577931038052+0x370>
  1e462c:	mov    $0x2c,%esi
  1e4631:	call   *0x158649(%rip)        # 33cc80 <_DYNAMIC+0x360>
  1e4637:	lea    0x1552ba(%rip),%rdx        # 3398f8 <anon.0154b0ae4e43a031cafbc3dbea9bcf13.2.llvm.11444141577931038052+0x298>
  1e463e:	mov    %r11,%rdi
  1e4641:	mov    %rcx,%rsi
  1e4644:	call   *0x15854e(%rip)        # 33cb98 <_DYNAMIC+0x278>
  1e464a:	lea    0x1552bf(%rip),%rdx        # 339910 <anon.0154b0ae4e43a031cafbc3dbea9bcf13.2.llvm.11444141577931038052+0x2b0>
  1e4651:	mov    %rax,%rdi
  1e4654:	call   *0x15853e(%rip)        # 33cb98 <_DYNAMIC+0x278>
  1e465a:	lea    0x1552c7(%rip),%rdx        # 339928 <anon.0154b0ae4e43a031cafbc3dbea9bcf13.2.llvm.11444141577931038052+0x2c8>
  1e4661:	mov    %rax,%rdi
  1e4664:	mov    0x8(%rsp),%rsi
  1e4669:	call   *0x158529(%rip)        # 33cb98 <_DYNAMIC+0x278>
  1e466f:	lea    0x155282(%rip),%rdx        # 3398f8 <anon.0154b0ae4e43a031cafbc3dbea9bcf13.2.llvm.11444141577931038052+0x298>
  1e4676:	mov    %rcx,%rsi
  1e4679:	call   *0x158519(%rip)        # 33cb98 <_DYNAMIC+0x278>
  1e467f:	lea    0x1552ba(%rip),%rdx        # 339940 <anon.0154b0ae4e43a031cafbc3dbea9bcf13.2.llvm.11444141577931038052+0x2e0>
  1e4686:	mov    0x10(%rsp),%rsi
  1e468b:	call   *0x158507(%rip)        # 33cb98 <_DYNAMIC+0x278>
  1e4691:	lea    0x155070(%rip),%rdx        # 339708 <anon.0154b0ae4e43a031cafbc3dbea9bcf13.2.llvm.11444141577931038052+0xa8>
  1e4698:	mov    0x48(%rsp),%rdi
  1e469d:	call   *0x1584f5(%rip)        # 33cb98 <_DYNAMIC+0x278>
