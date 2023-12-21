DATA SEGMENT
    MSG1 DB 10,13,"ENTER A STRING : $"
    STRING DB 6,0,6 DUP('$')
    MSG2 DB 10,13,"ENTER CHARACTER TO BE REPLACED : $" 
    MSG3 DB 10,13,"ENTER NEW CHARACTER  : $" 
    MSG4 DB 10,13,"MODIFIED STRING : $" 
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
                    
    XOR BL,BL
    XOR BH,BH
    PRINT MSG2 
    MOV AH,01H
    INT 21H
    MOV BL,AL
    
    PRINT MSG3 
    MOV AH,01H
    INT 21H 
    MOV BH,AL  
    
    MOV SI,OFFSET STRING+2
    ITERATE:
    MOV AL,[SI]
    CMP AL,0DH
    JZ DISPLAY
    
    CMP AL,BL
    JZ REPLACE
    JMP NXT_ITR
    
    REPLACE:
    MOV [SI],BH
    
    NXT_ITR:
    INC SI
    JMP ITERATE
    
    DISPLAY:
    PRINT MSG4
    PRINT STRING+2
    
    END_PRGM:
    MOV AH,4CH
    INT 21H
    
    CODE ENDS
END START
    
        