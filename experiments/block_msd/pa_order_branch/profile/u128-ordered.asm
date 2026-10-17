
experiments/block_msd/target/pa-order-branch/time:     file format elf64-x86-64


Disassembly of section .text:

0000000000113d10 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>>:
  113d10:	push   %rbp
  113d11:	push   %r15
  113d13:	push   %r14
  113d15:	push   %r13
  113d17:	push   %r12
  113d19:	push   %rbx
  113d1a:	sub    $0x38,%rsp
  113d1e:	mov    $0x1,%r8b
  113d21:	cmp    $0x2,%rsi
  113d25:	jb     114579 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x869>
  113d2b:	mov    (%rdi),%r9
  113d2e:	mov    0x8(%rdi),%rcx
  113d32:	mov    %rsi,0x8(%rsp)
  113d37:	lea    -0x1(%rsi),%rax
  113d3b:	movabs $0x7ffffffffffff80,%r10
  113d45:	mov    %rax,%rbp
  113d48:	and    %rax,%r10
  113d4b:	mov    %rdi,(%rsp)
  113d4f:	je     113ee5 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x1d5>
  113d55:	lea    0x10(%rdi),%r11
  113d59:	lea    -0x80(%r10),%rbx
  113d5d:	shr    $0x7,%rbx
  113d61:	xor    %esi,%esi
  113d63:	jmp    113d84 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x74>
  113d65:	data16 cs nopw 0x0(%rax,%rax,1)
  113d70:	add    $0x800,%r11
  113d77:	cmp    %rbx,%rsi
  113d7a:	lea    0x1(%rsi),%rsi
  113d7e:	je     113ee5 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x1d5>
  113d84:	xor    %edx,%edx
  113d86:	xor    %r15d,%r15d
  113d89:	xor    %r14d,%r14d
  113d8c:	nopl   0x0(%rax)
  113d90:	mov    (%r11,%r14,1),%rax
  113d94:	xor    %r9,%rax
  113d97:	or     %rdx,%rax
  113d9a:	mov    0x8(%r11,%r14,1),%rdx
  113d9f:	xor    %rcx,%rdx
  113da2:	or     %r15,%rdx
  113da5:	mov    0x18(%r11,%r14,1),%r8
  113daa:	xor    %rcx,%r8
  113dad:	mov    0x10(%r11,%r14,1),%r12
  113db2:	xor    %r9,%r12
  113db5:	mov    0x20(%r11,%r14,1),%r15
  113dba:	xor    %r9,%r15
  113dbd:	or     %r12,%r15
  113dc0:	or     %rax,%r15
  113dc3:	mov    0x28(%r11,%r14,1),%r12
  113dc8:	xor    %rcx,%r12
  113dcb:	or     %r8,%r12
  113dce:	or     %rdx,%r12
  113dd1:	mov    0x38(%r11,%r14,1),%rax
  113dd6:	xor    %rcx,%rax
  113dd9:	mov    0x30(%r11,%r14,1),%rdx
  113dde:	xor    %r9,%rdx
  113de1:	mov    0x40(%r11,%r14,1),%r13
  113de6:	xor    %r9,%r13
  113de9:	or     %rdx,%r13
  113dec:	mov    0x48(%r11,%r14,1),%rdx
  113df1:	xor    %rcx,%rdx
  113df4:	or     %rax,%rdx
  113df7:	mov    0x58(%r11,%r14,1),%rax
  113dfc:	xor    %rcx,%rax
  113dff:	or     %rdx,%rax
  113e02:	or     %r12,%rax
  113e05:	mov    0x50(%r11,%r14,1),%r8
  113e0a:	xor    %r9,%r8
  113e0d:	or     %r13,%r8
  113e10:	or     %r15,%r8
  113e13:	mov    0x60(%r11,%r14,1),%r12
  113e18:	xor    %r9,%r12
  113e1b:	mov    0x68(%r11,%r14,1),%r13
  113e20:	xor    %rcx,%r13
  113e23:	mov    0x78(%r11,%r14,1),%r15
  113e28:	mov    0x70(%r11,%r14,1),%rdx
  113e2d:	add    $0x80,%r14
  113e34:	xor    %rcx,%r15
  113e37:	or     %r13,%r15
  113e3a:	or     %rax,%r15
  113e3d:	xor    %r9,%rdx
  113e40:	or     %r12,%rdx
  113e43:	or     %r8,%rdx
  113e46:	cmp    $0x800,%r14
  113e4d:	jne    113d90 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x80>
  113e53:	or     %r15,%rdx
  113e56:	je     113d70 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x60>
  113e5c:	xor    %r13d,%r13d
  113e5f:	xor    %r12d,%r12d
  113e62:	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  113e70:	mov    (%r11,%r13,1),%r14
  113e74:	mov    0x8(%r11,%r13,1),%r15
  113e79:	mov    %r15,%rax
  113e7c:	xor    %rcx,%rax
  113e7f:	mov    %r14,%rdx
  113e82:	xor    %r9,%rdx
  113e85:	or     %rax,%rdx
  113e88:	jne    1140ac <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x39c>
  113e8e:	mov    0x10(%r11,%r13,1),%r14
  113e93:	mov    0x18(%r11,%r13,1),%r15
  113e98:	mov    %r15,%rax
  113e9b:	xor    %rcx,%rax
  113e9e:	mov    %r14,%rdx
  113ea1:	xor    %r9,%rdx
  113ea4:	or     %rax,%rdx
  113ea7:	jne    1140a9 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x399>
  113ead:	cmp    $0x7e0,%r13
  113eb4:	je     113d70 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x60>
  113eba:	mov    0x20(%r11,%r13,1),%r14
  113ebf:	mov    0x28(%r11,%r13,1),%r15
  113ec4:	add    $0x30,%r13
  113ec8:	add    $0x3,%r12
  113ecc:	mov    %r15,%rax
  113ecf:	xor    %rcx,%rax
  113ed2:	mov    %r14,%rdx
  113ed5:	xor    %r9,%rdx
  113ed8:	or     %rax,%rdx
  113edb:	je     113e70 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x160>
  113edd:	dec    %r12
  113ee0:	jmp    1140ac <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x39c>
  113ee5:	shl    $0x4,%r10
  113ee9:	lea    (%rdi,%r10,1),%rsi
  113eed:	add    $0x10,%rsi
  113ef1:	mov    %rbp,%rdi
  113ef4:	and    $0x7f,%edi
  113ef7:	mov    %edi,%r8d
  113efa:	shl    $0x4,%r8d
  113efe:	not    %rdi
  113f01:	mov    0x8(%rsp),%rdx
  113f06:	add    %rdx,%rdi
  113f09:	xor    %eax,%eax
  113f0b:	nopl   0x0(%rax,%rax,1)
  113f10:	cmp    %rax,%r8
  113f13:	je     114576 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x866>
  113f19:	mov    (%rsi,%rax,1),%r14
  113f1d:	mov    0x8(%rsi,%rax,1),%r15
  113f22:	mov    %r15,%r11
  113f25:	xor    %rcx,%r11
  113f28:	mov    %r14,%r10
  113f2b:	xor    %r9,%r10
  113f2e:	add    $0x10,%rax
  113f32:	inc    %rdi
  113f35:	or     %r11,%r10
  113f38:	je     113f10 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x200>
  113f3a:	cmp    %r9,%r14
  113f3d:	mov    %rdx,%rax
  113f40:	sbb    %rcx,%r15
  113f43:	jae    1140cb <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x3bb>
  113f49:	sub    %rdi,%rax
  113f4c:	jb     1145a9 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x899>
  113f52:	lea    -0x1(%rax),%rsi
  113f56:	mov    %rdx,%r8
  113f59:	sub    %rdi,%r8
  113f5c:	je     114598 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x888>
  113f62:	mov    %rdi,%r10
  113f65:	shl    $0x4,%r10
  113f69:	mov    %rsi,%rax
  113f6c:	shr    $0x7,%rax
  113f70:	movabs $0xfffffffffffff,%r9
  113f7a:	and    %rax,%r9
  113f7d:	je     1141cb <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x4bb>
  113f83:	mov    (%rsp),%rax
  113f87:	lea    (%r10,%rax,1),%rbx
  113f8b:	add    $0x40,%rbx
  113f8f:	xor    %eax,%eax
  113f91:	xor    %ecx,%ecx
  113f93:	mov    %rdi,0x10(%rsp)
  113f98:	mov    %r10,0x18(%rsp)
  113f9d:	mov    %r8,0x30(%rsp)
  113fa2:	mov    %r9,0x28(%rsp)
  113fa7:	inc    %rax
  113faa:	mov    %rax,0x20(%rsp)
  113faf:	xor    %r15d,%r15d
  113fb2:	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  113fc0:	mov    -0x40(%rbx,%r15,1),%rdi
  113fc5:	mov    -0x38(%rbx,%r15,1),%rax
  113fca:	mov    -0x28(%rbx,%r15,1),%r13
  113fcf:	mov    -0x30(%rbx,%r15,1),%rdx
  113fd4:	cmp    %rdx,%rdi
  113fd7:	mov    %rax,%r8
  113fda:	sbb    %r13,%r8
  113fdd:	jb     114289 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x579>
  113fe3:	mov    -0x20(%rbx,%r15,1),%rbp
  113fe8:	mov    -0x18(%rbx,%r15,1),%r11
  113fed:	cmp    %rbp,%rdx
  113ff0:	mov    %r13,%r8
  113ff3:	sbb    %r11,%r8
  113ff6:	jb     114289 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x579>
  113ffc:	mov    -0x10(%rbx,%r15,1),%r14
  114001:	mov    -0x8(%rbx,%r15,1),%r9
  114006:	cmp    %r14,%rbp
  114009:	mov    %r11,%r8
  11400c:	sbb    %r9,%r8
  11400f:	jb     114289 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x579>
  114015:	mov    (%rbx,%r15,1),%r10
  114019:	mov    0x8(%rbx,%r15,1),%r8
  11401e:	cmp    %r10,%r14
  114021:	mov    %r9,%r12
  114024:	sbb    %r8,%r12
  114027:	jb     114289 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x579>
  11402d:	xor    %rdx,%rdi
  114030:	xor    %r13,%rax
  114033:	or     %rdi,%rax
  114036:	sete   %al
  114039:	or     %al,%cl
  11403b:	xor    %rbp,%rdx
  11403e:	xor    %r11,%r13
  114041:	or     %rdx,%r13
  114044:	sete   %al
  114047:	xor    %r14,%rbp
  11404a:	xor    %r9,%r11
  11404d:	or     %rbp,%r11
  114050:	sete   %dl
  114053:	or     %al,%dl
  114055:	or     %cl,%dl
  114057:	xor    %r14,%r10
  11405a:	xor    %r9,%r8
  11405d:	or     %r10,%r8
  114060:	sete   %cl
  114063:	or     %dl,%cl
  114065:	add    $0x40,%r15
  114069:	cmp    $0x800,%r15
  114070:	jne    113fc0 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x2b0>
  114076:	add    $0x800,%rbx
  11407d:	mov    0x28(%rsp),%r9
  114082:	mov    0x20(%rsp),%rax
  114087:	cmp    %r9,%rax
  11408a:	mov    0x8(%rsp),%rdx
  11408f:	mov    0x10(%rsp),%rdi
  114094:	mov    0x18(%rsp),%r10
  114099:	mov    0x30(%rsp),%r8
  11409e:	jne    113fa7 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x297>
  1140a4:	jmp    1141cd <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x4bd>
  1140a9:	inc    %r12
  1140ac:	shl    $0x7,%rsi
  1140b0:	lea    (%r12,%rsi,1),%rdi
  1140b4:	inc    %rdi
  1140b7:	mov    0x8(%rsp),%rdx
  1140bc:	cmp    %r9,%r14
  1140bf:	mov    %rdx,%rax
  1140c2:	sbb    %rcx,%r15
  1140c5:	jb     113f49 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x239>
  1140cb:	sub    %rdi,%rax
  1140ce:	jb     1145b9 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x8a9>
  1140d4:	lea    -0x1(%rax),%rsi
  1140d8:	sub    %rdi,%rdx
  1140db:	je     114598 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x888>
  1140e1:	shl    $0x4,%rdi
  1140e5:	mov    %rsi,%rax
  1140e8:	shr    $0x7,%rax
  1140ec:	movabs $0xfffffffffffff,%r14
  1140f6:	and    %rax,%r14
  1140f9:	je     114175 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x465>
  1140fb:	mov    (%rsp),%rax
  1140ff:	lea    (%rax,%rdi,1),%rcx
  114103:	xor    %r9d,%r9d
  114106:	inc    %r9
  114109:	mov    $0x30,%eax
  11410e:	xchg   %ax,%ax
  114110:	mov    -0x20(%rcx,%rax,1),%rbx
  114115:	mov    -0x18(%rcx,%rax,1),%r11
  11411a:	cmp    -0x30(%rcx,%rax,1),%rbx
  11411f:	mov    %r11,%r8
  114122:	sbb    -0x28(%rcx,%rax,1),%r8
  114127:	jb     114289 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x579>
  11412d:	mov    -0x10(%rcx,%rax,1),%r10
  114132:	mov    -0x8(%rcx,%rax,1),%r8
  114137:	cmp    %rbx,%r10
  11413a:	mov    %r8,%rbx
  11413d:	sbb    %r11,%rbx
  114140:	jb     114289 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x579>
  114146:	lea    0x30(%rax),%r11
  11414a:	cmp    $0x840,%r11
  114151:	je     114169 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x459>
  114153:	mov    0x8(%rcx,%rax,1),%rbx
  114158:	cmp    %r10,(%rcx,%rax,1)
  11415c:	sbb    %r8,%rbx
  11415f:	mov    %r11,%rax
  114162:	jae    114110 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x400>
  114164:	jmp    114289 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x579>
  114169:	add    $0x800,%rcx
  114170:	cmp    %r14,%r9
  114173:	jne    114106 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x3f6>
  114175:	and    $0xffffffffffffff80,%rsi
  114179:	cmp    %rdx,%rsi
  11417c:	ja     1145c9 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x8b9>
  114182:	sub    %rsi,%rdx
  114185:	shl    $0x4,%rsi
  114189:	add    %rdi,%rsi
  11418c:	mov    (%rsp),%rax
  114190:	add    %rsi,%rax
  114193:	add    $0x10,%rax
  114197:	inc    %rdx
  11419a:	nopw   0x0(%rax,%rax,1)
  1141a0:	dec    %rdx
  1141a3:	cmp    $0x2,%rdx
  1141a7:	setb   %r8b
  1141ab:	jb     114579 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x869>
  1141b1:	mov    (%rax),%rcx
  1141b4:	mov    0x8(%rax),%rsi
  1141b8:	cmp    -0x10(%rax),%rcx
  1141bc:	sbb    -0x8(%rax),%rsi
  1141c0:	lea    0x10(%rax),%rax
  1141c4:	jae    1141a0 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x490>
  1141c6:	jmp    114579 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x869>
  1141cb:	xor    %ecx,%ecx
  1141cd:	and    $0xffffffffffffff80,%rsi
  1141d1:	mov    %r8,%r11
  1141d4:	sub    %rsi,%r11
  1141d7:	jb     1145dc <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x8cc>
  1141dd:	cmp    $0x2,%r11
  1141e1:	jb     114245 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x535>
  1141e3:	mov    (%rsp),%r9
  1141e7:	lea    (%r9,%r10,1),%rax
  1141eb:	shl    $0x4,%rsi
  1141ef:	mov    (%rax,%rsi,1),%r8
  1141f3:	mov    0x8(%rax,%rsi,1),%rbx
  1141f8:	inc    %r11
  1141fb:	add    %r10,%rsi
  1141fe:	add    %rsi,%r9
  114201:	add    $0x10,%r9
  114205:	data16 cs nopw 0x0(%rax,%rax,1)
  114210:	mov    (%r9),%rax
  114213:	mov    0x8(%r9),%rsi
  114217:	cmp    %rax,%r8
  11421a:	mov    %rbx,%r10
  11421d:	sbb    %rsi,%r10
  114220:	jb     114289 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x579>
  114222:	xor    %rax,%r8
  114225:	xor    %rsi,%rbx
  114228:	or     %r8,%rbx
  11422b:	sete   %r8b
  11422f:	or     %r8b,%cl
  114232:	dec    %r11
  114235:	add    $0x10,%r9
  114239:	mov    %rax,%r8
  11423c:	mov    %rsi,%rbx
  11423f:	cmp    $0x3,%r11
  114243:	jae    114210 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x500>
  114245:	mov    %rdx,%r14
  114248:	shr    $1,%r14
  11424b:	mov    %rdx,%rsi
  11424e:	shl    $0x4,%rsi
  114252:	lea    -0x1(%r14),%rax
  114256:	mov    %r14d,%r8d
  114259:	and    $0x3,%r8d
  11425d:	movabs $0xffffffffffffffe,%r10
  114267:	movabs $0xffffffffffffffd,%r11
  114271:	movabs $0xffffffffffffffc,%rbx
  11427b:	cmp    $0x3,%rax
  11427f:	jae    114291 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x581>
  114281:	xor    %r15d,%r15d
  114284:	jmp    11435b <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x64b>
  114289:	xor    %r8d,%r8d
  11428c:	jmp    114579 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x869>
  114291:	mov    (%rsp),%rdx
  114295:	lea    (%rdx,%rsi,1),%r12
  114299:	movabs $0x3fffffffffffffc,%rax
  1142a3:	and    %rax,%r14
  1142a6:	lea    0x30(%rdx),%r13
  1142aa:	lea    (%rsi,%rdx,1),%rbp
  1142ae:	add    $0xfffffffffffffff0,%rbp
  1142b2:	xor    %r15d,%r15d
  1142b5:	data16 cs nopw 0x0(%rax,%rax,1)
  1142c0:	vmovaps -0x30(%r13),%xmm0
  1142c6:	vmovaps 0x0(%rbp),%xmm1
  1142cb:	vmovaps %xmm1,-0x30(%r13)
  1142d1:	vmovaps %xmm0,0x0(%rbp)
  1142d6:	mov    %r15,%rax
  1142d9:	xor    %r10,%rax
  1142dc:	shl    $0x4,%rax
  1142e0:	vmovaps -0x20(%r13),%xmm0
  1142e6:	vmovaps (%r12,%rax,1),%xmm1
  1142ec:	vmovaps %xmm1,-0x20(%r13)
  1142f2:	vmovaps %xmm0,(%r12,%rax,1)
  1142f8:	mov    %r15,%rax
  1142fb:	xor    %r11,%rax
  1142fe:	shl    $0x4,%rax
  114302:	vmovaps -0x10(%r13),%xmm0
  114308:	vmovaps (%r12,%rax,1),%xmm1
  11430e:	vmovaps %xmm1,-0x10(%r13)
  114314:	vmovaps %xmm0,(%r12,%rax,1)
  11431a:	mov    %r15,%rax
  11431d:	xor    %rbx,%rax
  114320:	shl    $0x4,%rax
  114324:	vmovaps 0x0(%r13),%xmm0
  11432a:	vmovaps (%r12,%rax,1),%xmm1
  114330:	vmovaps %xmm1,0x0(%r13)
  114336:	vmovaps %xmm0,(%r12,%rax,1)
  11433c:	add    $0x4,%r15
  114340:	add    $0x40,%r13
  114344:	add    $0xffffffffffffffc0,%rbp
  114348:	cmp    %r15,%r14
  11434b:	jne    1142c0 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x5b0>
  114351:	test   %r8,%r8
  114354:	mov    0x8(%rsp),%rdx
  114359:	je     1143a1 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x691>
  11435b:	shl    $0x4,%r15
  11435f:	mov    (%rsp),%r9
  114363:	lea    (%r9,%r15,1),%rax
  114367:	sub    %r15,%rsi
  11436a:	add    %r9,%rsi
  11436d:	add    $0xfffffffffffffff0,%rsi
  114371:	shl    $0x4,%r8d
  114375:	xor    %r9d,%r9d
  114378:	nopl   0x0(%rax,%rax,1)
  114380:	vmovaps (%rax,%r9,1),%xmm0
  114386:	vmovaps (%rsi),%xmm1
  11438a:	vmovaps %xmm1,(%rax,%r9,1)
  114390:	vmovaps %xmm0,(%rsi)
  114394:	add    $0x10,%r9
  114398:	add    $0xfffffffffffffff0,%rsi
  11439c:	cmp    %r9,%r8
  11439f:	jne    114380 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x670>
  1143a1:	cmp    $0x2,%rdi
  1143a5:	setae  %al
  1143a8:	or     %cl,%al
  1143aa:	test   $0x1,%al
  1143ac:	je     114576 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x866>
  1143b2:	mov    (%rsp),%rax
  1143b6:	lea    0x10(%rax),%rcx
  1143ba:	mov    %rcx,0x20(%rsp)
  1143bf:	lea    0x30(%rax),%rcx
  1143c3:	mov    %rcx,0x18(%rsp)
  1143c8:	add    $0xfffffffffffffff0,%rax
  1143cc:	mov    %rax,0x10(%rsp)
  1143d1:	xor    %esi,%esi
  1143d3:	jmp    1143ee <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x6de>
  1143d5:	data16 cs nopw 0x0(%rax,%rax,1)
  1143e0:	mov    0x8(%rsp),%rdx
  1143e5:	cmp    %rdx,%rsi
  1143e8:	jae    114576 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x866>
  1143ee:	mov    %rsi,%rdi
  1143f1:	mov    %rsi,%r15
  1143f4:	shl    $0x4,%r15
  1143f8:	mov    (%rsp),%rcx
  1143fc:	mov    (%rcx,%r15,1),%rax
  114400:	mov    0x8(%rcx,%r15,1),%r13
  114405:	lea    0x1(%rsi),%rcx
  114409:	cmp    %rcx,%rdx
  11440c:	cmova  %rdx,%rcx
  114410:	lea    -0x1(%rcx),%r8
  114414:	mov    0x20(%rsp),%r9
  114419:	add    %r15,%r9
  11441c:	nopl   0x0(%rax)
  114420:	cmp    %rsi,%r8
  114423:	je     114440 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x730>
  114425:	inc    %rsi
  114428:	mov    (%r9),%r14
  11442b:	xor    %rax,%r14
  11442e:	mov    0x8(%r9),%r12
  114432:	xor    %r13,%r12
  114435:	add    $0x10,%r9
  114439:	or     %r14,%r12
  11443c:	je     114420 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x710>
  11443e:	jmp    114443 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x733>
  114440:	mov    %rcx,%rsi
  114443:	mov    %rsi,%rax
  114446:	sub    %rdi,%rax
  114449:	jb     11458b <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x87b>
  11444f:	mov    %rax,%r13
  114452:	shr    $1,%r13
  114455:	je     1143e0 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x6d0>
  114457:	mov    %rsi,%rdx
  11445a:	shl    $0x4,%rdx
  11445e:	mov    %r13d,%r12d
  114461:	and    $0x3,%r12d
  114465:	cmp    $0x8,%rax
  114469:	jae    114480 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x770>
  11446b:	xor    %ebp,%ebp
  11446d:	jmp    114536 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x826>
  114472:	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
  114480:	mov    (%rsp),%rax
  114484:	lea    (%rax,%rdx,1),%r9
  114488:	and    $0xfffffffffffffffc,%r13
  11448c:	mov    0x18(%rsp),%rax
  114491:	lea    (%rax,%r15,1),%r14
  114495:	mov    0x10(%rsp),%rax
  11449a:	lea    (%rax,%rdx,1),%rcx
  11449e:	xor    %ebp,%ebp
  1144a0:	vmovaps -0x30(%r14),%xmm0
  1144a6:	vmovaps (%rcx),%xmm1
  1144aa:	vmovaps %xmm1,-0x30(%r14)
  1144b0:	vmovaps %xmm0,(%rcx)
  1144b4:	mov    %rbp,%rax
  1144b7:	xor    %r10,%rax
  1144ba:	shl    $0x4,%rax
  1144be:	vmovaps -0x20(%r14),%xmm0
  1144c4:	vmovaps (%r9,%rax,1),%xmm1
  1144ca:	vmovaps %xmm1,-0x20(%r14)
  1144d0:	vmovaps %xmm0,(%r9,%rax,1)
  1144d6:	mov    %rbp,%rax
  1144d9:	xor    %r11,%rax
  1144dc:	shl    $0x4,%rax
  1144e0:	vmovaps -0x10(%r14),%xmm0
  1144e6:	vmovaps (%r9,%rax,1),%xmm1
  1144ec:	vmovaps %xmm1,-0x10(%r14)
  1144f2:	vmovaps %xmm0,(%r9,%rax,1)
  1144f8:	mov    %rbp,%rax
  1144fb:	xor    %rbx,%rax
  1144fe:	shl    $0x4,%rax
  114502:	vmovaps (%r14),%xmm0
  114507:	vmovaps (%r9,%rax,1),%xmm1
  11450d:	vmovaps %xmm1,(%r14)
  114512:	vmovaps %xmm0,(%r9,%rax,1)
  114518:	add    $0x4,%rbp
  11451c:	add    $0x40,%r14
  114520:	add    $0xffffffffffffffc0,%rcx
  114524:	cmp    %rbp,%r13
  114527:	jne    1144a0 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x790>
  11452d:	test   %r12,%r12
  114530:	je     1143e0 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x6d0>
  114536:	shl    $0x4,%rbp
  11453a:	add    (%rsp),%r15
  11453e:	add    %rbp,%r15
  114541:	sub    %rbp,%rdx
  114544:	add    0x10(%rsp),%rdx
  114549:	shl    $0x4,%r12d
  11454d:	xor    %eax,%eax
  11454f:	nop
  114550:	vmovaps (%r15,%rax,1),%xmm0
  114556:	vmovaps (%rdx),%xmm1
  11455a:	vmovaps %xmm1,(%r15,%rax,1)
  114560:	vmovaps %xmm0,(%rdx)
  114564:	add    $0x10,%rax
  114568:	add    $0xfffffffffffffff0,%rdx
  11456c:	cmp    %rax,%r12
  11456f:	jne    114550 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x840>
  114571:	jmp    1143e0 <block_msd_research::frontier::ordered_tiled::ordered::<u128, u128>+0x6d0>
  114576:	mov    $0x1,%r8b
  114579:	mov    %r8d,%eax
  11457c:	add    $0x38,%rsp
  114580:	pop    %rbx
  114581:	pop    %r12
  114583:	pop    %r13
  114585:	pop    %r14
  114587:	pop    %r15
  114589:	pop    %rbp
  11458a:	ret
  11458b:	lea    0x3a409e(%rip),%rcx        # 4b8630 <anon.005357b6259aec7dbb5efeaf9c6c1e46.1.llvm.5840278210049151275>
  114592:	call   *0x3a6610(%rip)        # 4baba8 <_DYNAMIC+0x298>
  114598:	lea    0x39b1c9(%rip),%rcx        # 4af768 <anon.4f09dbc27bc51892750e1edd1fc396d9.1.llvm.4484181053944774123+0x60>
  11459f:	xor    %edi,%edi
  1145a1:	xor    %edx,%edx
  1145a3:	call   *0x3a65ff(%rip)        # 4baba8 <_DYNAMIC+0x298>
  1145a9:	lea    0x39b1a0(%rip),%rcx        # 4af750 <anon.4f09dbc27bc51892750e1edd1fc396d9.1.llvm.4484181053944774123+0x48>
  1145b0:	mov    %rdx,%rsi
  1145b3:	call   *0x3a65ef(%rip)        # 4baba8 <_DYNAMIC+0x298>
  1145b9:	lea    0x39b178(%rip),%rcx        # 4af738 <anon.4f09dbc27bc51892750e1edd1fc396d9.1.llvm.4484181053944774123+0x30>
  1145c0:	mov    %rdx,%rsi
  1145c3:	call   *0x3a65df(%rip)        # 4baba8 <_DYNAMIC+0x298>
  1145c9:	lea    0x39b1b0(%rip),%rcx        # 4af780 <anon.4f09dbc27bc51892750e1edd1fc396d9.1.llvm.4484181053944774123+0x78>
  1145d0:	mov    %rsi,%rdi
  1145d3:	mov    %rdx,%rsi
  1145d6:	call   *0x3a65cc(%rip)        # 4baba8 <_DYNAMIC+0x298>
  1145dc:	lea    0x39b19d(%rip),%rcx        # 4af780 <anon.4f09dbc27bc51892750e1edd1fc396d9.1.llvm.4484181053944774123+0x78>
  1145e3:	mov    %rsi,%rdi
  1145e6:	mov    %r8,%rsi
  1145e9:	mov    %r8,%rdx
  1145ec:	call   *0x3a65b6(%rip)        # 4baba8 <_DYNAMIC+0x298>
