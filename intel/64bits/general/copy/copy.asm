    section .bss
    MAXARGS equ     10
    BUFFSIZE equ  1024
ArgCount:   resq    1
ArgPtrs:    resq        MAXARGS 
ArgLens:    resq        MAXARGS
Buffer:     resb        BUFFSIZE 
    section .data
ErrMsg: db  "Terminated with error.",0x0a ; Error message + New Line 
ERRLEN  equ $-ErrMsg
FD1  dq  0
FD2  dq  0
;; F1:  db  "something.txt",0
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

;; This block although useful in other cases, replaces the null with \n
;; ScanOne:
;;     mov rcx, 0000ffffh      ; Limit search to 65535 bytes max
;;     mov rdi, qword [ArgPtrs+rbx*8]  ; Put address of string to search in RDI
;;     mov rdx, rdi            ; Copy starting address into RDX
;;     cld     ; Set search direction to up-memory
;;     repne scasb     ; Search fo null (0 char= in string
;;     jnz Error
;;     mov byte [rdi-1], 0x0a     ; Store an EOL where the null used to be
;;     sub rdi, rdx
;;     mov qword [ArgLens+rbx*8], rdi
;;     inc rbx
;;     cmp rbx, [ArgCount]
;;     jb ScanOne
;;

;; TODO: Copy code to go here
;;

OpenFiles:
    mov rax, 2
    mov rdi, qword [ArgPtrs + 8]    ; Load path to file 1, is this not null term?
    ;; mov rdi, F1    ; Load path to file 1, this works
    mov rsi, 0  ; Flags for open, in this case Read-Only 
    syscall
    mv qword [FD1], rax ; Save file descriptor
    cmp rax, 0 ; Show error if file descriptor is invalid 
    jl  Error

    mov rax, 2
    ;; mov rdi, qword [ArgPtrs + 16]    ; Load path to file 1
    mov rdi, qword [ArgPtrs + 16]    ; Load path to file 1
    mov rsi, 0x40  ; Flags for open, in this case Read-Only 
    mov rdx, 0644o ; Permissions in case of file-creation event
    syscall
    mv qword [FD2], rax     ; Save file descriptor
    cmp rax, 0 ; Show error if file descriptor is invalid 
    jl  Error
;;
;; CopyChar:
;;    TODO: Make a loop here

;; DEBUGG CODE, TESTING FILE DESCRIPTORS
    ;; mov qword [FILED1], rax ; save file descriptor's value
    ;; mov rax, 1
    ;; mov rdi, 1
    ;; ;; lea rsi, qword [FILED1]
    ;; mov rsi, FILED1
    ;; mov rdx, 8
    ;; syscall
;;
    jmp Exit

;   Display all arguments to stdout:
;;     xor r9, r9
;; 
;; Showem:
;;     mov rsi, [ArgPtrs+r9*8]
;;     mov rax, 1
;;     mov rdi, 1
;;     mov rdx, [ArgLens+r9*8]
;;     syscall
;;     inc r9
;;     cmp r9, [ArgCount]
;;     jb Showem
;;     jmp Exit

Error:  mov rax, 1
        mov rdi, 1
        mov rsi, ErrMsg
        mov rdx, ERRLEN
        syscall
Exit:   mov rax, 60
        mov rdi, 0
        syscall
