
SECTION .data
filename db 'add', 0h    ; the filename to create
filePath_msg db 'filePath:    ',0h 
 filePath_msg_len 	equ $-filePath_msg
 handle dd 0
newline  db 10,0
lpHexString	db "0123456789ABCDEF"
space   db " ",0h
singleByte db 0

e_header      		db "ELF Header:", 0Ah, "    Magic: ", 0h
e_header_len 			equ $-e_header

; ELF Header Members msgs
    e_class_32b 	db "    Class:                ELF32",10, 0h
    e_class_msg_len 				equ $-e_class_32b
    e_class_64b 	db "    Class:                ELF64",10, 0h
    e_class_msg 	dd e_class_32b, e_class_64b
    e_arch           dd 1 

 ; ELF Data
    e_data_32b  	db "    Data:                 2's complement, little endian",10, 0h
    e_data_msg_len 				equ $-e_data_32b
    e_data_64b  	db "    Data:                 2's complement, big endian   ",10, 0h
    e_data_msg  	dd e_data_32b, e_data_64b
    e_data            dd 1
  ; ELF Version
    e_version_msg 	db "    Version:              1 (current)",10, 0h
    e_version_msg_len 			equ $-e_version_msg


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
    e_OsAbi   dd 1
    
; ELF ABI Version
    e_ABIver_msg db "    ABI Version:         ", 0h
    e_ABIver_msg_len 				equ $-e_ABIver_msg    
    e_ABIver dd 0
; ELF Type
    e_type_00 db "    Type:                 NONE ",10, 0h
    e_type_msg_len equ $-e_type_00
    e_type_01 db "    Type:                 REL  ",10, 0h
    e_type_02 db "    Type:                 EXEC ",10, 0h
    e_type_03 db "    Type:                 DYN  ",10, 0h
    e_type_04 db "    Type:                 CORE ",10, 0h 
    e_type_FE00 db "    Type:               LOOS ",10, 0h   
    
    e_type_msg dd e_type_00, e_type_01, e_type_02, e_type_03, 0xFEFC dup(e_type_04) , 0xFF dup(e_type_FE00) 
    e_type dd 0
 

; ELF Machine
    e_machine_00 db "    Machine:              Null          ",10, 0h
    e_machine_01 db "    Machine:              AT&T WE 32100 ",10, 0h
    e_machine_msg_len equ $-e_machine_01
    e_machine_02 db "    Machine:              SPARC         ",10, 0h
    e_machine_03 db "    Machine:              Intel 80386   ",10, 0h
    e_machine_04 db "    Machine:              M68k          ",10, 0h
    e_machine_05 db "    Machine:              M88K          ",10, 0h
    e_machine_06 db "    Machine:              INTEL MCU     ",10, 0h
    e_machine_07 db "    Machine:              INTEL 80860   ",10, 0h
    e_machine_08 db "    Machine:              MIPS          ",10, 0h
    e_machine_09 db "    Machine:              IBM SYSTEM/370",10, 0h
    e_machine_0A db "    Machine:              MIPS RS 3000  ",10, 0h
    e_machine_13 db "    Machine:              INTEL 80960   ",10, 0h
    e_machine_17 db "    Machine:              IBM SPU/SPC   ",10, 0h    
    e_machine_28 db "    Machine:              ARM           ",10, 0h
    e_machine_3E db "    Machine:              AMD X86-64    ",10, 0h
    e_machine_B7 db "    Machine:              ARM 64-BITS   ",10, 0h
    e_machine_F3 db "    Machine:              RISC-V        ",10, 0h
    
    e_machine_msg dd e_machine_00,e_machine_01 , e_machine_02 , e_machine_03 , e_machine_04 , e_machine_05 , e_machine_06 , e_machine_07 , e_machine_08 , e_machine_09 , 0x9 dup(e_machine_0A), 0x4 dup(e_machine_13),0x11 dup(e_machine_17),0x16 dup(e_machine_28),0x79 dup(e_machine_3E),0x3C dup(e_machine_B7),0xE dup(e_machine_F3)

    e_machine dd 0
 ; ELF Version
    e_version2_msg db "    Version:              0x1", 10, 0h
    e_version2_msg_len equ $-e_version2_msg 
 ; ELF Entry
    e_entry_msg    db "    Entry point address:  0x", 0h
    e_entry_msg_len equ $-e_entry_msg   
  
  ;; ELF Program Offset
    e_phoff_msg db "    Start of program headers:          ", 0h
    e_phoff_msg_len equ $-e_phoff_msg
    e_phoff dd 1
        
    bytes_into_file_msg db " (bytes into file)", 0Ah
    bytes_into_file_msg_len equ $-bytes_into_file_msg
  
  ; ELF Section Offset
    e_shoff_msg db "    Start of section headers:          ", 0h
    e_shoff_msg_len equ $-e_shoff_msg
    e_shoff dd 1  
   
   ; ELF Flags
    e_sh_flags_msg db "    Flags:                             0x", 0h
    e_sh_flags_msg_len equ $-e_sh_flags_msg

    ; ELF Header Size
    e_ehsize_msg db "    Size of this header:               ", 0h
    e_ehsize_msg_len equ $-e_ehsize_msg
    bytes_msg db " (bytes)", 0Ah
    bytes_msg_len equ $-bytes_msg

    ; ELF Program Header Size
    e_phentsize_msg db "    Size of program header:            ", 0h
    e_phentsize_msg_len equ $-e_phentsize_msg
    e_phentsize dd 1

    ; Number of Program Header Size
    e_phnum_msg db "    Number of program header:          ", 0h
    e_phnum_msg_len equ $-e_phnum_msg
    e_phnum dd 1

    ; Size of Section Header
    e_shentsize_msg db "    Size of section headers:           ", 0h
    e_shentsize_msg_len equ $-e_shentsize_msg
    e_shentsize dd 1
    ; Number of Section Header
    e_shnum_msg db "    Number of section headers:         ", 0h
    e_shnum_msg_len equ $-e_shnum_msg
    e_shnum dd 1

    ; Index of Section Header Tbable index
    e_shstrndx_msg db "    Section header string table index: ", 0h
    e_shstrndx_msg_len equ $-e_shstrndx_msg
    e_shstrndx dd 1
     
     
    ;;;
    ;; Program Header msgs
    ph_msg db 0Ah, "Program Header:", 0Ah,"Type             Offset   virtaddr Physaddr  FileSiz  Mensiz  Flg  Align ",0Ah,0h
    ph_msg_len equ $-ph_msg
    
    
    ; p_type
    p_type_msg_00           db "  NULL          ",0h
    p_type_msg_len equ $-p_type_msg_00
    p_type_msg_01           db "  LOAD          ",0h
    p_type_msg_02           db "  DYNAMIC       ",0h
    p_type_msg_03           db "  INTERP        ",0h
    p_type_msg_04           db "  NOTE          ",0h
    p_type_msg_05           db "  SHLIB         ",0h
    p_type_msg_06           db "  PHDR          ",0h
    p_type_msg_07           db "  TLS           ",0h
    p_type_msg_60           db "  LOOS          ",0h
    p_type_msg_6f           db "  HIOS          ",0h
    p_type_msg_70           db "  LOPROC        ",0h
    p_type_msg_7f           db "  HIPROC        ",0h
  

    p_type_msg dd p_type_msg_00 , p_type_msg_01 , p_type_msg_02 , p_type_msg_03 , p_type_msg_04 , p_type_msg_05 , p_type_msg_06 , p_type_msg_07 ,0x59 dup(p_type_msg_60),0xf dup(p_type_msg_6f) , p_type_msg_70 ,0xf dup(p_type_msg_7f)  
    
    ; p_flags
    p_flags_msg_01 db "  E", 0h
    p_flags_msg_len equ $-p_flags_msg_01
    p_flags_msg_02 db " w ",0h
    p_flags_msg_04 db "R  ",0h
    p_flags_msg_03 db " WE", 0h
    p_flags_msg_06 db "RW ",0h
    p_flags_msg_05 db "R E",0h
    p_flags_msg_07 db "RWE",0h
    p_flags_msg dd p_flags_msg_01 , p_flags_msg_02 ,p_flags_msg_04 , p_flags_msg_03 ,p_flags_msg_06 , p_flags_msg_05 , p_flags_msg_07 
    p_flags dd 1
    
     
     
     
     
     
    ; Section Header msgs
    sectionHeader_msg db 0Ah, "Section Headers:", 0Ah,"Name            Type           Addr      Off      Size     Lk Info Al ES", 0Ah,0h
    sectionHeader_msg_len equ $-sectionHeader_msg
    open_square_bracket db "[ ", 0h
    open_square_bracket_len equ $-open_square_bracket
    name_msg db " ] Name: ", 0h
    name_msg_len equ $-name_msg
    
    ; sh_type
    sh_type_msg_00 db "NULL           ", 0h
    sh_type_msg_len equ $-sh_type_msg_00
    sh_type_msg_01 db "PROGBITS       ", 0h
    sh_type_msg_02 db "SYMTAB         ", 0h
    sh_type_msg_03 db "STRTAB         ", 0h
    sh_type_msg_04 db "RELA           ", 0h
    sh_type_msg_05 db "HASH           ", 0h
    sh_type_msg_06 db "DYNAMIC        ", 0h
    sh_type_msg_07 db "NOTE           ", 0h
    sh_type_msg_08 db "NOBITS         ", 0h
    sh_type_msg_09 db "REL            ", 0h
    sh_type_msg_0A db "SHLIB          ", 0h
    sh_type_msg_0B db "DYNSYM         ", 0h
    sh_type_msg_0E db "INIT_ARRAY     ", 0h
    sh_type_msg_0F db "FINI_ARRAY     ", 0h
    sh_type_msg_10 db "PREINIT_ARRAY  ", 0h
    sh_type_msg_11 db "GROUP          ", 0h
    sh_type_msg_12 db "SYMTAB_SHNDX   ", 0h
    sh_type_msg_13 db "NUM            ", 0h
    sh_type_msg_14 db "LOOS           ", 0h
    sh_type_msg dd   sh_type_msg_00 , sh_type_msg_01 , sh_type_msg_02 , sh_type_msg_03 , sh_type_msg_04 , sh_type_msg_05 , sh_type_msg_06 , sh_type_msg_07 , sh_type_msg_08 , sh_type_msg_09 , sh_type_msg_0A , 0x3 dup(sh_type_msg_0B) , sh_type_msg_0E , sh_type_msg_0F , sh_type_msg_10 , sh_type_msg_11 , sh_type_msg_12 , sh_type_msg_13,sh_type_msg_14
    sh_type dd 1
    
    sh_flags_msg_00 db "N",  0h
    sh_flags_msg_len equ $-sh_flags_msg_00
    sh_flags_msg_01 db "W",  0h
    sh_flags_msg_02 db "A",  0h
    sh_flags_msg_04 db "X",  0h
    sh_flags_msg_10 db "M",  0h
    sh_flags_msg_20 db "S",  0h
    sh_flags_msg_40 db "I",  0h
    sh_flags_msg_80 db "L",  0h
    sh_flags_msg_100 db " ",  0h
    sh_flags_msg_200 db "G",  0h
    sh_flags_msg_400 db "T",  0h
    sh_flags_msg dd sh_flags_msg_400,sh_flags_msg_200, sh_flags_msg_100, sh_flags_msg_80, sh_flags_msg_40, sh_flags_msg_20, sh_flags_msg_10, sh_flags_msg_04, sh_flags_msg_02, sh_flags_msg_01
    sh_flags_value_list dd 0x400,0x200, 0x100, 0x80, 0x40, 0x20, 0x10, 0x04, 0x02, 0x01
    
    
    NameSection_offset dd 0
    NameSection_virtOffset dd 0
    cur_offset dd 0  
    
    count dd 1
    count2 dd 1
    
    ph_vaddr_array times 200 dd 1
    ph_vaddr_plus_size_array times 200 dd 1  
SECTION .bss
fileInput    resb 255,          ; variable to store file contents
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
    mov edx,filePath_msg_len
    mov ecx,filePath_msg
    mov ebx,1
    mov eax,4
    int 80h 
    
    mov edx, 256
    mov ecx, fileInput
    mov ebx, 0
    mov eax, 3
    int 80h             

    mov esi, fileInput
    call convertInput

    mov     edx, 0777
    mov     ecx, 0              ; Open file 
    mov     ebx, fileInput
    mov     eax, 5
    int     80h
    mov [handle], eax
    
    mov ecx, e_header
    mov edx, e_header_len
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
    mov [e_arch], eax    
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
    mov [e_data], eax    
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
    mov [e_OsAbi], eax
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
    mov [e_ABIver], eax
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

    mov eax, [BytesBuffer]
    mov [e_type], eax

    ;; read machine
    mov eax, 3
    mov ebx, eax
    mov ecx, BytesBuffer
    mov edx, 2
    int 80h

    mov eax, [BytesBuffer]
    mov [e_machine], eax
    
    ;; read VERSION
    mov eax, 3
    mov ebx, eax
    mov ecx, BytesBuffer
    mov edx, 4
    int 80h

    
    
        
    
    
    call newLine
    ;   print ELF Class
    mov eax, dword [e_arch]
    dec eax
    mov edx, e_class_msg
    mov ecx, [eax*4 + edx]
    mov edx, e_class_msg_len
    call print
    
    ;   print ELF data
    mov eax, dword [e_data]
    dec eax
    mov edx, e_data_msg
    mov ecx, [eax*4 + edx]
    mov edx, e_data_msg_len
    call print

    ;   print ELF version
    mov ecx, e_version_msg
    mov edx, e_version_msg_len
    call print
     
        ;   print ELF OS/ABI
    mov eax, dword [e_OsAbi]
    mov edx, OsAbi_msg
    mov ecx, [eax*4 + edx]
    mov edx, OsAbi_msg_len
    call print  

    ;   print ELF ABI Version
    mov ecx, e_ABIver_msg
    mov edx, e_ABIver_msg_len
    call print
  
    movzx eax, word [e_ABIver]
    mov esi, tmp_string1
    call itoa
    mov ecx, eax
    mov edx, 2
    call print
    call newLine 
    ;   print ELF Type
    mov eax, [e_type]
    mov ecx, [e_type_msg + 4* eax]
    mov edx, e_type_msg_len
    call print
 

     ;   print ELF machine
    mov eax, [e_machine]
    mov ecx, [e_machine_msg + 4* eax]
    mov edx, e_machine_msg_len
    call print

    
    ;   print ELF version
    mov ecx, e_version2_msg
    mov edx, e_version2_msg_len
    call print
    
    ;   print ELF Entry
    mov ecx, e_entry_msg
    mov edx, e_entry_msg_len
    call print
    
    mov edx, [e_arch]
    shl edx, 2             ; edx= e_arch*4                              
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
    
    mov ecx, e_phoff_msg
    mov edx, e_phoff_msg_len
    call print

    mov edx, [e_arch]
    shl edx, 2                
    mov eax,3
    mov ebx, eax
    mov ecx, BytesBuffer
    int 80h

    mov eax, dword [BytesBuffer]
    mov [e_phoff], eax
    lea esi, [tmp_string]
    call itoa
    mov ecx, eax
    mov edx, 10
    call print

    mov ecx, bytes_into_file_msg
    mov edx, bytes_into_file_msg_len
    call print






    ;   print ELF Section Header 
    
    mov ecx, e_shoff_msg
    mov edx, e_shoff_msg_len
    call print

    mov edx, [e_arch]
    shl edx, 2                
    mov eax,3
    mov ebx, eax
    mov ecx, BytesBuffer
    int 80h

    mov eax, dword [BytesBuffer]
    mov [e_shoff], eax
    lea esi, [tmp_string]
    call itoa
    mov ecx, eax
    mov edx, 10
    call print

    mov ecx, bytes_into_file_msg
    mov edx, bytes_into_file_msg_len
    call print
    
    ;   print  Flags
    mov ecx, e_sh_flags_msg
    mov edx, e_sh_flags_msg_len
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
    mov ecx, e_ehsize_msg
    mov edx, e_ehsize_msg_len
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
    mov ecx, e_phentsize_msg
    mov edx, e_phentsize_msg_len
    call print 

    mov eax, 3
    mov ebx, eax
    mov ecx, BytesBuffer
    mov edx, 2
    int 80h

    movzx eax, word [BytesBuffer]
    mov [e_phentsize], eax
    lea esi, [tmp_string]
    call itoa
    mov ecx, eax
    mov edx, 10
    call print
    
    mov ecx, bytes_msg
    mov edx, bytes_msg_len
    call print

    ;print number of program header
    mov ecx, e_phnum_msg
    mov edx, e_phnum_msg_len
    call print 

    mov eax, 3
    mov ebx, eax
    mov ecx, BytesBuffer
    mov edx, 2
    int 80h

    movzx eax, word [BytesBuffer]
    mov [e_phnum], eax
    lea esi, [tmp_string]
    call itoa
    mov ecx, eax
    mov edx, 10
    call print
    call newLine
    ;   print Size of Section Header
    mov ecx, e_shentsize_msg
    mov edx, e_shentsize_msg_len
    call print 

    mov eax, 3
    mov ebx, eax
    mov ecx, BytesBuffer
    mov edx, 2
    int 80h

    movzx eax, word [BytesBuffer]
    mov [e_shentsize], eax
    lea esi, [tmp_string]
    call itoa
    mov ecx, eax
    mov edx, 10
    call print
    
    mov ecx, bytes_msg
    mov edx, bytes_msg_len
    call print

    
    ;   print Number of Section Headers
    mov ecx, e_shnum_msg
    mov edx, e_shnum_msg_len
    call print 

    mov eax, 3
    mov ebx, eax
    mov ecx, BytesBuffer
    mov edx, 2
    int 80h

    movzx eax, word [BytesBuffer]
    mov [e_shnum], eax
    lea esi, [tmp_string]
    call itoa
    mov ecx, eax
    mov edx, 10
    call print
    call newLine

    ;   print table index
    mov ecx, e_shstrndx_msg
    mov edx, e_shstrndx_msg_len
    call print 

    mov eax, 3
    mov ebx, eax
    mov ecx, BytesBuffer
    mov edx, 2
    int 80h
    
    movzx eax, word [BytesBuffer]
    mov [e_shstrndx], eax
    lea esi, [tmp_string]
    call itoa
    mov ecx, eax
    mov edx, 10
    call print
    call newLine

  



   
   
   
   
   
   
   
   


    ;;;program header   
    mov ecx, ph_msg
    mov edx, ph_msg_len
    call print

    mov eax,  [e_phoff]
    mov [cur_offset], eax

   ; point to Program Header 

    mov ebx, [handle]
    movzx ecx, word [cur_offset]
    mov edx, 0
    mov eax, 19
    int 80h

    mov dword [count], 0h
    loop_p_print:

    mov eax, dword [e_phnum]
    ;dec eax
   cmp dword [count], eax
    je done_p_print

   ;   print each member

       add dword [count], 1

        ; print p_type
        mov eax, 3
        mov ebx, eax
        mov ecx, BytesBuffer
        mov edx, 4
        int 80h        

        mov eax, [BytesBuffer]
        cmp eax, 8
        
        jl breakDiv
        mov edx,0
        mov ecx, 0x1000000  ;; neu p_type > 8 thi chia cho 100000 de dua ve so nho
        idiv ecx
        
        breakDiv:
        shl eax,2
        mov ecx, [p_type_msg+eax]
        mov edx, p_type_msg_len
        call print
        
        call printSpace
             
       ; save p_flags if 64bit
        mov edx, dword [e_arch]
        dec edx
        lea edx, [edx * 4]
        mov eax, 3
        mov ebx, eax
        mov ecx, BytesBuffer
        int 80h

        cmp dword [e_arch], 0x2
        jne .not_64
        movzx eax, word [BytesBuffer]
        mov [p_flags], eax
        .not_64:
        
        ; print p_offset
        mov edx, dword [e_arch]
        lea edx, [edx * 4]
        mov eax, 3
        mov ebx, eax
        mov ecx, BytesBuffer
        int 80h


        mov eax, dword [BytesBuffer]
        lea edi, [tmp_string]
        mov ecx, 4
        call print_string
        call printSpace
        
        ; print p_vaddr
        mov edx, dword [e_arch]
        lea edx, [edx * 4]
        mov eax, 3
        mov ebx, eax
        mov ecx, BytesBuffer
        int 80h


        mov eax, dword [BytesBuffer]
        mov ebx, dword [count]
        dec ebx
        mov dword [ph_vaddr_array + ebx * 4], eax
        lea edi, [tmp_string]
        mov ecx, 4
        call print_string
        call printSpace
        
        
       ; print p_paddr
        mov edx, dword [e_arch]
        lea edx, [edx * 4]
        mov eax, 3
        mov ebx, eax
        mov ecx, BytesBuffer
        int 80h


        mov eax, dword [BytesBuffer]
        lea edi, [tmp_string]
        mov ecx, 4
        call print_string
        call printSpace
     
       ; print p_filesz
        mov edx, dword [e_arch]
        lea edx, [edx * 4]
        mov eax, 3
        mov ebx, eax
        mov ecx, BytesBuffer
        int 80h



        mov eax, dword [BytesBuffer]
        lea edi, [tmp_string]
        mov ecx, 4
        call print_string
        call printSpace

        ; print p_memsz
        mov edx, dword [e_arch]
        lea edx, [edx * 4]
        mov eax, 3
        mov ebx, eax
        mov ecx, BytesBuffer
        int 80h

 

        mov eax, dword [BytesBuffer]
        mov ebx, dword [count]
        dec ebx
        mov ecx, dword [ph_vaddr_array + ebx * 4]
        add eax, ecx
        mov dword [ph_vaddr_plus_size_array + ebx * 4], eax
        mov eax, dword [BytesBuffer]
        lea edi, [tmp_string]
        mov ecx, 4
        call print_string
        call printSpace
        
        ; print p_flags
        ; get p_flags if 32bit
        mov edx, dword [e_arch]
        and edx, 1
        lea edx, [edx * 4]
        mov eax, 3
        mov ebx, eax
        mov ecx, BytesBuffer
        int 80h
        
        cmp dword [e_arch], 0x1
        jne not_32
        movzx eax, word [BytesBuffer]
        mov [p_flags], eax
        not_32:

        mov eax, [p_flags]
        shl eax,2
        mov ecx, [p_flags_msg+eax]
        mov edx, p_flags_msg_len
        call print
        call printSpace
        ; print p_Align
        mov edx, dword [e_arch]
        lea edx, [edx * 4]
        mov eax, 3
        mov ebx, eax
        mov ecx, BytesBuffer
        int 80h

        mov eax, dword [BytesBuffer]
        lea edi, [tmp_string]
        mov ecx, 4
        call print_string
        
        call newLine
        jmp loop_p_print
    done_p_print:
  
  
  
  
  
    ;;print section header  
    ;; con thieu  e flag
    mov ecx, sectionHeader_msg
    mov edx,sectionHeader_msg_len
    call print
    
    mov eax,  [e_shentsize]
    mov ebx,  [e_shstrndx]
    imul eax, ebx
    add eax,  [e_shoff]
    
    mov ecx,2
    cmp ecx, dword [e_arch]
    je _64bit
    _32bit:
    add eax, 0x10
    jmp _breakbit
    _64bit:
    add eax,0x18
    
    _breakbit:
    mov [NameSection_virtOffset], eax   
    
    mov ebx, [handle]
    mov ecx, dword [NameSection_virtOffset]
    mov edx, 0
    mov eax, 19
    int 80h   

    mov eax, 3
    mov ebx, eax
    mov ecx, BytesBuffer
    mov edx, 2
    int 80h
    
    
    
    
    ;; print section header  con thieu flag
    mov eax,  [BytesBuffer]
    mov [NameSection_offset], eax   ; offset .shstrtab
    
    mov eax, [e_shoff]
    mov [cur_offset], eax
    
    mov edx,0 ; den so section dc in
    push edx
    _lapSectionHeader:
    pop edx
    cmp edx,[e_shnum]
    je _breakSectionHeader
    inc edx
    push edx
    
    
    mov ebx, [handle]
    mov ecx, dword [cur_offset]
    mov edx, 0
    mov eax, 19
    int 80h
    
    mov ecx, sectionHeader_msg
    mov edx, sectionHeader_msg_len
    
    ; print name
        mov eax, 3
        mov ebx, eax
        mov ecx, BytesBuffer
        mov edx, 4
        int 80h
        
        mov ecx,  [BytesBuffer]
        add ecx,  [NameSection_offset]

    call print_name_in_Section_Header
        
        mov ebx, [handle]
        mov ecx, dword [cur_offset]
        add ecx, 4
        mov edx, 0
        mov eax, 19
        int 80h
    
    call printSpace
    ;print type 
 
        mov eax, 3
        mov ebx, eax
        mov ecx, BytesBuffer
        mov edx, 4
        int 80h
        
        mov eax, [BytesBuffer]
        shl eax,2
        mov ecx, [sh_type_msg+eax]
        mov edx, sh_type_msg_len
        call print
    
    
    ;;print flag
        mov edx, dword [e_arch]
        lea edx, [edx * 4]
        mov eax, 3
        mov ebx, eax
        mov ecx, BytesBuffer
        int 80h

    
    ;print addr
     mov edx, dword [e_arch]
        lea edx, [edx * 4]
        mov eax, 3
        mov ebx, eax
        mov ecx, BytesBuffer
        int 80h
        
        mov eax, dword [BytesBuffer]
        lea edi, [tmp_string]
        mov ecx, edx
        call print_string
        call printSpace
     ;print offset
        mov edx, dword [e_arch]
        lea edx, [edx * 4]
        mov eax, 3
        mov ebx, eax
        mov ecx, BytesBuffer
        int 80h
        
        mov eax, dword [BytesBuffer]
        lea edi, [tmp_string]
        mov ecx, edx
        call print_string
        call printSpace
        call printSpace
        
     ;print size
        mov edx, dword [e_arch]
        lea edx, [edx * 4]
        mov eax, 3
        mov ebx, eax
        mov ecx, BytesBuffer
        int 80h
        
        mov eax, dword [BytesBuffer]
        lea edi, [tmp_string]
        mov ecx, edx
        call print_string
        call printSpace   
        call printSpace
        
     ;print link - lk
        mov edx, 4
        mov eax, 3
        mov ebx, eax
        mov ecx, BytesBuffer
        int 80h
        
        mov eax, dword [BytesBuffer]
        lea esi, [tmp_string]
        call itoa
        mov ecx, eax
        mov edx, 10
        call print
        call setupSpace
        
        
     ;print link - info
        mov edx, 4
        mov eax, 3
        mov ebx, eax
        mov ecx, BytesBuffer
        int 80h
        
        mov eax, dword [BytesBuffer]
        lea esi, [tmp_string]
        call itoa
        mov ecx, eax
        mov edx, 10
        call print

        call setupSpace
        call printSpace
     ;print addralign - al
        mov edx, dword [e_arch]
        lea edx, [edx * 4]
        mov eax, 3
        mov ebx, eax
        mov ecx, BytesBuffer
        int 80h
        
        mov eax, dword [BytesBuffer]
        lea esi, [tmp_string]
        call itoa
        mov ecx, eax
        mov edx, 10
        call print

        call setupSpace
        
     ;print entsize - es
        mov edx, 4
        mov eax, 3
        mov ebx, eax
        mov ecx, BytesBuffer
        int 80h
        
        mov eax, dword [BytesBuffer]
        lea edi, [tmp_string]
        mov ecx, edx
        call print_string
        
    ;; tro cur_offset toi dia chi section tiep theo
    mov eax,  [e_shentsize]
    add  [cur_offset], eax
    call newLine 
     jmp _lapSectionHeader
          
    _breakSectionHeader:
    pop edx
    


call    quit                ; call our quit function




; dung sau lenh print khi itoa
setupSpace:
        sub esi,tmp_string
        sub esi,28
        _lapPrintSpace:
        cmp esi,0
        je _breakPrintSpace
        dec esi
        call printSpace
        jmp _lapPrintSpace    
        _breakPrintSpace:
        ret

 ;; print name in Section Header
    ;; Input: ecx - offset in file
    print_name_in_Section_Header:
        mov ebx, [handle]
        mov edx, 0
        mov eax, 19
        int 80h
        mov edx,16
        push edx
        loop_print_name:
            pop edx
            dec edx
            push edx
            mov eax, 3
            mov ebx, eax
            mov ecx, singleByte
            mov edx, 1
            int 80h

            cmp byte [singleByte], 0h
            je _done

            mov edi, tmp_string
            mov ah, byte [singleByte]
            mov byte [edi], ah
            inc edi
            mov byte [edi], 0h
            
            mov ecx, tmp_string
            mov edx, 1
            call print 
            jmp loop_print_name
        _done:

        _lap:
            pop edx
            cmp edx, 0
            je _break
            dec edx
            push edx
            call printSpace
            jmp _lap
        _break:     
            ret

quit:
    mov     ebx, 0
    mov     eax, 1
    int     80h
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



 ;input eax: int ;esi offset tempstring
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
;input esi offset string convert
convertInput:
   .lap:
   mov ah, byte[esi]
   cmp ah, 0Ah
   je .break
   inc esi
   jmp .lap
   .break:
   mov byte[esi],0
   ret
   
