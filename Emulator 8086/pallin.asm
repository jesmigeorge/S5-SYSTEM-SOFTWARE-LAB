DATA SEGMENT
    MSG1 DB 10,13,"ENTER A STRING : $"
    STRING DB 10,0,10 DUP('$')
    PALLIN_MSG DB 10,13,"ITS PALLINDROME.$"
    NOT_PALLIN_MSG DB 10,13,"ITS NOT PALLINDROME.$"  
    
    PRINT MACRO ARG
        LEA DX,ARG
        MOV AH,09H
        INT 21H
    PRINT ENDM
    
    INPUT MACRO ARG
        LEA DX,ARG               
        MOV AH,0AH
        INT 21H
    INPUT ENDM
DATA ENDS

CODE SEGMENT
    START: 
        MOV AX,DATA
        MOV DS,AX
                 
        PRINT MSG1
        INPUT STRING
        
        MOV DI,OFFSET STRING+2
        MOV SI,DI
        ILOOP:
        MOV AL,[DI] 
        CMP AL,0DH
        JZ LOOPTEST
        INC DI
        JMP ILOOP
        
        LOOPTEST:
        DEC DI
        CMP SI,DI
        JZ PALLINDROME
        MOV AL,[SI]
        MOV BL,[DI]
        CMP AL,BL
        JNZ NOT_PALLINDROME
        INC SI 
        JMP LOOPTEST
        
        PALLINDROME:
        PRINT PALLIN_MSG
        JMP END_PROGRAM
        
        NOT_PALLINDROME:
        PRINT NOT_PALLIN_MSG
        
        END_PROGRAM:
        MOV AH,4CH
        INT 21H
        
    CODE ENDS
END START