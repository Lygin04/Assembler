.model flat, stdcall
option casemap:none

include C:\masm32\include\masm32.inc
include C:\masm32\include\kernel32.inc
include C:\masm32\include\user32.inc
includelib C:\masm32\lib\masm32.lib
includelib C:\masm32\lib\kernel32.lib
includelib C:\masm32\lib\user32.lib

.data
  format1   db "Input first number: ", 0   ; Форматная строка для ввода первого числа
  format2   db "Input second number: ", 0  ; Форматная строка для ввода второго числа
  format3   db "Input third number: ", 0   ; Форматная строка для ввода третьего числа
  resultMsg db "Sorted numbers:", 0        ; Сообщение о том, что будут выведены отсортированные числа
  newLine   db 13, 10, 0                   ; Символы новой строки (Carriage Return + Line Feed)
  buffer    db 20 dup(?)                   ; Буфер для хранения ввода пользователя
  numStr    db 12 dup(?)                   ; Буфер для строки с числом при выводе
  num1      dd 0                           ; Переменная для хранения первого числа
  num2      dd 0                           ; Переменная для хранения второго числа
  num3      dd 0                           ; Переменная для хранения третьего числа
  temp      dd 0                           ; Временная переменная для обмена значениями

.code
  start: 
  ; Ввод первого числа
         invoke StdOut, addr format1               ; Вывод сообщения для ввода первого числа
         invoke StdIn, addr buffer, sizeof buffer  ; Ввод строки с первым числом
         invoke atodw, addr buffer                 ; Преобразование строки в целое число
         mov    num1, eax                          ; Сохранение первого числа в переменную num1

  ; Ввод второго числа
         invoke StdOut, addr format2               ; Вывод сообщения для ввода второго числа
         invoke StdIn, addr buffer, sizeof buffer  ; Ввод строки со вторым числом
         invoke atodw, addr buffer                 ; Преобразование строки в целое число
         mov    num2, eax                          ; Сохранение второго числа в переменную num2

  ; Ввод третьего числа
         invoke StdOut, addr format3               ; Вывод сообщения для ввода третьего числа
         invoke StdIn, addr buffer, sizeof buffer  ; Ввод строки с третьим числом
         invoke atodw, addr buffer                 ; Преобразование строки в целое число
         mov    num3, eax                          ; Сохранение третьего числа в переменную num3

  ; Сортировка чисел
  ; Если num1 > num2, меняем их местами
         mov    eax, num1                          ; Загружаем значение num1 в регистр eax
         cmp    eax, num2                          ; Сравниваем значение в eax с num2
         jle    check2                             ; Если num1 <= num2, переход к check2
         mov    eax, num1                          ; Загружаем значение num1 в eax
         mov    temp, eax                          ; Сохраняем значение num1 в временную переменную temp
         mov    eax, num2                          ; Загружаем значение num2 в eax
         mov    num1, eax                          ; Сохраняем значение num2 в переменную num1
         mov    eax, temp                          ; Загружаем значение temp (первоначальное значение num1) в eax
         mov    num2, eax                          ; Сохраняем его в переменную num2

  check2:
  ; Если num2 > num3, меняем их местами
         mov    eax, num2                          ; Загружаем значение num2 в регистр eax
         cmp    eax, num3                          ; Сравниваем значение в eax с num3
         jle    check3                             ; Если num2 <= num3, переход к check3
         mov    eax, num2                          ; Загружаем значение num2 в eax
         mov    temp, eax                          ; Сохраняем значение num2 в временную переменную temp
         mov    eax, num3                          ; Загружаем значение num3 в eax
         mov    num2, eax                          ; Сохраняем значение num3 в переменную num2
         mov    eax, temp                          ; Загружаем значение temp (первоначальное значение num2) в eax
         mov    num3, eax                          ; Сохраняем его в переменную num3

  check3:
  ; Если num1 > num2, снова проверяем после второй замены
         mov    eax, num1                          ; Загружаем значение num1 в регистр eax
         cmp    eax, num2                          ; Сравниваем значение в eax с num2
         jle    sorted                             ; Если num1 <= num2, переход к sorted
         mov    eax, num1                          ; Загружаем значение num1 в eax
         mov    temp, eax                          ; Сохраняем значение num1 в временную переменную temp
         mov    eax, num2                          ; Загружаем значение num2 в eax
         mov    num1, eax                          ; Сохраняем значение num2 в переменную num1
         mov    eax, temp                          ; Загружаем значение temp (первоначальное значение num1) в eax
         mov    num2, eax                          ; Сохраняем его в переменную num2

  sorted:
  ; Вывод отсортированных чисел
         invoke StdOut, addr resultMsg             ; Вывод сообщения "Sorted numbers:"
         invoke StdOut, addr newLine               ; Перевод строки

  ; Вывод первого числа
         invoke dwtoa, num1, addr numStr           ; Преобразование первого числа в строку
         invoke StdOut, addr numStr                ; Вывод строки с первым числом
         invoke StdOut, addr newLine               ; Перевод строки

  ; Вывод второго числа
         invoke dwtoa, num2, addr numStr           ; Преобразование второго числа в строку
         invoke StdOut, addr numStr                ; Вывод строки со вторым числом
         invoke StdOut, addr newLine               ; Перевод строки

  ; Вывод третьего числа
         invoke dwtoa, num3, addr numStr           ; Преобразование третьего числа в строку
         invoke StdOut, addr numStr                ; Вывод строки с третьим числом
         invoke StdOut, addr newLine               ; Перевод строки

  ; Завершение программы
         invoke ExitProcess, 0                     ; Завершение работы программы с кодом 0

end start
