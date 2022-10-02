; Read
; Compile with: nasm -f elf read.asm
; Link with (64 bit systems require elf_i386 option): ld -m elf_i386 read.o -o read
; Run with: ./read
 
%include    'functions.asm'
 
SECTION .data
filename db 'add', 0h    ; the filename to create
contents db 'Hello world!', 0h  ; the contents to write
 handle dd 0
newline  db 10,0
lpHexString	db "0123456789ABCDEF"



SECTION .bss
fileContents resb 255,          ; variable to store file contents
buffer       resb 200 
BytesBuffer resb 200
tmp_string resb 200
tmp_string1 resb 200
tmp_string2 resb 200
tmp_string3 resb 200
tmp_string4 resb 200
string_buf db 20 dup(?)
SECTION .text
global  _start
 
_start:
    mov     edx, 0777
    mov     ecx, 0              ; Open file 
    mov     ebx, filename
    mov     eax, 5
    int     80h
    mov [handle], eax
   
    
    
    mov eax, 3
    mov ebx, eax
    mov ecx, BytesBuffer
    mov edx, 4
    int 80h
    
    lea edi, [tmp_string]
    mov ecx, 1
    movzx eax, word [BytesBuffer]
    ;mov [elf_arch], eax
    call print_string
     
    ;; 
    mov eax, 3
    mov ebx, eax
    mov ecx, BytesBuffer
    mov edx, 1
    int 80h
    
    lea edi, [tmp_string]
    mov ecx, 1
    movzx eax, word [BytesBuffer]
    ;mov [elf_arch], eax
    call print_string
    
    ;;
    mov eax, 3
    mov ebx, eax
    mov ecx, BytesBuffer
    mov edx, 1
    int 80h

    lea edi, [tmp_string]
    mov ecx, 1
    movzx eax, word [BytesBuffer]
    ;mov [elf_arch], eax
    call print_string
    ;;
    
        mov eax, 3
    mov ebx, eax
    mov ecx, BytesBuffer
    mov edx, 1
    int 80h

    lea edi, [tmp_string]
    mov ecx, 1
    movzx eax, word [BytesBuffer]
    ;mov [elf_arch], eax
    call print_string
    
    ;;
    
        mov eax, 3
    mov ebx, eax
    mov ecx, BytesBuffer
    mov edx, 1
    int 80h

    lea edi, [tmp_string]
    mov ecx, 1
    movzx eax, word [BytesBuffer]
    ;mov [elf_arch], eax
    call print_string
    
   
    
    
    call    quit                ; call our quit function
    

newLine:
    mov edx,2
    mov ecx, newline
    call print
    ret 
          
print: 
    mov eax,4
    mov ebx,1
    int 80h
    ret    


 ;; Input: eax - number to convert
    ;;        edi - pointer to buffer
    ;; Output: hex number in buffer
	Dec2Hex:
        mov ecx, 8
    @digit_loop:
        rol eax, 4
        mov edx, eax
        and edx, 0Fh
        movzx edx, byte [lpHexString + edx]
        mov [edi], dl
        inc edi

        dec ecx
        jnz @digit_loop
        mov byte [edi], 0h
        ret

    ;; Input: eax - value to print in hex
    ;;        edi - pointer to string
    ;;        ecx - number of bytes to print
    ;; Output: StdOut
    print_string:
        push ecx
        push edi
        call Dec2Hex
        pop edi
        pop ecx
        ;lea edi, [tmp_string]
        add ecx, ecx
        mov eax, 8
        sub eax, ecx
        add edi, eax
        lea esi, [string_buf]
        Li:
            mov ah, byte [edi]
            mov byte [esi], ah
            cmp ecx, 1h
            je @done
            inc edi
            inc esi
            dec ecx
            jmp Li
        @done:
            inc esi
            mov byte [esi], 0h
            mov ecx, string_buf
            mov edx, 8
            call print
            ret    
    
