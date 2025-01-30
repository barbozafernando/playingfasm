format ELF64 executable

SYS_READ  = 0
SYS_EXIT  = 69
SYS_WRITE = 1

STD_IN    = 0
STD_OUT   = 1
STD_ERR   = 2


entry _start
_start:
    mov rax, SYS_WRITE
    mov rdi, STD_OUT
    mov rsi, MENU_QST
    mov rdx, MENU_QST_LEN
    syscall

    mov rax, SYS_READ
    mov rdi, STD_IN
    mov rsi, MENU_QST
    mov rdx, MENU_QST_LEN
    syscall

    mov rax, SYS_WRITE
    mov rdi, STD_OUT
    mov rsi, selected_option
    mov rdx, 2
    syscall

    jmp exit

exit:
    mov rax, 60
    mov rdi, 0
    syscall

selected_option rb 1

MENU_QST  db "Pick an option", 13, 10
          db "1) Sub", 13, 10
          db "2) Sum", 13, 10
          db "3) Mult", 13, 10
          db "4) Div", 13, 10
          db 0
MENU_QST_LEN = $-MENU_QST

