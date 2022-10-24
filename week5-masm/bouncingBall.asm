.386 
.model flat, stdcall 
option casemap:none 

include C:\masm32\include\masm32rt.inc

.const  
    IDM_GETTEXT equ 1
    DRAWING equ 1
    BALL_SIZE equ 10
 
.data?
    hInstance HINSTANCE ?
    
    ps PAINTSTRUCT <?>
    hdc HDC ?  
    right_bottom POINT <>
    left_top POINT <>

    wc WNDCLASSEX <?>
    msg MSG <?>
    hwnd HWND ?

    hPen_out HPEN ?
    hPen_in HPEN ?
    hOldPen HPEN ?

    hEdit dd ?
    hPrint    dd ?
    textString db 32 dup(?)                    
.data
	ClassName        db "BouncingBall ", 0h                
    AppName db "BouncingBall ", 0h

    vector_X dd 10
    vector_Y dd 10
    randomNumber dd 1
    state db 0
 
    WIN_WIDTH dd 500
    WIN_HEIGHT dd 600
 

.code

;   Input: randomNumber
;   Output: eax 
random proc     

    db 0fh,0c7h,0f0h  
    mov ecx, randomNumber     
    xor edx, edx                               
    div ecx                          
    mov eax, edx            
    ret

random endp

moveBall proc
    mov eax, dword ptr [vector_X]
    mov ebx, dword ptr [vector_Y]

    add left_top.x, eax
    add left_top.y, ebx
    add right_bottom.x, eax
    add right_bottom.y, ebx

    ret
moveBall endp

createBall proc
    push hPen_out
    push hdc
    call SelectObject
    mov eax, hOldPen

    ; print ellipse
    push right_bottom.y
    push right_bottom.x
    push left_top.y
    push left_top.x
    push hdc
    call Ellipse

    push hPen_in
    push hdc
    call SelectObject
    mov eax, hOldPen

    push hPen_in
    push hdc
    call SelectObject
    mov eax, hOldPen
    push right_bottom.y
    push right_bottom.x
    push left_top.y
    push left_top.x
    push hdc
    call Ellipse  
    
    push hOldPen
    push hdc
    call SelectObject          

    call moveBall

    cmp left_top.x, BALL_SIZE
    jl meet_right_left

    cmp left_top.y, BALL_SIZE
    jl meet_bottom_top

    mov eax, WIN_WIDTH
    sub eax, BALL_SIZE
    sub eax, BALL_SIZE
    cmp right_bottom.x, eax
    jg meet_right_left

    mov eax, WIN_HEIGHT
    sub eax, BALL_SIZE
    sub eax, BALL_SIZE
    sub eax, BALL_SIZE
    sub eax, BALL_SIZE
    sub eax, BALL_SIZE
    cmp right_bottom.y, eax
    jg meet_bottom_top

    jmp bouncing

    meet_right_left:
        neg vector_X
        jmp bouncing

    meet_bottom_top:
        neg vector_Y
        jmp bouncing

    bouncing:
        ret
createBall endp

TimerProc PROC thwnd:HWND, uMsg:UINT, idEvent:UINT, dwTime:DWORD
        push TRUE
        push NULL
        push thwnd
        call InvalidateRect
        ret
TimerProc ENDP

updateXY proc lParam:LPARAM
    cmp [state], DRAWING
    je _drawing_update

    mov eax, dword ptr [WIN_WIDTH]
    sub eax, BALL_SIZE
    mov dword ptr [randomNumber], eax
    call random
    add eax, BALL_SIZE
    mov left_top.x, eax
    mov right_bottom.x, eax
    add right_bottom.x, BALL_SIZE

    mov eax, dword ptr [WIN_HEIGHT]
    sub eax, BALL_SIZE
    mov dword ptr [randomNumber], eax
    call random
    add eax, BALL_SIZE
    mov left_top.y, eax
    mov right_bottom.y, eax
    add right_bottom.y, BALL_SIZE

    mov dword ptr [randomNumber], 4
    call random
    cmp eax, 0h                 
    je _done

    cmp eax, 1h                 
    je _top_left

    cmp eax, 2h                 
    je _bottom_right

    cmp eax, 3h                 
    je _bottom_left  
    _top_left:
    neg vector_X
    ret
    _bottom_right:
    neg vector_Y
    ret
    _bottom_left:
    neg vector_X
    neg vector_Y
    ret
    
_drawing_update:
    mov eax, lParam

    ; get low word that contain x
    xor ebx, ebx
    mov bx, ax

    mov left_top.x, ebx
    mov right_bottom.x, ebx
    add right_bottom.x, BALL_SIZE

    ; get high word that contain y
    mov eax, lParam
    shr eax, 16

    mov left_top.y, eax
    mov right_bottom.y, eax
    add right_bottom.y, BALL_SIZE
_done:
    ret
updateXY endp


WindowProcedure proc hWnd:HWND, uMsg:UINT, wParam:WPARAM, lParam:LPARAM

    cmp uMsg, WM_CREATE
    je _WM_CREATE

    cmp uMsg, WM_ACTIVATE
    je _WM_ACTIVATE

    cmp uMsg, WM_PAINT
    je _WM_PAINT

    cmp uMsg, WM_CLOSE
    je _WM_CLOSE

    jmp _default

    _WM_CREATE:
        push Black  ; create our pen
        push 30
        push PS_SOLID
        call CreatePen
        mov hPen_out, eax

        push Red  ; create our pen
        push 20
        push PS_SOLID
        call CreatePen
        mov hPen_in, eax

        jmp exit_proc
    _WM_PAINT:
        push offset ps
        push hWnd
        call BeginPaint
        mov hdc, eax
        
        call createBall

        push offset ps
        push hWnd
        call EndPaint

        jmp exit_proc   
    _WM_ACTIVATE:

            push lParam
            call updateXY

            mov [state], DRAWING

            push OFFSET TimerProc
            push 33
            push 10
            push hwnd
            call SetTimer

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
        mov wc.hbrBackground, COLOR_WINDOW
        mov wc.lpszClassName, OFFSET ClassName

        ; Register the window class
        push offset wc
        call RegisterClassEx

        ; The class is registered, let's create the program
        push NULL
        push hInstance
        push NULL
        push NULL
        push WIN_HEIGHT
        push WIN_WIDTH
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
