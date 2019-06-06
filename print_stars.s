section .data

newline:    db  10
star:       db  '*'

section .text
global _start
_start:

    call print_stars
    mov rax, 60
    mov rdi, 0
    syscall

print_stars:
    mov rsi, 5
    mov rcx, rsi    ; counter
    mov r10, rcx
    inc r10

    .loop:
        mov r15, rcx    ; temp storage
        mov r9, rcx

        .inner_loop:
            cmp r10, r9
            je .exit_inner_loop
            mov rsi, star
            mov rax, 1
            mov rdi, 1
            mov rdx, 1
            syscall
            inc r9
            jmp .inner_loop
        .exit_inner_loop:

        mov rsi, newline
        mov rax, 1
        mov rdi, 1
        mov rdx, 1
        syscall
        mov rcx, r15    ; restore temp
    loop .loop

    ret
