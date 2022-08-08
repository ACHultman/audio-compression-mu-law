#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include "main.h"

// TODO possible optimization: use a single array for both wave and compressed_wave?
// TODO possible optimization: use local variables for wave and compressed_wave instead of global variables?

/**
 * @brief Compresses the wave data using MuLaw encoding
 */
void compress() {
	compressed_wave.samples = calloc(num_samples, sizeof(uint8_t));
	if (NULL == compressed_wave.samples) 
	{
		printf("Could not allocate memory for compressed samples.\n");
		exit(1);
	}

	int16_t sample; // 16-bit signed integer
	uint16_t mag; // 16-bit unsigned integer - magnitude of sample
	uint8_t sign; // 8-bit unsigned integer - sign of sample
	uint8_t codeword; // 8-bit unsigned integer - MuLaw codeword for sample

	int i;
	for (i = 0; i < num_samples; i++)
	{
		sample = (wave.samples[i] >> 2); // right shift by 2 to get rid of last 2 bits (only 1 sign bit, 13 magnitude bits are used)
		sign = signum(sample); // get sign of sample
		mag = magnitude(sample) + 33; // get magnitude of sample and add 33 so that it is a power of 2
		codeword = find_codeword(sign, mag);
		codeword = ~codeword;

        // TODO: possible optimizations:
        // - use loop unrolling
        // - use bitwise operations instead of logical operations

		compressed_wave.samples[i] = codeword; // store codeword in compressed wave structure
	}
}

/**
 * @brief Use MuLaw encoding to find the codeword for a sample
 * 
 * @param sign - sign of sample
 * @param mag - magnitude of sample
 * @return uint8_t - MuLaw codeword for sample
 */
uint8_t find_codeword(uint8_t sign, uint16_t mag) {
	uint8_t chord, step;

    // TODO possible optimizations:
    // - use lookup table
    // - use switch statement instead of if-else statement
    // - return codeword directly instead of wasting time on the if-else statement

	// Chord corresponds to the location of the msb of 1 in the magnitude
	if (mag & (1 << 12)) 
	{
		chord = 0x7;
		step = (mag >> 8) & 0xF;
	}
	else if (mag & (1 << 11)) 
	{
		chord = 0x6;
		step = (mag >> 7) & 0xF;
	}
	else if (mag & (1 << 10)) 
	{
		chord = 0x5;
		step = (mag >> 6) & 0xF;
	}
	else if (mag & (1 << 9)) 
	{
		chord = 0x4;
		step = (mag >> 5) & 0xF;
	}
	else if (mag & (1 << 8)) 
	{
		chord = 0x3;
		step = (mag >> 4) & 0xF;
	}
	else if (mag & (1 << 7)) 
	{
		chord = 0x2;
		step = (mag >> 3) & 0xF;
	}
	else if (mag & (1 << 6)) 
	{
		chord = 0x1;
		step = (mag >> 2) & 0xF;
	}
	else if (mag & (1 << 5)) 
	{
		chord = 0x0;
		step = (mag >> 1) & 0xF;
	}
	else 
	{
		printf("Invalid magnitude while compressing.\n");
		printf("Magnitude: %d\n", mag);
		exit(1);
	}

	return (sign << 7) | (chord << 4) | step;
}

/**
 * @brief Finds the sign of a sample
 * 
 * @param sample - sample to find sign of
 * @return int - sign of sample
 */
uint8_t signum(int16_t sample) {
	return sample & (1 << 15) ? 0 : 1;
}

/**
 * @brief Gets the sign of a compressed sample
 * 
 * @param codeword - compressed sample to find sign of
 * @return uint8_t - sign of compressed sample
 */
uint8_t compressed_signum(uint8_t codeword) {
	return codeword & (1 << 7) ? 0 : 1;
}

/**
 * @brief Gets the magnitude of a sample
 * 
 * @param sample - sample to find magnitude of
 * @return uint16_t - magnitude of sample
 */
uint16_t magnitude(int16_t sample) {
	if (0 > sample) 
	{
		sample = -sample;
	}

	return (uint16_t)sample;
}

/**
 * @brief Gets the magnitude of a compressed sample
 * 
 * @param codeword - compressed sample to find magnitude of
 * @return uint16_t - magnitude of compressed sample
 */
uint16_t compressed_magnitude(uint8_t codeword) {
	uint8_t chord = (codeword >> 4) & 0x7;
	uint8_t step = codeword & 0xF;

    // TODO possible optimizations:
    // - use switch statement instead of if-else statement

	if (0x7 == chord) 
	{
		return (1 << 12) | (step << 8) | (1 << 7);
	}
	else if (0x6 == chord) 
	{
		return (1 << 11) | (step << 7) | (1 << 6);
	}
	else if (0x5 == chord) 
	{
		return (1 << 10) | (step << 6) | (1 << 5);
	}
	else if (0x4 == chord) 
	{
		return (1 << 9) | (step << 5) | (1 << 4);
	}
	else if (0x3 == chord) 
	{
		return (1 << 8) | (step << 4) | (1 << 3);
	}
	else if (0x2 == chord) 
	{
		return (1 << 7) | (step << 3) | (1 << 2);
	}
	else if (0x1 == chord) 
	{
		return (1 << 6) | (step << 2) | (1 << 1);
	}
	else if (0x0 == chord) 
	{
		return (1 << 5) | (step << 1) | 1;
	}
	else 
	{
		printf("Invalid chord while decompressing.\n");
		printf("Chord: %d\n", chord);
		exit(1);
	}
}

/**
 * @brief Decompresses the wave data using MuLaw encoding
 */
void decompress() {
	int16_t sample; // 16-bit signed integer
	uint16_t mag; // 16-bit unsigned integer - magnitude of sample
	uint8_t sign; // 8-bit unsigned integer - sign of sample
	uint8_t codeword; // 8-bit unsigned integer - MuLaw codeword for sample

    // TODO possible optimizations:
    // - use loop unrolling
    // - use bitwise operations instead of logical operations

	int i;
	for (i = 0; i < num_samples; i++) 
	{
		codeword = compressed_wave.samples[i];
		codeword = ~codeword;
		sign = compressed_signum(codeword);
		mag = compressed_magnitude(codeword);
		mag -= 33;
		sample = (int16_t)(sign ? -mag : mag); // WARNING: assuming max of ~9000
		wave.samples[i] = (sample << 2); // shift sample left by 2 to make it 16-bit
	}
}
