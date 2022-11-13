	.file	"main.c"
	.intel_syntax noprefix
	.text
	.p2align 4,,15
	.globl	find_substring
	.type	find_substring, @function
find_substring:
	push	r12
	push	rbp
	mov	r12, rsi
	push	rbx
	mov	rbx, rdi
	call	strlen@PLT
	mov	rdi, r12
	mov	rbp, rax
	call	strlen@PLT
	cmp	rbp, rax
	jb	.L12
	test	rbp, rbp
	mov	rsi, rax
	mov	rax, -1
	je	.L1
	movzx	ecx, BYTE PTR [r12]
	cmp	BYTE PTR [rbx], cl
	je	.L10
	xor	edx, edx
	jmp	.L4
	.p2align 4,,10
	.p2align 3
.L7:
	cmp	BYTE PTR [rbx+rdx], cl
	je	.L17
.L4:
	add	rdx, 1
	cmp	rbp, rdx
	jne	.L7
.L12:
	mov	rax, -1
.L1:
	pop	rbx
	pop	rbp
	pop	r12
	ret
	.p2align 4,,10
	.p2align 3
.L17:
	mov	rax, rdx
.L3:
	cmp	rsi, 1
	jbe	.L1
	movzx	edi, BYTE PTR 1[rbx+rdx]
	cmp	BYTE PTR 1[r12], dil
	jne	.L12
	mov	ecx, 1
	add	rdx, rbx
	.p2align 4,,10
	.p2align 3
.L5:
	add	rcx, 1
	cmp	rsi, rcx
	je	.L1
	movzx	edi, BYTE PTR [r12+rcx]
	cmp	BYTE PTR [rdx+rcx], dil
	je	.L5
	jmp	.L12
	.p2align 4,,10
	.p2align 3
.L10:
	xor	eax, eax
	xor	edx, edx
	jmp	.L3
	.size	find_substring, .-find_substring
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
	jmp	.L19
	.p2align 4,,10
	.p2align 3
.L21:
	test	al, al
	js	.L22
	mov	BYTE PTR [rbx], al
	add	rbx, 1
	cmp	rbx, r12
	je	.L18
.L19:
	mov	rdi, rbp
	call	fgetc@PLT
	cmp	al, -1
	jne	.L21
.L18:
	add	rsp, 8
	mov	rax, r13
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	ret
	.p2align 4,,10
	.p2align 3
.L22:
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
	je	.L24
	mov	r13, rax
	add	rbx, rax
	mov	ebp, -2130574327
	.p2align 4,,10
	.p2align 3
.L26:
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
	jne	.L26
.L24:
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
	.string	"%lli\n"
.LC7:
	.string	"Elapsed time:"
.LC9:
	.string	"Read:\t\t%f\n"
.LC10:
	.string	"Calculations:\t%f\n"
.LC11:
	.string	"Write:\t\t%f\n"
.LC12:
	.string	"-r"
.LC13:
	.string	"Length is greater than limit!"
.LC14:
	.string	"Generated string: %s\n"
.LC15:
	.string	"Generated substring: %s\n"
.LC16:
	.string	"Posiniton of substring: %lli\n"
.LC17:
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
	jle	.L36
	mov	rdx, QWORD PTR 8[r12]
	lea	rdi, .LC1[rip]
	mov	ecx, 3
	mov	rsi, rdx
	repz cmpsb
	seta	al
	sbb	al, 0
	test	al, al
	je	.L48
	lea	rsi, .LC12[rip]
	mov	rdi, rdx
	call	strcmp@PLT
	test	eax, eax
	jne	.L41
	cmp	ebx, 4
	je	.L49
.L36:
	lea	rdi, .LC0[rip]
	call	puts@PLT
.L34:
	add	rsp, 40
	xor	eax, eax
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	ret
.L48:
	cmp	ebx, 5
	jne	.L36
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
	mov	r14, rax
	sete	dl
	test	rbx, rbx
	sete	al
	or	dl, al
	jne	.L44
	test	r14, r14
	je	.L44
	call	clock@PLT
	mov	rdi, rbp
	mov	QWORD PTR [rsp], rax
	call	read_string_from_file
	mov	rdi, rbx
	mov	r12, rax
	call	read_string_from_file
	mov	r13, rax
	call	clock@PLT
	test	r12, r12
	je	.L45
	test	r13, r13
	je	.L45
	mov	QWORD PTR 24[rsp], rax
	call	clock@PLT
	mov	rsi, r13
	mov	rdi, r12
	mov	r15, rax
	call	find_substring
	mov	QWORD PTR 16[rsp], rax
	call	clock@PLT
	sub	rax, r15
	mov	QWORD PTR 8[rsp], rax
	call	clock@PLT
	mov	rcx, QWORD PTR 16[rsp]
	lea	rdx, .LC6[rip]
	mov	esi, 1
	mov	rdi, r14
	mov	r15, rax
	xor	eax, eax
	call	__fprintf_chk@PLT
	call	clock@PLT
	mov	rdi, r12
	sub	rax, r15
	mov	r15, rax
	call	free@PLT
	mov	rdi, r13
	call	free@PLT
	mov	rdi, rbp
	call	fclose@PLT
	mov	rdi, rbx
	call	fclose@PLT
	mov	rdi, r14
	call	fclose@PLT
	lea	rdi, .LC7[rip]
	call	puts@PLT
	mov	r9, QWORD PTR 24[rsp]
	sub	r9, QWORD PTR [rsp]
	lea	rsi, .LC9[rip]
	pxor	xmm0, xmm0
	mov	edi, 1
	mov	eax, 1
	cvtsi2sdq	xmm0, r9
	mulsd	xmm0, QWORD PTR .LC8[rip]
	call	__printf_chk@PLT
	pxor	xmm0, xmm0
	lea	rsi, .LC10[rip]
	mov	edi, 1
	mov	eax, 1
	cvtsi2sdq	xmm0, QWORD PTR 8[rsp]
	mulsd	xmm0, QWORD PTR .LC8[rip]
	call	__printf_chk@PLT
	pxor	xmm0, xmm0
	lea	rsi, .LC11[rip]
	mov	edi, 1
	mov	eax, 1
	cvtsi2sdq	xmm0, r15
	mulsd	xmm0, QWORD PTR .LC8[rip]
	call	__printf_chk@PLT
	jmp	.L34
.L49:
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
	ja	.L46
	cmp	rax, 4095
	ja	.L46
	mov	rdi, rbx
	call	get_rand_string
	mov	rdi, rbp
	mov	r12, rax
	call	get_rand_string
	mov	rdi, r12
	mov	rsi, rax
	mov	rbx, rax
	call	find_substring
	lea	rsi, .LC14[rip]
	mov	rbp, rax
	mov	rdx, r12
	mov	edi, 1
	xor	eax, eax
	call	__printf_chk@PLT
	lea	rsi, .LC15[rip]
	mov	rdx, rbx
	mov	edi, 1
	xor	eax, eax
	call	__printf_chk@PLT
	lea	rsi, .LC16[rip]
	mov	rdx, rbp
	mov	edi, 1
	xor	eax, eax
	call	__printf_chk@PLT
	mov	rdi, r12
	call	free@PLT
	mov	rdi, rbx
	call	free@PLT
	jmp	.L34
.L41:
	lea	rdi, .LC17[rip]
	call	puts@PLT
	jmp	.L34
.L44:
	lea	rdi, .LC4[rip]
	call	puts@PLT
	jmp	.L34
.L46:
	lea	rdi, .LC13[rip]
	call	puts@PLT
	jmp	.L34
.L45:
	lea	rdi, .LC5[rip]
	call	puts@PLT
	mov	rdi, r12
	call	free@PLT
	mov	rdi, r13
	call	free@PLT
	mov	rdi, rbp
	call	fclose@PLT
	mov	rdi, rbx
	call	fclose@PLT
	jmp	.L34
	.size	main, .-main
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC8:
	.long	2696277389
	.long	1051772663
	.ident	"GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0"
	.section	.note.GNU-stack,"",@progbits
