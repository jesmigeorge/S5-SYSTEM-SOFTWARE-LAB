DATA SEGMENT
    MSG1 DB 10,13,"ENTER A STRING : $"
    STRING DB 6,0,6 DUP('$')
    MSG2 DB 10,13,"COUNT OF VOWELS : $"
    EVEN_MSG DB 10,13,"EVEN NO. OF VOWELS!$"
    ODD_MSG DB 10,13,"ODD NO. OF VOWELS!$"
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
    
    XOR BL,BL
    MOV SI,OFFSET STRING+2 
    
    ITERATE:
    MOV AL,[SI]
    CMP AL,0DH
    JZ DISPLAY
    CMP AL,'A'
    JZ INC_CNT
    CMP AL,'E'
    JZ INC_CNT 
    CMP AL,'I'
    JZ INC_CNT
    CMP AL,'O'
    JZ INC_CNT
    CMP AL,'U'
    JZ INC_CNT
    CMP AL,'a'
    JZ INC_CNT
    CMP AL,'e'
    JZ INC_CNT 
    CMP AL,'i'
    JZ INC_CNT
    CMP AL,'o'
    JZ INC_CNT 
    CMP AL,'u'
    JZ INC_CNT 
    
    NXT_ITR:
    INC SI
    JMP ITERATE
    
    INC_CNT:
    INC BL 
    JMP NXT_ITR
    
    DISPLAY:
    PRINT MSG2
    COUNT BL 
    MOV CL,1
    ROR BL,CL
    JC ODD_CNT
    JMP EVEN_CNT
    
    ODD_CNT:
    PRINT ODD_MSG
    JMP END_PRG
    
    EVEN_CNT:
    PRINT EVEN_MSG
    
    END_PRG:
    MOV AH,4CH
    INT 21H
    CODE ENDS
END START
    
    
     
    
    
    