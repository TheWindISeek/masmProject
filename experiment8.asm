assume cs:code

data segment
    ;21 年
    db '1975', '1976', '1977', '1978', '1979', '1980', '1981'
    db '1982', '1983', '1984', '1985', '1986', '1987', '1988'
    db '1989', '1990', '1991', '1992', '1993', '1994', '1995'
    
    ;21年总收入
    dd 16,      22,         382,        1356,       2390,       8000,       16000
    dd 24486,   50065,      97479,      140417,     197514,     345980,     590827
    dd 803530,  1183000,    1843000,    2759000,    3753000,    4649000,    5937000
    
    ;21个雇员人数
    dw 3,       7,      9,      13,     28,     38,     130
    dw 220,     476,    778,    1001,   1442,   2258,   2793
    dw 4037,    5635,   8226,   11542,  14430,  15257,  17800
data ends

table segment
    db 21 dup('year summ ne ?? ')
table ends

code segment
    start:
    ;将data中的数据写入到table中 并计算21年中的人均收入
    mov ax, data
    mov ds, ax
    mov ax, table
    mov ss, ax

    ; bp 指向 table bx固定不变 恒为0
    mov bx, 0
    mov bp, 0
    mov cx, 21
    mov si, 0
    mov di, 0
    row:
    push cx

    ;year
    ;将年份放到指定位置
    push dx
    mov bx, 0; find the begin of years
    mov dx, [bx+si]
    mov [bp], dx
    mov dx, [bx+si+2]
    mov 2h[bp], dx
    pop dx

    ;income nums avg_income
    ; 将收入 四字节放入指定位置 每次移动两个字节 取出人数 两个字节 进行32/16 将结果放入avg_income
    ;si = 4*n; bx = 0; bp = 16*n;
    ;income = 5-8; ne = a-b; avg = d-e;
    ;bx = 30h dword income
    ;bx = 90h word nums
    push ax
    push dx
    push cx


    mov bx, 54h; find the begin of income
    mov ax, word ptr [bx][si];
    mov dx, word ptr [bx][si+2];
    mov 5h[bp], ax
    mov 7h[bp], dx

    mov bx, 0a8h; find the begin of nums
    mov cx, word ptr [bx][di]
    mov 0ah[bp], cx
    
    div cx
    mov 0dh[bp], ax; mov the avg_income to the right place

    pop cx
    pop dx
    pop ax

    ;si 指向下一年份 bp移动到下一行 
    add si, 4
    add di, 2
    add bp, 10h
    pop cx
    loop row

    
    ;
    mov ah, 4CH
    int 21h
code ends

end start