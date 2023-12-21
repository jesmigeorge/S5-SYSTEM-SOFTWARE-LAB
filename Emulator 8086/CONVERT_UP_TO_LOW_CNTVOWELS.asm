DATA SEGMENT
    MSG1 DB 10,13,"ENTER A STRING : $" 
    STRING DB 6,0,6 DUP('$')
    MSG2 DB 10,13,"RESULTING STRING : $"
    MSG3 DB 10,13,"COUNT OF VOWELS : $"    
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
    XOR CL,CL
     
    ITERATE:
    MOV AL,[SI]
    CMP AL,0DH
    JZ DISPLAY
    
    CMP AL,'A'
    JZ CNT_VOWEL 
    CMP AL,'E'
    JZ CNT_VOWEL
    CMP AL,'I'
    JZ CNT_VOWEL
    CMP AL,'O'
    JZ CNT_VOWEL
    CMP AL,'U'
    JZ CNT_VOWEL  
    CMP AL,'a'
    JZ CNT_VOWEL 
    CMP AL,'e'
    JZ CNT_VOWEL
    CMP AL,'i'
    JZ CNT_VOWEL
    CMP AL,'o'
    JZ CNT_VOWEL
    CMP AL,'u'
    JZ CNT_VOWEL 
    JMP UPPERCHECK
    
    CNT_VOWEL:
    INC CL
    
    UPPERCHECK:
    CMP AL,65
    JL NXT_ITR
    CMP AL,90
    JLE CONVERT
    
    NXT_ITR:
    INC SI
    JMP ITERATE
    
    CONVERT:
    ADD AL,32 
    MOV [SI],AL
    JMP NXT_ITR
    
    DISPLAY:
    PRINT MSG2
    PRINT STRING+2 
    PRINT MSG3
    COUNT CL
    
    END_PRG:
    MOV AH,4CH
    INT 21H
    CODE ENDS
END START
    
    