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
  msgInput  db "Enter a natural number: ", 0
  msgOutput db "The number of single digits: %d", 0
  buffer    db 11 dup(0)                             ; буфер для ввода числа
  number    dd 0                                     ; переменная для числа
  onesCount dd 0                                     ; переменная для подсчета единичных разрядов

.code

  ; Макрокоманда для вывода сообщения
PrintMessage MACRO message
                                 invoke       StdOut, addr message
ENDM

  ; Макрокоманда для подсчета единичных битов
CountOnes MACRO number, countVar
                                        xor           eax, eax                                          ; обнуляем регистр EAX (для счетчика единичных битов)
                                        mov           ecx, 0                                            ; инициализируем счетчик для количества проверенных битов

    checkBits_macro:                                                                                   ; метка для проверки бита
                                        test         number, 1                                          ; проверяем младший бит числа
                                        jz             skipIncrement_macro                              ; если бит равен 0, пропускаем увеличение счетчика
                                        inc           eax                                               ; увеличиваем счетчик, если бит равен 1

    skipIncrement_macro:                                                                               ; метка для пропуска инкремента
                                        shr           number, 1                                         ; сдвигаем число вправо
                                        inc           ecx                                               ; увеличиваем счетчик проверенных битов
                                        cmp           ecx, 32                                           ; проверяем, все ли биты проверены (32 бита для DWORD)
                                        jl             checkBits_macro                                  ; если нет, продолжаем проверку

                                        mov           countVar, eax                                     ; сохраняем результат в переменную
ENDM

  start:              
  ; Выводим запрос на ввод числа
                      PrintMessage msgInput

  ; Вводим число
                      invoke       StdIn, addr buffer, sizeof buffer
                      invoke       atodw, addr buffer                                ; конвертируем строку в число
                      mov          number, eax                                       ; сохраняем число в переменную

  ; Подсчитываем количество единичных битов с помощью макрокоманды
                      CountOnes    number, onesCount

  ; Выводим результат
                      invoke       wsprintf, addr buffer, addr msgOutput, onesCount
                      invoke       StdOut, addr buffer

  ; Завершаем программу
                      invoke       ExitProcess, 0
end start
