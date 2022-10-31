assume cs:code, ss:stacks, ds:datas

datas segment
    db 32 dup(0)
datas ends

stacks segment
    db 32 dup(0)
stacks ends

code segment
    interruptProgram:
    push ax
    push cx
    push es
    push di
    push si
    ;;;;;;;;;;;;;;;;;;
    jmp endShowString
    showString db "overflow!"
    endShowString:nop
    mov ax, 0b800h
    mov es, ax
    mov di, 12*160+36*2
	lea si, showString
    mov cx, offset endShowString - offset showString
    movStringLoop:mov al, [si]
    mov es:[di], al
    inc si
    add di, 2
    loop movStringLoop
    mov dl, '9'
    mov ah, 2
    int 21h
    ;;;;;;;;;;;;;;;;;;
    pop si
    pop di
    pop es
    pop cx
    pop ax
    mov ah, 4ch
    int 21h
    iret 
    start:
    ;code interrupt program 
    ;set up interrupt program
    ;alter 0000:0(ip) 0000:2(cs)
    ;make interrupt
    ;return 
    setupInterruptProgram:
    ;choose ip and cs
    mov ax, cs
    mov ds, ax
    mov si, offset interruptProgram
    ;get program cs:ip
    mov ax, 0
    mov es, ax
    mov di, 200h
    ;set source cs:ip = 0000:0200h
    mov cx, offset start - offset interruptProgram
    ;program size
    cld
    rep movsb;-> by byte
    ;alter interrupt table
    mov ax, 0
    mov es, ax
    mov di, 0
    mov es:[di], word ptr 200h
    mov es:[di+2], word ptr 0h
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    mov ax, 1000h
    mov bl, 1
    div bl
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    mov ah, 4ch
    int 21h
code ends

end start
