#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include "main.h"

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
    // - return codeword directly
	// 	 instead of wasting time on the if-else statement

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

    // OPTIMIZATION: use switch statement instead of if-else statement
	switch (chord) {
		case 0x0:
			return (1 << 5) | (step << 1) | 1;
		case 0x1:
			return (1 << 6) | (step << 2) | (1 << 1);
		case 0x2:
			return (1 << 7) | (step << 3) | (1 << 2);
		case 0x3:
			return (1 << 8) | (step << 4) | (1 << 3);
		case 0x4:
			return (1 << 9) | (step << 5) | (1 << 4);
		case 0x5:
			return (1 << 10) | (step << 6) | (1 << 5);
		case 0x6:
			return (1 << 11) | (step << 7) | (1 << 6);
		case 0x7:
			return (1 << 12) | (step << 8) | (1 << 7);
		default:
			printf("Invalid chord while decompressing.\n");
			printf("Chord: %d\n", chord);
			exit(1);
	}
}
