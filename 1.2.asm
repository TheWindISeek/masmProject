DATAS SEGMENT
    HELLO byte 'Hello$'
    WORLD byte 'World$'
    CHANGELINE DB 13,10,'$'
DATAS ENDS

STACKS SEGMENT
    ;此处输入堆栈段代码
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    ;输出两个字符串 中间需要换行
    mov dx,offset HELLO
    mov ah,09h
    int 21h
    
    mov dx,offset CHANGELINE
    mov ah,09h
    int 21h
    
    mov dx,offset WORLD
    mov ah,09h
    int 21h
    
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START

