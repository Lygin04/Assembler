.386
.model flat, stdcall
option casemap:none

include C:\masm32\include\masm32.inc
include C:\masm32\include\kernel32.inc
include C:\masm32\include\user32.inc
includelib C:\masm32\lib\masm32.lib
includelib C:\masm32\lib\kernel32.lib
includelib C:\masm32\lib\user32.lib

.data
    messageSquare db " ^ 2 = ", 0
    messageNewLine db 13, 10, 0
    numStr db 12 dup(?)
    square dd 0

.code
    start:
        mov ebx, 10

        jmp for_condition

        for_start:
            mov eax, ebx
            mul ebx
            mov square, eax

            invoke dwtoa, ebx, addr numStr
            invoke StdOut, addr numStr
            invoke StdOut, addr messageSquare
            invoke dwtoa, square, addr numStr
            invoke StdOut, addr numStr
            invoke StdOut, addr messageNewLine

            inc ebx
        for_condition:
            cmp ebx, 20
            jle for_start
    end start