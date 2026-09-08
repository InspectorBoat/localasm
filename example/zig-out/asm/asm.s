.LCPI0_0:
	.zero	64,1
.LCPI0_1:
	.zero	16,1
main.block_unroll_reduce_dependency_chain:
	push	rbp
	mov	rbp, rsp
	vbroadcasti32x4	zmm0, xmmword ptr [rip + .LCPI0_1]
	lea	rax, [rdi + 928]
	lea	rcx, [rsi + 3584]
	xor	edx, edx
.LBB0_1:
	kmovq	k1, qword ptr [rdi + 8*rdx]
	kmovq	k2, qword ptr [rdi + 8*rdx + 32]
	kmovq	k3, qword ptr [rdi + 8*rdx + 64]
	kmovq	k4, qword ptr [rdi + 8*rdx + 96]
	lea	r8, [4*rdx]
	mov	r9, rdx
	shl	r9, 6
	xor	r10d, r10d
	vmovdqu8	zmm1 {k1} {z}, zmm0
	kmovq	k1, qword ptr [rdi + 8*rdx + 128]
	vpmovm2b	zmm2, k2
	vpsubb	zmm2, zmm1, zmm2
	vpmovm2b	zmm3, k3
	vpmovm2b	zmm4, k4
	vmovdqu8	zmm15 {k2} {z}, zmm0
	vmovdqu8	zmm14 {k3} {z}, zmm0
	vpsubb	zmm2, zmm2, zmm3
	vmovdqu8	zmm3 {k4} {z}, zmm0
	vpsubb	zmm2, zmm2, zmm4
	vpmovm2b	zmm5, k1
	vmovdqu8	zmm4 {k1} {z}, zmm0
	kmovq	k1, qword ptr [rdi + 8*rdx + 160]
	vpsubb	zmm2, zmm2, zmm5
	vpmovm2b	zmm6, k1
	vmovdqu8	zmm5 {k1} {z}, zmm0
	kmovq	k1, qword ptr [rdi + 8*rdx + 192]
	vpsubb	zmm2, zmm2, zmm6
	vpmovm2b	zmm7, k1
	vmovdqu8	zmm6 {k1} {z}, zmm0
	kmovq	k1, qword ptr [rdi + 8*rdx + 224]
	vpsubb	zmm2, zmm2, zmm7
	vpmovm2b	zmm8, k1
	vmovdqu8	zmm7 {k1} {z}, zmm0
	kmovq	k1, qword ptr [rdi + 8*rdx + 256]
	vpsubb	zmm2, zmm2, zmm8
	vpmovm2b	zmm9, k1
	vmovdqu8	zmm8 {k1} {z}, zmm0
	kmovq	k1, qword ptr [rdi + 8*rdx + 288]
	vpsubb	zmm2, zmm2, zmm9
	vpmovm2b	zmm10, k1
	vmovdqu8	zmm9 {k1} {z}, zmm0
	kmovq	k1, qword ptr [rdi + 8*rdx + 320]
	vpsubb	zmm2, zmm2, zmm10
	vpmovm2b	zmm11, k1
	vmovdqu8	zmm10 {k1} {z}, zmm0
	kmovq	k1, qword ptr [rdi + 8*rdx + 352]
	vpsubb	zmm2, zmm2, zmm11
	vpmovm2b	zmm12, k1
	vmovdqu8	zmm11 {k1} {z}, zmm0
	kmovq	k1, qword ptr [rdi + 8*rdx + 384]
	vpsubb	zmm2, zmm2, zmm12
	vpmovm2b	zmm13, k1
	vmovdqu8	zmm12 {k1} {z}, zmm0
	kmovq	k1, qword ptr [rdi + 8*rdx + 416]
	vpsubb	zmm2, zmm2, zmm13
	vpmovm2b	zmm16, k1
	vmovdqu8	zmm13 {k1} {z}, zmm0
	kmovq	k1, qword ptr [rdi + 8*rdx + 448]
	vpsubb	zmm16, zmm2, zmm16
	vpmovm2b	zmm17, k1
	vpsubb	zmm18, zmm16, zmm17
	vmovdqu8	zmm2 {k1} {z}, zmm0
.LBB0_2:
	vmovdqa64	zmmword ptr [rcx + 8*r10 - 3584], zmm18
	vmovdqa64	zmm16, zmm1
	kmovq	k1, qword ptr [rax + r10 - 448]
	vmovdqu8	zmm1 {k1} {z}, zmm0
	vpsubb	zmm16, zmm1, zmm16
	vpaddb	zmm17, zmm16, zmm18
	vmovdqa64	zmmword ptr [rcx + 8*r10 - 3328], zmm17
	kmovq	k1, qword ptr [rax + r10 - 416]
	vmovdqu8	zmm16 {k1} {z}, zmm0
	vpsubb	zmm15, zmm16, zmm15
	vpaddb	zmm15, zmm15, zmm17
	vmovdqa64	zmmword ptr [rcx + 8*r10 - 3072], zmm15
	kmovq	k1, qword ptr [rax + r10 - 384]
	vmovdqu8	zmm17 {k1} {z}, zmm0
	vpsubb	zmm14, zmm17, zmm14
	vpaddb	zmm14, zmm14, zmm15
	vmovdqa64	zmm15, zmm16
	vmovdqa64	zmmword ptr [rcx + 8*r10 - 2816], zmm14
	kmovq	k1, qword ptr [rax + r10 - 352]
	vmovdqu8	zmm19 {k1} {z}, zmm0
	vpsubb	zmm3, zmm19, zmm3
	vpaddb	zmm3, zmm3, zmm14
	vmovdqa64	zmm14, zmm17
	vmovdqa64	zmmword ptr [rcx + 8*r10 - 2560], zmm3
	kmovq	k1, qword ptr [rax + r10 - 320]
	vmovdqu8	zmm20 {k1} {z}, zmm0
	vpsubb	zmm4, zmm20, zmm4
	vpaddb	zmm3, zmm4, zmm3
	vmovdqa64	zmmword ptr [rcx + 8*r10 - 2304], zmm3
	kmovq	k1, qword ptr [rax + r10 - 288]
	vmovdqu8	zmm21 {k1} {z}, zmm0
	vpsubb	zmm4, zmm21, zmm5
	vmovdqa64	zmm5, zmm21
	vpaddb	zmm3, zmm4, zmm3
	vmovdqa64	zmmword ptr [rcx + 8*r10 - 2048], zmm3
	kmovq	k1, qword ptr [rax + r10 - 256]
	vmovdqu8	zmm22 {k1} {z}, zmm0
	vpsubb	zmm4, zmm22, zmm6
	vmovdqa64	zmm6, zmm22
	vpaddb	zmm3, zmm4, zmm3
	vmovdqa64	zmmword ptr [rcx + 8*r10 - 1792], zmm3
	kmovq	k1, qword ptr [rax + r10 - 224]
	vmovdqu8	zmm23 {k1} {z}, zmm0
	vpsubb	zmm4, zmm23, zmm7
	vmovdqa64	zmm7, zmm23
	vpaddb	zmm3, zmm4, zmm3
	vmovdqa64	zmmword ptr [rcx + 8*r10 - 1536], zmm3
	kmovq	k1, qword ptr [rax + r10 - 192]
	vmovdqu8	zmm24 {k1} {z}, zmm0
	vpsubb	zmm4, zmm24, zmm8
	vmovdqa64	zmm8, zmm24
	vpaddb	zmm3, zmm4, zmm3
	vmovdqa64	zmmword ptr [rcx + 8*r10 - 1280], zmm3
	kmovq	k1, qword ptr [rax + r10 - 160]
	vmovdqu8	zmm25 {k1} {z}, zmm0
	vpsubb	zmm4, zmm25, zmm9
	vmovdqa64	zmm9, zmm25
	vpaddb	zmm3, zmm4, zmm3
	vmovdqa64	zmmword ptr [rcx + 8*r10 - 1024], zmm3
	kmovq	k1, qword ptr [rax + r10 - 128]
	vmovdqu8	zmm26 {k1} {z}, zmm0
	vpsubb	zmm4, zmm26, zmm10
	vmovdqa64	zmm10, zmm26
	vpaddb	zmm3, zmm4, zmm3
	vmovdqa64	zmmword ptr [rcx + 8*r10 - 768], zmm3
	kmovq	k1, qword ptr [rax + r10 - 96]
	vmovdqu8	zmm27 {k1} {z}, zmm0
	vpsubb	zmm4, zmm27, zmm11
	vmovdqa64	zmm11, zmm27
	vpaddb	zmm3, zmm4, zmm3
	vmovdqa64	zmmword ptr [rcx + 8*r10 - 512], zmm3
	kmovq	k1, qword ptr [rax + r10 - 64]
	vmovdqu8	zmm28 {k1} {z}, zmm0
	vpsubb	zmm4, zmm28, zmm12
	vmovdqa64	zmm12, zmm28
	vpaddb	zmm3, zmm4, zmm3
	vmovdqa64	zmmword ptr [rcx + 8*r10 - 256], zmm3
	kmovq	k1, qword ptr [rax + r10 - 32]
	vmovdqu8	zmm29 {k1} {z}, zmm0
	vpsubb	zmm4, zmm29, zmm13
	vmovdqa64	zmm13, zmm29
	vpaddb	zmm3, zmm4, zmm3
	vmovdqa64	zmmword ptr [rcx + 8*r10], zmm3
	vpsubb	zmm2, zmm3, zmm2
	kmovq	k1, qword ptr [rax + r10]
	add	r10, 480
	vpmovm2b	zmm4, k1
	vpsubb	zmm18, zmm2, zmm4
	vmovdqu8	zmm3 {k1} {z}, zmm0
	vmovdqa64	zmm2, zmm3
	vmovdqa64	zmm3, zmm19
	vmovdqa64	zmm4, zmm20
	cmp	r10, 7680
	jne	.LBB0_2
	vmovdqa64	zmmword ptr [rsi + r9 + 61440], zmm18
	inc	rdx
	add	rax, 8
	add	rcx, 64
	kmovq	k1, qword ptr [rdi + 2*r8 + 8160]
	vmovdqu8	zmm2 {k1} {z}, zmmword ptr [rip + .LCPI0_0]
	vpsubb	zmm1, zmm2, zmm1
	vpaddb	zmm1, zmm1, zmm18
	vmovdqa64	zmmword ptr [rsi + r9 + 61696], zmm1
	cmp	rdx, 4
	jne	.LBB0_1
	pop	rbp
	vzeroupper
	ret
.LCPI1_1:
	.zero	16,1
main.block_unroll:
	push	rbp
	mov	rbp, rsp
	vbroadcasti32x4	zmm0, xmmword ptr [rip + .LCPI1_1]
	lea	rax, [rdi + 928]
	lea	rcx, [rsi + 3584]
	xor	edx, edx
.LBB1_1:
	kmovq	k1, qword ptr [rdi + 8*rdx]
	kmovq	k2, qword ptr [rdi + 8*rdx + 32]
	kmovq	k3, qword ptr [rdi + 8*rdx + 64]
	kmovq	k4, qword ptr [rdi + 8*rdx + 96]
	lea	r8, [4*rdx]
	mov	r9, rdx
	shl	r9, 6
	xor	r10d, r10d
	vpmovm2b	zmm1, k1
	vmovdqu8	zmm2 {k1} {z}, zmm0
	kmovq	k1, qword ptr [rdi + 8*rdx + 128]
	vpmovm2b	zmm3, k2
	vpsubb	zmm2, zmm2, zmm3
	vpmovm2b	zmm3, k3
	vmovdqu8	zmm15 {k2} {z}, zmm0
	vmovdqu8	zmm14 {k3} {z}, zmm0
	vmovdqu8	zmm13 {k4} {z}, zmm0
	vpsubb	zmm2, zmm2, zmm3
	vpmovm2b	zmm3, k4
	vpsubb	zmm2, zmm2, zmm3
	vpmovm2b	zmm3, k1
	vmovdqu8	zmm12 {k1} {z}, zmm0
	kmovq	k1, qword ptr [rdi + 8*rdx + 160]
	vpsubb	zmm2, zmm2, zmm3
	vpmovm2b	zmm3, k1
	vmovdqu8	zmm11 {k1} {z}, zmm0
	kmovq	k1, qword ptr [rdi + 8*rdx + 192]
	vpsubb	zmm2, zmm2, zmm3
	vpmovm2b	zmm3, k1
	vmovdqu8	zmm10 {k1} {z}, zmm0
	kmovq	k1, qword ptr [rdi + 8*rdx + 224]
	vpsubb	zmm2, zmm2, zmm3
	vpmovm2b	zmm3, k1
	vmovdqu8	zmm9 {k1} {z}, zmm0
	kmovq	k1, qword ptr [rdi + 8*rdx + 256]
	vpsubb	zmm2, zmm2, zmm3
	vpmovm2b	zmm3, k1
	vmovdqu8	zmm8 {k1} {z}, zmm0
	kmovq	k1, qword ptr [rdi + 8*rdx + 288]
	vpsubb	zmm2, zmm2, zmm3
	vpmovm2b	zmm3, k1
	vmovdqu8	zmm7 {k1} {z}, zmm0
	kmovq	k1, qword ptr [rdi + 8*rdx + 320]
	vpsubb	zmm2, zmm2, zmm3
	vpmovm2b	zmm3, k1
	vmovdqu8	zmm6 {k1} {z}, zmm0
	kmovq	k1, qword ptr [rdi + 8*rdx + 352]
	vpsubb	zmm2, zmm2, zmm3
	vpmovm2b	zmm3, k1
	vmovdqu8	zmm5 {k1} {z}, zmm0
	kmovq	k1, qword ptr [rdi + 8*rdx + 384]
	vpsubb	zmm2, zmm2, zmm3
	vpmovm2b	zmm3, k1
	vmovdqu8	zmm4 {k1} {z}, zmm0
	kmovq	k1, qword ptr [rdi + 8*rdx + 416]
	vpsubb	zmm2, zmm2, zmm3
	vpmovm2b	zmm16, k1
	vmovdqu8	zmm3 {k1} {z}, zmm0
	kmovq	k1, qword ptr [rdi + 8*rdx + 448]
	vpsubb	zmm16, zmm2, zmm16
	vpmovm2b	zmm17, k1
	vpsubb	zmm16, zmm16, zmm17
	vmovdqu8	zmm2 {k1} {z}, zmm0
.LBB1_2:
	vmovdqa64	zmmword ptr [rcx + 8*r10 - 3584], zmm16
	vpaddb	zmm16, zmm16, zmm1
	kmovq	k0, qword ptr [rax + r10 - 448]
	vpmovm2b	zmm1, k0
	vpsubb	zmm16, zmm16, zmm1
	vmovdqa64	zmmword ptr [rcx + 8*r10 - 3328], zmm16
	vpsubb	zmm16, zmm16, zmm15
	kmovq	k1, qword ptr [rax + r10 - 416]
	vpmovm2b	zmm17, k1
	vpsubb	zmm16, zmm16, zmm17
	vmovdqu8	zmm15 {k1} {z}, zmm0
	vmovdqa64	zmmword ptr [rcx + 8*r10 - 3072], zmm16
	vpsubb	zmm16, zmm16, zmm14
	kmovq	k1, qword ptr [rax + r10 - 384]
	vpmovm2b	zmm17, k1
	vpsubb	zmm16, zmm16, zmm17
	vmovdqu8	zmm14 {k1} {z}, zmm0
	vmovdqa64	zmmword ptr [rcx + 8*r10 - 2816], zmm16
	vpsubb	zmm16, zmm16, zmm13
	kmovq	k1, qword ptr [rax + r10 - 352]
	vpmovm2b	zmm17, k1
	vpsubb	zmm16, zmm16, zmm17
	vmovdqu8	zmm13 {k1} {z}, zmm0
	vmovdqa64	zmmword ptr [rcx + 8*r10 - 2560], zmm16
	vpsubb	zmm16, zmm16, zmm12
	kmovq	k1, qword ptr [rax + r10 - 320]
	vpmovm2b	zmm17, k1
	vpsubb	zmm16, zmm16, zmm17
	vmovdqu8	zmm12 {k1} {z}, zmm0
	vmovdqa64	zmmword ptr [rcx + 8*r10 - 2304], zmm16
	vpsubb	zmm16, zmm16, zmm11
	kmovq	k1, qword ptr [rax + r10 - 288]
	vpmovm2b	zmm17, k1
	vpsubb	zmm16, zmm16, zmm17
	vmovdqu8	zmm11 {k1} {z}, zmm0
	vmovdqa64	zmmword ptr [rcx + 8*r10 - 2048], zmm16
	vpsubb	zmm16, zmm16, zmm10
	kmovq	k1, qword ptr [rax + r10 - 256]
	vpmovm2b	zmm17, k1
	vpsubb	zmm16, zmm16, zmm17
	vmovdqu8	zmm10 {k1} {z}, zmm0
	vmovdqa64	zmmword ptr [rcx + 8*r10 - 1792], zmm16
	vpsubb	zmm16, zmm16, zmm9
	kmovq	k1, qword ptr [rax + r10 - 224]
	vpmovm2b	zmm17, k1
	vpsubb	zmm16, zmm16, zmm17
	vmovdqu8	zmm9 {k1} {z}, zmm0
	vmovdqa64	zmmword ptr [rcx + 8*r10 - 1536], zmm16
	vpsubb	zmm8, zmm16, zmm8
	kmovq	k1, qword ptr [rax + r10 - 192]
	vpmovm2b	zmm16, k1
	vpsubb	zmm8, zmm8, zmm16
	vmovdqu8	zmm17 {k1} {z}, zmm0
	vmovdqa64	zmmword ptr [rcx + 8*r10 - 1280], zmm8
	vpsubb	zmm7, zmm8, zmm7
	kmovq	k1, qword ptr [rax + r10 - 160]
	vpmovm2b	zmm8, k1
	vpsubb	zmm7, zmm7, zmm8
	vmovdqu8	zmm18 {k1} {z}, zmm0
	vmovdqa64	zmm8, zmm17
	vmovdqa64	zmmword ptr [rcx + 8*r10 - 1024], zmm7
	vpsubb	zmm6, zmm7, zmm6
	kmovq	k1, qword ptr [rax + r10 - 128]
	vpmovm2b	zmm7, k1
	vpsubb	zmm6, zmm6, zmm7
	vmovdqu8	zmm19 {k1} {z}, zmm0
	vmovdqa64	zmm7, zmm18
	vmovdqa64	zmmword ptr [rcx + 8*r10 - 768], zmm6
	vpsubb	zmm5, zmm6, zmm5
	kmovq	k1, qword ptr [rax + r10 - 96]
	vpmovm2b	zmm6, k1
	vpsubb	zmm5, zmm5, zmm6
	vmovdqu8	zmm20 {k1} {z}, zmm0
	vmovdqa64	zmm6, zmm19
	vmovdqa64	zmmword ptr [rcx + 8*r10 - 512], zmm5
	vpsubb	zmm4, zmm5, zmm4
	kmovq	k1, qword ptr [rax + r10 - 64]
	vpmovm2b	zmm5, k1
	vpsubb	zmm4, zmm4, zmm5
	vmovdqu8	zmm21 {k1} {z}, zmm0
	vmovdqa64	zmm5, zmm20
	vmovdqa64	zmmword ptr [rcx + 8*r10 - 256], zmm4
	vpsubb	zmm3, zmm4, zmm3
	kmovq	k1, qword ptr [rax + r10 - 32]
	vpmovm2b	zmm4, k1
	vpsubb	zmm3, zmm3, zmm4
	vmovdqu8	zmm22 {k1} {z}, zmm0
	vmovdqa64	zmmword ptr [rcx + 8*r10], zmm3
	vpsubb	zmm2, zmm3, zmm2
	kmovq	k1, qword ptr [rax + r10]
	add	r10, 480
	vpmovm2b	zmm4, k1
	vpsubb	zmm16, zmm2, zmm4
	vmovdqu8	zmm3 {k1} {z}, zmm0
	vmovdqa64	zmm2, zmm3
	vmovdqa64	zmm4, zmm21
	vmovdqa64	zmm3, zmm22
	cmp	r10, 7680
	jne	.LBB1_2
	vmovdqa64	zmmword ptr [rsi + r9 + 61440], zmm16
	vpaddb	zmm1, zmm16, zmm1
	inc	rdx
	add	rax, 8
	add	rcx, 64
	kmovq	k0, qword ptr [rdi + 2*r8 + 8160]
	vpmovm2b	zmm2, k0
	vpsubb	zmm1, zmm1, zmm2
	vmovdqa64	zmmword ptr [rsi + r9 + 61696], zmm1
	cmp	rdx, 4
	jne	.LBB1_1
	pop	rbp
	vzeroupper
	ret
