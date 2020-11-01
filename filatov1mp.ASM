format PE Console

;Филатов Юрий БПИ193
;Программа для получения количества простых чисел до данного машинного слова
entry Start

include 'win32a.inc'

section '.data' data readable writable

        strNum db 'Enter number: ', 0

        resStr db 'The number of primes before the entered: %d', 0
        emptyStr db '%d', 0

;так как у меня x86-64, поэтому слово = 64 бита, то есть двойное машинное слово для 32битной системы
        scanNum dd ?
        counter dd 0

section '.code' code readable executable

        Start:

        push strNum
        call [printf]


        push scanNum
        push emptyStr
        call [scanf]

;первый for для проверки каждого числа от 1 до scanNum на простоту
;накапливаем количество простых чисел в ecx
startPrime:
        mov ebx, 2
        lp:
                mov ecx, 1
                jmp isPrime
                postlp:
                inc ebx

                cmp ebx, [scanNum]
                jle lp
        ;конец программы
        finish:


        invoke printf, resStr, [counter]

        ;задержка, перед выходом из программы
        call [getch]

        push 0
        call [ExitProcess]

;проверка числа на простоту===================
isPrime:

        inc [counter]         ;счетчик нашего кол-ва простых чисел - сразу +1, а если будет не простое число, то вычтем 1
        stpr:
                inc ecx         ;от 2 до текущего ebx

                cmp ecx, ebx ;postlp
                jge postlp

                xor edx, edx
                mov eax, ebx
                div ecx

                cmp edx, 0 ;ost
                je notPrime


                jmp stpr


;=============================================
notPrime:
        dec [counter]
        jmp postlp
;=============================================
section '.idata'  import data readable

        library kernel, 'kernel32.dll',\
                msvcrt, 'msvcrt.dll'

        import kernel,\
               ExitProcess, 'ExitProcess'
        import msvcrt,\
               printf, 'printf',\
               scanf, 'scanf',\
               getch, '_getch'