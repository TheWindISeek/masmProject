DATAS SEGMENT
    ;�˴��������ݶδ���  
DATAS ENDS

STACKS SEGMENT
    ;�˴������ջ�δ���
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    ;
    mov cl,0
    mov bx, 0000h
BEGIN:
    mov ah,1
    int 21h
    
    
    mov [bx], ax
    inc bx
    inc cl
    ;mov ah, 0
    ;push ax
    cmp al, 13
    jnz BEGIN
    ;zf zero flag
    ;jump not zero 
	
	mov bx, 0000h
zloop:
	;pop dx
	
	mov dx, [bx]
	inc bx
	
	mov ah,2
	int 21h
	
	dec cl
	cmp cl,0
	jnz zloop
    
    
    MOV AH,4CH
    INT 21H
CODES ENDS
    END 

