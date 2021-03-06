format PE Console

;������� ���� ���193
;��������� ��� ��������� ���������� ������� ����� �� ������� ��������� �����
entry Start

include 'win32a.inc'

section '.data' data readable writable

        strNum db 'Enter number: ', 0

        resStr db 'The number of primes before the entered: %d', 0
        emptyStr db '%d', 0

;��� ��� � ���� x86-64, ������� ����� = 64 ����, �� ���� ������� �������� ����� ��� 32������ �������
        scanNum dd ?
        counter dd 0

section '.code' code readable executable

        Start:

        push strNum
        call [printf]


        push scanNum
        push emptyStr
        call [scanf]

;������ for ��� �������� ������� ����� �� 1 �� scanNum �� ��������
;����������� ���������� ������� ����� � ecx
startPrime:
        mov ebx, 2
        lp:
                mov ecx, 1
                jmp isPrime
                postlp:
                inc ebx

                cmp ebx, [scanNum]
                jle lp
        ;����� ���������
        finish:


        invoke printf, resStr, [counter]

        ;��������, ����� ������� �� ���������
        call [getch]

        push 0
        call [ExitProcess]

;�������� ����� �� ��������===================
isPrime:

        inc [counter]         ;������� ������ ���-�� ������� ����� - ����� +1, � ���� ����� �� ������� �����, �� ������ 1
        stpr:
                inc ecx         ;�� 2 �� �������� ebx

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