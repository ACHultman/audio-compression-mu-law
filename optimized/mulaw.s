	.arch armv4t
	.fpu softvfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 2
	.eabi_attribute 18, 4
	.file	"mulaw.c"
	.text
	.align	2
	.global	compressed_magnitude
	.type	compressed_magnitude, %function
compressed_magnitude:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	mov	r3, r0, lsr #4
	stmfd	sp!, {r4, lr}
	and	r4, r3, #7
	and	r0, r0, #15
	cmp	r4, #7
	ldrls	pc, [pc, r4, asl #2]
	b	.L2
.L11:
	.word	.L3
	.word	.L4
	.word	.L5
	.word	.L6
	.word	.L7
	.word	.L8
	.word	.L9
	.word	.L10
.L2:
	ldr	r0, .L15
	bl	puts
	mov	r1, r4
	ldr	r0, .L15+4
	bl	printf
	mov	r0, #1
	bl	exit
.L3:
	mov	r3, r0, asl #1
	orr	r0, r3, #33
.L12:
	ldmfd	sp!, {r4, lr}
	bx	lr
.L4:
	mov	r3, r0, asl #2
	orr	r0, r3, #66
	b	.L12
.L5:
	mov	r3, r0, asl #3
	orr	r0, r3, #132
	b	.L12
.L6:
	mov	r3, r0, asl #4
	orr	r0, r3, #264
	b	.L12
.L7:
	mov	r3, r0, asl #5
	orr	r0, r3, #528
	b	.L12
.L8:
	mov	r3, r0, asl #6
	orr	r0, r3, #1056
	b	.L12
.L9:
	mov	r3, r0, asl #7
	orr	r0, r3, #2112
	b	.L12
.L10:
	mov	r3, r0, asl #8
	orr	r0, r3, #4224
	b	.L12
.L16:
	.align	2
.L15:
	.word	.LC0
	.word	.LC1
	.size	compressed_magnitude, .-compressed_magnitude
	.align	2
	.global	find_codeword
	.type	find_codeword, %function
find_codeword:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	tst	r1, #4096
	movne	r3, r1, lsr #8
	stmfd	sp!, {r4, lr}
	mov	r2, r0
	mov	r4, r1
	movne	r0, #112
	andne	r1, r3, #15
	bne	.L19
	tst	r4, #2048
	movne	r3, r4, lsr #7
	andne	r1, r3, #15
	movne	r0, #96
	bne	.L19
	tst	r4, #1024
	movne	r3, r4, lsr #6
	andne	r1, r3, #15
	movne	r0, #80
	bne	.L19
	tst	r4, #512
	movne	r3, r4, lsr #5
	andne	r1, r3, #15
	movne	r0, #64
	bne	.L19
	tst	r4, #256
	movne	r3, r4, lsr #4
	andne	r1, r3, #15
	movne	r0, #48
	bne	.L19
	tst	r4, #128
	movne	r3, r4, lsr #3
	andne	r1, r3, #15
	movne	r0, #32
	bne	.L19
	ands	r0, r4, #64
	movne	r3, r4, lsr #2
	andne	r1, r3, #15
	movne	r0, #16
	bne	.L19
	tst	r4, #32
	movne	r3, r4, lsr #1
	andne	r1, r3, #15
	bne	.L19
	ldr	r0, .L28
	bl	puts
	mov	r1, r4
	ldr	r0, .L28+4
	bl	printf
	mov	r0, #1
	bl	exit
.L19:
	orr	r0, r0, r2, asl #7
	and	r0, r0, #240
	orr	r0, r0, r1
	ldmfd	sp!, {r4, lr}
	bx	lr
.L29:
	.align	2
.L28:
	.word	.LC2
	.word	.LC3
	.size	find_codeword, .-find_codeword
	.align	2
	.global	decompress
	.type	decompress, %function
decompress:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, .L48
	ldr	r0, [r3, #0]
	cmp	r0, #0
	stmfd	sp!, {r4, r5, r6, lr}
	beq	.L46
	ldr	r5, .L48+4
	ldr	r6, .L48+8
	mov	ip, r0, asl #1
.L45:
	ldr	r3, [r5, #44]
	ldrb	r2, [r3, r0]	@ zero_extendqisi2
	mvn	r2, r2
	and	r1, r2, #255
	mov	r3, r1, lsr #4
	and	r4, r3, #7
	and	r2, r2, #15
	cmp	r4, #7
	ldrls	pc, [pc, r4, asl #2]
	b	.L32
.L41:
	.word	.L33
	.word	.L34
	.word	.L35
	.word	.L36
	.word	.L37
	.word	.L38
	.word	.L39
	.word	.L40
.L32:
	ldr	r0, .L48+12
	bl	puts
	mov	r1, r4
	ldr	r0, .L48+16
	bl	printf
	mov	r0, #1
	bl	exit
.L40:
	mov	r3, r2, asl #8
	orr	r2, r3, #4224
.L42:
	sub	r3, r2, #33
	mov	r3, r3, asl #16
	tst	r1, #128
	mov	r2, r3, lsr #16
	rsbeq	r3, r2, #0
	moveq	r3, r3, asl #18
	movne	r3, r2, asl #18
	ldr	r1, [r6, #44]
	moveq	r2, r3, lsr #16
	movne	r2, r3, lsr #16
	subs	r0, r0, #1
	strh	r2, [r1, ip]	@ movhi
	sub	ip, ip, #2
	bne	.L45
.L46:
	ldmfd	sp!, {r4, r5, r6, lr}
	bx	lr
.L39:
	mov	r3, r2, asl #7
	orr	r2, r3, #2112
	b	.L42
.L38:
	mov	r3, r2, asl #6
	orr	r2, r3, #1056
	b	.L42
.L37:
	mov	r3, r2, asl #5
	orr	r2, r3, #528
	b	.L42
.L36:
	mov	r3, r2, asl #4
	orr	r2, r3, #264
	b	.L42
.L35:
	mov	r3, r2, asl #3
	orr	r2, r3, #132
	b	.L42
.L34:
	mov	r3, r2, asl #2
	orr	r2, r3, #66
	b	.L42
.L33:
	mov	r3, r2, asl #1
	orr	r2, r3, #33
	b	.L42
.L49:
	.align	2
.L48:
	.word	num_samples
	.word	compressed_wave
	.word	wave
	.word	.LC0
	.word	.LC1
	.size	decompress, .-decompress
	.align	2
	.global	compress
	.type	compress, %function
compress:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, lr}
	ldr	r4, .L68
	mov	r1, #1
	ldr	r0, [r4, #0]
	bl	calloc
	ldr	r6, .L68+4
	cmp	r0, #0
	str	r0, [r6, #44]
	beq	.L67
	ldr	r0, [r4, #0]
	cmp	r0, #0
	beq	.L65
	ldr	r7, .L68+8
	mov	ip, r0, asl #1
.L64:
	ldr	r2, [r7, #44]
	ldrsh	r3, [r2, ip]
	mov	r3, r3, asl #14
	mov	r3, r3, lsr #16
	movs	r5, r3, asl #16
	rsbmi	r3, r3, #33
	addpl	r3, r3, #33
	movmi	r3, r3, asl #16
	movpl	r3, r3, asl #16
	movmi	r4, r3, lsr #16
	movpl	r4, r3, lsr #16
	tst	r4, #4096
	movne	r3, r4, lsr #8
	ldr	lr, [r6, #44]
	andne	r1, r3, #15
	movne	r2, #112
	bne	.L56
	tst	r4, #2048
	movne	r3, r4, lsr #7
	andne	r1, r3, #15
	movne	r2, #96
	bne	.L56
	tst	r4, #1024
	movne	r3, r4, lsr #6
	andne	r1, r3, #15
	movne	r2, #80
	bne	.L56
	tst	r4, #512
	movne	r3, r4, lsr #5
	andne	r1, r3, #15
	movne	r2, #64
	bne	.L56
	tst	r4, #256
	movne	r3, r4, lsr #4
	andne	r1, r3, #15
	movne	r2, #48
	bne	.L56
	tst	r4, #128
	movne	r3, r4, lsr #3
	andne	r1, r3, #15
	movne	r2, #32
	bne	.L56
	ands	r2, r4, #64
	movne	r3, r4, lsr #2
	andne	r1, r3, #15
	movne	r2, #16
	bne	.L56
	tst	r4, #32
	beq	.L63
	mov	r3, r4, lsr #1
	and	r1, r3, #15
.L56:
	mov	r3, r5, asr #16
	mvn	r3, r3
	mov	r3, r3, lsr #31
	orr	r3, r2, r3, asl #7
	orr	r3, r3, r1
	mvn	r3, r3
	strb	r3, [lr, r0]
	subs	r0, r0, #1
	sub	ip, ip, #2
	bne	.L64
.L65:
	ldmfd	sp!, {r4, r5, r6, r7, r8, lr}
	bx	lr
.L67:
	ldr	r0, .L68+12
	bl	puts
	mov	r0, #1
	bl	exit
.L63:
	ldr	r0, .L68+16
	bl	puts
	mov	r1, r4
	ldr	r0, .L68+20
	bl	printf
	mov	r0, #1
	bl	exit
.L69:
	.align	2
.L68:
	.word	num_samples
	.word	compressed_wave
	.word	wave
	.word	.LC4
	.word	.LC2
	.word	.LC3
	.size	compress, .-compress
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"Invalid chord while decompressing.\000"
	.space	1
.LC1:
	.ascii	"Chord: %d\012\000"
	.space	1
.LC2:
	.ascii	"Invalid magnitude while compressing.\000"
	.space	3
.LC3:
	.ascii	"Magnitude: %d\012\000"
	.space	1
.LC4:
	.ascii	"Could not allocate memory for compressed samples.\000"
	.ident	"GCC: (Sourcery G++ Lite 2008q3-72) 4.3.2"
	.section	.note.GNU-stack,"",%progbits
