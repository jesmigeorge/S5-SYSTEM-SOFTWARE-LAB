DATA SEGMENT
    MSG1 DB 10,13,"ENTER A STRING : $" 
    STRING DB 6,0,6 DUP('$')  
    MSG2 DB 10,13,"THE REVERSED STRING IS : $"
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
    
    MOV SI,OFFSET STRING+2
    MOV DI,SI
    LOOPTEST:
    CMP [DI],0DH
    JZ REVERSE
    INC DI
    JMP LOOPTEST
    
    REVERSE:
    DEC DI
    CMP DI,SI
    JC PRINT_REVERSE 
    MOV AL,[SI]
    MOV BL,[DI] 
    XCHG AL,BL
    MOV [SI],AL
    MOV [DI],BL
    INC SI 
    JMP REVERSE 
    
    PRINT_REVERSE:  
    PRINT MSG2
    MOV SI,OFFSET STRING+2
    PRINT_LOOP:
    CMP [SI],0DH
    JZ END_PROGRAM
    MOV DL,[SI]
    MOV AH,02H
    INT 21H
    INC SI
    JMP PRINT_LOOP
    
    
    END_PROGRAM:
    MOV AH,4CH
    INT 21H
    CODE ENDS
END START
    
    
    
    
    
    