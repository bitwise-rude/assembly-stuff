; A clone of the cat tool in the unix system

format ELF64 executable
entry main

segment readable executable
main:
    ; argument/ file to open
    mov rbx, rsp
    mov rdi, [rbx+16] ; argv[1]

    ; opening a file (syscall)
    mov rax, 2
    ; the following arguments are modes, don't worry about them
    xor rsi, rsi
    xor rdx, rdx
    syscall
    
    ; TODO: check when fd < 0
    mov r12, rax ; File descriptor

    ; reading the file (syscall)
    mov rax, 0
    mov rdi, r12
    mov rsi, buffer
    mov rdx, 4096
    syscall

    ; display the text (sycall)
    mov rax, 1
    mov rdi, 1
    mov rsi, buffer
    mov rdx, 4096 
    syscall

    ; exit with exit code (syscall)
    mov rax, 60
    mov rdi, 1
    syscall

segment readable writable
buffer rb 4096









