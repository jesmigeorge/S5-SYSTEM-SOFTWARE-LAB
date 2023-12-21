DATA SEGMENT
    MSG1 DB "ENTER A STRING : $"
    BUFFER1 DB 80,?,80 DUP('$')
DATA ENDS

CODE SEGMENT
    START:
        MOV AX, DATA
        MOV DS, AX
        
        LEA DX, MSG1
        MOV AH, 09H
        INT 21H
        
        MOV AH, 0AH
        LEA DX, BUFFER1
        INT 21H
        
        LEA SI, BUFFER1+2
        
    CONVERT_LOWERCASE:
        MOV AL, [SI]
        CMP AL, 00H
        JE END_PROG
        
        CMP AL, 'A'
        JB NOT_UPPERCASE
        
        CMP AL, 'Z'
        JA NOT_UPPERCASE 
        
        ADD AL, 20H
        MOV [SI], AL 
     
     NOT_UPPERCASE:
        INC SI
        JMP CONVERT_LOWERCASE
     
     END_PROG:
        LEA DX, BUFFER1+2
        MOV AH, 09H
        INT 21H
        MOV AH, 4CH
        INT 21H

CODE ENDS
END START
           
     
        
        
        
        
        
    