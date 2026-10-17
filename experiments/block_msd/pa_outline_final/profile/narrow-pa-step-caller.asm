
experiments/block_msd/target/pa-outline/time:     file format elf64-x86-64


Disassembly of section .text:

00000000001f2180 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>>:
  1f2180:	push   %rbp
  1f2181:	push   %r15
  1f2183:	push   %r14
  1f2185:	push   %r13
  1f2187:	push   %r12
  1f2189:	push   %rbx
  1f218a:	sub    $0x88,%rsp
  1f2191:	mov    %rsi,%r13
  1f2194:	mov    0x80(%rdi),%r14
  1f219b:	mov    %r14,%r12
  1f219e:	shl    $0x4,%r12
  1f21a2:	mov    %r14,%rax
  1f21a5:	shr    $0x3c,%rax
  1f21a9:	setne  %al
  1f21ac:	movabs $0x7ffffffffffffff8,%rsi
  1f21b6:	cmp    %rsi,%r12
  1f21b9:	seta   %sil
  1f21bd:	or     %al,%sil
  1f21c0:	je     1f21cd <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x4d>
  1f21c2:	xor    %edi,%edi
  1f21c4:	mov    %r12,%rsi
  1f21c7:	call   *0x14aa9b(%rip)        # 33cc68 <_DYNAMIC+0x348>
  1f21cd:	mov    %rdi,%r15
  1f21d0:	mov    %rdx,0x40(%rsp)
  1f21d5:	test   %r12,%r12
  1f21d8:	je     1f2251 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xd1>
  1f21da:	mov    %ecx,%ebp
  1f21dc:	mov    %r8d,%ebx
  1f21df:	call   *0x14a9c3(%rip)        # 33cba8 <_DYNAMIC+0x288>
  1f21e5:	mov    %r12,%rdi
  1f21e8:	call   *0x14a9c2(%rip)        # 33cbb0 <malloc@GLIBC_2.2.5>
  1f21ee:	mov    %rax,0x8(%rsp)
  1f21f3:	test   %rax,%rax
  1f21f6:	je     1f2be3 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xa63>
  1f21fc:	movzbl 0x14cce5(%rip),%eax        # 33eee8 <frontier_experiment::TRACK>
  1f2203:	test   %al,%al
  1f2205:	je     1f2245 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xc5>
  1f2207:	lock incq 0x14cce1(%rip)        # 33eef0 <frontier_experiment::ALLOCS>
  1f220f:	lock add %r12,0x14cce1(%rip)        # 33eef8 <frontier_experiment::REQUESTED>
  1f2217:	mov    %r12,%rcx
  1f221a:	lock xadd %rcx,0x14ccb5(%rip)        # 33eed8 <frontier_experiment::LIVE>
  1f2223:	add    %r12,%rcx
  1f2226:	mov    0x14ccb3(%rip),%rax        # 33eee0 <frontier_experiment::PEAK>
  1f222d:	nopl   (%rax)
  1f2230:	cmp    %rcx,%rax
  1f2233:	mov    %rcx,%rdx
  1f2236:	cmova  %rax,%rdx
  1f223a:	lock cmpxchg %rdx,0x14cc9d(%rip)        # 33eee0 <frontier_experiment::PEAK>
  1f2243:	jne    1f2230 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xb0>
  1f2245:	mov    %r14,0x28(%rsp)
  1f224a:	mov    %ebx,%r8d
  1f224d:	mov    %ebp,%ecx
  1f224f:	jmp    1f2264 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xe4>
  1f2251:	mov    $0x8,%eax
  1f2256:	mov    %rax,0x8(%rsp)
  1f225b:	movq   $0x0,0x28(%rsp)
  1f2264:	cmp    $0x2,%r14
  1f2268:	mov    %r15,0x30(%rsp)
  1f226d:	mov    %r14,0x20(%rsp)
  1f2272:	mov    %r8d,0x48(%rsp)
  1f2277:	mov    %ecx,0x50(%rsp)
  1f227b:	jb     1f229c <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x11c>
  1f227d:	lea    -0x10(%r12),%rdx
  1f2282:	mov    0x8(%rsp),%rbx
  1f2287:	mov    %rbx,%rdi
  1f228a:	xor    %esi,%esi
  1f228c:	call   *0x14a9be(%rip)        # 33cc50 <memset@GLIBC_2.2.5>
  1f2292:	lea    (%rbx,%r12,1),%rax
  1f2296:	add    $0xfffffffffffffff0,%rax
  1f229a:	jmp    1f22aa <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x12a>
  1f229c:	mov    0x8(%rsp),%rax
  1f22a1:	test   %r14,%r14
  1f22a4:	je     1f2854 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x6d4>
  1f22aa:	lea    0x0(,%r14,8),%rbx
  1f22b2:	vxorps %xmm0,%xmm0,%xmm0
  1f22b6:	vmovups %xmm0,(%rax)
  1f22ba:	call   *0x14a8e8(%rip)        # 33cba8 <_DYNAMIC+0x288>
  1f22c0:	mov    %rbx,%rdi
  1f22c3:	call   *0x14a8e7(%rip)        # 33cbb0 <malloc@GLIBC_2.2.5>
  1f22c9:	test   %rax,%rax
  1f22cc:	je     1f2bd3 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xa53>
  1f22d2:	mov    %rax,%r8
  1f22d5:	movzbl 0x14cc0c(%rip),%eax        # 33eee8 <frontier_experiment::TRACK>
  1f22dc:	test   %al,%al
  1f22de:	je     1f2325 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x1a5>
  1f22e0:	lock incq 0x14cc08(%rip)        # 33eef0 <frontier_experiment::ALLOCS>
  1f22e8:	lock add %rbx,0x14cc08(%rip)        # 33eef8 <frontier_experiment::REQUESTED>
  1f22f0:	mov    %rbx,%rcx
  1f22f3:	lock xadd %rcx,0x14cbdc(%rip)        # 33eed8 <frontier_experiment::LIVE>
  1f22fc:	add    %rbx,%rcx
  1f22ff:	mov    0x14cbda(%rip),%rax        # 33eee0 <frontier_experiment::PEAK>
  1f2306:	cs nopw 0x0(%rax,%rax,1)
  1f2310:	cmp    %rcx,%rax
  1f2313:	mov    %rcx,%rdx
  1f2316:	cmova  %rax,%rdx
  1f231a:	lock cmpxchg %rdx,0x14cbbd(%rip)        # 33eee0 <frontier_experiment::PEAK>
  1f2323:	jne    1f2310 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x190>
  1f2325:	mov    %r13,0x38(%rsp)
  1f232a:	mov    $0x1,%eax
  1f232f:	mov    %rax,0x18(%rsp)
  1f2334:	mov    %r8,%rax
  1f2337:	cmp    $0x2,%r14
  1f233b:	jb     1f23b8 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x238>
  1f233d:	lea    -0x1(%r14),%rdx
  1f2341:	mov    $0x1,%ecx
  1f2346:	mov    %r8,%rax
  1f2349:	cmp    $0x10,%rdx
  1f234d:	jb     1f23a0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x220>
  1f234f:	mov    %rdx,%rsi
  1f2352:	and    $0xfffffffffffffff0,%rsi
  1f2356:	lea    (%r8,%rsi,8),%rax
  1f235a:	lea    0x1(%rsi),%rcx
  1f235e:	xor    %edi,%edi
  1f2360:	vbroadcastsd -0x1e19b9(%rip),%ymm0        # 109b0 <anon.1b06fbe60509ae926a49330b91708f0a.13.llvm.11709953318905502329+0x530>
  1f2369:	nopl   0x0(%rax)
  1f2370:	vmovups %ymm0,(%r8,%rdi,8)
  1f2376:	vmovups %ymm0,0x20(%r8,%rdi,8)
  1f237d:	vmovups %ymm0,0x40(%r8,%rdi,8)
  1f2384:	vmovups %ymm0,0x60(%r8,%rdi,8)
  1f238b:	add    $0x10,%rdi
  1f238f:	cmp    %rdi,%rsi
  1f2392:	jne    1f2370 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x1f0>
  1f2394:	mov    %r14,0x18(%rsp)
  1f2399:	cmp    %rsi,%rdx
  1f239c:	je     1f23b8 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x238>
  1f239e:	xchg   %ax,%ax
  1f23a0:	inc    %rcx
  1f23a3:	movq   $0x1,(%rax)
  1f23aa:	add    $0x8,%rax
  1f23ae:	cmp    %rcx,%r14
  1f23b1:	jne    1f23a0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x220>
  1f23b3:	mov    %r14,0x18(%rsp)
  1f23b8:	mov    %r8,0x10(%rsp)
  1f23bd:	movq   $0x1,(%rax)
  1f23c4:	mov    0x8(%rsp),%r15
  1f23c9:	add    %r15,%r12
  1f23cc:	mov    0x30(%rsp),%rdx
  1f23d1:	mov    0x20(%rdx),%rax
  1f23d5:	mov    0x28(%rdx),%rdi
  1f23d9:	mov    0x88(%rdx),%rcx
  1f23e0:	mov    0xa0(%rdx),%rsi
  1f23e7:	mov    0x90(%rdx),%r13
  1f23ee:	mov    0x78(%rdx),%r10
  1f23f2:	mov    0x58(%rdx),%r9
  1f23f6:	mov    0x50(%rdx),%r11
  1f23fa:	xor    %ebx,%ebx
  1f23fc:	lea    0x1474c5(%rip),%rdx        # 3398c8 <anon.0154b0ae4e43a031cafbc3dbea9bcf13.2.llvm.11444141577931038052+0x268>
  1f2403:	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  1f2410:	cmp    %rbx,%rdi
  1f2413:	je     1f2b4e <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x9ce>
  1f2419:	mov    (%rax,%rbx,4),%ebp
  1f241c:	cmp    %rbp,%rdi
  1f241f:	jbe    1f2a9c <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x91c>
  1f2425:	cmp    %rbp,%rcx
  1f2428:	mov    $0x0,%r14d
  1f242e:	cmovbe %rcx,%r14
  1f2432:	mov    %r13,%r8
  1f2435:	cmova  %rsi,%r8
  1f2439:	sub    %r14,%rbp
  1f243c:	imul   %r10,%rbp
  1f2440:	lea    (%r8,%rbp,8),%r8
  1f2444:	lea    (%r8,%r10,8),%r14
  1f2448:	mov    %r8,(%r15)
  1f244b:	mov    %r14,0x8(%r15)
  1f244f:	cmp    %rbx,%r9
  1f2452:	je     1f2b44 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x9c4>
  1f2458:	mov    %bl,(%r11,%rbx,1)
  1f245c:	add    $0x10,%r15
  1f2460:	inc    %rbx
  1f2463:	cmp    %r12,%r15
  1f2466:	jne    1f2410 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x290>
  1f2468:	mov    0x10(%rsp),%rbx
  1f246d:	mov    0x30(%rsp),%r15
  1f2472:	mov    0x20(%rsp),%r14
  1f2477:	mov    0x38(%rsp),%r13
  1f247c:	cmpb   $0x0,0x50(%rsp)
  1f2481:	mov    0x40(%rsp),%rdx
  1f2486:	je     1f2872 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x6f2>
  1f248c:	mov    0x0(%r13),%rsi
  1f2490:	movzbl 0x48(%rsp),%ecx
  1f2495:	mov    %r15,%rdi
  1f2498:	mov    0x8(%rsp),%r8
  1f249d:	mov    %r14,%r9
  1f24a0:	push   %r14
  1f24a2:	push   %rbx
  1f24a3:	vzeroupper
  1f24a6:	call   1df400 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter_grouped::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>>
  1f24ab:	add    $0x10,%rsp
  1f24af:	mov    %rax,0x40(%rsp)
  1f24b4:	mov    %rax,0xa8(%r15)
  1f24bb:	lea    0x60(%rsp),%rdi
  1f24c0:	mov    %r14,%rsi
  1f24c3:	mov    %r14,%rdx
  1f24c6:	call   158d90 <alloc::vec::from_elem::<usize>>
  1f24cb:	cmp    $0x2,%r14
  1f24cf:	mov    %rbx,0x10(%rsp)
  1f24d4:	jb     1f2553 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x3d3>
  1f24d6:	mov    0x68(%rsp),%rax
  1f24db:	mov    0x70(%rsp),%rsi
  1f24e0:	cmp    $0x1,%rsi
  1f24e4:	mov    %rsi,%rcx
  1f24e7:	adc    $0x0,%rcx
  1f24eb:	lea    -0x1(%rcx),%rdi
  1f24ef:	lea    -0x1(%r14),%r8
  1f24f3:	mov    $0x1,%r13d
  1f24f9:	xor    %r12d,%r12d
  1f24fc:	lea    0x147355(%rip),%rdx        # 339858 <anon.0154b0ae4e43a031cafbc3dbea9bcf13.2.llvm.11444141577931038052+0x1f8>
  1f2503:	lea    0x147366(%rip),%r9        # 339870 <anon.0154b0ae4e43a031cafbc3dbea9bcf13.2.llvm.11444141577931038052+0x210>
  1f250a:	lea    0x147377(%rip),%r10        # 339888 <anon.0154b0ae4e43a031cafbc3dbea9bcf13.2.llvm.11444141577931038052+0x228>
  1f2511:	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  1f2520:	cmp    %r12,%rsi
  1f2523:	je     1f2bb5 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xa35>
  1f2529:	cmp    %r12,%r14
  1f252c:	je     1f2bbd <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xa3d>
  1f2532:	cmp    %r12,%rdi
  1f2535:	je     1f2bad <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xa2d>
  1f253b:	mov    (%rax,%r12,8),%r11
  1f253f:	add    (%rbx,%r12,8),%r11
  1f2543:	mov    %r11,0x8(%rax,%r12,8)
  1f2548:	inc    %r12
  1f254b:	inc    %r13
  1f254e:	cmp    %r12,%r8
  1f2551:	jne    1f2520 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x3a0>
  1f2553:	mov    0x40(%rsp),%rdi
  1f2558:	test   %rdi,%rdi
  1f255b:	je     1f280b <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x68b>
  1f2561:	mov    0x58(%r15),%r12
  1f2565:	mov    0x50(%r15),%rax
  1f2569:	mov    %rax,0x50(%rsp)
  1f256e:	mov    0x68(%rsp),%rcx
  1f2573:	mov    0x70(%rsp),%rsi
  1f2578:	mov    0x20(%r15),%rax
  1f257c:	mov    %rax,0x48(%rsp)
  1f2581:	mov    0x28(%r15),%rbp
  1f2585:	mov    0x40(%r15),%rax
  1f2589:	mov    %rax,0x38(%rsp)
  1f258e:	mov    0x38(%r15),%rax
  1f2592:	mov    %rax,0x80(%rsp)
  1f259a:	mov    0x88(%r15),%r11
  1f25a1:	mov    0xa0(%r15),%r9
  1f25a8:	mov    0x90(%r15),%rdx
  1f25af:	mov    %r15,%rax
  1f25b2:	mov    0x78(%r15),%r15
  1f25b6:	mov    0x70(%rax),%rdi
  1f25ba:	mov    %rdi,0x58(%rsp)
  1f25bf:	mov    0x68(%rax),%rax
  1f25c3:	mov    %rax,0x78(%rsp)
  1f25c8:	xor    %r13d,%r13d
  1f25cb:	mov    0x8(%rsp),%r10
  1f25d0:	jmp    1f2612 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x492>
  1f25d2:	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  1f25e0:	add    0x8(%rsp),%rdi
  1f25e5:	mov    (%rdi),%rdi
  1f25e8:	sub    %rax,%rdi
  1f25eb:	sar    $0x3,%rdi
  1f25ef:	shl    $0x4,%r14d
  1f25f3:	mov    0x78(%rsp),%rax
  1f25f8:	mov    %rbx,(%rax,%r14,1)
  1f25fc:	mov    %rdi,0x8(%rax,%r14,1)
  1f2601:	inc    %r13
  1f2604:	mov    0x40(%rsp),%rdi
  1f2609:	cmp    %r13,%rdi
  1f260c:	je     1f26c9 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x549>
  1f2612:	cmp    %r13,%r12
  1f2615:	je     1f2b81 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xa01>
  1f261b:	mov    0x50(%rsp),%rax
  1f2620:	movzbl (%rax,%r13,1),%r14d
  1f2625:	cmp    %r14,%rsi
  1f2628:	jbe    1f2b75 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x9f5>
  1f262e:	mov    (%rcx,%r14,8),%rbx
  1f2632:	lea    0x1(%rbx),%rax
  1f2636:	mov    %rax,(%rcx,%r14,8)
  1f263a:	cmp    %r13,%rbp
  1f263d:	je     1f2b8d <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xa0d>
  1f2643:	cmp    0x38(%rsp),%rbx
  1f2648:	jae    1f2b64 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x9e4>
  1f264e:	mov    0x48(%rsp),%rax
  1f2653:	mov    (%rax,%r13,4),%eax
  1f2657:	mov    0x80(%rsp),%rdi
  1f265f:	mov    %eax,(%rdi,%rbx,4)
  1f2662:	cmp    %rax,%rbp
  1f2665:	jbe    1f2ac2 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x942>
  1f266b:	cmp    %rax,%r11
  1f266e:	mov    $0x0,%r8d
  1f2674:	cmovbe %r11,%r8
  1f2678:	mov    %rdx,%rdi
  1f267b:	cmova  %r9,%rdi
  1f267f:	cmp    %r14,0x20(%rsp)
  1f2684:	jbe    1f2b9c <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xa1c>
  1f268a:	sub    %r8,%rax
  1f268d:	imul   %r15,%rax
  1f2691:	lea    (%rdi,%rax,8),%rax
  1f2695:	lea    (%rax,%r15,8),%r8
  1f2699:	mov    %r14d,%edi
  1f269c:	shl    $0x4,%edi
  1f269f:	cmp    0x8(%r10,%rdi,1),%r8
  1f26a4:	jne    1f2601 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x481>
  1f26aa:	cmp    %r14,0x58(%rsp)
  1f26af:	ja     1f25e0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x460>
  1f26b5:	mov    %r14,%r12
  1f26b8:	mov    0x58(%rsp),%rsi
  1f26bd:	lea    0x14717c(%rip),%rdx        # 339840 <anon.0154b0ae4e43a031cafbc3dbea9bcf13.2.llvm.11444141577931038052+0x1e0>
  1f26c4:	jmp    1f2bc3 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xa43>
  1f26c9:	mov    0x30(%rsp),%r15
  1f26ce:	mov    0x20(%rsp),%r14
  1f26d3:	lea    (%r14,%rdi,1),%r13
  1f26d7:	mov    %rbp,%rbx
  1f26da:	sub    %r13,%rbx
  1f26dd:	jb     1f281f <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x69f>
  1f26e3:	mov    %r14,%rax
  1f26e6:	mov    0x40(%r15),%r14
  1f26ea:	cmp    %r14,%rax
  1f26ed:	ja     1f2af4 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x974>
  1f26f3:	cmp    %rdi,%r13
  1f26f6:	jb     1f2ae5 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x965>
  1f26fc:	mov    %r15,%rax
  1f26ff:	mov    0x38(%r15),%r15
  1f2703:	mov    0x20(%rax),%r12
  1f2707:	lea    (%r12,%rdi,4),%rsi
  1f270b:	mov    0x20(%rsp),%rdx
  1f2710:	shl    $0x2,%rdx
  1f2714:	mov    %r15,%rdi
  1f2717:	call   *0x14a513(%rip)        # 33cc30 <memcpy@GLIBC_2.14>
  1f271d:	mov    %r14,%rdx
  1f2720:	sub    %r13,%rdx
  1f2723:	jb     1f2b04 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x984>
  1f2729:	cmp    %rbp,%r14
  1f272c:	jne    1f2b24 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x9a4>
  1f2732:	lea    (%r12,%r13,4),%rsi
  1f2736:	lea    (%r15,%r13,4),%rdi
  1f273a:	shl    $0x2,%rdx
  1f273e:	call   *0x14a4ec(%rip)        # 33cc30 <memcpy@GLIBC_2.14>
  1f2744:	mov    0x30(%rsp),%rdx
  1f2749:	mov    %r13,0xa8(%rdx)
  1f2750:	mov    0x18(%rdx),%rax
  1f2754:	mov    0x30(%rdx),%rcx
  1f2758:	mov    %rcx,0x18(%rdx)
  1f275c:	mov    %rax,0x30(%rdx)
  1f2760:	mov    %r15,0x20(%rdx)
  1f2764:	mov    %r12,0x38(%rdx)
  1f2768:	mov    %rbp,0x28(%rdx)
  1f276c:	mov    %rbp,0x40(%rdx)
  1f2770:	mov    0x60(%rsp),%rax
  1f2775:	test   %rax,%rax
  1f2778:	je     1f279c <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x61c>
  1f277a:	mov    0x68(%rsp),%rdi
  1f277f:	movzbl 0x14c762(%rip),%ecx        # 33eee8 <frontier_experiment::TRACK>
  1f2786:	test   %cl,%cl
  1f2788:	je     1f2796 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x616>
  1f278a:	shl    $0x3,%rax
  1f278e:	lock sub %rax,0x14c742(%rip)        # 33eed8 <frontier_experiment::LIVE>
  1f2796:	call   *0x14a434(%rip)        # 33cbd0 <free@GLIBC_2.2.5>
  1f279c:	cmpq   $0x0,0x18(%rsp)
  1f27a2:	mov    0x10(%rsp),%rdi
  1f27a7:	je     1f27cb <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x64b>
  1f27a9:	movzbl 0x14c738(%rip),%eax        # 33eee8 <frontier_experiment::TRACK>
  1f27b0:	test   %al,%al
  1f27b2:	je     1f27c5 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x645>
  1f27b4:	mov    0x18(%rsp),%rax
  1f27b9:	shl    $0x3,%rax
  1f27bd:	lock sub %rax,0x14c713(%rip)        # 33eed8 <frontier_experiment::LIVE>
  1f27c5:	call   *0x14a405(%rip)        # 33cbd0 <free@GLIBC_2.2.5>
  1f27cb:	cmpq   $0x0,0x28(%rsp)
  1f27d1:	je     1f2842 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x6c2>
  1f27d3:	movzbl 0x14c70e(%rip),%eax        # 33eee8 <frontier_experiment::TRACK>
  1f27da:	test   %al,%al
  1f27dc:	je     1f27ef <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x66f>
  1f27de:	mov    0x28(%rsp),%rax
  1f27e3:	shl    $0x4,%rax
  1f27e7:	lock sub %rax,0x14c6e9(%rip)        # 33eed8 <frontier_experiment::LIVE>
  1f27ef:	mov    0x8(%rsp),%rdi
  1f27f4:	add    $0x88,%rsp
  1f27fb:	pop    %rbx
  1f27fc:	pop    %r12
  1f27fe:	pop    %r13
  1f2800:	pop    %r14
  1f2802:	pop    %r15
  1f2804:	pop    %rbp
  1f2805:	jmp    *0x14a3c5(%rip)        # 33cbd0 <free@GLIBC_2.2.5>
  1f280b:	mov    0x28(%r15),%rbp
  1f280f:	lea    (%r14,%rdi,1),%r13
  1f2813:	mov    %rbp,%rbx
  1f2816:	sub    %r13,%rbx
  1f2819:	jae    1f26e3 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x563>
  1f281f:	lea    -0x1dd321(%rip),%rdi        # 15505 <anon.0154b0ae4e43a031cafbc3dbea9bcf13.0.llvm.11444141577931038052+0x45>
  1f2826:	lea    0x146ef3(%rip),%rdx        # 339720 <anon.0154b0ae4e43a031cafbc3dbea9bcf13.2.llvm.11444141577931038052+0xc0>
  1f282d:	mov    $0x41,%esi
  1f2832:	mov    0x10(%rsp),%rbx
  1f2837:	call   *0x14a443(%rip)        # 33cc80 <_DYNAMIC+0x360>
  1f283d:	jmp    1f2bf9 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xa79>
  1f2842:	add    $0x88,%rsp
  1f2849:	pop    %rbx
  1f284a:	pop    %r12
  1f284c:	pop    %r13
  1f284e:	pop    %r14
  1f2850:	pop    %r15
  1f2852:	pop    %rbp
  1f2853:	ret
  1f2854:	mov    $0x8,%ebx
  1f2859:	movq   $0x0,0x18(%rsp)
  1f2862:	cmpb   $0x0,0x50(%rsp)
  1f2867:	mov    0x40(%rsp),%rdx
  1f286c:	jne    1f248c <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x30c>
  1f2872:	cmp    $0xf,%rdx
  1f2876:	ja     1f2bf1 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xa71>
  1f287c:	lea    -0x1de8e7(%rip),%rax        # 13f9c <anon.d3250b76d489f4edfc636faa13ff4d9e.1.llvm.14943984570314982472+0x250>
  1f2883:	movslq (%rax,%rdx,4),%rcx
  1f2887:	add    %rax,%rcx
  1f288a:	jmp    *%rcx
  1f288c:	mov    %r15,%rdi
  1f288f:	mov    %r13,%rsi
  1f2892:	mov    0x8(%rsp),%rdx
  1f2897:	mov    %r14,%rcx
  1f289a:	mov    %rbx,%r8
  1f289d:	mov    %r14,%r9
  1f28a0:	vzeroupper
  1f28a3:	call   1e3a30 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>>
  1f28a8:	jmp    1f24af <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x32f>
  1f28ad:	mov    %r15,%rdi
  1f28b0:	mov    %r13,%rsi
  1f28b3:	mov    0x8(%rsp),%rdx
  1f28b8:	mov    %r14,%rcx
  1f28bb:	mov    %rbx,%r8
  1f28be:	mov    %r14,%r9
  1f28c1:	vzeroupper
  1f28c4:	call   1e46b0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>>
  1f28c9:	jmp    1f24af <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x32f>
  1f28ce:	mov    %r15,%rdi
  1f28d1:	mov    %r13,%rsi
  1f28d4:	mov    0x8(%rsp),%rdx
  1f28d9:	mov    %r14,%rcx
  1f28dc:	mov    %rbx,%r8
  1f28df:	mov    %r14,%r9
  1f28e2:	vzeroupper
  1f28e5:	call   1e4d00 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 3>>
  1f28ea:	jmp    1f24af <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x32f>
  1f28ef:	mov    %r15,%rdi
  1f28f2:	mov    %r13,%rsi
  1f28f5:	mov    0x8(%rsp),%rdx
  1f28fa:	mov    %r14,%rcx
  1f28fd:	mov    %rbx,%r8
  1f2900:	mov    %r14,%r9
  1f2903:	vzeroupper
  1f2906:	call   1e3a30 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>>
  1f290b:	jmp    1f24af <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x32f>
  1f2910:	mov    %r15,%rdi
  1f2913:	mov    %r13,%rsi
  1f2916:	mov    0x8(%rsp),%rdx
  1f291b:	mov    %r14,%rcx
  1f291e:	mov    %rbx,%r8
  1f2921:	mov    %r14,%r9
  1f2924:	vzeroupper
  1f2927:	call   1e3a30 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>>
  1f292c:	jmp    1f24af <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x32f>
  1f2931:	mov    %r15,%rdi
  1f2934:	mov    %r13,%rsi
  1f2937:	mov    0x8(%rsp),%rdx
  1f293c:	mov    %r14,%rcx
  1f293f:	mov    %rbx,%r8
  1f2942:	mov    %r14,%r9
  1f2945:	vzeroupper
  1f2948:	call   1e4060 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>>
  1f294d:	jmp    1f24af <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x32f>
  1f2952:	mov    %r15,%rdi
  1f2955:	mov    %r13,%rsi
  1f2958:	mov    0x8(%rsp),%rdx
  1f295d:	mov    %r14,%rcx
  1f2960:	mov    %rbx,%r8
  1f2963:	mov    %r14,%r9
  1f2966:	vzeroupper
  1f2969:	call   1e46b0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>>
  1f296e:	jmp    1f24af <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x32f>
  1f2973:	mov    %r15,%rdi
  1f2976:	mov    %r13,%rsi
  1f2979:	mov    0x8(%rsp),%rdx
  1f297e:	mov    %r14,%rcx
  1f2981:	mov    %rbx,%r8
  1f2984:	mov    %r14,%r9
  1f2987:	vzeroupper
  1f298a:	call   1e4d00 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 3>>
  1f298f:	jmp    1f24af <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x32f>
  1f2994:	mov    %r15,%rdi
  1f2997:	mov    %r13,%rsi
  1f299a:	mov    0x8(%rsp),%rdx
  1f299f:	mov    %r14,%rcx
  1f29a2:	mov    %rbx,%r8
  1f29a5:	mov    %r14,%r9
  1f29a8:	vzeroupper
  1f29ab:	call   1e4d00 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 3>>
  1f29b0:	jmp    1f24af <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x32f>
  1f29b5:	mov    %r15,%rdi
  1f29b8:	mov    %r13,%rsi
  1f29bb:	mov    0x8(%rsp),%rdx
  1f29c0:	mov    %r14,%rcx
  1f29c3:	mov    %rbx,%r8
  1f29c6:	mov    %r14,%r9
  1f29c9:	vzeroupper
  1f29cc:	call   1e4d00 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 3>>
  1f29d1:	jmp    1f24af <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x32f>
  1f29d6:	mov    %r15,%rdi
  1f29d9:	mov    %r13,%rsi
  1f29dc:	mov    0x8(%rsp),%rdx
  1f29e1:	mov    %r14,%rcx
  1f29e4:	mov    %rbx,%r8
  1f29e7:	mov    %r14,%r9
  1f29ea:	vzeroupper
  1f29ed:	call   1e4060 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>>
  1f29f2:	jmp    1f24af <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x32f>
  1f29f7:	mov    %r15,%rdi
  1f29fa:	mov    %r13,%rsi
  1f29fd:	mov    0x8(%rsp),%rdx
  1f2a02:	mov    %r14,%rcx
  1f2a05:	mov    %rbx,%r8
  1f2a08:	mov    %r14,%r9
  1f2a0b:	vzeroupper
  1f2a0e:	call   1e4060 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>>
  1f2a13:	jmp    1f24af <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x32f>
  1f2a18:	mov    %r15,%rdi
  1f2a1b:	mov    %r13,%rsi
  1f2a1e:	mov    0x8(%rsp),%rdx
  1f2a23:	mov    %r14,%rcx
  1f2a26:	mov    %rbx,%r8
  1f2a29:	mov    %r14,%r9
  1f2a2c:	vzeroupper
  1f2a2f:	call   1e4060 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 1>>
  1f2a34:	jmp    1f24af <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x32f>
  1f2a39:	mov    %r15,%rdi
  1f2a3c:	mov    %r13,%rsi
  1f2a3f:	mov    0x8(%rsp),%rdx
  1f2a44:	mov    %r14,%rcx
  1f2a47:	mov    %rbx,%r8
  1f2a4a:	mov    %r14,%r9
  1f2a4d:	vzeroupper
  1f2a50:	call   1e46b0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>>
  1f2a55:	jmp    1f24af <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x32f>
  1f2a5a:	mov    %r15,%rdi
  1f2a5d:	mov    %r13,%rsi
  1f2a60:	mov    0x8(%rsp),%rdx
  1f2a65:	mov    %r14,%rcx
  1f2a68:	mov    %rbx,%r8
  1f2a6b:	mov    %r14,%r9
  1f2a6e:	vzeroupper
  1f2a71:	call   1e46b0 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 2>>
  1f2a76:	jmp    1f24af <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x32f>
  1f2a7b:	mov    %r15,%rdi
  1f2a7e:	mov    %r13,%rsi
  1f2a81:	mov    0x8(%rsp),%rdx
  1f2a86:	mov    %r14,%rcx
  1f2a89:	mov    %rbx,%r8
  1f2a8c:	mov    %r14,%r9
  1f2a8f:	vzeroupper
  1f2a92:	call   1e3a30 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::scatter::<u32, block_msd_research::frontier::distribute_children<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>, 1>::{closure#0}, 0>>
  1f2a97:	jmp    1f24af <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x32f>
  1f2a9c:	lea    -0x1dd4f0(%rip),%rdi        # 155b3 <anon.0154b0ae4e43a031cafbc3dbea9bcf13.0.llvm.11444141577931038052+0xf3>
  1f2aa3:	lea    0x146f26(%rip),%rdx        # 3399d0 <anon.0154b0ae4e43a031cafbc3dbea9bcf13.2.llvm.11444141577931038052+0x370>
  1f2aaa:	mov    $0x2c,%esi
  1f2aaf:	mov    0x10(%rsp),%rbx
  1f2ab4:	vzeroupper
  1f2ab7:	call   *0x14a1c3(%rip)        # 33cc80 <_DYNAMIC+0x360>
  1f2abd:	jmp    1f2bf9 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xa79>
  1f2ac2:	lea    -0x1dd516(%rip),%rdi        # 155b3 <anon.0154b0ae4e43a031cafbc3dbea9bcf13.0.llvm.11444141577931038052+0xf3>
  1f2ac9:	lea    0x146f00(%rip),%rdx        # 3399d0 <anon.0154b0ae4e43a031cafbc3dbea9bcf13.2.llvm.11444141577931038052+0x370>
  1f2ad0:	mov    $0x2c,%esi
  1f2ad5:	mov    0x10(%rsp),%rbx
  1f2ada:	call   *0x14a1a0(%rip)        # 33cc80 <_DYNAMIC+0x360>
  1f2ae0:	jmp    1f2bf9 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xa79>
  1f2ae5:	lea    0x146c64(%rip),%rcx        # 339750 <anon.0154b0ae4e43a031cafbc3dbea9bcf13.2.llvm.11444141577931038052+0xf0>
  1f2aec:	mov    %r13,%rsi
  1f2aef:	mov    %rbp,%r14
  1f2af2:	jmp    1f2b11 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x991>
  1f2af4:	lea    0x146c3d(%rip),%rcx        # 339738 <anon.0154b0ae4e43a031cafbc3dbea9bcf13.2.llvm.11444141577931038052+0xd8>
  1f2afb:	xor    %edi,%edi
  1f2afd:	mov    0x20(%rsp),%rsi
  1f2b02:	jmp    1f2b11 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0x991>
  1f2b04:	lea    0x146c5d(%rip),%rcx        # 339768 <anon.0154b0ae4e43a031cafbc3dbea9bcf13.2.llvm.11444141577931038052+0x108>
  1f2b0b:	mov    %r13,%rdi
  1f2b0e:	mov    %r14,%rsi
  1f2b11:	mov    %r14,%rdx
  1f2b14:	mov    0x10(%rsp),%rbx
  1f2b19:	call   *0x14a071(%rip)        # 33cb90 <_DYNAMIC+0x270>
  1f2b1f:	jmp    1f2bf9 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xa79>
  1f2b24:	lea    0x146c6d(%rip),%rax        # 339798 <anon.0154b0ae4e43a031cafbc3dbea9bcf13.2.llvm.11444141577931038052+0x138>
  1f2b2b:	mov    %rdx,%rdi
  1f2b2e:	mov    %rbx,%rsi
  1f2b31:	mov    %rax,%rdx
  1f2b34:	mov    0x10(%rsp),%rbx
  1f2b39:	call   *0x14a149(%rip)        # 33cc88 <_DYNAMIC+0x368>
  1f2b3f:	jmp    1f2bf9 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xa79>
  1f2b44:	mov    %r9,%rdi
  1f2b47:	lea    0x146d92(%rip),%rdx        # 3398e0 <anon.0154b0ae4e43a031cafbc3dbea9bcf13.2.llvm.11444141577931038052+0x280>
  1f2b4e:	mov    %rdi,%rsi
  1f2b51:	mov    0x10(%rsp),%rbx
  1f2b56:	vzeroupper
  1f2b59:	call   *0x14a039(%rip)        # 33cb98 <_DYNAMIC+0x278>
  1f2b5f:	jmp    1f2bf9 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xa79>
  1f2b64:	mov    %rbx,%r12
  1f2b67:	mov    0x38(%rsp),%rsi
  1f2b6c:	lea    0x146c85(%rip),%rdx        # 3397f8 <anon.0154b0ae4e43a031cafbc3dbea9bcf13.2.llvm.11444141577931038052+0x198>
  1f2b73:	jmp    1f2bc3 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xa43>
  1f2b75:	mov    %r14,%r12
  1f2b78:	lea    0x146c49(%rip),%rdx        # 3397c8 <anon.0154b0ae4e43a031cafbc3dbea9bcf13.2.llvm.11444141577931038052+0x168>
  1f2b7f:	jmp    1f2bc3 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xa43>
  1f2b81:	mov    %r12,%rsi
  1f2b84:	lea    0x146c25(%rip),%rdx        # 3397b0 <anon.0154b0ae4e43a031cafbc3dbea9bcf13.2.llvm.11444141577931038052+0x150>
  1f2b8b:	jmp    1f2bc3 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xa43>
  1f2b8d:	mov    %rbp,%r12
  1f2b90:	mov    %rbp,%rsi
  1f2b93:	lea    0x146c46(%rip),%rdx        # 3397e0 <anon.0154b0ae4e43a031cafbc3dbea9bcf13.2.llvm.11444141577931038052+0x180>
  1f2b9a:	jmp    1f2bc3 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xa43>
  1f2b9c:	mov    %r14,%r12
  1f2b9f:	mov    0x20(%rsp),%rsi
  1f2ba4:	lea    0x146c7d(%rip),%rdx        # 339828 <anon.0154b0ae4e43a031cafbc3dbea9bcf13.2.llvm.11444141577931038052+0x1c8>
  1f2bab:	jmp    1f2bc3 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xa43>
  1f2bad:	mov    %rcx,%r12
  1f2bb0:	mov    %r10,%rdx
  1f2bb3:	jmp    1f2bc3 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xa43>
  1f2bb5:	dec    %r13
  1f2bb8:	mov    %r13,%r12
  1f2bbb:	jmp    1f2bc3 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xa43>
  1f2bbd:	mov    %r14,%rsi
  1f2bc0:	mov    %r9,%rdx
  1f2bc3:	mov    %r12,%rdi
  1f2bc6:	mov    0x10(%rsp),%rbx
  1f2bcb:	call   *0x149fc7(%rip)        # 33cb98 <_DYNAMIC+0x278>
  1f2bd1:	jmp    1f2bf9 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xa79>
  1f2bd3:	mov    $0x8,%edi
  1f2bd8:	mov    %rbx,%rsi
  1f2bdb:	call   *0x14a087(%rip)        # 33cc68 <_DYNAMIC+0x348>
  1f2be1:	jmp    1f2bf9 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xa79>
  1f2be3:	mov    $0x8,%edi
  1f2be8:	mov    %r12,%rsi
  1f2beb:	call   *0x14a077(%rip)        # 33cc68 <_DYNAMIC+0x348>
  1f2bf1:	vzeroupper
  1f2bf4:	call   26c8b0 <core::panicking::unreachable_display::<&str>>
  1f2bf9:	ud2
  1f2bfb:	mov    %rax,%r15
  1f2bfe:	jmp    1f2c61 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xae1>
  1f2c00:	mov    %rax,%r15
  1f2c03:	mov    0x60(%rsp),%rax
  1f2c08:	test   %rax,%rax
  1f2c0b:	je     1f2c34 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xab4>
  1f2c0d:	mov    0x68(%rsp),%rdi
  1f2c12:	movzbl 0x14c2cf(%rip),%ecx        # 33eee8 <frontier_experiment::TRACK>
  1f2c19:	test   %cl,%cl
  1f2c1b:	je     1f2c29 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xaa9>
  1f2c1d:	shl    $0x3,%rax
  1f2c21:	lock sub %rax,0x14c2af(%rip)        # 33eed8 <frontier_experiment::LIVE>
  1f2c29:	call   *0x149fa1(%rip)        # 33cbd0 <free@GLIBC_2.2.5>
  1f2c2f:	jmp    1f2c34 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xab4>
  1f2c31:	mov    %rax,%r15
  1f2c34:	cmpq   $0x0,0x18(%rsp)
  1f2c3a:	je     1f2c61 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xae1>
  1f2c3c:	movzbl 0x14c2a5(%rip),%eax        # 33eee8 <frontier_experiment::TRACK>
  1f2c43:	test   %al,%al
  1f2c45:	je     1f2c58 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xad8>
  1f2c47:	mov    0x18(%rsp),%rax
  1f2c4c:	shl    $0x3,%rax
  1f2c50:	lock sub %rax,0x14c280(%rip)        # 33eed8 <frontier_experiment::LIVE>
  1f2c58:	mov    %rbx,%rdi
  1f2c5b:	call   *0x149f6f(%rip)        # 33cbd0 <free@GLIBC_2.2.5>
  1f2c61:	cmpq   $0x0,0x28(%rsp)
  1f2c67:	je     1f2c90 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xb10>
  1f2c69:	movzbl 0x14c278(%rip),%eax        # 33eee8 <frontier_experiment::TRACK>
  1f2c70:	test   %al,%al
  1f2c72:	je     1f2c85 <<block_msd_research::frontier::block::Sorter<frontier_experiment::Small>>::step_impl::<u32, block_msd_research::frontier::pa::partition<frontier_experiment::Small, u32, block_msd_research::frontier::Prefix<u32>>::{closure#0}>+0xb05>
  1f2c74:	mov    0x28(%rsp),%rax
  1f2c79:	shl    $0x4,%rax
  1f2c7d:	lock sub %rax,0x14c253(%rip)        # 33eed8 <frontier_experiment::LIVE>
  1f2c85:	mov    0x8(%rsp),%rdi
  1f2c8a:	call   *0x149f40(%rip)        # 33cbd0 <free@GLIBC_2.2.5>
  1f2c90:	mov    %r15,%rdi
  1f2c93:	call   32f210 <_Unwind_Resume@plt>
