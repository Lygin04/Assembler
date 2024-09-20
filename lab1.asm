; X=a-c/d+b*4
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
    format1 db "Input a: ", 0
    format2 db "Input b: ", 0
    format3 db "Input c: ", 0
    format4 db "Input d: ", 0
    resultMsg db "Result X = ", 0
    errorMsg db "Error: division by 0!", 0
    buffer db 20 dup(?)
    resultStr db 20 dup(?)
    a dd 0
    b dd 0
    cc dd 0
    d dd 0
    result dd 0

.code
start:
    ; ���� a
    invoke StdOut, addr format1
    invoke StdIn, addr buffer, sizeof buffer
    invoke atodw, addr buffer
    mov a, eax

    ; ���� b
    invoke StdOut, addr format2
    invoke StdIn, addr buffer, sizeof buffer
    invoke atodw, addr buffer
    mov b, eax

    ; ���� c
    invoke StdOut, addr format3
    invoke StdIn, addr buffer, sizeof buffer
    invoke atodw, addr buffer
    mov cc, eax

    ; ���� d
    invoke StdOut, addr format4
    invoke StdIn, addr buffer, sizeof buffer
    invoke atodw, addr buffer
    mov d, eax

    ; �������� ������� �� 0
    cmp d, 0
    je error

    ; ���������� ���������� �� ������� X = a - c / d + b * 4
    mov eax, cc          ; eax = cc
    cdq                 ; ���������� ��������� ������� ��� dword
    idiv d              ; eax = c / d
    mov ebx, eax        ; ebx = c / d
    
    mov eax, b          ; eax = b
    shl eax, 2          ; eax = b * 4
    add eax, a          ; eax = a + b * 4
    sub eax, ebx        ; eax = a + b * 4 - (c / d)

    mov result, eax     ; ���������� ���������� � result

     ; �������������� ���������� � ������
    invoke dwtoa, result, addr resultStr

    ; ����� ����������
    invoke StdOut, addr resultMsg
    invoke StdOut, addr resultStr
    invoke ExitProcess, 0

error:
    invoke StdOut, addr errorMsg
    invoke ExitProcess, 0

end start
