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
space   db " ",0h

elf_header      		db "ELF Header:", 0Ah, "    Magic: ", 0h
elf_header_len 			equ $-elf_header

; ELF Header Members msgs
    elf_class_32b 	db "    Class:                ELF32",10, 0h
    elf_class_msg_len 				equ $-elf_class_32b
    elf_class_64b 	db "    Class:                ELF64",10, 0h
    elf_class_msg 	dd elf_class_32b, elf_class_64b
    elf_class           dd 1 

 ; ELF Data
    elf_data_32b  	db "    Data:                 2's complement, little endian",10, 0h
    elf_data_msg_len 				equ $-elf_data_32b
    elf_data_64b  	db "    Data:                 2's complement, big endian   ",10, 0h
    elf_data_msg  	dd elf_data_32b, elf_data_64b
    elf_data            dd 1
  ; ELF Version
    elf_version_msg 	db "    Version:              1 (current)",10, 0h
    elf_version_msg_len 			equ $-elf_version_msg


; ELF OS/ABI
    OsAbi_00 	db "    OS/ABI:                UNIX - System V              ",10, 0h  
    OsAbi_msg_len 					equ $-OsAbi_00  
    OsAbi_01 	db "    OS/ABI:                HP-UX                        ",10, 0h
    OsAbi_02 	db "    OS/ABI:                NetBSD                       ",10, 0h
    OsAbi_03 	db "    OS/ABI:                Linux                        ",10, 0h
    OsAbi_04 	db "    OS/ABI:                GNU Hurd                     ",10, 0h
    OsAbi_06 	db "    OS/ABI:                Solaris                      ",10, 0h
    OsAbi_07 	db "    OS/ABI:                AIX                          ",10, 0h
    OsAbi_08 	db "    OS/ABI:                IRIX                         ",10, 0h
    OsAbi_09 	db "    OS/ABI:                FreeBSD                      ",10, 0h
    OsAbi_0A 	db "    OS/ABI:                Tru64                        ",10, 0h
    OsAbi_0B 	db "    OS/ABI:                Novell Modesto               ",10, 0h
    OsAbi_0C 	db "    OS/ABI:                OpenBSD                      ",10, 0h
    OsAbi_0D 	db "    OS/ABI:                OpenVMS                      ",10, 0h
    OsAbi_0E 	db "    OS/ABI:                Nonstop Kernel               ",10, 0h
    OsAbi_0F 	db "    OS/ABI:                AROS                         ",10, 0h
    OsAbi_10 	db "    OS/ABI:                Fenix OS                     ",10, 0h
    OsAbi_11 	db "    OS/ABI:                CloudABI                     ",10, 0h
    OsAbi_12 	db "    OS/ABI:                Stratus Technologies OpenVOS ",10, 0h
    OsAbi_msg 	dd OsAbi_00 , OsAbi_01 , OsAbi_02 , OsAbi_03 , OsAbi_04 , OsAbi_06 , OsAbi_06 , OsAbi_07 , OsAbi_08 , OsAbi_09 , OsAbi_0A , OsAbi_0B , OsAbi_0C , OsAbi_0D , OsAbi_0E , OsAbi_0F , OsAbi_10 , OsAbi_11 , OsAbi_12
    elf_OsAbi   dd 1
    
; ELF ABI Version
    elf_ABIver_msg db "    ABI Version:                   ", 0h
    elf_ABIver_msg_len 				equ $-elf_ABIver_msg    
    
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
    
    mov ecx, elf_header
    mov edx, elf_header_len
    call print
    
    mov edx,4
    lap4:
    push edx
    mov eax, 3
    mov ebx, eax
    mov ecx, BytesBuffer
    mov edx, 1           ; so byte doc
    int 80h              ; doc file
    
    lea edi, [tmp_string]
    mov ecx, 1
    movzx eax, word [BytesBuffer]
    call print_string      ;in byte vua doc
    call printSpace
    pop edx
    dec edx
    cmp edx,0 
    jne lap4
    
    ;;read Class print value Hex

    mov eax, 3
    mov ebx, eax
    mov ecx, BytesBuffer
    mov edx, 1           ; so byte doc
    int 80h              ; doc file
    
    lea edi, [tmp_string]
    mov ecx, 1
    movzx eax, word [BytesBuffer]
    mov [elf_class], eax    
    call print_string      ;in byte vua doc
    call printSpace
   
    ;;read data print value Hex

    mov eax, 3
    mov ebx, eax
    mov ecx, BytesBuffer
    mov edx, 1           ; so byte doc
    int 80h              ; doc file
    
    lea edi, [tmp_string]
    mov ecx, 1
    movzx eax, word [BytesBuffer]
    mov [elf_data], eax    
    call print_string      ;in byte vua doc
    call printSpace

    
    ;;read version print value Hex

    mov eax, 3
    mov ebx, eax
    mov ecx, BytesBuffer
    mov edx, 1           ; so byte doc
    int 80h              ; doc file
    
    lea edi, [tmp_string]
    mov ecx, 1
    movzx eax, word [BytesBuffer]
    call print_string      ;in byte vua doc
    call printSpace

    
    ;;read OS/ABI print value Hex

    mov eax, 3
    mov ebx, eax
    mov ecx, BytesBuffer
    mov edx, 1           ; so byte doc
    int 80h              ; doc file
    
    lea edi, [tmp_string]
    mov ecx, 1
    movzx eax, word [BytesBuffer]
    mov [elf_OsAbi], eax
    call print_string      ;in byte vua doc
    call printSpace
 
    
    
    
    
    call newLine
    ;   print ELF Class
    mov eax, dword [elf_class]
    dec eax
    mov edx, elf_class_msg
    mov ecx, [eax*8 + edx]
    mov edx, elf_class_msg_len
    call print
    
    ;   print ELF data
    mov eax, dword [elf_data]
    dec eax
    mov edx, elf_data_msg
    mov ecx, [eax*8 + edx]
    mov edx, elf_data_msg_len
    call print

    ;   print ELF version
    mov ecx, elf_version_msg
    mov edx, elf_version_msg_len
    call print
     
        ;   print ELF OS/ABI
    mov eax, dword [elf_OsAbi]
    mov edx, OsAbi_msg
    mov ecx, [eax*8 + edx]
    mov edx, OsAbi_msg_len
    call print  



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

printSpace:
    mov edx,1
    mov ecx, space
    call print
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
    
