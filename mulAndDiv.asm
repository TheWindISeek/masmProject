assume cs:code, ds:data, ss:stack

data segment
    buffer dw 16 dup(0)
    CRLF db 13, 10, '$'
    tip0 db 'Please input the length of numbers you want to sort(maximum is 16):', 13, 10, '$'
    tip1 db 'Please input the number you want to sort:(each number end with a non-digital number):', 13, 10,'$'
    tip2 db 'Below is the sorted numbers:', 13, 10, '$'
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
    mov sp, 40h

    

    mov dx, offset tip0
    mov ah, 9
    int 21h
    
    call input
    mov cx, ax
    ;12a    -> c
    ;23b    -> 17
    ;9c     -> 9
    ;45d    -> 2d
    ;8e     -> 8
    ;10a    -> a
    ;11b    -> b
    ;15d    -> f
    ;4a     -> 4
    ;13d    -> d
    mov dx, offset tip1
    mov ah, 9
    int 21h

    mov si, offset buffer
    call inputSomeData

    ;mov di, 2
    ;call partition
    call quickSort

    mov dx, offset tip2
    mov ah, 9
    int 21h

    call outputSomeData

    mov ah, 4ch
    int 21h

    quickSort:
    ;select the 0-th 
    ;select base number less put in the left bigger in the right
    ;input : cx = length of nums; ds:si = the first address of array
    ;return : ds:si = the first address of sorted array
    ;--calcuate first and last 
    push si
    push di
    push cx
    ;-------------
    shl cx, 1; word byte
    add cx, si
    mov di, cx
    sub di, 2
    call quickSortLeftRight
    ;-------------
    pop cx
    pop di
    pop si
    ret


    quickSortLeftRight:
    ;input : ds:si = the first address of array; ds:di = the last address of array;
    ;return : ds:si = the first address of sorted array
    ;
    push si
    push di
    push bp
    ;----------------
    ;---if si >= di then quit
    cmp si, di
    jnb endQuickSortLeftRight
    ;---------
    call partition
    ;bp is the bias place
    ;
    ;-----------
    push si
    push di
    ;si - bp-2------------
    sub bp, 2
    mov di, bp
    call quickSortLeftRight
    pop di
    ;bp+2 - di------------
    add bp, 4
    mov si, bp
    call quickSortLeftRight
    pop si
    ;----------------
    endQuickSortLeftRight:
    pop bp
    pop di
    pop si
    ret

    partition:
    ;
    ;input : ds:si = the first address of array; ds:di = the last address of array
    ;return : bp = the address of bias
    push si
    push di
    push cx
    push bx
    push ax
    ;----------
    mov bx, word ptr ds:[si]
    ;
    mov bp, si; record the address of bias number
    add si, 2;
    ;
    ;if only have one element
    cmp bp, di
    jz endPartition
    ;----------
    LeftLessRight:
    findLeft:
    mov ax, word ptr ds:[si]
    cmp ax, bx
    jnb endFindLeft
    add si, 2
    ;-----------if out of size-
    cmp si, di
    ja endPartition
    ;-------------------------
    jmp findLeft
    endFindLeft:nop

    findRight:
    mov ax, word ptr ds:[di]
    cmp ax, bx
    jna endFindRight
    sub di, 2
    ;------------------if out of size
    cmp si, di
    ja endPartition
    ;-------------------------------
    jmp findRight
    endFindRight:nop


    ;--------avoid swap, si > di
    cmp si, di
    jnb endPartition
    ;swap two number
    mov ax, word ptr ds:[si]
    mov cx, word ptr ds:[di]
    mov word ptr ds:[di], ax
    mov word ptr ds:[si], cx
    ;
    ;add si, 2
    ;sub di, 2
    cmp si, di
    jna LeftLessRight
    ;-----------
    endPartition:
    ;-------swap the bais number
    mov ax, word ptr ds:[di]
    mov word ptr ds:[di], bx
    mov word ptr ds:[bp], ax
    ;----------
    mov bp, di
    ;----------
    pop ax
    pop bx
    pop cx
    pop di
    pop si
    ret


    inputSomeData:
    ;function : read cx number from keyborad, end with nondigital charter
    ;input : cx = number of input, ds:si = the first address of  store number
    ;return : void
    push ax
    push cx
    push dx
    push si
    ;-----------------
    lea dx, CRLF
    inputSomeDataLoop:
    call input
    mov word ptr ds:[si], ax

    mov ah, 9
    int 21h 

    add si, 2
    loop inputSomeDataLoop
    ;----------------
    pop si
    pop dx
    pop cx
    pop ax
    ret
    
    outputSomeData:
    push cx
    push dx
    ;-----------------
    lea dx, CRLF
    outputSomeDataLoop:
    mov ax, word ptr ds:[si]
    call output

    mov ah, 9
    int 21h 

    add si, 2
    loop outputSomeDataLoop
    ;------------------
    pop dx
    pop cx
    ret

    input:
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
