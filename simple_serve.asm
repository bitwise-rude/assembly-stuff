format ELF64 executable

segment readable executable
main:
    mov rbx, rsp 
    mov r8, [rbx] ; argc

    cmp r8, 2
    jl show_usage

    mov rdi, [rbx+16] ; argv[1]

    jmp exit

show_usage:
    ; shows usages and quits
    mov rax, 0x01
    mov rdi, 0x01
    mov rsi, msg
    mov rdx, msg_len  
    syscall
    jmp exit 

show_error:
    ; shows errors a quit
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
err_msg db "Please enter a text to serve", 10
err_msg_len = $ - err_msg

msg db 10, \
    9, \
    "-------Simple_Server-------", \ 
    10,10,9, \
    "Simple Webserver to serve a text",10,10, \ 
    "Usage : simple_server <text>", 10 

msg_len = $ - msg 


