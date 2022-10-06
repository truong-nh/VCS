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
singleByte db 0

elf_header      		db "ELF Header:", 0Ah, "    Magic: ", 0h
elf_header_len 			equ $-elf_header

; ELF Header Members msgs
    elf_class_32b 	db "    Class:                ELF32",10, 0h
    elf_class_msg_len 				equ $-elf_class_32b
    elf_class_64b 	db "    Class:                ELF64",10, 0h
    elf_class_msg 	dd elf_class_32b, elf_class_64b
    elf_arch           dd 1 

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
    OsAbi_msg 	dd OsAbi_00 , OsAbi_01 , OsAbi_02 , OsAbi_03 , OsAbi_04 , OsAbi_06 , OsAbi_06 , OsAbi_07 , OsAbi_08 , OsAbi_09 , OsAbi_0A , OsAbi_0B , OsAbi_0C , OsAbi_0D , OsAbi_0E , OsAbi_0F , OsAbi_10 , OsAbi_11 ,OsAbi_12
    elf_OsAbi   dd 1
    
; ELF ABI Version
    elf_ABIver_msg db "    ABI Version:         ", 0h
    elf_ABIver_msg_len 				equ $-elf_ABIver_msg    
    elf_ABIver dd 0
; ELF Type
    elf_type_00 db "    Type:                 NONE ",10, 0h
    elf_type_msg_len equ $-elf_type_00
    elf_type_01 db "    Type:                 REL  ",10, 0h
    elf_type_02 db "    Type:                 EXEC ",10, 0h
    elf_type_03 db "    Type:                 DYN  ",10, 0h
    elf_type_04 db "    Type:                 CORE ",10, 0h 
    elf_type_FE00 db "    Type:               LOOS ",10, 0h   
    
    elf_type_msg dd elf_type_00, elf_type_01, elf_type_02, elf_type_03, 0xFEFC dup(elf_type_04) , 0xFF dup(elf_type_FE00) 
    elf_type dd 0
 

; ELF Machine
    elf_machine_00 db "    Machine:              Null          ",10, 0h
    elf_machine_01 db "    Machine:              AT&T WE 32100 ",10, 0h
    elf_machine_msg_len equ $-elf_machine_01
    elf_machine_02 db "    Machine:              SPARC         ",10, 0h
    elf_machine_03 db "    Machine:              Intel 80386   ",10, 0h
    elf_machine_04 db "    Machine:              M68k          ",10, 0h
    elf_machine_05 db "    Machine:              M88K          ",10, 0h
    elf_machine_06 db "    Machine:              INTEL MCU     ",10, 0h
    elf_machine_07 db "    Machine:              INTEL 80860   ",10, 0h
    elf_machine_08 db "    Machine:              MIPS          ",10, 0h
    elf_machine_09 db "    Machine:              IBM SYSTEM/370",10, 0h
    elf_machine_0A db "    Machine:              MIPS RS 3000  ",10, 0h
    elf_machine_13 db "    Machine:              INTEL 80960   ",10, 0h
    elf_machine_17 db "    Machine:              IBM SPU/SPC   ",10, 0h    
    elf_machine_28 db "    Machine:              ARM           ",10, 0h
    elf_machine_3E db "    Machine:              AMD X86-64    ",10, 0h
    elf_machine_B7 db "    Machine:              ARM 64-BITS   ",10, 0h
    elf_machine_F3 db "    Machine:              RISC-V        ",10, 0h
    
    elf_machine_msg dd elf_machine_00,elf_machine_01 , elf_machine_02 , elf_machine_03 , elf_machine_04 , elf_machine_05 , elf_machine_06 , elf_machine_07 , elf_machine_08 , elf_machine_09 , 0x9 dup(elf_machine_0A), 0x4 dup(elf_machine_13),0x11 dup(elf_machine_17),0x16 dup(elf_machine_28),0x79 dup(elf_machine_3E),0x3C dup(elf_machine_B7),0xE dup(elf_machine_F3)

    elf_machine dd 0
 ; ELF Version
    elf_version2_msg db "    Version:              0x1", 10, 0h
    elf_version2_msg_len equ $-elf_version2_msg 
 ; ELF Entry
    elf_entry_msg    db "    Entry point address:  0x", 0h
    elf_entry_msg_len equ $-elf_entry_msg   
  
  ;; ELF Program Offset
    elf_phoff_msg db "    Start of program headers:          ", 0h
    elf_phoff_msg_len equ $-elf_phoff_msg
    elf_phoff dd 1
        
    bytes_into_file_msg db " (bytes into file)", 0Ah
    bytes_into_file_msg_len equ $-bytes_into_file_msg
  
  ; ELF Section Offset
    elf_shoff_msg db "    Start of section headers:          ", 0h
    elf_shoff_msg_len equ $-elf_shoff_msg
    elf_shoff dd 1  
   
   ; ELF Flags
    elf_sh_flags_msg db "    Flags:                             0x", 0h
    elf_sh_flags_msg_len equ $-elf_sh_flags_msg

    ; ELF Header Size
    elf_ehsize_msg db "    Size of this header:               ", 0h
    elf_ehsize_msg_len equ $-elf_ehsize_msg
    bytes_msg db " (bytes)", 0Ah
    bytes_msg_len equ $-bytes_msg

    ; ELF Program Header Size
    elf_phentsize_msg db "    Size of program header:            ", 0h
    elf_phentsize_msg_len equ $-elf_phentsize_msg
    elf_phentsize dd 1

    ; Number of Program Header Size
    elf_phnum_msg db "    Number of program header:          ", 0h
    elf_phnum_msg_len equ $-elf_phnum_msg
    elf_phnum dd 1

    ; Size of Section Header
    elf_shentsize_msg db "    Size of section headers:           ", 0h
    elf_shentsize_msg_len equ $-elf_shentsize_msg
    elf_shentsize dd 1
    ; Number of Section Header
    elf_shnum_msg db "    Number of section headers:         ", 0h
    elf_shnum_msg_len equ $-elf_shnum_msg
    elf_shnum dd 1

    ; Index of Section Header Tbable index
    elf_shstrndx_msg db "    Section header string table index: ", 0h
    elf_shstrndx_msg_len equ $-elf_shstrndx_msg
    elf_shstrndx dd 1
     
     
     
    ; Section Header msgs
    sectionHeader_msg db 0Ah, "Section Headers:", 0Ah, 0h
    sectionHeader_msg_len equ $-sectionHeader_msg
    open_square_bracket db "[ ", 0h
    open_square_bracket_len equ $-open_square_bracket
    name_msg db " ] Name: ", 0h
    name_msg_len equ $-name_msg
    ; sh_type
    sh_type_msg_00 db "       Type: NULL           ", 0Ah, 0h
    sh_type_msg_len equ $-sh_type_msg_00
    sh_type_msg_01 db "       Type: PROGBITS       ", 0Ah, 0h
    sh_type_msg_02 db "       Type: SYMTAB         ", 0Ah, 0h
    sh_type_msg_03 db "       Type: STRTAB         ", 0Ah, 0h
    sh_type_msg_04 db "       Type: RELA           ", 0Ah, 0h
    sh_type_msg_05 db "       Type: HASH           ", 0Ah, 0h
    sh_type_msg_06 db "       Type: DYNAMIC        ", 0Ah, 0h
    sh_type_msg_07 db "       Type: NOTE           ", 0Ah, 0h
    sh_type_msg_08 db "       Type: NOBITS         ", 0Ah, 0h
    sh_type_msg_09 db "       Type: REL            ", 0Ah, 0h
    sh_type_msg_0A db "       Type: SHLIB          ", 0Ah, 0h
    sh_type_msg_0B db "       Type: DYNSYM         ", 0Ah, 0h
    sh_type_msg_0E db "       Type: INIT_ARRAY     ", 0Ah, 0h
    sh_type_msg_0F db "       Type: FINI_ARRAY     ", 0Ah, 0h
    sh_type_msg_10 db "       Type: PREINIT_ARRAY  ", 0Ah, 0h
    sh_type_msg_11 db "       Type: GROUP          ", 0Ah, 0h
    sh_type_msg_12 db "       Type: SYMTAB_SHNDX   ", 0Ah, 0h
    sh_type_msg_13 db "       Type: NUM            ", 0Ah, 0h
    sh_type_msg dd   sh_type_msg_00 , sh_type_msg_01 , sh_type_msg_02 , sh_type_msg_03 , sh_type_msg_04 , sh_type_msg_05 , sh_type_msg_06 , sh_type_msg_07 , sh_type_msg_08 , sh_type_msg_09 , sh_type_msg_0A , sh_type_msg_0B , sh_type_msg_0E , sh_type_msg_0F , sh_type_msg_10 , sh_type_msg_11 , sh_type_msg_12 , sh_type_msg_13
   
    NameSection_offset dd 0
    NameSection_virtOffset dd 0
    cur_offset dd 0  
    
    count dd 1
    count2 dd 1  
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
    mov [elf_arch], eax    
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
 
    ;;read ABI version print value Hex
    
    mov eax, 3
    mov ebx, eax
    mov ecx, BytesBuffer
    mov edx, 1           ; so byte doc
    int 80h              ; doc file
    
    lea edi, [tmp_string]
    mov ecx, 1
    movzx eax, word [BytesBuffer]
    mov [elf_ABIver], eax
    call print_string      ;in byte vua doc
    call printSpace
    
    ;  e_ident[EI_PAD]	print value Hex
    mov edx,7
    lap7:
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
    jne lap7
    
    ;; read EI_TYPE
    mov eax, 3
    mov ebx, eax
    mov ecx, BytesBuffer
    mov edx, 2
    int 80h

    movzx eax, word [BytesBuffer]
    mov [elf_type], eax

    ;; read machine
    mov eax, 3
    mov ebx, eax
    mov ecx, BytesBuffer
    mov edx, 2
    int 80h

    movzx eax, word [BytesBuffer]
    mov [elf_machine], eax
    
    ;; read VERSION
    mov eax, 3
    mov ebx, eax
    mov ecx, BytesBuffer
    mov edx, 4
    int 80h

    
    
        
    
    
    call newLine
    ;   print ELF Class
    mov eax, dword [elf_arch]
    dec eax
    mov edx, elf_class_msg
    mov ecx, [eax*4 + edx]
    mov edx, elf_class_msg_len
    call print
    
    ;   print ELF data
    mov eax, dword [elf_data]
    dec eax
    mov edx, elf_data_msg
    mov ecx, [eax*4 + edx]
    mov edx, elf_data_msg_len
    call print

    ;   print ELF version
    mov ecx, elf_version_msg
    mov edx, elf_version_msg_len
    call print
     
        ;   print ELF OS/ABI
    mov eax, dword [elf_OsAbi]
    mov edx, OsAbi_msg
    mov ecx, [eax*4 + edx]
    mov edx, OsAbi_msg_len
    call print  

    ;   print ELF ABI Version
    mov ecx, elf_ABIver_msg
    mov edx, elf_ABIver_msg_len
    call print
  
    movzx eax, word [elf_ABIver]
    mov esi, tmp_string1
    call itoa
    mov ecx, eax
    mov edx, 2
    call print
    call newLine 
    ;   print ELF Type
    mov eax, [elf_type]
    mov ecx, [elf_type_msg + 4* eax]
    mov edx, elf_type_msg_len
    call print
 

     ;   print ELF machine
    mov eax, [elf_machine]
    mov ecx, [elf_machine_msg + 4* eax]
    mov edx, elf_machine_msg_len
    call print

    
    ;   print ELF version
    mov ecx, elf_version2_msg
    mov edx, elf_version2_msg_len
    call print
    
    ;   print ELF Entry
    mov ecx, elf_entry_msg
    mov edx, elf_entry_msg_len
    call print
    
    mov edx, [elf_arch]
    shl edx, 2             ; edx = 4 if e_arch = 1
                                    ; edx = 8 if e_arch = 2                             
    mov eax, 3
    mov ebx, eax
    mov ecx, BytesBuffer
    int 80h

    mov eax, dword [BytesBuffer]
    mov ecx, 4
    lea edi, [tmp_string]
    call print_string
    call newLine
    
    ;   print ELF Program Header 
    
    mov ecx, elf_phoff_msg
    mov edx, elf_phoff_msg_len
    call print

    mov edx, [elf_arch]
    shl edx, 2                
    mov eax,3
    mov ebx, eax
    mov ecx, BytesBuffer
    int 80h

    mov eax, dword [BytesBuffer]
    mov [elf_phoff], eax
    lea esi, [tmp_string]
    call itoa
    mov ecx, eax
    mov edx, 10
    call print

    mov ecx, bytes_into_file_msg
    mov edx, bytes_into_file_msg_len
    call print

    ;   print ELF Section Header 
    
    mov ecx, elf_shoff_msg
    mov edx, elf_shoff_msg_len
    call print

    mov edx, [elf_arch]
    shl edx, 2                
    mov eax,3
    mov ebx, eax
    mov ecx, BytesBuffer
    int 80h

    mov eax, dword [BytesBuffer]
    mov [elf_shoff], eax
    lea esi, [tmp_string]
    call itoa
    mov ecx, eax
    mov edx, 10
    call print

    mov ecx, bytes_into_file_msg
    mov edx, bytes_into_file_msg_len
    call print
    
    ;   print  Flags
    mov ecx, elf_sh_flags_msg
    mov edx, elf_sh_flags_msg_len
    call print 

    mov eax, 3
    mov ebx, eax
    mov ecx, BytesBuffer
    mov edx, 4
    int 80h

    mov eax, dword [BytesBuffer]
    lea edi, [tmp_string]
    mov ecx, 4
    call print_string
    call newLine
    
    ;   print size of this header
    mov ecx, elf_ehsize_msg
    mov edx, elf_ehsize_msg_len
    call print 

    mov eax, 3
    mov ebx, eax
    mov ecx, BytesBuffer
    mov edx, 2
    int 80h

    movzx eax, word [BytesBuffer]
    lea esi, [tmp_string]
    call itoa
    mov ecx, eax
    mov edx, 10
    call print
    
    mov ecx, bytes_msg
    mov edx, bytes_msg_len
    call print

    ;   print size of program header
    mov ecx, elf_phentsize_msg
    mov edx, elf_phentsize_msg_len
    call print 

    mov eax, 3
    mov ebx, eax
    mov ecx, BytesBuffer
    mov edx, 2
    int 80h

    movzx eax, word [BytesBuffer]
    mov [elf_phentsize], eax
    lea esi, [tmp_string]
    call itoa
    mov ecx, eax
    mov edx, 10
    call print
    
    mov ecx, bytes_msg
    mov edx, bytes_msg_len
    call print

    ;print number of program header
    mov ecx, elf_phnum_msg
    mov edx, elf_phnum_msg_len
    call print 

    mov eax, 3
    mov ebx, eax
    mov ecx, BytesBuffer
    mov edx, 2
    int 80h

    movzx eax, word [BytesBuffer]
    mov [elf_phnum], eax
    lea esi, [tmp_string]
    call itoa
    mov ecx, eax
    mov edx, 10
    call print
    call newLine
    ;   print Size of Section Header
    mov ecx, elf_shentsize_msg
    mov edx, elf_shentsize_msg_len
    call print 

    mov eax, 3
    mov ebx, eax
    mov ecx, BytesBuffer
    mov edx, 2
    int 80h

    movzx eax, word [BytesBuffer]
    mov [elf_shentsize], eax
    lea esi, [tmp_string]
    call itoa
    mov ecx, eax
    mov edx, 10
    call print
    
    mov ecx, bytes_msg
    mov edx, bytes_msg_len
    call print

    
    ;   print Number of Section Headers
    mov ecx, elf_shnum_msg
    mov edx, elf_shnum_msg_len
    call print 

    mov eax, 3
    mov ebx, eax
    mov ecx, BytesBuffer
    mov edx, 2
    int 80h

    movzx eax, word [BytesBuffer]
    mov [elf_shnum], eax
    lea esi, [tmp_string]
    call itoa
    mov ecx, eax
    mov edx, 10
    call print
    call newLine

    ;   print table index
    mov ecx, elf_shstrndx_msg
    mov edx, elf_shstrndx_msg_len
    call print 

    mov eax, 3
    mov ebx, eax
    mov ecx, BytesBuffer
    mov edx, 2
    int 80h




    ;; Section Header print
    movzx eax, word [BytesBuffer]
    mov [elf_shstrndx], eax
    lea esi, [tmp_string]
    call itoa
    mov ecx, eax
    mov edx, 10
    call print
    call newLine

    ;; Section Header members print
    mov ecx, sectionHeader_msg
    mov edx, sectionHeader_msg_len
    call print 

    mov eax, dword [elf_shentsize]
    mov ebx, dword [elf_shstrndx]
    imul eax, ebx
    mov ebx, dword [elf_shoff]
    add eax, ebx
    add eax,0x28
    mov [NameSection_virtOffset], eax
    
    mov eax, dword [elf_shoff]
    mov [cur_offset], eax

    
    mov ebx, [handle]
    mov ecx, dword [NameSection_virtOffset]
    mov edx, 0
    mov eax, 19
    int 80h

    mov eax, 3
    mov ebx, eax
    mov ecx, BytesBuffer
    mov edx, 4
    int 80h
    
    test:
     movzx eax, word [BytesBuffer]
    mov [NameSection_offset], eax
    mov edx, 10
    mov ecx,[NameSection_offset]
    call print_name_in_Section_Header
    
   


call    quit                ; call our quit function



 ;; print name in Section Header
    ;; Input: ecx - offset in file
    print_name_in_Section_Header:
        mov ebx, [handle]
        mov edx, 0
        mov eax, 19
        int 80h

        loop_print_name:

            mov eax, 3
            mov ebx, eax
            mov ecx, singleByte
            mov edx, 1
            int 80h

            cmp byte [singleByte], 0h
            je .done

            mov edi, tmp_string
            mov ah, byte [singleByte]
            mov byte [edi], ah
            inc edi
            mov byte [edi], 0h
            
            mov ecx, tmp_string
            mov edx, 1
            call print 
            jmp loop_print_name
        .done:
            ret

newLine:
    mov edx,2
    mov ecx, newline
    mov ebx,1
    mov eax,4
    int 80h
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
        lea edi, [tmp_string]
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
    
    ;input ebx=offset input
;output eax
atoi :
      mov eax,0
      mov ecx,1
      .lap:
          movzx ecx, byte [ebx] ; ecx= input[ebx] 
          cmp   ecx,0
          je    .break
          cmp ecx,10
          je   .break
          
          sub  ecx, '0'
          lea eax, [eax*4+eax] ; eax= eax*5
          lea eax, [eax*2+ecx] ; eax= eax*5+ ecx
          inc ebx   ; ebx++
          jmp .lap 
          
      .break:    
          ret   



 ;input eax: int 
 ;out put eax dia chi cua xau sau khi chuyen
    itoa: 
        add esi, 32      ; point to the last of result buffer
        dec esi
        mov byte  [esi], 0h      ; set the last byte of result buffser to null
        mov ebx, 10             ; ebx = 10
    .lap:
        xor edx, edx            ; edx = 0
        div ebx                 ; divide eax by divisor ebx = 10
        add dl, '0'             ; dl - remainder
        dec esi                 ; point to the next left byte 
        mov [esi], dl           ; mov remainder to the current byte
        test eax, eax           ; if (eax == 0) ?
        jnz .lap                ; if not -> loop
        mov eax, esi            ; else return result to eax
        ret      

    
 ;esi offset string
printString:
     push eax
     push ebx
     push ecx
     push edx

     mov esi, esi
     call strlen
     mov edx, eax
     call print
     
     call newLine
     
     pop edx
     pop ecx
     pop ebx
     pop eax
     ret
     
 ;input esi string
;output eax: length 
strlen:
      push esi
      push ecx
      mov eax,0
      .lap: 
           movzx ecx, byte [esi]
           cmp ecx, 0
           je .break
           cmp ecx, 10
           je .break
           inc eax
           inc esi
           jmp .lap
       .break:
       pop esi
       pop ecx
       ret          
