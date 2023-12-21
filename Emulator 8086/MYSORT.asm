DATA SEGMENT
    MSG1 DB 0AH,0DH,"ENTER LENGTH : $"
    LEN DB ?
    MSG2 DB 0AH,0DH,"ENTER NUMBERS : $" 
    NEWLINE DB 0AH,0DH,"$"
    MSG3 DB 0AH,0DH,"AFTER SORTING : $" 
    ARR DW ?        
    PRINT MACRO ARG
        LEA DX,ARG
        MOV AH,09H
        INT 21H
    PRINT ENDM
DATA ENDS
CODE SEGMENT
    START:
    MOV AX, DATA
    MOV DS, AX     
    PRINT MSG1
    CALL SCAN 
    MOV LEN, AL
    PRINT NEWLINE
    PRINT MSG2
    MOV CH, LEN
    MOV CL, 04H
    LEA SI, ARR
    
    READ:
    CALL SCAN
    MOV BH, AL 
    SHL BH, CL
    CALL SCAN
    ADD BH, AL
    CALL SCAN
    MOV BL, AL 
    SHL BL, CL
    CALL SCAN
    ADD BL, AL
    MOV [SI], BX
    ADD SI,02H
    CALL SCAN  ; READS THE SPACE
    DEC CH
    JNZ READ
    MOV CH,LEN
    
    OUTER_LOOP:
    LEA SI,ARR
    MOV CL,CH
    DEC CL
    JZ END_INPUT
    
    INNER_LOOP:
    MOV AX,[SI]
    MOV BX,[SI+2]
    CMP AX,BX
    JLE SKIP_SWAP 
    MOV [SI],BX
    MOV [SI+2],AX 
    
    SKIP_SWAP: 
    ADD SI,02H
    DEC CL
    JNZ INNER_LOOP
    DEC CH
    JNZ OUTER_LOOP 
    
    END_INPUT:           
        MOV CH,LEN
        LEA SI,ARR
        PRINT MSG3
        PRINT NEWLINE 
    
    DISPLAY:
        
        MOV AL,[SI+1]
        AND AL,0F0H
        SHR AL,04H
        ADD AL,30H
        CMP AL,39H
        JLE SKIP_DISPLAY
        ADD AL,07H
    SKIP_DISPLAY:
        MOV DL,AL
        MOV AH,02H
        INT 21H
        MOV AL,[SI+1]
        AND AL,0FH
        ADD AL,30H
        CMP AL,39H
        JLE SKIP_DISPLAY2
        ADD AL,07H
    SKIP_DISPLAY2:
        MOV DL,AL
        MOV AH,02H
        INT 21H   
        MOV AL,[SI]
        AND AL,0F0H
        SHR AL,04H
        ADD AL,30H
        CMP AL,39H
        JLE SKIP_DISPLAY3
        ADD AL,07H
    SKIP_DISPLAY3:
        MOV DL,AL
        MOV AH,02H
        INT 21H
        MOV AL,[SI]
        AND AL,0FH
        ADD AL,30H
        CMP AL,39H
        JLE SKIP_DISPLAY4
        ADD AL,07H
    SKIP_DISPLAY4:
        MOV DL,AL
        MOV AH,02H
        INT 21H 
        PRINT NEWLINE
        ADD SI,02H
        DEC CH
        JNZ DISPLAY
        
        MOV AH,4CH
        INT 21H
    
    SCAN PROC
        MOV AH,01H
        INT 21H
        SUB AL,30H
        CMP AL,9H
        JLE SKIP_SCAN
        ADD AL,07H
    SKIP_SCAN:RET
    SCAN ENDP
CODE ENDS
END START    
    