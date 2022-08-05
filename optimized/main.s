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
	.file	"main.c"
	.section	.rodata
	.align	2
.LC0:
	.ascii	"Please enter the input and output file names.\000"
	.align	2
.LC1:
	.ascii	"Usage: %s <input file> <output file>\012\000"
	.align	2
.LC2:
	.ascii	"\012Using file: %s\012\012\000"
	.align	2
.LC3:
	.ascii	"rb\000"
	.align	2
.LC4:
	.ascii	"Error opening file\000"
	.align	2
.LC5:
	.ascii	"Compressed %u samples in %us\012\000"
	.global	__aeabi_i2d
	.align	2
.LC6:
	.ascii	"%us\012\000"
	.align	2
.LC7:
	.ascii	"wb\000"
	.align	2
.LC8:
	.ascii	"Error creating output file\000"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {r4, fp, lr}
	add	fp, sp, #8
	sub	sp, sp, #12
	str	r0, [fp, #-16]
	str	r1, [fp, #-20]
	ldr	r3, [fp, #-16]
	cmp	r3, #2
	bgt	.L2
	ldr	r0, .L6
	bl	puts
	ldr	r3, [fp, #-20]
	ldr	r3, [r3, #0]
	ldr	r0, .L6+4
	mov	r1, r3
	bl	printf
	mov	r0, #1
	bl	exit
.L2:
	ldr	r3, [fp, #-20]
	add	r3, r3, #4
	ldr	r3, [r3, #0]
	ldr	r0, .L6+8
	mov	r1, r3
	bl	printf
	ldr	r3, [fp, #-20]
	add	r3, r3, #4
	ldr	r3, [r3, #0]
	mov	r0, r3
	ldr	r1, .L6+12
	bl	fopen
	mov	r2, r0
	ldr	r3, .L6+16
	str	r2, [r3, #0]
	ldr	r3, .L6+16
	ldr	r3, [r3, #0]
	cmp	r3, #0
	bne	.L3
	ldr	r0, .L6+20
	bl	puts
	mov	r0, #1
	bl	exit
.L3:
	bl	read_wav
	ldr	r3, .L6+16
	ldr	r3, [r3, #0]
	mov	r0, r3
	bl	fclose
	bl	clock
	mov	r2, r0
	ldr	r3, .L6+24
	str	r2, [r3, #0]
	bl	compress
	bl	clock
	mov	r2, r0
	ldr	r3, .L6+28
	str	r2, [r3, #0]
	ldr	r3, .L6+32
	ldr	ip, [r3, #0]
	ldr	r3, .L6+28
	ldr	r2, [r3, #0]
	ldr	r3, .L6+24
	ldr	r3, [r3, #0]
	rsb	r1, r3, r2
	ldr	r3, .L6+36
	smull	r2, r3, r1, r3
	mov	r2, r3, asr #18
	mov	r3, r1, asr #31
	rsb	r3, r3, r2
	ldr	r0, .L6+40
	mov	r1, ip
	mov	r2, r3
	bl	printf
	bl	clock
	mov	r2, r0
	ldr	r3, .L6+24
	str	r2, [r3, #0]
	bl	decompress
	bl	clock
	mov	r2, r0
	ldr	r3, .L6+28
	str	r2, [r3, #0]
	ldr	r3, .L6+28
	ldr	r2, [r3, #0]
	ldr	r3, .L6+24
	ldr	r3, [r3, #0]
	rsb	r1, r3, r2
	ldr	r3, .L6+36
	smull	r2, r3, r1, r3
	mov	r2, r3, asr #18
	mov	r3, r1, asr #31
	rsb	r3, r3, r2
	mov	r0, r3
	bl	__aeabi_i2d
	mov	r3, r0
	mov	r4, r1
	ldr	r0, .L6+44
	mov	r2, r3
	mov	r3, r4
	bl	printf
	ldr	r3, [fp, #-20]
	add	r3, r3, #8
	ldr	r3, [r3, #0]
	mov	r0, r3
	ldr	r1, .L6+48
	bl	fopen
	mov	r2, r0
	ldr	r3, .L6+52
	str	r2, [r3, #0]
	ldr	r3, .L6+52
	ldr	r3, [r3, #0]
	cmp	r3, #0
	bne	.L4
	ldr	r0, .L6+56
	bl	puts
	mov	r0, #1
	bl	exit
.L4:
	bl	write_wav
	ldr	r3, .L6+52
	ldr	r3, [r3, #0]
	mov	r0, r3
	bl	fclose
	ldr	r3, .L6+60
	ldr	r3, [r3, #44]
	mov	r0, r3
	bl	free
	ldr	r3, .L6+64
	ldr	r3, [r3, #44]
	mov	r0, r3
	bl	free
	mov	r0, #0
	bl	exit
.L7:
	.align	2
.L6:
	.word	.LC0
	.word	.LC1
	.word	.LC2
	.word	.LC3
	.word	ifp
	.word	.LC4
	.word	start
	.word	end
	.word	num_samples
	.word	1125899907
	.word	.LC5
	.word	.LC6
	.word	.LC7
	.word	ofp
	.word	.LC8
	.word	wave
	.word	compressed_wave
	.size	main, .-main
	.comm	start,4,4
	.comm	end,4,4
	.ident	"GCC: (Sourcery G++ Lite 2008q3-72) 4.3.2"
	.section	.note.GNU-stack,"",%progbits
