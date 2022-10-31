assume cs:code, ds:data, ss:stack
;assume Used to assist the compiler to determine which label is located, otherwise it cannot be recognized
;please remeber it is just a hypothesis.
;you should make ds/ss connect with the correct segment
;
;mov ax, data
;mov ds, ax
;
;then use the label to touch data
data segment
    a    db 1, 2, 3, 4, 5, 6, 7, 8
    b    dw 0
    cz   dd a, b
data ends

stack segment

stack ends

code segment
    start:    
    ; a dw 1, 2, 3, 4, 5, 6, 7, 8
    ; b dd 0
    ; start:
    ; mov si, 0
    ; mov cx, 8

    ; s:mov ax, a[si]
    ; add word ptr b, ax
    ; adc word ptr b[2], 0
    ; add si, 2
    ; loop s
    ;------------
              mov  ax, data
              mov  ds, ax

    ;           mov  si, 0
    ;           mov  cx, 8
    ; s:        mov  al, a[si]
    ;           mov  ah, 0
    ;           add  b, ax
    ;           inc  si
    ;           loop s
    ;           mov  ax, seg a
    ;           mov  ax, 30
    ;           call showin
    ;           mov  ax, 40
    ;           call showin
    ;           mov  ah, 0
    ;           call setscreen
    ;           mov  ah, 1
    ;           call setscreen
    ;           mov  ah, 2
              ;call setscreen
              mov  ax, 0201h
              call setscreen
              mov ax, 0102h
              call setscreen
    ;------------
              mov  ax, 4c00h
              int  21h
    ;--------------------
    ;-----showin--------;
    showin:   jmp  short show
    table     dw   ag0, ag30, ag60, ag90, ag120, ag150, ag180
    ag0       db   '0', 0
    ag30      db   '0.5', 0
    ag60      db   '0.866', 0
    ag90      db   '1', 0
    ag120     db   '0.866', 0
    ag150     db   '0.5', 0
    ag180     db   '0', 0
    show:     
              push bx
              push ss
              push si
              mov  bx, 0b800h
              mov  es, bx

              mov  ah, 0
              mov  bl, 30
              div  bl
    ;
              cmp  ah, 0
              jnz  showret
    ;
              mov  bl, al
              mov  bh, 0
              add  bx, bx
              mov  bx, table[bx]

              mov  si, 160*12+40*2
    shows:    
              mov  ah, cs:[bx]
              cmp  ah, 0
              jz   showret
              mov  es:[si], ah
              inc  bx
              add  si, 2
              jmp  short shows
    showret:  pop  si
              pop  es
              pop  bx
              ret
    ;-----------------
    ;----setscreen----;
    setscreen:jmp  short set
    screenTable     dw   sub1, sub2, sub3, sub4
    set:      push bx

              cmp  ah, 3
              ja   sret
              mov  bl, ah
              mov  bh, 0
              add  bx, bx

              call word ptr screenTable[bx]

    sret:     pop  bx
              ret


    ;-------------------
    ;-----sub1---------;
    ;cls
    sub1:     push bx
              push cx
              push es

              mov  bx, 0b800h
              mov  es, bx
              mov  bx, 0
              mov  cx, 2000
    sub1s:    
              mov  byte ptr es:[bx], ' '
              add  bx, 2
              loop sub1s

              pop  es
              pop  cx
              pop  bx
              ret
    ;---------------------
    ;-------sub2---------;
    ;set foreground color
    sub2:     
              push bx
              push cx
              push es

              mov  bx, 0b800h
              mov  es, bx
              mov  bx, 1
              mov  cx, 2000
              
              and al, 00000111B
    sub2s:    
              and  byte ptr es:[bx], 11111000B;clean foreground
              or   es:[bx], al;set foreground
              add  bx, 2
              loop sub2s

              pop  es
              pop  cx
              pop  bx
              ret
    ;-------------------------
    ;----------sub3-----------
    ;set background color
    sub3:     
              push bx
              push cx
              push es
    
              mov  cl, 4
              shl  al, cl
              and al, 01110000B
              mov  bx, 0b800h
              mov  es, bx
              mov  bx, 1
              mov  cx, 2000
    sub3s:    
              and  byte ptr es:[bx], 10001111B;clean background 
              or   es:[bx], al;set background
              add  bx, 2
              loop sub3s
    
              pop  es
              pop  cx
              pop  bx
              ret
    ;-----------------------
    ;----------sub4--------
    ;copy n+1-th row to n-th row
    sub4:     
              push cx
              push bx
              push si
              push di
              push es
              push ds
            
              mov  si, 0b800h
              mov  es, si
              mov  ds, si
              mov  si, 160
              mov  di, 0
              cld

              mov  cx, 24
    sub4s:    
              push cx
              mov  cx, 160
              rep  movsb;copy one line
              pop  cx
              loop sub4s


            ;clean the last line
              mov  cx, 80
              mov  si, 0
             
    sub4s1:   
              mov  byte ptr [160*24+si], ' '
              add  si, 2
              loop sub4s1

              pop  ds
              pop  es
              pop  di
              pop  si
              pop  bx
              pop  cx
              ret
    ;--------------------------------





code ends

end start 

