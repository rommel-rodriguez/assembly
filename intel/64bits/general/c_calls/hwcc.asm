    section .data
msg:    db  "Hello World!", 0x0a    ; String to print
len:    equ $-msg                   ; Length of the string
    section .text
    global  main
    extern  write, exit
main:
    mov edx, len    ; Arg 3 is the length
    mov rsi, msg    ; Arg 2 is the array 
    mov edi, 1      ; Arg 1 is the fd
    call    write
    xor edi, edi
    call    exit
