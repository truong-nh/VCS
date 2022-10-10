.386
.model flat, stdcall
option casemap :none

include C:\masm32\include\masm32rt.inc


.data

; Dos Header

DosH db 0Ah, "             Dos Header        ", 0Ah,\
             "Member     |Size  |Offset    |Value", 0Ah, 0h
e_magic   db "e_magic    |WORD  |00000000  |", 0h
e_cblp    db "e_cblp     |WORD  |00000002  |", 0h
e_cp      db "e_cp       |WORD  |00000004  |", 0h
e_crlc    db "e_crlc     |WORD  |00000006  |", 0h
e_cparhdr db "e_cparhdr  |WORD  |00000008  |", 0h
e_minalloc db"e_minalloc |WORD  |0000000A  |", 0h
e_maxalloc db"e_maxalloc |WORD  |0000000C  |", 0h
e_ss      db "e_ss       |WORD  |0000000E  |", 0h
e_sp      db "e_sp       |WORD  |00000010  |", 0h
e_csum    db "e_csum     |WORD  |00000012  |", 0h
e_ip      db "e_ip       |WORD  |00000014  |", 0h
e_cs      db "e_cs       |WORD  |00000016  |", 0h
e_lfarlc  db "e_lfarlc   |WORD  |00000018  |", 0h
e_ovno    db "e_ovno     |WORD  |0000001A  |", 0h
e_res     db "e_res      |WORD  |0000001C  |", 0h
e_res_1   db "           |WORD  |0000001E  |", 0h
e_res_2   db "           |WORD  |00000020  |", 0h
e_res_3   db "           |WORD  |00000022  |", 0h
e_oemid   db "e_oemid    |WORD  |00000024  |", 0h
e_oeminfo db "e_oeminfo  |WORD  |00000026  |", 0h
e_res2    db "e_res2     |WORD  |00000028  |", 0h  
e_res2_1  db "           |WORD  |0000002A  |", 0h  
e_res2_2  db "           |WORD  |0000002C  |", 0h  
e_res2_3  db "           |WORD  |0000002E  |", 0h  
e_res2_4  db "           |WORD  |00000030  |", 0h  
e_res2_5  db "           |WORD  |00000032  |", 0h  
e_res2_6  db "           |WORD  |00000034  |", 0h  
e_res2_7  db "           |WORD  |00000036  |", 0h  
e_res2_8  db "           |WORD  |00000038  |", 0h  
e_res2_9  db "           |WORD  |0000003A  |", 0h  
e_lfanew  db "e_lfanew   |DWORD |0000003C  |", 0h

DosH_msg dq offset e_magic,offset e_cblp,offset e_cp,offset e_crlc,offset e_cparhdr,offset e_minalloc,offset e_maxalloc,offset e_ss\
,offset e_sp,offset e_csum,offset e_ip,offset e_cs,offset e_lfarlc,offset e_ovno,offset e_res,offset e_res_1,offset e_res_2,offset e_res_3,offset e_oemid,offset e_oeminfo\
,offset e_res2,offset e_res2_1,offset e_res2_2,offset e_res2_3,offset e_res2_4,offset e_res2_5,offset e_res2_6,offset e_res2_7,offset e_res2_8,offset e_res2_9,offset e_lfanew
DosH_members_size dd 30 dup (2h), 4

; Nt Header
Nt db 0Ah, "Nt Header", 0Ah, "Member     |Size  |Offset    Value", 0Ah, "Signature  |DWORD |", 0h
fileHeader          db "----File Header", 0Ah, "    Member               |Size  |Offset    |Value", 0Ah, 0h
machine             db "    Machine              |WORD  |", 0h
numberOfSections    db "    NumberOfSections     |WORD  |", 0h
timeDateStamp       db "    TimeDateStamp        |DWORD |", 0h
pointer2SymbolTable db "    PointerToSymbolTable |DWORD |", 0h
numberOfSymbols     db "    NumberOfSymbols      |DWORD |", 0h
sizeOptionalHeader  db "    SizeOfOptionalHeader |WORD  |", 0h
characteristics     db "    Characteristics      |WORD  |", 0h
fileHeader_msg dq offset machine, offset numberOfSections,offset timeDateStamp, offset pointer2SymbolTable, offset numberOfSymbols,\
offset sizeOptionalHeader, offset characteristics
fileHeader_members_size dd 2h, 2h, 4h, 4h, 4h, 2h, 2h


; Optional Header
Opt db 0Ah, "Optional Header ", 0Ah,\
                           "Member                  |Size    |Offset    |Value", 0Ah, 0h

; Optional Header Standard Fields
magic                   db "Magic                   |WORD    |", 0h
majorLinkerVersion      db "MajorLinkerVersion      |Byte    |", 0h
minorLinkerVersion      db "MinorLinkerVersion      |Byte    |", 0h
sizeOfCode              db "SizeOfCode              |DWORD   |", 0h
sizeOfInitializedData   db "SizeOfInitializedData   |DWORD   |", 0h
sizeOfUninitializedData db "SizeOfUninitializedData |DWORD   |", 0h
addressOfEntryPoint     db "AddressOfEntryPoint     |DWORD   |", 0h
baseOfCode              db "BaseOfCode              |DWORD   |", 0h
baseOfData              db "BaseOfData              |DWORD   |", 0h

;Optional Header Windows-Specified Fields
imageBase               db "ImageBase               |", 0h
sectionAlignment        db "SectionAlignment        |", 0h
fileAlignment           db "FileAlignment           |", 0h
majorOSVer              db "MajorOSVersion          |", 0h
minorOSVer              db "MinorOsVersion          |", 0h
majorImageVersion       db "MajorImageVersion       |", 0h
minorImageVersion       db "MinorImageVersion       |", 0h
majorSubSystemVersion   db "MajorSubSystemVersion   |", 0h
minorSubSystemVersion   db "MinorSubSystemVersion   |", 0h
win32VersionBlue        db "Win32VersionBlue        |", 0h
sizeOfImage             db "SizeOfImage             |", 0h
sizeOfHeaders           db "SizeOfHeaders           |", 0h
checkSum                db "CheckSum                |", 0h
subSystem               db "SubSystem               |", 0h
dllCharacteristics      db "DllCharacteristics      |", 0h
sizeOfStackReverse      db "SizeOfStackReverse      |", 0h
sizeOfStackCommit       db "SizeOfStackCommit       |", 0h
sizeOfHeapReverse       db "SizeOfHeapReverse       |", 0h
sizeOfHeapCommit        db "SizeOfHeapCommit        |", 0h
loaderFlags             db "LoaderFlags             |", 0h
numberOfRvaAndSizes     db "NumberOfRvaAndSizes     |", 0h

; Data directories Fields
dataDir                 db "----------- Data Directories [x]", 0Ah,\
                           "Member                                  |Size   |Offset    |Value  ", 0Ah, 0h
ex_RVA                  db "ExportDirectory RVA                     |DWORD  |", 0h
ex_size                 db "ExportDirectory Size                    |DWORD  |", 0h
im_RVA                  db "ImportDirectory RVA                     |DWORD  |", 0h
im_size                 db "ImportDirectory Size                    |DWORD  |", 0h
rsc_RVA                 db "ResourceDirectory RVA                   |DWORD  |", 0h
rsc_size                db "ResourceDirectory Size                  |DWORD  |", 0h
excep_RVA               db "ExceptionDirectory RVA                  |DWORD  |", 0h
excep_size              db "ExceptionDirectory Size                 |DWORD  |", 0h
sec_RVA                 db "SecurityDirectory RVA                   |DWORD  |", 0h
sec_size                db "SecurityDirectory Size                  |DWORD  |", 0h
relo_RVA                db "RelocationDirectory RVA                 |DWORD  |", 0h
relo_size               db "RelocationDirectory Size                |DWORD  |", 0h
dbg_RVA                 db "DebugDirectory RVA                      |DWORD  |", 0h
dbg_size                db "DebugDirectory Size                     |DWORD  |", 0h  
arch_RVA                db "Architecture Directory RVA              |DWORD  |", 0h
arch_size               db "Architecture Directory Size             |DWORD  |", 0h
reserved                db "Reserved                                |DWORD  |", 0h
tls_RVA                 db "TLS Directory RVA                       |DWORD  |", 0h
tls_size                db "TLS Directory Size                      |DWORD  |", 0h
cfg_RVA                 db "Configuration Directory RVA             |DWORD  |", 0h
cfg_size                db "Configuration Directory Size            |DWORD  |", 0h
boundim_RVA             db "Bound Import Directory RVA              |DWORD  |", 0h
boundim_size            db "Bound Import Directory Size             |DWORD  |", 0h
iat_RVA                 db "Import Address Table Directory RVA      |DWORD  |", 0h
iat_size                db "Import Address Table Directory Size     |DWORD  |", 0h
delay_RVA               db "Delay Import Directory RVA              |DWORD  |", 0h
delay_size              db "Delay Import Directory Size             |DWORD  |", 0h
comNet_RVA              db ".NET MetaData Directory RVA             |DWORD  |", 0h
comNet_size             db ".NET MetaData Directory Size            |DWORD  |", 0h

; msg for Optional Header 32bit
opt_header_msg_32 dq offset magic, offset majorLinkerVersion, offset minorLinkerVersion,\
offset sizeOfCode, offset sizeOfInitializedData, offset sizeOfUninitializedData,\
offset addressOfEntryPoint, offset baseOfCode, offset baseOfData
optHeader_members_size_32 dd 2, 1, 1, 6 dup (4)

; msg for Optional Header 64bit (No baseofData)
opt_header_msg_64 dq offset magic, offset majorLinkerVersion, offset minorLinkerVersion,\
offset sizeOfCode, offset sizeOfInitializedData, offset sizeOfUninitializedData,\
offset addressOfEntryPoint, offset baseOfCode
optHeader_members_size_64 dd 2, 1, 1, 5 dup (4)

; msg for Optional Header Windows-Specific Fields 
opt_win_spec_msg dq offset imageBase,offset sectionAlignment,offset fileAlignment,\
offset majorOSVer,offset minorOSVer,offset majorImageVersion,offset minorImageVersion,\
offset majorSubSystemVersion,offset minorSubSystemVersion,offset win32VersionBlue,offset sizeOfImage,\
offset sizeOfHeaders,offset checkSum,offset subSystem,offset dllCharacteristics,offset sizeOfStackReverse,\
offset sizeOfStackCommit,offset sizeOfHeapReverse,offset sizeOfHeapCommit,offset loaderFlags,offset numberOfRvaAndSizes

; size arrays for Optional Header Windows-Specific Fields
optHeader_win_spec_members_size_32 dd 3 dup (4), 6 dup (2), 4 dup (4), 2 dup (2), 6 dup (4)
optHeader_win_spec_members_size_64 dd 8, 2 dup (4), 6 dup (2), 4 dup (4), 2 dup (2), 4 dup (8), 2 dup (4)

; msg for Optional Header - Data Directories 
data_msg dq offset ex_RVA,offset ex_size,offset im_RVA,offset im_size,\
offset rsc_RVA,offset rsc_size,offset excep_RVA,offset excep_size,offset sec_RVA,\
offset sec_size,offset relo_RVA,offset relo_size,offset dbg_RVA,\
offset dbg_size,offset arch_RVA,offset arch_size,2 dup (offset reserved),offset tls_RVA,offset tls_size,\
offset cfg_RVA,offset cfg_size,offset boundim_RVA,offset boundim_size,offset iat_RVA,\
offset iat_size,offset delay_RVA,offset delay_size,offset comNet_RVA,offset comNet_size 


; Section Header 
sectionHeader       db 0Ah, "SECTION HEADER", 0Ah,"Name      |Virtual Size  |VirtualAddress |RawSize       |Raw Address   |Reloc Address |LineNumbers|RelocaNum |LinenumNum |CharacTeristics" ,10,0h

; size of Section header's members 
sectionHeader_members_size dd 6 dup (4), 2 dup (2), 4 
virtAddr_array dd 20 dup (?)
rawAddr_array dd 20 dup (?)

; Import Directory message
impDir_msg          db 0Ah, "Import Directory", 0Ah, \
 "Module Name     |OFTs        |TimeDateStamp  |ForwarderChain |Name RVA     | FTs (IAR) ", 0Ah, 0h



max_size EQU 17
newLn db " ", 0Ah, 0h
separator       db "      |", 0h

FileName     db 400 dup(?)

fileName_msg db "File Path: ", 0h


byte_msg        db "Byte    |", 0h
word_msg        db "WORD    |", 0h
dword_msg       db "DWORD   |", 0h 
qword_msg       db "QWORD   |", 0h

tmp_string db max_size dup(?), 0h
tmp_string1 db max_size dup(?), 0h
tmp_string2 db max_size dup(?), 0h
tmp_string3 db max_size dup(?), 0h
string_buf db max_size dup(?)
hexString	db "0123456789ABCDEF"

not_found_msg db 0Ah, "Not Found", 0Ah, 0h
buffer dw 150h dup (?)
BytesBuffer dd 4
singleByte db 2
cur_offset dd 1
Nt_offset dd 1
numberOfSections_int dd 1
numberOfImportedDlls_int dd 1
offsetOfImportDirRVA dd 1
offsetOfExportDirRVA dd 1
offsetImportDir      dd 1
cur_offset1 dd 1 
nameImportOffset dd 1

counter_int dd 0
exe_type dd 1           ; 0 for dll
                        ; 1 for exe
arch dd 1               ; 0 for 32bit
                        ; 1 for 64bit
size2Read dd 1
number_of_directories dd 1      ; number of data directories
dll_exe_possible_flag dd '2', '3', '6', '7', 'A', 'E', 'F'
dll_msg         db 0Ah, "File Type: dll", 0Ah, 0h
exe_msg         db 0Ah, "File Type: exe", 0Ah, 0h
_32bit_msg      db "Architecture: 32bit", 0Ah, 0h
_64bit_msg      db "Architecture: 64bit", 0Ah, 0h
not_valid_exc   db 0Ah,"File Type: Unknown Type", 0h
valid_exc       db 0Ah,"File Type: Executable file", 0h



.data?

hFile       dd ?
Filesize    dd ?
hMem        dd ?
BytesRead   db ?


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


    ;; Input: eax - number to convert
    ;;        edi - pointer to buffer
    ;; Output: hex number in buffer
	Dec2Hex proc
        mov ecx, 8
      _lap:
        rol eax, 4
        mov edx, eax
        and edx, 0Fh
        movzx edx, byte ptr [hexString + edx]
        mov [edi], dl
        inc edi

        dec ecx
        jnz _lap
        mov byte ptr [edi], 0h
        ret
	Dec2Hex endp

    ;; Input: edi - pointer to string
    ;;        ecx - number of bytes to print
    ;; Output: StdOut
    print_string proc
        push ecx
        call Dec2Hex
        pop ecx
        mov edi, offset tmp_string
        add ecx, ecx
        mov eax, 8
        sub eax, ecx
        add edi, eax
        mov esi, offset string_buf
        _lap:
            mov ah, byte ptr [edi]
            mov byte ptr [esi], ah
            cmp ecx, 1h
            je _break
            inc edi
            inc esi
            dec ecx
            jmp _lap
        _break:
            inc esi
            mov byte ptr [esi], 0h
            push offset string_buf
            call StdOut
            ret
    print_string endp



    DosHeader proc
        push ebp
        mov ebp, esp

        push offset newLn
        call StdOut

        invoke  CreateFile,ADDR FileName,GENERIC_READ,0,0,\
                OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL,0   
        mov     hFile,eax
        push offset DosH
        call StdOut
        mov esi, -1
        push esi
        
        _lap:
        pop esi
        cmp esi, 30
        je _break
        inc esi
        push esi
        lea edi, [DosH_msg]
        mov eax, [edi + esi*8]
        push eax
        call StdOut

        mov eax, dword ptr [DosH_members_size + esi*4]
        invoke  ReadFile,hFile,addr BytesBuffer,eax,addr BytesRead,0
        mov edi, offset tmp_string
        mov eax, dword ptr [BytesBuffer]
        mov ecx, dword ptr [DosH_members_size + esi*4]
        call print_string
        push offset newLn
        call StdOut
        jmp _lap
        
    _break:
        invoke CloseHandle, hFile
        mov esp, ebp
        pop ebp
        ret
    DosHeader endp




    formatFile proc
        push ebp
        mov ebp, esp

        invoke  CreateFile,ADDR FileName,GENERIC_READ,0,0,\
                OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL,0   
        mov     hFile,eax

         invoke SetFilePointer, hFile, 3Ch, 0, FILE_CURRENT
         invoke ReadFile,hFile, addr BytesBuffer, 4, addr BytesRead, 0
         mov esi, dword ptr [BytesBuffer]
         add esi, 18h    ; 18h = C8h- B0h
         sub esi, 64      ; 64 = 64 byte DOSheader       
        invoke SetFilePointer, hFile, esi, 0, FILE_CURRENT    ; 200 = C8h
        invoke ReadFile,hFile, addr BytesBuffer, 2, addr BytesRead, 0
        mov eax, dword ptr [BytesBuffer]
        cmp eax, 10Bh
        je _32bit
        cmp eax, 20Bh
        je _64bit
        jmp _break
        _32bit:
        mov [arch], 0h
        jmp _break
        _64bit:
        mov [arch], 1h
        
        _break:
        invoke CloseHandle, hFile
        mov esp, ebp
        pop ebp
        ret
    formatFile endp





NtHeader_print proc
        push ebp
        mov ebp, esp
        invoke  CreateFile,ADDR FileName,GENERIC_READ,0,0,\
                OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL,0   
        mov     hFile,eax

        ; Print Nt Header
        push offset newLn
        call StdOut
        push offset Nt
        call StdOut
     
        invoke SetFilePointer,hFile, 3Ch, 0, FILE_BEGIN         ; 3Ch vi tri ket thuc cua DosHeader
        invoke ReadFile,hFile, addr BytesBuffer, 2, addr BytesRead, 0
        
        mov edi, offset tmp_string
        mov eax, dword ptr [BytesBuffer]
        call Dec2Hex
        invoke StdOut, offset tmp_string   ; print offset Signature = value e_lfanew
        mov esi, dword ptr [BytesBuffer]
        mov [Nt_offset], esi
        add esi, 2
        mov [cur_offset], esi      
        push offset separator
        call StdOut
 
        mov eax, dword ptr [BytesBuffer]
        sub eax, 3Eh
 
        invoke SetFilePointer, hFile, eax, 0, FILE_CURRENT
        invoke ReadFile,hFile,addr BytesBuffer, 4,addr BytesRead,0
        mov edi, offset tmp_string
        mov eax, dword ptr [BytesBuffer]
        mov ecx, 4
        push esi
        call print_string
        pop esi

        push offset newLn
        call StdOut

        ; Print File Header
        xor esi, esi
        
        push offset fileHeader
        call StdOut
        push esi
        _lap:
        lea edi, [fileHeader_msg]
        mov eax, [edi + esi*8]
        push eax
        call StdOut

        lea edi, [fileHeader_members_size]
        mov eax, dword ptr [edi + esi*4]
        mov ebx, [cur_offset]
        add ebx, eax
        mov [cur_offset], ebx
        invoke ReadFile,hFile,addr BytesBuffer,eax,addr BytesRead,0

        mov edi, offset tmp_string
        mov eax, [cur_offset]
        call Dec2Hex
        invoke StdOut, offset tmp_string        ;print Offset
        invoke StdOut, offset separator

        mov edi, offset tmp_string
        mov eax, dword ptr [BytesBuffer]
        pop esi
        mov ecx, dword ptr [fileHeader_members_size + esi*4]
        push esi
        call print_string                       ;print value

        push offset newLn
        call StdOut
        pop esi
        cmp esi, 6h
        
        je optionalHeader_print
        inc esi   ; esi bien dem
        push esi 
        jmp _lap

        ret  
    NtHeader_print endp



optionalHeader_print proc
            add [cur_offset], 2h
            push offset Opt
            call StdOut

            cmp byte ptr [arch], 0h
            je optionalHeader_print_32
            cmp byte ptr [arch], 1h
            je optionalHeader_print_64
            
        optionalHeader_print_32:
            xor esi, esi
            push esi
        _opt_Li_32:
            lea edi, [opt_header_msg_32]
            mov eax, [edi + esi*8]
            push eax
            call StdOut

            mov edi, offset tmp_string
            mov eax, [cur_offset]
            call Dec2Hex
            invoke StdOut, offset tmp_string
            invoke StdOut, offset separator

            mov eax, dword ptr [optHeader_members_size_32 + esi*4]
            mov ebx, [cur_offset]
            add ebx, eax
            mov [cur_offset], ebx
            invoke ReadFile,hFile,addr BytesBuffer,eax,addr BytesRead,0

            mov edi, offset tmp_string
            mov eax, dword ptr [BytesBuffer]
            call Dec2Hex

            lea edi, [optHeader_members_size_32]
            mov ecx, dword ptr [edi + esi*4]
            mov edi, offset tmp_string
            call print_string

            push offset newLn
            call StdOut
            pop esi
            cmp esi, 8h
            je optionalHeader_win_spec_print_32
            inc esi 
            push esi 
            jmp _opt_Li_32
        optionalHeader_win_spec_print_32:
            xor esi, esi
            push esi
        _opt_win_spec_Li_32:
            lea edi, [opt_win_spec_msg]
            mov eax, [edi + esi*8]
            push eax
            call StdOut

            cmp byte ptr [optHeader_win_spec_members_size_32 + esi*4], 2h
            je print_word_msg
            cmp byte ptr [optHeader_win_spec_members_size_32 + esi*4], 4h
            je print_dword_msg
            cmp byte ptr [optHeader_win_spec_members_size_32 + esi*4], 8h
            je print_qword_msg
            print_word_msg:
                push offset word_msg
                call StdOut
                jmp continue
            print_dword_msg:
                push offset dword_msg
                call StdOut
                jmp continue
            print_qword_msg:
                push offset qword_msg
                call StdOut
                jmp continue
            continue:
            mov edi, offset tmp_string
            mov eax, [cur_offset]
            call Dec2Hex
            invoke StdOut, offset tmp_string
            invoke StdOut, offset separator

            mov eax, dword ptr [optHeader_win_spec_members_size_32 + esi*4]
            mov ebx, [cur_offset]
            add ebx, eax
            mov [cur_offset], ebx
            invoke ReadFile,hFile,addr BytesBuffer,eax,addr BytesRead,0

            mov edi, offset tmp_string
            mov eax, dword ptr [BytesBuffer]
            call Dec2Hex

            lea edi, [optHeader_win_spec_members_size_32]
            mov ecx, dword ptr [edi + esi*4]
            mov edi, offset tmp_string
            call print_string

            push offset newLn
            call StdOut
            pop esi
            cmp esi, 14h
            je data_directories_print
            inc esi 
            push esi 
            jmp _opt_win_spec_Li_32
        optionalHeader_print_64:
            xor esi, esi
            push esi
        _opt_Li_64:
            lea edi, [opt_header_msg_64]
            mov eax, [edi + esi*8]
            push eax
            call StdOut

            mov edi, offset tmp_string
            mov eax, [cur_offset]
            call Dec2Hex
            invoke StdOut, offset tmp_string
            invoke StdOut, offset separator

            mov eax, dword ptr [optHeader_members_size_64 + esi*4]
            mov ebx, [cur_offset]
            add ebx, eax
            mov [cur_offset], ebx
            invoke ReadFile,hFile,addr BytesBuffer,eax,addr BytesRead,0

            mov edi, offset tmp_string
            mov eax, dword ptr [BytesBuffer]
            call Dec2Hex

            lea edi, [optHeader_members_size_64]
            mov ecx, dword ptr [edi + esi*4]
            mov edi, offset tmp_string
            call print_string

            push offset newLn
            call StdOut
            pop esi
            cmp esi, 7h
            je optionalHeader_win_spec_print_64
            inc esi 
            push esi 
            jmp _opt_Li_64
        optionalHeader_win_spec_print_64:
            xor esi, esi
            push esi
        _opt_win_spec_Li_64:
            lea edi, [opt_win_spec_msg]
            mov eax, [edi + esi*8]
            push eax
            call StdOut

            cmp byte ptr [optHeader_win_spec_members_size_64 + esi*4], 2h
            je print_word_msg_64
            cmp byte ptr [optHeader_win_spec_members_size_64 + esi*4], 4h
            je print_dword_msg_64
            cmp byte ptr [optHeader_win_spec_members_size_64 + esi*4], 8h
            je print_qword_msg_64
            print_word_msg_64:
                push offset word_msg
                call StdOut
                jmp continue_64
            print_dword_msg_64:
                push offset dword_msg
                call StdOut
                jmp continue_64
            print_qword_msg_64:
                push offset qword_msg
                call StdOut
                jmp continue_64
            continue_64:
            mov edi, offset tmp_string
            mov eax, [cur_offset]
            call Dec2Hex
            invoke StdOut, offset tmp_string
            invoke StdOut, offset separator

            mov eax, dword ptr [optHeader_win_spec_members_size_64 + esi*4]
            mov ebx, [cur_offset]
            add ebx, eax
            mov [cur_offset], ebx
            cmp eax, 8h
            je print_value_qword
            invoke ReadFile,hFile,addr BytesBuffer,eax,addr BytesRead,0
            mov edi, offset tmp_string
            mov eax, dword ptr [BytesBuffer]
            call Dec2Hex

            mov ecx, dword ptr [optHeader_win_spec_members_size_64 + esi*4]
            mov edi, offset tmp_string
            call print_string
            jmp continue_qword
            print_value_qword:  
                invoke ReadFile,hFile,addr BytesBuffer,4,addr BytesRead,0
                mov edi, offset tmp_string3
                mov eax, dword ptr [BytesBuffer]
                call Dec2Hex
                
                invoke ReadFile,hFile,addr BytesBuffer,4,addr BytesRead,0
                mov edi, offset tmp_string2
                mov eax, dword ptr [BytesBuffer]
                call Dec2Hex
                invoke StdOut, offset tmp_string2
                invoke StdOut, offset tmp_string3

            continue_qword:
            push offset newLn
            call StdOut
            pop esi
            cmp esi, 14h
            je data_directories_print
            inc esi 
            push esi 
            jmp _opt_win_spec_Li_64
        data_directories_print:
            push offset newLn 
            call StdOut

            invoke StdOut, offset dataDir                       ; set number_of_directories = value of NumberOfRvaAndSizes * 2 - 2
            mov eax, dword ptr [BytesBuffer]
            lea eax, [eax + eax]
            sub eax, 3
            mov [number_of_directories], eax
            xor esi, esi
            push esi
        _data_dir_Li:
            lea edi, [data_msg]
            mov eax, [edi + esi*8]
            push eax
            call StdOut

            mov edi, offset tmp_string
            mov eax, [cur_offset]
            call Dec2Hex
            invoke StdOut, offset tmp_string
            invoke StdOut, offset separator

            mov eax, 4
            mov ebx, [cur_offset]
            add ebx, eax
            mov [cur_offset], ebx
            invoke ReadFile,hFile,addr BytesBuffer,eax,addr BytesRead,0

            mov edi, offset tmp_string
            mov eax, dword ptr [BytesBuffer]
            call Dec2Hex

            mov ecx, 4
            mov edi, offset tmp_string
            call print_string

            push offset newLn
            call StdOut
            pop esi
            cmp esi, dword ptr [number_of_directories]
            je _done
            inc esi 
            push esi 
            jmp _data_dir_Li
        _done:
            invoke CloseHandle, hFile
            mov esp, ebp
            pop ebp
            ret
        optionalHeader_print endp


        ;Section header

    SectionHeader_print proc
        push ebp
        mov ebp, esp
        invoke  CreateFile,ADDR FileName,GENERIC_READ,0,0,\
                OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL,0   
        mov     hFile,eax

        mov eax, dword ptr [Nt_offset]
        add eax, 6

        invoke ReadFile, hFile, addr buffer, eax, addr BytesRead,0
        invoke ReadFile, hFile, addr BytesBuffer, 2, addr BytesRead, 0
        mov ebx, dword ptr [BytesBuffer]
        mov [numberOfSections_int], ebx

        cmp [arch], 0
        je SectionHeader_offset_32
        mov eax, 256
        jmp cont
        SectionHeader_offset_32:
            mov eax, 240
        cont:
        invoke ReadFile,hFile,addr buffer,eax,addr BytesRead,0
        
        ;;print Section Header msg
        push offset sectionHeader
        call StdOut

        xor edx, edx
        push edx
        _lap:
        pop edx
        cmp edx, dword ptr [numberOfSections_int]
        je _break
        inc edx
        push edx
        ;;print name
         push offset newLn
        call StdOut
        invoke ReadFile,hFile,addr BytesBuffer, 8,addr BytesRead,0
        push offset BytesBuffer
        call StdOut
        
        ;print member of Section Header
            xor esi, esi
            push esi
        _lap2:

            push offset separator
            call StdOut

            mov eax, dword ptr [sectionHeader_members_size + esi * 4]
            invoke ReadFile,hFile,addr BytesBuffer,eax,addr BytesRead,0

            mov eax, dword ptr [BytesBuffer]
            mov ecx, dword ptr [sectionHeader_members_size + esi*4]
            mov edi, offset tmp_string
            call print_string

            pop esi
            cmp esi, 8h
            je _lap
            inc esi 
            push esi 
            jmp _lap2
        _break:
       
        invoke CloseHandle, hFile
        mov esp, ebp
        pop ebp

        ;;; luu gia tri virtual address vs raw address 
        push ebp
        mov ebp, esp
        invoke  CreateFile,ADDR FileName,GENERIC_READ,0,0,\
                OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL,0   
        mov     hFile,eax


        mov eax, dword ptr [Nt_offset]
        add eax, 6
        invoke ReadFile, hFile, addr buffer, eax, addr BytesRead,0
        invoke ReadFile, hFile, addr BytesBuffer, 2, addr BytesRead, 0
       ; mov ebx, dword ptr [BytesBuffer]
       ;  mov [numberOfSections_int], ebx
       
        cmp [arch], 0
        je _SectionHeader_offset_32
        mov eax, 256
        jmp _cont1
        _SectionHeader_offset_32:
            mov eax, 240
        _cont1:
        add eax,12
        invoke ReadFile,hFile,addr buffer,eax,addr BytesRead,0
        
        mov esi,0
        push esi
        _lap1:
        pop esi
        cmp esi, dword ptr [numberOfSections_int]
        je _break1
        push esi
        ; luu gia tri virtual address cua moi section vao [virtAddr_array]
        invoke ReadFile,hFile,addr BytesBuffer,4,addr BytesRead,0
        mov eax, dword ptr [BytesBuffer]
        pop esi
        mov [virtAddr_array + esi * 4], eax
        
        push esi
        
        ; luu gia tri Raw address vao rawAddr_array 
        invoke SetFilePointer, hFile, 4, 0, FILE_CURRENT
        invoke ReadFile,hFile, addr BytesBuffer, 4, addr BytesRead, 0
        mov eax, dword ptr [BytesBuffer]
        
        pop esi
        mov [rawAddr_array + esi * 4], eax
        push esi
      
        pop esi
        inc esi
        push esi
        invoke SetFilePointer, hFile, 28, 0, FILE_CURRENT
        jmp _lap1  
        _break1:        

        invoke CloseHandle, hFile
        mov esp, ebp
        pop ebp
        ret
    SectionHeader_print endp

import_print proc
        push ebp
        mov ebp, esp
        invoke  CreateFile,ADDR FileName,GENERIC_READ,0,0,\
                OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL,0   
        mov     hFile,eax
        

        ;; find import director RVA
         
        mov eax, dword ptr [Nt_offset]
        cmp [arch],0h
        je  _importDirRVA32
        add eax, 90h
        jmp _importDirRVA64
        _importDirRVA32:
        add eax, 80h
        _importDirRVA64: 
        invoke SetFilePointer, hFile, eax, 0, FILE_BEGIN
        invoke ReadFile, hFile, addr BytesBuffer, 2, addr BytesRead, 0
        movzx ebx, word ptr [BytesBuffer]
        
        ;; find offset import director
        movzx ebx, word ptr [BytesBuffer]
        call convert_RVA_to_raw_offset
        mov [cur_offset1],ebx
        mov [cur_offset],ebx
        
        push offset impDir_msg
        call StdOut
        _lap:
            
            mov ebx, [cur_offset1]      
            invoke SetFilePointer, hFile, ebx, 0, FILE_BEGIN
             mov esi,1
             push esi   
            _test:
            invoke ReadFile,hFile,addr BytesBuffer, 4,addr BytesRead,0
            mov eax, [BytesBuffer]
            cmp eax, 0
            jne _pass
            pop esi
            je  _break 
            inc esi 
            push esi  
            jmp _test 
         _pass:
        ;;print name
            mov ebx, [cur_offset1]      
            add ebx, 12
            invoke SetFilePointer, hFile, ebx, 0, FILE_BEGIN
            invoke ReadFile,hFile,addr BytesBuffer, 4,addr BytesRead,0
           mov ebx, [BytesBuffer] 
         call convert_RVA_to_raw_offset          
        invoke SetFilePointer, hFile, ebx, 0, FILE_BEGIN
        invoke ReadFile,hFile,addr BytesBuffer, 30,addr BytesRead,0
        push offset BytesBuffer
        call StdOut

        ;print member 
        mov ebx, [cur_offset1]       
        invoke SetFilePointer, hFile, ebx, 0, FILE_BEGIN
        mov esi,1
        push esi
        _lap2:

            push offset separator
            call StdOut

            invoke ReadFile,hFile,addr BytesBuffer,4,addr BytesRead,0
            add [cur_offset1],4
            mov eax, dword ptr [BytesBuffer]
            mov ecx, 4
            mov edi, offset tmp_string
            call print_string

            pop esi
            cmp esi, 5h
            je _break2
            inc esi 
            push esi 
            jmp _lap2
        _break2:
        push offset newLn
        call StdOut 
        jmp _lap
        
        _break:
        invoke CloseHandle, hFile
        mov esp, ebp
        pop ebp
        ret
     
import_print endp  

    ;; Input:       ebx - RVA offset
    ;; Output:      ebx - raw offset
    convert_RVA_to_raw_offset proc
        xor edx, edx
        _lap:
        cmp ebx, dword ptr [virtAddr_array + edx * 4]
        jl _break
        inc edx
        cmp edx, dword ptr [numberOfSections_int]
        je _break 
        jmp _lap
        _break:
        dec edx
        sub ebx, dword ptr [virtAddr_array + edx * 4]
        add ebx, dword ptr [rawAddr_array + edx * 4]
        ret
    convert_RVA_to_raw_offset endp


start:
    push offset fileName_msg  
    call StdOut

    push 400
    push offset FileName
    call StdIn

       
    call formatFile
    call DosHeader
    call NtHeader_print
    call SectionHeader_print



   push offset newLn
   call StdOut
    call import_print
    
 
      
   
    invoke  ExitProcess,0

END start
