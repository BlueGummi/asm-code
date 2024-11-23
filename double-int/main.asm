section .bss
    buffer resb 256    ; we reserve 256 bytes for input
    result resb 10      ; we reserve space for the result string

section .data
    welcome db 'Enter a number, this will return the double of it: '
    welcome_len equ $ - welcome ; welcome message
    returned db 'Double of your number is: '
    returned_len equ $ - returned ; length of thing to return
    newline db 10
    tempeax dd 0
    tempebx dd 0
    tempecx dd 0
    tempedx dd 0
section .text
    global _start

_start:

    mov ecx, welcome    ; put welcome message here
    mov edx, welcome_len; length of welcome
    call print
    ; read user input
    mov eax, 3          ; sys_read
    mov ebx, 0          ; file descriptor 0 (stdin)
    mov ecx, buffer     ; buffer to store input
    mov edx, 256        ; maximum number of bytes to read
    int 0x80            ; call kernel

    ; convert input string to integer
    mov ecx, buffer     ; ecx points to the input string
    xor eax, eax        ; clear eax (accumulator for the result)

.next_digit:
    movzx ebx, byte [ecx] ; load the next character
    test ebx, ebx         ; check for null terminator
    jz .done               ; if zero, we are done
    cmp ebx, 10           ; check if it's a newline
    je .done               ; if newline, we are done

    sub ebx, '0'          ; convert ascii to integer
    imul eax, eax, 10     ; multiply eax by 10 (shift left)
    add eax, ebx          ; add the digit to eax
    inc ecx               ; move to the next character
    jmp .next_digit       ; repeat for the next digit

.done:
    ; double the number
    shl eax, 1            ; eax = eax * 2

    ; convert the result back to string
    mov ecx, result       ; ecx points to the result string
    mov edi, 10           ; base 10 for conversion
    xor ebx, ebx          ; clear ebx (digit count)
    mov ebx, eax          ; store the doubled value in ebx for conversion

.convert:
    xor edx, edx          ; clear edx
    div edi                ; eax = eax / 10, edx = eax % 10
    add dl, '0'           ; convert remainder to ascii
    dec ecx               ; move to the previous character in the buffer
    mov [ecx], dl         ; store the digit
    inc ebx               ; increase digit count
    test eax, eax         ; check if EAX is zero
    jnz .convert           ; repeat if not zero
    ; write the result

     
    mov edx, result      ; point to the end of the result string
    sub edx, eax          ; calculate length of the result string
    mov [tempedx], edx
    xor edx, edx
    mov [tempecx], ecx
    xor ecx, ecx
    mov [tempeax], eax
    xor eax, eax
    mov [tempebx], ebx
    xor ebx, ebx
    call return
    mov edx, [tempedx]
    mov ecx, [tempecx]
    mov ebx, [tempebx]
    mov eax, [tempeax]
    call print

    mov ecx, newline
    mov edx, 1
    call print            ; newline
    ; exit program
    mov eax, 1            ; sys_exit
    xor ebx, ebx          ; exit code 0
    int 0x80              ; call kernel

print:
    mov ebx, 1     ; file descriptor (stdout)
    mov eax, 4     ; system call number (sys_write)
    int 0x80       ; call kernel
    ret

return:
    mov ecx, returned
    mov edx, returned_len
    call print
    ret
