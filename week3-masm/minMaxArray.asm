.386
.model flat, stdcall
option casemap :none

include C:\masm32\include\masm32rt.inc

.data?

.data
    n      dd 0
    inputN db 32 dup (?)
    max_array dd 0
    min_array dd 0
    array     dd 100 dup(?)
    endline db 10,0

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

    ;;  Input:   edi - pointer to output string
    printStringInt proc
        _lap:
            cmp byte ptr [edi], '0'
            jne _break
            inc edi
            jmp _lap 
        _break:
            push edi
            call StdOut
            call printNewLine
            ret
    printStringInt endp

   printNewLine proc 
         push offset endline
         call StdOut
          
         ret
   printNewLine endp


;input esi= offset
;output eax: lengthString
strlen proc 
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

strlen endp


;input ecx :n esi: offset Array
scanArray proc 
          _lap:
              cmp ecx, 0
              je _break
              push ecx  
              push 32 
              push offset inputN 
              call StdIn                 ; call StdIn anh huong toi ecx nen can push ecx

              mov ebx, offset inputN
              call atoi
              mov [esi], eax
              add esi, 4    ; 1 dd = 4 byte
              pop ecx
              dec ecx
              jmp _lap
           

          _break:
          ret
scanArray endp

;input ecx: n esi offset Array
;output min ebx, max edx

minMaxArray proc
              mov ebx, [esi]
              mov edx, [esi]
              _lap:
              cmp ecx, 0
              je _break
              push ecx  
              
              cmp ebx, [esi]
              jnl _next1
              mov ebx,[esi]

              _next1:
              cmp edx, [esi]
              jng _next2
              mov edx,[esi]
              _next2:
              add esi,4
              pop ecx
              dec ecx
              jmp _lap
           

          _break:
          ret
minMaxArray endp

start:
    push 32
    push offset inputN
    call StdIn

    mov ebx, offset inputN
    call atoi

    mov n, eax

    mov esi, offset array
    mov ecx,n
    call scanArray
    
    mov esi,offset array
    mov ecx,n
    call minMaxArray

    push ebx
    mov eax,edx
    call itoa
    push eax
    call StdOut
    call printNewLine
    pop ebx

    mov eax,ebx
    call itoa
    push eax
    call StdOut
    call printNewLine
    
    inkey                           

    push 0h                         
    call ExitProcess
end start

