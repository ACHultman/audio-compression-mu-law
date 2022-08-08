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
	.global	convert_short_to_big_endian
	.arch armv6
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
	lsr	r3, r1, #8
	strb	r1, [r0]
	strb	r3, [r0, #1]
	bx	lr
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
	lsr	ip, r1, #8
	lsr	r2, r1, #16
	lsr	r3, r1, #24
	strb	r1, [r0]
	strb	ip, [r0, #1]
	strb	r2, [r0, #2]
	strb	r3, [r0, #3]
	bx	lr
	.size	convert_int_to_little_endian, .-convert_int_to_little_endian
	.ident	"GCC: (Raspbian 8.3.0-6+rpi1) 8.3.0"
	.section	.note.GNU-stack,"",%progbits
