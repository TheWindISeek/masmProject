ASSUME cs:code 

code SEGMENT
START:
    mov ax, cs
    mov ds, ax
    
    mov ax, 0020h
    mov es, ax
    
    mov bx, 0
    ;mov cx, offset s
    
    s:mov al, ds:[bx]
    mov es:[bx], al
    inc bx
    loop S
    
    mov ah, 4CH
    int 21h
code ENDS
end START
end
