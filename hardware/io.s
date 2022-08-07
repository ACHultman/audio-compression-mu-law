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
	.file	"io.c"
	.text
	.comm	ifp,4,4
	.comm	ofp,4,4
	.comm	num_samples,4,4
	.comm	bytes_per_sample,2,2
	.comm	wave,48,4
	.comm	compressed_wave,48,4
	.comm	buffer_2,2,4
	.comm	buffer_4,4,4
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
	.arch armv6
	.syntax unified
	.arm
	.fpu vfp
	.type	print_header, %function
print_header:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	ldr	r1, .L2
	ldr	r0, .L2+4
	bl	printf
	ldr	r3, .L2
	ldr	r1, [r3, #4]
	ldr	r3, .L2
	ldr	r3, [r3, #4]
	lsr	r3, r3, #10
	mov	r2, r3
	ldr	r0, .L2+8
	bl	printf
	ldr	r1, .L2+12
	ldr	r0, .L2+16
	bl	printf
	ldr	r1, .L2+20
	ldr	r0, .L2+24
	bl	printf
	ldr	r3, .L2
	ldr	r3, [r3, #16]
	mov	r1, r3
	ldr	r0, .L2+28
	bl	printf
	ldr	r3, .L2
	ldrh	r3, [r3, #20]
	mov	r1, r3
	ldr	r0, .L2+32
	bl	printf
	ldr	r3, .L2
	ldrh	r3, [r3, #22]
	mov	r1, r3
	ldr	r0, .L2+36
	bl	printf
	ldr	r3, .L2
	ldr	r3, [r3, #24]
	mov	r1, r3
	ldr	r0, .L2+40
	bl	printf
	ldr	r3, .L2
	ldr	r3, [r3, #28]
	mov	r1, r3
	ldr	r0, .L2+44
	bl	printf
	ldr	r3, .L2
	ldrh	r3, [r3, #32]
	mov	r1, r3
	ldr	r0, .L2+48
	bl	printf
	ldr	r3, .L2
	ldrh	r3, [r3, #34]
	mov	r1, r3
	ldr	r0, .L2+52
	bl	printf
	ldr	r1, .L2+56
	ldr	r0, .L2+60
	bl	printf
	ldr	r3, .L2
	ldr	r1, [r3, #40]
	ldr	r3, .L2
	ldr	r3, [r3, #40]
	lsr	r3, r3, #10
	mov	r2, r3
	ldr	r0, .L2+64
	bl	printf
	ldr	r3, .L2+68
	ldr	r3, [r3]
	mov	r1, r3
	ldr	r0, .L2+72
	bl	printf
	ldr	r3, .L2+76
	ldrh	r3, [r3]
	mov	r1, r3
	ldr	r0, .L2+80
	bl	printf
	nop
	pop	{fp, pc}
.L3:
	.align	2
.L2:
	.word	wave
	.word	.LC0
	.word	.LC1
	.word	wave+8
	.word	.LC2
	.word	wave+12
	.word	.LC3
	.word	.LC4
	.word	.LC5
	.word	.LC6
	.word	.LC7
	.word	.LC8
	.word	.LC9
	.word	.LC10
	.word	wave+36
	.word	.LC11
	.word	.LC12
	.word	num_samples
	.word	.LC13
	.word	bytes_per_sample
	.word	.LC14
	.size	print_header, .-print_header
	.align	2
	.global	convert_short_to_big_endian
	.syntax unified
	.arm
	.fpu vfp
	.type	convert_short_to_big_endian, %function
convert_short_to_big_endian:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #20
	str	r0, [fp, #-16]
	ldr	r3, [fp, #-16]
	ldrb	r3, [r3]	@ zero_extendqisi2
	sxth	r2, r3
	ldr	r3, [fp, #-16]
	add	r3, r3, #1
	ldrb	r3, [r3]	@ zero_extendqisi2
	lsl	r3, r3, #8
	sxth	r3, r3
	orr	r3, r2, r3
	sxth	r3, r3
	strh	r3, [fp, #-6]	@ movhi
	ldrh	r3, [fp, #-6]
	mov	r0, r3
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
	.size	convert_short_to_big_endian, .-convert_short_to_big_endian
	.align	2
	.global	convert_short_to_little_endian
	.syntax unified
	.arm
	.fpu vfp
	.type	convert_short_to_little_endian, %function
convert_short_to_little_endian:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #12
	mov	r3, r0
	strh	r3, [fp, #-6]	@ movhi
	ldrh	r3, [fp, #-6]	@ movhi
	uxtb	r2, r3
	ldr	r3, .L7
	strb	r2, [r3]
	ldrh	r3, [fp, #-6]
	lsr	r3, r3, #8
	uxth	r3, r3
	uxtb	r2, r3
	ldr	r3, .L7
	strb	r2, [r3, #1]
	nop
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
.L8:
	.align	2
.L7:
	.word	buffer_2
	.size	convert_short_to_little_endian, .-convert_short_to_little_endian
	.align	2
	.global	convert_int_to_big_endian
	.syntax unified
	.arm
	.fpu vfp
	.type	convert_int_to_big_endian, %function
convert_int_to_big_endian:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #20
	str	r0, [fp, #-16]
	ldr	r3, [fp, #-16]
	ldrb	r3, [r3]	@ zero_extendqisi2
	mov	r2, r3
	ldr	r3, [fp, #-16]
	add	r3, r3, #1
	ldrb	r3, [r3]	@ zero_extendqisi2
	lsl	r3, r3, #8
	orr	r2, r2, r3
	ldr	r3, [fp, #-16]
	add	r3, r3, #2
	ldrb	r3, [r3]	@ zero_extendqisi2
	lsl	r3, r3, #16
	orr	r2, r2, r3
	ldr	r3, [fp, #-16]
	add	r3, r3, #3
	ldrb	r3, [r3]	@ zero_extendqisi2
	lsl	r3, r3, #24
	orr	r3, r2, r3
	str	r3, [fp, #-8]
	ldr	r3, [fp, #-8]
	mov	r0, r3
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
	.size	convert_int_to_big_endian, .-convert_int_to_big_endian
	.align	2
	.global	convert_int_to_little_endian
	.syntax unified
	.arm
	.fpu vfp
	.type	convert_int_to_little_endian, %function
convert_int_to_little_endian:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #12
	str	r0, [fp, #-8]
	ldr	r3, [fp, #-8]
	uxtb	r2, r3
	ldr	r3, .L12
	strb	r2, [r3]
	ldr	r3, [fp, #-8]
	lsr	r3, r3, #8
	uxtb	r2, r3
	ldr	r3, .L12
	strb	r2, [r3, #1]
	ldr	r3, [fp, #-8]
	lsr	r3, r3, #16
	uxtb	r2, r3
	ldr	r3, .L12
	strb	r2, [r3, #2]
	ldr	r3, [fp, #-8]
	lsr	r3, r3, #24
	uxtb	r2, r3
	ldr	r3, .L12
	strb	r2, [r3, #3]
	nop
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
.L13:
	.align	2
.L12:
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
	.syntax unified
	.arm
	.fpu vfp
	.type	read_wav, %function
read_wav:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #8
	ldr	r3, .L18
	ldr	r3, [r3]
	mov	r2, #1
	mov	r1, #4
	ldr	r0, .L18+4
	bl	fread
	ldr	r3, .L18
	ldr	r3, [r3]
	mov	r2, #1
	mov	r1, #4
	ldr	r0, .L18+8
	bl	fread
	ldr	r0, .L18+8
	bl	convert_int_to_big_endian
	mov	r2, r0
	ldr	r3, .L18+4
	str	r2, [r3, #4]
	ldr	r3, .L18
	ldr	r3, [r3]
	mov	r2, #1
	mov	r1, #4
	ldr	r0, .L18+12
	bl	fread
	ldr	r3, .L18
	ldr	r3, [r3]
	mov	r2, #1
	mov	r1, #4
	ldr	r0, .L18+16
	bl	fread
	ldr	r3, .L18
	ldr	r3, [r3]
	mov	r2, #1
	mov	r1, #4
	ldr	r0, .L18+8
	bl	fread
	ldr	r0, .L18+8
	bl	convert_int_to_big_endian
	mov	r2, r0
	ldr	r3, .L18+4
	str	r2, [r3, #16]
	ldr	r3, .L18
	ldr	r3, [r3]
	mov	r2, #1
	mov	r1, #2
	ldr	r0, .L18+20
	bl	fread
	ldr	r0, .L18+20
	bl	convert_short_to_big_endian
	mov	r3, r0
	mov	r2, r3
	ldr	r3, .L18+4
	strh	r2, [r3, #20]	@ movhi
	ldr	r3, .L18
	ldr	r3, [r3]
	mov	r2, #1
	mov	r1, #2
	ldr	r0, .L18+20
	bl	fread
	ldr	r0, .L18+20
	bl	convert_short_to_big_endian
	mov	r3, r0
	mov	r2, r3
	ldr	r3, .L18+4
	strh	r2, [r3, #22]	@ movhi
	ldr	r3, .L18
	ldr	r3, [r3]
	mov	r2, #1
	mov	r1, #4
	ldr	r0, .L18+8
	bl	fread
	ldr	r0, .L18+8
	bl	convert_int_to_big_endian
	mov	r2, r0
	ldr	r3, .L18+4
	str	r2, [r3, #24]
	ldr	r3, .L18
	ldr	r3, [r3]
	mov	r2, #1
	mov	r1, #4
	ldr	r0, .L18+8
	bl	fread
	ldr	r0, .L18+8
	bl	convert_int_to_big_endian
	mov	r2, r0
	ldr	r3, .L18+4
	str	r2, [r3, #28]
	ldr	r3, .L18
	ldr	r3, [r3]
	mov	r2, #1
	mov	r1, #2
	ldr	r0, .L18+20
	bl	fread
	ldr	r0, .L18+20
	bl	convert_short_to_big_endian
	mov	r3, r0
	mov	r2, r3
	ldr	r3, .L18+4
	strh	r2, [r3, #32]	@ movhi
	ldr	r3, .L18
	ldr	r3, [r3]
	mov	r2, #1
	mov	r1, #2
	ldr	r0, .L18+20
	bl	fread
	ldr	r0, .L18+20
	bl	convert_short_to_big_endian
	mov	r3, r0
	mov	r2, r3
	ldr	r3, .L18+4
	strh	r2, [r3, #34]	@ movhi
	ldr	r3, .L18
	ldr	r3, [r3]
	mov	r2, #1
	mov	r1, #4
	ldr	r0, .L18+24
	bl	fread
	ldr	r3, .L18
	ldr	r3, [r3]
	mov	r2, #1
	mov	r1, #4
	ldr	r0, .L18+8
	bl	fread
	ldr	r0, .L18+8
	bl	convert_int_to_big_endian
	mov	r2, r0
	ldr	r3, .L18+4
	str	r2, [r3, #40]
	ldr	r3, .L18+4
	ldrh	r3, [r3, #34]
	mov	r2, r3
	ldr	r3, .L18+4
	ldrh	r3, [r3, #22]
	mul	r3, r3, r2
	add	r2, r3, #7
	cmp	r3, #0
	movlt	r3, r2
	movge	r3, r3
	asr	r3, r3, #3
	uxth	r3, r3
	ldr	r2, .L18+28
	strh	r3, [r2]	@ movhi
	ldr	r3, .L18+4
	ldr	r2, [r3, #40]
	ldr	r3, .L18+28
	ldrh	r3, [r3]
	mov	r1, r3
	ldr	r3, .L18+4
	ldrh	r3, [r3, #22]
	mul	r3, r3, r1
	mov	r1, r3
	mov	r0, r2
	bl	__aeabi_uidiv
	mov	r3, r0
	mov	r2, r3
	ldr	r3, .L18+32
	str	r2, [r3]
	ldr	r3, .L18+32
	ldr	r2, [r3]
	ldr	r3, .L18+28
	ldrh	r3, [r3]
	mov	r1, r3
	mov	r0, r2
	bl	calloc
	mov	r3, r0
	mov	r2, r3
	ldr	r3, .L18+4
	str	r2, [r3, #44]
	ldr	r3, .L18+4
	ldr	r3, [r3, #44]
	cmp	r3, #0
	bne	.L15
	ldr	r0, .L18+36
	bl	puts
	mov	r0, #1
	bl	exit
.L15:
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L16
.L17:
	ldr	r3, .L18
	ldr	r3, [r3]
	mov	r2, #1
	mov	r1, #2
	ldr	r0, .L18+20
	bl	fread
	ldr	r0, .L18+20
	bl	convert_short_to_big_endian
	mov	r3, r0
	mov	r1, r3
	ldr	r3, .L18+4
	ldr	r2, [r3, #44]
	ldr	r3, [fp, #-8]
	lsl	r3, r3, #1
	add	r3, r2, r3
	sxth	r2, r1
	strh	r2, [r3]	@ movhi
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
.L16:
	ldr	r2, [fp, #-8]
	ldr	r3, .L18+32
	ldr	r3, [r3]
	cmp	r2, r3
	bcc	.L17
	nop
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L19:
	.align	2
.L18:
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
	.syntax unified
	.arm
	.fpu vfp
	.type	write_wav, %function
write_wav:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #8
	ldr	r3, .L23
	ldr	r3, [r3]
	mov	r2, #1
	mov	r1, #4
	ldr	r0, .L23+4
	bl	fwrite
	ldr	r3, .L23+4
	ldr	r3, [r3, #4]
	mov	r0, r3
	bl	convert_int_to_little_endian
	ldr	r3, .L23
	ldr	r3, [r3]
	mov	r2, #1
	mov	r1, #4
	ldr	r0, .L23+8
	bl	fwrite
	ldr	r3, .L23
	ldr	r3, [r3]
	mov	r2, #1
	mov	r1, #4
	ldr	r0, .L23+12
	bl	fwrite
	ldr	r3, .L23
	ldr	r3, [r3]
	mov	r2, #1
	mov	r1, #4
	ldr	r0, .L23+16
	bl	fwrite
	ldr	r3, .L23+4
	ldr	r3, [r3, #16]
	mov	r0, r3
	bl	convert_int_to_little_endian
	ldr	r3, .L23
	ldr	r3, [r3]
	mov	r2, #1
	mov	r1, #4
	ldr	r0, .L23+8
	bl	fwrite
	ldr	r3, .L23+4
	ldrh	r3, [r3, #20]
	mov	r0, r3
	bl	convert_short_to_little_endian
	ldr	r3, .L23
	ldr	r3, [r3]
	mov	r2, #1
	mov	r1, #2
	ldr	r0, .L23+20
	bl	fwrite
	ldr	r3, .L23+4
	ldrh	r3, [r3, #22]
	mov	r0, r3
	bl	convert_short_to_little_endian
	ldr	r3, .L23
	ldr	r3, [r3]
	mov	r2, #1
	mov	r1, #2
	ldr	r0, .L23+20
	bl	fwrite
	ldr	r3, .L23+4
	ldr	r3, [r3, #24]
	mov	r0, r3
	bl	convert_int_to_little_endian
	ldr	r3, .L23
	ldr	r3, [r3]
	mov	r2, #1
	mov	r1, #4
	ldr	r0, .L23+8
	bl	fwrite
	ldr	r3, .L23+4
	ldr	r3, [r3, #28]
	mov	r0, r3
	bl	convert_int_to_little_endian
	ldr	r3, .L23
	ldr	r3, [r3]
	mov	r2, #1
	mov	r1, #4
	ldr	r0, .L23+8
	bl	fwrite
	ldr	r3, .L23+4
	ldrh	r3, [r3, #32]
	mov	r0, r3
	bl	convert_short_to_little_endian
	ldr	r3, .L23
	ldr	r3, [r3]
	mov	r2, #1
	mov	r1, #2
	ldr	r0, .L23+20
	bl	fwrite
	ldr	r3, .L23+4
	ldrh	r3, [r3, #34]
	mov	r0, r3
	bl	convert_short_to_little_endian
	ldr	r3, .L23
	ldr	r3, [r3]
	mov	r2, #1
	mov	r1, #2
	ldr	r0, .L23+20
	bl	fwrite
	ldr	r3, .L23
	ldr	r3, [r3]
	mov	r2, #1
	mov	r1, #4
	ldr	r0, .L23+24
	bl	fwrite
	ldr	r3, .L23+4
	ldr	r3, [r3, #40]
	mov	r0, r3
	bl	convert_int_to_little_endian
	ldr	r3, .L23
	ldr	r3, [r3]
	mov	r2, #1
	mov	r1, #4
	ldr	r0, .L23+8
	bl	fwrite
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L21
.L22:
	ldr	r3, .L23+4
	ldr	r2, [r3, #44]
	ldr	r3, [fp, #-8]
	lsl	r3, r3, #1
	add	r3, r2, r3
	ldrsh	r3, [r3]
	uxth	r3, r3
	mov	r0, r3
	bl	convert_short_to_little_endian
	ldr	r3, .L23
	ldr	r3, [r3]
	mov	r2, #1
	mov	r1, #2
	ldr	r0, .L23+20
	bl	fwrite
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
.L21:
	ldr	r2, [fp, #-8]
	ldr	r3, .L23+28
	ldr	r3, [r3]
	cmp	r2, r3
	bcc	.L22
	nop
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L24:
	.align	2
.L23:
	.word	ofp
	.word	wave
	.word	buffer_4
	.word	wave+8
	.word	wave+12
	.word	buffer_2
	.word	wave+36
	.word	num_samples
	.size	write_wav, .-write_wav
	.ident	"GCC: (Raspbian 8.3.0-6+rpi1) 8.3.0"
	.section	.note.GNU-stack,"",%progbits
