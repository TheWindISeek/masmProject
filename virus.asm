assume cs:code

code segment
start:
    mov ax, cs
    mov es, ax
    mov ds, ax

    mov di, cx
    mov si, 0
    ;cs:ip
    ;ds:si -> es:di
    mov bx, cx
    cld
    rep movsb
    sub bx, 4
    mov si, bx
    add bx, 4
    mov ds:[si], bx
    mov ds:[si+2], ax
    jmp dword ptr ds:[si]
    db 0
    db 0
    db 0
    db 0
code ends

end start