DATAS SEGMENT
    CRLF  db 13, 10, '$'
    AREA  db 4 dup(0)
DATAS ENDS

STACKS SEGMENT
    
STACKS ENDS

CODES SEGMENT
            ASSUME CS:CODES,DS:DATAS,SS:STACKS
    START:  
            MOV    AX,DATAS
            MOV    DS,AX
   	
            mov    ax, 2345
            lea    bx, CS:AREA
            mov    si, 1
            mov    dl, 10
            
            div    dl
            mov    [bx], ah
    divLoop:
            mov    ah, 0
            div    dl

            mov    [bx+si], ah
            inc    si
            
            cmp    al, 0
            jnz    divLoop
			dec si
    output: 
            mov    dl, [bx+si]
     		dec si
            add    dl, '0'
            
            mov    ah, 2
            int    21h
            
            cmp    si ,-1
            jnz    output
            
            MOV    AH,4CH
            INT    21H
CODES ENDS
    END START

