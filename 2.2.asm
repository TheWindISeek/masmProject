DATAS SEGMENT
    DAT1 DB 10;���建��������
    	db ?;Ԥ��ʵ�������ַ������ļ�����Ԫ
    	db 10 dup('$');��DS����buffer�Ķλ�ַ
    CRLF db 13,10,'$'
DATAS ENDS

STACKS SEGMENT
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    ;�˴��������δ���
    ;N1 ���ɼ����ַ���
    ;N2 ʵ�ʼ����ַ�
    ;��ż����ַ�
    ;0DH
    ;�����ַ� ����dat1 ��������СΪ20
    lea dx, DAT1
    mov ah, 0ah
    int 21h
    ;������з� ��ֹ���Ե�
    lea dx, CRLF
    mov ah, 09h
    int 21h
    ;ƫ����λ ����Ԥ���建�������� ʵ�����볤��
    lea dx, dat1+2
    mov ah,09h
    int 21h
    ;������з� ��ֹ���Ե�
    lea dx, CRLF
    mov ah, 09h
    int 21h
    ;���ʵ�����볤��
    mov dl, dat1+1
    add dl, '0'
    mov ah, 2
    int 21h
    
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START


