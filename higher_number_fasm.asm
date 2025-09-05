format ELF64 executable 3

sys_read  = 0
sys_exit  = 60
sys_write = 1

std_in    = 0
std_out   = 1
std_err   = 2

segment readable executable

strHello db 'Hello, world!', 0
strHello_len equ $ - strHello

entry _start
_start:
  mov rax, 1
  mov rdi, std_out
  mov rsi, strHello
  mov rdx, strHello_len
  syscall
  jmp exit

exit:
  mov rax, 60
  mov rdi, 69
  syscall
