format PE64 console
entry _start

include '%FASM_INCLUDE%\win64ax.inc'

_start:
    sub rsp, 8                  				        ; Alinha a pilha (garantia adicional)
    mov rcx, 0                                          ; First argument: NULL (no owner window)
	mov rdx, message                                    ; Second argument: Pointer to the message text
	mov r8, messagetitle                                ; Third argument: Pointer to the message box title
    mov r9, MB_OK                                       ; Fourth argument: MB_OK (MessageBox type)
	invoke MessageBoxA, rcx, rdx, r8, r9                ; Call MessageBoxA
	invoke ExitProcess, 0                               ; Exit the program


section '.data' data readable

    message db "Hello from the message box", 0
	messagetitle db "Hello from Title", 0


section '.idata' import data readable writeable

    library user32, 'USER32.DLL',\
		kernel, 'KERNEL32.DLL'

    import user32,\
        MessageBoxA, 'MessageBoxA'

    import kernel,\
        ExitProcess, 'ExitProcess'
