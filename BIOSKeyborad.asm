assume cs:code, ds:data, ss:stack

data segment
    db 32 dup(0)
data ends

stack segment
    db 32 dup(0)
stack ends
;-------------BIOS Keyborad----------------------
;BIOS keyborad buffer use Circular queue as its data structure 
;8086 has 16 words, storing 15 units.
;
;
;
;
;readFromDisc and wirteToDisc  please don't be called.
;it's just use for demonstration
;
;
;
;
;
;
;
;
;
;
;
;
;
;
;
;





code segment
    start:
    mov ax, data
    mov ds, ax
    mov ax, stack
    mov ss, ax
    mov sp, 20h

    mov si, 0
    call getstr

    mov ah, 4ch
    int 21h


    ;--------------------sub program-----------------;
    ;-----------------------------
    ;--------alter word color----;
    ;ds:si = char stack
    ;ah = 
    ;0 -> al = push; 
    ;1 -> al = top; 
    ;2 -> dh <- row, dl <- column; show string
    alterWordColor:
    ;wait keyborad buffer
    mov ah, 0
    int 16h
    
    mov ah, 1
    cmp al, 'r'
    je red
    cmp al, 'g'
    je green
    cmp al, 'b'
    je blue
    jmp short sret

    red:shl ah, 1
    green:shl ah, 1
    blue:mov bx, 0b800h
    mov es, bx
    mov bx, 1
    mov cx, 2000
    s:and byte ptr es:[bx], 11111000B
    or es:[bx], ah
    add bx, 2
    loop s

    sret:
    mov dl, al
    mov ah, 2
    int 21h
    ret

    ;-----------------------
    ;----charStack---------;
    charStack:
    jmp short charstart
    stackTable dw charPush, charPop, charShow 
    top dw 0
    charstart:
    push bx
    push dx
    push di
    push es

    cmp ah, 2
    ja charStackRet
    mov bl, ah
    mov bh, 0
    add bx, bx
    jmp word ptr stackTable[bx]

    charPush:
    mov bx, top
    mov [si][bx], al
    inc top
    jmp charStackRet

    charPop:
    cmp top, 0
    je sret
    dec top
    mov bx, top
    mov al, [si][bx]
    jmp charStackRet

    charShow:
    mov bx, 0b800h
    mov es, bx
    mov al, 160
    mov ah, 0
    mul dh
    mov di, ax; row 
    add dl, dl
    mov dh, 0
    add di, dx; column

    mov bx, 0

    charShows:
    cmp bx, top
    jne noempty
    mov byte ptr es:[di], ' '
    jmp charStackRet

    noempty:
    ;show content of stack
    mov al, [si][bx]
    mov es:[di], al
    mov byte ptr es:[di+2], ' '
    inc bx
    add di, 2
    jmp charShows

    charStackRet:
    pop es
    pop di
    pop dx
    pop bx
    ret 
    ;
    ;
    ;-------------------------------------------
    ;---------getstr-----------------------;
    ;ds:si = stack of string 
    getstr:
    push ax

    getstrs:
    mov ah, 0
    int 16h

    cmp al, 20h
    jb nochar

    mov ah, 0
    call charstack

    mov ah, 2
    mov dh, 24;rows
    mov dl, 0;column
    call charstack
    jmp getstrs

    nochar:
    cmp ah, 0eh
    je backspace
    cmp ah, 1ch
    je enter
    jmp getstrs

    backspace:
    mov ah, 1
    call charstack
    mov ah, 2
    call charstack
    jmp getstrs

    enter:
    mov al, 0
    mov ah, 0
    call charstack
    mov ah, 2
    call charstack
    pop ax
    ret 


    ;-------------------------------------------
    ;-------readFromDisc-----------------------;
    readFromDisc:
    ;ah = function code of int 13
    ;al = number of disc to read
    ;ch = track code
    ;cl = Sector code
    ;dh = head number
    ;dl = Drive letter
    ;es:di = buffer of read data
    ;return:
    ;success -> ah = 0, al = number of sector 
    ;fail -> ah = error code
    ;read from 0 side, 0 channel, 1 sector, to 0:200 
    mov ax, 0
    mov es, ax
    mov bx, 200h

    mov al, 1
    mov ch, 0
    mov cl, 1
    mov dl, 0
    mov dh, 0
    mov ah, 2
    int 13h
    ret
    ;write 0:200 to 0 side, 0 channel, 1 sector
    WriteToDisc:
    ;ah = function code of int13 (3 write disc)
    ;al = number of sector written
    ;ch = code of track
    ;cl = code of sector
    ;dh = code of head
    ;dl = drive of code
    ;es:bx = data for writing
    ;return :
    ;success -> ah = 0, al = numbers of sector written
    ;fail -> ah = error code
    mov ax, 0
    mov es, ax
    mov bx, 200h

    mov al, 1
    mov ch, 0
    mov cl, 1
    mov dl, 0
    mov dh, 0

    mov ah, 3
    int 31h
    ret


code ends

end start