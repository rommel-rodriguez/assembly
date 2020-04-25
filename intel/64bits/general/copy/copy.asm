    section .bss
    MAXARGS equ     10
ArgCount:   resq    1
ArgPtrs:   resq     MAXARGS 
ArgLens:   resq    MAXARGS
    section .data
ErrMsg: db  "Terminated with error.",0x0a ; Error message + New Line 
ERRLEN  equ $-ErrMsg
    section .text
    global  _start
_start:
    nop         ; This no-op keeps gdb happy...

    pop rcx
    cmp rcx, MAXARGS
    ja  Error
    mov qword [ArgCount], rcx

    xor rdx, rdx    ; Zero a loop counter
SaveArgs:
    pop qword [ArgPtrs + rdx*8]
    inc rdx
    cmp rdx, rcx
    jb  SaveArgs
; with the argument pointers sotred in ArgPtrs, we calculate their lengths:
    xor rax, rax
    xor rbx, rbx

ScanOne:
    mov rcx, 0000ffffh      ; Limit search to 65535 bytes max
    mov rdi, qword [ArgPtrs+rbx*8]  ; Put address of string to search in RDI
    mov rdx, rdi            ; Copy starting address into RDX
    cld     ; Set search direction to iup-memory
    repne scasb     ; Search fo null (0 char= in string
    jnz Error
    mov byte [rdi-1], 0x0a     ; Sore an EOL where the null used to be
    sub rdi, rdx
    mov qword [ArgLens+rbx*8], rdi
    inc rbx
    cmp rbx, [ArgCount]
    jb ScanOne
;   Display all arguments to stdout:
    xor r9, r9
;;
;; TODO: Copy code to go here
;;
Showem:
    mov rsi, [ArgPtrs+r9*8]
    mov rax, 1
    mov rdi, 1
    mov rdx, [ArgLens+r9*8]
    syscall
    inc r9
    cmp r9, [ArgCount]
    jb Showem
    jmp Exit

Error:  mov rax, 1
        mov rdi, 1
        mov rsi, ErrMsg
        mov rdx, ERRLEN
        syscall
Exit:   mov rax, 60
        mov rdi, 0
        syscall
