	.arch armv4t
	.fpu softvfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 2
	.eabi_attribute 18, 4
	.file	"main.c"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	cmp	r0, #2
	stmfd	sp!, {r4, r5, r6, lr}
	mov	r6, r1
	ble	.L7
	ldr	r1, [r1, #4]
	ldr	r0, .L9
	bl	printf
	ldr	r0, [r6, #4]
	ldr	r1, .L9+4
	bl	fopen
	ldr	r4, .L9+8
	cmp	r0, #0
	str	r0, [r4, #0]
	beq	.L8
	bl	read_wav
	ldr	r0, [r4, #0]
	bl	fclose
	bl	clock
	ldr	r5, .L9+12
	mov	r3, r0
	mov	r1, r0
	ldr	r0, .L9+16
	str	r3, [r5, #0]
	bl	printf
	bl	compress
	bl	clock
	ldr	r4, .L9+20
	mov	r3, r0
	str	r3, [r4, #0]
	mov	r1, r0
	ldr	r0, .L9+24
	bl	printf
	ldr	r0, [r4, #0]
	ldr	r1, [r5, #0]
	bl	difftime
	mov	r2, r0
	ldr	r0, .L9+28
	mov	r3, r1
	ldr	r1, [r0, #0]
	ldr	r0, .L9+32
	bl	printf
	bl	clock
	mov	r3, r0
	mov	r1, r0
	ldr	r0, .L9+36
	str	r3, [r5, #0]
	bl	printf
	bl	decompress
	bl	clock
	mov	r3, r0
	str	r3, [r4, #0]
	mov	r1, r0
	ldr	r0, .L9+40
	bl	printf
	ldr	r0, [r4, #0]
	ldr	r1, [r5, #0]
	bl	difftime
	mov	r2, r0
	mov	r3, r1
	ldr	r0, .L9+44
	bl	printf
	ldr	r0, [r6, #8]
	ldr	r1, .L9+48
	bl	fopen
	ldr	r4, .L9+52
	cmp	r0, #0
	str	r0, [r4, #0]
	bne	.L4
	ldr	r0, .L9+56
	bl	puts
	mov	r0, #1
	bl	exit
.L7:
	ldr	r0, .L9+60
	bl	puts
	ldr	r1, [r6, #0]
	ldr	r0, .L9+64
	bl	printf
	mov	r0, #1
	bl	exit
.L8:
	ldr	r0, .L9+68
	bl	puts
	mov	r0, #1
	bl	exit
.L4:
	bl	write_wav
	ldr	r0, [r4, #0]
	bl	fclose
	ldr	r3, .L9+72
	ldr	r0, [r3, #44]
	bl	free
	ldr	r3, .L9+76
	ldr	r0, [r3, #44]
	bl	free
	mov	r0, #0
	bl	exit
.L10:
	.align	2
.L9:
	.word	.LC2
	.word	.LC3
	.word	ifp
	.word	start
	.word	.LC5
	.word	end
	.word	.LC6
	.word	num_samples
	.word	.LC7
	.word	.LC8
	.word	.LC9
	.word	.LC10
	.word	.LC11
	.word	ofp
	.word	.LC12
	.word	.LC0
	.word	.LC1
	.word	.LC4
	.word	wave
	.word	compressed_wave
	.size	main, .-main
	.comm	start,4,4
	.comm	end,4,4
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"Please enter the input and output file names.\000"
	.space	2
.LC1:
	.ascii	"Usage: %s <input file> <output file>\012\000"
	.space	2
.LC2:
	.ascii	"\012Using file: %s\012\012\000"
	.space	2
.LC3:
	.ascii	"rb\000"
	.space	1
.LC4:
	.ascii	"Error opening file\000"
	.space	1
.LC5:
	.ascii	"Starting compression, start_t = %ld\012\000"
	.space	3
.LC6:
	.ascii	"Finished compression, end_t = %ld\012\000"
	.space	1
.LC7:
	.ascii	"Compressed %u samples in %g\012\000"
	.space	3
.LC8:
	.ascii	"Starting decompression, start_t = %ld\012\000"
	.space	1
.LC9:
	.ascii	"Finished decompression, end_t = %ld\012\000"
	.space	3
.LC10:
	.ascii	"%g\012\000"
.LC11:
	.ascii	"wb\000"
	.space	1
.LC12:
	.ascii	"Error creating output file\000"
	.ident	"GCC: (Sourcery G++ Lite 2008q3-72) 4.3.2"
	.section	.note.GNU-stack,"",%progbits
