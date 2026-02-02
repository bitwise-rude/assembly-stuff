; A clone of the `cat` tool in the unix system

format ELF64 executable

segment readable executable
main:
    ; argument/ file to open
    mov rbx, rsp 
    mov r8, [rbx] ; argc

    ; check if argc is greater than equal to 2
    cmp r8, 2
    jl show_usage

    mov rdi, [rbx+16] ; argv[1]

    ; opening a file (syscall)
    mov rax, 2
    ; the following arguments are modes, don't worry about them
    xor rsi, rsi
    xor rdx, rdx
    syscall
    
    ; check if file succesfully opened, in case of not opened, rax < 0
    cmp rax, 0
    jl show_error

    mov r12, rax ; File descriptor

    ; read this in a loop since read handles all of the things
read_display_loop:
    ; reading the file (syscall)
    mov rax, 0
    mov rdi, r12
    mov rsi, buffer
    mov rdx, 4096 
    syscall

    cmp rax, 0
    je exit ; means file has been read completely

    ; display the text (sycall)
    mov rax, 1
    mov rdi, 1
    mov rsi, buffer
    mov rdx, 4096 
    syscall

    jmp read_display_loop


show_usage:
    ; prints to the stdout wiht msg
    mov rax, 0x01
    mov rdi, 0x01
    mov rsi, msg
    mov rdx, msg_len  
    syscall
    jmp exit 

show_error:
    ; display file not found error
    mov rax,1
    mov rdi,1
    mov rsi, err_msg
    mov rdx, err_msg_len
    syscall

exit:
    ; exit with exit code (syscall)
    mov rax, 60
    mov rdi, 1
    syscall

segment readable writable
buffer rb 4096

err_msg db "Error:File You have specified couldnt be opened", 10
err_msg_len = $ - err_msg

msg db 10, \
    9, \
    "-------NeoCat-------", \ 
    10,10,9, \
    "A lightweight `cat` alternative",10,10, \ 
    "Usage : neocat <filename>", 10 

msg_len = $ - msg 



