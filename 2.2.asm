DATAS SEGMENT
    DAT1 DB 10;定义缓冲区长度
    	db ?;预留实际输入字符个数的技术单元
    	db 10 dup('$');设DS已是buffer的段基址
    CRLF db 13,10,'$'
DATAS ENDS

STACKS SEGMENT
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    ;此处输入代码段代码
    ;N1 最大可键入字符数
    ;N2 实际键入字符
    ;存放键入字符
    ;0DH
    ;输入字符 放在dat1 缓冲区大小为20
    lea dx, DAT1
    mov ah, 0ah
    int 21h
    ;输出换行符 防止被吃掉
    lea dx, CRLF
    mov ah, 09h
    int 21h
    ;偏移两位 跳过预定义缓冲区长度 实际输入长度
    lea dx, dat1+2
    mov ah,09h
    int 21h
    ;输出换行符 防止被吃掉
    lea dx, CRLF
    mov ah, 09h
    int 21h
    ;输出实际输入长度
    mov dl, dat1+1
    add dl, '0'
    mov ah, 2
    int 21h
    
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START


