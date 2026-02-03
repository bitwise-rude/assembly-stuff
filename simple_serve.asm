format ELF64 executable

; code -> rax
; o -> rdi
;1 -> rsi
; 2 -> rdx
segment readable executable
main:
    mov rbx, rsp 
    mov r8, [rbx] ; argc

    cmp r8, 2
    jl show_usage

    mov rdi, [rbx+16] ; argv[1]

    ; creating socket
    mov rax, 0x29
    mov rdi, 2 ; AF_INET
    mov rsi, 1 ; SOCK_STREAM and SOCKET NONBLOCK
    mov rdx, 0 ; idk what this is 
    syscall 

    cmp rax, 0
    jl show_error_msg_socket 
    mov r10, rax

    ; binding
    mov rax, 0x31
    mov rdi, r10
    mov rsi, sockaddr
    mov rdx, 16
    syscall

    cmp rax, 0
    jne show_error_msg_socket
    

    ; listen
    mov rax, 0x32
    mov rdi, r10
    mov rsi, 50 
    syscall  

    ; accept
    mov rax, 0x2b
    mov rdi, r10
    mov rsi, sockaddr2
    mov rdx, temp_addr
    syscall

    cmp rax, 0
    jl show_error_msg_socket
    mov r9, rax

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

show_error_msg_socket:
    mov rax, 1
    mov rdi, 1
    mov rsi, err_msg_socket
    mov rdx, err_msg_socket_len
    syscall

exit:
    ; exit with exit code (syscall)
    mov rax, 60
    mov rdi, 1
    syscall

segment readable writable
err_msg db "Please enter a text to serve", 10
err_msg_len = $ - err_msg

err_msg_socket db "Some Error in socket Creation", 10
err_msg_socket_len = $ - err_msg_socket

msg db 10, \
    9, \
    "-------Simple_Server-------", \ 
    10,10,9, \
    "Simple Webserver to serve a text",10,10, \ 
    "Usage : simple_server <text>", 10 

msg_len = $ - msg 


temp_addr: 
    dw 16

sockaddr: 
    dw 2 ; AF_INET
    dw 0x5c11 ; port number = 2
    dd 0 ; 0.0.0.0
    dq 0 ; padding purposes 


sockaddr2: 
    dw 2 ; AF_INET
    dw 0x1F90; port number = 8080
    dd 0 ; 0.0.0.0
    dq 0 ; padding purposes 
