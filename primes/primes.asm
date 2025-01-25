section .data
    percent db '%d', 0xA, 0
section .bss
    reserved_data resd 500
section .text
    extern printf
    global main
main:
    add esp, 4
    mov ecx, 0
    mov ebx, 2
one:
    push ebx
    call four
    add esp, 4
    cmp eax, 1
    jne two
    mov [reserved_data + ecx*4], ebx
    push ebx
    push percent
    call printf
    add esp, 8
    inc ecx
    cmp ecx, 500
    jl three
two:
three:
    inc ebx
    jmp one
    mov eax, 1
    xor ebx, ebx
    int 0x80
four:
    cmp ebx, 2
    jl seven
    cmp ebx, 2
    je six
    test ebx, 1
    jz seven
    mov edi, 3
five:
    mov eax, edi
    mul edi
    cmp eax, ebx
    jg six
    mov edx, 0
    mov eax, ebx
    div edi
    cmp edx, 0
    je seven
    add edi, 2
    jmp five
six:
    mov eax, 1
    ret
seven:
    xor eax, eax
    ret
