section .text
    global _start

strHello db 'Hello, world!', 0
strHello_len equ $ - strHello

_start:
  mov rax, 1
  mov rdi, 1
  mov rsi, strHello
  mov rdx, strHello_len
  syscall
  jmp exit

exit:
  mov rax, 60
  mov rdi, 69
  syscall
