assume cs:code, ds:data

data segment
    masm db 'alter memory block b800:848 to welcome to masm!'
    say db 'i also want to say'
    programmer db 'talk is cheap show me the code'
    world db 'the world is yours'
    final db '$'
data ends

code segment 
start:
    ;alter memory block b800:848 to welcome to masm!
    ;i also want to say talk is cheap show me the code
    ;tomorrow is another day
    ;the world is yours
    ;
    mov ax, data
    mov ds, ax

    mov ax, 0b800h
    mov es, ax
    mov bp, 012h
    ;first string 
    mov cx, offset say - offset masm
    mov bx, offset masm
    mov dx, 0cah;
    call output
	
	add bp, 0a0h
	mov cx, offset programmer - offset say
	mov bx, offset say
	mov dl, 04h
	call output
	
	add bp, 0a0h
	mov cx, offset world - offset programmer
	lea bx, programmer
	mov dl, 24h
	call output
	
	add bp, 140h
	mov cx, offset final - offset world
	lea bx, programmer
	mov dl, 01h
	call output
	
    mov ax, 4c00h
    int 21h

    output proc
    ;cx = numbers of charters;
    ;bx = the first address of string;
    ;dx = font of charters;
    ;put in the ss:bp;
    push si
    push di
    push ax
    push bx
    push cx
    push dx
    
    mov si, 0
    mov di, 0
    outputString:
    ;first byte
    mov al, [bx+di];
    mov es:[bp+si], al;
    ;second byte used to set font
    mov es:[bp+si+1], dl;
    add si, 2
    inc di
    loop outputString
    
    pop dx
    pop cx
    pop bx
    pop ax
    pop di
    pop si
    ret
    output endp
code ends
end start




