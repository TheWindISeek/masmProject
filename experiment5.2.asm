ASSUME cs:code, ds:data, ss:stack

new segment
	dw 1h, 2h, 3h, 4h, 5h, 6h, 7h, 8h
new ends

data SEGMENT
         dw 0123h, 0456h
data ENDS

stack SEGMENT
          dw 0, 0
stack ends

code SEGMENT
;cs = 0772 ss = 076f ds = 0760
    START:mov  ax, stack
          mov  ss, ax
          mov  sp, 16

          mov  ax, data
          mov  ds, ax

          push ds:[0]
          push ds:[2]
          pop  ds:[2]
          pop  ds:[0]
		;cs = 0772 ss = 0771 ds = 0770
          mov  ax, 4c00h
          int  21h
code ENDS
end START

