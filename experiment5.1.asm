ASSUME cs:code, ds:data, ss:stack

data SEGMENT
         dw 0123h, 0456h, 0789h, 0abch, 0defh, 0fedh, 0cbah, 0987h
data ENDS

stack SEGMENT
          dw 0, 0, 0, 0, 0, 0, 0, 0
stack ends

code SEGMENT
;cs = 0772 ss = 0771 ds = 0770
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
