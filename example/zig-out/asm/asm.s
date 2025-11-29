
_start:
	#APP
	#NO_APP
	#APP
	xor	ebp, ebp
	mov	rdi, rsp
	and	rsp, -16
	call	start.posixCallMainAndExit
	#NO_APP

start.posixCallMainAndExit:
	push	rbp
	mov	rbp, rsp
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbx
	sub	rsp, 40
	mov	rsi, qword ptr [rdi]
	mov	rbx, rdi
	add	rbx, 8
	mov	r15, -1
	lea	rdi, [rdi + 8*rsi + 16]
	mov	rax, rdi
.LBB1_1:
	inc	r15
	cmp	qword ptr [rax], 0
	lea	rax, [rax + 8]
	jne	.LBB1_1
	lea	rcx, [rax + 8]
	xor	r12d, r12d
	xor	r14d, r14d
	mov	rdx, qword ptr [rcx - 8]
	cmp	rdx, 3
	jne	.LBB1_5
	jmp	.LBB1_4
.LBB1_3:
	mov	r12, qword ptr [rcx]
	add	rcx, 16
	mov	rdx, qword ptr [rcx - 8]
	cmp	rdx, 3
	je	.LBB1_4
.LBB1_5:
	cmp	rdx, 5
	je	.LBB1_3
	test	rdx, rdx
	jne	.LBB1_7
	jmp	.LBB1_8
.LBB1_4:
	mov	r14, qword ptr [rcx]
.LBB1_7:
	add	rcx, 16
	mov	rdx, qword ptr [rcx - 8]
	cmp	rdx, 3
	jne	.LBB1_5
	jmp	.LBB1_4
.LBB1_8:
	mov	qword ptr [rip + os.linux.elf_aux_maybe], rax
	movabs	rcx, -6148914691236517206
	mov	eax, 8
	mov	rdx, -1
	mov	qword ptr [rbp - 80], rsi
	mov	qword ptr [rbp - 72], rdi
	test	r12, r12
	je	.LBB1_9
	mov	esi, r12d
	and	esi, 7
	cmp	r12, 8
	jae	.LBB1_15
	xor	edi, edi
	xor	r8d, r8d
	xor	r9d, r9d
.LBB1_12:
	test	rsi, rsi
	jne	.LBB1_49
.LBB1_13:
	test	rdi, rdi
	jne	.LBB1_55
.LBB1_9:
	xor	esi, esi
	jmp	.LBB1_56
.LBB1_15:
	mov	r10, r12
	and	r10, -8
	xor	edi, edi
	mov	r11, r14
	xor	r8d, r8d
	xor	r9d, r9d
	jmp	.LBB1_18
.LBB1_16:
	mov	r8, r14
	sub	r8, qword ptr [r11 + 408]
.LBB1_17:
	add	r9, 8
	add	r11, 448
	cmp	r10, r9
	je	.LBB1_12
.LBB1_18:
	mov	r13d, dword ptr [r11]
	cmp	r13d, 6
	je	.LBB1_40
	cmp	r13d, 7
	jne	.LBB1_21
	mov	rdi, r11
.LBB1_21:
	mov	r13d, dword ptr [r11 + 56]
	cmp	r13d, 6
	je	.LBB1_41
.LBB1_22:
	cmp	r13d, 7
	jne	.LBB1_24
	lea	rdi, [r11 + 56]
.LBB1_24:
	mov	r13d, dword ptr [r11 + 112]
	cmp	r13d, 6
	je	.LBB1_42
.LBB1_25:
	cmp	r13d, 7
	jne	.LBB1_27
	lea	rdi, [r11 + 112]
.LBB1_27:
	mov	r13d, dword ptr [r11 + 168]
	cmp	r13d, 6
	je	.LBB1_43
.LBB1_28:
	cmp	r13d, 7
	jne	.LBB1_30
	lea	rdi, [r11 + 168]
.LBB1_30:
	mov	r13d, dword ptr [r11 + 224]
	cmp	r13d, 6
	je	.LBB1_44
.LBB1_31:
	cmp	r13d, 7
	jne	.LBB1_33
	lea	rdi, [r11 + 224]
.LBB1_33:
	mov	r13d, dword ptr [r11 + 280]
	cmp	r13d, 6
	je	.LBB1_45
.LBB1_34:
	cmp	r13d, 7
	jne	.LBB1_36
	lea	rdi, [r11 + 280]
.LBB1_36:
	mov	r13d, dword ptr [r11 + 336]
	cmp	r13d, 6
	je	.LBB1_46
.LBB1_37:
	cmp	r13d, 7
	jne	.LBB1_39
	lea	rdi, [r11 + 336]
.LBB1_39:
	mov	r13d, dword ptr [r11 + 392]
	cmp	r13d, 6
	jne	.LBB1_47
	jmp	.LBB1_16
.LBB1_40:
	mov	r8, r14
	sub	r8, qword ptr [r11 + 16]
	mov	r13d, dword ptr [r11 + 56]
	cmp	r13d, 6
	jne	.LBB1_22
.LBB1_41:
	mov	r8, r14
	sub	r8, qword ptr [r11 + 72]
	mov	r13d, dword ptr [r11 + 112]
	cmp	r13d, 6
	jne	.LBB1_25
.LBB1_42:
	mov	r8, r14
	sub	r8, qword ptr [r11 + 128]
	mov	r13d, dword ptr [r11 + 168]
	cmp	r13d, 6
	jne	.LBB1_28
.LBB1_43:
	mov	r8, r14
	sub	r8, qword ptr [r11 + 184]
	mov	r13d, dword ptr [r11 + 224]
	cmp	r13d, 6
	jne	.LBB1_31
.LBB1_44:
	mov	r8, r14
	sub	r8, qword ptr [r11 + 240]
	mov	r13d, dword ptr [r11 + 280]
	cmp	r13d, 6
	jne	.LBB1_34
.LBB1_45:
	mov	r8, r14
	sub	r8, qword ptr [r11 + 296]
	mov	r13d, dword ptr [r11 + 336]
	cmp	r13d, 6
	jne	.LBB1_37
.LBB1_46:
	mov	r8, r14
	sub	r8, qword ptr [r11 + 352]
	mov	r13d, dword ptr [r11 + 392]
	cmp	r13d, 6
	je	.LBB1_16
.LBB1_47:
	cmp	r13d, 7
	jne	.LBB1_17
	lea	rdi, [r11 + 392]
	jmp	.LBB1_17
.LBB1_49:
	imul	r9, r9, 56
	add	r9, r14
	jmp	.LBB1_52
.LBB1_50:
	mov	r8, r14
	sub	r8, qword ptr [r9 + 16]
.LBB1_51:
	add	r9, 56
	dec	rsi
	je	.LBB1_13
.LBB1_52:
	mov	r10d, dword ptr [r9]
	cmp	r10d, 6
	je	.LBB1_50
	cmp	r10d, 7
	jne	.LBB1_51
	mov	rdi, r9
	jmp	.LBB1_51
.LBB1_55:
	mov	rdx, qword ptr [rdi + 40]
	add	r8, qword ptr [rdi + 16]
	mov	rax, qword ptr [rdi + 48]
	mov	rsi, qword ptr [rdi + 32]
	dec	rdx
	mov	rcx, r8
.LBB1_56:
	mov	r8, rax
	add	rdx, rax
	neg	r8
	mov	qword ptr [rip + os.linux.tls.area_desc.1], rax
	mov	qword ptr [rip + os.linux.tls.area_desc.4.0], rcx
	mov	qword ptr [rip + os.linux.tls.area_desc.4.1], rsi
	and	r8, rdx
	lea	rdi, [r8 + 23]
	mov	qword ptr [rip + os.linux.tls.area_desc.3], r8
	and	rdi, -8
	lea	rdx, [rdi + 16]
	mov	qword ptr [rip + os.linux.tls.area_desc.2], rdi
	mov	qword ptr [rip + os.linux.tls.area_desc.0], rdx
	cmp	rax, 4096
	ja	.LBB1_58
	cmp	rdi, 8433
	jb	.LBB1_61
.LBB1_58:
	lea	rsi, [rax + rdx - 1]
	xor	r13d, r13d
	mov	eax, 9
	mov	edx, 3
	mov	r10d, 34
	xor	edi, edi
	mov	r8, -1
	xor	r9d, r9d
	#APP
	syscall
	#NO_APP
	mov	rcx, rax
	neg	rcx
	cmp	rax, -4095
	cmovb	rcx, r13
	test	rcx, rcx
	je	.LBB1_60
	ud2
.LBB1_60:
	mov	r13, qword ptr [rip + os.linux.tls.area_desc.1]
	mov	rdx, qword ptr [rip + os.linux.tls.area_desc.0]
	lea	rax, [rax + r13 - 1]
	neg	r13
	and	r13, rax
	jmp	.LBB1_62
.LBB1_61:
	mov	r13d, offset os.linux.tls.main_thread_area_buffer
.LBB1_62:
	mov	rdi, r13
	xor	esi, esi
	call	memset@PLT
	mov	rax, qword ptr [rip + os.linux.tls.area_desc.3]
	mov	rdi, r13
	lea	rcx, [r13 + rax]
	mov	qword ptr [r13 + rax], rcx
	mov	qword ptr [rbp - 64], rcx
	mov	rax, qword ptr [rip + os.linux.tls.area_desc.2]
	mov	qword ptr [r13 + rax], 1
	mov	qword ptr [r13 + rax + 8], r13
	mov	rsi, qword ptr [rip + os.linux.tls.area_desc.4.0]
	mov	rdx, qword ptr [rip + os.linux.tls.area_desc.4.1]
	call	memcpy@PLT
	mov	eax, 158
	mov	edi, 4098
	mov	rsi, qword ptr [rbp - 64]
	#APP
	syscall
	#NO_APP
	test	r12, r12
	je	.LBB1_70
	add	r14, 40
.LBB1_64:
	cmp	dword ptr [r14 - 40], 1685382481
	je	.LBB1_66
	add	r14, 56
	dec	r12
	jne	.LBB1_64
	jmp	.LBB1_70
.LBB1_66:
	cmp	qword ptr [r14], 0
	je	.LBB1_70
	xor	r8d, r8d
	lea	r10, [rbp - 56]
	mov	eax, 302
	mov	esi, 3
	xor	edi, edi
	xor	edx, edx
	#APP
	syscall
	#NO_APP
	mov	rcx, rax
	neg	rcx
	cmp	rax, -4095
	cmovb	rcx, r8
	test	rcx, rcx
	jne	.LBB1_70
	mov	rax, qword ptr [rbp - 48]
	mov	rcx, qword ptr [r14]
	cmp	rcx, rax
	cmovae	rcx, rax
	cmp	rcx, qword ptr [rbp - 56]
	jbe	.LBB1_70
	mov	qword ptr [rbp - 56], rcx
	mov	qword ptr [rbp - 48], rax
	lea	rdx, [rbp - 56]
	mov	eax, 302
	xor	edi, edi
	xor	r10d, r10d
	#APP
	syscall
	#NO_APP
.LBB1_70:
	mov	r14, qword ptr [rip + __init_array_end@GOTPCREL]
	sub	r14, qword ptr [rip + __init_array_start@GOTPCREL]
	je	.LBB1_73
	mov	r13, qword ptr [rip + __init_array_start@GOTPCREL]
	shr	r14, 3
	cmp	r14, 1
	adc	r14, 0
	xor	r12d, r12d
.LBB1_72:
	call	qword ptr [r13 + 8*r12]
	inc	r12
	cmp	r14, r12
	jne	.LBB1_72
.LBB1_73:
	mov	rcx, qword ptr [rbp - 72]
	mov	rax, qword ptr [rbp - 80]
	mov	qword ptr [rip + os.argv], rbx
	mov	qword ptr [rip + os.environ], rcx
	mov	qword ptr [rip + os.argv+8], rax
	mov	qword ptr [rip + os.environ+8], r15
	call	start.maybeIgnoreSigpipe
	call	main.main
	mov	eax, 231
	xor	edi, edi
	#APP
	syscall
	#NO_APP

main.main:
	push	rbp
	mov	rbp, rsp
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbx
	sub	rsp, 168
	cmp	byte ptr fs:[Thread.LinuxThreadImpl.tls_thread_id.1@TPOFF], 1
	jne	.LBB2_2
	mov	eax, dword ptr fs:[Thread.LinuxThreadImpl.tls_thread_id.0@TPOFF]
	cmp	dword ptr [rip + Progress.stderr_mutex+12], eax
	je	.LBB2_4
.LBB2_5:
	lock		bts	dword ptr [rip + Progress.stderr_mutex+8], 0
	jb	.LBB2_6
.LBB2_7:
	mov	dword ptr [rip + Progress.stderr_mutex+12], eax
	mov	eax, 1
	jmp	.LBB2_8
.LBB2_2:
	mov	eax, 186
	#APP
	syscall
	#NO_APP
	mov	dword ptr fs:[Thread.LinuxThreadImpl.tls_thread_id.0@TPOFF], eax
	mov	byte ptr fs:[Thread.LinuxThreadImpl.tls_thread_id.1@TPOFF], 1
	cmp	dword ptr [rip + Progress.stderr_mutex+12], eax
	jne	.LBB2_5
.LBB2_4:
	mov	rax, qword ptr [rip + Progress.stderr_mutex]
	inc	rax
.LBB2_8:
	mov	qword ptr [rip + Progress.stderr_mutex], rax
	mov	rax, qword ptr [rip + Progress.stderr_file_writer+8]
	mov	edi, offset Progress.stderr_file_writer+8
	call	qword ptr [rax + 16]
	lea	rax, [rbp - 208]
	lea	r12, [rbp - 84]
	lea	rbx, [rbp - 56]
	lea	r14, [rbp - 72]
	mov	dword ptr [rbp - 83], 808464432
	mov	byte ptr [rbp - 84], 49
	xor	r13d, r13d
	mov	qword ptr [rip + Progress.stderr_file_writer+16], rax
	mov	qword ptr [rip + Progress.stderr_file_writer+24], 64
	mov	rdi, qword ptr [rip + Progress.stderr_file_writer+32]
.LBB2_9:
	mov	r15d, 5
	lea	rsi, [r12 + r13]
	sub	r15, r13
	lea	rax, [r15 + rdi]
	cmp	rax, qword ptr [rip + Progress.stderr_file_writer+24]
	ja	.LBB2_11
	add	rdi, qword ptr [rip + Progress.stderr_file_writer+16]
	mov	rdx, r15
	call	memcpy@PLT
	mov	rdi, qword ptr [rip + Progress.stderr_file_writer+32]
	add	rdi, r15
	mov	qword ptr [rip + Progress.stderr_file_writer+32], rdi
	add	r13, r15
	cmp	r13, 5
	jb	.LBB2_9
	jmp	.LBB2_14
.LBB2_11:
	mov	rax, qword ptr [rip + Progress.stderr_file_writer+8]
	mov	ecx, 1
	mov	r8d, 1
	mov	rdi, rbx
	mov	rdx, r14
	mov	rax, qword ptr [rax]
	mov	qword ptr [rbp - 72], rsi
	mov	esi, offset Progress.stderr_file_writer+8
	mov	qword ptr [rbp - 64], r15
	call	rax
	cmp	word ptr [rbp - 48], 0
	jne	.LBB2_19
	mov	r15, qword ptr [rbp - 56]
	mov	rdi, qword ptr [rip + Progress.stderr_file_writer+32]
	add	r13, r15
	cmp	r13, 5
	jb	.LBB2_9
.LBB2_14:
	lea	rbx, [rbp - 144]
	lea	r14, [rbp - 56]
.LBB2_15:
	cmp	rdi, qword ptr [rip + Progress.stderr_file_writer+24]
	jb	.LBB2_16
	mov	rax, qword ptr [rip + Progress.stderr_file_writer+8]
	mov	esi, offset Progress.stderr_file_writer+8
	mov	ecx, 1
	mov	r8d, 1
	mov	rdi, rbx
	mov	rdx, r14
	mov	rax, qword ptr [rax]
	mov	qword ptr [rbp - 56], offset __anon_3632
	mov	qword ptr [rbp - 48], 1
	call	rax
	cmp	word ptr [rbp - 136], 0
	jne	.LBB2_19
	mov	rdi, qword ptr [rip + Progress.stderr_file_writer+32]
	cmp	qword ptr [rbp - 144], 0
	je	.LBB2_15
	jmp	.LBB2_19
.LBB2_16:
	mov	rax, qword ptr [rip + Progress.stderr_file_writer+16]
	mov	byte ptr [rax + rdi], 10
	inc	qword ptr [rip + Progress.stderr_file_writer+32]
.LBB2_19:
	mov	rax, qword ptr [rip + Progress.stderr_file_writer+8]
	mov	edi, offset Progress.stderr_file_writer+8
	call	qword ptr [rax + 16]
	dec	qword ptr [rip + Progress.stderr_mutex]
	movabs	rax, -6148914691236517206
	vxorps	xmm0, xmm0, xmm0
	mov	qword ptr [rip + Progress.stderr_file_writer+16], rax
	vmovups	xmmword ptr [rip + Progress.stderr_file_writer+24], xmm0
	jne	.LBB2_22
	mov	dword ptr [rip + Progress.stderr_mutex+12], -1
	xor	eax, eax
	xchg	dword ptr [rip + Progress.stderr_mutex+8], eax
	cmp	eax, 3
	jne	.LBB2_22
	mov	eax, 202
	mov	edi, offset Progress.stderr_mutex+8
	mov	esi, 129
	mov	edx, 1
	#APP
	syscall
	#NO_APP
.LBB2_22:
	add	rsp, 168
	pop	rbx
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	pop	rbp
	ret
.LBB2_6:
	mov	rbx, rax
	call	Thread.Mutex.FutexImpl.lockSlow
	mov	rax, rbx
	jmp	.LBB2_7

main.square:
	mov	eax, edi
	imul	eax, edi
	jo	.LBB3_1
	ret
.LBB3_1:
	push	rbp
	mov	rbp, rsp
	mov	qword ptr [rbp - 8], 0
	#APP
	ud2	#integerOverflow
	#NO_APP

start.maybeIgnoreSigpipe:
	push	rbp
	mov	rbp, rsp
	mov	qword ptr [rbp - 32], offset start.noopSigHandler
	mov	qword ptr [rbp - 24], 67108864
	mov	qword ptr [rbp - 16], offset os.linux.x86_64.restore_rt
	mov	qword ptr [rbp - 8], 0
	lea	rsi, [rbp - 32]
	mov	eax, 13
	mov	edi, 13
	mov	r10d, 8
	xor	edx, edx
	#APP
	syscall
	#NO_APP
	pop	rbp
	ret

start.noopSigHandler:
	push	rbp
	mov	rbp, rsp
	pop	rbp
	ret

os.linux.x86_64.restore_rt:
	mov	eax, 15
	#APP
	syscall
	#NO_APP

Io.Writer.defaultFlush:
	push	rbp
	mov	rbp, rsp
	push	r15
	push	r14
	push	rbx
	sub	rsp, 24
	mov	rax, qword ptr [rdi]
	lea	r14, [rbp - 40]
	mov	rbx, rdi
	mov	r15, qword ptr [rax]
.LBB7_1:
	cmp	qword ptr [rbx + 24], 0
	je	.LBB7_2
	mov	edx, offset __anon_3708
	mov	ecx, 1
	mov	r8d, 1
	mov	rdi, r14
	mov	rsi, rbx
	call	r15
	movzx	eax, word ptr [rbp - 32]
	test	ax, ax
	je	.LBB7_1
	jmp	.LBB7_4
.LBB7_2:
	xor	eax, eax
.LBB7_4:
	add	rsp, 24
	pop	rbx
	pop	r14
	pop	r15
	pop	rbp
	ret

Io.Writer.defaultRebase:
	push	rbp
	mov	rbp, rsp
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbx
	sub	rsp, 24
	mov	rax, qword ptr [rdi + 16]
	mov	r13, qword ptr [rdi + 24]
	sub	rax, r13
	cmp	rax, rdx
	jae	.LBB8_1
	mov	rbx, rdx
	mov	r15, rsi
	mov	r14, rdi
.LBB8_4:
	mov	r12, r13
	sub	r12, r15
	mov	eax, 0
	mov	edx, offset __anon_3708
	mov	ecx, 1
	mov	r8d, 1
	lea	rdi, [rbp - 56]
	mov	rsi, r14
	cmovb	r12, rax
	mov	qword ptr [r14 + 24], r12
	sub	r13, r12
	mov	rax, qword ptr [r14]
	call	qword ptr [rax]
	movzx	eax, word ptr [rbp - 48]
	test	ax, ax
	jne	.LBB8_5
	mov	rax, qword ptr [r14 + 8]
	mov	rdi, qword ptr [r14 + 24]
	mov	rdx, r13
	add	r12, rax
	add	rdi, rax
	mov	rsi, r12
	call	memmove@PLT
	add	r13, qword ptr [r14 + 24]
	mov	qword ptr [r14 + 24], r13
	mov	rax, qword ptr [r14 + 16]
	sub	rax, r13
	cmp	rax, rbx
	jb	.LBB8_4
.LBB8_1:
	xor	eax, eax
.LBB8_2:
	add	rsp, 24
	pop	rbx
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	pop	rbp
	ret
.LBB8_5:
	add	qword ptr [r14 + 24], r13
	jmp	.LBB8_2

fs.File.Reader.getSize:
	cmp	byte ptr [rsi + 16], 0
	je	.LBB9_3
	mov	rax, qword ptr [rsi + 8]
	mov	qword ptr [rdi], rax
	mov	word ptr [rdi + 8], 0
	ret
.LBB9_3:
	movzx	eax, word ptr [rsi + 70]
	test	ax, ax
	je	.LBB9_5
	mov	word ptr [rdi + 8], ax
	ret
.LBB9_5:
	push	rbp
	mov	rbp, rsp
	push	rbx
	sub	rsp, 136
	mov	rbx, rdi
	movsxd	rdi, dword ptr [rsi + 64]
	vxorps	xmm0, xmm0, xmm0
	vmovups	zmmword ptr [rbp - 80], zmm0
	vmovups	zmmword ptr [rbp - 144], zmm0
	vmovups	zmmword ptr [rbp - 208], zmm0
	vmovups	zmmword ptr [rbp - 272], zmm0
	mov	r9, rsi
	lea	r8, [rbp - 272]
	mov	eax, 332
	mov	esi, offset __anon_3470
	mov	edx, 4096
	mov	r10d, 227
	#APP
	syscall
	#NO_APP
	mov	rdx, rax
	neg	rdx
	xor	ecx, ecx
	cmp	rax, -4095
	cmovae	rcx, rdx
	cmp	cx, 12
	je	.LBB9_6
	test	ecx, ecx
	jne	.LBB9_10
	movzx	ecx, word ptr [rbp - 244]
	mov	rax, qword ptr [rbp - 232]
	movabs	rsi, 45776219570349221
	shr	ecx, 12
	mov	edx, ecx
	shl	edx, 2
	xor	dl, 32
	cmp	cx, 7
	shrx	rcx, rsi, rdx
	mov	edx, 10
	cmovne	edx, ecx
	and	dl, 15
	mov	byte ptr [rbp - 16], dl
	cmp	dl, 5
	jne	.LBB9_12
	mov	qword ptr [r9 + 8], rax
	mov	byte ptr [r9 + 16], 1
	mov	word ptr [rbx + 8], 0
	mov	qword ptr [rbx], rax
	add	rsp, 136
	pop	rbx
	pop	rbp
	vzeroupper
	ret
.LBB9_6:
	mov	ax, 9
	jmp	.LBB9_11
.LBB9_10:
	mov	ax, 1
.LBB9_11:
	mov	word ptr [r9 + 70], ax
	mov	word ptr [rbx + 8], ax
	add	rsp, 136
	pop	rbx
	pop	rbp
	vzeroupper
	ret
.LBB9_12:
	movzx	eax, byte ptr [r9 + 74]
	vmovups	xmm0, xmmword ptr [rip + .L__unnamed_1]
	mov	ecx, 4718596
	xor	al, 4
	and	al, 7
	movzx	eax, al
	lea	eax, [rax + 2*rax]
	shrx	eax, ecx, eax
	and	al, 7
	mov	byte ptr [r9 + 74], al
	mov	word ptr [r9 + 70], 22
	vmovups	xmmword ptr [rbx], xmm0
	add	rsp, 136
	pop	rbx
	pop	rbp
	vzeroupper
	ret

fs.File.Reader.seekBy:
	push	rbp
	mov	rbp, rsp
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbx
	sub	rsp, 424
	movzx	eax, byte ptr [rdi + 74]
	mov	r14, rsi
	mov	rbx, rdi
	and	eax, 7
	jmp	qword ptr [8*rax + .LJTI10_0]
	cmp	word ptr [rbx + 72], 0
	je	.LBB10_4
	test	r14, r14
	jne	.LBB10_12
	jmp	.LBB10_36
	movzx	eax, word ptr [rbx + 72]
	jmp	.LBB10_52
.LBB10_4:
	movsxd	rdi, dword ptr [rbx + 64]
	mov	eax, 8
	mov	edx, 1
	mov	rsi, r14
	#APP
	syscall
	#NO_APP
	mov	rdx, rax
	neg	rdx
	xor	ecx, ecx
	cmp	rax, -4095
	mov	ax, 23
	cmovae	rcx, rdx
	cmp	cx, 29
	ja	.LBB10_9
	jmp	qword ptr [8*rcx + .LJTI10_1]
	mov	rdx, qword ptr [rbx]
	mov	rax, qword ptr [rbx + 48]
	lea	rcx, [rax + rdx]
	sub	rcx, qword ptr [rbx + 56]
	add	rcx, r14
	cmp	rcx, rdx
	jae	.LBB10_8
	add	rax, r14
	mov	qword ptr [rbx + 48], rax
	xor	eax, eax
	jmp	.LBB10_52
.LBB10_8:
	mov	qword ptr [rbx + 56], 0
	mov	qword ptr [rbx], rcx
	xor	eax, eax
	mov	qword ptr [rbx + 48], rax
	xor	eax, eax
	jmp	.LBB10_52
.LBB10_9:
	cmp	ecx, 75
	je	.LBB10_11
	mov	ax, 1
.LBB10_11:
	mov	word ptr [rbx + 72], ax
	test	r14, r14
	je	.LBB10_36
.LBB10_12:
	lea	r13, [rbp - 456]
	lea	rsi, [rbp - 328]
	xor	r8d, r8d
.LBB10_13:
	movzx	eax, byte ptr [rbx + 74]
	mov	r12, qword ptr [rbx]
	and	eax, 7
	jmp	qword ptr [8*rax + .LJTI10_2]
	movsxd	r15, dword ptr [rbx + 64]
	cmp	word ptr [rbx + 70], 0
	jne	.LBB10_16
	cmp	word ptr [rbx + 72], 0
	je	.LBB10_29
.LBB10_16:
	lea	rax, [rbp - 320]
	mov	rcx, r14
	xor	r9d, r9d
.LBB10_17:
	cmp	rcx, 128
	mov	edi, 128
	lea	rdx, [r9 + 1]
	mov	qword ptr [rax - 8], r13
	cmovb	rdi, rcx
	sub	rcx, rdi
	mov	qword ptr [rax], rdi
	je	.LBB10_19
	add	rax, 16
	cmp	r9, 15
	mov	r9, rdx
	jb	.LBB10_17
.LBB10_19:
	mov	eax, 19
	mov	rdi, r15
	#APP
	syscall
	#NO_APP
	mov	r9, rax
	neg	rax
	cmp	r9, -4095
	cmovb	rax, r8
	cmp	ax, 4
	je	.LBB10_19
	cmp	eax, 21
	ja	.LBB10_37
	mov	eax, eax
	jmp	qword ptr [8*rax + .LJTI10_3]
	test	r9, r9
	je	.LBB10_53
	add	r12, r9
	mov	qword ptr [rbx], r12
	jmp	.LBB10_28
	lea	rdi, [rbp - 56]
	mov	r15, rsi
	mov	rsi, rbx
	call	fs.File.Reader.getSize
	cmp	word ptr [rbp - 48], 0
	je	.LBB10_26
	movzx	eax, byte ptr [rbx + 74]
	mov	ecx, 4718596
	xor	r9d, r9d
	xor	al, 4
	and	al, 7
	movzx	eax, al
	lea	eax, [rax + 2*rax]
	shrx	eax, ecx, eax
	and	al, 7
	mov	byte ptr [rbx + 74], al
	jmp	.LBB10_27
.LBB10_26:
	mov	r9, qword ptr [rbp - 56]
	sub	r9, r12
	cmp	r14, r9
	cmovb	r9, r14
	add	r12, r9
	mov	qword ptr [rbx], r12
.LBB10_27:
	xor	r8d, r8d
	mov	rsi, r15
.LBB10_28:
	sub	r14, r9
	jne	.LBB10_13
	jmp	.LBB10_36
.LBB10_29:
	lea	rdi, [rbp - 72]
	mov	rsi, rbx
	call	fs.File.Reader.getSize
	cmp	word ptr [rbp - 64], 0
	je	.LBB10_31
	xor	r9d, r9d
	xor	r8d, r8d
	lea	rsi, [rbp - 328]
	jmp	.LBB10_28
.LBB10_31:
	mov	r9, qword ptr [rbp - 72]
	movabs	rax, 9223372036854775807
	mov	edx, 1
	mov	rdi, r15
	mov	r8d, 0
	sub	r9, r12
	cmp	r9, r14
	cmovae	r9, r14
	cmp	r9, rax
	cmovae	r9, rax
	mov	eax, 8
	mov	rsi, r9
	#APP
	syscall
	#NO_APP
	mov	rcx, rax
	neg	rcx
	cmp	rax, -4095
	mov	ax, 23
	lea	rsi, [rbp - 328]
	cmovb	rcx, r8
	cmp	cx, 29
	ja	.LBB10_33
	jmp	qword ptr [8*rcx + .LJTI10_5]
.LBB10_33:
	cmp	ecx, 75
	je	.LBB10_35
	mov	ax, 1
.LBB10_35:
	mov	word ptr [rbx + 72], ax
	xor	r9d, r9d
	jmp	.LBB10_28
.LBB10_36:
	vxorps	xmm0, xmm0, xmm0
	vmovups	xmmword ptr [rbx + 48], xmm0
	xor	eax, eax
	jmp	.LBB10_52
.LBB10_37:
	add	eax, -104
	cmp	eax, 6
	ja	.LBB10_48
	jmp	qword ptr [8*rax + .LJTI10_4]
	mov	ax, 13
	jmp	.LBB10_49
	mov	ax, 9
	jmp	.LBB10_49
	mov	ax, 20
	jmp	.LBB10_49
	mov	ax, 15
	jmp	.LBB10_49
	mov	ax, 10
	jmp	.LBB10_49
	mov	ax, 8
	jmp	.LBB10_49
	mov	ax, 17
	jmp	.LBB10_49
	mov	ax, 14
	jmp	.LBB10_49
	mov	ax, 16
	jmp	.LBB10_49
.LBB10_48:
	mov	ax, 1
.LBB10_49:
	mov	word ptr [rbx + 68], ax
	mov	ax, 5
.LBB10_51:
	mov	word ptr [rbx + 72], ax
.LBB10_52:
	add	rsp, 424
	pop	rbx
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	pop	rbp
	ret
.LBB10_53:
	mov	ax, 6
	mov	qword ptr [rbx + 8], r12
	mov	byte ptr [rbx + 16], 1
	jmp	.LBB10_51
.LJTI10_0:
	.quad	.LBB10_1
	.quad	.LBB10_6
	.quad	.LBB10_1
	.quad	.LBB10_6
	.quad	.LBB10_3
.LJTI10_1:
	.quad	.LBB10_6
	.quad	.LBB10_10
	.quad	.LBB10_10
	.quad	.LBB10_10
	.quad	.LBB10_10
	.quad	.LBB10_10
	.quad	.LBB10_11
	.quad	.LBB10_10
	.quad	.LBB10_10
	.quad	.LBB10_10
	.quad	.LBB10_10
	.quad	.LBB10_10
	.quad	.LBB10_10
	.quad	.LBB10_10
	.quad	.LBB10_10
	.quad	.LBB10_10
	.quad	.LBB10_10
	.quad	.LBB10_10
	.quad	.LBB10_10
	.quad	.LBB10_10
	.quad	.LBB10_10
	.quad	.LBB10_10
	.quad	.LBB10_11
	.quad	.LBB10_10
	.quad	.LBB10_10
	.quad	.LBB10_10
	.quad	.LBB10_10
	.quad	.LBB10_10
	.quad	.LBB10_10
	.quad	.LBB10_11
.LJTI10_2:
	.quad	.LBB10_14
	.quad	.LBB10_24
	.quad	.LBB10_14
	.quad	.LBB10_24
	.quad	.LBB10_50
.LJTI10_3:
	.quad	.LBB10_22
	.quad	.LBB10_48
	.quad	.LBB10_48
	.quad	.LBB10_41
	.quad	.LBB10_48
	.quad	.LBB10_44
	.quad	.LBB10_48
	.quad	.LBB10_48
	.quad	.LBB10_48
	.quad	.LBB10_42
	.quad	.LBB10_48
	.quad	.LBB10_45
	.quad	.LBB10_40
	.quad	.LBB10_48
	.quad	.LBB10_48
	.quad	.LBB10_48
	.quad	.LBB10_48
	.quad	.LBB10_48
	.quad	.LBB10_48
	.quad	.LBB10_48
	.quad	.LBB10_48
	.quad	.LBB10_43
.LJTI10_4:
	.quad	.LBB10_39
	.quad	.LBB10_40
	.quad	.LBB10_48
	.quad	.LBB10_47
	.quad	.LBB10_48
	.quad	.LBB10_48
	.quad	.LBB10_46
.LJTI10_5:
	.quad	.LBB10_23
	.quad	.LBB10_34
	.quad	.LBB10_34
	.quad	.LBB10_34
	.quad	.LBB10_34
	.quad	.LBB10_34
	.quad	.LBB10_35
	.quad	.LBB10_34
	.quad	.LBB10_34
	.quad	.LBB10_34
	.quad	.LBB10_34
	.quad	.LBB10_34
	.quad	.LBB10_34
	.quad	.LBB10_34
	.quad	.LBB10_34
	.quad	.LBB10_34
	.quad	.LBB10_34
	.quad	.LBB10_34
	.quad	.LBB10_34
	.quad	.LBB10_34
	.quad	.LBB10_34
	.quad	.LBB10_34
	.quad	.LBB10_35
	.quad	.LBB10_34
	.quad	.LBB10_34
	.quad	.LBB10_34
	.quad	.LBB10_34
	.quad	.LBB10_34
	.quad	.LBB10_34
	.quad	.LBB10_35

Thread.Mutex.FutexImpl.lockSlow:
	mov	eax, dword ptr [rip + Progress.stderr_mutex+8]
	cmp	eax, 3
	jne	.LBB11_1
	mov	eax, 202
	mov	edi, offset Progress.stderr_mutex+8
	mov	esi, 128
	mov	edx, 3
	xor	r10d, r10d
	#APP
	syscall
	#NO_APP
.LBB11_1:
	push	rbp
	mov	rbp, rsp
	mov	eax, 3
	xchg	dword ptr [rip + Progress.stderr_mutex+8], eax
	test	eax, eax
	je	.LBB11_4
	mov	edi, offset Progress.stderr_mutex+8
	mov	esi, 128
	mov	edx, 3
.LBB11_3:
	mov	eax, 202
	xor	r10d, r10d
	#APP
	syscall
	#NO_APP
	mov	eax, 3
	xchg	dword ptr [rip + Progress.stderr_mutex+8], eax
	test	eax, eax
	jne	.LBB11_3
.LBB11_4:
	pop	rbp
	ret

fs.File.Writer.sendFile:
	push	rbp
	mov	rbp, rsp
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbx
	sub	rsp, 120
	mov	r14, rdx
	mov	r9, qword ptr [rdx + 48]
	mov	r10, qword ptr [rdx + 56]
	mov	rdx, qword ptr [rdx + 32]
	mov	rbx, rdi
	mov	rdi, r10
	add	rdx, r9
	sub	rdi, r9
	cmp	rdi, rcx
	jae	.LBB12_5
	mov	r8, qword ptr [rsi + 24]
	mov	r13d, dword ptr [rsi + 32]
	mov	r15d, dword ptr [r14 + 64]
	cmp	byte ptr [r14 + 16], 0
	je	.LBB12_9
	mov	r11, qword ptr [r14 + 8]
	cmp	r11, qword ptr [r14]
	jne	.LBB12_9
	cmp	r10, r9
	jne	.LBB12_16
	vmovups	xmm0, xmmword ptr [rip + .L__unnamed_2]
	jmp	.LBB12_13
.LBB12_5:
	mov	qword ptr [rbp - 56], rdx
	mov	qword ptr [rbp - 48], rcx
	jmp	.LBB12_6
.LBB12_9:
	movzx	r9d, byte ptr [rsi + 46]
	test	r9b, 7
	jne	.LBB12_11
	cmp	word ptr [rsi + 38], 0
	je	.LBB12_19
.LBB12_11:
	cmp	word ptr [rsi + 40], 0
	je	.LBB12_15
	vmovups	xmm0, xmmword ptr [rip + .L__unnamed_3]
.LBB12_13:
	vmovups	xmmword ptr [rbx], xmm0
	jmp	.LBB12_14
.LBB12_15:
	or	r8, rdi
	jne	.LBB12_16
	movzx	edx, byte ptr [r14 + 74]
	and	edx, 7
	jmp	qword ptr [8*rdx + .LJTI12_1]
	movzx	edi, r9b
	xor	edx, edx
	xor	r8d, r8d
	and	edi, 7
	jmp	qword ptr [8*rdi + .LJTI12_2]
.LBB12_19:
	mov	r10, r8
	or	r10, rdi
	je	.LBB12_23
.LBB12_16:
	mov	qword ptr [rbp - 56], rdx
	mov	qword ptr [rbp - 48], rdi
.LBB12_6:
	lea	rdi, [rbp - 72]
	lea	rdx, [rbp - 56]
	mov	ecx, 1
	mov	r8d, 1
	call	fs.File.Writer.drain
	movzx	eax, word ptr [rbp - 64]
	test	ax, ax
	jne	.LBB12_17
	mov	r15, qword ptr [rbp - 72]
	mov	rdi, r14
	mov	rsi, r15
	call	fs.File.Reader.seekBy
	xor	ecx, ecx
	test	ax, ax
	setne	cl
	lea	eax, [rcx + 4*rcx]
.LBB12_8:
	mov	qword ptr [rbx], r15
	mov	word ptr [rbx + 8], ax
	mov	dword ptr [rbx + 10], 0
	mov	word ptr [rbx + 14], 0
.LBB12_14:
	mov	rax, rbx
	add	rsp, 120
	pop	rbx
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	pop	rbp
	ret
.LBB12_23:
	movzx	r10d, byte ptr [r14 + 74]
	and	r10d, 7
	jmp	qword ptr [8*r10 + .LJTI12_0]
	mov	r12, rsi
	xor	r9d, r9d
.LBB12_25:
	cmp	rcx, 2147479552
	mov	r8d, 2147479552
	lea	rdi, [rbp - 136]
	mov	esi, r13d
	mov	edx, r15d
	cmovb	r8, rcx
	mov	rcx, r9
	call	os.linux.wrapped.sendfile
	movzx	eax, word ptr [rbp - 128]
	test	eax, eax
	je	.LBB12_40
	cmp	eax, 23
	jne	.LBB12_44
	movzx	eax, byte ptr [r14 + 74]
	mov	ecx, 4718596
	xor	al, 4
	and	al, 7
	movzx	eax, al
	lea	eax, [rax + 2*rax]
	shrx	eax, ecx, eax
	and	al, 7
	mov	byte ptr [r14 + 74], al
	mov	rsi, qword ptr [r14]
	test	rsi, rsi
	je	.LBB12_45
	mov	rdi, r14
	mov	qword ptr [r14], 0
	call	fs.File.Reader.seekBy
	test	ax, ax
	je	.LBB12_45
	vmovups	xmm0, xmmword ptr [rip + .L__unnamed_4]
	mov	byte ptr [r14 + 74], 4
	jmp	.LBB12_13
	mov	rdx, qword ptr [r14]
	movzx	edi, r9b
	xor	r8d, r8d
	and	edi, 7
	mov	qword ptr [rbp - 96], rdx
	lea	rdx, [rbp - 96]
	jmp	qword ptr [8*rdi + .LJTI12_2]
	mov	rdi, qword ptr [rsi - 8]
	lea	r8, [rbp - 104]
	mov	qword ptr [rbp - 104], rdi
	lea	rdi, [rbp - 152]
	mov	r12, rsi
	mov	r9, rcx
	mov	esi, r15d
	mov	ecx, r13d
	call	os.linux.wrapped.copy_file_range
	movzx	eax, word ptr [rbp - 144]
	test	ax, ax
	je	.LBB12_39
	mov	word ptr [r12 + 40], ax
	jmp	.LBB12_45
	vmovups	xmm0, xmmword ptr [rip + .L__unnamed_5]
	jmp	.LBB12_13
	lea	rdi, [rbp - 120]
	mov	r12, rsi
	mov	rsi, r14
	mov	qword ptr [rbp - 80], rcx
	call	fs.File.Reader.getSize
	cmp	word ptr [rbp - 112], 0
	jne	.LBB12_45
	mov	rcx, qword ptr [r14]
	test	rcx, rcx
	js	.LBB12_38
	mov	rdx, qword ptr [rbp - 120]
	mov	qword ptr [rbp - 88], rcx
	lea	r9, [rbp - 88]
	sub	rdx, rcx
	mov	rcx, qword ptr [rbp - 80]
	cmp	rcx, rdx
	cmovae	rcx, rdx
	jmp	.LBB12_25
.LBB12_38:
	vmovups	xmm0, xmmword ptr [rip + .L__unnamed_4]
	jmp	.LBB12_13
.LBB12_39:
	mov	rax, qword ptr [rbp - 152]
	jmp	.LBB12_41
.LBB12_40:
	mov	rax, qword ptr [rbp - 136]
.LBB12_41:
	mov	rcx, qword ptr [r14]
	test	rax, rax
	je	.LBB12_43
	add	rcx, rax
	mov	qword ptr [r14], rcx
	add	qword ptr [r12 - 8], rax
	mov	word ptr [rbx + 8], 0
	mov	qword ptr [rbx], rax
	jmp	.LBB12_14
.LBB12_43:
	vmovups	xmm0, xmmword ptr [rip + .L__unnamed_2]
	mov	qword ptr [r14 + 8], rcx
	mov	byte ptr [r14 + 16], 1
	jmp	.LBB12_13
.LBB12_44:
	mov	word ptr [r12 + 38], ax
.LBB12_45:
	vxorps	xmm0, xmm0, xmm0
	jmp	.LBB12_13
.LBB12_17:
	jmp	.LBB12_8
.LJTI12_0:
	.quad	.LBB12_24
	.quad	.LBB12_35
	.quad	.LBB12_11
	.quad	.LBB12_11
	.quad	.LBB12_38
.LJTI12_1:
	.quad	.LBB12_22
	.quad	.LBB12_30
	.quad	.LBB12_12
	.quad	.LBB12_12
	.quad	.LBB12_34
.LJTI12_2:
	.quad	.LBB12_32
	.quad	.LBB12_31
	.quad	.LBB12_12
	.quad	.LBB12_12
	.quad	.LBB12_34

os.linux.wrapped.sendfile:
	push	rbp
	mov	rbp, rsp
	cmp	r8, 2147479552
	mov	r10d, 2147479552
	mov	r9, rdi
	movsxd	rdi, esi
	movsxd	rsi, edx
	mov	eax, 40
	mov	rdx, rcx
	cmovb	r10, r8
	#APP
	syscall
	#NO_APP
	mov	rdx, rax
	neg	rdx
	xor	ecx, ecx
	cmp	rax, -4095
	cmovae	rcx, rdx
	cmp	cx, 107
	ja	.LBB13_3
	jmp	qword ptr [8*rcx + .LJTI13_0]
.LBB13_3:
	mov	word ptr [r9 + 8], 1
	pop	rbp
	ret
	vmovups	xmm0, xmmword ptr [rip + .L__unnamed_6]
	vmovups	xmmword ptr [r9], xmm0
	pop	rbp
	ret
	vmovups	xmm0, xmmword ptr [rip + .L__unnamed_7]
	vmovups	xmmword ptr [r9], xmm0
	pop	rbp
	ret
	vmovups	xmm0, xmmword ptr [rip + .L__unnamed_8]
	vmovups	xmmword ptr [r9], xmm0
	pop	rbp
	ret
	vmovups	xmm0, xmmword ptr [rip + .L__unnamed_9]
	vmovups	xmmword ptr [r9], xmm0
	pop	rbp
	ret
	vmovups	xmm0, xmmword ptr [rip + .L__unnamed_10]
	vmovups	xmmword ptr [r9], xmm0
	pop	rbp
	ret
	mov	word ptr [r9 + 8], 0
	mov	qword ptr [r9], rax
	pop	rbp
	ret
	vmovups	xmm0, xmmword ptr [rip + .L__unnamed_11]
	vmovups	xmmword ptr [r9], xmm0
	pop	rbp
	ret
.LJTI13_0:
	.quad	.LBB13_2
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_9
	.quad	.LBB13_11
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_8
	.quad	.LBB13_10
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_7
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_11
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_5
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_3
	.quad	.LBB13_5

os.linux.wrapped.copy_file_range:
	push	rbp
	mov	rbp, rsp
	push	r14
	push	rbx
	movsxd	rcx, ecx
	mov	rbx, rdi
	movsxd	rdi, esi
	mov	rsi, rdx
	mov	r10, r8
	mov	r8, r9
	xor	r14d, r14d
	mov	eax, 326
	xor	r9d, r9d
	mov	rdx, rcx
	#APP
	syscall
	#NO_APP
	mov	rcx, rax
	neg	rcx
	cmp	rax, -4095
	cmovb	rcx, r14
	cmp	cx, 95
	ja	.LBB14_10
	jmp	qword ptr [8*rcx + .LJTI14_0]
	mov	word ptr [rbx + 8], 0
	mov	qword ptr [rbx], rax
	pop	rbx
	pop	r14
	pop	rbp
	ret
	vmovups	xmm0, xmmword ptr [rip + .L__unnamed_12]
	jmp	.LBB14_9
	vmovups	xmm0, xmmword ptr [rip + .L__unnamed_13]
	jmp	.LBB14_9
	vmovups	xmm0, xmmword ptr [rip + .L__unnamed_14]
	jmp	.LBB14_9
	vmovups	xmm0, xmmword ptr [rip + .L__unnamed_15]
	jmp	.LBB14_9
	vmovups	xmm0, xmmword ptr [rip + .L__unnamed_16]
	jmp	.LBB14_9
	vmovups	xmm0, xmmword ptr [rip + .L__unnamed_17]
	jmp	.LBB14_9
.LBB14_10:
	mov	word ptr [rbx + 8], 1
	pop	rbx
	pop	r14
	pop	rbp
	ret
	vmovups	xmm0, xmmword ptr [rip + .L__unnamed_11]
	jmp	.LBB14_9
	vmovups	xmm0, xmmword ptr [rip + .L__unnamed_18]
	jmp	.LBB14_9
	vmovups	xmm0, xmmword ptr [rip + .L__unnamed_19]
	jmp	.LBB14_9
	vmovups	xmm0, xmmword ptr [rip + .L__unnamed_20]
	jmp	.LBB14_9
	vmovups	xmm0, xmmword ptr [rip + .L__unnamed_21]
	jmp	.LBB14_9
	vmovups	xmm0, xmmword ptr [rip + .L__unnamed_22]
.LBB14_9:
	vmovups	xmmword ptr [rbx], xmm0
	pop	rbx
	pop	r14
	pop	rbp
	ret
.LJTI14_0:
	.quad	.LBB14_2
	.quad	.LBB14_12
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_11
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_8
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_4
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_6
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_13
	.quad	.LBB14_14
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_16
	.quad	.LBB14_15
	.quad	.LBB14_3
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_7
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_10
	.quad	.LBB14_5
.LCPI15_2:
	.byte	4
	.byte	8
	.byte	5
	.byte	8
	.byte	6
	.byte	8
	.byte	7
	.byte	8
.LCPI15_3:
	.byte	0
	.byte	8
	.byte	1
	.byte	8
	.byte	2
	.byte	8
	.byte	3
	.byte	8

fs.File.Writer.drain:
	push	rbp
	mov	rbp, rsp
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbx
	sub	rsp, 344
	mov	r14, rsi
	mov	rsi, qword ptr [rsi + 8]
	mov	r13, qword ptr [r14 + 24]
	mov	r12, rdi
	test	r13, r13
	je	.LBB15_2
	mov	qword ptr [rbp - 320], rsi
	mov	qword ptr [rbp - 312], r13
	mov	ebx, 1
	movsxd	rdi, dword ptr [r14 + 32]
	dec	rcx
	jne	.LBB15_3
	jmp	.LBB15_9
.LBB15_2:
	xor	ebx, ebx
	movsxd	rdi, dword ptr [r14 + 32]
	dec	rcx
	je	.LBB15_9
.LBB15_3:
	lea	rax, [rdx + 8]
	mov	r9, rcx
	jmp	.LBB15_5
.LBB15_4:
	add	rax, 16
	dec	r9
	je	.LBB15_8
.LBB15_5:
	mov	r10, qword ptr [rax]
	test	r10, r10
	je	.LBB15_4
	mov	r11, qword ptr [rax - 8]
	mov	r15, rbx
	shl	r15, 4
	mov	qword ptr [rbp + r15 - 320], r11
	mov	qword ptr [rbp + r15 - 312], r10
	cmp	rbx, 15
	je	.LBB15_13
	inc	rbx
	jmp	.LBB15_4
.LBB15_8:
	mov	r9d, 16
	cmp	rbx, 16
	je	.LBB15_28
.LBB15_9:
	test	r8, r8
	je	.LBB15_27
	shl	rcx, 4
	mov	rax, qword ptr [rdx + rcx]
	mov	rcx, qword ptr [rdx + rcx + 8]
	cmp	r8, 1
	jne	.LBB15_14
	test	rcx, rcx
	je	.LBB15_27
	mov	rdx, rbx
	shl	rdx, 4
	inc	rbx
	mov	qword ptr [rbp + rdx - 320], rax
	mov	qword ptr [rbp + rdx - 312], rcx
	mov	r9, rbx
	movzx	eax, byte ptr [r14 + 46]
	and	eax, 7
	jmp	qword ptr [8*rax + .LJTI15_0]
.LBB15_14:
	test	rcx, rcx
	je	.LBB15_27
	cmp	rcx, 1
	jne	.LBB15_21
	mov	rcx, qword ptr [r14 + 16]
	mov	qword ptr [rbp - 48], r12
	add	rsi, r13
	lea	r12, [rbp - 384]
	mov	r15d, 64
	mov	qword ptr [rbp - 56], rdi
	mov	qword ptr [rbp - 64], r8
	sub	rcx, r13
	mov	r13, r8
	cmp	rcx, 64
	cmovae	r12, rsi
	movzx	esi, byte ptr [rax]
	cmovae	r15, rcx
	cmp	r15, r8
	mov	rdi, r12
	cmovb	r13, r15
	mov	rdx, r13
	call	memset@PLT
	mov	rax, qword ptr [rbp - 64]
	mov	rdx, rbx
	shl	rdx, 4
	mov	qword ptr [rbp + rdx - 320], r12
	mov	qword ptr [rbp + rdx - 312], r13
	sub	rax, r13
	cmp	rax, r15
	setbe	sil
	cmp	rbx, 15
	sete	dil
	setne	cl
	or	dil, sil
	jne	.LBB15_35
	mov	rdi, qword ptr [rbp - 56]
	lea	rcx, [rbp - 320]
	mov	rsi, r15
	neg	rsi
	mov	r9, rbx
	lea	rdx, [rdx + rcx + 24]
.LBB15_18:
	lea	r8, [rsi + rax]
	sub	rax, r15
	cmp	r9, 14
	lea	rbx, [r9 + 1]
	mov	qword ptr [rdx - 8], r12
	mov	qword ptr [rdx], r15
	setne	cl
	cmp	r8, r15
	jbe	.LBB15_36
	add	rdx, 16
	cmp	r9, 14
	mov	r9, rbx
	jne	.LBB15_18
	jmp	.LBB15_36
.LBB15_21:
	mov	esi, 15
	lea	rdx, [r8 - 1]
	sub	rsi, rbx
	cmp	rdx, rsi
	cmovb	rsi, rdx
	mov	rdx, rbx
	inc	rsi
	cmp	rsi, 32
	jbe	.LBB15_24
	vpmovsxbq	zmm0, qword ptr [rip + .LCPI15_2]
	vpmovsxbq	zmm1, qword ptr [rip + .LCPI15_3]
	vpbroadcastq	zmm2, rax
	vmovq	xmm3, rcx
	mov	edx, esi
	and	edx, 31
	mov	r9d, 32
	mov	r10, rbx
	cmovne	r9, rdx
	shl	r10, 4
	sub	rsi, r9
	lea	r9, [rbp - 320]
	lea	r9, [r10 + r9 + 384]
	lea	rdx, [rbx + rsi]
	vpermi2q	zmm0, zmm2, zmm3
	vpermi2q	zmm1, zmm2, zmm3
.LBB15_23:
	vmovdqu64	zmmword ptr [r9 - 384], zmm1
	vmovdqu64	zmmword ptr [r9 - 320], zmm0
	vmovdqu64	zmmword ptr [r9 - 256], zmm1
	vmovdqu64	zmmword ptr [r9 - 192], zmm0
	vmovdqu64	zmmword ptr [r9 - 128], zmm1
	vmovdqu64	zmmword ptr [r9 - 64], zmm0
	vmovdqu64	zmmword ptr [r9], zmm1
	vmovdqu64	zmmword ptr [r9 + 64], zmm0
	add	r9, 512
	add	rsi, -32
	jne	.LBB15_23
.LBB15_24:
	mov	rsi, rdx
	add	rbx, r8
	shl	rsi, 4
	lea	r8, [rbp - 320]
	lea	rsi, [rsi + r8 + 8]
.LBB15_25:
	mov	qword ptr [rsi - 8], rax
	mov	qword ptr [rsi], rcx
	cmp	rdx, 15
	je	.LBB15_13
	inc	rdx
	add	rsi, 16
	cmp	rbx, rdx
	jne	.LBB15_25
.LBB15_27:
	mov	r9, rbx
	test	rbx, rbx
	je	.LBB15_49
.LBB15_28:
	movzx	eax, byte ptr [r14 + 46]
	and	eax, 7
	jmp	qword ptr [8*rax + .LJTI15_0]
.LBB15_13:
	mov	r9d, 16
	movzx	eax, byte ptr [r14 + 46]
	and	eax, 7
	jmp	qword ptr [8*rax + .LJTI15_0]
	cmp	r9, 1024
	mov	edx, 1024
	lea	rsi, [rbp - 320]
	cmovb	rdx, r9
	xor	r8d, r8d
.LBB15_30:
	mov	eax, 20
	#APP
	syscall
	#NO_APP
	mov	rcx, rax
	neg	rcx
	cmp	rax, -4095
	cmovb	rcx, r8
	cmp	cx, 4
	je	.LBB15_30
	cmp	ecx, 122
	ja	.LBB15_76
	mov	ecx, ecx
	jmp	qword ptr [8*rcx + .LJTI15_1]
	mov	ax, 13
	mov	word ptr [r14 + 36], ax
	jmp	.LBB15_84
.LBB15_35:
	mov	rdi, qword ptr [rbp - 56]
.LBB15_36:
	lea	r9, [rbx + 1]
	test	rax, rax
	je	.LBB15_78
	test	cl, cl
	je	.LBB15_78
	shl	r9, 4
	add	rbx, 2
	mov	qword ptr [rbp + r9 - 320], r12
	mov	qword ptr [rbp + r9 - 312], rax
	mov	r12, qword ptr [rbp - 48]
	mov	r9, rbx
	movzx	eax, byte ptr [r14 + 46]
	and	eax, 7
	jmp	qword ptr [8*rax + .LJTI15_0]
.LBB15_78:
	mov	r12, qword ptr [rbp - 48]
	movzx	eax, byte ptr [r14 + 46]
	and	eax, 7
	jmp	qword ptr [8*rax + .LJTI15_0]
	mov	r10, qword ptr [r14 - 8]
	cmp	r9, 1024
	mov	edx, 1024
	lea	rsi, [rbp - 320]
	cmovb	rdx, r9
	xor	r9d, r9d
	mov	eax, 296
	xor	r8d, r8d
	#APP
	syscall
	#NO_APP
	mov	rcx, rax
	neg	rcx
	cmp	rax, -4095
	cmovb	rcx, r9
	cmp	cx, 122
	ja	.LBB15_76
	jmp	qword ptr [8*rcx + .LJTI15_2]
	movzx	eax, byte ptr [r14 + 46]
	mov	ecx, 4718596
	xor	al, 4
	and	al, 7
	movzx	eax, al
	lea	eax, [rax + 2*rax]
	shrx	eax, ecx, eax
	and	al, 7
	mov	byte ptr [r14 + 46], al
	mov	rsi, qword ptr [r14 - 8]
	test	rsi, rsi
	je	.LBB15_49
	mov	qword ptr [r14 - 8], 0
	movzx	eax, byte ptr [r14 + 46]
	and	eax, 7
	jmp	qword ptr [8*rax + .LJTI15_3]
	cmp	word ptr [r14 + 44], 0
	jne	.LBB15_83
	movsxd	rdi, dword ptr [r14 + 32]
	xor	r8d, r8d
	mov	eax, 8
	xor	edx, edx
	#APP
	syscall
	#NO_APP
	mov	rcx, rax
	neg	rcx
	cmp	rax, -4095
	mov	ax, 23
	cmovb	rcx, r8
	cmp	cx, 29
	ja	.LBB15_80
	jmp	qword ptr [8*rcx + .LJTI15_4]
	mov	qword ptr [r14 - 8], rsi
.LBB15_49:
	vpxor	xmm0, xmm0, xmm0
	jmp	.LBB15_85
	mov	ax, 24
	mov	word ptr [r14 + 36], ax
	jmp	.LBB15_84
	mov	ax, 12
	mov	word ptr [r14 + 36], ax
	jmp	.LBB15_84
	mov	ax, 8
	mov	word ptr [r14 + 36], ax
	jmp	.LBB15_84
	mov	ax, 2
	mov	word ptr [r14 + 36], ax
	jmp	.LBB15_84
	mov	ax, 17
	mov	word ptr [r14 + 36], ax
	jmp	.LBB15_84
	add	qword ptr [r14 - 8], rax
	mov	rcx, rax
	mov	r15, qword ptr [r14 + 24]
	sub	rcx, r15
	jae	.LBB15_64
	mov	rdi, qword ptr [r14 + 8]
	sub	r15, rax
	mov	rdx, r15
	lea	rsi, [rdi + rax]
	vzeroupper
	call	memmove@PLT
	xor	ecx, ecx
	jmp	.LBB15_65
	mov	ax, 29
	mov	word ptr [r14 + 36], ax
	jmp	.LBB15_84
	mov	ax, 20
	mov	word ptr [r14 + 36], ax
	jmp	.LBB15_84
	mov	ax, 26
	mov	word ptr [r14 + 36], ax
	jmp	.LBB15_84
	mov	ax, 27
	mov	word ptr [r14 + 36], ax
	jmp	.LBB15_84
	mov	ax, 28
	mov	word ptr [r14 + 36], ax
	jmp	.LBB15_84
	mov	ax, 25
	mov	word ptr [r14 + 36], ax
	jmp	.LBB15_84
.LBB15_76:
	mov	ax, 1
	mov	word ptr [r14 + 36], ax
	jmp	.LBB15_84
.LBB15_64:
	xor	r15d, r15d
.LBB15_65:
	mov	qword ptr [r14 + 24], r15
	mov	word ptr [r12 + 8], 0
	mov	qword ptr [r12], rcx
	jmp	.LBB15_86
	cmp	word ptr [r14 + 44], 0
	jne	.LBB15_83
	jmp	.LBB15_49
.LBB15_80:
	cmp	ecx, 75
	je	.LBB15_82
	mov	ax, 1
.LBB15_82:
	mov	word ptr [r14 + 44], ax
.LBB15_83:
	mov	byte ptr [r14 + 46], 4
.LBB15_84:
	vmovdqu	xmm0, xmmword ptr [rip + .L__unnamed_5]
.LBB15_85:
	vmovdqu	xmmword ptr [r12], xmm0
.LBB15_86:
	mov	rax, r12
	add	rsp, 344
	pop	rbx
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	pop	rbp
	vzeroupper
	ret
.LJTI15_0:
	.quad	.LBB15_29
	.quad	.LBB15_40
	.quad	.LBB15_29
	.quad	.LBB15_40
	.quad	.LBB15_84
.LJTI15_1:
	.quad	.LBB15_51
	.quad	.LBB15_68
	.quad	.LBB15_76
	.quad	.LBB15_71
	.quad	.LBB15_76
	.quad	.LBB15_67
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_69
	.quad	.LBB15_76
	.quad	.LBB15_70
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_73
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_74
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_75
	.quad	.LBB15_72
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_66
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_61
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_50
.LJTI15_2:
	.quad	.LBB15_51
	.quad	.LBB15_68
	.quad	.LBB15_76
	.quad	.LBB15_71
	.quad	.LBB15_41
	.quad	.LBB15_67
	.quad	.LBB15_43
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_69
	.quad	.LBB15_76
	.quad	.LBB15_70
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_73
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_74
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_75
	.quad	.LBB15_72
	.quad	.LBB15_43
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_66
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_43
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_76
	.quad	.LBB15_50
.LJTI15_3:
	.quad	.LBB15_45
	.quad	.LBB15_48
	.quad	.LBB15_45
	.quad	.LBB15_48
	.quad	.LBB15_79
.LJTI15_4:
	.quad	.LBB15_48
	.quad	.LBB15_81
	.quad	.LBB15_81
	.quad	.LBB15_81
	.quad	.LBB15_81
	.quad	.LBB15_81
	.quad	.LBB15_82
	.quad	.LBB15_81
	.quad	.LBB15_81
	.quad	.LBB15_81
	.quad	.LBB15_81
	.quad	.LBB15_81
	.quad	.LBB15_81
	.quad	.LBB15_81
	.quad	.LBB15_81
	.quad	.LBB15_81
	.quad	.LBB15_81
	.quad	.LBB15_81
	.quad	.LBB15_81
	.quad	.LBB15_81
	.quad	.LBB15_81
	.quad	.LBB15_81
	.quad	.LBB15_82
	.quad	.LBB15_81
	.quad	.LBB15_81
	.quad	.LBB15_81
	.quad	.LBB15_81
	.quad	.LBB15_81
	.quad	.LBB15_81
	.quad	.LBB15_82

__anon_3632:
	.byte	10

__anon_3708:
	.quad	__anon_3470
	.quad	0

__anon_3470:
	.zero	1

Progress.stderr_mutex:
	.quad	0
	.zero	4
	.long	4294967295

Progress.stderr_file_writer:
	.quad	0
	.quad	__anon_5611
	.quad	-6148914691236517206
	.quad	0
	.quad	0
	.long	2
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.byte	0
	.zero	1
.L__unnamed_1:
	.zero	8
	.short	22
	.zero	6

Thread.LinuxThreadImpl.tls_thread_id.0:
	.zero	4

Thread.LinuxThreadImpl.tls_thread_id.1:
	.byte	0
.L__unnamed_2:
	.zero	8
	.short	6
	.zero	6
.L__unnamed_3:
	.zero	8
	.short	7
	.zero	6
.L__unnamed_5:
	.zero	8
	.short	4
	.zero	6
.L__unnamed_4:
	.zero	8
	.short	5
	.zero	6
.L__unnamed_6:
	.zero	8
	.short	12
	.zero	6
.L__unnamed_10:
	.zero	8
	.short	32
	.zero	6
.L__unnamed_8:
	.zero	8
	.short	17
	.zero	6
.L__unnamed_9:
	.zero	8
	.short	9
	.zero	6
.L__unnamed_7:
	.zero	8
	.short	23
	.zero	6
.L__unnamed_17:
	.zero	8
	.short	33
	.zero	6
.L__unnamed_21:
	.zero	8
	.short	25
	.zero	6
.L__unnamed_20:
	.zero	8
	.short	35
	.zero	6
.L__unnamed_11:
	.zero	8
	.short	8
	.zero	6
.L__unnamed_19:
	.zero	8
	.short	10
	.zero	6
.L__unnamed_13:
	.zero	8
	.short	37
	.zero	6
.L__unnamed_12:
	.zero	8
	.short	26
	.zero	6
.L__unnamed_14:
	.zero	8
	.short	38
	.zero	6
.L__unnamed_16:
	.zero	8
	.short	39
	.zero	6
.L__unnamed_18:
	.zero	8
	.short	2
	.zero	6
.L__unnamed_22:
	.zero	8
	.short	40
	.zero	6
.L__unnamed_15:
	.zero	8
	.short	41
	.zero	6

__anon_5611:
	.quad	fs.File.Writer.drain
	.quad	fs.File.Writer.sendFile
	.quad	Io.Writer.defaultFlush
	.quad	Io.Writer.defaultRebase
	.quad	main.square
