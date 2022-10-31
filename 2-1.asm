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
    ;显示设置ds寄存器和ss寄存器
    MOV AX,DATAS
    MOV DS,AX
    
    mov ax, stacks
    mov ss, ax
    
    ;业务逻辑代码
    ;从这里开始调用函数 sum 将两个形参入栈
    mov ax, 0003h
    push ax
    mov ax, 0004h
    push ax
    call sum
    ;退出程序
    mov ah, 4ch
    int 21h
    ;入口参数 出口参数 出口参数会放在哪里？
    ;功能函数
    sum:
    ;用bp指针记录调用前sp指针的值
    mov bp, sp
    
    ;为函数开辟局部变量的空间
    sub sp, 20H
    
    ;定义局部变量 c = 1, d = 2
    mov byte ptr ss:[bp - 2], 0001h
    mov byte ptr ss:[bp - 4], 0002h
    
    ;执行a + b + c + d
    mov ax, ss:[bp + 0004h]
    add ax, ss:[bp + 0002h]
    add ax, ss:[bp - 0002h]
    add ax, ss:[bp - 0004h]
    
    ;恢复sp指针的位置 清空函数内部局部变量
    mov sp, bp
    
    ret 4
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START




