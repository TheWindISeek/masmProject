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
    ;�Ӽ������������������ַ� �����Ӧ����ֵ
    ;��������2 6 �����26
    
    ;;�����ַ�����al
    ;mov ah,1
    ;int 21h
    ;
    ;sub al,48
    ;mov bl,al
    ;mov al,0
    ;mov cl,10
    ;mul cl
    ;add al,bl
    ;mov ch,al
    ;;���2
    ;;mov dl,ch
    ;;mov ah,2
    ;;int 21h
    ;
    ;mov ah,1
    ;int 21h
    ;sub al,48
    ;mov bh,al
    ;mov al,ch
    ;mov cl,10
    ;mul cl
    ;add al,bh
    ;;���26
    ;;mov dl,al
    ;;mov ah,2
    ;;int 21h
    
    ;���ս����ʼ��
    mov dl,0
    
    ;�����ַ� ����al    
    mov ah,1
    int 21h
    
    ;��ASCIIת��Ϊ��Ӧ����
    sub al,'0'
    ;�ݴ��Ӧ����
 	mov dh,al
 	;���ս����10
 	mov al,dl
    mov cl,10
    mul cl
    add al,dh
    ;���������Żص����ս��
    mov dl,al
    
    ;�߼�ͬ��
    mov ah,1
    int 21h
    
    sub al,'0'
    
    mov dh,al
    mov al,dl
    mov cl,10
    mul cl
    add al,dh
    mov dl,al
    
    ;����Ҽ�ͷ�����������26 �Ҽ�ͷ��ASCII��Ϊ26
    mov ah,2
    int 21h
    
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START




