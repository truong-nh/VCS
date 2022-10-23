.386
.model flat, stdcall
option casemap :none

include C:\masm32\include\masm32rt.inc

.data
     x dd 0
     array db 100 dup(0)
     endline db 10,0
.data? 
     stringS db 100 dup(?)
     stringC db 10  dup(?)
     count db 0
     
 .code
    ;input eax: int 
 ;out put eax dia chi cua xau sau khi chuyen
    itoa proc 
        add esi, 32      ; point to the last of result buffer
        dec esi
        mov byte ptr [esi], 0h      ; set the last byte of result buffser to null
        mov ebx, 10             ; ebx = 10
    lap2:
        xor edx, edx            ; edx = 0
        div ebx                 ; divide eax by divisor ebx = 10
        add dl, '0'             ; dl - remainder
        dec esi                 ; point to the next left byte 
        mov [esi], dl           ; mov remainder to the current byte
        test eax, eax           ; if (eax == 0) ?
        jnz lap2                ; if not -> loop
        mov eax, esi            ; else return result to eax
        ret      
    itoa endp


    

;input esi= offset
;output eax: lengthString
lengthString proc uses ecx esi
 
      mov eax,0
     _lap:
        movzx ecx, byte ptr[esi]
        cmp  ecx, 0
        je _break
        inc eax
        inc esi
        jmp _lap
     _break:
        ret   

lengthString endp


;input edi,esi offset String eax chieu dai xau
;output eax=0 neu dung; eax!= 0 neu sai
    test1 proc uses ebx edi esi
             mov bh,0
             mov ch,0
         _lap:
             cmp eax,0
             je _break
             mov bh,byte ptr [edi]
             mov ch,byte ptr [esi]
             cmp bh,ch 
             jne _break
             dec eax
             inc edi
             inc esi
             jmp _lap
         _break:
         ret 
    test1 endp

;input edi -offset xau me; esi -offset xau con; eax do dai xau con
;output ebx: so lan xuat hien xau con
subString proc uses edi esi eax
         mov ebx,0 
         _lap:
             cmp byte ptr[edi],0
             je _break
             push eax
             call test1
             cmp eax,0
             jne _next
             inc ebx
          _next:
             pop eax
             inc edi
             jmp _lap
          _break:

          ret

subString endp

;input edi -offset xau me; esi -offset xau con; eax do dai xau con
;output ebx: so lan xuat hien xau con
printSubString proc uses edi esi eax
         mov ebx,0 
         _lap:
             cmp byte ptr[edi],0
             je _break
             push eax
             call test1
             cmp eax,0
             jne _next
             call printInt

           
          _next:
             pop eax
             inc edi
             inc ebx
             jmp _lap
          _break:

          ret

printSubString endp

;input ebx
printInt proc uses eax ebx ecx edx esi edi
       mov eax,ebx
       call itoa  
       push eax
       call StdOut
       call printNewLine
       ret
printInt endp

printNewLine proc 
         push offset endline
         call StdOut
          
         ret
printNewLine endp

 start:
       push 100
       push offset stringS
       call StdIn

       push 10
       push offset stringC 
       call StdIn
       
       mov esi,offset stringC
       call lengthString   ;eax= length string C
       mov esi, offset stringC
       mov edi, offset stringS
       call subString
       call printInt

       mov esi,offset stringC
       call lengthString   ;eax= length string C
       mov esi, offset stringC
       mov edi, offset stringS
       call printSubString  
       
    inkey
                                      
    push 0h                                 
    call ExitProcess



       
 end start

