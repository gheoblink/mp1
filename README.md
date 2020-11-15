# mp1
Архитектуры Вычислительных Систем. Микропроект 1.
(Файлы со скриншотами прикреплены отдельно, не в ПЗ)


# Code

format PE Console

entry Start

include 'win32a.inc'

section '.data' data readable writable

        strNum db 'Enter number: ', 0

        resStr db 'The number of primes before the entered: %d', 0
        emptyStr db '%d', 0

        scanNum dd ?
        counter dd 0

section '.code' code readable executable

        Start:

        push strNum
        call [printf]


        push scanNum
        push emptyStr
        call [scanf]

startPrime:

        mov ebx, 2
        
        lp:
        
                mov ecx, 1
                
                jmp isPrime
                
                postlp:
                
                        inc ebx
                        cmp ebx, [scanNum]
                        jle lp
        finish:


        invoke printf, resStr, [counter]

        call [getch]

        push 0
        call [ExitProcess]

;===================
isPrime:

        inc [counter]   
        
        stpr:
                inc ecx       

                cmp ecx, ebx
                
                jge postlp

                xor edx, edx
                
                mov eax, ebx
                
                div ecx

                cmp edx, 0
                
                je notPrime


                jmp stpr


;====================

notPrime:
        dec [counter]
        jmp postlp
        
;====================

section '.idata'  import data readable

        library kernel, 'kernel32.dll',\
                msvcrt, 'msvcrt.dll'

        import kernel,\
               ExitProcess, 'ExitProcess'
        import msvcrt,\
               printf, 'printf',\
               scanf, 'scanf',\
               getch, '_getch'
