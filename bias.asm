assume ds:data, cs:code, ss:stack

data segment
    ; db define byte 
    ; dw define word
    ; dd double word
    dd 100001
    dw 100
    db 0
    db 3 dup(0, 1, 2);定义了9个字节  db 指定类型 后跟dup重复次数 dup内部的数据
data ends

stack segment
    db 0 0 0 0 0 0 0 0
stack ends 

code segment
start:
    ;汇编语言中数据的表达
    ; idata 直接包含在机器指令中的数据 执行前在CPU的指令缓冲器中 
    ;指令要处理的数据在寄存器中 在汇编指令中给出相应的寄存器名
    ;指令要处理的数据在内存中 在汇编指令中可用[x]的格式给出EA, SA在某个段寄存器中
    ;[bp+si*n+idata] 默认段寄存器为 ss 而[bx+su*n+idata]默认段寄存器为ds 
    ;也可用显式给出 ds:[bp] ss:[bx] 
    ;
    ;寻址方式
    ;[idata]   直接寻址 
    ;[bx] [si] [di] [bp]    寄存器直接寻址
    ;[bx+idata] [si+idata] [di+idata] [bp+idata]    寄存器相对寻址 结构体[bx].idata 数组idata[si] 二维数组 [bx][idata]
    ;[bx+si] [bp+si] [bx+di] [bp+di]    基址变址寻址 二维数组 [bx][si]
    ;[bx+si+idata] [bx+di+idata] [bp+si+idata] [bp+di+idata] 相对基址变址寻址 表格中结构的数据项[bx].idata[si] idata[bx][si]
    ;
    ;指定处理字长
    ;mov ax, 1
    ;mov ds:[0], ax
    ;mov ds, ax
    ;默认字操作 
    ;mov al, 1
    ;mov bl, ds:[0]
    ;mov al, ds:[0]
    ;默认字节操作
    ;可以显示指定字节操作还是字操作
    ;use word ptr/byte ptr
    ;mov word ptr ds:[0], 1
    ;mov byte ptr ds:[0], 1
    ;push 只能进行字操作
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
    ;除数8位 被除数放在AX 结果放al 余数放ah
    ;除数16位 被除数高位放DX 低位放AX 结果放AX 余数放DX
    ;mov dx, 1
    ;mov ax, 86a1h
    ;mov bx, 100
    ;div bx
    ;
    ;将第一个数除以第二个数的结果放在第三个数
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
