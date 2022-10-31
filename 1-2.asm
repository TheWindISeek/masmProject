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
    ;从键盘上输入两个数字字符 算出对应的数值
    ;例如输入2 6 计算出26
    
    ;;输入字符放在al
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
    ;;输出2
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
    ;;输出26
    ;;mov dl,al
    ;;mov ah,2
    ;;int 21h
    
    ;最终结果初始化
    mov dl,0
    
    ;输入字符 放在al    
    mov ah,1
    int 21h
    
    ;从ASCII转换为对应数字
    sub al,'0'
    ;暂存对应数字
 	mov dh,al
 	;最终结果乘10
 	mov al,dl
    mov cl,10
    mul cl
    add al,dh
    ;将计算结果放回到最终结果
    mov dl,al
    
    ;逻辑同上
    mov ah,1
    int 21h
    
    sub al,'0'
    
    mov dh,al
    mov al,dl
    mov cl,10
    mul cl
    add al,dh
    mov dl,al
    
    ;输出右箭头代表输出的是26 右箭头的ASCII码为26
    mov ah,2
    int 21h
    
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START




