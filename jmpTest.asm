assume cs:code 
data segment
    ;db 0, 0, 0
    ;dd 12345678h
    dw 8 dup(0)
data ends

code segment
start:
    ;mov ax, data
    ;mov ds, ax
    ;mov bx, 0
    ;jmp word ptr [bx+1]
    ;mov ax, data
    ;mov ds, ax
    ;mov bx, 0
    ;mov [bx], word ptr 0
    ;mov [bx+2],  cs
    ;jmp dword ptr ds:[0]


    ;p195 test case 10.5
    ;mov ax, data
    ;mov ss, ax
    ;mov sp, 16
    ;mov ds, ax
    ;mov ax, 0

    ;call word ptr ds:[0eh];会执行下一条语句
    
    ;inc ax
    ;inc ax
    ;inc ax
    ;mov dl, al 
    ;mov ah, 2h
    ;int 21h
    

    ;p196 test case 10.6
    ;mov ax, data
    ;mov ss, ax
    ;mov sp, 16
    ;mov word ptr ss:[0], offset s
    ;mov ss:[2], cs
    ;call dword ptr ss:[0]
    ;此处有多少个nop ax的值就是多少 
    ;因为记录的ip是下一个指令的ip 而call 和 s之间隔了一个nop nop 一个字节
    ;nop
    ;nop
    ;nop
    ;nop
    ;nop
    ;nop
    ;s:mov ax, offset s
    ;sub ax, ss:[0ch]
    ;mov bx, cs
    ;sub bx, ss:[0eh]
    ;mov dl, al
    ;add dl, 30h
    ;mov ah, 2
    ;int 21h

    ;mov dl, bl
    ;add dl, 30h
    ;mov ah, 2
    ;int 21h


    ;
    mov ah, 4ch
    int 21h
code ends

end start