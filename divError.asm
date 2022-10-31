code segment
         assume cs:code
         mov ax, 2569
         mov cx, 10
         call divdb

        mov ah, 4ch
        int 21h

            divdb:;16/8 not overflow
            ;
                 push dx
    
                 push ax                        

                 mov  al, ah
                 mov  ah, 0
                 div  cl
    
                 mov  dx, ax                    
                 pop  ax                        
                 mov  ah, dh                    
                 div  cl

                 mov  cl, ah
                 mov  ah, dl
    
                 pop  dx
                 ret
code ends
end