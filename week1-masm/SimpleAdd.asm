.386 
.model flat, stdcall 
option casemap:none 

include C:\masm32\include\masm32rt.inc
.data

.data?

   number1 db 32 dup (?)
   number2 db 32 dup (?)
   sum     db 32 dup (?)
   x       dd 0
.code 
;input ebx=offset input
;output eax

atoi proc
      mov eax,0
      mov ecx,1
      lap:
          movzx ecx, byte ptr[ebx] ; ecx= input[ebx] 
          cmp   ecx,0
          je    break
          
          sub  ecx, '0'
          lea eax, [eax*4+eax] ; eax= eax*5
          lea eax, [eax*2+ecx] ; eax= eax*5+ ecx
          inc ebx   ; ebx++
          jmp lap 
          
      break:    
          ret   

 atoi endp


 ;input eax: int ; esi dia chi xau
 ;out put eax dia chi cua xau sau khi chuyen
    itoa proc 
        add esi, 32      
        dec esi
        mov byte ptr [esi], 0h      
        mov ebx, 10             
    lap2:
        xor edx, edx            
        div ebx                 
        add dl, '0'             
        dec esi                  
        mov [esi], dl           
        test eax, eax           
        jnz lap2               
        mov eax, esi           
        ret      
    itoa endp



start: 
    
    push 32                       
    push offset number1           
    call StdIn           

    mov ebx, offset number1                                              
    call atoi  

    mov x,eax

    push 32                       
    push offset number2           
    call StdIn           

    mov ebx, offset number2                                              
    call atoi  

    add eax,x
    mov esi, offset sum
    call itoa 

    push eax          
    call StdOut
    
    inkey
                                      
    push 0h                                 
    call ExitProcess

    
     
end start








