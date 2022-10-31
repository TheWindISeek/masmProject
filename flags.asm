assume cs:code, ds:data, ss:stack

data segment
    db 32 dup(0)
    first db 1, 2, 3, 4, 5, 6, 7, 8
    second db 6, 7, 8, 9, 0AH, 0BH, 0CH, 0DH
    lowString db "Beginner's All-purpose Symbolic Instruction Code.", 0
data ends

stack segment
    db 32 dup(0)
stack ends

code segment
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    start:
    mov ax, data
    mov ds, ax
    mov ax, stack
    mov ss, ax
    mov sp, 20h
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;F      E       D       C       B       A       9       8
    ;                               OF      DF      IF      TF
    ;7      6       5       4       3       2       1       0
    ;SF     ZF              AF              PF              CF
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;FLAGS      1               0
    ;OF         OV              NV
    ;SF         NG              PL
    ;ZF         ZR              NZ
    ;PF         PE              PO
    ;CF         CY              NC
    ;DF         DN              UP
    ;
    ;
    ;;;;;;;;;;;;;;;;;;;;;;
    ;zero flag
    ;mov ax, 1
    ;sub ax, 1
    ;zf = 1
    ;
    ;mov ax, 2
    ;sub ax, 1
    ;zf = 0
    ;;;;;;;;;;;;;;;;;;;;;;;
    ;parity flag
    ;mov al, 1
    ;add al, 10
    ;pf = 0; 3 * 1
    ; 
    ;mov al, 1
    ;or al, 2
    ;pf = 1; 2 * 1
    ;;;;;;;;;;;;;;;;;;;;;;
    ;sign flag
    ;mov al, 1000_0001b
    ;add al, 1
    ;sf = 1
    ;
    ;mov al, 1000_0001b
    ;add al, 0111_1111b
    ;sf = 0
    ;;;;;;;;;;;;;;;;;;;;;;
    ;carry flag unsigned number
    ;mov al, 98h
    ;add al, al
    ;(al) = 30h, cf = 1
    ;add al, al
    ;(al) = 60h, cf = 0
    ;
    ;mov al, 97h
    ;sub al, 98h
    ;(al) = 0ffh, cf = 1
    ;sub al, al
    ;(al) = 0, cf = 0, cf record the borrow
    ;
    ;;;;;;;;;;;;;;;;;;;;;
    ;overflow flag signed number
    ;mov al, 98
    ;add al, 99
    ;al = al + 99 = 98 + 99 = 197
    ;OF = 1
    ;
    ;mov al, 0F0h 
    ;f0h = -16
    ;add al, 088h
    ;88h = -120
    ;OF = 1
    ;
    ;mov al, 0F0h
    ;add al, 88h
    ;OF = 1, CF = 1
    ;add include signed and unsigned ops
    ;
    ;mov al, 0F0h
    ;add al, 78H
    ;CF = 1, OF = 0
    ;for unsigned number CF = 1
    ;for signed number OF = 0; 0F0h = -16, 78h = 120, 120+(-16) = 104
    ;
    ;
    ;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;adc ax, bx = 
    ;ax = ax + bx + cf
    ;
    ;use for extended add
    ;
    ;
    ;mov ax, 2
    ;mov bx, 1
    ;sub bx, ax
    ;adc ax, 1
    ;= 
    ;ax = ax + 1 + cf = 2 + 1 + 1 = 4
    ;
    ;mov ax, 1
    ;add ax, ax
    ;adc ax, 3
    ;=
    ;ax = ax + 3 + cf = 2 + 3 + 0 = 5
    ;
    ;calculate 1EF000H + 201000H 
    ;mov ax, 001EH
    ;mov bx, 0F000H
    ;add bx, 1000H
    ;adc ax, 0020H
    ;
    ;high 16 bit -> ax; low 16 bit -> bx;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;sbb 
    ;sbb ax, bx = 
    ;ax = ax - bx - CF
    ;
    ;mov bx, 1000H
    ;mov ax, 003EH
    ;sub bx, 2000H
    ;sbb ax, 0020H
    ;;;;;;;;;;;;;;;use like adc, skip
    ;cmp ax, bx = 
    ;sub ax, bx that doesn't keep result
    ;
    ;mov ax, 8
    ;mov bx, 3
    ;cmp ax, bx; zf = 0, pf = 1, sf = 0, cf = 0, OF = 0, ax = 8
    ;
    ;for unsigned operations
    ;zf = 1, ax == bx
    ;zf = 0, ax != bx
    ;cf = 0, ax < bx
    ;cf = 0, ax >= bx
    ;cf = 0, zf = 0, ax > bx
    ;cf = 1 or zf = 1, ax <= bx
    ;
    ;for signed operations
    ;zf = 1, ax == bx
    ;zf = 0, ax != bx
    ;sf = 1, of = 0, ax < bx
    ;sf = 1, of = 1, ax > bx
    ;sf = 0, of = 0, ax >= bx
    ;sf = 0, of = 1, ax < bx
    ;
    ;je jump if equal
    ;jne jump if not equal
    ;jb jump if below
    ;jnb jump not below
    ;ja jump above
    ;jna jump not above
    ;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;DF 
    ;df = 0, si, di ++ (not just 1)
    ;df = 1, si, di -- (not just 1)
    ;
    ;movsb = 
    ;mov es:[di], byte ptr ds:[si]
    ;if df = 0, then 
    ;   inc si
    ;   inc di
    ;else 
    ;   dec si
    ;   dec si
    ;
    ;movsw = 
    ;mov es:[di], word ptr ds:[si]
    ;if df = 0 then 
    ;   add si, 2
    ;   add di, 2
    ;else 
    ;   sub si, 2
    ;   sub di, 2
    ;
    ;rep : repeat
    ;rep movsb = 
    ;s:movsb
    ;loop s
    ;
    ;rep movsw = 
    ;s:movsw
    ;loop s
    ;
    ;cld = set df <- 0
    ;std = set df <- 1
    ;
    ;
    ;
    ;
    ;
    ;
    ;
    ;;;;;;;;;;;;;;;;;;;;;;;;;; example 
    ;data segment
    ;   db 'Welcome to masm!'
    ;   db 16 dup(0)
    ;data ends
    ;
    ;mov ax, data
    ;mov ds, ax
    ;mov si, 0
    ;mov es, ax
    ;mov di, 16
    ;mov cx, 16
    ;cld        ;set df = 0, ->
    ;rep movsb
    ;
    ;
    ;data segment 
    ;   db 16 dup(0)
    ;data ends 
    ;
    ;mov ax, 0F000H
    ;mov ds, ax
    ;mov si, 0FFFFH
    ;mov ax, data
    ;mov es, ax
    ;mov di, 15
    ;mov cx, 16
    ;std        ;set df = 1, <-
    ;rep movsb
    ;
    ;
    ;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;;;;;;;;;;;;;;;;;
    mov ax, 0 
    push ax
    popf 
    mov ax, 0fff0h
    add ax, 0010h
    pushf
    pop ax
    and al, 11000101B
    and ah, 00001000B
    ;;;;;;;;;;;;;;;;;;;;
    ;1E_F000_1000h + 20_1000_1EF0H
    ;ax-bx-cx
    mov ax, 01EH
    mov bx, 0F000H
    mov cx, 1000h
    add cx, 1EF0H
    adc bx, 1000H
    adc ax, 20h
    ;like three input adder
    mov si, offset first
    mov di, offset second
    call add128

    mov si, offset lowString
    call letterc
    mov ah, 4ch
    int 21h



    letterc:
    ;lowercase letters to uppercase letters
    ;input:  ds:[si] = the first address of string end with 0
    ;ouput: void
    push cx
    push si
    ;;;;;;;;;;;;;;;;
    dec si
    charUpperLoop:
    inc si
    mov cl, ds:[si]
    cmp cl, 0
    jz endLetterc
    cmp cl, 'a'
    jb charUpperLoop
    cmp cl, 'z'
    ja charUpperLoop
    sub cl, 20h
    mov ds:[si], cl
    jmp charUpperLoop
    ;;;;;;;;;;;;;;;;
    endLetterc:
    pop si
    pop cx
    ret


















    add128:
    ;128bit + 128
    ;input di, si. like add es:[di], ds:[si]
    ;output void
    push ax
    push cx
    push si
    push di

    sub ax, ax

    mov cx, 8
    s:mov ax, [si]
    adc ax, [di]
    mov [si], ax
    inc si
    inc si
    inc di
    inc di
   ;can't use followed code, because add will affect CF bit.
    ;add si, 2
    ;add di, 2
    loop s

    pop di
    pop si
    pop cx
    pop ax
    ret
code ends
end start