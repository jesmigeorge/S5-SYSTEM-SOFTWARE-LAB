DATA SEGMENT
    MSG1 DB 0AH, 0DH, "Enter a string: $"
    USER_STRING DB 30, 0, 30 DUP('$')
    MSG2 DB 0AH, 0DH, "Enter a substring: $"
    SUBSTRING DB 20, 0, 20 DUP('$')
    FOUND_MSG DB 0AH, 0DH, "Substring found!$"
    NOT_FOUND_MSG DB 0AH, 0DH, "Substring not found!$"
    LENGTH_ERROR_MSG DB 0AH, 0DH, "Length of substring is greater than length of string!$" 
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
        MOV DL,ARG
        ADD DL,30H
        MOV AH,02H
        INT 21H
    COUNT ENDM
DATA ENDS

CODE SEGMENT
    ASSUME CS:CODE, DS:DATA
    START:
        MOV AX, DATA
        MOV DS, AX
        MOV ES, AX

        PRINT MSG1 
        INPUT USER_STRING

        PRINT MSG2
        INPUT SUBSTRING

        
        XOR CH,CH
        XOR CL,CL

        MOV SI, OFFSET USER_STRING+2
        MOV CL, [SI-1]   
       ; COUNT CL
        MOV DI, OFFSET SUBSTRING+2
        MOV CH, [DI-1] 
        ;COUNT CH

        CMP CL, CH
        JC LENGTH_ERROR

    LOOP1:
        MOV AL, [DI] ; Current character in substring
        
    LOOPIN:
        CMP AL, [SI] ; Compare with current character in string
        JNE CHECK_NXT_CHAR
        INC DI
        INC SI 
        CMP [DI], 0DH ; Check for end of substring
        JE SUBSTRING_FOUND
        JMP LOOP1

    CHECK_NXT_CHAR:
        INC SI   
        MOV DI, OFFSET SUBSTRING+2
        CMP [SI], 13 ; Check for end of string
        JZ STRING_END
        JMP LOOPIN    

    SUBSTRING_FOUND:
        ; Substring found, display message and exit
        PRINT FOUND_MSG
        JMP END_PROGRAM

    LENGTH_ERROR:
        ; Length of substring is greater than length of string
        PRINT LENGTH_ERROR_MSG
        JMP END_PROGRAM

    STRING_END:
        ; End of string reached, substring not found
        PRINT NOT_FOUND_MSG

    END_PROGRAM:
        MOV AH, 4CH
        INT 21H
CODE ENDS
END START