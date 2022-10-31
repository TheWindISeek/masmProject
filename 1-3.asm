DATAS SEGMENT
    CRLF db 13,10,'$'
DATAS ENDS

STACKS SEGMENT
    ;此处输入堆栈段代码
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
	;输入字符 直到遇到非数字字符
    call input
    
    mov ah, 4ch
    int 21h
    
    ;编写子程序input
    ;
    input proc
    ;压栈
    push dx
    push ax
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
    
    mov dl, al
    mov ax, bx
    mul cl
    sub dl,'0'
    mov dh, 0
    add ax, dx
    mov bx, ax
    
    jmp read
    

    quit:
    lea dx, CRLF
    mov ah, 9
    int 21h
    ;输出结果
    mov ax, bx
    call output
    ;出栈
    pop bx
    pop cx
    pop ax
    pop dx
    
    ret 
    input endp
    
    
    
    
    
    
    
    ; 编写子程序output 
    ;将AX中的数以无符号十进制形式输出显示
    ;如果存在 入口参数 和 出口参数 请标注
     
    output proc
	;压栈
	push dx
	push cx
	push bx
	;计数器初始化
	mov bl, 0
	;无符号十进制 未知长度 需要不断除10
	
	mov cl, 10
	bbegin:
	mov ah, 0 ; 别忘记给ah赋值为0
	div cl
	push ax;压栈
	inc bl
	;除数放在 al, 余数放在ah

	cmp al, 0
	jnz bbegin
	
	aa:
	;输出
	pop dx
	mov dl, dh
	add dl, '0'
	mov ah, 2
	int 21h
	dec bl
	
	cmp bx, 0
	jnz aa
	
	
	;出栈
	pop bx
	pop cx
	pop dx 
	ret
     output endp
    
    
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START




