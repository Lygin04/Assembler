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
  inputString db 256 dup(0)                     ; Буфер для ввода строки (макс. длина 256 символов)
  promptMsg   db 'Enter the line: ', 0
  foundAMsg   db 'The letter A was found', 0
  foundBMsg   db 'The letter B was found', 0
  notFoundMsg db 'Буквы A или B не найдены', 0

.code

  ; Подпрограмма для проверки символа 'A'
CheckForA proc
  ; Входной параметр в AL
              cmp    al, 'A'
              je     found_a
              ret

  found_a:    
              invoke StdOut, addr foundAMsg
              mov    eax, 1                        ; Устанавливаем флаг, чтобы выйти из цикла
              ret
CheckForA endp

  ; Подпрограмма для проверки символа 'B'
CheckForB proc
  ; Входной параметр в AL
              cmp    al, 'B'
              je     found_b
              ret

  found_b:    
              invoke StdOut, addr foundBMsg
              mov    eax, 1                        ; Устанавливаем флаг, чтобы выйти из цикла
              ret
CheckForB endp

  start:      
  ; Вывод сообщения о вводе строки
              invoke StdOut, addr promptMsg

  ; Ввод строки
              invoke StdIn, addr inputString, 256

  ; Инициализация флага для выхода из цикла
              xor    eax, eax                      ; Обнуляем EAX (флаг выхода из цикла)

  ; Проверка на наличие букв 'A' или 'B'
              mov    esi, offset inputString       ; Установка указателя на начало строки

  check_loop: 
              lodsb                                ; Загружаем текущий символ в AL
              cmp    al, 0                         ; Проверяем, достигли ли конца строки
              je     not_found                     ; Если конец строки, то переходим к выводу "не найдено"
    
  ; Вызов подпрограммы для проверки 'A'
              call   CheckForA
  ; Если флаг выхода (EAX == 1), выходим из цикла
              cmp    eax, 1
              je     end_program

  ; Вызов подпрограммы для проверки 'B'
              call   CheckForB
  ; Если флаг выхода (EAX == 1), выходим из цикла
              cmp    eax, 1
              je     end_program

              jmp    check_loop                    ; Переход на следующую итерацию

  not_found:  
              invoke StdOut, addr notFoundMsg

  end_program:
              invoke ExitProcess, 0

end start
