assume cs:code, ss:stack, ds:data
data segment
    ;numbers dw 123, 12666, 1, 8, 3, 38
    show_buffer db 10 dup(0)
                db 0
    new         db '?????????',0
data ends

stack segment
          db 16 dup(0)
stack ends

code segment
    start:       
                 mov  ax, 12666
                 mov  bx, data
                 mov  ds, bx
                 mov  bx, stack
                 mov  ss, bx
                 mov  sp, 10h
	
                 mov  si, offset show_buffer
                 call dtoc
    
                 mov  si, offset show_buffer
                 mov  dh, 8
                 mov  dl, 3
                 mov  cl, 2
                 call show_str

                 mov  ah, 4ch
                 int  21h


    dtoc:        
    ;function:
    ;input: ax = word; ds:si =
    ;return: void
                 push dx
                 push cx
                 push bx
                 push ax
                 push si
    ;
                 mov  dx, 0
    ;ah = rem, al = ans
    divStr:      
                 mov  cl, 10
                 call divdb
                 push cx
                 inc  dx
                 cmp  ax, 0
                 jnz  divStr
                 mov  cx, dx
    writeStr:    
                 pop  dx

                 add  dl, 30h
                 mov  ds:[si], dl
                 inc  si
                 loop writeStr

                 mov  ds:[si], '$'
    ;
                 pop  si
                 pop  ax
                 pop  bx
                 pop  cx
                 pop  dx
    ;jmp  next
                 ret


    divdb:;16/8 not overflow
    ;function: word byte word
    ;input: ah = word ; al = word; cl =
    ;output: ah = ans ; al = ans ; cl =
                 push dx
    ;
                 push ax                        ;
    ;
                 mov  al, ah
                 mov  ah, 0
                 div  cl
    ;ah =  al =
                 mov  dx, ax                    ;
                 pop  ax                        ;
                 mov  ah, dh                    ;
                 div  cl
    ;ah = al =
                 mov  cl, ah
                 mov  ah, dl
    ;
                 pop  dx
                 ret


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
                 mov  bx, 0b800h
                 mov  es, bx
                 mov  bx, 0
    
    ;row; bx = dh * a0 + bx
                 mov  ax, 00a0h
                 mul  dh
                 add  bx, ax
    ;column; bx = dl * 2 + bx
                 mov  ax, 0002h
                 mul  dh
                 add  bx, ax
    
    ;set string
    ;restore cx dx
                 mov  al, cl
    stringLoop:  
                 mov  cl, ds:[si]               ;get char
                 mov  ch, 0
                 jcxz end_show_str              ; if zero jmp end_show_str
                 mov  ch, al                    ; set font
                 mov  es:[bx], cx               ; set data

    ;move back
                 add  bx, 2
                 inc  si
                 jmp  short stringLoop

    ;return
    end_show_str:
                 pop  ax
                 pop  bx
                 pop  cx
                 pop  dx
                 pop  si
                 pop  es
                 ret

                 mov  ah, 4ch
                 int  21h
code ends

end start
