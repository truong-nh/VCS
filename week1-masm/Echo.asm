.386 
.model flat, stdcall 
option casemap:none 

include C:\masm32\include\masm32rt.inc

.data?
    inputString db 32 dup(?)

.code 



start: 
    
    push 32                             ; size of inputString
    push offset inputString              ; address of inputString
    call StdIn                          ; read string
    push offset inputString              ; print inputString
    call StdOut
    
    inkey                           

    push 0h                         
    call ExitProcess
    
end start
