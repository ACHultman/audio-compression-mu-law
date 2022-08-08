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
	.global	find_codeword
	.arch armv6
	.syntax unified
	.arm
	.fpu vfp
	.type	find_codeword, %function
find_codeword:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	tst	r1, #4096
	beq	.L2
	lsr	r1, r1, #8
	and	r1, r1, #15
	mov	r3, #112
.L3:
	orr	r0, r3, r0, lsl #7
	orr	r0, r0, r1
	uxtb	r0, r0
	bx	lr
.L2:
	tst	r1, #2048
	beq	.L4
	mov	r3, #96
	lsr	r1, r1, #7
	and	r1, r1, #15
	orr	r0, r3, r0, lsl #7
	orr	r0, r0, r1
	uxtb	r0, r0
	bx	lr
.L4:
	tst	r1, #1024
	bne	.L14
	tst	r1, #512
	beq	.L6
	lsr	r1, r1, #5
	and	r1, r1, #15
	mov	r3, #64
	b	.L3
.L14:
	mov	r3, #80
	lsr	r1, r1, #6
	and	r1, r1, #15
	orr	r0, r3, r0, lsl #7
	orr	r0, r0, r1
	uxtb	r0, r0
	bx	lr
.L6:
	tst	r1, #256
	bne	.L15
	tst	r1, #128
	beq	.L8
	lsr	r3, r1, #3
	and	r1, r3, #15
	mov	r3, #32
	b	.L3
.L15:
	lsr	r1, r1, #4
	and	r1, r1, #15
	mov	r3, #48
	b	.L3
.L8:
	ands	r2, r1, #64
	lsrne	r3, r1, #2
	andne	r1, r3, #15
	movne	r3, #16
	bne	.L3
.L9:
	tst	r1, #32
	lsrne	r3, r1, #1
	andne	r1, r3, #15
	movne	r3, r2
	bne	.L3
.L10:
	push	{r4, lr}
	mov	r4, r1
	ldr	r0, .L16
	bl	puts
	mov	r1, r4
	ldr	r0, .L16+4
	bl	printf
	mov	r0, #1
	bl	exit
.L17:
	.align	2
.L16:
	.word	.LC0
	.word	.LC1
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
	b	.L19
.L21:
	.word	.L27
	.word	.L26
	.word	.L25
	.word	.L24
	.word	.L23
	.word	.L22
	.word	.L20
.L22:
	lsl	r3, r3, #7
	orr	r0, r3, #2112
	bx	lr
.L20:
	lsl	r3, r3, #8
	orr	r0, r3, #4224
	bx	lr
.L27:
	lsl	r3, r3, #2
	orr	r0, r3, #66
	bx	lr
.L26:
	lsl	r3, r3, #3
	orr	r0, r3, #132
	bx	lr
.L25:
	lsl	r3, r3, #4
	orr	r0, r3, #264
	bx	lr
.L24:
	lsl	r3, r3, #5
	orr	r0, r3, #528
	bx	lr
.L23:
	lsl	r3, r3, #6
	orr	r0, r3, #1056
	bx	lr
.L19:
	lsl	r3, r3, #1
	orr	r0, r3, #33
	bx	lr
	.size	compressed_magnitude, .-compressed_magnitude
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"Invalid magnitude while compressing.\000"
	.space	3
.LC1:
	.ascii	"Magnitude: %d\012\000"
	.ident	"GCC: (Raspbian 8.3.0-6+rpi1) 8.3.0"
	.section	.note.GNU-stack,"",%progbits
