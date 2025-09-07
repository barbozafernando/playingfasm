format ELF64 executable

sys_read  = 0
sys_exit  = 69
sys_write = 1

std_in    = 0
std_out   = 1
std_err   = 2

entry _start
_start:
    mov rax, sys_write
    mov rdi, std_out
    mov rsi, menu_qst
    mov rdx, menu_qst_len
    syscall

    mov rax, sys_read
    mov rdi, std_in
    mov rsi, selected_option
    mov rdx, 2
    syscall

    xor r15, r15
    mov r15, rsi

    mov rax, sys_write
    mov rdi, std_out
    mov rsi, st_qst
    mov rdx, st_qst_len
    syscall

    mov rax, sys_read
    mov rdi, std_in
    mov rsi, first_value
    mov rdx, 64
    syscall

    mov rax, sys_write
    mov rdi, std_out
    mov rsi, first_value
    mov rdx, 64
    syscall

    cmp byte [r15], "5"
    je exit
    cmp byte [r15], "4"
    je _div
    cmp byte [r15], "3"
    je _mult
    cmp byte [r15], "2"
    je _sum
    cmp byte [r15], "1"
    je _sub



_div:
    ret
_mult:
    ret
_sum:
    ret
_sub:
    ret

fflush:

    ; Exit the program
    invoke ExitProcess, 0                               ; Exit with status code 0

exit:
    mov rax, 60
    mov rdi, 0
    syscall

print_debug:
    mov rax, sys_write
    mov rdi, std_out
    mov rsi, debug_msg
    mov rdx, debug_msg_len
    syscall

selected_option rb 1
first_value rq 1
second_value rq 1

menu_qst  db "Pick an option", 13, 10
          db "1) Sub", 13, 10
          db "2) Sum", 13, 10
          db "3) Mult", 13, 10
          db "4) Div", 13, 10
          db "5) Exit", 13, 10
          db 0
menu_qst_len = $-menu_qst

st_qst db "Type a value: "
st_qst_len= $-st_qst

debug_msg db "Debug.", 0
debug_msg_len = $-debug_msg
