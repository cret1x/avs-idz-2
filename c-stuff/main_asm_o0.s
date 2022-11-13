	.file	"main.c"
	.intel_syntax noprefix
	.text
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
	jmp	.L2
.L6:
	cmp	BYTE PTR -17[rbp], 0
	jns	.L3
	mov	eax, 0
	jmp	.L4
.L3:
	mov	rax, QWORD PTR -8[rbp]
	lea	rdx, 1[rax]
	mov	QWORD PTR -8[rbp], rdx
	mov	rdx, QWORD PTR -16[rbp]
	add	rdx, rax
	movzx	eax, BYTE PTR -17[rbp]
	mov	BYTE PTR [rdx], al
.L2:
	cmp	QWORD PTR -8[rbp], 134217727
	ja	.L5
	mov	rax, QWORD PTR -40[rbp]
	mov	rdi, rax
	call	fgetc@PLT
	mov	BYTE PTR -17[rbp], al
	cmp	BYTE PTR -17[rbp], -1
	jne	.L6
.L5:
	mov	rax, QWORD PTR -16[rbp]
.L4:
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
	jmp	.L8
.L9:
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
.L8:
	mov	rax, QWORD PTR -8[rbp]
	cmp	rax, QWORD PTR -24[rbp]
	jb	.L9
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
	.string	"%llu\n"
.LC7:
	.string	"-1\n"
.LC9:
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
	.text
	.globl	main
	.type	main, @function
main:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 208
	mov	DWORD PTR -180[rbp], edi
	mov	QWORD PTR -192[rbp], rsi
	mov	edi, 0
	call	time@PLT
	mov	edi, eax
	call	srand@PLT
	cmp	DWORD PTR -180[rbp], 1
	jg	.L12
	lea	rdi, .LC0[rip]
	call	puts@PLT
	mov	eax, 0
	jmp	.L13
.L12:
	mov	rax, QWORD PTR -192[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	lea	rsi, .LC1[rip]
	mov	rdi, rax
	call	strcmp@PLT
	test	eax, eax
	jne	.L14
	cmp	DWORD PTR -180[rbp], 5
	je	.L15
	lea	rdi, .LC0[rip]
	call	puts@PLT
	mov	eax, 0
	jmp	.L13
.L15:
	mov	rax, QWORD PTR -192[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	lea	rsi, .LC2[rip]
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -56[rbp], rax
	mov	rax, QWORD PTR -192[rbp]
	add	rax, 24
	mov	rax, QWORD PTR [rax]
	lea	rsi, .LC2[rip]
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -64[rbp], rax
	mov	rax, QWORD PTR -192[rbp]
	add	rax, 32
	mov	rax, QWORD PTR [rax]
	lea	rsi, .LC3[rip]
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -72[rbp], rax
	cmp	QWORD PTR -56[rbp], 0
	je	.L16
	cmp	QWORD PTR -64[rbp], 0
	je	.L16
	cmp	QWORD PTR -72[rbp], 0
	jne	.L17
.L16:
	lea	rdi, .LC4[rip]
	call	puts@PLT
	mov	eax, 0
	jmp	.L13
.L17:
	call	clock@PLT
	mov	QWORD PTR -80[rbp], rax
	mov	rax, QWORD PTR -56[rbp]
	mov	rdi, rax
	call	read_string_from_file
	mov	QWORD PTR -88[rbp], rax
	mov	rax, QWORD PTR -64[rbp]
	mov	rdi, rax
	call	read_string_from_file
	mov	QWORD PTR -96[rbp], rax
	call	clock@PLT
	sub	rax, QWORD PTR -80[rbp]
	mov	QWORD PTR -104[rbp], rax
	cmp	QWORD PTR -88[rbp], 0
	je	.L18
	cmp	QWORD PTR -96[rbp], 0
	jne	.L19
.L18:
	lea	rdi, .LC5[rip]
	call	puts@PLT
	mov	rax, QWORD PTR -88[rbp]
	mov	rdi, rax
	call	free@PLT
	mov	rax, QWORD PTR -96[rbp]
	mov	rdi, rax
	call	free@PLT
	mov	rax, QWORD PTR -56[rbp]
	mov	rdi, rax
	call	fclose@PLT
	mov	rax, QWORD PTR -64[rbp]
	mov	rdi, rax
	call	fclose@PLT
	mov	eax, 0
	jmp	.L13
.L19:
	call	clock@PLT
	mov	QWORD PTR -112[rbp], rax
	mov	rdx, QWORD PTR -96[rbp]
	mov	rax, QWORD PTR -88[rbp]
	mov	rsi, rdx
	mov	rdi, rax
	call	strstr@PLT
	mov	QWORD PTR -120[rbp], rax
	call	clock@PLT
	sub	rax, QWORD PTR -112[rbp]
	mov	QWORD PTR -128[rbp], rax
	call	clock@PLT
	mov	QWORD PTR -136[rbp], rax
	cmp	QWORD PTR -120[rbp], 0
	je	.L20
	mov	rdx, QWORD PTR -120[rbp]
	mov	rax, QWORD PTR -88[rbp]
	sub	rdx, rax
	mov	rax, rdx
	mov	QWORD PTR -144[rbp], rax
	mov	rdx, QWORD PTR -144[rbp]
	mov	rax, QWORD PTR -72[rbp]
	lea	rsi, .LC6[rip]
	mov	rdi, rax
	mov	eax, 0
	call	fprintf@PLT
	jmp	.L21
.L20:
	mov	rax, QWORD PTR -72[rbp]
	mov	rcx, rax
	mov	edx, 3
	mov	esi, 1
	lea	rdi, .LC7[rip]
	call	fwrite@PLT
.L21:
	call	clock@PLT
	sub	rax, QWORD PTR -136[rbp]
	mov	QWORD PTR -152[rbp], rax
	mov	rax, QWORD PTR -88[rbp]
	mov	rdi, rax
	call	free@PLT
	mov	rax, QWORD PTR -96[rbp]
	mov	rdi, rax
	call	free@PLT
	mov	rax, QWORD PTR -56[rbp]
	mov	rdi, rax
	call	fclose@PLT
	mov	rax, QWORD PTR -64[rbp]
	mov	rdi, rax
	call	fclose@PLT
	mov	rax, QWORD PTR -72[rbp]
	mov	rdi, rax
	call	fclose@PLT
	cvtsi2sd	xmm0, QWORD PTR -104[rbp]
	movsd	xmm1, QWORD PTR .LC8[rip]
	divsd	xmm0, xmm1
	movsd	QWORD PTR -160[rbp], xmm0
	cvtsi2sd	xmm0, QWORD PTR -128[rbp]
	movsd	xmm1, QWORD PTR .LC8[rip]
	divsd	xmm0, xmm1
	movsd	QWORD PTR -168[rbp], xmm0
	cvtsi2sd	xmm0, QWORD PTR -152[rbp]
	movsd	xmm1, QWORD PTR .LC8[rip]
	divsd	xmm0, xmm1
	movsd	QWORD PTR -176[rbp], xmm0
	lea	rdi, .LC9[rip]
	call	puts@PLT
	mov	rax, QWORD PTR -160[rbp]
	mov	QWORD PTR -200[rbp], rax
	movsd	xmm0, QWORD PTR -200[rbp]
	lea	rdi, .LC10[rip]
	mov	eax, 1
	call	printf@PLT
	mov	rax, QWORD PTR -168[rbp]
	mov	QWORD PTR -200[rbp], rax
	movsd	xmm0, QWORD PTR -200[rbp]
	lea	rdi, .LC11[rip]
	mov	eax, 1
	call	printf@PLT
	mov	rax, QWORD PTR -176[rbp]
	mov	QWORD PTR -200[rbp], rax
	movsd	xmm0, QWORD PTR -200[rbp]
	lea	rdi, .LC12[rip]
	mov	eax, 1
	call	printf@PLT
	jmp	.L22
.L14:
	mov	rax, QWORD PTR -192[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	lea	rsi, .LC13[rip]
	mov	rdi, rax
	call	strcmp@PLT
	test	eax, eax
	jne	.L23
	cmp	DWORD PTR -180[rbp], 4
	je	.L24
	lea	rdi, .LC0[rip]
	call	puts@PLT
	mov	eax, 0
	jmp	.L13
.L24:
	mov	rax, QWORD PTR -192[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atoll@PLT
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR -192[rbp]
	add	rax, 24
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atoll@PLT
	mov	QWORD PTR -16[rbp], rax
	cmp	QWORD PTR -8[rbp], 4095
	ja	.L25
	cmp	QWORD PTR -16[rbp], 4095
	jbe	.L26
.L25:
	lea	rdi, .LC14[rip]
	call	puts@PLT
	mov	eax, 0
	jmp	.L13
.L26:
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
	call	strstr@PLT
	mov	QWORD PTR -40[rbp], rax
	mov	rax, QWORD PTR -24[rbp]
	mov	rsi, rax
	lea	rdi, .LC15[rip]
	mov	eax, 0
	call	printf@PLT
	mov	rax, QWORD PTR -32[rbp]
	mov	rsi, rax
	lea	rdi, .LC16[rip]
	mov	eax, 0
	call	printf@PLT
	cmp	QWORD PTR -40[rbp], 0
	je	.L27
	mov	rdx, QWORD PTR -40[rbp]
	mov	rax, QWORD PTR -24[rbp]
	sub	rdx, rax
	mov	rax, rdx
	mov	QWORD PTR -48[rbp], rax
	mov	rax, QWORD PTR -48[rbp]
	mov	rsi, rax
	lea	rdi, .LC17[rip]
	mov	eax, 0
	call	printf@PLT
	jmp	.L28
.L27:
	lea	rdi, .LC18[rip]
	call	puts@PLT
.L28:
	mov	rax, QWORD PTR -24[rbp]
	mov	rdi, rax
	call	free@PLT
	mov	rax, QWORD PTR -32[rbp]
	mov	rdi, rax
	call	free@PLT
	jmp	.L22
.L23:
	lea	rdi, .LC19[rip]
	call	puts@PLT
.L22:
	mov	eax, 0
.L13:
	leave
	ret
	.size	main, .-main
	.section	.rodata
	.align 8
.LC8:
	.long	0
	.long	1093567616
	.ident	"GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0"
	.section	.note.GNU-stack,"",@progbits
