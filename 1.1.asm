DATAS SEGMENT
    changeline db 13,10,'$'
    
DATAS ENDS

STACKS SEGMENT
    ;�˴������ջ�δ���
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    ;�˴��������δ���
    
    ;�����ַ�����al
    mov ah,1
    int 21h
    
    mov cx,ax
    ;mov dl,al
    ;mov ah,2
    ;int 21h
    
    ;mov dl,'1'
    ;mov ah,2
    ;int 21h
    
	;�س�����
	;mov dx,offset changeline
	;mov ah,9
	;int 21h
	
    mov dl,0dh
    mov ah,2
    int 21h
    
    mov dl,0ah
   	mov ah,2
    int 21h
 	
 	;���al�е�ֵ
    mov dl,cl
    mov ah,2
    int 21h
    
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START

