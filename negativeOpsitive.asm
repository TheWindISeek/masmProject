assume cs:code, ds:data, ss:stack

data segment
    table dw 128, -128, 0, 0, 156, 100, -134, 122, 255, -255, -122, 134, -256, 256, 0, -0
    line db "the is a line from these data$$$$$"
    zero dw 0 ; 4
    negetive dw 0 ; 5
    opsitive dw 0 ; 7
    tips0 db 'Please input the numbers of data', 13, 10, '$'
    zeros db 13, 10, 'zeros : ', 13, 10, '$'
    negetives db 13, 10, 'negetives : ', 13, 10, '$'
    opsitives db 13, 10, 'opsitives : ', 13, 10, '$' 
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
   
    lea dx, zeros
    mov ah, 9
    int 21h

    mov bx, offset zero
    mov ax, ds:[bx]
    call output

    lea dx, negetives
    mov ah, 9
    int 21h

    mov bx, offset negetive
    mov ax, ds:[bx]
    call output

    lea dx, opsitives
    mov ah, 9
    int 21h

    mov bx, offset opsitive
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
    countLoop:
    mov ax, word ptr ds:[si]
    mov dx, word ptr ds:[si+2]
    cmp ax, 0
    jnz opsitiveOrNegetive
    mov bx, offset zero
    jmp AddOne

    opsitiveOrNegetive:
    ;判断是正数还是负数
    and ax, 0ff00h
    xor ax, 0ff00h
    cmp ax, 0
    je NegetiveLabel

    mov bx, offset opsitive
    jmp AddOne

    NegetiveLabel:
    mov bx, offset negetive

    AddOne:
    mov dx, word ptr ds:[bx]
    add dx, 1
    mov word ptr ds:[bx], dx

    add si, 2
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


    input:
    ;0-2559
    ;function : read number from keyborad until input charter isn't digital charter
    ;input : void
    ;output : ax <- input number
    ;
    ;压栈
    push dx
    push cx
 	push bx
    ;读取字符 放
    mov cl, 10
    mov bx, 0
    read:
    
    mov ah, 1
    int 21h
    
    cmp al, '0'
    jb quit;如果dl小于0
    cmp al, '9'
    jg quit;如果比9大
    ;此处存在问题 cl为8位
    mov dl, al
    mov ax, bx
    mul cl
    sub dl,'0'
    mov dh, 0
    add ax, dx
    mov bx, ax
    
    jmp read
    

    quit:
    ;输出结果
    mov ax, bx
    ;出栈
    pop bx
    pop cx
    pop dx
    
    ret 
code ends

end start