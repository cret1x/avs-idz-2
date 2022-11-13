	.file	"main.c"
	.intel_syntax noprefix
	.text
	.globl	read_string_from_file
	.type	read_string_from_file, @function
read_string_from_file:
	push	r12
	push	rbp
	mov	r12, rdi
	push	rbx
	mov	edi, 134217728
	xor	ebx, ebx
	call	malloc@PLT
	mov	rbp, rax
.L2:
	mov	rdi, r12
	call	fgetc@PLT
	cmp	al, -1
	je	.L1
	test	al, al
	js	.L5
	inc	rbx
	cmp	rbx, 134217728
	mov	BYTE PTR -1[rbp+rbx], al
	jne	.L2
	jmp	.L1
.L5:
	xor	ebp, ebp
.L1:
	mov	rax, rbp
	pop	rbx
	pop	rbp
	pop	r12
	ret
	.size	read_string_from_file, .-read_string_from_file
	.globl	get_rand_string
	.type	get_rand_string, @function
get_rand_string:
	push	r13
	push	r12
	mov	r12, rdi
	push	rbp
	push	rbx
	mov	r13d, 127
	sub	rsp, 8
	call	malloc@PLT
	mov	rbp, rax
	mov	rbx, rax
	add	r12, rax
.L12:
	cmp	rbx, r12
	je	.L15
	call	rand@PLT
	cdq
	inc	rbx
	idiv	r13d
	mov	BYTE PTR -1[rbx], dl
	jmp	.L12
.L15:
	pop	rdx
	mov	rax, rbp
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
.LC5:
	.string	"Invalid chars in string. Must be in range [0-127]."
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
	.globl	main
	.type	main, @function
main:
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbp
	push	rbx
	mov	ebp, edi
	xor	edi, edi
	mov	rbx, rsi
	sub	rsp, 40
	call	time@PLT
	mov	edi, eax
	call	srand@PLT
	cmp	ebp, 1
	jg	.L17
.L20:
	lea	rdi, .LC0[rip]
	jmp	.L36
.L17:
	mov	r12, QWORD PTR 8[rbx]
	lea	rsi, .LC1[rip]
	mov	rdi, r12
	call	strcmp@PLT
	test	eax, eax
	jne	.L19
	cmp	ebp, 5
	jne	.L20
	mov	rdi, QWORD PTR 16[rbx]
	lea	rsi, .LC2[rip]
	call	fopen@PLT
	mov	rdi, QWORD PTR 24[rbx]
	lea	rsi, .LC2[rip]
	mov	r13, rax
	call	fopen@PLT
	mov	rdi, QWORD PTR 32[rbx]
	lea	rsi, .LC3[rip]
	mov	r12, rax
	call	fopen@PLT
	test	r13, r13
	mov	rbp, rax
	sete	dl
	test	r12, r12
	sete	al
	or	dl, al
	jne	.L32
	test	rbp, rbp
	jne	.L21
.L32:
	lea	rdi, .LC4[rip]
	jmp	.L36
.L21:
	call	clock@PLT
	mov	rdi, r13
	mov	QWORD PTR 8[rsp], rax
	call	read_string_from_file
	mov	rdi, r12
	mov	rbx, rax
	call	read_string_from_file
	mov	r14, rax
	call	clock@PLT
	test	rbx, rbx
	mov	QWORD PTR [rsp], rax
	je	.L33
	test	r14, r14
	jne	.L23
.L33:
	lea	rdi, .LC5[rip]
	call	puts@PLT
	mov	rdi, rbx
	call	free@PLT
	mov	rdi, r14
	call	free@PLT
	mov	rdi, r13
	call	fclose@PLT
	mov	rdi, r12
	call	fclose@PLT
	jmp	.L18
.L23:
	call	clock@PLT
	mov	rsi, r14
	mov	r15, rax
	mov	rdi, rbx
	call	strstr@PLT
	mov	QWORD PTR 24[rsp], rax
	call	clock@PLT
	sub	rax, r15
	mov	QWORD PTR 16[rsp], rax
	call	clock@PLT
	mov	rcx, QWORD PTR 24[rsp]
	mov	r15, rax
	test	rcx, rcx
	je	.L25
	lea	rdx, .LC6[rip]
	sub	rcx, rbx
	mov	esi, 1
	mov	rdi, rbp
	xor	eax, eax
	call	__fprintf_chk@PLT
	jmp	.L26
.L25:
	lea	rdi, .LC7[rip]
	mov	rsi, rbp
	call	fputs@PLT
.L26:
	call	clock@PLT
	mov	rdi, rbx
	sub	rax, r15
	mov	r15, rax
	call	free@PLT
	mov	rdi, r14
	call	free@PLT
	mov	rdi, r13
	call	fclose@PLT
	mov	rdi, r12
	call	fclose@PLT
	mov	rdi, rbp
	call	fclose@PLT
	lea	rdi, .LC8[rip]
	call	puts@PLT
	mov	rax, QWORD PTR [rsp]
	sub	rax, QWORD PTR 8[rsp]
	lea	rsi, .LC10[rip]
	mov	edi, 1
	cvtsi2sd	xmm0, rax
	mov	al, 1
	divsd	xmm0, QWORD PTR .LC9[rip]
	call	__printf_chk@PLT
	cvtsi2sd	xmm0, QWORD PTR 16[rsp]
	divsd	xmm0, QWORD PTR .LC9[rip]
	lea	rsi, .LC11[rip]
	mov	edi, 1
	mov	al, 1
	call	__printf_chk@PLT
	cvtsi2sd	xmm0, r15
	lea	rsi, .LC12[rip]
	mov	edi, 1
	mov	al, 1
	divsd	xmm0, QWORD PTR .LC9[rip]
	call	__printf_chk@PLT
	jmp	.L18
.L19:
	lea	rsi, .LC13[rip]
	mov	rdi, r12
	call	strcmp@PLT
	test	eax, eax
	jne	.L27
	cmp	ebp, 4
	jne	.L20
	mov	rdi, QWORD PTR 16[rbx]
	call	atoll@PLT
	mov	rdi, QWORD PTR 24[rbx]
	mov	r12, rax
	call	atoll@PLT
	cmp	r12, 4095
	mov	rbp, rax
	ja	.L34
	cmp	rax, 4095
	jbe	.L28
.L34:
	lea	rdi, .LC14[rip]
	jmp	.L36
.L28:
	mov	rdi, r12
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
	jmp	.L31
.L30:
	lea	rdi, .LC18[rip]
	call	puts@PLT
.L31:
	mov	rdi, rbx
	call	free@PLT
	mov	rdi, r12
	call	free@PLT
	jmp	.L18
.L27:
	lea	rdi, .LC19[rip]
.L36:
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
	.size	main, .-main
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC9:
	.long	0
	.long	1093567616
	.ident	"GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0"
	.section	.note.GNU-stack,"",@progbits
