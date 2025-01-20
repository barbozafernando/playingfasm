format PE64 console
entry _start

include '%FASM_INCLUDE%\win64ax.inc'

STD_OUTPUT_HANDLE = -11

section '.text' code readable executable

_start:
    sub rsp, 8                  				        ; Alinha a pilha (garantia adicional)
    invoke GetStdHandle, STD_OUTPUT_HANDLE    			; Obtém o identificador do console de saída
    mov rcx, rax                				        ; Coloca o handle no 1º argumento (RCX)
    lea rdx, [message]          				        ; Endereço da mensagem no 2º argumento (RDX)
    mov r8, message_len         				        ; Tamanho da mensagem no 3º argumento (R8)
    mov r9, 0                   				        ; NULL no 4º argumento (R9)
    invoke WriteConsoleA, rcx, rdx, r8, r9, 0
    invoke ExitProcess, 0       				        ; Termina o programa

section '.data' data readable

    message db "Hello, world!", 0
    message_len = $ - message

section '.idata' import data readable writeable

    library kernel, 'KERNEL32.DLL'

    import kernel, \
        GetStdHandle, 'GetStdHandle', \
        WriteConsoleA, 'WriteConsoleA', \
        ExitProcess, 'ExitProcess'
