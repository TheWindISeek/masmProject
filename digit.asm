assume cs:code, ds:data, ss:stack

data segment
    digital db '0123456789ABCDEF'
    datas dw -134, 1, -127, 125
    ;ff7a 1 ff81 7d
    ;177_572                1       177_601                  175
    ;1111_1111_0111_1010    1       1111_1111_1000_0001    0111_1101
    digital_2 db 'this is based-2:', 13, 10, '$'
    digital_8 db 'this is based-8:', 13, 10, '$'
    digital_16 db 'this is based-16:', 13, 10, '$'
    CRLF db 13,10,'$'
data ends

stack segment
    dw 32 dup(0)
stack ends

code segment
    start:
    mov ax, data
    mov ds, ax
    mov ax, stack
    mov ss, ax
    mov sp, 40h
    ;--------------
    ;2进制显示
    lea dx, digital_2
    mov ah, 9
    int 21h
    mov bx, offset datas
    mov cx, 4
    call show_in_2
    ;8进制显示
    ; mov bx, offset datas
    ; add bx, 0
    ; mov cx, 3
    ; call show_in_cx
    lea dx, digital_8
    mov ah, 9
    int 21h

    mov bx, offset datas
    mov cx, 4
    call show_in_8


    ;16进制显示
    lea dx, digital_16
    mov ah, 9
    int 21h

    mov bx, offset datas
    mov cx, 4
    call show_in_16

    ;--------------
    mov ah, 4ch 
    int 21h
    ;
    show_in_cx:
    ;ax = number
    ;cl = digital 1 = 2, 2 = 4, 3 = 8, 4= 16
    ;
    push dx
    push cx
    push bx 
    push ax
    push si
    ;
    ;先将这个数对位数进行除法操作 然后 拿到余数和结果 再把余数压栈 继续对结果进行相关的处理
    mov bx, cx
    ;bx = div
    ;
    mov cx, 0
    divLoop:  
    mov dx, 0
    div bx
    push dx
    inc cx
    cmp ax, 0
    jnz divLoop
    ;----------
    outputLoop:
    pop si
    mov dl, byte ptr ds:[si]
    mov ah, 2
    int 21h 
    loop outputLoop
    ;
    pop si
    pop ax
    pop bx
    pop cx
    pop dx
    ret 

    show_in_16:
    ;bx = firsr address of the datas
    ;cx = the number of you want to show
    push ax
    mov ax, 16
    call shows_in_ax
    pop ax
    ret


    shows_in_ax:
    ;bx = firsr address of the datas
    ;cx = the number of you want to show
    ;ax = based number
    ;
    push ax
    push bx
    push cx
    push dx
    ;---------
    mov dx, ax
    outputAXLoop:
    push cx
    mov cx, dx
    mov ax, ds:[bx]
    call show_in_cx
    ;----
    push dx
    lea dx, CRLF
    mov ah, 9
    int 21h
    pop dx
    ;----
    add bx, 2
    pop cx
    loop outputAXLoop
    ;---------
    pop dx
    pop cx
    pop bx
    pop ax
    ret
    show_in_8:
    ;bx = firsr address of the datas
    ;cx = the number of you want to show
    push ax
    mov ax, 8
    call shows_in_ax
    pop ax
    ret

    show_in_2:
    ;bx = firsr address of the datas
    ;cx = the number of you want to show
    push ax
    mov ax, 2
    call shows_in_ax
    pop ax
    ret 
code ends

end start