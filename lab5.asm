.386
.model flat, stdcall
option casemap:none

include windows.inc
include kernel32.inc
include user32.inc
include masm32.inc

includelib kernel32.lib
includelib user32.lib
includelib masm32.lib

.data
    inputString db 256 dup(0)  ; Буфер для ввода строки (макс. длина 256 символов)
    promptMsg   db 'Enter the line: ', 0
    foundAMsg   db 'The letter A was found', 0
    foundBMsg   db 'The letter B was found', 0
    notFoundMsg db 'Буквы A или B не найдены', 0

.code
start:
    ; Вывод сообщения о вводе строки
    invoke StdOut, addr promptMsg

    ; Ввод строки
    invoke StdIn, addr inputString, 256

    ; Проверка на наличие букв 'A' или 'B'
    mov esi, offset inputString  ; Установка указателя на начало строки

check_loop:
    lodsb                       ; Загружаем текущий символ в AL
    cmp al, 0                   ; Проверяем, достигли ли конца строки
    je  not_found               ; Если конец строки, то переходим к выводу "не найдено"
    
    cmp al, 'A'                 ; Проверка на наличие 'A'
    je  found_a

    cmp al, 'B'                 ; Проверка на наличие 'B'
    je  found_b

    jmp check_loop              ; Переход на следующую итерацию

found_a:
    invoke StdOut, addr foundAMsg
    jmp end_program

found_b:
    invoke StdOut, addr foundBMsg
    jmp end_program

not_found:
    invoke StdOut, addr notFoundMsg

end_program:
    invoke ExitProcess, 0

end start