.386 
.model flat, stdcall 
option casemap:none 

include C:\masm32\include\masm32rt.inc
;.data
  ;   input_text db 32 dup('$')
.data?
   input_text db 32 dup(?)

.code 
start: 
    
    push 32                       
    push offset input_text              
    call StdIn                          

    
    mov ebx,0
      lap:
         cmp  [input_text+ebx],0
         je break

         cmp [input_text+ebx], 'a'
        jl continue
        
        cmp [input_text+ebx],'z'
       jg continue
        
        sub [input_text+ebx], 32
        
        continue:
        
        inc ebx
        
        jmp lap
     
      break:
    
    push offset input_text              ; print input_text
    call StdOut
    inkey                           

    push 0h                         
    call ExitProcess

end start

