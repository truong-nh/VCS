.386
.model flat, stdcall
option casemap :none

include C:\masm32\include\masm32rt.inc
max_size  EQU 20

.data?
    input1     db 20 dup(?), 0h
    input2     db 20 dup(?), 0h
.data
    number1    db "000000000000000000000", 0h
    number2    db "000000000000000000000", 0h
    numberTemp db "00000000000000000000", 0h 
    divisor DWORD 0000000Ah
    temp dd 0
    endline db 10,0
    inputN db 32 dup (?)
 
.code

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
        mov ecx,20
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

strlen proc uses esi
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

;input esi offset source; edi offset target; eax: lengthString source; ebx size string taget
convert proc
      ;dec ebx
      ;dec eax
      add esi,eax
      add edi,ebx
      _lap:
          mov ch, byte ptr[esi]
          mov byte ptr [edi],ch
          cmp eax, 0
          je _break
          dec eax
          dec esi
          dec edi
          jmp _lap
      _break:
      ret
convert endp




start:
    push 20
    push offset input1
    call StdIn
    mov esi, offset input1
    call strlen 
    mov ecx,eax
    mov edi, offset number1
    mov ebx, 20
    call convert



    push 20
    push offset input2
    call StdIn
    mov esi, offset input2
    call strlen 
    mov ecx,eax
    mov edi, offset number2
    mov ebx, 20
    call convert
    
    mov edi,offset numberTemp
    mov edi,offset number1
    mov esi,offset number2
    call big_int_sum

    mov edi, offset numberTemp
    call printStringInt 


    inkey                                   ; stop program and ask user to exit

    push 0h                                 ; exit
    call ExitProcess

end start

