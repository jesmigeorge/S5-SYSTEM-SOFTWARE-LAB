DATA SEGMENT
    MSG1 DB 10,13,"ENTER A STRING : $"
    STRING DB 10,0,10 DUP('$')
    MSG2 DB 10,13,"COUNT OF ALPHABETS : $"
    MSG3 DB 10,13,"COUNT OF NUMBERS : $"
    MSG4 DB 10,13,"COUNT OF SPECIAL CHARACTERS : $"
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
    COUNT MACRO ARG
        LEA DL,ARG
        ADD DL,30H
        MOV AH,02H
        INT 21H
    COUNT ENDM
DATA ENDS
CODE SEGMENT
    START:
    MOV AX,DATA
    MOV DS,AX
    
    PRINT MSG1
    INPUT STRING
    
    MOV SI,OFFSET STRING+2 
    XOR BL,BL
    XOR BH,BH
    XOR CL,CL
    ITERATE:  
    MOV AL,[SI]
    CMP AL,0DH
    JZ DISPLAY
    
    ALPHABETS:
    CMP AL,'A'
    JL NUMBERS
    CMP AL,'Z'
    JLE CNT_ALPHABETS  
    CMP AL,'a'
    JL SPECIALS
    CMP AL,'z'
    JLE CNT_ALPHABETS
    
    
    NUMBERS:
    CMP AL,'0'
    JL SPECIALS
    CMP AL,'9'
    JLE CNT_NUMBERS
    
    SPECIALS:
    INC CL 
    JMP NEXT_ITR
    
    CNT_ALPHABETS:
    INC BL
    JMP NEXT_ITR
    
    CNT_NUMBERS:
    INC BH
    
    NEXT_ITR:
    INC SI
    JMP ITERATE
    
    DISPLAY:
    PRINT MSG2
    COUNT BL
    PRINT MSG3
    COUNT BH
    PRINT MSG4
    COUNT CL
                            
    STOP:
    MOV AH,4CH
    INT 21H
    CODE ENDS
END START
    
    
    
    
    
    
    
    
    
    