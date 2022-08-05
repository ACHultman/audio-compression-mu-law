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
	.file	"io.c"
	.section	.rodata
	.align	2
.LC0:
	.ascii	"(1-4): %s\012\000"
	.align	2
.LC1:
	.ascii	"(5-8): Total Size: %u bytes, %ukb\012\000"
	.align	2
.LC2:
	.ascii	"(9-12): %s\012\000"
	.align	2
.LC3:
	.ascii	"(13-16): %s\012\000"
	.align	2
.LC4:
	.ascii	"(17-20): Format Length: %u bytes\012\000"
	.align	2
.LC5:
	.ascii	"(21-22): Format Type: %u\012\000"
	.align	2
.LC6:
	.ascii	"(23-24): Channels: %u\012\000"
	.align	2
.LC7:
	.ascii	"(25-28): Sample Rate: %u Hz\012\000"
	.align	2
.LC8:
	.ascii	"(29-32): Byte Rate: %u bytes/s\012\000"
	.align	2
.LC9:
	.ascii	"(33-34): Block Align: %u\012\000"
	.align	2
.LC10:
	.ascii	"(35-36): Bits Per Sample: %u\012\000"
	.align	2
.LC11:
	.ascii	"(37-40): %s\012\000"
	.align	2
.LC12:
	.ascii	"(40-44): Data Length: %u bytes, %ukb\012\012\000"
	.align	2
.LC13:
	.ascii	"Number of Samples: %u\012\000"
	.align	2
.LC14:
	.ascii	"Bytes per Sample: %u\012\012\000"
	.text
	.align	2
	.global	print_header
	.type	print_header, %function
print_header:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4
	ldr	r0, .L3
	ldr	r1, .L3+4
	bl	printf
	ldr	r3, .L3+4
	ldr	r2, [r3, #4]
	ldr	r3, .L3+4
	ldr	r3, [r3, #4]
	mov	r3, r3, lsr #10
	ldr	r0, .L3+8
	mov	r1, r2
	mov	r2, r3
	bl	printf
	ldr	r0, .L3+12
	ldr	r1, .L3+16
	bl	printf
	ldr	r0, .L3+20
	ldr	r1, .L3+24
	bl	printf
	ldr	r3, .L3+4
	ldr	r3, [r3, #16]
	ldr	r0, .L3+28
	mov	r1, r3
	bl	printf
	ldr	r3, .L3+4
	ldrh	r3, [r3, #20]
	ldr	r0, .L3+32
	mov	r1, r3
	bl	printf
	ldr	r3, .L3+4
	ldrh	r3, [r3, #22]
	ldr	r0, .L3+36
	mov	r1, r3
	bl	printf
	ldr	r3, .L3+4
	ldr	r3, [r3, #24]
	ldr	r0, .L3+40
	mov	r1, r3
	bl	printf
	ldr	r3, .L3+4
	ldr	r3, [r3, #28]
	ldr	r0, .L3+44
	mov	r1, r3
	bl	printf
	ldr	r3, .L3+4
	ldrh	r3, [r3, #32]
	ldr	r0, .L3+48
	mov	r1, r3
	bl	printf
	ldr	r3, .L3+4
	ldrh	r3, [r3, #34]
	ldr	r0, .L3+52
	mov	r1, r3
	bl	printf
	ldr	r0, .L3+56
	ldr	r1, .L3+60
	bl	printf
	ldr	r3, .L3+4
	ldr	r2, [r3, #40]
	ldr	r3, .L3+4
	ldr	r3, [r3, #40]
	mov	r3, r3, lsr #10
	ldr	r0, .L3+64
	mov	r1, r2
	mov	r2, r3
	bl	printf
	ldr	r3, .L3+68
	ldr	r3, [r3, #0]
	ldr	r0, .L3+72
	mov	r1, r3
	bl	printf
	ldr	r3, .L3+76
	ldrh	r3, [r3, #0]
	ldr	r0, .L3+80
	mov	r1, r3
	bl	printf
	sub	sp, fp, #4
	ldmfd	sp!, {fp, lr}
	bx	lr
.L4:
	.align	2
.L3:
	.word	.LC0
	.word	wave
	.word	.LC1
	.word	.LC2
	.word	wave+8
	.word	.LC3
	.word	wave+12
	.word	.LC4
	.word	.LC5
	.word	.LC6
	.word	.LC7
	.word	.LC8
	.word	.LC9
	.word	.LC10
	.word	.LC11
	.word	wave+36
	.word	.LC12
	.word	num_samples
	.word	.LC13
	.word	bytes_per_sample
	.word	.LC14
	.size	print_header, .-print_header
	.align	2
	.global	convert_short_to_big_endian
	.type	convert_short_to_big_endian, %function
convert_short_to_big_endian:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #20
	str	r0, [fp, #-16]
	ldr	r3, [fp, #-16]
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, [fp, #-16]
	add	r3, r3, #1
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	orr	r3, r2, r3
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	strh	r3, [fp, #-6]	@ movhi
	ldrh	r3, [fp, #-6]
	mov	r0, r3
	add	sp, fp, #0
	ldmfd	sp!, {fp}
	bx	lr
	.size	convert_short_to_big_endian, .-convert_short_to_big_endian
	.align	2
	.global	convert_short_to_little_endian
	.type	convert_short_to_little_endian, %function
convert_short_to_little_endian:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #12
	mov	r3, r0
	strh	r3, [fp, #-6]	@ movhi
	ldrh	r3, [fp, #-6]	@ movhi
	and	r3, r3, #255
	ldr	r2, .L9
	strb	r3, [r2, #0]
	ldrh	r3, [fp, #-6]
	mov	r3, r3, lsr #8
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	and	r3, r3, #255
	ldr	r2, .L9
	strb	r3, [r2, #1]
	add	sp, fp, #0
	ldmfd	sp!, {fp}
	bx	lr
.L10:
	.align	2
.L9:
	.word	buffer_2
	.size	convert_short_to_little_endian, .-convert_short_to_little_endian
	.align	2
	.global	convert_int_to_big_endian
	.type	convert_int_to_big_endian, %function
convert_int_to_big_endian:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #20
	str	r0, [fp, #-16]
	ldr	r3, [fp, #-16]
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, [fp, #-16]
	add	r3, r3, #1
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	orr	r2, r2, r3
	ldr	r3, [fp, #-16]
	add	r3, r3, #2
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r3, r3, asl #16
	orr	r2, r2, r3
	ldr	r3, [fp, #-16]
	add	r3, r3, #3
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r3, r3, asl #24
	orr	r3, r2, r3
	str	r3, [fp, #-8]
	ldr	r3, [fp, #-8]
	mov	r0, r3
	add	sp, fp, #0
	ldmfd	sp!, {fp}
	bx	lr
	.size	convert_int_to_big_endian, .-convert_int_to_big_endian
	.align	2
	.global	convert_int_to_little_endian
	.type	convert_int_to_little_endian, %function
convert_int_to_little_endian:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #12
	str	r0, [fp, #-8]
	ldr	r3, [fp, #-8]
	and	r3, r3, #255
	ldr	r2, .L15
	strb	r3, [r2, #0]
	ldr	r3, [fp, #-8]
	and	r3, r3, #65280
	mov	r3, r3, lsr #8
	and	r3, r3, #255
	ldr	r2, .L15
	strb	r3, [r2, #1]
	ldr	r3, [fp, #-8]
	and	r3, r3, #16711680
	mov	r3, r3, lsr #16
	and	r3, r3, #255
	ldr	r2, .L15
	strb	r3, [r2, #2]
	ldr	r3, [fp, #-8]
	mov	r3, r3, lsr #24
	and	r3, r3, #255
	ldr	r2, .L15
	strb	r3, [r2, #3]
	add	sp, fp, #0
	ldmfd	sp!, {fp}
	bx	lr
.L16:
	.align	2
.L15:
	.word	buffer_4
	.size	convert_int_to_little_endian, .-convert_int_to_little_endian
	.global	__aeabi_uidiv
	.section	.rodata
	.align	2
.LC15:
	.ascii	"Could not allocate memory for samples.\000"
	.text
	.align	2
	.global	read_wav
	.type	read_wav, %function
read_wav:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {r4, fp, lr}
	add	fp, sp, #8
	sub	sp, sp, #12
	ldr	r3, .L22
	ldr	r3, [r3, #0]
	ldr	r0, .L22+4
	mov	r1, #4
	mov	r2, #1
	bl	fread
	ldr	r3, .L22
	ldr	r3, [r3, #0]
	ldr	r0, .L22+8
	mov	r1, #4
	mov	r2, #1
	bl	fread
	ldr	r0, .L22+8
	bl	convert_int_to_big_endian
	mov	r2, r0
	ldr	r3, .L22+4
	str	r2, [r3, #4]
	ldr	r3, .L22
	ldr	r3, [r3, #0]
	ldr	r0, .L22+12
	mov	r1, #4
	mov	r2, #1
	bl	fread
	ldr	r3, .L22
	ldr	r3, [r3, #0]
	ldr	r0, .L22+16
	mov	r1, #4
	mov	r2, #1
	bl	fread
	ldr	r3, .L22
	ldr	r3, [r3, #0]
	ldr	r0, .L22+8
	mov	r1, #4
	mov	r2, #1
	bl	fread
	ldr	r0, .L22+8
	bl	convert_int_to_big_endian
	mov	r2, r0
	ldr	r3, .L22+4
	str	r2, [r3, #16]
	ldr	r3, .L22
	ldr	r3, [r3, #0]
	ldr	r0, .L22+20
	mov	r1, #2
	mov	r2, #1
	bl	fread
	ldr	r0, .L22+20
	bl	convert_short_to_big_endian
	mov	r3, r0
	mov	r2, r3
	ldr	r3, .L22+4
	strh	r2, [r3, #20]	@ movhi
	ldr	r3, .L22
	ldr	r3, [r3, #0]
	ldr	r0, .L22+20
	mov	r1, #2
	mov	r2, #1
	bl	fread
	ldr	r0, .L22+20
	bl	convert_short_to_big_endian
	mov	r3, r0
	mov	r2, r3
	ldr	r3, .L22+4
	strh	r2, [r3, #22]	@ movhi
	ldr	r3, .L22
	ldr	r3, [r3, #0]
	ldr	r0, .L22+8
	mov	r1, #4
	mov	r2, #1
	bl	fread
	ldr	r0, .L22+8
	bl	convert_int_to_big_endian
	mov	r2, r0
	ldr	r3, .L22+4
	str	r2, [r3, #24]
	ldr	r3, .L22
	ldr	r3, [r3, #0]
	ldr	r0, .L22+8
	mov	r1, #4
	mov	r2, #1
	bl	fread
	ldr	r0, .L22+8
	bl	convert_int_to_big_endian
	mov	r2, r0
	ldr	r3, .L22+4
	str	r2, [r3, #28]
	ldr	r3, .L22
	ldr	r3, [r3, #0]
	ldr	r0, .L22+20
	mov	r1, #2
	mov	r2, #1
	bl	fread
	ldr	r0, .L22+20
	bl	convert_short_to_big_endian
	mov	r3, r0
	mov	r2, r3
	ldr	r3, .L22+4
	strh	r2, [r3, #32]	@ movhi
	ldr	r3, .L22
	ldr	r3, [r3, #0]
	ldr	r0, .L22+20
	mov	r1, #2
	mov	r2, #1
	bl	fread
	ldr	r0, .L22+20
	bl	convert_short_to_big_endian
	mov	r3, r0
	mov	r2, r3
	ldr	r3, .L22+4
	strh	r2, [r3, #34]	@ movhi
	ldr	r3, .L22
	ldr	r3, [r3, #0]
	ldr	r0, .L22+24
	mov	r1, #4
	mov	r2, #1
	bl	fread
	ldr	r3, .L22
	ldr	r3, [r3, #0]
	ldr	r0, .L22+8
	mov	r1, #4
	mov	r2, #1
	bl	fread
	ldr	r0, .L22+8
	bl	convert_int_to_big_endian
	mov	r2, r0
	ldr	r3, .L22+4
	str	r2, [r3, #40]
	ldr	r3, .L22+4
	ldrh	r3, [r3, #34]
	mov	r2, r3
	ldr	r3, .L22+4
	ldrh	r3, [r3, #22]
	mul	r3, r2, r3
	add	r2, r3, #7
	cmp	r3, #0
	movlt	r3, r2
	mov	r3, r3, asr #3
	mov	r3, r3, asl #16
	mov	r2, r3, lsr #16
	ldr	r3, .L22+28
	strh	r2, [r3, #0]	@ movhi
	ldr	r3, .L22+4
	ldr	r1, [r3, #40]
	ldr	r3, .L22+28
	ldrh	r3, [r3, #0]
	mov	r2, r3
	ldr	r3, .L22+4
	ldrh	r3, [r3, #22]
	mul	r3, r2, r3
	mov	r0, r1
	mov	r1, r3
	bl	__aeabi_uidiv
	mov	r3, r0
	mov	r2, r3
	ldr	r3, .L22+32
	str	r2, [r3, #0]
	ldr	r3, .L22+32
	ldr	r2, [r3, #0]
	ldr	r3, .L22+28
	ldrh	r3, [r3, #0]
	mov	r0, r2
	mov	r1, r3
	bl	calloc
	mov	r3, r0
	mov	r2, r3
	ldr	r3, .L22+4
	str	r2, [r3, #44]
	ldr	r3, .L22+4
	ldr	r3, [r3, #44]
	cmp	r3, #0
	bne	.L18
	ldr	r0, .L22+36
	bl	puts
	mov	r0, #1
	bl	exit
.L18:
	mov	r3, #0
	str	r3, [fp, #-16]
	b	.L19
.L20:
	ldr	r3, .L22
	ldr	r3, [r3, #0]
	ldr	r0, .L22+20
	mov	r1, #2
	mov	r2, #1
	bl	fread
	ldr	r3, .L22+4
	ldr	r2, [r3, #44]
	ldr	r3, [fp, #-16]
	mov	r3, r3, asl #1
	add	r4, r2, r3
	ldr	r0, .L22+20
	bl	convert_short_to_big_endian
	mov	r3, r0
	strh	r3, [r4, #0]	@ movhi
	ldr	r3, [fp, #-16]
	add	r3, r3, #1
	str	r3, [fp, #-16]
.L19:
	ldr	r3, [fp, #-16]
	ldr	r2, .L22+32
	ldr	r2, [r2, #0]
	cmp	r3, r2
	bcc	.L20
	sub	sp, fp, #8
	ldmfd	sp!, {r4, fp, lr}
	bx	lr
.L23:
	.align	2
.L22:
	.word	ifp
	.word	wave
	.word	buffer_4
	.word	wave+8
	.word	wave+12
	.word	buffer_2
	.word	wave+36
	.word	bytes_per_sample
	.word	num_samples
	.word	.LC15
	.size	read_wav, .-read_wav
	.align	2
	.global	write_wav
	.type	write_wav, %function
write_wav:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #8
	ldr	r3, .L28
	ldr	r3, [r3, #0]
	ldr	r0, .L28+4
	mov	r1, #4
	mov	r2, #1
	bl	fwrite
	ldr	r3, .L28+4
	ldr	r3, [r3, #4]
	mov	r0, r3
	bl	convert_int_to_little_endian
	ldr	r3, .L28
	ldr	r3, [r3, #0]
	ldr	r0, .L28+8
	mov	r1, #4
	mov	r2, #1
	bl	fwrite
	ldr	r3, .L28
	ldr	r3, [r3, #0]
	ldr	r0, .L28+12
	mov	r1, #4
	mov	r2, #1
	bl	fwrite
	ldr	r3, .L28
	ldr	r3, [r3, #0]
	ldr	r0, .L28+16
	mov	r1, #4
	mov	r2, #1
	bl	fwrite
	ldr	r3, .L28+4
	ldr	r3, [r3, #16]
	mov	r0, r3
	bl	convert_int_to_little_endian
	ldr	r3, .L28
	ldr	r3, [r3, #0]
	ldr	r0, .L28+8
	mov	r1, #4
	mov	r2, #1
	bl	fwrite
	ldr	r3, .L28+4
	ldrh	r3, [r3, #20]
	mov	r0, r3
	bl	convert_short_to_little_endian
	ldr	r3, .L28
	ldr	r3, [r3, #0]
	ldr	r0, .L28+20
	mov	r1, #2
	mov	r2, #1
	bl	fwrite
	ldr	r3, .L28+4
	ldrh	r3, [r3, #22]
	mov	r0, r3
	bl	convert_short_to_little_endian
	ldr	r3, .L28
	ldr	r3, [r3, #0]
	ldr	r0, .L28+20
	mov	r1, #2
	mov	r2, #1
	bl	fwrite
	ldr	r3, .L28+4
	ldr	r3, [r3, #24]
	mov	r0, r3
	bl	convert_int_to_little_endian
	ldr	r3, .L28
	ldr	r3, [r3, #0]
	ldr	r0, .L28+8
	mov	r1, #4
	mov	r2, #1
	bl	fwrite
	ldr	r3, .L28+4
	ldr	r3, [r3, #28]
	mov	r0, r3
	bl	convert_int_to_little_endian
	ldr	r3, .L28
	ldr	r3, [r3, #0]
	ldr	r0, .L28+8
	mov	r1, #4
	mov	r2, #1
	bl	fwrite
	ldr	r3, .L28+4
	ldrh	r3, [r3, #32]
	mov	r0, r3
	bl	convert_short_to_little_endian
	ldr	r3, .L28
	ldr	r3, [r3, #0]
	ldr	r0, .L28+20
	mov	r1, #2
	mov	r2, #1
	bl	fwrite
	ldr	r3, .L28+4
	ldrh	r3, [r3, #34]
	mov	r0, r3
	bl	convert_short_to_little_endian
	ldr	r3, .L28
	ldr	r3, [r3, #0]
	ldr	r0, .L28+20
	mov	r1, #2
	mov	r2, #1
	bl	fwrite
	ldr	r3, .L28
	ldr	r3, [r3, #0]
	ldr	r0, .L28+24
	mov	r1, #4
	mov	r2, #1
	bl	fwrite
	ldr	r3, .L28+4
	ldr	r3, [r3, #40]
	mov	r0, r3
	bl	convert_int_to_little_endian
	ldr	r3, .L28
	ldr	r3, [r3, #0]
	ldr	r0, .L28+8
	mov	r1, #4
	mov	r2, #1
	bl	fwrite
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L25
.L26:
	ldr	r3, .L28+4
	ldr	r2, [r3, #44]
	ldr	r3, [fp, #-8]
	mov	r3, r3, asl #1
	add	r3, r2, r3
	ldrh	r3, [r3, #0]
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r0, r3
	bl	convert_short_to_little_endian
	ldr	r3, .L28
	ldr	r3, [r3, #0]
	ldr	r0, .L28+20
	mov	r1, #2
	mov	r2, #1
	bl	fwrite
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
.L25:
	ldr	r3, [fp, #-8]
	ldr	r2, .L28+28
	ldr	r2, [r2, #0]
	cmp	r3, r2
	bcc	.L26
	sub	sp, fp, #4
	ldmfd	sp!, {fp, lr}
	bx	lr
.L29:
	.align	2
.L28:
	.word	ofp
	.word	wave
	.word	buffer_4
	.word	wave+8
	.word	wave+12
	.word	buffer_2
	.word	wave+36
	.word	num_samples
	.size	write_wav, .-write_wav
	.comm	ifp,4,4
	.comm	ofp,4,4
	.comm	num_samples,4,4
	.comm	bytes_per_sample,2,2
	.comm	wave,48,4
	.comm	compressed_wave,48,4
	.comm	buffer_2,2,1
	.comm	buffer_4,4,1
	.ident	"GCC: (Sourcery G++ Lite 2008q3-72) 4.3.2"
	.section	.note.GNU-stack,"",%progbits
