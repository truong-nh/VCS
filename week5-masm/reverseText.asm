.386
.model flat, stdcall 
option casemap:none 

include C:\masm32\include\masm32rt.inc

.const  
    IDM_GETTEXT equ 1

.data?
    hInstance HINSTANCE ?

    wc WNDCLASSEX <?>
    msg MSG <?>
    hwnd HWND ?

    hEdit dd ?
    hPrint    dd ?
    textString db 32 dup(?)                    
.data
	ClassName        db "Reverse", 0                
    AppName db "Text Reverse", 0h


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


WindowProcedure proc hWnd:HWND, uMsg:UINT, wParam:WPARAM, lParam:LPARAM

    cmp uMsg, WM_CREATE
    je _WM_CREATE

    cmp uMsg, WM_ACTIVATE
    je _WM_ACTIVATE

    cmp uMsg, WM_TIMER
    je _WM_TIMER

    cmp uMsg, WM_COMMAND
    je _WM_COMMAND

    cmp uMsg, WM_CLOSE
    je _WM_CLOSE

    jmp _default

    _WM_TIMER:
        push 0h
        push IDM_GETTEXT
        push WM_COMMAND
        push hwnd
        call SendMessage

        jmp exit_proc

    _WM_ACTIVATE:  

        push 0h
        push 100
        push 10
        push hwnd
        call SetTimer  

        jmp exit_proc

    _WM_CREATE:	       
        push 0h
        push HINSTANCE
        push 0h
        push hWnd
        push 20
        push 200
        push 100
        push 200
        push WS_CHILD or WS_VISIBLE 
        push 0h
        push chr$("edit")
        push WS_EX_CLIENTEDGE
        call CreateWindowEx
        
        mov hEdit, eax        ; you may need this global variable for further processing

		
        push 0h
        push HINSTANCE
        push 0h
        push hWnd
        push 20
        push 200
        push 200
        push 200
        push WS_CHILD or WS_VISIBLE or ES_READONLY 
        push 0h
        push chr$("edit")
        push WS_EX_CLIENTEDGE
        call CreateWindowEx
        
        mov hPrint, eax


        jmp exit_proc

	_WM_COMMAND:
		mov eax, dword ptr wParam        
        .IF ax==IDM_GETTEXT
                push 90
                push offset textString
                push hEdit
                call GetWindowText

                mov esi, offset textString
                call lengthString
                mov esi, offset textString     
                call reverse

                push offset textString
                push FALSE
                push WM_SETTEXT
                push hPrint
                call SendMessage

        
        .ENDIF
            jmp exit_proc
    _WM_CLOSE:
        push NULL
        call PostQuitMessage
        jmp exit_proc 
    _default:
        push lParam
        push wParam
        push uMsg
        push hWnd
        call DefWindowProc 

        jmp exit_proc
    exit_proc:
        ret
WindowProcedure endp 

WinMain proc hThisInstance:HINSTANCE, hPrevInstance:HINSTANCE, lpszArgument:LPSTR, CmdShow:DWORD

        mov wc.cbSize, SIZEOF WNDCLASSEX           
        mov wc.lpfnWndProc, OFFSET WindowProcedure  
        mov wc.lpszClassName, OFFSET ClassName

        ; Register the window class
        push offset wc
        call RegisterClassEx

        ; The class is registered, let's create the program
        push NULL
        push hInstance
        push NULL
        push NULL
        push 400
        push 800
        push CW_USEDEFAULT
        push CW_USEDEFAULT
        push WS_OVERLAPPEDWINDOW
        push offset AppName
        push offset ClassName
        push WS_EX_CLIENTEDGE
        call CreateWindowEx
        mov hwnd, eax 

        ; Make the window visible on the screen
        push CmdShow
        push hwnd
        call ShowWindow



    ;Run the message loop
    MESSAGE_LOOP:
        push 0
        push 0
        push NULL
        push offset msg
        call GetMessage

        ; return in eax
        test eax, eax
        jle END_LOOP

        ; Translate virtual-key messages into character messages
        push offset msg
        call TranslateMessage

        ; Send message to WindowProcedure
        push offset msg
        call DispatchMessage

        jmp MESSAGE_LOOP

    END_LOOP:
       ;  The program return-value is 0 - The value that PostQuitMessage() gave */
        mov eax, msg.wParam
    ret
WinMain endp

start:  
    push 0h
    call GetModuleHandle

    mov hInstance, eax
    push SW_SHOW
    push 0h
    push 0h
    push hInstance
    call WinMain

    push eax
    call ExitProcess
end start