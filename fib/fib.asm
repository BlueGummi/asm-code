section .data
    x dd 0
    y dd 0
    format db '%d', 10, 0
section .text
    extern printf
    global main
main:
    mov eax, 0 ; x = 0
    mov ebx, 1 ; y = 1
    mov [x], eax
    mov [y], ebx
    mov ecx, 0
    call loop
loop:
    pop edx
    push ecx
    push format
    call printf
    mov eax, [x]
    mov ebx, [y]
    add ecx, ebx
    add ecx, eax
    mov eax, ebx ; x = y
    mov ebx, ecx ; y = z
    mov [x], eax
    mov [y], ebx
    jo end
    call loop
end:
    pop edx
    mov eax, 1
    xor ebx, ebx
    int 0x80
