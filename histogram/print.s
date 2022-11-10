	.intel_syntax noprefix		# using Intel-style syntax
	.text				# starting the section
	.section	.rodata		# section .rodata
.LC0:
	.string	"%s %d\n"		# mark for "%s %d\n"
	.text				# code section
	.globl	print			# declaring and exporting outside "print" symbol
	.type	print, @function	# type of the print is the function
print:
	push	rbp			# save stack pointer
	mov	rbp, rsp		# move stack pointer to the new position
	sub	rsp, 32			# reserve 32 bytes on stack
	mov	QWORD PTR -24[rbp], rdi	# getting the &output from the argument rdi
	mov	r12d, 0			# r12d := 0 ~~ i = 0
	jmp	.L2			# jump to the mark .L2
.L3:
	mov	eax, r12d		# eax := r12d = i
	cdqe				# cast eax (int i) to rax (long long i)
	lea	rdx, 0[0+rax*4]		# calculating the address (rax*4)[0], which is equal to rax*4
	lea	rax, cnt[rip]		# rax := &rip[cnt] - address of the beginning of the array
	mov	ecx, DWORD PTR [rdx+rax]# ecx := &cnt[i]
	mov	eax, r12d		# eax := r12d = i
	cdqe				# cast eax (int i) to rax (long long i)
	lea	rdx, 0[0+rax*8]		# calculating the address (rax*8)[0], which is equal to rax*8
	lea	rax, words[rip]		# rax := &rip[words] - address of the beginning of the array
	mov	rdx, QWORD PTR [rdx+rax]# rdx := &words[i]
	mov	rax, QWORD PTR -24[rbp]	# rax := rbp[-24] = &output
	lea	rsi, .LC0[rip]		# rsi := rip[,LC0] = "%s %d\n" - putting in the 2nd argument "%s %d\n"
	mov	rdi, rax		# rdi := rax = &output
	mov	eax, 0			# eax := 0 - zeroing out rax
	call	fprintf@PLT		# call fprintf(rdi, rsi, rdx, ecx) ~~ fprint(&output, "%s %d\n", &words[i], &cnt[i])
	add	r12d, 1			# r12d += 1 ~~ i++
.L2:
	cmp	r12d, 4			# comparison r12d and 4 ~~ i and 4
	jle	.L3			# jump in mark .L3 if i <= 4
	leave				# else leave the function
	ret				# return;
