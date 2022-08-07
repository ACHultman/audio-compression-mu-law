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
	.section	.text.startup,"ax",%progbits
	.align	2
	.global	main
	.arch armv6
	.syntax unified
	.arm
	.fpu vfp
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	cmp	r0, #2
	push	{r4, r5, r6, lr}
	mov	r4, r1
	vpush.64	{d8}
	bgt	.L2
	ldr	r0, .L9+8
	bl	puts
	ldr	r1, [r4]
	ldr	r0, .L9+12
	bl	printf
	mov	r0, #1
	bl	exit
.L2:
	ldr	r1, .L9+16
	ldr	r0, [r4, #4]
	bl	fopen
	ldr	r5, .L9+20
	cmp	r0, #0
	str	r0, [r5]
	beq	.L7
	bl	read_wav
	ldr	r0, [r5]
	bl	fclose
	bl	clock
	vldr.64	d8, .L9
	ldr	r6, .L9+24
	mov	r5, r0
	bl	compress
	bl	clock
	ldr	r3, .L9+28
	ldr	r1, [r3]
	sub	r5, r0, r5
	ldr	r0, .L9+32
	vmov	s15, r5	@ int
	vcvt.f64.s32	d7, s15
	vdiv.f64	d7, d7, d8
	vmov	r2, r3, d7
	bl	printf
	bl	clock
	mov	r5, r0
	bl	decompress
	bl	clock
	sub	r5, r0, r5
	ldr	r0, .L9+36
	vmov	s15, r5	@ int
	vcvt.f64.s32	d7, s15
	vdiv.f64	d7, d7, d8
	vmov	r2, r3, d7
	bl	printf
	ldr	r0, [r4, #8]
	ldr	r1, .L9+40
	bl	fopen
	cmp	r0, #0
	str	r0, [r6]
	beq	.L8
	bl	write_wav
	ldr	r0, [r6]
	bl	fclose
	ldr	r3, .L9+44
	ldr	r0, [r3, #44]
	bl	free
	ldr	r3, .L9+48
	ldr	r0, [r3, #44]
	bl	free
	mov	r0, #0
	bl	exit
.L7:
	ldr	r0, .L9+52
	bl	puts
	mov	r0, #1
	bl	exit
.L8:
	ldr	r0, .L9+56
	bl	puts
	mov	r0, #1
	bl	exit
.L10:
	.align	3
.L9:
	.word	0
	.word	1093567616
	.word	.LC0
	.word	.LC1
	.word	.LC2
	.word	ifp
	.word	ofp
	.word	num_samples
	.word	.LC4
	.word	.LC5
	.word	.LC6
	.word	wave
	.word	compressed_wave
	.word	.LC3
	.word	.LC7
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
	.ascii	"Compressed %u samples in %.7fs\012\000"
.LC5:
	.ascii	"Decompressed in %.7fs\012\000"
	.space	1
.LC6:
	.ascii	"wb\000"
	.space	1
.LC7:
	.ascii	"Error creating output file\000"
	.ident	"GCC: (Raspbian 8.3.0-6+rpi1) 8.3.0"
	.section	.note.GNU-stack,"",%progbits
