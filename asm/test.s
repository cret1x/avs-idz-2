	.intel_syntax noprefix
	 .bss
    .lcomm string, 128
    .lcomm substring, 128
	.text
    .global _start
msg_str:
    .string "String: "
msg_substr:
    .string "Substring: "
_start:
	mov rax, 16[rsp]
	mov rbx, 24[rsp]
	
	call find_string
	call print_number
	call print_line
	

	mov rax, 60
	mov rdi, 0
	syscall
	