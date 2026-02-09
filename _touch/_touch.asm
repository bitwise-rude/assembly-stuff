format ELF64 executable
entry main

segment executable readable
main:
    mov r10,[rsp]
    cmp r10,2 
    jl print_usage

    mov r11, [rsp+8]
    mov r9,1
    _loop:
        cmp r9,r10
        jge exit

        mov r8, [r11+8*r9]
        call print

        inc r9
        jmp _loop

    jmp exit

print:
    mov rax,1
    mov rdi,1
    mov rsi,r8 
    mov rdx,2
    syscall
    ret

print_usage:
    mov rax, 1
    mov rdi, 1
    mov rsi, usage
    mov rdx, len_usage
    syscall

exit:
    mov rax, 60
    mov rdi, 0
    syscall

usage db "_touch: missing file operand", 10
db "Don't Try _touch --help for more information",10

len_usage = $ - usage
