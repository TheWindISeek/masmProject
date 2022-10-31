assume cs:code
;能够修改CS或IP中任意一个或多个的指令被称为转移指令
;
;
;只修改ip 称为段内转移 jmp ax
;同时修改CS和ip 称为段间转移指令 jmp 1000:0
;短转移ip的修改范围为-128-127
;近转移ip的修改范围为-32768-32767
;
;offset 是由编译器自动处理的符号 用于计算标号的偏移量
;jmp short 标号 -128 - 127
;jmp near 标号 -32768 - 32767 同样基于当前地址的偏移量进行计算
;jmp far ptr 标号 远转移 cs = 标号所在段 ip = 标号在段中的偏移地址
; 
;jcxz 有条件转移指令 有条件转移指令都是短转移
;jcxz if cx = zero jmp source else do nothing
;
;
;
;
;
;jmp short s
;db 128 dup (0)
;s:mov ax, 0ffffh
;上述代码编译器会报错 因为跳转距离超过了最大限制127 
;
;
;ret = 
;pop ip
;
;retf = 
;pop ip
;pop cs
;
;call (can't be short) label = 
;push ip
;jmp near ptr label
;
;call far ptr label = 
;push cs
;push ip
;jmp far ptr label
;
;
;call 16 reg = 
;push ip
;jmp 16 reg
;
;call address of memory
;call word ptr address of memory = 
;push ip
;jmp word ptr address of memory
;
;call dword ptr address of memory = 
;push ca
;push ip
;jmp dword ptr address of memory
;
;
;
;
;
;
;
;
data segment
    0fh dup(0)
data ends
code segment
start:
    ;example 1 copy code to next 
    s:mov ax, bx
    mov si, offset s
    mov di, offset s0
    mov ax, cs:[si]
    mov cs:[di], ax
    s0:nop
    nop

    ;example 2 jmp short  跳转距离是当前ip地址的一个偏移量 -128 - 127
    jmp short sz; 
    mov ax, 0
    mov ax, 1
    sz:inc ax
    ;
    ;jmp far ptr s 
    ;db 256 dup(0)
    ;s:add ax, 1
    mov ax, 0123h
    mov ds:[0], ax
    ;jmp word ptr ds:[0] ; ip = 0123h

    mov ax, 0123h
    mov ds:[0], ax
    mov word ptr ds:[2], 0
    ;jmp dword ptr ds:[0];cs = 0000h, ip = 0123h 双字高位cs 低位ip

    mov ah, 4ch
    int 21h
code ends

end start