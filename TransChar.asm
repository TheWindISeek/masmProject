assume cs:codesg, ds:datasg

datasg segment
    db 'BaSiC'
    db 'iNfOrMaTiOn'
datasg ends

codesg segment
start:mov ax, datasg
    mov ds, ax

    mov bx, 0

    mov cx, 5; 5 charters
    s:mov al, [bx]
    and al, 11011111B;alter bit 
    mov [bx], al
    inc bx
    loop s 

    mov bx, 5

    mov cx, 11; 11 charters
    s0:mov al, [bx]
    or al, 00100000B
    mov [bx], al
    inc bx
    loop s0

    mov ah, 4CH
    int 21h
codesg ends
end start