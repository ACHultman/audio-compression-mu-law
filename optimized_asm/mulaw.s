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
	ldr	r3, .L23+4
	cmp	r0, #0
	str	r0, [r3, #44]
	beq	.L20
	subs	r0, r4, #0
	popeq	{r4, pc}
	ldr	r2, .L23+8
	b	.L3
.L21:
	lsr	r4, r4, #8
	and	r4, r4, #15
	mov	ip, #112
.L7:
	orr	r1, ip, r1, lsl #7
	ldr	ip, [r3, #44]
	orr	r4, r1, r4
	mvn	r4, r4
	strb	r4, [ip, r0]
	subs	r0, r0, #1
	popeq	{r4, pc}
.L3:
	ldr	ip, [r2, #44]
	lsl	r1, r0, #1
	ldrsh	r4, [ip, r1]
	asr	r4, r4, #2
	cmp	r4, #0
	mvn	r1, r4
	rsblt	r4, r4, #33
	addge	r4, r4, #33
	lsr	r1, r1, #31
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
	bne	.L22
	ands	ip, r4, #64
	beq	.L13
	lsr	r4, r4, #2
	and	r4, r4, #15
	mov	ip, #16
	b	.L7
.L22:
	lsr	r4, r4, #3
	and	r4, r4, #15
	mov	ip, #32
	b	.L7
.L13:
	tst	r4, #32
	lsrne	r4, r4, #1
	andne	r4, r4, #15
	bne	.L7
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
	.global	find_codeword
	.syntax unified
	.arm
	.fpu vfp
	.type	find_codeword, %function
find_codeword:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	tst	r1, #4096
	beq	.L26
	lsr	r1, r1, #8
	and	r1, r1, #15
	mov	r3, #112
.L27:
	orr	r0, r3, r0, lsl #7
	orr	r0, r0, r1
	bx	lr
.L26:
	tst	r1, #2048
	beq	.L28
	mov	r3, #96
	lsr	r1, r1, #7
	and	r1, r1, #15
	orr	r0, r3, r0, lsl #7
	orr	r0, r0, r1
	bx	lr
.L28:
	tst	r1, #1024
	bne	.L37
	tst	r1, #512
	beq	.L30
	lsr	r1, r1, #5
	and	r1, r1, #15
	mov	r3, #64
	b	.L27
.L37:
	mov	r3, #80
	lsr	r1, r1, #6
	and	r1, r1, #15
	orr	r0, r3, r0, lsl #7
	orr	r0, r0, r1
	uxtb	r0, r0
	bx	lr
.L30:
	tst	r1, #256
	bne	.L38
	tst	r1, #128
	beq	.L32
	lsr	r3, r1, #3
	and	r1, r3, #15
	mov	r3, #32
	b	.L27
.L38:
	lsr	r1, r1, #4
	and	r1, r1, #15
	mov	r3, #48
	b	.L27
.L32:
	ands	r2, r1, #64
	lsrne	r3, r1, #2
	andne	r1, r3, #15
	movne	r3, #16
	bne	.L27
.L33:
	tst	r1, #32
	lsrne	r3, r1, #1
	andne	r1, r3, #15
	movne	r3, r2
	bne	.L27
.L34:
	push	{r4, lr}
	mov	r4, r1
	ldr	r0, .L39
	bl	puts
	mov	r1, r4
	ldr	r0, .L39+4
	bl	printf
	mov	r0, #1
	bl	exit
.L40:
	.align	2
.L39:
	.word	.LC1
	.word	.LC2
	.size	find_codeword, .-find_codeword
	.align	2
	.global	compressed_magnitude
	.syntax unified
	.arm
	.fpu vfp
	.type	compressed_magnitude, %function
compressed_magnitude:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	and	r3, r0, #15
	lsr	r0, r0, #4
	and	r0, r0, #7
	sub	r0, r0, #1
	cmp	r0, #6
	ldrls	pc, [pc, r0, asl #2]
	b	.L42
.L44:
	.word	.L50
	.word	.L49
	.word	.L48
	.word	.L47
	.word	.L46
	.word	.L45
	.word	.L43
.L45:
	lsl	r3, r3, #7
	orr	r0, r3, #2112
	bx	lr
.L43:
	lsl	r3, r3, #8
	orr	r0, r3, #4224
	bx	lr
.L50:
	lsl	r3, r3, #2
	orr	r0, r3, #66
	bx	lr
.L49:
	lsl	r3, r3, #3
	orr	r0, r3, #132
	bx	lr
.L48:
	lsl	r3, r3, #4
	orr	r0, r3, #264
	bx	lr
.L47:
	lsl	r3, r3, #5
	orr	r0, r3, #528
	bx	lr
.L46:
	lsl	r3, r3, #6
	orr	r0, r3, #1056
	bx	lr
.L42:
	lsl	r3, r3, #1
	orr	r0, r3, #33
	bx	lr
	.size	compressed_magnitude, .-compressed_magnitude
	.align	2
	.global	decompress
	.syntax unified
	.arm
	.fpu vfp
	.type	decompress, %function
decompress:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, .L74
	ldr	r1, [r3]
	cmp	r1, #0
	bxeq	lr
	ldr	r2, .L74+4
	ldr	r3, .L74+8
	add	r1, r1, #1
	ldr	r0, [r2, #44]
	ldr	r3, [r3, #44]
	add	r2, r0, r1
	add	r0, r0, #1
	add	r1, r3, r1, lsl #1
	str	lr, [sp, #-4]!
.L67:
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
	b	.L54
.L56:
	.word	.L62
	.word	.L61
	.word	.L60
	.word	.L59
	.word	.L58
	.word	.L57
	.word	.L55
.L57:
	lsl	r3, r3, #7
	orr	r3, r3, #2112
.L63:
	cmp	ip, #0
	blt	.L64
.L73:
	rsb	r3, r3, #33
	cmp	r0, r2
	lsl	r3, r3, #2
	strh	r3, [r1, #-2]!	@ movhi
	bne	.L67
	ldr	pc, [sp], #4
.L58:
	lsl	r3, r3, #6
	cmp	ip, #0
	orr	r3, r3, #1056
	bge	.L73
.L64:
	sub	r3, r3, #33
	cmp	r0, r2
	lsl	r3, r3, #2
	strh	r3, [r1, #-2]!	@ movhi
	bne	.L67
	ldr	pc, [sp], #4
.L59:
	lsl	r3, r3, #5
	orr	r3, r3, #528
	b	.L63
.L60:
	lsl	r3, r3, #4
	orr	r3, r3, #264
	b	.L63
.L61:
	lsl	r3, r3, #3
	orr	r3, r3, #132
	b	.L63
.L62:
	lsl	r3, r3, #2
	orr	r3, r3, #66
	b	.L63
.L55:
	lsl	r3, r3, #8
	orr	r3, r3, #4224
	b	.L63
.L54:
	lsl	r3, r3, #1
	orr	r3, r3, #33
	b	.L63
.L75:
	.align	2
.L74:
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
