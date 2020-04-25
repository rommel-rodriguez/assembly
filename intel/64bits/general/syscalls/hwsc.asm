    section .data
hello:  db  "Hello World!", 0x0a
    section .text
    global  _start
_start:  mov     eax, 1      ; syscall 1 is write
        mov     edi, 1      ; file descriptor (STDOUT)
        lea     rsi, [hello]
        mov     edx, 13     ; write 13 bytes
        syscall
        mov     eax, 60     ; syscall 60 is exit
        xor     edi, edi    ; exit(0)
        syscall

