DATAS SEGMENT

DATAS ENDs

STACKS SEGMENT

STACKS ENDs

CODES SEGMENT
           ASSUME DS:DATAS, CS:CODES, SS:STACKS
    START: 
           mov    ax, DATAS
           mov    ds, ax
    ;output ax 无符号十进制
    ;对用到的寄存器进行初始值设定 ax = 2555 cx = 0
           mov    ax, 2555
           mov    cx, 0
           mov    bl, 10
    ;循环输出ax

           div    bl
           push   ax
           inc    cx

           cmp    al, 0
           jz     output

    next:
           mov    ah, 0
           div    bl
           push   ax
           inc    cx
           cmp    al, 0
           jnz    next
    output:  
           pop    dx
           mov    dl, dh
           add    dl, '0'
           mov    ah, 2
           int    21H
           dec    cx
           cmp    cx, 0
           jnz    output
           
           mov ah, 4CH
           int 21h
CODES ENDS
    end START