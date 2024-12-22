org 100h
.DATA
MSG1 DB 'For Add type   :1$', 0
MSG2 DB 10,13,'For Sub type   :2$', 0
MSG3 DB 10,13,'For Mul type   :3$', 0
MSG4 DB 10,13,'For Div type   :4$', 0
MSG5 DB 10,13,'For Neg type   :5$', 0
MSG6 DB 10,13,'For Inc type   :6$', 0
MSG7 DB 10,13,'For Dec type   :7$', 0
MSG8 DB 10,13,'Choose Any One:$', 0
MSG9 DB 10,13,10,13,'Enter 1st Number:$', 0
MSG10 DB 10,13,'Enter 2nd Number:$', 0  
MSG11 DB 10,13,10,13,'The Result is:$', 0 
MSG12 DB 10,13,'Error division  $', 0
MSG_INVALID DB 10,13, 'Invalid option. Please choose a valid option: 1, 2, 3, 4, 5, 6, or 7$', 0
MSG DB 10,13,10,13,'               **THANK YOU FOR USING MY APP$', 0

NUM1 DB ? 
NUM2 DB ? 
RESULT DB ?

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    LEA DX, MSG1
    MOV AH, 9
    INT 21H

    LEA DX, MSG2
    MOV AH, 9
    INT 21H

    LEA DX, MSG3
    MOV AH, 9
    INT 21H

    LEA DX, MSG4
    MOV AH, 9
    INT 21H

    LEA DX, MSG5
    MOV AH, 9
    INT 21H

    LEA DX, MSG6
    MOV AH, 9
    INT 21H

    LEA DX, MSG7
    MOV AH, 9
    INT 21H

    LEA DX, MSG8
    MOV AH, 9
    INT 21H

    MOV AH, 1
    INT 21H
    MOV BH, AL
    SUB BH, 30h  

    CMP BH, 1
    JE ADD
    CMP BH, 2
    JE SUB
    CMP BH, 3
    JE MUL
    CMP BH, 4
    JE DIV
    CMP BH, 5
    JE NEG
    CMP BH, 6
    JE INC        
    CMP BH, 7
    JE DEC
    LEA DX, MSG_INVALID
    MOV AH, 9
    INT 21H
    JMP EXIT_P

ADD:
    LEA DX,MSG9  
    MOV AH,9
     INT 21H 
    
    MOV AH,1
    INT 21H
    MOV BL,AL
    LEA DX,MSG10    
    MOV AH,9
    INT 21H
    MOV AH,1
    INT 21H
    MOV CL,AL
    ADD AL,BL
    MOV AH,0
    AAA
    MOV BX,AX 
    ADD BH,48
    ADD BL,48 
    LEA DX,MSG11
    MOV AH,9
    INT 21H
    MOV AH,2
    MOV DL,BH
    INT 21H
    MOV AH,2
    MOV DL,BL
    INT 21H
    
    JMP EXIT_P

    

SUB:
 
    LEA DX,MSG9  
    MOV AH,9
    INT 21H 
    MOV AH,1
    INT 21H
    MOV BL,AL
    LEA DX,MSG10    
    MOV AH,9
    INT 21H
    MOV AH,1
    INT 21H
    MOV CL,AL
    SUB BL,CL
    ADD BL,48
    LEA DX,MSG11
    MOV AH,9
    INT 21H
    MOV AH,2
    MOV DL,BL
    INT 21H
    JMP EXIT_P 
    

    
   MUL:
    LEA DX,MSG9
    MOV AH,9
    INT 21H
    MOV AH,1
    INT 21H
    SUB AL,30H
    MOV NUM1,AL
    LEA DX,MSG10
    MOV AH,9
    INT 21H 
    MOV AH,1
    INT 21H
    SUB AL,30H
    MOV NUM2,AL
    MUL NUM1
    MOV RESULT,AL
    AAM  
    ADD AH,30H
    ADD AL,30H
    MOV BX,AX 
    LEA DX,MSG11
    MOV AH,9
    INT 21H 
    MOV AH,2
    MOV DL,BH
    INT 21H
    MOV AH,2
    MOV DL,BL
    INT 21H 
    JMP EXIT_P  
      
   

DIV:

    LEA DX, MSG9  
    MOV AH, 9
    INT 21H
    MOV AH, 1      
    INT 21H
    SUB AL, 30H   
    MOV NUM1, AL
    LEA DX, MSG10  
    MOV AH, 9
    INT 21H
    MOV AH, 1      
    INT 21H
    SUB AL, 30H    
    MOV NUM2, AL

    MOV CL, NUM1
    MOV CH, 00
    MOV AX, CX  
    CMP NUM2, 0
    JE DIV_ZERO

    DIV NUM2  

    MOV RESULT, AL
    MOV AH, 00
    AAD  
    ADD AH, 30H
    ADD AL, 30H
    MOV BX, AX 
    LEA DX, MSG11
    MOV AH, 9
    INT 21H 
    MOV AH, 2
    MOV DL, BH
    INT 21H
    MOV AH, 2
    MOV DL, BL
    INT 21H
    JMP EXIT_P
DIV_ZERO:
    LEA DX, MSG12
    MOV AH, 9
    INT 21H
    LEA DX, MSG
    MOV AH, 9
    INT 21H
    JMP EXIT_P
NEG:
    LEA DX, MSG9 
    MOV AH, 9
    INT 21H
    MOV AH, 1      
    INT 21H
    SUB AL, 30H
    MOV NUM1, AL   
    NEG NUM1      
    ADD NUM1, 30H  
    LEA DX, MSG11  
    MOV AH, 9
    INT 21H
    MOV DL, NUM1   
    MOV AH, 2
    INT 21H        
    JMP EXIT_P
INC:
    LEA DX, MSG9  
    MOV AH, 9
    INT 21H
    MOV AH, 1     
    INT 21H
    SUB AL, 30H    
    MOV NUM1 ,AL
    INC NUM1        

    ADD NUM1, 30H  
    LEA DX, MSG11
    MOV AH, 9
    INT 21H
    MOV DL, NUM1
    MOV AH, 2
    INT 21H        

    JMP EXIT_P

DEC:
    LEA DX, MSG9  
    MOV AH, 9
    INT 21H
    MOV AH, 1      
    INT 21H
    SUB AL, 30H 
    MOV NUM1,AL   
    DEC NUM1   

    ADD NUM1, 30H   
    LEA DX, MSG11
    MOV AH, 9
    INT 21H
    MOV DL, NUM1
    MOV AH, 2
    INT 21H     
    JMP EXIT_P

EXIT_P:
    LEA DX, MSG
    MOV AH, 9
    INT 21H
    MOV AH, 4Ch
    INT 21H

MAIN ENDP

