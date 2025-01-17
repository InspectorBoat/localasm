
main.square:
	push	rbp
	mov	rbp, rsp
	mov	eax, ecx
	imul	eax, ecx
	pop	rbp
	ret

main.fib:
	push	rbp
	push	rsi
	push	rdi
	sub	rsp, 32
	lea	rbp, [rsp + 32]
	xor	esi, esi
	cmp	rcx, 2
	jb	.LBB1_3
	mov	rdi, rcx
.LBB1_2:
	lea	rcx, [rdi - 2]
	call	main.fib
	lea	rcx, [rdi - 1]
	add	rsi, rax
	cmp	rdi, 3
	mov	rdi, rcx
	jae	.LBB1_2
.LBB1_3:
	add	rsi, rcx
	mov	rax, rsi
	add	rsp, 32
	pop	rdi
	pop	rsi
	pop	rbp
	ret
