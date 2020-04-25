    section     .data
count   dd      0 
loopc   dq      0
    section     .text
    global      _start
_start:
    mov rax, 1
    mov rdi, 1
    mov rdx, [rsp] ; dfsf
    mov dword [count], edx 

    mov r8, rsp ; Copy direction on the TOS to r8
    lea rsi, [count] ; make buffer for write poin to it
    mov rdx, 8
    syscall
    xor rsi, rsi
    xor ebx, ebx
    add r8, 8 ; go to the first address on the stack 
while_loop:
    mov r9, r8 ; save address
    xor r10, r10 ; factor
    mov r8, [r8] ; r8 now holds the address to 1st character in arg
inner_loop:
    mov rax, 1 ; Prepare the system call
    mov rdi, 1 ; File descriptor
    lea rsi, [r8 + r10]
    inc r10
    mov rdx, 1 ; Number of bytes to print
    syscall

    ; xor rcx, rcx
    ; mov rcx, [r8 + r10]
    ; cmp rcx, 0
    xor cl, cl
    mov cl, byte [r8 + r10]
    cmp cl, 0
    jnz inner_loop
finish_while:
    mov r8, r9 ; Restore r8 for next loop
    add r8, 8; go to the next address
    inc ebx
    cmp ebx, dword [count]
    jb while_loop ; end with null pointer
end_loop:
    xor rax, rax
    mov     rax, 60
    xor     rdi, rdi
    syscall
    

