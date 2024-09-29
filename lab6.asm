.386
.model flat, stdcall
option casemap:none

include masm32.inc
include kernel32.inc
include user32.inc

includelib masm32.lib
includelib kernel32.lib
includelib user32.lib

.data
    msgInput db "Enter a natural number: ", 0
    msgOutput db "The number of single digits: %d", 0
    buffer db 11 dup(0) ; буфер для ввода числа
    number dd 0         ; переменная для числа
    onesCount dd 0      ; переменная для подсчета единичных разрядов

.code
start:
    ; Выводим запрос на ввод числа
    invoke StdOut, addr msgInput
    
    ; Вводим число
    invoke StdIn, addr buffer, sizeof buffer
    invoke atodw, addr buffer ; конвертируем строку в число
    mov number, eax           ; сохраняем число в переменную

    ; Инициализируем счетчик единичных битов
    xor eax, eax
    mov ecx, 0

checkBits:
    test number, 1        ; проверяем младший бит
    jz skipIncrement      ; если 0, пропускаем увеличение счетчика
    inc eax               ; увеличиваем счетчик, если бит равен 1

skipIncrement:
    shr number, 1         ; сдвигаем число вправо
    inc ecx               ; увеличиваем счетчик битов
    cmp ecx, 32           ; проверяем, все ли биты проверены
    jl checkBits          ; если нет, продолжаем

    ; Сохраняем результат в переменную onesCount
    mov onesCount, eax

    ; Выводим результат
    invoke wsprintf, addr buffer, addr msgOutput, onesCount
    invoke StdOut, addr buffer

    ; Завершаем программу
    invoke ExitProcess, 0
end start