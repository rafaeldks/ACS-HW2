	.intel_syntax noprefix
	.text # Начало новой секции
	
	.globl	revstr # Директива для отображения функции видимой для линкера
	.type	revstr, @function # Определение как функции
revstr:
	endbr64 # End branch 64 bit
	push	rbp # Кладём rbp на стек
	mov	rbp, rsp # rbp = rsp
	sub	rsp, 32 # rsp -= 32 (выделение памяти под функцию)
	mov	QWORD PTR -24[rbp], rdi # rbp[-24] := rdi (представляет из себя первый параметр функции revstr в коде на C)
	mov	rdi, QWORD PTR -24[rbp] # rdi:= rbp[-24] - Оптимизация
	call	strlen@PLT # Вызов strlen
	mov	r14d, eax # r14d:= eax
	mov	r12d, 0 # (начало цикла, как i := 0 в коде C), можно заменить i на регистр
	jmp	.L2 # Переход к циклу на .L2
.L3:
	mov	eax, r12d # eax:= r12d=i
	movsx	rdx, eax # rdx:= eax с сохранением знака в битах
	mov	rax, QWORD PTR -24[rbp] # rax:= rbp[-24]
	add	rax, rdx # rax += rdx
	movzx	eax, BYTE PTR [rax] # eax := [rax] с дополнением результата нулевыми битами
	movsx	eax, al # eax:= al с сохранением знака в битах
	mov	DWORD PTR -12[rbp], eax # rbp[-12] = eax
	mov	eax, r14d #eax:= r14d
	sub	eax, r12d #eax = r12d=i
	cdqe # sign-extend, отвечает за сохранение знака числа i в регистре rax (лучше оставить, чтобы наверняка ничего не сломалось)
	lea	rdx, -1[rax]
	mov	rax, QWORD PTR -24[rbp] # rax:= rbp[-24]
	add	rax, rdx # rax+= rdx
	mov	edx, r12d # edx:= r12d=i
	movsx	rcx, edx # rcx:= edx с сохранением знака в битах
	mov	rdx, QWORD PTR -24[rbp] # rdx:= rbp[-24]
	add	rdx, rcx # rdx+=rcx
	movzx	eax, BYTE PTR [rax] # eax := [rax] с дополнением результата нулевыми битами
	mov	BYTE PTR [rdx], al #rdx:= al
	mov	eax, r14d # eax:= r14d
	sub	eax, r12d # eax -= r12d=i
	cdqe # sign-extend, отвечает за сохранение знака числа i в регистре rax (лучше оставить, чтобы наверняка ничего не сломалось)
	lea	rdx, -1[rax] # rdx:= &rax[-1] запоминаем эффективный адрес в rdx
	mov	rax, QWORD PTR -24[rbp] # rax:= rbp[-24]
	add	rax, rdx # rax += rdx
	mov	edx, DWORD PTR -12[rbp] # edx:= rbp[-12]
	mov	BYTE PTR [rax], dl # rax:= dl
	add	r12d, 1 # r12d += 1, другими словами i++
.L2:
	mov	eax, r14d # eax:= r14d
	mov	edx, eax # edx:= eax
	shr	edx, 31 # Побитовый сдвиг вправо edx на 31 бит
	add	eax, edx # eax+=edx
	sar	eax # Арифметический сдвиг eax вправо
	cmp	r12d, eax # команда сравнения чисел, находящегося в регистре eax и в регистре r12d=i, которая заполняет флаги сравнения
	jl	.L3 # Если eax=i<len/2, то переходим к .L3
	leave # Выход из функции с удалением фрейма из стека
	ret # Выход из процедуры
	.size	revstr, .-revstr # Метаинформация:
	
	.globl	printChangedString # Директива для отображения функции видимой для линкера
	.type	printChangedString, @function # Определение как функции
printChangedString:
	endbr64 # End branch 64 bit
	push	rbp # Кладём rbp на стек
	mov	rbp, rsp # rbp:=rsp
	push	rbx # Кладём rbx на стек для вызова внутренней функции revstr
	sub	rsp, 88 # rsp -= 88 (выделение памяти под функции)
	mov	QWORD PTR -88[rbp], rdi # rbp[-88] := rdi (представляет из себя первый параметр функции printChangedString в коде на C)
	mov	QWORD PTR -80[rbp], 0
	mov	QWORD PTR -72[rbp], 0
	mov	QWORD PTR -64[rbp], 0
	mov	QWORD PTR -56[rbp], 0
	mov	QWORD PTR -48[rbp], 0
	mov	QWORD PTR -40[rbp], 0
	mov	WORD PTR -32[rbp], 0 # Выделение 7 байтов на строки word и text
	mov	r13d, 0 # i = 0, начало цикла
	jmp	.L5 # Переходим к циклу на .L5
.L8: # Тело цикла, где проверяется длинное условие проверки на то, является ли символ буквой
	mov	eax, r13d # eax:= r13d=i
	movsx	rdx, eax # rdx:= eax с сохранением знака в битах
	mov	rax, QWORD PTR -88[rbp] # rax:= rbp[-88]
	add	rax, rdx # rax+= rdx
	movzx	eax, BYTE PTR [rax] # eax := [rax] с дополнением результата нулевыми битами
	cmp	al, 64 # команда сравнения числа, находящегося в аккумуляторном регистре al, с числом 64 которая заполняет флаги сравнения
	setle	al # al:=1, если al<=64
	movzx	edx, al # edx = al с дополнением результата нулевыми битами
	mov	eax, r13d # eax:= r13d=i
	movsx	rcx, eax # rcx:= eax с сохранением знака в битах
	mov	rax, QWORD PTR -88[rbp] # rax:=rbp[-88]
	add	rax, rcx # rax += rcx
	movzx	eax, BYTE PTR [rax] # eax := [rax] с дополнением результата нулевыми битами
	cmp	al, 90 # команда сравнения числа, находящегося в аккумуляторном регистре al, с числом 90 которая заполняет флаги сравнения
	setg	sil # sil:=1 если al>90
	mov	eax, r13d # eax:=r13d=i
	movsx	rcx, eax # rcx := eax с сохранением знака в битах
	mov	rax, QWORD PTR -88[rbp] # rax:=rbp[-88]
	add	rax, rcx # rax += rcx
	movzx	eax, BYTE PTR [rax] # eax:= [rax] с сохранением знака в битах
	cmp	al, 96 # команда сравнения числа, находящегося в аккумуляторном регистре al, с числом 96 которая заполняет флаги сравнения
	setle	al # al:=1 если al<=96
	and	eax, esi # eax:= побитовое умножение eax на esi
	movzx	eax, al # eax := [rax] с дополнением результата нулевыми битами
	mov	ecx, edx # ecx:= edx
	or	ecx, eax # ecx:= логическое сложение ecx и eax
	mov	eax, r13d # eax:= r13d=i
	movsx	rdx, eax # rdx := eax с сохранением знака в битах
	mov	rax, QWORD PTR -88[rbp] # rax:= rbp[-88]
	add	rax, rdx # rax+= rdx
	movzx	eax, BYTE PTR [rax] # eax := [rax] с дополнением результата нулевыми битами
	cmp	al, 122 # команда сравнения числа, находящегося в аккумуляторном регистре al, с числом 122 которая заполняет флаги сравнения
	setg	al # al:=1 если al>122
	movzx	eax, al # eax := al с сохранением знака в битах
	or	eax, ecx # eax:= логическое сложение eax и ecx
	test	eax, eax # Выполняет логическое И и заполняет флаги
	je	.L6 # Если логическое условие на проверку на букву не выполнилось, переходим к .L6
	lea	rax, -80[rbp] # rax:= &rbp[-80], запоминаем эффективный адрес в rax
	mov	rdi, rax # rdi:= rax
	call	revstr # Вызов revstr
	lea	rax, -80[rbp]
	mov	rdi, rax # rdi:= rax
	xor	eax, eax # eax:= 0, Оптимизация
	call	printf@PLT # Вызов printf
	movsx	rdx, r13d # rdx:= r13d=i, Оптимизация
	mov	rax, QWORD PTR -88[rbp] # rax:= rbp[-88]
	add	rax, rdx # rax+= rdx
	movzx	eax, BYTE PTR [rax] # eax := [rax] с дополнением результата нулевыми битами
	movsx	eax, al # eax := al с сохранением знака в битах
	mov	edi, eax # edi:= eax
	call	putchar@PLT # Вызов putchar
	mov	BYTE PTR -80[rbp], 0 # rbp[-80]:= 0
	jmp	.L7 # Переходим к .L7
.L6:
	mov	eax, r13d # eax:= r13d=i
	movsx	rdx, eax # rdx:= eax с сохранением знака в битах
	mov	rax, QWORD PTR -88[rbp] # rax:= rbp[-88]
	lea	rcx, [rdx+rax] # rcx:= &[rdx+rax]
	lea	rax, -80[rbp] # rax:= rbp[-80]
	mov	edx, 1 # edx:= 1
	mov	rsi, rcx # rsi:= rcx
	mov	rdi, rax # rdi:= rax
	call	strncat@PLT # Вызов strncat
.L7:
	add	r13d, 1 # r13d += 1, иначе говоря i++
.L5:
	mov	eax, r13d # eax:= r13d=i (помещаем i в eax, чтобы использовать регистр в качестве аккумулятора)
	movsx	rbx, eax # rbx:= eax с сохранением знака в битах
	mov	rax, QWORD PTR -88[rbp] # rax:= rbp[-88]
	mov	rdi, rax # rdi:=rax
	call	strlen@PLT # Вызов strlen
	cmp	rbx, rax # команда сравнения чисел, находящихся в регистрах eax и rax, которая заполняет флаги сравнения
	jb	.L8 # Если i< strlen, то переходим к .L8
	lea	rax, -80[rbp] # rax:= &rbp[-80] запоминаем эффективный адрес
	mov	rdi, rax # rdi:= rax
	call	revstr # Вызов revstr
	lea	rax, -80[rbp] # rax:= rbp[-80]
	mov	rdi, rax # rdi:= rax
	xor	eax, eax # eax:= 0, Оптимизация
	call	printf@PLT # Вызов printf
	mov	rbx, QWORD PTR -8[rbp] # rbx:= rbp[-8]
	leave # Выход из функции с удалением фрейма из стека
	ret # Выход из процедуры
	.size	printChangedString, .-printChangedString # Метаданные
	
	.globl	main # Директива для отображения функции видимой для линкера
	.type	main, @function # Определение как функции
main:
	endbr64 # End branch 64 bit
	push	rbp # Кладём rbp на стек
	mov	rbp, rsp # rbp:= rsp
	sub	rsp, 112 # rsp -= 112 (выделение памяти под функцию)
	lea	rax, -112[rbp] # rax:= &rbp[-112] запоминаем эффективный адрес
	mov	rdi, rax # rdi:= rax
	xor	eax, eax # eax:=0, Оптимизация
	call	gets@PLT # вызов gets для чтения строки
	lea	rax, -112[rbp] # rax:= &rbp[-112] запоминаем эффективный адрес
	mov	rdi, rax # rdi:= rax
	call	printChangedString # вызов printChangedString
	xor	eax, eax # eax:= 0, Оптимизация
	leave # Выход из функции с удалением фрейма из стека
	ret # Выход из процедуры
	.size	main, .-main # Метаданные