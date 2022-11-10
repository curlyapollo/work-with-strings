	.intel_syntax noprefix		# using Intel-style syntax
	.text				# starting the section
	.globl	read_text		# declaring and exporting outside "read_text" symbol
	.type	read_text, @function	# type of the read_text is the function
read_text:
	push	rbp			# save stack pointer
	mov	rbp, rsp		# move stack pointer to the new position
	sub	rsp, 48			# reserve 48 bytes on stack
	mov	QWORD PTR -40[rbp], rdi	# getting the &input from the argument rdi
	mov	r12d, 0			# r12d := 0 ~~ size = 0
	mov	r13d, 1			# r13d := 1 ~~ capacity = 1
	mov	eax, r13d		# eax := r13d = capacity
	cdqe				# cast eax (int capacity) to rax (long long capacity)
	mov	rdi, rax		# rdi := rax = capacity
	call	malloc@PLT		# call malloc(rdi)
	mov	QWORD PTR -16[rbp], rax	# rbp[-16] := rax = text
	jmp	.L2			# jump to the mark .L2
.L4:
	mov	eax, r12d		# eax := r12d = size
	cmp	eax, r13d		# comparison of size and capacity
	jl	.L3			# if r12d < r13d jump to the mark .L3
	sal	r13d			# r13d << 1 ~~ capacity *= 2
	mov	eax, r13d		# eax := r13d = capacity
	movsx	rdx, eax		# analogue of cdqe
	mov	rax, QWORD PTR -16[rbp]	# rax := rbp[-16] = text
	mov	rsi, rdx		# rsi := rdx = capacity
	mov	rdi, rax		# rdi := rax = text
	call	realloc@PLT		# call realloc(text, capacity)
	mov	QWORD PTR -16[rbp], rax	# rbp[-16] := rax = text
.L3:
	mov	eax, r12d		# eax := r12d = size
	movsx	rdx, eax		# analogue of cdqe
	mov	rax, QWORD PTR -16[rbp]	# rax := rbp[-16]
	add	rdx, rax		# rdx += rax = text[size]
	movzx	eax, BYTE PTR -17[rbp]	# analogue of cdqe
	mov	BYTE PTR [rdx], al	# rdx := al
	add	r12d, 1			# r12d += 1 ~~ size++
.L2:
	mov	rax, QWORD PTR -40[rbp]	# rax := rbp[-40] = &input
	mov	rdi, rax		# rdi := rax = &input
	call	fgetc@PLT		# call fgetc(&input)
	mov	BYTE PTR -17[rbp], al	# rbp[-17] = al
	cmp	BYTE PTR -17[rbp], -1	# comparison of current and eof
	jne	.L4			# if not equal jump to .L4
	mov	eax, r12d		# eax := r12d = size
	cmp	eax, r13d		# comparison of the size and capacity
	jl	.L5			# if size < capacity jump to the mark .L5
	sal	r13d			# sal << 1 ~~ capacity *= 2
	mov	eax, r13d		# eax := r13d = capacity
	movsx	rdx, eax		# analogue of cdqe
	mov	rax, QWORD PTR -16[rbp]	# rax := rbp[-16] = text
	mov	rsi, rdx		# rsi := rdx = capacity
	mov	rdi, rax		# rdi := rax = text
	call	realloc@PLT		# call realloc(text, capacity)
	mov	QWORD PTR -16[rbp], rax	# rbp[-16] = rax = realloc
.L5:
	mov	eax, r12d		# eax := r12d = size
	movsx	rdx, eax		# analogue of cdqe
	mov	rax, QWORD PTR -16[rbp]	# rax := rbp[-16] = text
	add	rax, rdx		# rax += rdx ~~ text[size]
	mov	BYTE PTR [rax], 0	# rax := 0
	mov	rax, QWORD PTR -16[rbp]	# rax := text
	leave				# leave the function
	ret				# return text;
