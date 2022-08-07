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
	.file	"mulaw.c"
	.text
	.align	2
	.global	compress
	.arch armv6
	.syntax unified
	.arm
	.fpu vfp
	.type	compress, %function
compress:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, .L23
	push	{r4, lr}
	mov	r1, #1
	ldr	r4, [r3]
	mov	r0, r4
	bl	calloc
	ldr	r2, .L23+4
	cmp	r0, #0
	str	r0, [r2, #44]
	beq	.L20
	subs	r3, r4, #0
	popeq	{r4, pc}
	ldr	r0, .L23+8
	b	.L3
.L21:
	lsr	r4, r4, #8
	and	r4, r4, #15
	mov	ip, #112
.L7:
	orr	r1, ip, r1, lsl #7
	ldr	ip, [r2, #44]
	orr	r4, r1, r4
	mvn	r4, r4
	strb	r4, [ip, r3]
	subs	r3, r3, #1
	popeq	{r4, pc}
.L3:
	ldr	ip, [r0, #44]
	lsl	r1, r3, #1
	ldrsh	r4, [ip, r1]
	asr	r4, r4, #2
	cmp	r4, #0
	mvn	r1, r4
	uxth	r4, r4
	rsblt	r4, r4, #33
	addge	r4, r4, #33
	lsr	r1, r1, #31
	uxth	r4, r4
	tst	r4, #4096
	bne	.L21
	tst	r4, #2048
	lsrne	r4, r4, #7
	andne	r4, r4, #15
	movne	ip, #96
	bne	.L7
.L8:
	tst	r4, #1024
	lsrne	r4, r4, #6
	andne	r4, r4, #15
	movne	ip, #80
	bne	.L7
.L9:
	tst	r4, #512
	lsrne	r4, r4, #5
	andne	r4, r4, #15
	movne	ip, #64
	bne	.L7
.L10:
	tst	r4, #256
	lsrne	r4, r4, #4
	andne	r4, r4, #15
	movne	ip, #48
	bne	.L7
.L11:
	tst	r4, #128
	lsrne	r4, r4, #3
	andne	r4, r4, #15
	movne	ip, #32
	bne	.L7
.L12:
	ands	ip, r4, #64
	bne	.L22
	tst	r4, #32
	beq	.L14
	lsr	r4, r4, #1
	and	r4, r4, #15
	b	.L7
.L22:
	lsr	r4, r4, #2
	and	r4, r4, #15
	mov	ip, #16
	b	.L7
.L14:
	ldr	r0, .L23+12
	bl	puts
	mov	r1, r4
	ldr	r0, .L23+16
	bl	printf
	mov	r0, #1
	bl	exit
.L20:
	ldr	r0, .L23+20
	bl	puts
	mov	r0, #1
	bl	exit
.L24:
	.align	2
.L23:
	.word	num_samples
	.word	compressed_wave
	.word	wave
	.word	.LC1
	.word	.LC2
	.word	.LC0
	.size	compress, .-compress
	.align	2
	.global	decompress
	.syntax unified
	.arm
	.fpu vfp
	.type	decompress, %function
decompress:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, .L47
	ldr	r1, [r3]
	cmp	r1, #0
	bxeq	lr
	ldr	r2, .L47+4
	ldr	r3, .L47+8
	add	r1, r1, #1
	ldr	r0, [r2, #44]
	ldr	r3, [r3, #44]
	add	r2, r0, r1
	add	r0, r0, #1
	add	r1, r3, r1, lsl #1
	str	lr, [sp, #-4]!
.L40:
	ldrb	ip, [r2, #-1]!	@ zero_extendqisi2
	mvn	ip, ip
	uxtb	ip, ip
	and	r3, ip, #15
	lsr	lr, ip, #4
	and	lr, lr, #7
	sub	lr, lr, #1
	sxtb	ip, ip
	cmp	lr, #6
	ldrls	pc, [pc, lr, asl #2]
	b	.L27
.L29:
	.word	.L35
	.word	.L34
	.word	.L33
	.word	.L32
	.word	.L31
	.word	.L30
	.word	.L28
.L30:
	lsl	r3, r3, #7
	orr	r3, r3, #2112
	sub	r3, r3, #33
	uxth	r3, r3
.L36:
	cmp	ip, #0
	blt	.L37
.L46:
	rsb	r3, r3, #0
	cmp	r0, r2
	lsl	r3, r3, #2
	strh	r3, [r1, #-2]!	@ movhi
	bne	.L40
	ldr	pc, [sp], #4
.L31:
	lsl	r3, r3, #6
	orr	r3, r3, #1056
	sub	r3, r3, #33
	cmp	ip, #0
	uxth	r3, r3
	bge	.L46
.L37:
	lsl	r3, r3, #2
	cmp	r0, r2
	strh	r3, [r1, #-2]!	@ movhi
	bne	.L40
	ldr	pc, [sp], #4
.L32:
	lsl	r3, r3, #5
	orr	r3, r3, #528
	sub	r3, r3, #33
	uxth	r3, r3
	b	.L36
.L33:
	lsl	r3, r3, #4
	orr	r3, r3, #264
	sub	r3, r3, #33
	uxth	r3, r3
	b	.L36
.L34:
	lsl	r3, r3, #3
	orr	r3, r3, #132
	sub	r3, r3, #33
	uxth	r3, r3
	b	.L36
.L35:
	lsl	r3, r3, #2
	orr	r3, r3, #66
	sub	r3, r3, #33
	uxth	r3, r3
	b	.L36
.L28:
	lsl	r3, r3, #8
	orr	r3, r3, #4224
	sub	r3, r3, #33
	uxth	r3, r3
	b	.L36
.L27:
	lsl	r3, r3, #1
	orr	r3, r3, #33
	sub	r3, r3, #33
	uxth	r3, r3
	b	.L36
.L48:
	.align	2
.L47:
	.word	num_samples
	.word	compressed_wave
	.word	wave
	.size	decompress, .-decompress
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"Could not allocate memory for compressed samples.\000"
	.space	2
.LC1:
	.ascii	"Invalid magnitude while compressing.\000"
	.space	3
.LC2:
	.ascii	"Magnitude: %d\012\000"
	.ident	"GCC: (Raspbian 8.3.0-6+rpi1) 8.3.0"
	.section	.note.GNU-stack,"",%progbits
