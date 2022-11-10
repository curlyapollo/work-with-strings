	.intel_syntax noprefix		# using Intel-style syntax
	.text				# starting the section
	.globl	analysis		# declaring and exporting outside the "analysis" symbol
	.type	analysis, @function	# type of the analysis is the function
analysis:
	push	rbp			# save stack pointer
	mov	rbp, rsp		# move stack pointer to the new position
	push	rbx			# save new pointer
	sub	rsp, 56			# allocation of memory on the stack
	mov	QWORD PTR -56[rbp], rdi	# rbp[-56] := rdi = text - getting the argument
	mov	r12d, 0			# r12d := 0 ~~ l = 0
	mov	r13d, 0			# r13d := 0 ~~ r = 0
	jmp	.L2			# jump to mark .L2
.L5:
	add	r12d, 1			# r12d += 1 ~~ l++
.L3:
	mov	eax, r12d		# eax := r12d = l
	movsx	rdx, eax		# analogue of cdqe
	mov	rax, QWORD PTR -56[rbp]	# rax := rbp[-56] = text
	add	rax, rdx		# rax += rdx ~~ text[l]
	movzx	eax, BYTE PTR [rax]	# analogue of cdqe
	test	al, al			# text[l] & text[l] ?
	je	.L4			# if previous value is equal to 0 jump to mark .L4
	call	__ctype_b_loc@PLT	# isalpha
	mov	rdx, QWORD PTR [rax]	# rdx := rax
	mov	eax, r12d		# eax := r12d = l
	movsx	rcx, eax		# analogue of cdqe
	mov	rax, QWORD PTR -56[rbp]	# rax := rbp[-56] = text
	add	rax, rcx		# rax += rcx ~~ text[l]
	movzx	eax, BYTE PTR [rax]	# analogue of cdqe
	movsx	rax, al			# --||--
	add	rax, rax		# rax += rax
	add	rax, rdx		# rax += rdx
	movzx	eax, WORD PTR [rax]	# analogue of cdqe
	movzx	eax, ax			# --||--
	and	eax, 1024		# eax & 1024
	test	eax, eax		# eax is 0?
	je	.L5			# if previous value is equal to 0 jump to mark .L5
.L4:
	mov	eax, r12d		# eax := r12d = l
	mov	r13d, eax		# r13d := eax = l ~~ r = l
	jmp	.L6			# jump to mark .L6
.L8:
	add	r13d, 1			# r13d += 1 ~~ r++
.L6:
	mov	eax, r13d		# eax := r13d = r
	movsx	rdx, eax		# analogue of cdqe
	mov	rax, QWORD PTR -56[rbp]	# rax := rbp[-56] = text
	add	rax, rdx		# rax += rdx ~~ text[r]
	movzx	eax, BYTE PTR [rax]	# analogue of cdqe
	test	al, al			# text[l] & text[l] is 0?
	je	.L7			# if previous value is equal to 0 jump to mark .L7
	call	__ctype_b_loc@PLT	# call isalpha
	mov	rdx, QWORD PTR [rax]	# rdx := rax
	mov	eax, r13d		# eax := r13d = r
	movsx	rcx, eax		# analogue of cdqe
	mov	rax, QWORD PTR -56[rbp]	# rax := rbp[-56] = text
	add	rax, rcx		# rax += rcx ~~ text[r]
	movzx	eax, BYTE PTR [rax]	# analogue of cdqe
	movsx	rax, al			# --||--
	add	rax, rax		# rax += rax
	add	rax, rdx		# rax += rdx
	movzx	eax, WORD PTR [rax]	# analogue of cdqe
	movzx	eax, ax			# --||--
	and	eax, 1024		# eax &= 1024
	test	eax, eax		# eax & eax is 0?
	jne	.L8			# if previous value is not equal to 0 jump to mark .L8
.L7:
	mov	eax, r13d		# eax := r13d = r
	sub	eax, r12d		# r -= l
	test	eax, eax		# is r 0?
	jle	.L9			# if r - l <= 0 jump to mark .L9
	mov	r14d, 0			# r14d := 0 ~~ i = 0
	jmp	.L10			# jump to mark .L10
.L15:
	mov	eax, r13d		# eax := r13d = r
	sub	eax, r12d		# eax -= r12d ~~ r - l
	movsx	rbx, eax		# analogue of cdqe
	mov	eax, r14d		# eax := r14d = i
	cdqe				# cast eax (int i) to rax (long long i)
	lea	rdx, 0[0+rax*8]		# calculating the address (rax*8)[0], which is equal to rax*8
	lea	rax, words[rip]		# rax := rip[words] - address of the beginning of the array
	mov	rax, QWORD PTR [rdx+rax]# rax := &words[i]
	mov	rdi, rax		# rdi := rax - putting in the argument of the function &words[i]
	call	strlen@PLT		# call strlen(words[i])
	cmp	rbx, rax		# comparison of r - l and strlen(words[i])
	jne	.L11			# if r - l != strlen(words[i]) jump to mark .L11
	mov	r15d, 1			# r15d := 1 ~~ is_same = 11
	mov	eax, r12d		# eax := r12d = l
	mov	r11d, eax		# r11d := eax ~~ j = l
	jmp	.L12			# jump to mark .L12
.L14:
	mov	eax, r11d		# eax := r11d = j
	movsx	rdx, eax		# analogue of cdqe
	mov	rax, QWORD PTR -56[rbp]	# eax := rbp[-56] ~~ text
	add	rax, rdx		# rax + rdx ~~ text[j]
	movzx	edx, BYTE PTR [rax]	# analogue of cdqe
	mov	eax, r14d		# eax := r14d = i
	cdqe				# cast eax (int i) to rax (long long i)
	lea	rcx, 0[0+rax*8]		# calculating the address (rax*8)[0], which is equal to rax*8
	lea	rax, words[rip]		# rax := rip[words] - address of the beginning of the array
	mov	rcx, QWORD PTR [rcx+rax]# rcx := &words[i]
	mov	eax, r11d		# eax := r11d = j
	sub	eax, r12d		# eax -= r12d ~~ j - l
	cdqe				# cast eax (int i) to rax (long long i)
	add	rax, rcx		# rax += rcx
	movzx	eax, BYTE PTR [rax]	# analogue of cdqe
	cmp	dl, al			# comparison of edx and eax (text[j] = words[i][j - l])
	je	.L13			# if previous comparison is equal jump to mark .L13
	mov	r15d, 0			# r15d := 0 ~~ is_same = 0
.L13:
	add	r11d, 1			# r11d += 1 ~~ j++
.L12:
	mov	eax, r11d		# eax := r11d = j
	cmp	eax, r13d		# comparison of j and r
	jl	.L14			# if j < r jump to mark .L14
	cmp	r15d, 0			# comparison of is_same and 0
	je	.L11			# if is_same == 0 jump to mark .L11
	mov	eax, r14d		# eax := r14d = i
	cdqe				# cast eax (int i) to rax (long long i)
	lea	rdx, 0[0+rax*4]		# calculating the address (rax*4)[0], which is equal to rax*4
	lea	rax, cnt[rip]		# rax := rip[cnt] - address of the beginning of the array
	mov	eax, DWORD PTR [rdx+rax]# eax := &cnt[i]
	lea	ecx, 1[rax]		# ecx := rax[1]
	mov	eax, r14d		# eax := r14d = i
	cdqe				# cast eax (int i) to rax (long long i)
	lea	rdx, 0[0+rax*4]		# calculating the address (rax*4)[0], which is equal to rax*4
	lea	rax, cnt[rip]		# rax := rip[cnt] - address of the beginning of the array
	mov	DWORD PTR [rdx+rax], ecx# cnt[i] := ecx
.L11:
	add	r14d, 1			# r14d += 1 ~~ i++
.L10:
	cmp	r14d, 4			# comparison of r14d(i) and 4
	jle	.L15			# if i <= 4 jump to mark .L15
.L9:
	mov	eax, r13d		# eax := r13d = r
	mov	r12d, eax		# r12d := eax = r ~~ l = r
.L2:
	mov	eax, r12d		# eax := r12d = l
	movsx	rdx, eax		# analogue of cdqe
	mov	rax, QWORD PTR -56[rbp]	# rax := rbp[-56] = text
	add	rax, rdx		# rax += rdx ~~ text[l]
	movzx	eax, BYTE PTR [rax]	# analogue of cdqe
	test	al, al			# text[l] & text[l] ?
	jne	.L3			# if previous value is not equal to 0 jump to mark .L3
	mov	rbx, QWORD PTR -8[rbp]	# rbx := rbp[-8]
	leave				# leave the function
	ret				# return to call function

