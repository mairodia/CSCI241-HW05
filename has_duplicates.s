;;;
;;; has_duplicates.s
;;;
section .data
    array:
        dq  0, 1, 2, 3, 4, 0, 6,
    length:     equ $-array
    msg_nodupe: db  "There are no duplicates.", 10
    nd_len      equ $-msg_nodupe
    msg_dupe:   db  "There are duplicates.", 10
    d_len       equ $-msg_dupe

section .text
global _start
_start:
    mov rdi, array
    mov rsi, length/8
    call  has_duplicates
    cmp rax, 0              ; if rax = 0, no dupes
    jne .duplicates
    ; if there are duplicates, then:
        mov rax, 1
        mov rdi, 1
        mov rsi, msg_nodupe
        mov rdx, nd_len
        syscall
        mov rax, 60
        mov rdi, 0
        syscall

    .duplicates:
        mov rax, 1
        mov rdi, 1
        mov rsi, msg_dupe
        mov rdx, d_len
        syscall
        mov rax, 60
        mov rdi, 0
        syscall

has_duplicates:

    mov rcx, rsi        ; counter
    mov rbx, rdi        ; base ptr for rdi array

    .loop:
        mov r8, [rdi]    ; member to be compared
        mov r9, rcx      ; inner counter
        lea rdi, [rdi+8] ; move to next member

        .inner_loop:
            cmp r9, 0
            je .exit_inner
            cmp r8, [rdi]
            je .duplicate
            add rdi, 8
            dec r9
            jmp .inner_loop
        .exit_inner:
        add rbx, 8
        mov rdi, rbx
    loop .loop

    mov rax, 0
    ret

    .duplicate:
        mov rax, 1
        ret
