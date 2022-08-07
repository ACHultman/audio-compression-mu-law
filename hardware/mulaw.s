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
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #8
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
	ldr	r3, .L5+4
	ldr	r2, [r3, #44]
	ldr	r3, [fp, #-8]
	add	r3, r2, r3
	ldr	r2, .L5+12
	ldr	r1, [r2, #44]
	ldr	r2, [fp, #-8]
	lsl	r2, r2, #1
	add	r2, r1, r2
	ldrsh	r2, [r2]
	mov	r1, #1
	.syntax divided
@ 25 "./hardware/mulaw.c" 1
	mulaw   r2, r2, r1
@ 0 "" 2
	.arm
	.syntax unified
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
	.align	2
	.global	decompress
	.syntax unified
	.arm
	.fpu vfp
	.type	decompress, %function
decompress:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #12
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L8
.L9:
	ldr	r3, .L10
	ldr	r2, [r3, #44]
	ldr	r3, [fp, #-8]
	lsl	r3, r3, #1
	add	r3, r2, r3
	ldr	r2, .L10+4
	ldr	r1, [r2, #44]
	ldr	r2, [fp, #-8]
	add	r2, r1, r2
	ldrb	r2, [r2]	@ zero_extendqisi2
	mov	r1, #0
	.syntax divided
@ 44 "./hardware/mulaw.c" 1
	mulaw   r2, r2, r1
@ 0 "" 2
	.arm
	.syntax unified
	strh	r2, [r3]	@ movhi
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
.L8:
	ldr	r2, [fp, #-8]
	ldr	r3, .L10+8
	ldr	r3, [r3]
	cmp	r2, r3
	bcc	.L9
	nop
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
.L11:
	.align	2
.L10:
	.word	wave
	.word	compressed_wave
	.word	num_samples
	.size	decompress, .-decompress
	.ident	"GCC: (Raspbian 8.3.0-6+rpi1) 8.3.0"
	.section	.note.GNU-stack,"",%progbits
