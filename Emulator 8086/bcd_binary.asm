DATA SEGMENT
    N1 DB 25H
DATA ENDS
CODE SEGMENT
    START:
        MOV AX,DATA
        MOV DS,AX
        XOR AX,AX
        MOV AL,N1
        MOV BL,AL
        AND BL,0FH
        MOV CL,04H
        SHR AL,CL
        MOV CH,0AH
        MUL CH
        ADD AL,BL
        MOV [1101H],AL
        MOV AH,4CH
        INT 21H
    CODE ENDS
END START
        