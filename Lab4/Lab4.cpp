#include <iostream>
using namespace std;

int main()
{
    setlocale(LC_ALL, "rus");

    const int size = 5;
    int arr[size];

    for (int i = 0; i < size; i++)
    {
        cout << "arr[" << i << "] = "; cin >> arr[i];
    }

    int plus = 0;
    int minus = 0;

    __asm
    {
        mov eax, 0
        mov ebx, 0
        lea esi, arr
        mov ecx, 5

        cycle:
        cmp [esi], 0
        jz nxt
        jg grtr
        inc ebx
        jmp nxt

        grtr:
        inc eax

        nxt:
        add esi, 4
        loop cycle
        
        mov plus, eax
        mov minus, ebx
    }

    cout << "Количество положительных чисел: " << plus << "\n";
    cout << "Количество отрицательных чисел: " << minus << "\n";

    return 0;
}
