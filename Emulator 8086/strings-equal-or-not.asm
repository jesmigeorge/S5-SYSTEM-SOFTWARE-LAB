DATA SEGMENT
    STRING1 DB "HALA$"
    STRING2 DB "HALA$"
    STRING3 DB "THEY ARE SAME STRINGS$"
    STRING4 DB "THEY ARE DIFFERENT STRINGS$"
    COUNT DW 04H ; Assuming the length of the strings is 4
DATA ENDS

CODE SEGMENT
    START:
            MOV AX, DATA
            MOV DS, AX
            MOV ES, AX
            MOV SI, OFFSET STRING1
            MOV DI, OFFSET STRING2
            CLD
            MOV CX, COUNT ; Initialize CX with the length of the strings
            REPE CMPSB      ; Compare strings ;repeat while CX!=0 or the strings are equal 
            JZ STRINGS_EQUAL ; Jump if strings are equal
            JMP STRINGS_DIFFERENT ; Jump if strings are different

    STRINGS_EQUAL:
            MOV DX, OFFSET STRING3
            MOV AH, 09H
            INT 21H
            JMP STOP

    STRINGS_DIFFERENT:
            MOV DX, OFFSET STRING4
            MOV AH, 09H
            INT 21H

    STOP:
            MOV AH, 4CH
            INT 21H

CODE ENDS
END START


    
        
         
