format ELF64

extrn printf
extrn _exit

section '.text' executable 
_start:
    mov rdi, msg    
    call printf

    mov rdi, 0
    call _exit

section '.data' writeable 
msg db "Hello World", 10, 0
