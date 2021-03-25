section .data:
	msg:    db "Digite uma frase: ", 0x0
	len:    equ $-msg

section .bss
	text:   resb 64 ; defina a quantidade máxima de bytes que serão lidos

section .text:
global _start

_start:
    mov ecx, msg
    mov edx, len
    call print
    mov ecx, text
    mov edx, 64 ; defina a quantidade máxima de bytes que serão lidos
    call read
    xor esi, esi

for:
    mov al, [ecx]
    test al, al
    jz done
    inc esi
    cmp al, 0x61
    jl next_chr
    cmp al, 0x7A
    jg next_chr
    sub al, 0x20
    mov [ecx], al
    jmp next_chr

done:
    sub ecx, esi
    call print
    jmp exit

next_chr:
    inc ecx
    jmp for
    
print:
    mov eax, 4
    xor ebx, 1
    int 0x80
    ret

read:
    mov eax, 3
    xor ebx, ebx
    int 0x80
    ret
    
exit:
    mov eax, 1
    xor ebx, ebx
    int 0x80
