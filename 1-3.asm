DATAS SEGMENT
    CRLF db 13,10,'$'
DATAS ENDS

STACKS SEGMENT
    ;�˴������ջ�δ���
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
	;�����ַ� ֱ�������������ַ�
    call input
    
    mov ah, 4ch
    int 21h
    
    ;��д�ӳ���input
    ;
    input proc
    ;ѹջ
    push dx
    push ax
    push cx
 	push bx
    ;��ȡ�ַ� ��
    mov cl, 10
    mov bx, 0
    read:
    
    mov ah, 1
    int 21h
    
    
    
    cmp al, '0'
    jb quit;���dlС��0
    cmp al, '9'
    jg quit;�����9��
    
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
    ;������
    mov ax, bx
    call output
    ;��ջ
    pop bx
    pop cx
    pop ax
    pop dx
    
    ret 
    input endp
    
    
    
    
    
    
    
    ; ��д�ӳ���output 
    ;��AX�е������޷���ʮ������ʽ�����ʾ
    ;������� ��ڲ��� �� ���ڲ��� ���ע
     
    output proc
	;ѹջ
	push dx
	push cx
	push bx
	;��������ʼ��
	mov bl, 0
	;�޷���ʮ���� δ֪���� ��Ҫ���ϳ�10
	
	mov cl, 10
	bbegin:
	mov ah, 0 ; �����Ǹ�ah��ֵΪ0
	div cl
	push ax;ѹջ
	inc bl
	;�������� al, ��������ah

	cmp al, 0
	jnz bbegin
	
	aa:
	;���
	pop dx
	mov dl, dh
	add dl, '0'
	mov ah, 2
	int 21h
	dec bl
	
	cmp bx, 0
	jnz aa
	
	
	;��ջ
	pop bx
	pop cx
	pop dx 
	ret
     output endp
    
    
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START




