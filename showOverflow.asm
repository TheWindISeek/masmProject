assume cs:code, ss:stacks, ds:datas
    ;code interrupt program 
    ;set up interrupt program
    ;alter 0000:0(ip) 0000:2(cs)
    ;make interrupt
    ;return 
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
    jmp endShowString;skip data
    showString db "overflow!"
    endShowString:nop
    mov ax, 0b800h;the address of Video Random Access Memory
    mov es, ax
    mov di, 12*160+36*2;which place
    ;
    mov ax, cs
    mov ds, ax
	lea si, showString;the first address of string
    add si, 200h;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;can't solve 
    mov cx, offset endShowString - offset showString;length of string
    ;
    movStringLoop:mov al, ds:[si]
    mov es:[di], al
    inc si
    add di, 2
    loop movStringLoop
    ;;;;;;;;;;;;;;;
    mov dl, '9';test whether execute this program or not
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
    ;;;;;;;;;;;;;;;;;

    ;;;;;;;;;;;;;;;;;
    start:
    ;
    ;
    ;
    
    mov ax, 0
    mov es, ax
    mov di, 200h;set source cs:ip = 0000:0200h
    mov si, offset interruptProgram;get program cs:ip
    mov bx, 0
    mov cx, offset start - offset interruptProgram;program size
    mov ax, cs
    call setupInterruptProgram
    ;
    ;Trigger interrupt
    ;
    mov ax, 1000h
    mov bl, 1
    div bl
    ;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    mov ah, 4ch
    int 21h
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    setupInterruptProgram:
    ;function : setup interrupt program
    ;input : cx = size of interrupt program; 
    ;ax:si = cs:ip of interrupt program;
    ;es:di = cs:ip of source 
    ;bx = which interrupt program
    ;output : void
    ;
    pushf
    push ds
    push es
    push si
    push di 
    push dx
    push cx
    push bx
    push ax
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    mov ds, ax
    cld
    rep movsb;-> by byte
    ;alter interrupt vector table
    mov ax, 0
    mov es, ax
    mov di, bx
    shl di, 1
    shl di, 1
    mov  es:[di],word ptr 200h
    mov  es:[di+2],word ptr 0h
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    pop ax
    pop bx
    pop cx
    pop dx
    pop di
    pop si
    pop es
    pop ds
    popf
    ret

code ends

end start