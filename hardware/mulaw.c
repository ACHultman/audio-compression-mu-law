#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include "main.h"

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

	int i;
	for (i = 0; i < num_samples; i++)
	{
		// OPTIMIZATION: replace with asm
		// muLaw Rt, Rs, Rm
		// Rs = source register - only the ls 14 or 8 bits are relevant depending on mode
		// Rm = mode register - lsb is 1 for compression, 0 for decompression
		// Rt = target register - only the ls 14 or 8 bits are relevant depending on mode
		__asm__ (
			"mulaw   %0, %1, %2" : "=r" (compressed_wave.samples[i]) : "r" (wave.samples[i]), "r" (0x1)
			return ((uint8_t) compressed_wave.samples[i]);
		)
	}
}


/**
 * @brief Decompresses the wave data using MuLaw encoding
 */
void decompress() {
	int i;
	for (i = 0; i < num_samples; i++) 
	{
		// OPTIMIZATION: replace with asm
		// muLaw Rt, Rs, Rm
		// Rs = source register - only the ls 14 or 8 bits are relevant depending on mode
		// Rm = mode register - lsb is 1 for compression, 0 for decompression
		// Rt = target register - only the ls 14 or 8 bits are relevant depending on mode
		__asm__ (
			"mulaw   %0, %1, %2" : "=r" (wave.samples[i]) : "r" (compressed_wave.samples[i]), "r" (0x0)
			return ((uint16_t) wave.samples[i]);
		)
	}
}
