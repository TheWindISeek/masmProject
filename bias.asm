assume ds:data, cs:code, ss:stack

data segment
    ; db define byte 
    ; dw define word
    ; dd double word
    dd 100001
    dw 100
    db 0
    db 3 dup(0, 1, 2);������9���ֽ�  db ָ������ ���dup�ظ����� dup�ڲ�������
data ends

stack segment
    db 0 0 0 0 0 0 0 0
stack ends 

code segment
start:
    ;������������ݵı��
    ; idata ֱ�Ӱ����ڻ���ָ���е����� ִ��ǰ��CPU��ָ������� 
    ;ָ��Ҫ����������ڼĴ����� �ڻ��ָ���и�����Ӧ�ļĴ�����
    ;ָ��Ҫ������������ڴ��� �ڻ��ָ���п���[x]�ĸ�ʽ����EA, SA��ĳ���μĴ�����
    ;[bp+si*n+idata] Ĭ�϶μĴ���Ϊ ss ��[bx+su*n+idata]Ĭ�϶μĴ���Ϊds 
    ;Ҳ������ʽ���� ds:[bp] ss:[bx] 
    ;
    ;Ѱַ��ʽ
    ;[idata]   ֱ��Ѱַ 
    ;[bx] [si] [di] [bp]    �Ĵ���ֱ��Ѱַ
    ;[bx+idata] [si+idata] [di+idata] [bp+idata]    �Ĵ������Ѱַ �ṹ��[bx].idata ����idata[si] ��ά���� [bx][idata]
    ;[bx+si] [bp+si] [bx+di] [bp+di]    ��ַ��ַѰַ ��ά���� [bx][si]
    ;[bx+si+idata] [bx+di+idata] [bp+si+idata] [bp+di+idata] ��Ի�ַ��ַѰַ ����нṹ��������[bx].idata[si] idata[bx][si]
    ;
    ;ָ�������ֳ�
    ;mov ax, 1
    ;mov ds:[0], ax
    ;mov ds, ax
    ;Ĭ���ֲ��� 
    ;mov al, 1
    ;mov bl, ds:[0]
    ;mov al, ds:[0]
    ;Ĭ���ֽڲ���
    ;������ʾָ���ֽڲ��������ֲ���
    ;use word ptr/byte ptr
    ;mov word ptr ds:[0], 1
    ;mov byte ptr ds:[0], 1
    ;push ֻ�ܽ����ֲ���
    ;
    ;struct company {
    ;   char cn[3];
    ;   char hn[9];
    ;   int pm;
    ;   int sr;
    ;   char cp[3];
    ;};
    ;struct company dec = {"DEC", "Ken Olsen", 137, 40, "PDP"};
    ;
    ;mov ax, seg
    ;mov ds, ax
    ;mov bx, 60h
    ;mov word ptr [bx].0ch, 38
    ;
    ;add word ptr [bx].0eh, 70
    ;
    ;mov si, 0
    ;mov byte ptr [bx].10h[si], 'V'
    ;inc si
    ;mov byte ptr [bx].10h[si], 'A'
    ;inc si
    ;mov byte ptr [bx].10h[si], 'X'
    ;
    ;����8λ ����������AX �����al ������ah
    ;����16λ ��������λ��DX ��λ��AX �����AX ������DX
    ;mov dx, 1
    ;mov ax, 86a1h
    ;mov bx, 100
    ;div bx
    ;
    ;����һ�������Եڶ������Ľ�����ڵ�������
    mov ax, data
    mov ds, ax
    mov ax, ds:[0]
    mov dx, ds:[2]
    div word ptr ds:[4]
    mov ds:[6], ax

    ;
    mov ah, 4CH
    int 21h
code ends

end start
