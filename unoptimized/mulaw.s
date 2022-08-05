	.arch armv4t
	.fpu softvfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 6
	.eabi_attribute 18, 4
	.file	"mulaw.c"
	.section	.rodata
	.align	2
.LC0:
	.ascii	"Could not allocate memory for compressed samples.\000"
	.text
	.align	2
	.global	compress
	.type	compress, %function
compress:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #16
	ldr	r3, .L6
	ldr	r3, [r3, #0]
	mov	r0, r3
	mov	r1, #1
	bl	calloc
	mov	r3, r0
	mov	r2, r3
	ldr	r3, .L6+4
	str	r2, [r3, #44]
	ldr	r3, .L6+4
	ldr	r3, [r3, #44]
	cmp	r3, #0
	bne	.L2
	ldr	r0, .L6+8
	bl	puts
	mov	r0, #1
	bl	exit
.L2:
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L3
.L4:
	ldr	r3, .L6+12
	ldr	r2, [r3, #44]
	ldr	r3, [fp, #-8]
	mov	r3, r3, asl #1
	add	r3, r2, r3
	ldrh	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, asr #16
	mov	r3, r3, asr #2
	strh	r3, [fp, #-14]	@ movhi
	ldrsh	r3, [fp, #-14]
	mov	r0, r3
	bl	signum
	mov	r3, r0
	strb	r3, [fp, #-10]
	ldrsh	r3, [fp, #-14]
	mov	r0, r3
	bl	magnitude
	mov	r3, r0
	add	r3, r3, #33
	strh	r3, [fp, #-12]	@ movhi
	ldrb	r3, [fp, #-10]	@ zero_extendqisi2
	ldrh	r2, [fp, #-12]
	mov	r0, r3
	mov	r1, r2
	bl	find_codeword
	mov	r3, r0
	strb	r3, [fp, #-9]
	ldrb	r3, [fp, #-9]
	mvn	r3, r3
	strb	r3, [fp, #-9]
	ldr	r3, .L6+4
	ldr	r2, [r3, #44]
	ldr	r3, [fp, #-8]
	add	r2, r2, r3
	ldrb	r3, [fp, #-9]
	strb	r3, [r2, #0]
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
.L3:
	ldr	r3, [fp, #-8]
	ldr	r2, .L6
	ldr	r2, [r2, #0]
	cmp	r3, r2
	bcc	.L4
	sub	sp, fp, #4
	ldmfd	sp!, {fp, lr}
	bx	lr
.L7:
	.align	2
.L6:
	.word	num_samples
	.word	compressed_wave
	.word	.LC0
	.word	wave
	.size	compress, .-compress
	.section	.rodata
	.align	2
.LC1:
	.ascii	"Invalid magnitude while compressing.\000"
	.align	2
.LC2:
	.ascii	"Magnitude: %d\012\000"
	.text
	.align	2
	.global	find_codeword
	.type	find_codeword, %function
find_codeword:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #16
	mov	r3, r0
	mov	r2, r1
	strb	r3, [fp, #-13]
	strh	r2, [fp, #-16]	@ movhi
	ldrh	r3, [fp, #-16]
	and	r3, r3, #4096
	cmp	r3, #0
	beq	.L9
	mov	r3, #7
	strb	r3, [fp, #-6]
	ldrh	r3, [fp, #-16]
	mov	r3, r3, lsr #8
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	and	r3, r3, #255
	and	r3, r3, #15
	strb	r3, [fp, #-5]
	b	.L10
.L9:
	ldrh	r3, [fp, #-16]
	and	r3, r3, #2048
	cmp	r3, #0
	beq	.L11
	mov	r3, #6
	strb	r3, [fp, #-6]
	ldrh	r3, [fp, #-16]
	mov	r3, r3, lsr #7
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	and	r3, r3, #255
	and	r3, r3, #15
	strb	r3, [fp, #-5]
	b	.L10
.L11:
	ldrh	r3, [fp, #-16]
	and	r3, r3, #1024
	cmp	r3, #0
	beq	.L12
	mov	r3, #5
	strb	r3, [fp, #-6]
	ldrh	r3, [fp, #-16]
	mov	r3, r3, lsr #6
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	and	r3, r3, #255
	and	r3, r3, #15
	strb	r3, [fp, #-5]
	b	.L10
.L12:
	ldrh	r3, [fp, #-16]
	and	r3, r3, #512
	cmp	r3, #0
	beq	.L13
	mov	r3, #4
	strb	r3, [fp, #-6]
	ldrh	r3, [fp, #-16]
	mov	r3, r3, lsr #5
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	and	r3, r3, #255
	and	r3, r3, #15
	strb	r3, [fp, #-5]
	b	.L10
.L13:
	ldrh	r3, [fp, #-16]
	and	r3, r3, #256
	cmp	r3, #0
	beq	.L14
	mov	r3, #3
	strb	r3, [fp, #-6]
	ldrh	r3, [fp, #-16]
	mov	r3, r3, lsr #4
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	and	r3, r3, #255
	and	r3, r3, #15
	strb	r3, [fp, #-5]
	b	.L10
.L14:
	ldrh	r3, [fp, #-16]
	and	r3, r3, #128
	cmp	r3, #0
	beq	.L15
	mov	r3, #2
	strb	r3, [fp, #-6]
	ldrh	r3, [fp, #-16]
	mov	r3, r3, lsr #3
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	and	r3, r3, #255
	and	r3, r3, #15
	strb	r3, [fp, #-5]
	b	.L10
.L15:
	ldrh	r3, [fp, #-16]
	and	r3, r3, #64
	cmp	r3, #0
	beq	.L16
	mov	r3, #1
	strb	r3, [fp, #-6]
	ldrh	r3, [fp, #-16]
	mov	r3, r3, lsr #2
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	and	r3, r3, #255
	and	r3, r3, #15
	strb	r3, [fp, #-5]
	b	.L10
.L16:
	ldrh	r3, [fp, #-16]
	and	r3, r3, #32
	cmp	r3, #0
	beq	.L17
	mov	r3, #0
	strb	r3, [fp, #-6]
	ldrh	r3, [fp, #-16]
	mov	r3, r3, lsr #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	and	r3, r3, #255
	and	r3, r3, #15
	strb	r3, [fp, #-5]
	b	.L10
.L17:
	ldr	r0, .L19
	bl	puts
	ldrh	r3, [fp, #-16]
	ldr	r0, .L19+4
	mov	r1, r3
	bl	printf
	mov	r0, #1
	bl	exit
.L10:
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	mov	r3, r3, asl #7
	and	r2, r3, #255
	ldrb	r3, [fp, #-6]	@ zero_extendqisi2
	mov	r3, r3, asl #4
	and	r3, r3, #255
	orr	r3, r2, r3
	and	r3, r3, #255
	ldrb	r2, [fp, #-5]	@ zero_extendqisi2
	mov	r1, r3
	mov	r3, r2
	orr	r3, r1, r3
	and	r3, r3, #255
	and	r3, r3, #255
	mov	r0, r3
	sub	sp, fp, #4
	ldmfd	sp!, {fp, lr}
	bx	lr
.L20:
	.align	2
.L19:
	.word	.LC1
	.word	.LC2
	.size	find_codeword, .-find_codeword
	.align	2
	.global	signum
	.type	signum, %function
signum:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #12
	mov	r3, r0
	strh	r3, [fp, #-6]	@ movhi
	ldrsh	r3, [fp, #-6]
	mvn	r3, r3
	mov	r3, r3, lsr #31
	mov	r0, r3
	add	sp, fp, #0
	ldmfd	sp!, {fp}
	bx	lr
	.size	signum, .-signum
	.align	2
	.global	compressed_signum
	.type	compressed_signum, %function
compressed_signum:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #12
	mov	r3, r0
	strb	r3, [fp, #-5]
	ldrb	r3, [fp, #-5]	@ zero_extendqisi2
	mov	r3, r3, asl #24
	mov	r3, r3, asr #24
	mvn	r3, r3
	mov	r3, r3, lsr #31
	mov	r0, r3
	add	sp, fp, #0
	ldmfd	sp!, {fp}
	bx	lr
	.size	compressed_signum, .-compressed_signum
	.align	2
	.global	magnitude
	.type	magnitude, %function
magnitude:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #12
	mov	r3, r0
	strh	r3, [fp, #-6]	@ movhi
	ldrsh	r3, [fp, #-6]
	cmp	r3, #0
	bge	.L26
	ldrh	r3, [fp, #-6]	@ movhi
	rsb	r3, r3, #0
	strh	r3, [fp, #-6]	@ movhi
.L26:
	ldrh	r3, [fp, #-6]
	mov	r0, r3
	add	sp, fp, #0
	ldmfd	sp!, {fp}
	bx	lr
	.size	magnitude, .-magnitude
	.section	.rodata
	.align	2
.LC3:
	.ascii	"Invalid chord while decompressing.\000"
	.align	2
.LC4:
	.ascii	"Chord: %d\012\000"
	.text
	.align	2
	.global	compressed_magnitude
	.type	compressed_magnitude, %function
compressed_magnitude:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #16
	mov	r3, r0
	strb	r3, [fp, #-13]
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	mov	r3, r3, lsr #4
	and	r3, r3, #255
	and	r3, r3, #7
	strb	r3, [fp, #-6]
	ldrb	r3, [fp, #-13]
	and	r3, r3, #15
	strb	r3, [fp, #-5]
	ldrb	r3, [fp, #-6]	@ zero_extendqisi2
	cmp	r3, #7
	bne	.L29
	ldrb	r3, [fp, #-5]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	orr	r3, r3, #4224
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	str	r3, [fp, #-20]
	b	.L30
.L29:
	ldrb	r3, [fp, #-6]	@ zero_extendqisi2
	cmp	r3, #6
	bne	.L31
	ldrb	r3, [fp, #-5]	@ zero_extendqisi2
	mov	r3, r3, asl #7
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	orr	r3, r3, #2112
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	str	r3, [fp, #-20]
	b	.L30
.L31:
	ldrb	r3, [fp, #-6]	@ zero_extendqisi2
	cmp	r3, #5
	bne	.L32
	ldrb	r3, [fp, #-5]	@ zero_extendqisi2
	mov	r3, r3, asl #6
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	orr	r3, r3, #1056
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	str	r3, [fp, #-20]
	b	.L30
.L32:
	ldrb	r3, [fp, #-6]	@ zero_extendqisi2
	cmp	r3, #4
	bne	.L33
	ldrb	r3, [fp, #-5]	@ zero_extendqisi2
	mov	r3, r3, asl #5
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	orr	r3, r3, #528
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	str	r3, [fp, #-20]
	b	.L30
.L33:
	ldrb	r3, [fp, #-6]	@ zero_extendqisi2
	cmp	r3, #3
	bne	.L34
	ldrb	r3, [fp, #-5]	@ zero_extendqisi2
	mov	r3, r3, asl #4
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	orr	r3, r3, #264
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	str	r3, [fp, #-20]
	b	.L30
.L34:
	ldrb	r3, [fp, #-6]	@ zero_extendqisi2
	cmp	r3, #2
	bne	.L35
	ldrb	r3, [fp, #-5]	@ zero_extendqisi2
	mov	r3, r3, asl #3
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	orr	r3, r3, #132
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	str	r3, [fp, #-20]
	b	.L30
.L35:
	ldrb	r3, [fp, #-6]	@ zero_extendqisi2
	cmp	r3, #1
	bne	.L36
	ldrb	r3, [fp, #-5]	@ zero_extendqisi2
	mov	r3, r3, asl #2
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	orr	r3, r3, #66
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	str	r3, [fp, #-20]
	b	.L30
.L36:
	ldrb	r3, [fp, #-6]	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L37
	ldrb	r3, [fp, #-5]	@ zero_extendqisi2
	mov	r3, r3, asl #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	orr	r3, r3, #33
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	str	r3, [fp, #-20]
	b	.L30
.L37:
	ldr	r0, .L39
	bl	puts
	ldrb	r3, [fp, #-6]	@ zero_extendqisi2
	ldr	r0, .L39+4
	mov	r1, r3
	bl	printf
	mov	r0, #1
	bl	exit
.L30:
	ldr	r3, [fp, #-20]
	mov	r0, r3
	sub	sp, fp, #4
	ldmfd	sp!, {fp, lr}
	bx	lr
.L40:
	.align	2
.L39:
	.word	.LC3
	.word	.LC4
	.size	compressed_magnitude, .-compressed_magnitude
	.align	2
	.global	decompress
	.type	decompress, %function
decompress:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #24
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L42
.L45:
	ldr	r3, .L47
	ldr	r2, [r3, #44]
	ldr	r3, [fp, #-8]
	add	r3, r2, r3
	ldrb	r3, [r3, #0]
	strb	r3, [fp, #-9]
	ldrb	r3, [fp, #-9]
	mvn	r3, r3
	strb	r3, [fp, #-9]
	ldrb	r3, [fp, #-9]	@ zero_extendqisi2
	mov	r0, r3
	bl	compressed_signum
	mov	r3, r0
	strb	r3, [fp, #-10]
	ldrb	r3, [fp, #-9]	@ zero_extendqisi2
	mov	r0, r3
	bl	compressed_magnitude
	mov	r3, r0
	strh	r3, [fp, #-12]	@ movhi
	ldrh	r3, [fp, #-12]	@ movhi
	sub	r3, r3, #33
	strh	r3, [fp, #-12]	@ movhi
	ldrb	r3, [fp, #-10]	@ zero_extendqisi2
	cmp	r3, #0
	beq	.L43
	ldrh	r3, [fp, #-12]
	rsb	r3, r3, #0
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	str	r3, [fp, #-24]
	b	.L44
.L43:
	ldrh	r3, [fp, #-12]
	str	r3, [fp, #-24]
.L44:
	ldr	r3, [fp, #-24]
	strh	r3, [fp, #-14]	@ movhi
	ldr	r3, .L47+4
	ldr	r2, [r3, #44]
	ldr	r3, [fp, #-8]
	mov	r3, r3, asl #1
	add	r2, r2, r3
	ldrsh	r3, [fp, #-14]
	mov	r3, r3, asl #2
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	strh	r3, [r2, #0]	@ movhi
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
.L42:
	ldr	r3, [fp, #-8]
	ldr	r2, .L47+8
	ldr	r2, [r2, #0]
	cmp	r3, r2
	bcc	.L45
	sub	sp, fp, #4
	ldmfd	sp!, {fp, lr}
	bx	lr
.L48:
	.align	2
.L47:
	.word	compressed_wave
	.word	wave
	.word	num_samples
	.size	decompress, .-decompress
	.ident	"GCC: (Sourcery G++ Lite 2008q3-72) 4.3.2"
	.section	.note.GNU-stack,"",%progbits
