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
	.file	"io.c"
	.text
	.align	2
	.global	convert_short_to_big_endian
	.type	convert_short_to_big_endian, %function
convert_short_to_big_endian:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldrb	r3, [r0, #0]	@ zero_extendqisi2
	ldrb	r0, [r0, #1]	@ zero_extendqisi2
	orr	r0, r3, r0, asl #8
	bx	lr
	.size	convert_short_to_big_endian, .-convert_short_to_big_endian
	.align	2
	.global	convert_short_to_little_endian
	.type	convert_short_to_little_endian, %function
convert_short_to_little_endian:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r2, .L5
	mov	r3, r0, lsr #8
	strb	r3, [r2, #1]
	strb	r0, [r2, #0]
	bx	lr
.L6:
	.align	2
.L5:
	.word	buffer_2
	.size	convert_short_to_little_endian, .-convert_short_to_little_endian
	.align	2
	.global	convert_int_to_big_endian
	.type	convert_int_to_big_endian, %function
convert_int_to_big_endian:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	mov	r3, r0
	ldrb	r0, [r0, #2]	@ zero_extendqisi2
	ldrb	r1, [r3, #1]	@ zero_extendqisi2
	ldrb	ip, [r3, #0]	@ zero_extendqisi2
	mov	r0, r0, asl #16
	orr	r0, r0, r1, asl #8
	ldrb	r2, [r3, #3]	@ zero_extendqisi2
	orr	r0, r0, ip
	orr	r0, r0, r2, asl #24
	bx	lr
	.size	convert_int_to_big_endian, .-convert_int_to_big_endian
	.align	2
	.global	convert_int_to_little_endian
	.type	convert_int_to_little_endian, %function
convert_int_to_little_endian:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L11
	mov	r2, r0, lsr #24
	mov	r1, r0, lsr #8
	mov	ip, r0, lsr #16
	strb	r2, [r3, #3]
	strb	r1, [r3, #1]
	strb	ip, [r3, #2]
	strb	r0, [r3, #0]
	bx	lr
.L12:
	.align	2
.L11:
	.word	buffer_4
	.size	convert_int_to_little_endian, .-convert_int_to_little_endian
	.align	2
	.global	write_wav
	.type	write_wav, %function
write_wav:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r3, r4, r5, r6, r7, r8, r9, sl, fp, lr}
	ldr	r9, .L19
	ldr	sl, .L19+4
	mov	r1, #4
	mov	r2, #1
	ldr	r3, [sl, #0]
	mov	r0, r9
	bl	fwrite
	ldr	ip, [r9, #4]
	ldr	r4, .L19+8
	mov	r7, ip, lsr #24
	mov	r5, ip, lsr #8
	mov	r6, ip, lsr #16
	strb	ip, [r4, #0]
	mov	r1, #4
	mov	r2, #1
	ldr	r3, [sl, #0]
	strb	r5, [r4, #1]
	strb	r6, [r4, #2]
	strb	r7, [r4, #3]
	mov	r0, r4
	bl	fwrite
	mov	r1, #4
	mov	r2, #1
	ldr	r3, [sl, #0]
	add	r0, r9, #8
	bl	fwrite
	mov	r1, #4
	mov	r2, #1
	ldr	r3, [sl, #0]
	add	r0, r9, #12
	bl	fwrite
	ldr	ip, [r9, #16]
	mov	r7, ip, lsr #24
	mov	r5, ip, lsr #8
	mov	r6, ip, lsr #16
	mov	r1, #4
	mov	r2, #1
	ldr	r3, [sl, #0]
	strb	r5, [r4, #1]
	strb	r6, [r4, #2]
	strb	r7, [r4, #3]
	strb	ip, [r4, #0]
	mov	r0, r4
	ldr	r8, .L19+12
	bl	fwrite
	ldrh	ip, [r9, #20]
	mov	r1, #2
	mov	r5, ip, lsr #8
	mov	r2, #1
	ldr	r3, [sl, #0]
	mov	r0, r8
	strb	r5, [r8, #1]
	strb	ip, [r8, #0]
	bl	fwrite
	ldrh	ip, [r9, #22]
	mov	r1, #2
	mov	r5, ip, lsr #8
	mov	r2, #1
	ldr	r3, [sl, #0]
	mov	r0, r8
	strb	r5, [r8, #1]
	strb	ip, [r8, #0]
	bl	fwrite
	ldr	ip, [r9, #24]
	mov	r7, ip, lsr #24
	mov	r5, ip, lsr #8
	mov	r6, ip, lsr #16
	mov	r1, #4
	mov	r2, #1
	ldr	r3, [sl, #0]
	strb	r5, [r4, #1]
	strb	r6, [r4, #2]
	strb	r7, [r4, #3]
	strb	ip, [r4, #0]
	mov	r0, r4
	bl	fwrite
	ldr	ip, [r9, #28]
	mov	r7, ip, lsr #24
	mov	r5, ip, lsr #8
	mov	r6, ip, lsr #16
	mov	r1, #4
	mov	r2, #1
	ldr	r3, [sl, #0]
	strb	r5, [r4, #1]
	strb	r6, [r4, #2]
	strb	r7, [r4, #3]
	strb	ip, [r4, #0]
	mov	r0, r4
	bl	fwrite
	ldrh	ip, [r9, #32]
	mov	r1, #2
	mov	r5, ip, lsr #8
	mov	r2, #1
	ldr	r3, [sl, #0]
	mov	r0, r8
	strb	r5, [r8, #1]
	strb	ip, [r8, #0]
	bl	fwrite
	ldrh	ip, [r9, #34]
	mov	r1, #2
	mov	r5, ip, lsr #8
	mov	r2, #1
	ldr	r3, [sl, #0]
	mov	r0, r8
	strb	ip, [r8, #0]
	strb	r5, [r8, #1]
	bl	fwrite
	mov	r1, #4
	mov	r2, #1
	ldr	r3, [sl, #0]
	add	r0, r9, #36
	bl	fwrite
	ldr	ip, [r9, #40]
	ldr	fp, .L19+16
	mov	r7, ip, lsr #24
	mov	r5, ip, lsr #8
	mov	r6, ip, lsr #16
	ldr	r3, [sl, #0]
	mov	r0, r4
	mov	r1, #4
	mov	r2, #1
	strb	r5, [r4, #1]
	strb	r6, [r4, #2]
	strb	r7, [r4, #3]
	strb	ip, [r4, #0]
	bl	fwrite
	ldr	r3, [fp, #0]
	cmp	r3, #0
	beq	.L16
	mov	r4, #0
	mov	r3, r4
.L15:
	ldr	r2, [r9, #44]
	mov	r3, r3, asl #1
	ldrh	ip, [r2, r3]
	ldr	r0, .L19+12
	mov	lr, ip, lsr #8
	ldr	r3, [sl, #0]
	mov	r1, #2
	mov	r2, #1
	strb	lr, [r8, #1]
	strb	ip, [r8, #0]
	bl	fwrite
	ldr	r3, [fp, #0]
	add	r4, r4, #1
	cmp	r4, r3
	mov	r3, r4
	bcc	.L15
.L16:
	ldmfd	sp!, {r3, r4, r5, r6, r7, r8, r9, sl, fp, lr}
	bx	lr
.L20:
	.align	2
.L19:
	.word	wave
	.word	ofp
	.word	buffer_4
	.word	buffer_2
	.word	num_samples
	.size	write_wav, .-write_wav
	.global	__aeabi_uidiv
	.align	2
	.global	read_wav
	.type	read_wav, %function
read_wav:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
	ldr	r8, .L28
	ldr	sl, .L28+4
	ldr	r5, .L28+8
	mov	r1, #4
	mov	r2, #1
	ldr	r3, [sl, #0]
	mov	r0, r8
	bl	fread
	mov	r1, #4
	mov	r2, #1
	ldr	r3, [sl, #0]
	mov	r0, r5
	bl	fread
	ldrb	ip, [r5, #2]	@ zero_extendqisi2
	ldrb	r2, [r5, #1]	@ zero_extendqisi2
	ldrb	r1, [r5, #0]	@ zero_extendqisi2
	mov	ip, ip, asl #16
	ldrb	r3, [r5, #3]	@ zero_extendqisi2
	orr	ip, ip, r2, asl #8
	orr	ip, ip, r1
	orr	ip, ip, r3, asl #24
	mov	r1, #4
	mov	r2, #1
	ldr	r3, [sl, #0]
	add	r0, r8, #8
	str	ip, [r8, #4]
	bl	fread
	mov	r1, #4
	mov	r2, #1
	ldr	r3, [sl, #0]
	add	r0, r8, #12
	bl	fread
	mov	r1, #4
	mov	r2, #1
	ldr	r3, [sl, #0]
	mov	r0, r5
	bl	fread
	ldrb	ip, [r5, #2]	@ zero_extendqisi2
	ldrb	r3, [r5, #1]	@ zero_extendqisi2
	ldrb	r2, [r5, #0]	@ zero_extendqisi2
	mov	ip, ip, asl #16
	ldr	r7, .L28+12
	orr	ip, ip, r3, asl #8
	ldrb	r3, [r5, #3]	@ zero_extendqisi2
	orr	ip, ip, r2
	orr	ip, ip, r3, asl #24
	mov	r1, #2
	mov	r2, #1
	ldr	r3, [sl, #0]
	mov	r0, r7
	str	ip, [r8, #16]
	bl	fread
	ldrb	r3, [r7, #1]	@ zero_extendqisi2
	ldrb	ip, [r7, #0]	@ zero_extendqisi2
	mov	r1, #2
	orr	ip, ip, r3, asl #8
	mov	r2, #1
	ldr	r3, [sl, #0]
	mov	r0, r7
	strh	ip, [r8, #20]	@ movhi
	bl	fread
	ldrb	r3, [r7, #1]	@ zero_extendqisi2
	ldrb	ip, [r7, #0]	@ zero_extendqisi2
	mov	r1, #4
	orr	ip, ip, r3, asl #8
	mov	r2, #1
	ldr	r3, [sl, #0]
	mov	r0, r5
	strh	ip, [r8, #22]	@ movhi
	bl	fread
	ldrb	ip, [r5, #2]	@ zero_extendqisi2
	ldrb	r2, [r5, #1]	@ zero_extendqisi2
	ldrb	r1, [r5, #0]	@ zero_extendqisi2
	mov	ip, ip, asl #16
	ldrb	r3, [r5, #3]	@ zero_extendqisi2
	orr	ip, ip, r2, asl #8
	orr	ip, ip, r1
	orr	ip, ip, r3, asl #24
	mov	r1, #4
	mov	r2, #1
	ldr	r3, [sl, #0]
	mov	r0, r5
	str	ip, [r8, #24]
	bl	fread
	ldrb	ip, [r5, #2]	@ zero_extendqisi2
	ldrb	r2, [r5, #1]	@ zero_extendqisi2
	ldrb	r1, [r5, #0]	@ zero_extendqisi2
	mov	ip, ip, asl #16
	ldrb	r3, [r5, #3]	@ zero_extendqisi2
	orr	ip, ip, r2, asl #8
	orr	ip, ip, r1
	orr	ip, ip, r3, asl #24
	mov	r1, #2
	mov	r2, #1
	ldr	r3, [sl, #0]
	mov	r0, r7
	str	ip, [r8, #28]
	bl	fread
	ldrb	r3, [r7, #1]	@ zero_extendqisi2
	ldrb	ip, [r7, #0]	@ zero_extendqisi2
	mov	r1, #2
	orr	ip, ip, r3, asl #8
	mov	r2, #1
	ldr	r3, [sl, #0]
	mov	r0, r7
	strh	ip, [r8, #32]	@ movhi
	bl	fread
	ldrb	r3, [r7, #1]	@ zero_extendqisi2
	ldrb	ip, [r7, #0]	@ zero_extendqisi2
	mov	r1, #4
	orr	ip, ip, r3, asl #8
	mov	r2, #1
	ldr	r3, [sl, #0]
	add	r0, r8, #36
	strh	ip, [r8, #34]	@ movhi
	bl	fread
	mov	r2, #1
	ldr	r3, [sl, #0]
	mov	r1, #4
	mov	r0, r5
	bl	fread
	ldrh	ip, [r8, #22]
	ldrh	r2, [r8, #34]
	mul	r4, r2, ip
	ldrb	r3, [r5, #2]	@ zero_extendqisi2
	ldrb	r2, [r5, #1]	@ zero_extendqisi2
	ldrb	r1, [r5, #0]	@ zero_extendqisi2
	mov	r3, r3, asl #16
	ldrb	r0, [r5, #3]	@ zero_extendqisi2
	orr	r3, r3, r2, asl #8
	orr	r3, r3, r1
	ldr	r2, .L28+16
	mov	r4, r4, asl #13
	orr	r3, r3, r0, asl #24
	mov	r4, r4, lsr #16
	mul	r1, ip, r4
	mov	r0, r3
	strh	r4, [r2, #0]	@ movhi
	str	r3, [r8, #40]
	bl	__aeabi_uidiv
	ldr	r6, .L28+20
	mov	r3, r0
	mov	r1, r4
	str	r3, [r6, #0]
	bl	calloc
	cmp	r0, #0
	str	r0, [r8, #44]
	beq	.L22
	ldr	r3, [r6, #0]
	cmp	r3, #0
	movne	r4, #0
	movne	r5, r4
	beq	.L26
.L25:
	mov	r1, #2
	mov	r2, #1
	ldr	r3, [sl, #0]
	ldr	r0, .L28+12
	bl	fread
	ldrb	r3, [r7, #1]	@ zero_extendqisi2
	ldrb	r2, [r7, #0]	@ zero_extendqisi2
	ldr	r1, [r6, #0]
	add	r4, r4, #1
	ldr	r0, [r8, #44]
	orr	r2, r2, r3, asl #8
	cmp	r1, r4
	mov	r3, r5, asl #1
	strh	r2, [r0, r3]	@ movhi
	mov	r5, r4
	bhi	.L25
.L26:
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
	bx	lr
.L22:
	ldr	r0, .L28+24
	bl	puts
	mov	r0, #1
	bl	exit
.L29:
	.align	2
.L28:
	.word	wave
	.word	ifp
	.word	buffer_4
	.word	buffer_2
	.word	bytes_per_sample
	.word	num_samples
	.word	.LC0
	.size	read_wav, .-read_wav
	.align	2
	.global	print_header
	.type	print_header, %function
print_header:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, lr}
	ldr	r4, .L32
	ldr	r0, .L32+4
	mov	r1, r4
	bl	printf
	ldr	r1, [r4, #4]
	ldr	r0, .L32+8
	mov	r2, r1, lsr #10
	bl	printf
	add	r1, r4, #8
	ldr	r0, .L32+12
	bl	printf
	add	r1, r4, #12
	ldr	r0, .L32+16
	bl	printf
	ldr	r1, [r4, #16]
	ldr	r0, .L32+20
	bl	printf
	ldrh	r1, [r4, #20]
	ldr	r0, .L32+24
	bl	printf
	ldrh	r1, [r4, #22]
	ldr	r0, .L32+28
	bl	printf
	ldr	r1, [r4, #24]
	ldr	r0, .L32+32
	bl	printf
	ldr	r1, [r4, #28]
	ldr	r0, .L32+36
	bl	printf
	ldrh	r1, [r4, #32]
	ldr	r0, .L32+40
	bl	printf
	ldrh	r1, [r4, #34]
	ldr	r0, .L32+44
	bl	printf
	add	r1, r4, #36
	ldr	r0, .L32+48
	bl	printf
	ldr	r1, [r4, #40]
	ldr	r0, .L32+52
	mov	r2, r1, lsr #10
	bl	printf
	ldr	r3, .L32+56
	ldr	r0, .L32+60
	ldr	r1, [r3, #0]
	bl	printf
	ldr	r3, .L32+64
	ldr	r0, .L32+68
	ldrh	r1, [r3, #0]
	bl	printf
	ldmfd	sp!, {r4, lr}
	bx	lr
.L33:
	.align	2
.L32:
	.word	wave
	.word	.LC1
	.word	.LC2
	.word	.LC3
	.word	.LC4
	.word	.LC5
	.word	.LC6
	.word	.LC7
	.word	.LC8
	.word	.LC9
	.word	.LC10
	.word	.LC11
	.word	.LC12
	.word	.LC13
	.word	num_samples
	.word	.LC14
	.word	bytes_per_sample
	.word	.LC15
	.size	print_header, .-print_header
	.comm	ifp,4,4
	.comm	ofp,4,4
	.comm	num_samples,4,4
	.comm	bytes_per_sample,2,2
	.comm	wave,48,4
	.comm	compressed_wave,48,4
	.comm	buffer_2,2,4
	.comm	buffer_4,4,4
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"Could not allocate memory for samples.\000"
	.space	1
.LC1:
	.ascii	"(1-4): %s\012\000"
	.space	1
.LC2:
	.ascii	"(5-8): Total Size: %u bytes, %ukb\012\000"
	.space	1
.LC3:
	.ascii	"(9-12): %s\012\000"
.LC4:
	.ascii	"(13-16): %s\012\000"
	.space	3
.LC5:
	.ascii	"(17-20): Format Length: %u bytes\012\000"
	.space	2
.LC6:
	.ascii	"(21-22): Format Type: %u\012\000"
	.space	2
.LC7:
	.ascii	"(23-24): Channels: %u\012\000"
	.space	1
.LC8:
	.ascii	"(25-28): Sample Rate: %u Hz\012\000"
	.space	3
.LC9:
	.ascii	"(29-32): Byte Rate: %u bytes/s\012\000"
.LC10:
	.ascii	"(33-34): Block Align: %u\012\000"
	.space	2
.LC11:
	.ascii	"(35-36): Bits Per Sample: %u\012\000"
	.space	2
.LC12:
	.ascii	"(37-40): %s\012\000"
	.space	3
.LC13:
	.ascii	"(40-44): Data Length: %u bytes, %ukb\012\012\000"
	.space	1
.LC14:
	.ascii	"Number of Samples: %u\012\000"
	.space	1
.LC15:
	.ascii	"Bytes per Sample: %u\012\012\000"
	.ident	"GCC: (Sourcery G++ Lite 2008q3-72) 4.3.2"
	.section	.note.GNU-stack,"",%progbits
