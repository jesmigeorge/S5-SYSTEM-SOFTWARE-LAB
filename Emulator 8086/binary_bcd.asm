DATA SEGMENT
    N1 DB 19H
DATA ENDS
CODE SEGMENT
    START:
        MOV AX,DATA
        MOV DS,AX
        XOR AX,AX
        MOV AL,N1
        MOV BL,64H ;TO TAKE THE NUMBER IN TEN'S PLACE
        MOV AH,00H
        DIV BL 
        MOV [1101H],AL
        MOV AL,AH
        MOV AH,00H
        MOV BL,0AH
        DIV BL
        MOV CL,04H
        SHL AL,CL
        OR AL,AH
        MOV [1102H],AL
   CODE ENDS
END START
        