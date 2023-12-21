DATA SEGMENT
    MSG1 DB 10,13,"ENTER THE LENGTH OF ARRAY : $"
    LEN DB ?
    MSG2 DB 10,13,"ENTER ARRAY ELEMENTS: $"
    ARR DW ?    
    NEWLINE DB 10,13,"$"
    MSG3 DB 10,13,"SMALLEST NO OF ARRAY : $"
    PRINT MACRO ARG
        LEA DX,ARG
        MOV AH,09H
        INT 21H
    PRINT ENDM
DATA ENDS
CODE SEGMENT
    START:
    MOV AX,DATA
    MOV DS,AX
    
    PRINT MSG1
    CALL SCAN
    MOV LEN,AL
    CALL SCAN
    LEA SI,ARR
    MOV CH,LEN 
    PRINT NEWLINE
    PRINT MSG2
    READ:
    CALL SCAN
    MOV BH,AL
    SHL BH,04H
    CALL SCAN
    ADD BH,AL
    CALL SCAN
    MOV BL,AL
    SHL BL,04H
    CALL SCAN
    ADD BL,AL
    MOV [SI],BX
    CALL SCAN
    ADD SI,02H    
    DEC CH
    JNZ READ
    MOV CH,LEN
    
    OUTER_LOOP:
    LEA SI,ARR
    MOV CL,CH
    DEC CL
    JZ END_SORT
    
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
    
    END_SORT: 
    PRINT NEWLINE
    PRINT MSG3
    LEA SI,ARR
    
    DISPLAY:
    MOV BL,[SI+1]
    AND BL,0F0H
    SHR BL,04H
    ADD BL,30H
    CMP BL,39H
    JLE SKIP_DISPLAY
    ADD BL,07H
    SKIP_DISPLAY:
    MOV DL,BL
    MOV AH,02H
    INT 21H 
    MOV BL,[SI+1]
    AND BL,0FH
    ADD BL,30H
    CMP BL,39H
    JLE SKIP_DISPLAY1
    ADD BL,07H
    SKIP_DISPLAY1:
    MOV DL,BL
    MOV AH,02H
    INT 21H 
    
    MOV BL,[SI]
    AND BL,0F0H
    SHR BL,04H
    ADD BL,30H
    CMP BL,39H
    JLE SKIP_DISPLAY2
    ADD BL,07H
    SKIP_DISPLAY2:
    MOV DL,BL
    MOV AH,02H
    INT 21H 
    MOV BL,[SI]
    AND BL,0FH
    ADD BL,30H
    CMP BL,39H
    JLE SKIP_DISPLAY3
    ADD BL,07H
    SKIP_DISPLAY3:
    MOV DL,BL
    MOV AH,02H
    INT 21H
    
    
    MOV AH,4CH
    INT 21H
    
    
    SCAN PROC
        MOV AH,01H
        INT 21H
        SUB AL,30H
        CMP AL,09H
        JLE SKIP_SCAN
        ADD AL,07H
    SKIP_SCAN:RET
    SCAN ENDP
    
    CODE ENDS
END START