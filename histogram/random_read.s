	.intel_syntax noprefix		# using Intel-style syntax
	.text				# starting the section
	.globl	random_read		# declaration and exporting outside "random_read" symbol
	.type	random_read, @function	# type of the random_read is the function
random_read:
	push	rbp			# save stack pointer
	mov	rbp, rsp		# move stack pointer to the new position
	sub	rsp, 16			# reserve 32 bytes on stack
	mov	edi, 1			# edi := 1 - seed
	call	srand@PLT		# call srand(1) - set seed
	call	rand@PLT		# call eax := rand()
	movsx	rdx, eax		# cast eax to rdx
	imul	rdx, rdx, 91625969	# rdx := rdx * integer
	shr	rdx, 32			# rdx >> 32
	sar	edx, 5			# edx << 5
	mov	ecx, eax		# ecx := eax
	sar	ecx, 31			# ecx << 31
	sub	edx, ecx		# edx -= ecx
	mov	DWORD PTR -8[rbp], edx	# rbp[-8] := edx
	mov	edx, DWORD PTR -8[rbp]	# edx := rbp[-8]
	imul	edx, edx, 1500		# edx := edx * 1500
	sub	eax, edx		# eax -= edx
	mov	DWORD PTR -8[rbp], eax	# rbp[-8] := eax
	mov	eax, DWORD PTR -8[rbp]	# eax := rbp[-8]
	cdqe				# cast
	sal	rax, 3			# rax >> 3
	mov	rdi, rax		# rdi := rax = n * sizeof(char*)
	call	malloc@PLT		# call malloc(rdi)
	mov	QWORD PTR -16[rbp], rax	# rbp[-16] := rax
	mov	r12d, 0			# r12d := 0 ~~ i = 0
	jmp	.L2			# jump to mark .L2
.L3:
	call	rand@PLT		# call rand()
	cdq				# analogue cdqe
	shr	edx, 25			# edx >> 32
	add	eax, edx		# eax += edx
	and	eax, 127		# eax &= 127
	sub	eax, edx		# eax -= edx
	mov	ecx, eax		# ecx := eax
	mov	eax, r12d		# eax := r12d = i
	movsx	rdx, eax		# analogue of cdqe
	mov	rax, QWORD PTR -16[rbp]	# rax := rbp[-16] = text
	add	rax, rdx		# rax + rdx ~~ text[i]
	mov	edx, ecx		# edx := ecx
	mov	BYTE PTR [rax], dl	# rax := dl
	mov	eax, r12d		# eax := r12d = i
	movsx	rdx, eax		# analogue of cdqe
	mov	rax, QWORD PTR -16[rbp]	# rax := rbp[-16] = text
	add	rax, rdx		# rax + rdx ~~ text[i]
	movzx	eax, BYTE PTR [rax]	# analogue of cdqe
	movsx	eax, al			# analogue of cdqe
	mov	edi, eax		# edi := eax = text[i]
	call	putchar@PLT		# call putchar(text[i])
	add	r12d, 1			# r12d += 1 ~~ i++
.L2:
	mov	eax, r12d		# eax := r12d = i
	cmp	eax, DWORD PTR -8[rbp]	# comparison of i and rbp[-8] ~~ n
	jl	.L3			# if i < n jump to mark .L3
	mov	rax, QWORD PTR -16[rbp]	# rax := rbp[-16] = text
	leave				# leave the function
	ret				# return rax(text);
