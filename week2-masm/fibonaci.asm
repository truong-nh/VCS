.386
.model flat, stdcall
option casemap :none

include C:\masm32\include\masm32rt.inc
max_size  EQU 20

.data?
    n db 32 dup(?)
.data
    number1    db "0000000000000000000001", 0h
    number2    db "0000000000000000000001", 0h
    numberTemp db "0000000000000000000000",0h 
    divisor DWORD 0000000Ah
    temp dd 0
    endline db 10,0
    inputN db 32 dup (?)
 
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


   
       ;;Input:    edi -offset number1
    ;;          esi - offset number2
    ;;          ecx - 22 size string number1
    ;;Output:   numberTemp = number1+ number1
    big_int_sum proc uses eax ebx ecx edx edi esi
        mov eax,0
        mov edx,0
        mov ecx,22
        mov ebx, offset numberTemp
        _lap:
            dec ecx
            cmp ecx,0 
            je _break
            mov edx ,0
            mov ah, byte ptr [edi+ecx]
            sub ah, '0'              ;ah = int number1[ecx]
            add byte ptr [temp],ah 
            mov al, byte ptr [esi+ecx] 
            sub al, '0'              ; al = int number2[ecx]
            add byte ptr [temp],al   
            mov edx,0
            mov eax,[temp]
            div divisor      ; eax: phan nguyen edx phan du
            mov temp,eax
            add dl,'0'
            mov numberTemp[ecx], dl
            jmp _lap
        _break:
        ret                             
    big_int_sum endp

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



    ;;Strcpy() function implemention 
    ;;Input:   edi - pointer to the target string
    ;;         esi - pointer to the source string
    ;;Output:  in the target string 
    strcpy proc uses eax ebx ecx edx
        mov eax, edi                        ; eax = target[]
        mov ebx, esi                        ; ebx = source[]
        mov ecx, 22                   ; ecx (counter) = max_size
    _lap:
        cmp ecx, 0                          ; compare ecx vs 0h
        jl _break                            ; if ecx < 0 -> done
        mov dh, byte ptr [ebx + ecx]            ; else dh = source[ecx]
        mov byte ptr [eax + ecx], dh            ; target[ecx] = dh = source[ecx]
        dec ecx                             ; ecx--
        jnz _lap
    _break:
        ret
    strcpy endp
    
    ;input ebx: n
    ;output in ra n so fibonaci
    fibonaci proc
             ;mov ebx,5
              _lap1:
              cmp ebx,0
              je _break1
              
              mov edi, offset number1
              mov esi, offset number2
              call big_int_sum        ; tong 2 so luu vao numberTemp

              mov edi, offset number1
              call printStringInt
             
              mov edi, offset  number1
              mov esi, offset number2
              call strcpy             ;number1 = number2

              mov edi,offset number2  
              mov esi,offset numberTemp
              call strcpy             ;number2 = numberTemp 

 
              dec ebx
              jmp _lap1
          _break1:
          ret
    fibonaci endp



start:
    push 32
    push offset inputN
    call StdIn

    mov ebx, offset inputN
    call atoi

    mov ebx,eax
    call fibonaci
    

    inkey                                   ; stop program and ask user to exit

    push 0h                                 ; exit
    call ExitProcess

end start

