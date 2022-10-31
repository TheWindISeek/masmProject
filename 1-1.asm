DATAS SEGMENT
    ;此处输入数据段代码  
DATAS ENDS

STACKS SEGMENT
    ;此处输入堆栈段代码
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    ;此处输入代码段代码
    
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
    
    ;除10
    mov dl,10
    div dl
    ;余数放ah,商放al
    
    ;转换为ASCII码
    add ah,'0'
    add al,'0'
    
    ;保存余数
    mov dh,ah
    ;输出商
    mov dl,al
    mov ah,2
    int 21h
    ;输出余数
    mov dl,dh
    mov ah,2
    int 21h
    ;结束程序
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START

