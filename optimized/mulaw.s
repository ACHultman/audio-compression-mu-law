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
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {r4, fp, lr}
	add	fp, sp, #8
	sub	sp, sp, #28
	ldr	r3, .L8
	ldr	r3, [r3, #0]
	mov	r0, r3
	mov	r1, #1
	bl	calloc
	mov	r3, r0
	mov	r2, r3
	ldr	r3, .L8+4
	str	r2, [r3, #44]
	ldr	r3, .L8+4
	ldr	r3, [r3, #44]
	cmp	r3, #0
	bne	.L2
	ldr	r0, .L8+8
	bl	puts
	mov	r0, #1
	bl	exit
.L2:
	ldr	r3, .L8
	ldr	r3, [r3, #0]
	str	r3, [fp, #-16]
	b	.L3
.L6:
	ldr	r3, .L8+12
	ldr	r2, [r3, #44]
	ldr	r3, [fp, #-16]
	mov	r3, r3, asl #1
	add	r3, r2, r3
	ldrh	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, asr #16
	mov	r3, r3, asr #2
	strh	r3, [fp, #-22]	@ movhi
	ldrh	r3, [fp, #-22]	@ movhi
	mvn	r3, r3
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r3, r3, lsr #15
	strb	r3, [fp, #-18]
	ldrsh	r3, [fp, #-22]
	cmp	r3, #0
	bge	.L4
	ldrh	r3, [fp, #-22]
	rsb	r3, r3, #33
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	str	r3, [fp, #-32]
	b	.L5
.L4:
	ldrh	r3, [fp, #-22]
	add	r3, r3, #33
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	str	r3, [fp, #-32]
.L5:
	ldr	r3, [fp, #-32]
	strh	r3, [fp, #-20]	@ movhi
	ldr	r3, .L8+4
	ldr	r2, [r3, #44]
	ldr	r3, [fp, #-16]
	add	r4, r2, r3
	ldrb	r3, [fp, #-18]	@ zero_extendqisi2
	ldrh	r2, [fp, #-20]
	mov	r0, r3
	mov	r1, r2
	bl	find_codeword
	mov	r3, r0
	mvn	r3, r3
	and	r3, r3, #255
	strb	r3, [r4, #0]
	ldr	r3, [fp, #-16]
	sub	r3, r3, #1
	str	r3, [fp, #-16]
.L3:
	ldr	r3, [fp, #-16]
	cmp	r3, #0
	bne	.L6
	sub	sp, fp, #8
	ldmfd	sp!, {r4, fp, lr}
	bx	lr
.L9:
	.align	2
.L8:
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
	beq	.L11
	mov	r3, #7
	strb	r3, [fp, #-6]
	ldrh	r3, [fp, #-16]
	mov	r3, r3, lsr #8
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	and	r3, r3, #255
	and	r3, r3, #15
	strb	r3, [fp, #-5]
	b	.L12
.L11:
	ldrh	r3, [fp, #-16]
	and	r3, r3, #2048
	cmp	r3, #0
	beq	.L13
	mov	r3, #6
	strb	r3, [fp, #-6]
	ldrh	r3, [fp, #-16]
	mov	r3, r3, lsr #7
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	and	r3, r3, #255
	and	r3, r3, #15
	strb	r3, [fp, #-5]
	b	.L12
.L13:
	ldrh	r3, [fp, #-16]
	and	r3, r3, #1024
	cmp	r3, #0
	beq	.L14
	mov	r3, #5
	strb	r3, [fp, #-6]
	ldrh	r3, [fp, #-16]
	mov	r3, r3, lsr #6
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	and	r3, r3, #255
	and	r3, r3, #15
	strb	r3, [fp, #-5]
	b	.L12
.L14:
	ldrh	r3, [fp, #-16]
	and	r3, r3, #512
	cmp	r3, #0
	beq	.L15
	mov	r3, #4
	strb	r3, [fp, #-6]
	ldrh	r3, [fp, #-16]
	mov	r3, r3, lsr #5
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	and	r3, r3, #255
	and	r3, r3, #15
	strb	r3, [fp, #-5]
	b	.L12
.L15:
	ldrh	r3, [fp, #-16]
	and	r3, r3, #256
	cmp	r3, #0
	beq	.L16
	mov	r3, #3
	strb	r3, [fp, #-6]
	ldrh	r3, [fp, #-16]
	mov	r3, r3, lsr #4
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	and	r3, r3, #255
	and	r3, r3, #15
	strb	r3, [fp, #-5]
	b	.L12
.L16:
	ldrh	r3, [fp, #-16]
	and	r3, r3, #128
	cmp	r3, #0
	beq	.L17
	mov	r3, #2
	strb	r3, [fp, #-6]
	ldrh	r3, [fp, #-16]
	mov	r3, r3, lsr #3
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	and	r3, r3, #255
	and	r3, r3, #15
	strb	r3, [fp, #-5]
	b	.L12
.L17:
	ldrh	r3, [fp, #-16]
	and	r3, r3, #64
	cmp	r3, #0
	beq	.L18
	mov	r3, #1
	strb	r3, [fp, #-6]
	ldrh	r3, [fp, #-16]
	mov	r3, r3, lsr #2
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	and	r3, r3, #255
	and	r3, r3, #15
	strb	r3, [fp, #-5]
	b	.L12
.L18:
	ldrh	r3, [fp, #-16]
	and	r3, r3, #32
	cmp	r3, #0
	beq	.L19
	mov	r3, #0
	strb	r3, [fp, #-6]
	ldrh	r3, [fp, #-16]
	mov	r3, r3, lsr #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	and	r3, r3, #255
	and	r3, r3, #15
	strb	r3, [fp, #-5]
	b	.L12
.L19:
	ldr	r0, .L21
	bl	puts
	ldrh	r3, [fp, #-16]
	ldr	r0, .L21+4
	mov	r1, r3
	bl	printf
	mov	r0, #1
	bl	exit
.L12:
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
.L22:
	.align	2
.L21:
	.word	.LC1
	.word	.LC2
	.size	find_codeword, .-find_codeword
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
	ldrls	pc, [pc, r3, asl #2]
	b	.L24
.L33:
	.word	.L25
	.word	.L26
	.word	.L27
	.word	.L28
	.word	.L29
	.word	.L30
	.word	.L31
	.word	.L32
.L25:
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
	b	.L34
.L26:
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
	b	.L34
.L27:
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
	b	.L34
.L28:
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
	b	.L34
.L29:
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
	b	.L34
.L30:
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
	b	.L34
.L31:
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
	b	.L34
.L32:
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
	b	.L34
.L24:
	ldr	r0, .L36
	bl	puts
	ldrb	r3, [fp, #-6]	@ zero_extendqisi2
	ldr	r0, .L36+4
	mov	r1, r3
	bl	printf
	mov	r0, #1
	bl	exit
.L34:
	ldr	r3, [fp, #-20]
	mov	r0, r3
	sub	sp, fp, #4
	ldmfd	sp!, {fp, lr}
	bx	lr
.L37:
	.align	2
.L36:
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
	ldr	r3, .L44
	ldr	r3, [r3, #0]
	str	r3, [fp, #-8]
	b	.L39
.L42:
	ldr	r3, .L44+4
	ldr	r2, [r3, #44]
	ldr	r3, [fp, #-8]
	add	r3, r2, r3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mvn	r3, r3
	strb	r3, [fp, #-9]
	ldrb	r3, [fp, #-9]	@ zero_extendqisi2
	mvn	r3, r3
	and	r3, r3, #255
	mov	r3, r3, lsr #7
	strb	r3, [fp, #-10]
	ldrb	r3, [fp, #-9]	@ zero_extendqisi2
	mov	r0, r3
	bl	compressed_magnitude
	mov	r3, r0
	sub	r3, r3, #33
	strh	r3, [fp, #-12]	@ movhi
	ldr	r3, .L44+8
	ldr	r2, [r3, #44]
	ldr	r3, [fp, #-8]
	mov	r3, r3, asl #1
	add	r2, r2, r3
	str	r2, [fp, #-28]
	ldrb	r3, [fp, #-10]	@ zero_extendqisi2
	cmp	r3, #0
	beq	.L40
	ldrh	r3, [fp, #-12]
	rsb	r3, r3, #0
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r3, r3, asl #16
	mov	r3, r3, asr #16
	mov	r3, r3, asl #2
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	str	r3, [fp, #-24]
	b	.L41
.L40:
	ldrh	r3, [fp, #-12]
	mov	r3, r3, asl #16
	mov	r3, r3, asr #16
	mov	r3, r3, asl #2
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	str	r3, [fp, #-24]
.L41:
	ldr	r2, [fp, #-24]
	ldr	r3, [fp, #-28]
	strh	r2, [r3, #0]	@ movhi
	ldr	r3, [fp, #-8]
	sub	r3, r3, #1
	str	r3, [fp, #-8]
.L39:
	ldr	r3, [fp, #-8]
	cmp	r3, #0
	bne	.L42
	sub	sp, fp, #4
	ldmfd	sp!, {fp, lr}
	bx	lr
.L45:
	.align	2
.L44:
	.word	num_samples
	.word	compressed_wave
	.word	wave
	.size	decompress, .-decompress
	.ident	"GCC: (Sourcery G++ Lite 2008q3-72) 4.3.2"
	.section	.note.GNU-stack,"",%progbits
