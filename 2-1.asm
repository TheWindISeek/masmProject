DATAS SEGMENT
    HELLO byte 'Hello$'
    WORLD byte 'World$'
    db 20 dup(0)
DATAS ENDS

STACKS SEGMENT
    db 20 dup(0)
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    ;��ʾ����ds�Ĵ�����ss�Ĵ���
    MOV AX,DATAS
    MOV DS,AX
    
    mov ax, stacks
    mov ss, ax
    
    ;ҵ���߼�����
    ;�����￪ʼ���ú��� sum �������β���ջ
    mov ax, 0003h
    push ax
    mov ax, 0004h
    push ax
    call sum
    ;�˳�����
    mov ah, 4ch
    int 21h
    ;��ڲ��� ���ڲ��� ���ڲ�����������
    ;���ܺ���
    sum:
    ;��bpָ���¼����ǰspָ���ֵ
    mov bp, sp
    
    ;Ϊ�������پֲ������Ŀռ�
    sub sp, 20H
    
    ;����ֲ����� c = 1, d = 2
    mov byte ptr ss:[bp - 2], 0001h
    mov byte ptr ss:[bp - 4], 0002h
    
    ;ִ��a + b + c + d
    mov ax, ss:[bp + 0004h]
    add ax, ss:[bp + 0002h]
    add ax, ss:[bp - 0002h]
    add ax, ss:[bp - 0004h]
    
    ;�ָ�spָ���λ�� ��պ����ڲ��ֲ�����
    mov sp, bp
    
    ret 4
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START




