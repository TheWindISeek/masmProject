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
    ;�˴��������δ���
    
    ;mov ax,26
    ;mov bl,10
    ;div bl
    ;
    ;mov ch,ah
    ;mov dl,al
    ;add dl,48
    ;mov ah,2
    ;int 21h
    ;
    ;mov dl,ch
    ;add dl,48
    ;mov ah,2
    ;int 21h
    
    mov ax,26
    
    ;��10
    mov dl,10
    div dl
    ;������ah,�̷�al
    
    ;ת��ΪASCII��
    add ah,'0'
    add al,'0'
    
    ;��������
    mov dh,ah
    ;�����
    mov dl,al
    mov ah,2
    int 21h
    ;�������
    mov dl,dh
    mov ah,2
    int 21h
    ;��������
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START

