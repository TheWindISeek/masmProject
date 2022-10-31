assume cs:codesg, ss:stacksg, ds:datasg

stacksg segment
    dw 0, 0, 0, 0, 0, 0, 0, 0
stacksg ends

datasg segment
    db '1. display      '
    db '2. brows        '
    db '3. replace      '
    db '4. modify       '
datasg ends

codesg segment
    start:
        mov ax, datasg
        mov ds, ax

        ;00-30 3-6 
        mov cx, 4
        mov bx, 0
        line:
        push cx
        ;
        ;set si and cx 
        mov si, 3
        mov cx, 4
        range:
        mov al, [bx+si]
        and al, 11011111B
        mov [bx+si], al
        inc si
        loop range
        ;
        ;
        ;next line
        add bx, 10h
        pop cx
        loop line

        mov ah, 4CH
        int 21h
codesg ends

end start
