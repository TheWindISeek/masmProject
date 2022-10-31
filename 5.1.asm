datas segment
        buffer db 5
               db ?
               db 5 dup('$')

        CRLF   db 13, 10, '$'
datas ends

stacks segment

stacks ends

codes segment
                ASSUME ds:datas, cs:codes, ss:stacks
        START:  
                mov    ax, datas
                mov    ds, ax


                lea    dx, buffer                           ;
                mov    ah, 0ah
                int    21H

                lea    dx, CRLF
                mov    ah, 09h
                int    21H

                lea    di, buffer + 1
                mov    cx, [di]
                mov    ch, 0
        ;mov cx, [dx] ;get the number of buffer
                add    di, 1
        ; put di in the first charter
        ; put the answer in bx
                mov    bx, 0
                mov    dl, 10
        mulLoop:
        	
                mov    ax, bx
                mul    dl
			
                mov    bx, [di]
                mov    bh, 0
                add    di, 1
                sub    bl, '0'
			
                add    bx, ax
        	
                dec    cx
                cmp    cx, 0
                jnz    mulLoop
        	
                mov    ax, bx
                call   output
        	
                mov    ah, 4ch
                int    21h
        
output proc
        ;ѹջ
                push   dx
                push   cx
                push   bx
                mov    bl, 0
                mov    cl, 10
        bbegin: 
                mov    ah, 0                                ; �����Ǹ�ah��ֵΪ0
                div    cl
                push   ax                                   ;ѹջ
                inc    bl

                cmp    al, 0
                jnz    bbegin
	
        aa:     
                pop    dx
                mov    dl, dh
                add    dl, '0'
                mov    ah, 2
                int    21h
                dec    bl
	
                cmp    bx, 0
                jnz    aa
	
	
                pop    bx
                pop    cx
                pop    dx
                ret
output endp
        
        
        
        

codes ends
    end START


