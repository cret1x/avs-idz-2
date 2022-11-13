	.file	"main.c"
	.intel_syntax noprefix
	.text
	.p2align 4,,15
	.globl	read_string_from_file
	.type	read_string_from_file, @function
read_string_from_file:
	push	r13
	push	r12
	push	rbp
	push	rbx
	mov	rbp, rdi
	mov	edi, 134217728
	sub	rsp, 8
	call	malloc@PLT
	mov	r13, rax
	mov	rbx, rax
	lea	r12, 134217728[rax]
	jmp	.L2
	.p2align 4,,10
	.p2align 3
.L4:
	test	al, al
	js	.L5
	mov	BYTE PTR [rbx], al
	add	rbx, 1
	cmp	rbx, r12
	je	.L1
.L2:
	mov	rdi, rbp
	call	fgetc@PLT
	cmp	al, -1
	jne	.L4
.L1:
	add	rsp, 8
	mov	rax, r13
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	ret
	.p2align 4,,10
	.p2align 3
.L5:
	add	rsp, 8
	xor	r13d, r13d
	pop	rbx
	mov	rax, r13
	pop	rbp
	pop	r12
	pop	r13
	ret
	.size	read_string_from_file, .-read_string_from_file
	.p2align 4,,15
	.globl	get_rand_string
	.type	get_rand_string, @function
get_rand_string:
	push	r13
	push	r12
	push	rbp
	push	rbx
	mov	rbx, rdi
	sub	rsp, 8
	call	malloc@PLT
	test	rbx, rbx
	mov	r12, rax
	je	.L8
	mov	r13, rax
	add	rbx, rax
	mov	ebp, -2130574327
	.p2align 4,,10
	.p2align 3
.L10:
	call	rand@PLT
	mov	ecx, eax
	add	r13, 1
	imul	ebp
	mov	eax, ecx
	sar	eax, 31
	add	edx, ecx
	sar	edx, 6
	sub	edx, eax
	mov	eax, edx
	sal	eax, 7
	sub	eax, edx
	sub	ecx, eax
	mov	BYTE PTR -1[r13], cl
	cmp	r13, rbx
	jne	.L10
.L8:
	add	rsp, 8
	mov	rax, r12
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	ret
	.size	get_rand_string, .-get_rand_string
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"Invalid args count"
.LC1:
	.string	"-f"
.LC2:
	.string	"r"
.LC3:
	.string	"w"
.LC4:
	.string	"Error opening the files"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC5:
	.string	"Invalid chars in string. Must be in range [0-127]."
	.section	.rodata.str1.1
.LC6:
	.string	"%llu\n"
.LC7:
	.string	"-1\n"
.LC8:
	.string	"Elapsed time:"
.LC10:
	.string	"Read:\t\t%f\n"
.LC11:
	.string	"Calculations:\t%f\n"
.LC12:
	.string	"Write:\t\t%f\n"
.LC13:
	.string	"-r"
.LC14:
	.string	"Length is greater than limit!"
.LC15:
	.string	"Generated string: %s\n"
.LC16:
	.string	"Generated substring: %s\n"
.LC17:
	.string	"Posiniton of substring: %llu\n"
.LC18:
	.string	"Posiniton of substring: -1"
.LC19:
	.string	"Invalid flag"
	.section	.text.startup,"ax",@progbits
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
	push	r15
	push	r14
	push	r13
	push	r12
	mov	r12, rsi
	push	rbp
	push	rbx
	mov	ebx, edi
	xor	edi, edi
	sub	rsp, 40
	call	time@PLT
	mov	edi, eax
	call	srand@PLT
	cmp	ebx, 1
	jle	.L20
	mov	rdx, QWORD PTR 8[r12]
	lea	rdi, .LC1[rip]
	mov	ecx, 3
	mov	rsi, rdx
	repz cmpsb
	seta	al
	sbb	al, 0
	test	al, al
	je	.L36
	lea	rsi, .LC13[rip]
	mov	rdi, rdx
	call	strcmp@PLT
	test	eax, eax
	jne	.L27
	cmp	ebx, 4
	je	.L37
.L20:
	lea	rdi, .LC0[rip]
	call	puts@PLT
.L18:
	add	rsp, 40
	xor	eax, eax
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	ret
.L36:
	cmp	ebx, 5
	jne	.L20
	mov	rdi, QWORD PTR 16[r12]
	lea	rsi, .LC2[rip]
	call	fopen@PLT
	mov	rdi, QWORD PTR 24[r12]
	lea	rsi, .LC2[rip]
	mov	rbp, rax
	call	fopen@PLT
	mov	rdi, QWORD PTR 32[r12]
	lea	rsi, .LC3[rip]
	mov	rbx, rax
	call	fopen@PLT
	test	rbp, rbp
	mov	r12, rax
	sete	dl
	test	rbx, rbx
	sete	al
	or	dl, al
	jne	.L32
	test	r12, r12
	je	.L32
	call	clock@PLT
	mov	rdi, rbp
	mov	QWORD PTR [rsp], rax
	call	read_string_from_file
	mov	rdi, rbx
	mov	r14, rax
	call	read_string_from_file
	mov	r15, rax
	call	clock@PLT
	test	r14, r14
	mov	r13, rax
	je	.L33
	test	r15, r15
	je	.L33
	call	clock@PLT
	mov	rsi, r15
	mov	rdi, r14
	mov	QWORD PTR 8[rsp], rax
	call	strstr@PLT
	mov	QWORD PTR 24[rsp], rax
	call	clock@PLT
	sub	rax, QWORD PTR 8[rsp]
	mov	QWORD PTR 8[rsp], rax
	call	clock@PLT
	mov	rcx, QWORD PTR 24[rsp]
	mov	QWORD PTR 16[rsp], rax
	test	rcx, rcx
	je	.L25
	lea	rdx, .LC6[rip]
	sub	rcx, r14
	mov	esi, 1
	mov	rdi, r12
	xor	eax, eax
	call	__fprintf_chk@PLT
.L26:
	call	clock@PLT
	sub	rax, QWORD PTR 16[rsp]
	mov	rdi, r14
	mov	QWORD PTR 16[rsp], rax
	call	free@PLT
	mov	rdi, r15
	call	free@PLT
	mov	rdi, rbp
	call	fclose@PLT
	mov	rdi, rbx
	call	fclose@PLT
	mov	rdi, r12
	call	fclose@PLT
	lea	rdi, .LC8[rip]
	call	puts@PLT
	sub	r13, QWORD PTR [rsp]
	pxor	xmm0, xmm0
	lea	rsi, .LC10[rip]
	mov	edi, 1
	mov	eax, 1
	cvtsi2sdq	xmm0, r13
	mulsd	xmm0, QWORD PTR .LC9[rip]
	call	__printf_chk@PLT
	pxor	xmm0, xmm0
	lea	rsi, .LC11[rip]
	mov	edi, 1
	mov	eax, 1
	cvtsi2sdq	xmm0, QWORD PTR 8[rsp]
	mulsd	xmm0, QWORD PTR .LC9[rip]
	call	__printf_chk@PLT
	pxor	xmm0, xmm0
	lea	rsi, .LC12[rip]
	mov	edi, 1
	mov	eax, 1
	cvtsi2sdq	xmm0, QWORD PTR 16[rsp]
	mulsd	xmm0, QWORD PTR .LC9[rip]
	call	__printf_chk@PLT
	jmp	.L18
.L37:
	mov	rdi, QWORD PTR 16[r12]
	xor	esi, esi
	mov	edx, 10
	call	strtoll@PLT
	mov	rdi, QWORD PTR 24[r12]
	mov	rbx, rax
	xor	esi, esi
	mov	edx, 10
	call	strtoll@PLT
	cmp	rbx, 4095
	mov	rbp, rax
	ja	.L34
	cmp	rax, 4095
	ja	.L34
	mov	rdi, rbx
	call	get_rand_string
	mov	rdi, rbp
	mov	rbx, rax
	call	get_rand_string
	mov	rdi, rbx
	mov	rsi, rax
	mov	r12, rax
	call	strstr@PLT
	lea	rsi, .LC15[rip]
	mov	rbp, rax
	mov	rdx, rbx
	mov	edi, 1
	xor	eax, eax
	call	__printf_chk@PLT
	lea	rsi, .LC16[rip]
	xor	eax, eax
	mov	rdx, r12
	mov	edi, 1
	call	__printf_chk@PLT
	test	rbp, rbp
	je	.L30
	mov	rdx, rbp
	lea	rsi, .LC17[rip]
	mov	edi, 1
	sub	rdx, rbx
	xor	eax, eax
	call	__printf_chk@PLT
.L31:
	mov	rdi, rbx
	call	free@PLT
	mov	rdi, r12
	call	free@PLT
	jmp	.L18
.L27:
	lea	rdi, .LC19[rip]
	call	puts@PLT
	jmp	.L18
.L32:
	lea	rdi, .LC4[rip]
	call	puts@PLT
	jmp	.L18
.L30:
	lea	rdi, .LC18[rip]
	call	puts@PLT
	jmp	.L31
.L33:
	lea	rdi, .LC5[rip]
	call	puts@PLT
	mov	rdi, r14
	call	free@PLT
	mov	rdi, r15
	call	free@PLT
	mov	rdi, rbp
	call	fclose@PLT
	mov	rdi, rbx
	call	fclose@PLT
	jmp	.L18
.L34:
	lea	rdi, .LC14[rip]
	call	puts@PLT
	jmp	.L18
.L25:
	lea	rdi, .LC7[rip]
	mov	rcx, r12
	mov	edx, 3
	mov	esi, 1
	call	fwrite@PLT
	jmp	.L26
	.size	main, .-main
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC9:
	.long	2696277389
	.long	1051772663
	.ident	"GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0"
	.section	.note.GNU-stack,"",@progbits
