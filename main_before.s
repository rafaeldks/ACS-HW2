	.file	"test.c"
	.intel_syntax noprefix
	.text
	.globl	revstr
	.type	revstr, @function
revstr:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR -24[rbp], rdi
	mov	rax, QWORD PTR -24[rbp]
	mov	rdi, rax
	call	strlen@PLT
	mov	DWORD PTR -8[rbp], eax
	mov	DWORD PTR -4[rbp], 0
	jmp	.L2
.L3:
	mov	eax, DWORD PTR -4[rbp]
	movsx	rdx, eax
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	mov	DWORD PTR -12[rbp], eax
	mov	eax, DWORD PTR -8[rbp]
	sub	eax, DWORD PTR -4[rbp]
	cdqe
	lea	rdx, -1[rax]
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	mov	edx, DWORD PTR -4[rbp]
	movsx	rcx, edx
	mov	rdx, QWORD PTR -24[rbp]
	add	rdx, rcx
	movzx	eax, BYTE PTR [rax]
	mov	BYTE PTR [rdx], al
	mov	eax, DWORD PTR -8[rbp]
	sub	eax, DWORD PTR -4[rbp]
	cdqe
	lea	rdx, -1[rax]
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	mov	edx, DWORD PTR -12[rbp]
	mov	BYTE PTR [rax], dl
	add	DWORD PTR -4[rbp], 1
.L2:
	mov	eax, DWORD PTR -8[rbp]
	mov	edx, eax
	shr	edx, 31
	add	eax, edx
	sar	eax
	cmp	DWORD PTR -4[rbp], eax
	jl	.L3
	nop
	nop
	leave
	ret
	.size	revstr, .-revstr
	.globl	printChangedString
	.type	printChangedString, @function
printChangedString:
	endbr64
	push	rbp
	mov	rbp, rsp
	push	rbx
	sub	rsp, 88
	mov	QWORD PTR -88[rbp], rdi
	mov	QWORD PTR -80[rbp], 0
	mov	QWORD PTR -72[rbp], 0
	mov	QWORD PTR -64[rbp], 0
	mov	QWORD PTR -56[rbp], 0
	mov	QWORD PTR -48[rbp], 0
	mov	QWORD PTR -40[rbp], 0
	mov	WORD PTR -32[rbp], 0
	mov	DWORD PTR -20[rbp], 0
	jmp	.L5
.L8:
	mov	eax, DWORD PTR -20[rbp]
	movsx	rdx, eax
	mov	rax, QWORD PTR -88[rbp]
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	cmp	al, 64
	setle	al
	movzx	edx, al
	mov	eax, DWORD PTR -20[rbp]
	movsx	rcx, eax
	mov	rax, QWORD PTR -88[rbp]
	add	rax, rcx
	movzx	eax, BYTE PTR [rax]
	cmp	al, 90
	setg	sil
	mov	eax, DWORD PTR -20[rbp]
	movsx	rcx, eax
	mov	rax, QWORD PTR -88[rbp]
	add	rax, rcx
	movzx	eax, BYTE PTR [rax]
	cmp	al, 96
	setle	al
	and	eax, esi
	movzx	eax, al
	mov	ecx, edx
	or	ecx, eax
	mov	eax, DWORD PTR -20[rbp]
	movsx	rdx, eax
	mov	rax, QWORD PTR -88[rbp]
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	cmp	al, 122
	setg	al
	movzx	eax, al
	or	eax, ecx
	test	eax, eax
	je	.L6
	lea	rax, -80[rbp]
	mov	rdi, rax
	call	revstr
	lea	rax, -80[rbp]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	mov	eax, DWORD PTR -20[rbp]
	movsx	rdx, eax
	mov	rax, QWORD PTR -88[rbp]
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	mov	edi, eax
	call	putchar@PLT
	mov	BYTE PTR -80[rbp], 0
	jmp	.L7
.L6:
	mov	eax, DWORD PTR -20[rbp]
	movsx	rdx, eax
	mov	rax, QWORD PTR -88[rbp]
	lea	rcx, [rdx+rax]
	lea	rax, -80[rbp]
	mov	edx, 1
	mov	rsi, rcx
	mov	rdi, rax
	call	strncat@PLT
.L7:
	add	DWORD PTR -20[rbp], 1
.L5:
	mov	eax, DWORD PTR -20[rbp]
	movsx	rbx, eax
	mov	rax, QWORD PTR -88[rbp]
	mov	rdi, rax
	call	strlen@PLT
	cmp	rbx, rax
	jb	.L8
	lea	rax, -80[rbp]
	mov	rdi, rax
	call	revstr
	lea	rax, -80[rbp]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	nop
	mov	rbx, QWORD PTR -8[rbp]
	leave
	ret
	.size	printChangedString, .-printChangedString
	.globl	main
	.type	main, @function
main:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 112
	lea	rax, -112[rbp]
	mov	rdi, rax
	mov	eax, 0
	call	gets@PLT
	lea	rax, -112[rbp]
	mov	rdi, rax
	call	printChangedString
	mov	eax, 0
	leave
	ret
	.size	main, .-main
	.ident	"GCC: (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:

