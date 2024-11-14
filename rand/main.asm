section .data
    msg db 'Random number: ', 0
    msg_len equ $ - msg
    
section .bss
    random_number resb 4

section .text
    global _start

_start:
    rdseed eax
    mov [random_number], eax
    mov rax, 1          ; syscall: write
    mov rdi, 1          ; file descriptor: stdout
    mov rsi, msg        ; pointer to message
    mov rdx, msg_len    ; message length
    syscall
    mov rax, [random_number]
    call print_number 
    mov rax, 60         ; syscall: exit
    xor rdi, rdi        ; exit code 0
    syscall

print_number:
    mov rbx, 10 
    mov rcx, 0          ; counter for digit count
    mov rsi, random_number + 4 ; buffer for string (4 bytes for int + 1 for null terminator)
    
.convert:
    xor rdx, rdx
    div rbx    
    add dl, '0'          ; convert remainder to ASCII
    dec rsi          
    mov [rsi], dl    
    inc rcx              ; increase the digit count
    test rax, rax    
    jnz .convert         ; if not, convert the next digit

    mov rax, 1          ; syscall: write
    mov rdi, 1      
    mov rdx, rcx      
    syscall
    ; newline
    mov rax, 1 
    mov rdi, 1 
    lea rsi, [newline]
    mov rdx, 1 
    syscall
    ret

section .data
    newline db 10 
