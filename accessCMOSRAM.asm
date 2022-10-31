assume cs:code

data segment
    bias db 0, 2, 4, 7, 8, 9
    ;0 -> second
    ;2 -> minute
    ;4 -> hour
    ;7 -> day
    ;8 -> month
    ;9 -> year
    ;
    time dw 0, ':', 0, ':', 0, ' ', 0, '/', 0, '/', 0
data ends


code segment
    start:
    mov ax, data
    mov ds, ax
    ;;;;;;;;;;;;;;;;;;;;
    mov cx, 6
    mov si, offset bias
    mov di, offset time
    getTime:
    push cx
    ;------------
    ;get BCD code
    mov al, [si];read the data from the port
    out 70h, al; 70 for select port
    in al, 71h; read from 71 port
    ;
    ;al/ax store the data to write/read 
    mov ah, al;one byte = 0010 0110 = 2 6 
    mov cl, 4;spit to two byte; 2 to ah, 6 to al
    shr ah, cl;
    and al, 00001111B;clean the high 4 bits

    ;to ascii
    add ah, 30h
    add al, 30h
    ;put the data into data segment
    mov [di], ax
    ;-----------
    inc si; select next data
    add di, 4;skip 4 bytes
    pop cx
    loop getTime

    mov bx, 0b800h;set es:bp -> video memory address
    mov es, bx
    mov bp, 160*12+40*2
    mov cx, 22;how many number to show
    sub di, 3;get the last address of data segment
    formatTimeLoop:
    mov al, byte ptr ds:[di];get time
 
    mov byte ptr es:[bp], al;to video memory 

    add bp, 2; ingnore attribute
    sub di, 1; dec di
    loop formatTimeLoop

    mov ax, 4c00h;ret
    int 21h
code ends
end start