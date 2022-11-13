	.file	"main.c"
	.intel_syntax noprefix
	.text
	.globl	find_substring
	.type	find_substring, @function
find_substring:
	push	rbp
	mov	rbp, rsp
	push	rbx
	sub	rsp, 56
	mov	QWORD PTR -56[rbp], rdi
	mov	QWORD PTR -64[rbp], rsi
	mov	rax, QWORD PTR -56[rbp]
	mov	rdi, rax
	call	strlen@PLT
	mov	rbx, rax
	mov	rax, QWORD PTR -64[rbp]
	mov	rdi, rax
	call	strlen@PLT
	cmp	rbx, rax
	jnb	.L2
	mov	rax, -1
	jmp	.L3
.L2:
	mov	QWORD PTR -24[rbp], 0
	jmp	.L4
.L9:
	mov	rax, QWORD PTR -24[rbp]
	mov	QWORD PTR -40[rbp], rax
	mov	rdx, QWORD PTR -56[rbp]
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	movzx	edx, BYTE PTR [rax]
	mov	rax, QWORD PTR -64[rbp]
	movzx	eax, BYTE PTR [rax]
	cmp	dl, al
	jne	.L5
	mov	QWORD PTR -32[rbp], 1
	jmp	.L6
.L8:
	mov	rdx, QWORD PTR -24[rbp]
	mov	rax, QWORD PTR -32[rbp]
	add	rdx, rax
	mov	rax, QWORD PTR -56[rbp]
	add	rax, rdx
	movzx	edx, BYTE PTR [rax]
	mov	rcx, QWORD PTR -64[rbp]
	mov	rax, QWORD PTR -32[rbp]
	add	rax, rcx
	movzx	eax, BYTE PTR [rax]
	cmp	dl, al
	je	.L7
	mov	rax, -1
	jmp	.L3
.L7:
	add	QWORD PTR -32[rbp], 1
.L6:
	mov	rax, QWORD PTR -64[rbp]
	mov	rdi, rax
	call	strlen@PLT
	cmp	QWORD PTR -32[rbp], rax
	jb	.L8
	mov	rax, QWORD PTR -40[rbp]
	jmp	.L3
.L5:
	add	QWORD PTR -24[rbp], 1
.L4:
	mov	rax, QWORD PTR -56[rbp]
	mov	rdi, rax
	call	strlen@PLT
	cmp	QWORD PTR -24[rbp], rax
	jb	.L9
	mov	rax, -1
.L3:
	add	rsp, 56
	pop	rbx
	pop	rbp
	ret
	.size	find_substring, .-find_substring
	.globl	read_string_from_file
	.type	read_string_from_file, @function
read_string_from_file:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	mov	QWORD PTR -40[rbp], rdi
	mov	edi, 134217728
	call	malloc@PLT
	mov	QWORD PTR -16[rbp], rax
	mov	QWORD PTR -8[rbp], 0
	jmp	.L11
.L15:
	cmp	BYTE PTR -17[rbp], 0
	jns	.L12
	mov	eax, 0
	jmp	.L13
.L12:
	mov	rax, QWORD PTR -8[rbp]
	lea	rdx, 1[rax]
	mov	QWORD PTR -8[rbp], rdx
	mov	rdx, QWORD PTR -16[rbp]
	add	rdx, rax
	movzx	eax, BYTE PTR -17[rbp]
	mov	BYTE PTR [rdx], al
.L11:
	cmp	QWORD PTR -8[rbp], 134217727
	ja	.L14
	mov	rax, QWORD PTR -40[rbp]
	mov	rdi, rax
	call	fgetc@PLT
	mov	BYTE PTR -17[rbp], al
	cmp	BYTE PTR -17[rbp], -1
	jne	.L15
.L14:
	mov	rax, QWORD PTR -16[rbp]
.L13:
	leave
	ret
	.size	read_string_from_file, .-read_string_from_file
	.globl	get_rand_string
	.type	get_rand_string, @function
get_rand_string:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR -24[rbp], rdi
	mov	rax, QWORD PTR -24[rbp]
	mov	rdi, rax
	call	malloc@PLT
	mov	QWORD PTR -16[rbp], rax
	mov	QWORD PTR -8[rbp], 0
	jmp	.L17
.L18:
	call	rand@PLT
	mov	ecx, eax
	mov	edx, -2130574327
	mov	eax, ecx
	imul	edx
	lea	eax, [rdx+rcx]
	sar	eax, 6
	mov	edx, eax
	mov	eax, ecx
	sar	eax, 31
	sub	edx, eax
	mov	eax, edx
	mov	edx, eax
	sal	edx, 7
	sub	edx, eax
	mov	eax, ecx
	sub	eax, edx
	mov	rdx, QWORD PTR -8[rbp]
	lea	rcx, 1[rdx]
	mov	QWORD PTR -8[rbp], rcx
	mov	rcx, QWORD PTR -16[rbp]
	add	rdx, rcx
	mov	BYTE PTR [rdx], al
.L17:
	mov	rax, QWORD PTR -8[rbp]
	cmp	rax, QWORD PTR -24[rbp]
	jb	.L18
	mov	rax, QWORD PTR -16[rbp]
	leave
	ret
	.size	get_rand_string, .-get_rand_string
	.section	.rodata
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
	.align 8
.LC5:
	.string	"Invalid chars in string. Must be in range [0-127]."
.LC6:
	.string	"%lli\n"
.LC8:
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
	.text
	.globl	main
	.type	main, @function
main:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 192
	mov	DWORD PTR -164[rbp], edi
	mov	QWORD PTR -176[rbp], rsi
	mov	edi, 0
	call	time@PLT
	mov	edi, eax
	call	srand@PLT
	cmp	DWORD PTR -164[rbp], 1
	jg	.L21
	lea	rdi, .LC0[rip]
	call	puts@PLT
	mov	eax, 0
	jmp	.L22
.L21:
	mov	rax, QWORD PTR -176[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	lea	rsi, .LC1[rip]
	mov	rdi, rax
	call	strcmp@PLT
	test	eax, eax
	jne	.L23
	cmp	DWORD PTR -164[rbp], 5
	je	.L24
	lea	rdi, .LC0[rip]
	call	puts@PLT
	mov	eax, 0
	jmp	.L22
.L24:
	mov	rax, QWORD PTR -176[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	lea	rsi, .LC2[rip]
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -48[rbp], rax
	mov	rax, QWORD PTR -176[rbp]
	add	rax, 24
	mov	rax, QWORD PTR [rax]
	lea	rsi, .LC2[rip]
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -56[rbp], rax
	mov	rax, QWORD PTR -176[rbp]
	add	rax, 32
	mov	rax, QWORD PTR [rax]
	lea	rsi, .LC3[rip]
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -64[rbp], rax
	cmp	QWORD PTR -48[rbp], 0
	je	.L25
	cmp	QWORD PTR -56[rbp], 0
	je	.L25
	cmp	QWORD PTR -64[rbp], 0
	jne	.L26
.L25:
	lea	rdi, .LC4[rip]
	call	puts@PLT
	mov	eax, 0
	jmp	.L22
.L26:
	call	clock@PLT
	mov	QWORD PTR -72[rbp], rax
	mov	rax, QWORD PTR -48[rbp]
	mov	rdi, rax
	call	read_string_from_file
	mov	QWORD PTR -80[rbp], rax
	mov	rax, QWORD PTR -56[rbp]
	mov	rdi, rax
	call	read_string_from_file
	mov	QWORD PTR -88[rbp], rax
	call	clock@PLT
	sub	rax, QWORD PTR -72[rbp]
	mov	QWORD PTR -96[rbp], rax
	cmp	QWORD PTR -80[rbp], 0
	je	.L27
	cmp	QWORD PTR -88[rbp], 0
	jne	.L28
.L27:
	lea	rdi, .LC5[rip]
	call	puts@PLT
	mov	rax, QWORD PTR -80[rbp]
	mov	rdi, rax
	call	free@PLT
	mov	rax, QWORD PTR -88[rbp]
	mov	rdi, rax
	call	free@PLT
	mov	rax, QWORD PTR -48[rbp]
	mov	rdi, rax
	call	fclose@PLT
	mov	rax, QWORD PTR -56[rbp]
	mov	rdi, rax
	call	fclose@PLT
	mov	eax, 0
	jmp	.L22
.L28:
	call	clock@PLT
	mov	QWORD PTR -104[rbp], rax
	mov	rdx, QWORD PTR -88[rbp]
	mov	rax, QWORD PTR -80[rbp]
	mov	rsi, rdx
	mov	rdi, rax
	call	find_substring
	mov	QWORD PTR -112[rbp], rax
	call	clock@PLT
	sub	rax, QWORD PTR -104[rbp]
	mov	QWORD PTR -120[rbp], rax
	call	clock@PLT
	mov	QWORD PTR -128[rbp], rax
	mov	rdx, QWORD PTR -112[rbp]
	mov	rax, QWORD PTR -64[rbp]
	lea	rsi, .LC6[rip]
	mov	rdi, rax
	mov	eax, 0
	call	fprintf@PLT
	call	clock@PLT
	sub	rax, QWORD PTR -128[rbp]
	mov	QWORD PTR -136[rbp], rax
	mov	rax, QWORD PTR -80[rbp]
	mov	rdi, rax
	call	free@PLT
	mov	rax, QWORD PTR -88[rbp]
	mov	rdi, rax
	call	free@PLT
	mov	rax, QWORD PTR -48[rbp]
	mov	rdi, rax
	call	fclose@PLT
	mov	rax, QWORD PTR -56[rbp]
	mov	rdi, rax
	call	fclose@PLT
	mov	rax, QWORD PTR -64[rbp]
	mov	rdi, rax
	call	fclose@PLT
	cvtsi2sd	xmm0, QWORD PTR -96[rbp]
	movsd	xmm1, QWORD PTR .LC7[rip]
	divsd	xmm0, xmm1
	movsd	QWORD PTR -144[rbp], xmm0
	cvtsi2sd	xmm0, QWORD PTR -120[rbp]
	movsd	xmm1, QWORD PTR .LC7[rip]
	divsd	xmm0, xmm1
	movsd	QWORD PTR -152[rbp], xmm0
	cvtsi2sd	xmm0, QWORD PTR -136[rbp]
	movsd	xmm1, QWORD PTR .LC7[rip]
	divsd	xmm0, xmm1
	movsd	QWORD PTR -160[rbp], xmm0
	lea	rdi, .LC8[rip]
	call	puts@PLT
	mov	rax, QWORD PTR -144[rbp]
	mov	QWORD PTR -184[rbp], rax
	movsd	xmm0, QWORD PTR -184[rbp]
	lea	rdi, .LC9[rip]
	mov	eax, 1
	call	printf@PLT
	mov	rax, QWORD PTR -152[rbp]
	mov	QWORD PTR -184[rbp], rax
	movsd	xmm0, QWORD PTR -184[rbp]
	lea	rdi, .LC10[rip]
	mov	eax, 1
	call	printf@PLT
	mov	rax, QWORD PTR -160[rbp]
	mov	QWORD PTR -184[rbp], rax
	movsd	xmm0, QWORD PTR -184[rbp]
	lea	rdi, .LC11[rip]
	mov	eax, 1
	call	printf@PLT
	jmp	.L29
.L23:
	mov	rax, QWORD PTR -176[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	lea	rsi, .LC12[rip]
	mov	rdi, rax
	call	strcmp@PLT
	test	eax, eax
	jne	.L30
	cmp	DWORD PTR -164[rbp], 4
	je	.L31
	lea	rdi, .LC0[rip]
	call	puts@PLT
	mov	eax, 0
	jmp	.L22
.L31:
	mov	rax, QWORD PTR -176[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atoll@PLT
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR -176[rbp]
	add	rax, 24
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atoll@PLT
	mov	QWORD PTR -16[rbp], rax
	cmp	QWORD PTR -8[rbp], 4095
	ja	.L32
	cmp	QWORD PTR -16[rbp], 4095
	jbe	.L33
.L32:
	lea	rdi, .LC13[rip]
	call	puts@PLT
	mov	eax, 0
	jmp	.L22
.L33:
	mov	rax, QWORD PTR -8[rbp]
	mov	rdi, rax
	call	get_rand_string
	mov	QWORD PTR -24[rbp], rax
	mov	rax, QWORD PTR -16[rbp]
	mov	rdi, rax
	call	get_rand_string
	mov	QWORD PTR -32[rbp], rax
	mov	rdx, QWORD PTR -32[rbp]
	mov	rax, QWORD PTR -24[rbp]
	mov	rsi, rdx
	mov	rdi, rax
	call	find_substring
	mov	QWORD PTR -40[rbp], rax
	mov	rax, QWORD PTR -24[rbp]
	mov	rsi, rax
	lea	rdi, .LC14[rip]
	mov	eax, 0
	call	printf@PLT
	mov	rax, QWORD PTR -32[rbp]
	mov	rsi, rax
	lea	rdi, .LC15[rip]
	mov	eax, 0
	call	printf@PLT
	mov	rax, QWORD PTR -40[rbp]
	mov	rsi, rax
	lea	rdi, .LC16[rip]
	mov	eax, 0
	call	printf@PLT
	mov	rax, QWORD PTR -24[rbp]
	mov	rdi, rax
	call	free@PLT
	mov	rax, QWORD PTR -32[rbp]
	mov	rdi, rax
	call	free@PLT
	jmp	.L29
.L30:
	lea	rdi, .LC17[rip]
	call	puts@PLT
.L29:
	mov	eax, 0
.L22:
	leave
	ret
	.size	main, .-main
	.section	.rodata
	.align 8
.LC7:
	.long	0
	.long	1093567616
	.ident	"GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0"
	.section	.note.GNU-stack,"",@progbits
