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
	.file	"io.c"
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
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	ldr	r4, .L4
	ldr	r0, .L4+4
	mov	r1, r4
	bl	printf
	ldr	r2, [r4, #4]
	ldr	r0, .L4+8
	mov	r1, r2
	lsr	r2, r2, #10
	bl	printf
	add	r1, r4, #8
	ldr	r0, .L4+12
	bl	printf
	add	r1, r4, #12
	ldr	r0, .L4+16
	bl	printf
	ldr	r1, [r4, #16]
	ldr	r0, .L4+20
	bl	printf
	ldrh	r1, [r4, #20]
	ldr	r0, .L4+24
	bl	printf
	ldrh	r1, [r4, #22]
	ldr	r0, .L4+28
	bl	printf
	ldr	r1, [r4, #24]
	ldr	r0, .L4+32
	bl	printf
	ldr	r1, [r4, #28]
	ldr	r0, .L4+36
	bl	printf
	ldrh	r1, [r4, #32]
	ldr	r0, .L4+40
	bl	printf
	ldrh	r1, [r4, #34]
	ldr	r0, .L4+44
	bl	printf
	add	r1, r4, #36
	ldr	r0, .L4+48
	bl	printf
	ldr	r2, [r4, #40]
	ldr	r0, .L4+52
	mov	r1, r2
	lsr	r2, r2, #10
	bl	printf
	ldr	r3, .L4+56
	ldr	r0, .L4+60
	ldr	r1, [r3]
	bl	printf
	ldr	r3, .L4+64
	ldr	r0, .L4+68
	pop	{r4, lr}
	ldrh	r1, [r3]
	b	printf
.L5:
	.align	2
.L4:
	.word	wave
	.word	.LC0
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
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldrb	r2, [r0, #1]	@ zero_extendqisi2
	ldrb	r0, [r0]	@ zero_extendqisi2
	orr	r0, r0, r2, lsl #8
	bx	lr
	.size	convert_short_to_big_endian, .-convert_short_to_big_endian
	.align	2
	.global	convert_short_to_little_endian
	.syntax unified
	.arm
	.fpu vfp
	.type	convert_short_to_little_endian, %function
convert_short_to_little_endian:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L8
	lsr	r2, r0, #8
	strb	r2, [r3, #1]
	strb	r0, [r3]
	bx	lr
.L9:
	.align	2
.L8:
	.word	buffer_2
	.size	convert_short_to_little_endian, .-convert_short_to_little_endian
	.align	2
	.global	convert_int_to_big_endian
	.syntax unified
	.arm
	.fpu vfp
	.type	convert_int_to_big_endian, %function
convert_int_to_big_endian:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r0, [r0]	@ unaligned
	bx	lr
	.size	convert_int_to_big_endian, .-convert_int_to_big_endian
	.align	2
	.global	convert_int_to_little_endian
	.syntax unified
	.arm
	.fpu vfp
	.type	convert_int_to_little_endian, %function
convert_int_to_little_endian:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L12
	lsr	ip, r0, #8
	lsr	r1, r0, #16
	lsr	r2, r0, #24
	strb	ip, [r3, #1]
	strb	r0, [r3]
	strb	r1, [r3, #2]
	strb	r2, [r3, #3]
	bx	lr
.L13:
	.align	2
.L12:
	.word	buffer_4
	.size	convert_int_to_little_endian, .-convert_int_to_little_endian
	.global	__aeabi_uidiv
	.align	2
	.global	read_wav
	.syntax unified
	.arm
	.fpu vfp
	.type	read_wav, %function
read_wav:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, lr}
	mov	r2, #1
	ldr	r7, .L22
	ldr	r6, .L22+4
	ldr	r4, .L22+8
	ldr	r3, [r7]
	mov	r1, #4
	mov	r0, r6
	bl	fread
	ldr	r3, [r7]
	mov	r0, r4
	mov	r2, #1
	mov	r1, #4
	bl	fread
	ldr	ip, [r4]	@ unaligned
	ldr	r3, [r7]
	mov	r2, #1
	mov	r1, #4
	add	r0, r6, #8
	str	ip, [r6, #4]
	bl	fread
	ldr	r3, [r7]
	mov	r2, #1
	mov	r1, #4
	add	r0, r6, #12
	ldr	r5, .L22+12
	bl	fread
	ldr	r3, [r7]
	mov	r0, r4
	mov	r2, #1
	mov	r1, #4
	bl	fread
	ldr	ip, [r4]	@ unaligned
	ldr	r3, [r7]
	mov	r2, #1
	mov	r1, #2
	mov	r0, r5
	str	ip, [r6, #16]
	bl	fread
	ldrb	r2, [r5, #1]	@ zero_extendqisi2
	ldrb	ip, [r5]	@ zero_extendqisi2
	ldr	r3, [r7]
	mov	r1, #2
	orr	ip, ip, r2, lsl #8
	mov	r0, r5
	mov	r2, #1
	strh	ip, [r6, #20]	@ movhi
	bl	fread
	ldrb	r2, [r5, #1]	@ zero_extendqisi2
	ldrb	ip, [r5]	@ zero_extendqisi2
	ldr	r3, [r7]
	mov	r0, r4
	orr	ip, ip, r2, lsl #8
	mov	r1, #4
	mov	r2, #1
	strh	ip, [r6, #22]	@ movhi
	bl	fread
	ldr	ip, [r4]	@ unaligned
	ldr	r3, [r7]
	mov	r0, r4
	mov	r2, #1
	mov	r1, #4
	str	ip, [r6, #24]
	bl	fread
	ldr	ip, [r4]	@ unaligned
	ldr	r3, [r7]
	mov	r2, #1
	mov	r1, #2
	mov	r0, r5
	str	ip, [r6, #28]
	bl	fread
	ldrb	r2, [r5, #1]	@ zero_extendqisi2
	ldrb	ip, [r5]	@ zero_extendqisi2
	ldr	r3, [r7]
	mov	r1, #2
	orr	ip, ip, r2, lsl #8
	mov	r0, r5
	mov	r2, #1
	strh	ip, [r6, #32]	@ movhi
	bl	fread
	ldrb	r2, [r5, #1]	@ zero_extendqisi2
	ldrb	ip, [r5]	@ zero_extendqisi2
	ldr	r3, [r7]
	mov	r1, #4
	orr	ip, ip, r2, lsl #8
	add	r0, r6, #36
	mov	r2, #1
	strh	ip, [r6, #34]	@ movhi
	bl	fread
	ldr	r3, [r7]
	mov	r0, r4
	mov	r2, #1
	mov	r1, #4
	bl	fread
	ldrh	r9, [r6, #22]
	ldrh	r3, [r6, #34]
	ldr	r10, [r4]	@ unaligned
	ldr	r2, .L22+16
	mov	r0, r10
	mul	r4, r9, r3
	str	r10, [r6, #40]
	ldr	r8, .L22+20
	asr	r4, r4, #3
	strh	r4, [r2]	@ movhi
	uxth	r4, r4
	mul	r9, r4, r9
	mov	r1, r9
	bl	__aeabi_uidiv
	mov	r1, r4
	str	r0, [r8]
	bl	calloc
	cmp	r0, #0
	str	r0, [r6, #44]
	beq	.L15
	cmp	r9, r10
	pophi	{r4, r5, r6, r7, r8, r9, r10, pc}
	mov	r4, #0
	mov	r9, r5
.L16:
	ldr	r3, [r7]
	mov	r2, #1
	mov	r1, #2
	mov	r0, r9
	bl	fread
	ldrb	ip, [r5, #1]	@ zero_extendqisi2
	ldrb	r3, [r5]	@ zero_extendqisi2
	ldr	r0, [r8]
	ldr	r1, [r6, #44]
	lsl	r2, r4, #1
	add	r4, r4, #1
	orr	r3, r3, ip, lsl #8
	cmp	r0, r4
	strh	r3, [r1, r2]	@ movhi
	bhi	.L16
	pop	{r4, r5, r6, r7, r8, r9, r10, pc}
.L15:
	ldr	r0, .L22+24
	bl	puts
	mov	r0, #1
	bl	exit
.L23:
	.align	2
.L22:
	.word	ifp
	.word	wave
	.word	buffer_4
	.word	buffer_2
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
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, lr}
	mov	r2, #1
	ldr	r7, .L32
	ldr	r6, .L32+4
	ldr	r4, .L32+8
	ldr	r3, [r7]
	mov	r1, #4
	mov	r0, r6
	bl	fwrite
	ldr	ip, [r6, #4]
	ldr	r3, [r7]
	str	ip, [r4]	@ unaligned
	mov	r2, #1
	mov	r1, #4
	mov	r0, r4
	bl	fwrite
	ldr	r3, [r7]
	mov	r2, #1
	mov	r1, #4
	add	r0, r6, #8
	bl	fwrite
	ldr	r3, [r7]
	mov	r2, #1
	mov	r1, #4
	add	r0, r6, #12
	bl	fwrite
	ldr	ip, [r6, #16]
	ldr	r3, [r7]
	mov	r2, #1
	mov	r1, #4
	str	ip, [r4]	@ unaligned
	mov	r0, r4
	bl	fwrite
	ldrh	ip, [r6, #20]
	ldr	r5, .L32+12
	ldr	r3, [r7]
	mov	r2, #1
	lsr	r1, ip, #8
	strb	r1, [r5, #1]
	mov	r0, r5
	mov	r1, #2
	strb	ip, [r5]
	bl	fwrite
	ldrh	r1, [r6, #22]
	ldr	r3, [r7]
	mov	r2, #1
	strb	r1, [r5]
	lsr	ip, r1, #8
	mov	r0, r5
	mov	r1, #2
	strb	ip, [r5, #1]
	bl	fwrite
	ldr	ip, [r6, #24]
	ldr	r3, [r7]
	mov	r2, #1
	mov	r1, #4
	str	ip, [r4]	@ unaligned
	mov	r0, r4
	bl	fwrite
	ldr	ip, [r6, #28]
	ldr	r3, [r7]
	mov	r2, #1
	mov	r1, #4
	str	ip, [r4]	@ unaligned
	mov	r0, r4
	bl	fwrite
	ldrh	r1, [r6, #32]
	ldr	r3, [r7]
	mov	r2, #1
	strb	r1, [r5]
	lsr	ip, r1, #8
	mov	r0, r5
	mov	r1, #2
	strb	ip, [r5, #1]
	bl	fwrite
	ldrh	r1, [r6, #34]
	ldr	r3, [r7]
	mov	r2, #1
	strb	r1, [r5]
	lsr	ip, r1, #8
	mov	r0, r5
	mov	r1, #2
	strb	ip, [r5, #1]
	bl	fwrite
	ldr	r3, [r7]
	mov	r2, #1
	mov	r1, #4
	add	r0, r6, #36
	bl	fwrite
	ldr	r8, .L32+16
	ldr	r1, [r6, #40]
	ldr	r3, [r7]
	str	r1, [r4]	@ unaligned
	mov	r0, r4
	mov	r2, #1
	mov	r1, #4
	bl	fwrite
	ldr	r3, [r8]
	cmp	r3, #0
	popeq	{r4, r5, r6, r7, r8, r9, r10, pc}
	mov	r4, #0
	mov	r9, r5
.L26:
	ldr	r1, [r6, #44]
	lsl	r2, r4, #1
	ldr	r3, [r7]
	ldrsh	lr, [r1, r2]
	mov	r0, r9
	mov	r2, #1
	mov	r1, #2
	uxth	ip, lr
	strb	lr, [r5]
	lsr	ip, ip, #8
	strb	ip, [r5, #1]
	bl	fwrite
	ldr	r3, [r8]
	add	r4, r4, #1
	cmp	r3, r4
	bhi	.L26
	pop	{r4, r5, r6, r7, r8, r9, r10, pc}
.L33:
	.align	2
.L32:
	.word	ofp
	.word	wave
	.word	buffer_4
	.word	buffer_2
	.word	num_samples
	.size	write_wav, .-write_wav
	.comm	buffer_4,4,4
	.comm	buffer_2,2,4
	.comm	compressed_wave,48,4
	.comm	wave,48,4
	.comm	bytes_per_sample,2,2
	.comm	num_samples,4,4
	.comm	ofp,4,4
	.comm	ifp,4,4
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"(1-4): %s\012\000"
	.space	1
.LC1:
	.ascii	"(5-8): Total Size: %u bytes, %ukb\012\000"
	.space	1
.LC2:
	.ascii	"(9-12): %s\012\000"
.LC3:
	.ascii	"(13-16): %s\012\000"
	.space	3
.LC4:
	.ascii	"(17-20): Format Length: %u bytes\012\000"
	.space	2
.LC5:
	.ascii	"(21-22): Format Type: %u\012\000"
	.space	2
.LC6:
	.ascii	"(23-24): Channels: %u\012\000"
	.space	1
.LC7:
	.ascii	"(25-28): Sample Rate: %u Hz\012\000"
	.space	3
.LC8:
	.ascii	"(29-32): Byte Rate: %u bytes/s\012\000"
.LC9:
	.ascii	"(33-34): Block Align: %u\012\000"
	.space	2
.LC10:
	.ascii	"(35-36): Bits Per Sample: %u\012\000"
	.space	2
.LC11:
	.ascii	"(37-40): %s\012\000"
	.space	3
.LC12:
	.ascii	"(40-44): Data Length: %u bytes, %ukb\012\012\000"
	.space	1
.LC13:
	.ascii	"Number of Samples: %u\012\000"
	.space	1
.LC14:
	.ascii	"Bytes per Sample: %u\012\012\000"
	.space	1
.LC15:
	.ascii	"Could not allocate memory for samples.\000"
	.ident	"GCC: (Raspbian 8.3.0-6+rpi1) 8.3.0"
	.section	.note.GNU-stack,"",%progbits
