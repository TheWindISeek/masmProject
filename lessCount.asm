assume cs:code, ds:data, ss:stack

data segment
    table dw -134, 1, -127, 125, 0, -1, -5, -1
    line db "the is a line from these data$$$$$"
    less dw 0 ; 8
    aboveOrEqual dw 0 ; 8
    tips0 db 'Please input the numbers of data', 13, 10, '$'
    lessTip db 13, 10, 'less : ', 13, 10, '$'
    aboveOrEqualTip db 13, 10, 'above or Equal : ', 13, 10, '$'
data ends

stack segment
    db 64 dup(0)
stack ends

code segment
    start:
    mov ax, data
    mov ds, ax
    mov ax, stack
    mov ss, ax
    mov sp, 20h


    lea dx, tips0
    mov ah, 9
    int 21h

    mov si, offset table
    mov cx, offset line - offset table
    call count
   
    lea dx, lessTip
    mov ah, 9
    int 21h

    mov bx, offset less
    mov ax, ds:[bx]
    call output

    lea dx, aboveOrEqualTip
    mov ah, 9
    int 21h

    mov bx, offset aboveOrEqual
    mov ax, ds:[bx]
    call output
    
    mov ah, 4ch
    int 21h
    count:
    ;ds:si = the first address of nums
    ;cx = the total numbers
    push si
    push dx
    push cx
    push bx
    push ax

    shr cx, 1
    shr cx, 1
    countLoop:
    mov ax, word ptr ds:[si]
    mov dx, word ptr ds:[si+2]
    cmp ax, dx
    jnb greater
    mov bx, offset less
    jmp AddOne
    greater:
    mov bx, offset aboveOrEqual
    AddOne:
    mov dx, word ptr ds:[bx]
    add dx, 1
    mov word ptr ds:[bx], dx

    add si, 4
    loop countLoop
    pop ax
    pop bx
    pop cx
    pop dx
    pop si
    ret

    output:
    ;function : output ax as decimal based number
    ;input : ax
    ;return : void
	;压栈
	push dx
	push cx
	push bx
    push ax
    ;------------
    mov bx, 0

    mov cx, 10
    mov dx, 0
    div cx
    divLoop:
    push dx
    mov dx, 0
    div cx
    inc bx
    cmp dx, 0
    jnz divLoop

    outputLoop:
    pop dx
    mov dh, 0
    add dl, 30h;ascii
    ;char
    mov ah, 2
    int 21h
    ;
    dec bx
    cmp bx, 0
    jnz outputLoop
	;------------
	;出栈
    pop ax
	pop bx
	pop cx
	pop dx 
	ret
code ends

end start