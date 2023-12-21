DATA SEGMENT
    MSG1 DB 10,13,"ENTER A NUMBER : $"
    NUM DB ?
    MSG2 DB 10,13,"FACTORIAL : $"  
    FACT DB ? 
    ARR DW ?
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
    LEA SI,ARR
    PRINT MSG1
    READ:
    CALL SCAN
    MOV BL,AL
    SHL BL,04H 
    CALL SCAN
    ADD BL,AL 
    MOV [SI],BL
    MOV NUM,BL
    CALL SCAN 
    
    INITIALIZE: 
    PRINT MSG2
    MOV AL,01H
    XOR AH,AH
    FACTORIAL:
    MUL BL
    DEC BL
    JNZ FACTORIAL
    
    XOR AH,AH
    CONVERT: 
    ;binary to bcd conversion
    MOV BL,64H
    DIV BL 
    MOV CH,AH   
    MOV CL,AL 
    AND CL,0FH
    ADD CL,30H
    CMP CL,39H
    JLE SKIP_DISPLAY7
    ADD CL,07H
    SKIP_DISPLAY7:
    MOV DL,CL
    MOV AH,02H
    INT 21H  
    
    MOV AL,CH
    XOR AH,AH
    MOV BL,0AH
    DIV BL
    SHL AL,04H
    ADD AL,AH
        
    MOV [SI+2],AL 
    MOV BL,[SI+2]  
        
    DISPLAY:
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
    MOV BL,[SI+2]
    AND BL,0FH
    ADD BL,30H
    CMP BL,39H
    JLE SKIP_DISPLAY1
    ADD BL,07H
    SKIP_DISPLAY1:
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
     
    
    

        
    