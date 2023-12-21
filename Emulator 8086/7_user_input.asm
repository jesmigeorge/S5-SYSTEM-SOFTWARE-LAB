; AH=09H is used for printing strings to the console pointed to by address in DX   
; AH = 0AH is used for inputing strings by the user until "enter" signal is read
DATA SEGMENT
    msg1 db "ENTER STRING 1 : $"
    msg2 db "ENTER STRING 2 : $"
    equalMsg db "The strings are equal.$"
    notEqualMsg db "The strings are not equal.$"
    buffer1 db 80, ?, 80 dup(?)
    buffer2 db 80, ?, 80 dup(?)
DATA ENDS

CODE SEGMENT
    START:
        MOV AX, DATA
        MOV DS, AX 

        LEA DX, msg1
        MOV AH, 09H 
        INT 21H  

        MOV AH, 0AH
        LEA DX, buffer1
        INT 21H

        LEA DX, msg2
        MOV AH, 09H
        INT 21H 

        MOV AH, 0AH
        LEA DX, buffer2
        INT 21H

        LEA SI, buffer1 + 2
        LEA DI, buffer2 + 2

    COMPARE_STRINGS:
        MOV AL, [SI]
        MOV BL, [DI]
        CMP AL, BL
        JNE NOT_EQUAL
        CMP AL, 0
        JE EQUAL
        INC SI
        INC DI
        JMP COMPARE_STRINGS

    EQUAL: 
        LEA DX, equalMsg
        MOV AH, 09H
        INT 21H
        JMP END_PROGRAM

    NOT_EQUAL:
        LEA DX, notEqualMsg
        MOV AH, 09H
        INT 21H

    END_PROGRAM:
        MOV AH, 4CH
        INT 21H

CODE ENDS
END START
