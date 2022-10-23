.386 
.model flat, stdcall 
option casemap:none 

INCLUDE C:\MASM32\INCLUDE\MASM32RT.INC

.DATA 
     HELLOWORLD DB "HELLO, WORLD!", 0AH, 0 
.CODE 
START: 
    PUSH OFFSET HELLOWORLD   
    CALL StdOut
    
    inkey                           

    push 0h                         
    call ExitProcess
  

END START