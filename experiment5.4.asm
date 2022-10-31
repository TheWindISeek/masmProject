assume cs:code

a segment 
    db 1, 2, 3, 4, 5, 6, 7, 8
    a ends

b segment 
    db 1, 2, 3, 4, 5, 6, 7, 8
    b ends

c segment
    db 0, 0, 0, 0, 0, 0, 0, 0
c ends

    code segment
    START:
        mov cx, 8
        mov bx, 0


        S:
        mov ax, a
        mov ds, ax

        mov dl, ds:[bx]

        mov ax, b
        mov ds, ax
        add dl, ds:[bx]

        mov ax, c
        mov ds, ax
        mov ds:[bx], dl
        inc bx
        loop S

        mov ah, 4ch
        int 21h

    code ends

    end START


