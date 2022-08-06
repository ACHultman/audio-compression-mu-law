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
	if (compressed_wave.samples == NULL) 
	{
		printf("Could not allocate memory for compressed samples.\n");
		exit(1);
	}

	int16_t sample; // 16-bit signed integer
	uint16_t mag; // 16-bit unsigned integer - magnitude of sample
	uint8_t sign; // 8-bit unsigned integer - sign of sample
	uint8_t codeword; // 8-bit unsigned integer - MuLaw codeword for sample

	// TODO: possible optimizations:
    // - use loop unrolling
    // - use bitwise operations instead of logical operations


	// OPTIMZATION: loop exit condition and decrement
	// OPTIMIZATION: loop unroll factor is set to 10
	int i;
	for (i = num_samples; i != 0; i--) 
	{
	#pragma HLS unroll factor=10
		sample = (wave.samples[i] >> 2); // right shift by 2 to get rid of last 2 bits (only 1 sign bit, 13 magnitude bits are used)
		sign = sample & (1 << 15) ? 0 : 1; // OPTIMIZATION: replace helper function
		mag =  (sample < 0 ? (uint16_t)(-sample) : (uint16_t)sample) + 33; // OPTIMIZATION: replace helper function
		compressed_wave.samples[i] = ~(find_codeword(sign, mag)); // OPTIMIZATION: replace onto single line - compiler should do this for us
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
 * @brief Gets the magnitude of a compressed sample
 * 
 * @param codeword - compressed sample to find magnitude of
 * @return uint16_t - magnitude of compressed sample
 */
uint16_t compressed_magnitude(uint8_t codeword) {
	uint8_t chord = (codeword >> 4) & 0x7;
	uint8_t step = codeword & 0xF;

	if (chord == 0x7) 
	{
		return (1 << 12) | (step << 8) | (1 << 7);
	}
	else if (chord == 0x6) 
	{
		return (1 << 11) | (step << 7) | (1 << 6);
	}
	else if (chord == 0x5) 
	{
		return (1 << 10) | (step << 6) | (1 << 5);
	}
	else if (chord == 0x4) 
	{
		return (1 << 9) | (step << 5) | (1 << 4);
	}
	else if (chord == 0x3) 
	{
		return (1 << 8) | (step << 4) | (1 << 3);
	}
	else if (chord == 0x2) 
	{
		return (1 << 7) | (step << 3) | (1 << 2);
	}
	else if (chord == 0x1) 
	{
		return (1 << 6) | (step << 2) | (1 << 1);
	}
	else if (chord == 0x0) 
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

	// OPTIMIZATION: loop exit condition + decrement instead of increment
	// OPTIMIZATION: use loop unrolling
	int i;
	for (i = num_samples; i != 0; i--) 
	{
	#pragma HLS unroll factor=10
		codeword = ~(compressed_wave.samples[i]); // OPTIMIZATION: collapse into single line
		sign = codeword & (1 << 7) ? 0 : 1; // OPTIMIZATION: replace helper function call with bitwise operation
		mag = compressed_magnitude(codeword) - 33; // OPTIMIZATION: collapse into single line
		wave.samples[i] = ((int16_t)(sign ? -mag : mag) << 2); // shift sample left by 2 to make it 16-bit
	}
}
