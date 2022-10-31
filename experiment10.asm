assume cs:code

data segment
    db 'Welcome to masm!', 0
data ends

stack segment
    db 16 dup(0)
stack ends

code segment
start:
    mov dh, 8
    mov dl, 3
    mov cl, 2
    mov ax, data
    mov ds, ax
    mov si, 0
    call show_str

    mov ax, 4c00h
    int 21h

show_str:
    ;function: show a string with 0 in place (dh row, dl column) show color(cl)
    ;dh = row; dl = column; cl = color; ds:si = first address of string
    ;return void
    ;b800:0000 : 0 row
    ;00 - 01 : 0 column
    ;0a0h byte
    push es
    push si
    push dx
    push cx
    push bx
    push ax
    ;bias 
    mov bx, 0b800h
    mov es, bx
    mov bx, 0
    
    ;row; bx = dh * a0 + bx
    mov ax, 00a0h
    mul dh
    add bx, ax
    ;column; bx = dl * 2 + bx
    mov ax, 0002h
    mul dh
    add bx, ax
    
    ;set string
    ;restore cx dx
    mov al, cl
    string:
    mov cl, ds:[si];get char
    mov ch, 0
    jcxz end_show_str; if zero jmp end_show_str
    mov ch, al; set font 
    mov es:[bx], cx; set data

    ;move back
    add bx, 2
    inc si
    jmp short string

    ;return 
    end_show_str:
    pop ax
    pop bx
    pop cx
    pop dx
    pop si
    pop es
    ret
code ends
end start
