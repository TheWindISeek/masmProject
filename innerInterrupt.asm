assume cs:code, ds:datas, ss:stacks

datas segment
    db 32 dup(0)
datas ends

stacks segment
    db 32 dup(0)
stacks ends

code segment
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;divide error   0
    ;single step    1
    ;execute into   4
    ;execute int    followed code
    ;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;interrupt vector table (8086)
    ;0000:03ff
    ;List items : 2 words = bias + segment address;0->1
    ;IP:N*4; CS: N*4+2
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;get interrupt code
    ;push FLAGS
    ;set TF <- 0, IF <- 0
    ;push cx
    ;push ip
    ;ip <- n * 4, cs <- n * 4 + 2
    ;give the control to program
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;interrupt program process:
    ;   push register
    ;   handle with interrupt
    ;   pop register
    ;   iret = 
    ;       pop ip
    ;       pop cs
    ;       popf
    ;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;
    ;single step : watch TF, if TF == 1 then execute followed steps
    ;   get interrupt code 1
    ;   pushf
    ;   TF <- 0, IF <- 1 ;exists in 8086
    ;   push cs
    ;   push ip
    ;   ip <- 1 * 4
    ;   cs <- 1 * 4 + 2
    ;   ;;;;;;;;;;;;;;;;
    ;outer interrupt <- IF
    ;
    ;   sti = IF <- 1
    ;   cli = IF <- 0
    ;   if have a maskable interrupt then
    ;       if IF == 1 then
    ;           response(refer to above process)
    ;       else 
    ;           ignore
    ;
    ;Non Maskable Interrupt -> interrupt code === 2
    ;Description using pseudo assembly code
    ;   pushf
    ;   IF = 0, TF = 0
    ;   push cs
    ;   push ip
    ;   ip = 8
    ;   cs = 0AH
    ;
    ;should:
    ;   mov ax, 1000h
    ;   mov ss, ax
    ;   mov sp, 20h
    ;shouldn't:
    ;   mov ax, 1000h
    ;   mov ss, ax
    ;   mov ax, 0
    ;   mov sp, 20h
    ;keep ss:sp point to the top of stack
    start:
    mov ax, datas
    mov ds, ax
    mov ax, stacks
    mov ss, ax
    mov sp, 20h
    ;;;;;;;;;;;;;;;;;
    mov ax, 1000h
    mov bh, 1
    div bh

    ;;;;;;;;;;;;;;;;;
    mov ah, 4ch
    int 21h
code ends

end start