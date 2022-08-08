	.arch armv6
	.eabi_attribute 28, 1
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 2
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"main.c"
	.text
	.global	__aeabi_uidiv
	.section	.text.startup,"ax",%progbits
	.align	2
	.global	main
	.arch armv6
	.syntax unified
	.arm
	.fpu vfp
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 64
	@ frame_needed = 0, uses_anonymous_args = 0
	cmp	r0, #2
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	mov	r7, r1
	sub	sp, sp, #68
	bgt	.L2
	ldr	r0, .L41+8
	bl	puts
	ldr	r1, [r7]
	ldr	r0, .L41+12
	bl	printf
	mov	r0, #1
	bl	exit
.L2:
	ldr	r1, .L41+16
	ldr	r0, [r7, #4]
	bl	fopen
	subs	r5, r0, #0
	beq	.L38
	mov	r3, r5
	mov	r2, #1
	mov	r1, #4
	add	r0, sp, #16
	bl	fread
	mov	r3, r5
	mov	r2, #1
	mov	r1, #4
	add	r0, sp, #12
	bl	fread
	add	r0, sp, #12
	bl	convert_int_to_big_endian
	mov	r3, r5
	mov	r2, #1
	mov	r1, #4
	str	r0, [sp, #20]
	add	r0, sp, #24
	bl	fread
	mov	r3, r5
	mov	r2, #1
	mov	r1, #4
	add	r0, sp, #28
	bl	fread
	mov	r3, r5
	mov	r2, #1
	mov	r1, #4
	add	r0, sp, #12
	bl	fread
	add	r0, sp, #12
	bl	convert_int_to_big_endian
	mov	r3, r5
	mov	r2, #1
	mov	r1, #2
	str	r0, [sp, #32]
	add	r0, sp, #8
	bl	fread
	add	r0, sp, #8
	bl	convert_short_to_big_endian
	mov	r3, r5
	mov	r2, #1
	mov	r1, #2
	strh	r0, [sp, #36]	@ movhi
	add	r0, sp, #8
	bl	fread
	add	r0, sp, #8
	bl	convert_short_to_big_endian
	mov	r3, r5
	mov	r2, #1
	mov	r1, #4
	strh	r0, [sp, #38]	@ movhi
	add	r0, sp, #12
	bl	fread
	add	r0, sp, #12
	bl	convert_int_to_big_endian
	mov	r3, r5
	mov	r2, #1
	mov	r1, #4
	str	r0, [sp, #40]
	add	r0, sp, #12
	bl	fread
	add	r0, sp, #12
	bl	convert_int_to_big_endian
	mov	r3, r5
	mov	r2, #1
	mov	r1, #2
	str	r0, [sp, #44]
	add	r0, sp, #8
	bl	fread
	add	r0, sp, #8
	bl	convert_short_to_big_endian
	mov	r3, r5
	mov	r2, #1
	mov	r1, #2
	strh	r0, [sp, #48]	@ movhi
	add	r0, sp, #8
	bl	fread
	add	r0, sp, #8
	bl	convert_short_to_big_endian
	mov	r3, r5
	mov	r2, #1
	mov	r1, #4
	strh	r0, [sp, #50]	@ movhi
	add	r0, sp, #52
	bl	fread
	mov	r3, r5
	mov	r2, #1
	mov	r1, #4
	add	r0, sp, #12
	bl	fread
	add	r0, sp, #12
	bl	convert_int_to_big_endian
	ldrh	r8, [sp, #38]
	ldrh	r4, [sp, #50]
	mul	r4, r8, r4
	asr	r4, r4, #3
	uxth	r4, r4
	mul	r8, r4, r8
	mov	r1, r8
	mov	r10, r0
	str	r0, [sp, #56]
	bl	__aeabi_uidiv
	mov	r1, r4
	mov	r6, r0
	bl	calloc
	cmp	r0, #0
	str	r0, [sp, #60]
	beq	.L4
	cmp	r10, r8
	movcs	r4, #0
	bcc	.L39
.L5:
	mov	r3, r5
	mov	r2, #1
	mov	r1, #2
	add	r0, sp, #8
	bl	fread
	add	r0, sp, #8
	bl	convert_short_to_big_endian
	ldr	r2, [sp, #60]
	lsl	r3, r4, #1
	add	r4, r4, #1
	cmp	r6, r4
	strh	r0, [r2, r3]	@ movhi
	bhi	.L5
	mov	r0, r5
	bl	fclose
	bl	clock
	mov	r1, #1
	str	r0, [sp, #4]
	mov	r0, r6
	bl	calloc
	subs	r3, r0, #0
	str	r3, [sp]
	beq	.L22
.L21:
	ldr	r3, [sp]
	add	r4, r6, #1
	add	r4, r3, r4
	lsl	r5, r6, #1
	mov	fp, r4
	mov	r9, r5
.L12:
	ldr	r2, [sp, #60]
	ldrsh	r1, [r2, r9]
	asr	r1, r1, #2
	cmp	r1, #0
	mvn	r0, r1
	uxth	r1, r1
	rsblt	r1, r1, #33
	addge	r1, r1, #33
	lsr	r0, r0, #31
	uxth	r1, r1
	bl	find_codeword
	subs	r9, r9, #2
	mvn	r0, r0
	strb	r0, [fp, #-1]!
	bne	.L12
	bl	clock
	ldr	r3, [sp]
	vldr.64	d6, .L41
	add	r9, r3, #1
	ldr	r3, [sp, #4]
	mov	r1, r6
	sub	r3, r0, r3
	ldr	r0, .L41+20
	vmov	s14, r3	@ int
	vcvt.f64.s32	d7, s14
	vdiv.f64	d7, d7, d6
	vmov	r2, r3, d7
	bl	printf
	bl	clock
	str	r0, [sp, #4]
.L20:
	ldrb	r3, [r4, #-1]!	@ zero_extendqisi2
	mvn	r3, r3
	uxtb	fp, r3
	mov	r0, fp
	bl	compressed_magnitude
	tst	fp, #128
	ldr	r3, [sp, #60]
	rsbeq	r0, r0, #33
	subne	r0, r0, #33
	cmp	r9, r4
	lsl	r0, r0, #2
	strh	r0, [r3, r5]	@ movhi
	sub	r5, r5, #2
	bne	.L20
.L16:
	bl	clock
	ldr	r3, [sp, #4]
	vldr.64	d6, .L41
	sub	r3, r0, r3
	ldr	r0, .L41+24
	vmov	s14, r3	@ int
	vcvt.f64.s32	d7, s14
	vdiv.f64	d7, d7, d6
	vmov	r2, r3, d7
	bl	printf
	ldr	r0, [r7, #8]
	ldr	r1, .L41+28
	bl	fopen
	subs	r5, r0, #0
	beq	.L40
	mov	r3, r5
	mov	r2, #1
	mov	r1, #4
	add	r0, sp, #16
	bl	fwrite
	ldr	r1, [sp, #20]
	add	r0, sp, #12
	bl	convert_int_to_little_endian
	mov	r3, r5
	mov	r2, #1
	mov	r1, #4
	add	r0, sp, #12
	bl	fwrite
	mov	r3, r5
	mov	r2, #1
	mov	r1, #4
	add	r0, sp, #24
	bl	fwrite
	mov	r3, r5
	mov	r2, #1
	mov	r1, #4
	add	r0, sp, #28
	bl	fwrite
	ldr	r1, [sp, #32]
	add	r0, sp, #12
	bl	convert_int_to_little_endian
	mov	r3, r5
	mov	r2, #1
	mov	r1, #4
	add	r0, sp, #12
	bl	fwrite
	ldrh	r1, [sp, #36]
	add	r0, sp, #8
	bl	convert_short_to_little_endian
	mov	r3, r5
	mov	r2, #1
	mov	r1, #2
	add	r0, sp, #8
	bl	fwrite
	ldrh	r1, [sp, #38]
	add	r0, sp, #8
	bl	convert_short_to_little_endian
	mov	r3, r5
	mov	r2, #1
	mov	r1, #2
	add	r0, sp, #8
	bl	fwrite
	ldr	r1, [sp, #40]
	add	r0, sp, #12
	bl	convert_int_to_little_endian
	mov	r3, r5
	mov	r2, #1
	mov	r1, #4
	add	r0, sp, #12
	bl	fwrite
	ldr	r1, [sp, #44]
	add	r0, sp, #12
	bl	convert_int_to_little_endian
	mov	r3, r5
	mov	r2, #1
	mov	r1, #4
	add	r0, sp, #12
	bl	fwrite
	ldrh	r1, [sp, #48]
	add	r0, sp, #8
	bl	convert_short_to_little_endian
	mov	r3, r5
	mov	r2, #1
	mov	r1, #2
	add	r0, sp, #8
	bl	fwrite
	ldrh	r1, [sp, #50]
	add	r0, sp, #8
	bl	convert_short_to_little_endian
	mov	r3, r5
	mov	r2, #1
	mov	r1, #2
	add	r0, sp, #8
	bl	fwrite
	mov	r3, r5
	mov	r2, #1
	mov	r1, #4
	add	r0, sp, #52
	bl	fwrite
	ldr	r1, [sp, #56]
	add	r0, sp, #12
	bl	convert_int_to_little_endian
	mov	r3, r5
	add	r0, sp, #12
	mov	r2, #1
	mov	r1, #4
	bl	fwrite
	cmp	r10, r8
	movcs	r4, #0
	bcc	.L19
.L18:
	ldr	r2, [sp, #60]
	lsl	r3, r4, #1
	add	r0, sp, #8
	ldrh	r1, [r2, r3]
	bl	convert_short_to_little_endian
	add	r4, r4, #1
	mov	r3, r5
	mov	r2, #1
	mov	r1, #2
	add	r0, sp, #8
	bl	fwrite
	cmp	r6, r4
	bhi	.L18
.L19:
	mov	r0, r5
	bl	fclose
	ldr	r0, [sp, #60]
	bl	free
	ldr	r0, [sp]
	bl	free
	mov	r0, #0
	bl	exit
.L38:
	ldr	r0, .L41+32
	bl	puts
	mov	r0, #1
	bl	exit
.L40:
	ldr	r0, .L41+36
	bl	puts
	mov	r0, #1
	bl	exit
.L4:
	ldr	r0, .L41+40
	bl	puts
	mov	r0, #1
	bl	exit
.L22:
	ldr	r0, .L41+44
	bl	puts
	mov	r0, #1
	bl	exit
.L39:
	mov	r0, r5
	bl	fclose
	bl	clock
	mov	r1, #1
	str	r0, [sp, #4]
	mov	r0, r6
	bl	calloc
	subs	r3, r0, #0
	str	r3, [sp]
	beq	.L22
	cmp	r6, #0
	bne	.L21
	bl	clock
	ldr	r3, [sp, #4]
	vldr.64	d6, .L41
	mov	r1, r6
	sub	r3, r0, r3
	ldr	r0, .L41+20
	vmov	s14, r3	@ int
	vcvt.f64.s32	d7, s14
	vdiv.f64	d7, d7, d6
	vmov	r2, r3, d7
	bl	printf
	bl	clock
	str	r0, [sp, #4]
	b	.L16
.L42:
	.align	3
.L41:
	.word	0
	.word	1093567616
	.word	.LC0
	.word	.LC1
	.word	.LC2
	.word	.LC9
	.word	.LC6
	.word	.LC7
	.word	.LC3
	.word	.LC8
	.word	.LC4
	.word	.LC5
	.size	main, .-main
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"Please enter the input and output file names.\000"
	.space	2
.LC1:
	.ascii	"Usage: %s <input file> <output file>\012\000"
	.space	2
.LC2:
	.ascii	"rb\000"
	.space	1
.LC3:
	.ascii	"Error opening file\000"
	.space	1
.LC4:
	.ascii	"Could not allocate memory for samples.\000"
	.space	1
.LC5:
	.ascii	"Could not allocate memory for compressed samples.\000"
	.space	2
.LC6:
	.ascii	"Decompressed in %.7fs\012\000"
	.space	1
.LC7:
	.ascii	"wb\000"
	.space	1
.LC8:
	.ascii	"Error creating output file\000"
	.space	1
.LC9:
	.ascii	"Compressed %u samples in %.7fs\012\000"
	.ident	"GCC: (Raspbian 8.3.0-6+rpi1) 8.3.0"
	.section	.note.GNU-stack,"",%progbits
