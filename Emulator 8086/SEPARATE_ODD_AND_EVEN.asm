DATA SEGMENT
    LIST DB 12H,98H,45H,83H,2H;,28H,67H,92H,54H,63H,76H
    MSG1 DB 10,13,"EVEN LIST : $" 
    EVENLIST DB ?     
    MSG2 DB 10,13,"ODD LIST : $" 
    NEWLINE DB 10,13,"$" 
    ODDLIST DB ?
    LEN DB 0AH  
    NEWLINE2 DB 10,13,"$" 
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
    MOV ES,AX  
    XOR AH,AH  
    MOV SI,OFFSET EVENLIST
    MOV DI,OFFSET ODDLIST 
    MOV BX,OFFSET LIST  
    MOV CL,05H 
    MOV CH,00H 
    XOR DX,DX
    
    ITERATE:
    MOV AL,[BX] 
    MOV AH,AL
    SHR AL,01H
    JC ODD 
    INC DH  
    MOV [SI],AH
    INC SI
    JMP NXT_ITR
    ODD: 
    INC DL   
    MOV [DI],AH
    INC DI
    NXT_ITR:
    INC BX 
    DEC CL
    CMP CL,00H
    JNE ITERATE 
    
    MOV SI,OFFSET EVENLIST 
    MOV DI,OFFSET ODDLIST 
    MOV CH,DH   
    MOV CL,DL
    PRINT MSG1
    PRINT NEWLINE
    
    DISPLAY:
    XOR AH,AH 
    MOV AL,[SI]
    AND AL,0F0H 
    SHR AL,04H
    ADD AL,30H
    CMP AL,39H
    JMP SKIP_DISPLAY1
    ADD AL,07H
    SKIP_DISPLAY1:
    MOV DL,AL
    MOV AH,02H
    INT 21H   
    MOV AL,[SI]
    AND AL,0FH 
    ADD AL,30H
    CMP AL,39H
    JMP SKIP_DISPLAY2
    ADD AL,07H
    SKIP_DISPLAY2:
    MOV DL,AL
    MOV AH,02H
    INT 21H  
    PRINT NEWLINE
    INC SI  
    DEC CH
    JNZ DISPLAY 
                
    
    PRINT NEWLINE
    PRINT MSG2
    PRINT NEWLINE2
    
    DISPLAY2:  
    XOR AH,AH
    MOV AL,[DI]
    AND AL,0F0H 
    SHR AL,04H
    ADD AL,30H
    CMP AL,39H
    JMP SKIP_DISPLAY3
    ADD AL,07H
    SKIP_DISPLAY3:
    MOV DL,AL
    MOV AH,02H
    INT 21H   
    MOV AL,[DI]
    AND AL,0FH 
    ADD AL,30H
    CMP AL,39H
    JMP SKIP_DISPLAY4
    ADD AL,07H
    SKIP_DISPLAY4:
    MOV DL,AL
    MOV AH,02H
    INT 21H  
    PRINT NEWLINE2
    INC DI  
    DEC CL
    JNZ DISPLAY2
    
    
    END_PRG:
    MOV AH,4CH
    INT 21H
    CODE ENDS
END START
     
    
     
    
      
    
    
    
    
    
    
    
    
    
    

    