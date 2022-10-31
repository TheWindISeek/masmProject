assume cs:code, ss:stack, ds:data

data segment
      ;21 �?
            db '1975', '1976', '1977', '1978', '1979', '1980', '1981'
            db '1982', '1983', '1984', '1985', '1986', '1987', '1988'
            db '1989', '1990', '1991', '1992', '1993', '1994', '1995'
    
      ;21年总收�?
            dd 16,      22,         382,        1356,       2390,       8000,       16000
            dd 24486,   50065,      97479,      140417,     197514,     345980,     590827
            dd 803530,  1183000,    1843000,    2759000,    3753000,    4649000,    5937000
    
      ;21个雇员人�?
            dw 3,       7,      9,      13,     28,     38,     130
            dw 220,     476,    778,    1001,   1442,   2258,   2793
            dw 4037,    5635,   8226,   11542,  14430,  15257,  17800
            db 14 dup(0)                                                                         ;补全好看数据
      table db 21 dup('year summ ne ?? ')
      show_buffer db 16 dup('$')
      ;00e0
data ends

stack segment
            db 64 dup(0)
stack ends

code segment
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      start:          
                      mov  ax, data
                      mov  ds, ax

                      mov  ax, stack
                      mov  ss, ax
                      mov  sp, 40h
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                      call matrixTransform
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                        mov cl, 0cah
                        mov si, offset show_buffer
                        mov ds:[si], '19'
                        mov ds:[si+2], '75'
                        mov ds:[si+4], '$'
                        mov dx, si
                        mov ah, 9
                        int 21h
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;already put the data into table : 00e0
                        mov cx, 21
                        mov dh, 30
                        mov bx, offset table
                        rowLoop:
                        push cx
                        ;;;;;;;;;;;;;;;;;

                        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                        ;year 4 byte
                        mov dl, 0h
                        mov di, 0h
                        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                        ;
                        ;ax low; dx high
                        mov si, offset show_buffer
                        mov al, ds:[bx+di]
                        mov ds:[si], al
                        mov al, ds:[bx+di+1]
                        mov ds:[si+1], al
                        mov al, ds:[bx+di+2]
                        mov ds:[si+2], al
                        mov al, ds:[bx+di+3]
                        mov ds:[si+3], al
                        mov ds:[si+4], byte ptr '$'
                        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                        ;use buffer change vision memory
                        push ax
                        push dx
                        
                        lea dx, show_buffer
                        mov ah, 9
                        int 21h

                        pop dx
                        pop ax
                        ;mov cl, 0cah
                        ;call show_str
                        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                        ;income 4 byte
                        mov dl, 6h
                        mov di, 5h
                        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                        ;let the data in ds:[bx+di] into buffer
                        push dx
                        push ax
                        mov ax, ds:[bx+di]
                        mov dx, ds:[bx+di+2]
                        mov si, offset show_buffer
                        mov cx, 10
                        call dwordToString
                        pop ax
                        pop dx
                        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                        ;mov cl, 0cah
                        ;call show_str
                        push ax
                        push dx
                        
                        lea dx, show_buffer
                        mov ah, 9
                        int 21h

                        pop dx
                        pop ax                        
                        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                        ;number 2 byte
                        mov dl, 0fh
                        mov di, 0ah
                        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                        push ax
                        mov ax, ds:[bx+di]
                        mov si, offset show_buffer
                        mov cx, 10
                        call wordToString
                        pop ax
                        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                        ;mov cl, 0cah
                        ;call show_str
                        push ax
                        push dx
                        
                        lea dx, show_buffer
                        mov ah, 9
                        int 21h

                        pop dx
                        pop ax                        
                        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                        ;avg 2 byte
                        mov dl, 016h
                        mov di, 0dh
                        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                        push ax
                        mov ax, ds:[bx+di]
                        mov si, offset show_buffer
                        mov cx, 10
                        call wordToString
                        pop ax
                        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                        ;mov cl, 0cah
                        ;call show_str
                        push ax
                        push dx
                        
                        lea dx, show_buffer
                        mov ah, 9
                        int 21h

                        pop dx
                        pop ax                        
                        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                        add dh, 0a0h; next screen row
                        add bx, 010h; next table row
                        pop cx
                        dec cx
                        cmp cx, 0
                        jnz near ptr rowLoop
                        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                        mov si, offset show_buffer
                        mov ax, 51265
                        call wordToString
                        mov dh, 8
                        mov dl, 3
                        mov cl, 2
                        call   show_str                        
                  
                      mov  ah, 4ch
                      int  21h






    wordToString:        
    ;function:
    ;input: ax = word; ds:si = the first address of string
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
                 mov  ds:[si], byte ptr 0
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
























      dwordToString:           
      ;dword to string end with 0
      ;input : ax = dword's lower 16 bits; dx = dword's high 16 bits; ds:si = first address of string
      ;return : void
            ;;;;;;;;;;;;;;;;;;
            push ax
            push bx
            push cx
            push dx
            push si
            push di
            push es
            push bp
            ;;;;;;;;;;;;;;;;;
            mov bx, 0
            mov cx, 10
            call divdw

            divLoop:
            push cx
            mov cx, 10
            call divdw
            inc bx
            cmp cx, 0
            jnz divLoop;if mod is not zero cycle
            ;
            ;execute data to string
            ;
            mov cx, bx
            dataToStringLoop:
            ;get data 
            pop bx
            add bl, '0'
            mov ds:[si], bl
            inc si
            loop dataToStringLoop
            ;结束符号
            mov ds:[si], byte ptr '$'
            ;;;;;;;;;;;;;;;;;
            pop bp
            pop es
            pop di
            pop si
            pop dx
            pop cx
            pop bx
            pop ax          
            ;;;;;;;;;;;;;;;;;;
            ret



      divdw:          
      ;进行不会产生溢出的除法运�?
      ;被除数为dword 除数为word 结果为dword
      ;input: ax �?6�? dx �?6�? cx 除数
      ;result: ax �?6�? dx �?6�? cx 余数
      ;x/n = int(h/n)*65536 + [rem(h/n)*65536+L]/N
      ;左边a�?右边b�?那么乘的就是2^b
                      push bx
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;   
                      push ax                           ;保存低位
                      mov  ax, dx
                      mov  dx, 0
                      div  cx
      ;dx 余数 ax 高位结果
                      mov  bx, ax                       ;bx 保存高位结果
                      pop  ax                           ;拿出低位
                      div  cx
      ;dx 余数 ax低位结果
                      mov  cx, dx
                      mov  dx, bx
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                      pop  bx
                      ret


      matrixTransform:
      ; bp 指向 table bx固定不变 恒为0
                      push bp
                      push si
                      push es
                      push di
                      push dx
                      push cx
                      push bx
                      push ax
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                      mov  bx, 0
                      mov  bp, offset table
                      mov  ax, ds
                      mov  es, ax
                      mov  cx, 21                       ;21years
                      mov  si, 0
                      mov  di, 0
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      row:            
                      push cx
      ;year
      ;将年份放到指定位�?
                      push dx
                      mov  bx, 0                        ; find the begin of years
                      mov  dx, [bx+si]
                      mov  es:[bp], dx
                      mov  dx, [bx+si+2]
                      mov  es:2h[bp], dx
                      pop  dx

      ;income nums avg_income
      ; 将收�?四字节放入指定位�?每次移动两个字节 取出人数 两个字节 进行32/16 将结果放入avg_income
      ;si = 4*n; bx = 0; bp = 16*n;
      ;income = 5-8; ne = a-b; avg = d-e;
      ;bx = 30h dword income
      ;bx = 90h word nums
                      push ax
                      push dx
                      push cx
      ;;;;;;;;;;;;;;;;;;;;;;;;
                      mov  bx, 54h                      ; find the begin of income
                      mov  ax, word ptr [bx][si]        ;
                      mov  dx, word ptr [bx][si+2]      ;
                      mov  es:5h[bp], ax
                      mov  es:7h[bp], dx

                      mov  bx, 0a8h                     ; find the begin of nums
                      mov  cx, word ptr [bx][di]
                      mov  es:0ah[bp], cx
    
                      div  cx
                      mov  es:0dh[bp], ax               ; mov the avg_income to the right place
      ;;;;;;;;;;;;;;;;;;;;;
                      pop  cx
                      pop  dx
                      pop  ax
      ;;;;;;;;;;;;;;;;;;;;;
      ;si 指向下一年份 bp移动到下一�?
                      add  si, 4
                      add  di, 2
                      add  bp, 10h
                      pop  cx
                      loop row

      ;;;;;;;
                      pop  ax
                      pop  bx
                      pop  cx
                      pop  dx
                      pop  di
                      pop  es
                      pop  si
                      pop  bp
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


code ends

end start 




