format PE64 console
entry _start

include '%FASM_INCLUDE%\win64ax.inc'

STD_INPUT_HANDLE  = -10
STD_OUTPUT_HANDLE = -11

_start:
    ; Print menu text on screen
    invoke GetStdHandle, STD_OUTPUT_HANDLE              ; Retrieves a handle to the specified standard device (stdin, stdout, stderr)
    mov rcx, rax                                        ; Gets the return of GetStdHandle that lives in RAX and sends to RCX
    lea rdx, [menu_msg]                                 ; Pointer to the text to be shown
    mov r8, menu_len                                    ; Text length
    mov r9, 0                                           ; lpReserved parameter must be NULL
    invoke WriteConsoleA, rcx, rdx, r8, r9, 0           ; Call WriteConsoleA

    ; Save selected option into option_picked
    mov rcx, GENERIC_READ                               ; Handle to the console input buffer
    lea rdx, [option_picked]                            ; A pointer to an array structure that receives the input buffer data
    mov r8, 8                                           ; The size of the array pointed to by the lpBuffer parameter
    mov r9, 0                                           ; Points to a variable that receives the number of input records read.
    invoke ReadConsoleA, rcx, rdx, r8, r9, 0            ; Call ReadConsoleA

    ; Print value 1 text on screen
    invoke GetStdHandle, STD_OUTPUT_HANDLE              ; Retrieves a handle to the specified standard device (stdin, stdout, stderr)
    mov rcx, rax                                        ; Gets the return of GetStdHandle that lives in RAX and sends to RCX
    lea rdx, [value1_text]                              ; Pointer to the text to be shown
    mov r8, value1_text_len                             ; Text length
    mov r9, 0                                           ; lpReserved parameter must be NULL
    invoke WriteConsoleA, rcx, rdx, r8, r9, 0           ; Call WriteConsoleA

    ; Save selected option into value1
    mov rcx, GENERIC_READ                               ; Handle to the console input buffer
    lea rdx, [value1]                                   ; A pointer to an array structure that receives the input buffer data
    mov r8, 1                                           ; The size of the array pointed to by the lpBuffer parameter
    mov r9, 0                                           ; Points to a variable that receives the number of input records read.
    invoke ReadConsoleA, rcx, rdx, r8, r9, 0            ; Call ReadConsoleA

    cmp [option_picked], 0x31                           ; Check whether picked option 1

sum:
    mov rax, value1
    add rax, value2

subt:
    ret



section '.data' data readable
    menu_msg db "Pick an option ** 1-Sum 2-Sub 3-Mult 4-Div **",0x0a,0x0d, 0
	menu_len = $ - menu_msg
    value1_text db "Type a number: ",0x0a,0x0d, 0
    value1_text_len = $ - value1_text

section '.bss' readable writeable
    option_picked dq 1
    value1 db 4
    value2 db 4


section '.idata' import data readable writeable
    library user32, 'USER32.DLL',\
		kernel, 'KERNEL32.DLL'

    import user32,\
        MessageBoxA, 'MessageBoxA'

    import kernel,\
        ExitProcess, 'ExitProcess',\
        GetStdHandle, 'GetStdHandle',\
        WriteConsoleA, 'WriteConsoleA',\
        ReadConsoleA, 'ReadConsoleA',\
        SetConsoleMode, 'SetConsoleMode'

; invoke GetStdHandle, STD_OUTPUT_HANDLE
; mov rcx, rax
; lea rdx, [option_picked]
; mov r8, 16
; mov r9, 0
; invoke WriteConsoleA, rcx, rdx, r8, r9, 0
