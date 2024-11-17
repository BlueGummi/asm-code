section .data
    primes_msg db 'Prime numbers:', 0xA, 0
    format db '%d', 0xA, 0

section .bss
    prime_numbers resd 500

section .text
    extern printf
    global _start

_start:
    push primes_msg
    call printf
    add esp, 4

    mov ecx, 0
    mov ebx, 2

next_prime:
    push ebx
    call is_prime
    add esp, 4
    cmp eax, 1
    jne not_prime
    mov [prime_numbers + ecx*4], ebx

    push ebx
    push format
    call printf
    add esp, 8

    inc ecx
    cmp ecx, 500
    jl next_number

not_prime:
next_number:
    inc ebx
    jmp next_prime

    mov eax, 1
    xor ebx, ebx
    int 0x80

is_prime:
    cmp ebx, 2
    jl not_prime_return
    cmp ebx, 2
    je prime_return

    test ebx, 1
    jz not_prime_return

    mov edi, 3

check_loop:
    mov eax, edi
    mul edi
    cmp eax, ebx
    jg prime_return
    mov edx, 0
    mov eax, ebx
    div edi
    cmp edx, 0
    je not_prime_return

    add edi, 2
    jmp check_loop

prime_return:
    mov eax, 1
    ret

not_prime_return:
    xor eax, eax
    ret
