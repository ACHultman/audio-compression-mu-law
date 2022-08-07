	.arch armv6
	.eabi_attribute 28, 1
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 6
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"mulaw.c"
	.text
	.section	.rodata
	.align	2
.LC0:
	.ascii	"Could not allocate memory for compressed samples.\000"
	.text
	.align	2
	.global	compress
	.arch armv6
	.syntax unified
	.arm
	.fpu vfp
	.type	compress, %function
compress:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #16
	ldr	r3, .L5
	ldr	r3, [r3]
	mov	r1, #1
	mov	r0, r3
	bl	calloc
	mov	r3, r0
	mov	r2, r3
	ldr	r3, .L5+4
	str	r2, [r3, #44]
	ldr	r3, .L5+4
	ldr	r3, [r3, #44]
	cmp	r3, #0
	bne	.L2
	ldr	r0, .L5+8
	bl	puts
	mov	r0, #1
	bl	exit
.L2:
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L3
.L4:
	ldr	r3, .L5+12
	ldr	r2, [r3, #44]
	ldr	r3, [fp, #-8]
	lsl	r3, r3, #1
	add	r3, r2, r3
	ldrsh	r3, [r3]
	asr	r3, r3, #2
	strh	r3, [fp, #-10]	@ movhi
	ldrsh	r3, [fp, #-10]
	mov	r0, r3
	bl	signum
	mov	r3, r0
	strb	r3, [fp, #-11]
	ldrsh	r3, [fp, #-10]
	mov	r0, r3
	bl	magnitude
	mov	r3, r0
	add	r3, r3, #33
	strh	r3, [fp, #-14]	@ movhi
	ldrh	r2, [fp, #-14]
	ldrb	r3, [fp, #-11]	@ zero_extendqisi2
	mov	r1, r2
	mov	r0, r3
	bl	find_codeword
	mov	r3, r0
	strb	r3, [fp, #-15]
	ldrb	r3, [fp, #-15]
	mvn	r3, r3
	strb	r3, [fp, #-15]
	ldr	r3, .L5+4
	ldr	r2, [r3, #44]
	ldr	r3, [fp, #-8]
	add	r3, r2, r3
	ldrb	r2, [fp, #-15]
	strb	r2, [r3]
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
.L3:
	ldr	r2, [fp, #-8]
	ldr	r3, .L5
	ldr	r3, [r3]
	cmp	r2, r3
	bcc	.L4
	nop
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L6:
	.align	2
.L5:
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
	.syntax unified
	.arm
	.fpu vfp
	.type	find_codeword, %function
find_codeword:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #16
	mov	r3, r0
	mov	r2, r1
	strb	r3, [fp, #-13]
	mov	r3, r2	@ movhi
	strh	r3, [fp, #-16]	@ movhi
	ldrh	r3, [fp, #-16]
	and	r3, r3, #4096
	cmp	r3, #0
	beq	.L8
	mov	r3, #7
	strb	r3, [fp, #-5]
	ldrh	r3, [fp, #-16]
	lsr	r3, r3, #8
	uxth	r3, r3
	uxtb	r3, r3
	and	r3, r3, #15
	strb	r3, [fp, #-6]
	b	.L9
.L8:
	ldrh	r3, [fp, #-16]
	and	r3, r3, #2048
	cmp	r3, #0
	beq	.L10
	mov	r3, #6
	strb	r3, [fp, #-5]
	ldrh	r3, [fp, #-16]
	lsr	r3, r3, #7
	uxth	r3, r3
	uxtb	r3, r3
	and	r3, r3, #15
	strb	r3, [fp, #-6]
	b	.L9
.L10:
	ldrh	r3, [fp, #-16]
	and	r3, r3, #1024
	cmp	r3, #0
	beq	.L11
	mov	r3, #5
	strb	r3, [fp, #-5]
	ldrh	r3, [fp, #-16]
	lsr	r3, r3, #6
	uxth	r3, r3
	uxtb	r3, r3
	and	r3, r3, #15
	strb	r3, [fp, #-6]
	b	.L9
.L11:
	ldrh	r3, [fp, #-16]
	and	r3, r3, #512
	cmp	r3, #0
	beq	.L12
	mov	r3, #4
	strb	r3, [fp, #-5]
	ldrh	r3, [fp, #-16]
	lsr	r3, r3, #5
	uxth	r3, r3
	uxtb	r3, r3
	and	r3, r3, #15
	strb	r3, [fp, #-6]
	b	.L9
.L12:
	ldrh	r3, [fp, #-16]
	and	r3, r3, #256
	cmp	r3, #0
	beq	.L13
	mov	r3, #3
	strb	r3, [fp, #-5]
	ldrh	r3, [fp, #-16]
	lsr	r3, r3, #4
	uxth	r3, r3
	uxtb	r3, r3
	and	r3, r3, #15
	strb	r3, [fp, #-6]
	b	.L9
.L13:
	ldrh	r3, [fp, #-16]
	and	r3, r3, #128
	cmp	r3, #0
	beq	.L14
	mov	r3, #2
	strb	r3, [fp, #-5]
	ldrh	r3, [fp, #-16]
	lsr	r3, r3, #3
	uxth	r3, r3
	uxtb	r3, r3
	and	r3, r3, #15
	strb	r3, [fp, #-6]
	b	.L9
.L14:
	ldrh	r3, [fp, #-16]
	and	r3, r3, #64
	cmp	r3, #0
	beq	.L15
	mov	r3, #1
	strb	r3, [fp, #-5]
	ldrh	r3, [fp, #-16]
	lsr	r3, r3, #2
	uxth	r3, r3
	uxtb	r3, r3
	and	r3, r3, #15
	strb	r3, [fp, #-6]
	b	.L9
.L15:
	ldrh	r3, [fp, #-16]
	and	r3, r3, #32
	cmp	r3, #0
	beq	.L16
	mov	r3, #0
	strb	r3, [fp, #-5]
	ldrh	r3, [fp, #-16]
	lsr	r3, r3, #1
	uxth	r3, r3
	uxtb	r3, r3
	and	r3, r3, #15
	strb	r3, [fp, #-6]
	b	.L9
.L16:
	ldr	r0, .L18
	bl	puts
	ldrh	r3, [fp, #-16]
	mov	r1, r3
	ldr	r0, .L18+4
	bl	printf
	mov	r0, #1
	bl	exit
.L9:
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	lsl	r3, r3, #7
	sxtb	r2, r3
	ldrb	r3, [fp, #-5]	@ zero_extendqisi2
	lsl	r3, r3, #4
	sxtb	r3, r3
	orr	r3, r2, r3
	sxtb	r2, r3
	ldrsb	r3, [fp, #-6]
	orr	r3, r2, r3
	sxtb	r3, r3
	uxtb	r3, r3
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L19:
	.align	2
.L18:
	.word	.LC1
	.word	.LC2
	.size	find_codeword, .-find_codeword
	.align	2
	.global	signum
	.syntax unified
	.arm
	.fpu vfp
	.type	signum, %function
signum:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #12
	mov	r3, r0
	strh	r3, [fp, #-6]	@ movhi
	ldrh	r3, [fp, #-6]	@ movhi
	mvn	r3, r3
	uxth	r3, r3
	lsr	r3, r3, #15
	uxtb	r3, r3
	mov	r0, r3
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
	.size	signum, .-signum
	.align	2
	.global	compressed_signum
	.syntax unified
	.arm
	.fpu vfp
	.type	compressed_signum, %function
compressed_signum:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #12
	mov	r3, r0
	strb	r3, [fp, #-5]
	ldrsb	r3, [fp, #-5]
	mvn	r3, r3
	uxtb	r3, r3
	lsr	r3, r3, #7
	uxtb	r3, r3
	mov	r0, r3
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
	.size	compressed_signum, .-compressed_signum
	.align	2
	.global	magnitude
	.syntax unified
	.arm
	.fpu vfp
	.type	magnitude, %function
magnitude:
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
	bge	.L25
	ldrh	r3, [fp, #-6]
	rsb	r3, r3, #0
	uxth	r3, r3
	strh	r3, [fp, #-6]	@ movhi
.L25:
	ldrh	r3, [fp, #-6]
	mov	r0, r3
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
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
	.syntax unified
	.arm
	.fpu vfp
	.type	compressed_magnitude, %function
compressed_magnitude:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #16
	mov	r3, r0
	strb	r3, [fp, #-13]
	ldrb	r3, [fp, #-13]	@ zero_extendqisi2
	lsr	r3, r3, #4
	uxtb	r3, r3
	and	r3, r3, #7
	strb	r3, [fp, #-5]
	ldrb	r3, [fp, #-13]
	and	r3, r3, #15
	strb	r3, [fp, #-6]
	ldrb	r3, [fp, #-5]	@ zero_extendqisi2
	cmp	r3, #7
	bne	.L28
	ldrb	r3, [fp, #-6]	@ zero_extendqisi2
	lsl	r3, r3, #8
	sxth	r3, r3
	orr	r3, r3, #4224
	sxth	r3, r3
	uxth	r3, r3
	b	.L29
.L28:
	ldrb	r3, [fp, #-5]	@ zero_extendqisi2
	cmp	r3, #6
	bne	.L30
	ldrb	r3, [fp, #-6]	@ zero_extendqisi2
	lsl	r3, r3, #7
	sxth	r3, r3
	orr	r3, r3, #2112
	sxth	r3, r3
	uxth	r3, r3
	b	.L29
.L30:
	ldrb	r3, [fp, #-5]	@ zero_extendqisi2
	cmp	r3, #5
	bne	.L31
	ldrb	r3, [fp, #-6]	@ zero_extendqisi2
	lsl	r3, r3, #6
	sxth	r3, r3
	orr	r3, r3, #1056
	sxth	r3, r3
	uxth	r3, r3
	b	.L29
.L31:
	ldrb	r3, [fp, #-5]	@ zero_extendqisi2
	cmp	r3, #4
	bne	.L32
	ldrb	r3, [fp, #-6]	@ zero_extendqisi2
	lsl	r3, r3, #5
	sxth	r3, r3
	orr	r3, r3, #528
	sxth	r3, r3
	uxth	r3, r3
	b	.L29
.L32:
	ldrb	r3, [fp, #-5]	@ zero_extendqisi2
	cmp	r3, #3
	bne	.L33
	ldrb	r3, [fp, #-6]	@ zero_extendqisi2
	lsl	r3, r3, #4
	sxth	r3, r3
	orr	r3, r3, #264
	sxth	r3, r3
	uxth	r3, r3
	b	.L29
.L33:
	ldrb	r3, [fp, #-5]	@ zero_extendqisi2
	cmp	r3, #2
	bne	.L34
	ldrb	r3, [fp, #-6]	@ zero_extendqisi2
	lsl	r3, r3, #3
	sxth	r3, r3
	orr	r3, r3, #132
	sxth	r3, r3
	uxth	r3, r3
	b	.L29
.L34:
	ldrb	r3, [fp, #-5]	@ zero_extendqisi2
	cmp	r3, #1
	bne	.L35
	ldrb	r3, [fp, #-6]	@ zero_extendqisi2
	lsl	r3, r3, #2
	sxth	r3, r3
	orr	r3, r3, #66
	sxth	r3, r3
	uxth	r3, r3
	b	.L29
.L35:
	ldrb	r3, [fp, #-5]	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L36
	ldrb	r3, [fp, #-6]	@ zero_extendqisi2
	lsl	r3, r3, #1
	sxth	r3, r3
	orr	r3, r3, #33
	sxth	r3, r3
	uxth	r3, r3
	b	.L29
.L36:
	ldr	r0, .L37
	bl	puts
	ldrb	r3, [fp, #-5]	@ zero_extendqisi2
	mov	r1, r3
	ldr	r0, .L37+4
	bl	printf
	mov	r0, #1
	bl	exit
.L29:
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L38:
	.align	2
.L37:
	.word	.LC3
	.word	.LC4
	.size	compressed_magnitude, .-compressed_magnitude
	.align	2
	.global	decompress
	.syntax unified
	.arm
	.fpu vfp
	.type	decompress, %function
decompress:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #16
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L40
.L43:
	ldr	r3, .L44
	ldr	r2, [r3, #44]
	ldr	r3, [fp, #-8]
	add	r3, r2, r3
	ldrb	r3, [r3]
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
	beq	.L41
	ldrh	r3, [fp, #-12]	@ movhi
	rsb	r3, r3, #0
	uxth	r3, r3
	sxth	r3, r3
	b	.L42
.L41:
	ldrsh	r3, [fp, #-12]
.L42:
	strh	r3, [fp, #-14]	@ movhi
	ldrsh	r3, [fp, #-14]
	lsl	r1, r3, #2
	ldr	r3, .L44+4
	ldr	r2, [r3, #44]
	ldr	r3, [fp, #-8]
	lsl	r3, r3, #1
	add	r3, r2, r3
	sxth	r2, r1
	strh	r2, [r3]	@ movhi
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
.L40:
	ldr	r2, [fp, #-8]
	ldr	r3, .L44+8
	ldr	r3, [r3]
	cmp	r2, r3
	bcc	.L43
	nop
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L45:
	.align	2
.L44:
	.word	compressed_wave
	.word	wave
	.word	num_samples
	.size	decompress, .-decompress
	.ident	"GCC: (Raspbian 8.3.0-6+rpi1) 8.3.0"
	.section	.note.GNU-stack,"",%progbits
