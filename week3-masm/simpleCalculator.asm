.386 
.model flat, stdcall 
option casemap:none 

include C:\masm32\include\masm32rt.inc
.data
   string0 db "lua chon chuc nang", 10,0
   string1 db "1.cong", 10, 0
   string2 db "2.tru",  10, 0
   string3 db "3.nhan", 10, 0
   string4 db "4.chia", 10, 0
   string5 db "nhap so thu nhat: ", 0
   string6 db "nhap so thu 2: "   , 0
   string7 db "ket qua: ",0  
   string8 db "   so du : ", 0
   string9 db "-", 0
   number1 dd 0
   number2 dd 0
   choice  dd 0
.data?
     
   inputNumber1 db 32 dup (?)
   inputNumber2 db 32 dup (?)
   inputChoice     db 32 dup (?)

   output  db 32 dup(?)
  .code 

;input ebx=offset input
;output eax
atoi proc uses ebx ecx 
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


 ;input eax: int 
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

;eax chuc nang
;ebx so thu nhat
;ecx so thu hai

calculator proc
          mov edx, 0 
          
          cmp eax, 1
          je _cong
          cmp eax, 2
          je _tru
          cmp eax, 3
          je _nhan
          cmp eax, 4
          je _chia

          _cong:
          add edx, ebx
          add edx, ecx
          mov eax, edx
          mov esi, offset output  
          call itoa
          push eax
          call StdOut
          jmp _break

          _tru:
          cmp ebx, ecx
          jg _grearer
          push ebx
          push ecx
          push offset string9
          call StdOut
          pop ebx
          pop ecx 
          _grearer:
          sub ebx, ecx         
          _done:
          mov eax, ebx
          mov esi, offset output  
          call itoa
          push eax
          call StdOut
          jmp _break
 

          _nhan:
          mov eax, ebx
          mul ecx
          
          mov esi, offset output  
          call itoa
          push eax
          call StdOut
          jmp _break
          
          _chia:
          mov eax, ebx
          div ecx
          push edx
          mov esi, offset output  
          call itoa
          push eax
          call StdOut

          push offset string8
          call StdOut
          pop edx
          mov eax,edx
          mov esi, offset output  
          call itoa
          push eax
          call StdOut


          jmp _break

          _break:
          ret
calculator endp


start: 
    
    push offset string0          
    call StdOut

    push offset string1         
    call StdOut

    push offset string2          
    call StdOut

    push offset string3          
    call StdOut

    push offset string4          
    call StdOut

    push 32                       
    push offset inputChoice           
    call StdIn           

    mov ebx, offset inputChoice                                              
    call atoi  
    mov choice, eax
    
    push offset string5
    call StdOut
    push 32                       
    push offset inputNumber1           
    call StdIn           

    mov ebx, offset inputNumber1                                              
    call atoi  
    mov number1, eax
    
    push offset string6
    call StdOut
    push 32                       
    push offset inputNumber2           
    call StdIn           

    mov ebx, offset inputNumber2                                              
    call atoi  
    mov number2, eax
    
    push offset string7
    call StdOut
    mov eax, choice
    mov ebx, number1
    mov ecx, number2
    call calculator

    inkey                           

    push 0h                         
    call ExitProcess
    
end start








