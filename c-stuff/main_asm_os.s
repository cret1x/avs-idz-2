	.file	"main.c"
	.intel_syntax noprefix
	.text
	.globl	find_substring
	.type	find_substring, @function
find_substring:
	or	rdx, -1
	xor	eax, eax
	mov	r9, rdi
	mov	rcx, rdx
	repnz scasb
	mov	rdi, rsi
	not	rcx
	lea	r8, [rcx+rdx]
	mov	rcx, rdx
	repnz scasb
	mov	rax, rdx
	not	rcx
	add	rcx, rdx
	cmp	r8, rcx
	jb	.L1
	xor	eax, eax
.L3:
	cmp	r8, rax
	je	.L10
	mov	dil, BYTE PTR [rsi]
	cmp	BYTE PTR [r9+rax], dil
	jne	.L11
	mov	edx, 1
	add	r9, rax
.L4:
	cmp	rcx, rdx
	jbe	.L13
	mov	dil, BYTE PTR [rsi+rdx]
	cmp	BYTE PTR [r9+rdx], dil
	jne	.L10
	inc	rdx
	jmp	.L4
.L13:
	ret
.L11:
	inc	rax
	jmp	.L3
.L10:
	or	rax, -1
.L1:
	ret
	.size	find_substring, .-find_substring
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
.L15:
	mov	rdi, r12
	call	fgetc@PLT
	cmp	al, -1
	je	.L14
	test	al, al
	js	.L18
	inc	rbx
	cmp	rbx, 134217728
	mov	BYTE PTR -1[rbp+rbx], al
	jne	.L15
	jmp	.L14
.L18:
	xor	ebp, ebp
.L14:
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
.L24:
	cmp	rbx, r12
	je	.L27
	call	rand@PLT
	cdq
	inc	rbx
	idiv	r13d
	mov	BYTE PTR -1[rbx], dl
	jmp	.L24
.L27:
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
	jg	.L29
.L32:
	lea	rdi, .LC0[rip]
	jmp	.L44
.L29:
	mov	rbp, QWORD PTR 8[r12]
	lea	rsi, .LC1[rip]
	mov	rdi, rbp
	call	strcmp@PLT
	test	eax, eax
	jne	.L31
	cmp	ebx, 5
	jne	.L32
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
	jne	.L40
	test	r14, r14
	jne	.L33
.L40:
	lea	rdi, .LC4[rip]
	jmp	.L44
.L33:
	call	clock@PLT
	mov	rdi, rbp
	mov	QWORD PTR 8[rsp], rax
	call	read_string_from_file
	mov	rdi, rbx
	mov	r13, rax
	call	read_string_from_file
	mov	r12, rax
	call	clock@PLT
	test	r13, r13
	mov	QWORD PTR [rsp], rax
	je	.L41
	test	r12, r12
	jne	.L35
.L41:
	lea	rdi, .LC5[rip]
	call	puts@PLT
	mov	rdi, r13
	call	free@PLT
	mov	rdi, r12
	call	free@PLT
	mov	rdi, rbp
	call	fclose@PLT
	mov	rdi, rbx
	call	fclose@PLT
	jmp	.L30
.L35:
	call	clock@PLT
	mov	rsi, r12
	mov	rdi, r13
	mov	r15, rax
	call	find_substring
	mov	QWORD PTR 24[rsp], rax
	call	clock@PLT
	sub	rax, r15
	mov	QWORD PTR 16[rsp], rax
	call	clock@PLT
	mov	rcx, QWORD PTR 24[rsp]
	lea	rdx, .LC6[rip]
	mov	esi, 1
	mov	rdi, r14
	mov	r15, rax
	xor	eax, eax
	call	__fprintf_chk@PLT
	call	clock@PLT
	mov	rdi, r13
	sub	rax, r15
	mov	r15, rax
	call	free@PLT
	mov	rdi, r12
	call	free@PLT
	mov	rdi, rbp
	call	fclose@PLT
	mov	rdi, rbx
	call	fclose@PLT
	mov	rdi, r14
	call	fclose@PLT
	lea	rdi, .LC7[rip]
	call	puts@PLT
	mov	rax, QWORD PTR [rsp]
	sub	rax, QWORD PTR 8[rsp]
	lea	rsi, .LC9[rip]
	mov	edi, 1
	cvtsi2sd	xmm0, rax
	mov	al, 1
	divsd	xmm0, QWORD PTR .LC8[rip]
	call	__printf_chk@PLT
	cvtsi2sd	xmm0, QWORD PTR 16[rsp]
	divsd	xmm0, QWORD PTR .LC8[rip]
	lea	rsi, .LC10[rip]
	mov	edi, 1
	mov	al, 1
	call	__printf_chk@PLT
	cvtsi2sd	xmm0, r15
	lea	rsi, .LC11[rip]
	mov	edi, 1
	mov	al, 1
	divsd	xmm0, QWORD PTR .LC8[rip]
	call	__printf_chk@PLT
	jmp	.L30
.L31:
	lea	rsi, .LC12[rip]
	mov	rdi, rbp
	call	strcmp@PLT
	test	eax, eax
	jne	.L37
	cmp	ebx, 4
	jne	.L32
	mov	rdi, QWORD PTR 16[r12]
	call	atoll@PLT
	mov	rdi, QWORD PTR 24[r12]
	mov	rbp, rax
	call	atoll@PLT
	cmp	rbp, 4095
	mov	rbx, rax
	ja	.L42
	cmp	rax, 4095
	jbe	.L38
.L42:
	lea	rdi, .LC13[rip]
	jmp	.L44
.L38:
	mov	rdi, rbp
	call	get_rand_string
	mov	rdi, rbx
	mov	rbp, rax
	call	get_rand_string
	mov	rdi, rbp
	mov	rsi, rax
	mov	rbx, rax
	call	find_substring
	lea	rsi, .LC14[rip]
	mov	r12, rax
	mov	rdx, rbp
	mov	edi, 1
	xor	eax, eax
	call	__printf_chk@PLT
	lea	rsi, .LC15[rip]
	mov	rdx, rbx
	mov	edi, 1
	xor	eax, eax
	call	__printf_chk@PLT
	lea	rsi, .LC16[rip]
	mov	rdx, r12
	mov	edi, 1
	xor	eax, eax
	call	__printf_chk@PLT
	mov	rdi, rbp
	call	free@PLT
	mov	rdi, rbx
	call	free@PLT
	jmp	.L30
.L37:
	lea	rdi, .LC17[rip]
.L44:
	call	puts@PLT
.L30:
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
.LC8:
	.long	0
	.long	1093567616
	.ident	"GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0"
	.section	.note.GNU-stack,"",@progbits
