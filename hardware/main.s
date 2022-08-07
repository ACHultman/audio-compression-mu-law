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
	.file	"main.c"
	.text
	.comm	start,4,4
	.comm	end,4,4
	.section	.rodata
	.align	2
.LC0:
	.ascii	"Please enter the input and output file names.\000"
	.align	2
.LC1:
	.ascii	"Usage: %s <input file> <output file>\012\000"
	.align	2
.LC2:
	.ascii	"rb\000"
	.align	2
.LC3:
	.ascii	"Error opening file\000"
	.align	2
.LC4:
	.ascii	"wb\000"
	.align	2
.LC5:
	.ascii	"Error creating output file\000"
	.text
	.align	2
	.global	main
	.arch armv6
	.syntax unified
	.arm
	.fpu vfp
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #8
	str	r0, [fp, #-8]
	str	r1, [fp, #-12]
	ldr	r3, [fp, #-8]
	cmp	r3, #2
	bgt	.L2
	ldr	r0, .L5
	bl	puts
	ldr	r3, [fp, #-12]
	ldr	r3, [r3]
	mov	r1, r3
	ldr	r0, .L5+4
	bl	printf
	mov	r0, #1
	bl	exit
.L2:
	ldr	r3, [fp, #-12]
	add	r3, r3, #4
	ldr	r3, [r3]
	ldr	r1, .L5+8
	mov	r0, r3
	bl	fopen
	mov	r2, r0
	ldr	r3, .L5+12
	str	r2, [r3]
	ldr	r3, .L5+12
	ldr	r3, [r3]
	cmp	r3, #0
	bne	.L3
	ldr	r0, .L5+16
	bl	puts
	mov	r0, #1
	bl	exit
.L3:
	bl	read_wav
	ldr	r3, .L5+12
	ldr	r3, [r3]
	mov	r0, r3
	bl	fclose
	bl	compress
	bl	decompress
	ldr	r3, [fp, #-12]
	add	r3, r3, #8
	ldr	r3, [r3]
	ldr	r1, .L5+20
	mov	r0, r3
	bl	fopen
	mov	r2, r0
	ldr	r3, .L5+24
	str	r2, [r3]
	ldr	r3, .L5+24
	ldr	r3, [r3]
	cmp	r3, #0
	bne	.L4
	ldr	r0, .L5+28
	bl	puts
	mov	r0, #1
	bl	exit
.L4:
	bl	write_wav
	ldr	r3, .L5+24
	ldr	r3, [r3]
	mov	r0, r3
	bl	fclose
	ldr	r3, .L5+32
	ldr	r3, [r3, #44]
	mov	r0, r3
	bl	free
	ldr	r3, .L5+36
	ldr	r3, [r3, #44]
	mov	r0, r3
	bl	free
	mov	r0, #0
	bl	exit
.L6:
	.align	2
.L5:
	.word	.LC0
	.word	.LC1
	.word	.LC2
	.word	ifp
	.word	.LC3
	.word	.LC4
	.word	ofp
	.word	.LC5
	.word	wave
	.word	compressed_wave
	.size	main, .-main
	.ident	"GCC: (Raspbian 8.3.0-6+rpi1) 8.3.0"
	.section	.note.GNU-stack,"",%progbits
