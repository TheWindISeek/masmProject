assume cs:code

data segment
    db 'Welcome to masm!','$'
data ends

code segment
start:
    mov ah, 2
    mov bh, 0
    mov dh, 5
    mov dl, 12
    int 10h

    ; mov ah, 9
    ; mov al, 'a'
    ; mov bl, 11001010B
    ; mov bh, 0
    ; mov cx, 3
    ; int 10h
    mov ax, data
    mov ds, ax
    mov dx, 0
    mov ah, 9
    int 21h

    mov ah, 4ch
    int 21h
code ends
end start