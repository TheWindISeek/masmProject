ASSUME cs:code, ds:data, ss:stack

code SEGMENT
;cs = 0770 ss = 076f ds = 0760
    START:mov  ax, stack
          mov  ss, ax
          mov  sp, 16

          mov  ax, data
          mov  ds, ax

          push ds:[0]
          push ds:[2]
          pop  ds:[2]
          pop  ds:[0]
		;cs = 0770 ss = 0774 ds = 0773
          mov  ax, 4c00h
          int  21h
code ENDS

data SEGMENT
         dw 0123h, 0456h
data ENDS
; segment length = (N bytes / 16 + 1) * 16 ; 8/3=2 for reduce access memory time 
stack SEGMENT
          dw 0, 0
stack ends


end START


