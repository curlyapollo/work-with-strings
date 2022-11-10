	.intel_syntax noprefix			# using Intel-style syntax
	.text					# starting the section
	.globl	words				# declaring and exporting outside the "words" symbol
	.section	.rodata			# section .rodata
.LC0:
	.string	"if"				# mark for "if"
.LC1:
	.string	"else"				# mark for "else"
.LC2:
	.string	"for"				# mark for "for"
.LC3:
	.string	"int"				# mark for "int"
.LC4:
	.string	"void"				# mark for "void"
	.section	.data.rel.local,"aw"
	.align 32				# stack alignment
	.type	words, @object			# type of the words is the object
	.size	words, 40			# size of the words equals 40 bytes
words:
	.quad	.LC0				# filling words
	.quad	.LC1				# --||--
	.quad	.LC2				# --||--
	.quad	.LC3				# --||--
	.quad	.LC4				# --||--
	.globl	cnt				# declaring and exporting outside the "cnt" symbol
	.bss					# memory allocation section
	.align 16				# stack alignment
	.type	cnt, @object			# type of the cnt is the object
	.size	cnt, 20				# size of the words equals 20 bytes
cnt:
	.zero	20				# generating of 20 spaces
	.section	.rodata			# section .rodata
.LC5:
	.string	"r"				# mark for "r"
.LC6:
	.string	"w"				# mark for "w"
.LC7:
	.string	"Elapsed: %ld ns\n"		# mark for "Elapsed: %ld ns\n"
	.text					# starting the section
	.globl	main				# declaring and exporting outside the "main" symbol
	.type	main, @function			# type of the main is the function
main:
	push	rbp				# save stack pointer
	mov	rbp, rsp			# move stack pointer to the new position
	sub	rsp, 80				# reserve 80 bytes on stack
	mov	r12d, edi			# r12d := edi - getting 1st argument argc
	mov	QWORD PTR -80[rbp], rsi		# rbp[-80] := rsi - getting 2nd argument argv
	mov	rax, QWORD PTR -80[rbp]		# rax := argv
	add	rax, 8				# rax += 8 - &argv[1]
	mov	rax, QWORD PTR [rax]		# rax := argv[1]
	lea	rdx, .LC5[rip]			# rdx := rip[.LC5] = "r"
	mov	rsi, rdx			# rsi := rdx - putting in the 2nd argument "r"
	mov	rdi, rax			# rdi := rax - putting in the 1st argument argv[1]
	call	fopen@PLT			# call fopen(rdi, rsi) ~~ fopen(argv[1], "r")
	mov	QWORD PTR -16[rbp], rax		# rbp[-16] := rax - saving
	mov	rax, QWORD PTR -80[rbp]		# rax := argv
	add	rax, 16				# rax += 16 ~~ &argv[2]
	mov	rax, QWORD PTR [rax]		# rax := argv[2]
	lea	rdx, .LC6[rip]			# rdx := rip[.LC6] = "w"
	mov	rsi, rdx			# rsi := rdx - putting in the 2nd argument "w"
	mov	rdi, rax			# rdi := rax - putting in the 1st argument argv[2]
	call	fopen@PLT			# call fopen(rdi, rsi) ~~ fopen(argv[2], "w")
	mov	QWORD PTR -24[rbp], rax		# rbp[-24] := rax
	cmp	r12d, 4				# comparison of r12d and 4 ~~ argc and 4
	jne	.L2				# if argc != 4 jump to .L2
	mov	eax, 0				# eax := 0 - zeroing out rax
	call	random_read@PLT			# call random_read()
	mov	QWORD PTR -8[rbp], rax		# rbp[-8] := rax
	jmp	.L3				# jump to mark .L3
.L2:
	mov	rax, QWORD PTR -16[rbp]		# rax := rbp[-16] - backup
	mov	rdi, rax			# rdi := rax = argv[1] - putting in th2 1st argument argv[1]
	call	read_text@PLT			# call read_text(argv[1])
	mov	QWORD PTR -8[rbp], rax		# rbp[-8] := rax - saving
.L3:
	lea	rax, -48[rbp]			# rax := rbp[-48] = &start
	mov	rsi, rax			# rsi := rax - putting in the 2nd argument &start
	mov	edi, 1				# edi := 1 - putting in the 1st argument 1
	call	clock_gettime@PLT		# call clock_gettime(edi, rsi) ~~ clock_gettime(1, &start)
	mov	rax, QWORD PTR -8[rbp]		# rax := text
	mov	rdi, rax			# rdi := rax = text - putting in the 1st argument text
	call	analysis@PLT			# call analysis(text)
	lea	rax, -64[rbp]			# rax := rbp[-64] = &end
	mov	rsi, rax			# rsi := rax = &end - putting in the 2nd argument &end
	mov	edi, 1				# edi := 1 - putting in the 1st argument 1
	call	clock_gettime@PLT		# call clock_gettime(edi, rsi) ~~ clock_gettime(1, &end)
	mov	rax, QWORD PTR -48[rbp]		# rax := rbp[-48]
	mov	rdx, QWORD PTR -40[rbp]		# rdx := rbp[-40]
	mov	rdi, QWORD PTR -64[rbp]		# rdi := rbp[-64] = &end
	mov	rsi, QWORD PTR -56[rbp]		# rsi := rbp[-56] = &start
	mov	rcx, rdx			# rcx := rdx
	mov	rdx, rax			# rdx := rax
	call	time_dif@PLT			# call time_dif(rdi, rsi) ~~ time_dif(&end, &start)
	mov	QWORD PTR -32[rbp], rax		# rbp[-32] := rax
	mov	rax, QWORD PTR -24[rbp]		# rax := rbp[-24]
	mov	rdi, rax			# rdi := rax = argv[2] - putting in the 1st argument argv[2]
	call	print@PLT			# call print(rdi) ~~ print(argv[2])
	mov	rax, QWORD PTR -32[rbp]		# rax := rbp[-32] = time
	mov	rsi, rax			# rsi := rax = time
	lea	rax, .LC7[rip]			# rax := rip[.LC7] = "Elapsed: %ld ns\n"
	mov	rdi, rax			# putting string in the 1st argument
	mov	eax, 0				# eax := 0 - zeroing out rax
	call	printf@PLT			# call printf(rdi, rsi) ~~ printf("Elapsed: %ld ns", time)
	mov	rax, QWORD PTR -8[rbp]		# rax := rbp[-8] = text
	mov	rdi, rax			# rdi := rax = text
	call	free@PLT			# call free(text)
	mov	eax, 0				# eax := 0 - zeroing out rax
	leave					# leave the function
	ret					# return 0;
