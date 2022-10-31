assume cs:code

data segment
    db 16 dup(0)
data ends

stack segment
    db 16 dup(0)
stack ends

code segment
    start:
    mov ax, 4240h
    mov dx, 000fh
    mov cx, 0ah
    call divdw
    
    mov ah, 4ch
    int 21h
    
    divdw:
    ;进行不会产生溢出的除法运算 
    ;被除数为dword 除数为word 结果为dword
    ;input: ax 低16位; dx 高16位; cx 除数
    ;result: ax 低16位; dx 高16位; cx 余数
    ;x/n = int(h/n)*65536 + [rem(h/n)*65536+L]/N
    ;左边a位 右边b位 那么乘的就是2^b
    push bx
    
    push ax;保存低位
    mov ax, dx
    mov dx, 0
    div cx
    ;dx 余数 ax 高位结果
    mov bx, ax;bx 保存高位结果
    pop ax;拿出低位
    div cx
    ;dx 余数 ax低位结果
    mov cx, dx
    mov dx, bx

    pop bx
    ret

    mov ah, 4ch
    int 21h
code ends

end start