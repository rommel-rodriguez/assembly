    section     .data
msg:    db      "Testing this.", 0x0a
count   dd      0
len:    equ     $-msg
    section     .text
    global      _start
_start:
    mov rax, 1
    mov rdi, 1
    lea rsi, [msg]
    mov rdx, len
    syscall
    mov     rax, 60
    xor     rdi, rdi
    syscall
    

