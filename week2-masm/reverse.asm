.386 
.model flat, stdcall 
option casemap:none 

include C:\masm32\include\masm32rt.inc

.data?
    inputString db 32 dup(?)
.code 
    
; input esi: off setstring, eax = length string
reverse proc
        
        mov edi,esi  
        add edi,eax  
        dec edi      ; edi= string[end];esi= string[0]    
        _lap:
        cmp esi,edi  ; esi > edi thi ket thuc vong lap
        jge _break
        
        mov al,[esi]
        mov bl,[edi]
        mov [esi],bl
        mov [edi],al
        inc esi
        dec edi
        jmp _lap
        
        _break:
        ret       
      
reverse endp

;input esi= offset
;output eax: lengthString
lengthString proc
      push esi
      push ecx
      mov eax,0
     _lap:
        movzx ecx, byte ptr[esi]
        cmp  ecx, 0
        je _break
        inc eax
        inc esi
        jmp _lap
     _break:
     pop ecx
     pop esi
        ret   

lengthString endp

start: 
    
    push 32                             ; size  of inputString
    push offset inputString             ; address of inputString
    call StdIn                          ; read inputString
    
    mov esi, offset inputString
    call lengthString
    
    
    mov esi, offset inputString     
    call reverse

    
    push offset inputString
    call StdOut
    
    inkey                           

    push 0h                         
    call ExitProcess


end start
