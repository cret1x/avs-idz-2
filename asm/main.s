    .intel_syntax noprefix

    .bss
    .lcomm _out_fname, 128
    .equ _string_limit, 32768
    .lcomm string_buf, _string_limit
    .lcomm substring_buf, _string_limit
    ReadStartTime: .space 16
    ReadEndTime: .space 16
    ReadDeltaTime: .space 16
    CalcStartTime: .space 16
    CalcEndTime: .space 16
    CalcDeltaTime: .space 16
    WriteStartTime: .space 16
    WriteEndTime: .space 16
    WriteDeltaTime: .space 16

    .text
    .global _start
msg_inv_args:
    .string "Invalid args count. See README file for corect usage.\n"
msg_inv_flag:
    .string "Invalid flag. See README file for corect usage.\n"
msg_inv_chars:
    .string "Invalid chars in string. Must be in range [0-127].\n"
msg_enter_str:
    .string "Enter the string: "
msg_enter_substr:
    .string "Enter the substring: "
msg_gen_str:
    .string "Generated string: "
msg_gen_substr:
    .string "Generated substring: "
msg_pos:
    .string "Position of substring: "
msg_len_big:
    .string "Length is greater than limit!\n"
msg_err:
    .string "Error while opening a file: "
msg_new_line:
    .string "\n"
msg_time:
    .string "Elapsed time:  \n"
msg_time_read:
    .string "Read:          "
msg_time_calc:
    .string "Calculations:  "
msg_time_write:
    .string "Write:         "
flag_file:
    .string "-f"
flag_random:
    .string "-r"
flag_console:
    .string "-c"

_start:
    mov r12, [rsp]
    cmp r12, 2                          # check number of args
    jl inv_args_count                   # if < 2 display error message                                 
    mov rcx, 16[rsp]
    mov rax, rcx
    mov rbx, offset flag_console
    call compare_strings
    cmp rax, 1
    je .console_input
    mov rax, rcx
    mov rbx, offset flag_random
    call compare_strings
    cmp rax, 1
    je .random_input
    mov rax, rcx
    mov rbx, offset flag_file
    call compare_strings
    cmp rax, 1
    je .file_input
    mov rax, offset msg_inv_flag
    call print_string
    jmp exit

.console_input:
    mov rax, offset msg_enter_str
    call print_string
    call input_string                           # get string
    mov rax, offset _str_buffer
    mov rbx, offset string_buf
    call copy_string
    mov rax, offset msg_enter_str
    call print_string
    call input_string                           # get substring
    mov rax, offset _str_buffer
    mov rbx, offset substring_buf
    call copy_string
    mov r14, 0
    jmp .do_task

.random_input:
    cmp r12, 4
    jne inv_args_count
    mov rax, 24[rsp]                            # get length of string
    call string_to_num
    cmp rax, _string_limit
    jg len_too_big
    mov rbx, offset string_buf
    call get_random_string                      # generate random string given length
    mov rax, 32[rsp]                            # get length of substring
    call string_to_num
    cmp rax, _string_limit
    jg len_too_big
    mov rbx, offset substring_buf                      # generate random substring given length
    call get_random_string
    mov rax, offset msg_gen_str
    call print_string
    mov rax, offset string_buf
    call print_string
    call print_line
    mov rax, offset msg_gen_substr
    call print_string
    mov rax, offset substring_buf
    call print_string
    call print_line
    mov r14, 0
    jmp .do_task

.file_input:
    cmp r12, 4
    jne inv_args_count
    mov rax, 24[rsp]                    # store in rax filename input
    mov rbx, 0                          # 0 - read
    call file_open
    push rax
    call file_read_line
    mov rax, offset _str_buffer
    mov rbx, offset string_buf
    call copy_string
    pop rax
    push rax
    call file_read_line
    mov rax, offset _str_buffer
    mov rbx, offset substring_buf
    call copy_string
    pop rax
    call file_close
    mov rax, 32[rsp]
    mov rbx, offset _out_fname
    call copy_string
    mov r14, 2
    jmp .do_task

    
.do_task:
    # check for invalid ascii codes 
    mov rax, offset string_buf
    mov rbx, 128
    call find_chars_by_code
    cmp rax, 0
    jge .inv_chars
    mov rax, offset substring_buf
    mov bl, 128
    call find_chars_by_code
    cmp rax, 0
    jge .inv_chars
    mov rax, offset string_buf
    mov rbx, offset substring_buf
    call find_string
    mov r15, rax
    cmp r14, 0
    jg .file_output
    jmp .console_output

.console_output:
    mov rax, offset msg_pos
    call print_string
    mov rax, r15
    call print_number
    call print_line
    jmp exit

.file_output:
    mov rax, offset _out_fname
    call file_create
    mov rbx, 289                        # write + append
    mov r13, rax
    call file_open
    mov rax, r15
    mov rbx, offset _str_buffer
    call number_to_string
    mov rax, offset _str_buffer
    push rax
    call length_string
    mov rcx, rax
    pop rax
    mov rax, r13
    call file_write_line
    mov rax, r13
    call file_close
    jmp exit

    /*
    mov rax, 16[rsp]                    # store in rax filename input
    mov rbx, 0                          # 0 - read
    call file_open

    mov rcx, rax                        # save output file name
    mov rax, 24[rsp]
    mov rbx, offset _out_fname
    mov [rbx], rax
    mov rax, rcx                       

    cmp rax, -1                         # if error
    jg .file_rd_st
    cmp rax, -133
    jl .file_rd_st

    neg rax                             # display error code
    mov rcx, rax
    mov rax, offset msg_err
    call print_string
    mov rax, rcx
    call print_number
    call print_line
    call exit

    .file_rd_st:
    push rax

    lea rax, ReadStartTime[rip]         # get time before reading from file
    call time_now

    pop rax
    push rax
    call file_read_line                 # get first line - length of array
    mov rax, offset _str_buffer
    call string_to_num                  # convert to number
    mov r12, rax                        # save it to r12
    pop rax
    xor rbx, rbx                        # counter


    cmp r12, 100000000                  # if array length is too big
    jle .file_crt_arr
    call file_close
    jmp .len_to_big

    .file_crt_arr:
        push rax                        # save file desc
        mov r13, r12
        imul r13, 8                     # memory = 8bytes (long) * length

        mov rax, r13
        call create_array               # create array A
        mov r14, rdi                    # r14 = arrA[0]

        mov rax, r13
        call create_array               # create array B
        mov r15, rdi                    # r15 = arrB[0]

        mov rax, r13
        call create_array               # without it, it just does not work idk why

        pop rax
    .file_rd_lp:
        cmp rbx, r12                    # if counter >= length - exit loop
        jge .file_rd_lp_ex
        push rax
        call file_read_line             # read next line
        mov rax, offset _str_buffer
        call string_to_num
        mov [r14 + rbx * 8], rax 
        pop rax
        inc rbx                         # counter++
        jmp .file_rd_lp
    .file_rd_lp_ex:
        call file_close

        lea rax, ReadEndTime[rip]
        call time_now

        mov r13, 1                      # 1 = file mode
        jmp .calc_section


    .random_input:
        debug:
        mov rax, 24[rsp]
        call string_to_num
        mov r12, rax
        cmp r12, 100000000              # if array length is too big
        jg .len_to_big

        mov rax, 32[rsp]             # lower bound
        call string_to_num
        mov rsi, rax

        mov rax, 40[rsp]             # upper bound
        call string_to_num
        mov rdi, rax


        mov rax, 48[rsp]
        mov rbx, offset _out_fname      # output filename
        mov [rbx], rax        

        push rsi
        push rdi
    
        mov r13, r12
        imul r13, 8                     # memory = 8bytes (long) * length

        mov rax, r13
        call create_array               # create array A
        mov r14, rdi                    # r14 = arrA[0]

        mov rax, r13
        call create_array               # create array B
        mov r15, rdi                    # r15 = arrB[0]

        mov rax, r13
        call create_array               # without it, it just does not work idk why

        pop rdi
        pop rsi

        xor rcx, rcx
        .rand_read_loop:
            cmp rcx, r12
            jge .rand_read_loop_ret
            
            mov rax, rsi
            mov rbx, rdi
            push rsi
            push rdi
            call get_random_number
            mov [r14 + rcx * 8], rax
            call print_number
            mov rax, ' '
            call print_char
            
            pop rdi
            pop rsi
            inc rcx
            jmp .rand_read_loop

        .rand_read_loop_ret:
        call print_line
        mov r13, 1
        jmp .calc_section


    .manual_input:
    mov rax, offset msg_enter_len
    call print_string
    call input_number                   # length of array is stored in rax
    cmp rax, 100000000
    jge .len_to_big

    mov r12, rax                        # save length to rcx
    mov r13, rax
    imul r13, 8                         # memory = 8bytes (long) * length

    mov rax, r13
    call create_array                   # create array A
    mov r14, rdi                        # r14 = arrA[0]

    mov rax, r13
    call create_array                   # create array B
    mov r15, rdi                        # r15 = arrB[0]
   

    mov rax, offset msg_allocated
    call print_string
    mov rax, r13
    call print_number
    call print_line

    mov rax, offset msg_enter_arr
    call print_string
    call print_line

    mov rax, r12
    mov rdi, r14
    call input_array

    mov r13, 0                          # 0 = manual mode
    .calc_section:

    lea rax, CalcStartTime[rip]         # get time before calculations
    call time_now

    mov rcx, -1
    xor rbx, rbx
    .arr_lp_fnd_neg_it:
        cmp rbx, r12
        jge .arr_lp_fnd_neg_ex
        mov rax, [r14 + rbx * 8]
        and ax, 1
        jz .arr_lp_evn
        inc rbx
        jmp .arr_lp_fnd_neg_it
        .arr_lp_evn:
            cmp rax, 0
            jl .arr_lp_fnd_neg_res
            inc rbx
            jmp .arr_lp_fnd_neg_it
    .arr_lp_fnd_neg_res:
        mov rcx, rbx
    .arr_lp_fnd_neg_ex:
        cmp rcx, 0
        jge .arr_lp_fnd_neg_yes
        mov rcx, r12 
        dec rcx
    .arr_lp_fnd_neg_yes:

    xor rbx, rbx
    .arr_lp_calc_it:
        cmp rbx, r12
        jge .arr_lp_calc_ex
        mov rax, [r14 + rbx * 8]        # arrA[i]
        mov rdx, [r14 + rcx * 8]        # arrA[m]
        imul rax, rdx                   # arrA[i] * arrA[m]
        mov r8, rbx
        imul r8, 8
        mov [r15 + rbx * 8], rax        # arrB[i] = arrA[i] * arrA[m]
        inc rbx
        jmp .arr_lp_calc_it
    .arr_lp_calc_ex:
    

    lea rax, CalcEndTime[rip]                # get time after calculations
    call time_now


    cmp r13, 0
    jne .file_output
    mov rax, offset msg_your_arr
    call print_string
    
    mov rax, r12
    mov rdi, r15
    call print_array
    call exit
    .file_output:

    lea rax, WriteStartTime[rip]
    call time_now

    mov rax, _out_fname
    call file_create
    mov rax, _out_fname
    mov rbx, 289                        # write + append
    call file_open
    mov r13, rax
    mov rax, r13
    mov rbx, offset msg_new_line
    call file_write_line
    xor rbx, rbx
    .file_arr_pr_lp:
        cmp rbx, r12
        jge .file_arr_pr_lp_ex
        push rbx
        mov rax, [r15 + rbx * 8]
        mov rbx, offset _str_buffer
        mov rcx, 21
        call number_to_string
        mov rax, offset _str_buffer
        call length_string
        mov rcx, rax
        mov rax, r13
        mov rbx, offset _str_buffer
        call file_write_line
        mov rax, r13
        mov rcx, 1
        mov rbx, offset msg_new_line
        call file_write_line
        pop rbx
        inc rbx
        jmp .file_arr_pr_lp

    .file_arr_pr_lp_ex:
    mov rax, r13
    call file_close

    lea rax, WriteEndTime[rip]
    call time_now
    # print measured time
    # for read
    mov rax, ReadStartTime[rip]
    mov rbx, ReadStartTime[rip + 8]
    mov rcx, ReadEndTime[rip]
    mov rdx, ReadEndTime[rip + 8]
    lea r8, ReadDeltaTime[rip]
    lea r9, ReadDeltaTime[rip + 8]
    call get_delta

    # for calc
    mov rax, CalcStartTime[rip]
    mov rbx, CalcStartTime[rip + 8]
    mov rcx, CalcEndTime[rip]
    mov rdx, CalcEndTime[rip + 8]
    lea r8, CalcDeltaTime[rip]
    lea r9, CalcDeltaTime[rip + 8]
    call get_delta
    
    # for write
    mov rax, WriteStartTime[rip]
    mov rbx, WriteStartTime[rip + 8]
    mov rcx, WriteEndTime[rip]
    mov rdx, WriteEndTime[rip + 8]
    lea r8, WriteDeltaTime[rip]
    lea r9, WriteDeltaTime[rip + 8]
    call get_delta

    
    mov rax, offset msg_time
    call print_string

    mov rax, offset msg_time_read
    call print_string
    mov rax, ReadDeltaTime[rip]
    call print_number
    mov rax, '.'
    call print_char
    mov rax, ReadDeltaTime[rip+8]
    call print_number
    call print_line
    
    mov rax, offset msg_time_calc
    call print_string
    mov rax, CalcDeltaTime[rip]
    call print_number
    mov rax, '.'
    call print_char
    mov rax, CalcDeltaTime[rip+8]
    call print_number
    call print_line

    mov rax, offset msg_time_write
    call print_string
    mov rax, WriteDeltaTime[rip]
    call print_number
    mov rax, '.'
    call print_char
    mov rax, WriteDeltaTime[rip+8]
    call print_number
    call print_line
    call exit

*/
len_too_big:
    mov rax, offset msg_len_big
    call print_string
    jmp exit
    
.inv_chars:
    mov rax, offset msg_inv_chars
    call print_string
    jmp exit

inv_args_count:
    mov rax, offset msg_inv_args
    call print_string
    jmp exit         

exit:
	mov rax, 60
	mov rdi, 0
	syscall
