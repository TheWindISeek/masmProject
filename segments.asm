assume cs:code

code segment
    start:
        ;set ds and es
          mov  ax, 0ffffh
          mov  ds, ax
    
          mov  ax, 0020h
          mov  es, ax
        ;set bias and cycles
          mov  bx, 0
          mov  cx, 12
        ;calc answer
    s:    mov  dl, ds:[bx]
          mov  es:[bx], dl
          inc  bx
          loop s
        ;return os
          mov  ax, 4c00h
          int  21h
code ends
end start
end