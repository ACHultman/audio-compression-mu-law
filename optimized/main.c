#include <stdint.h>
#include <time.h>
#include <stdio.h>
#include <stdlib.h>
#include "main.h"

time_t start, end; // For timing

int main(int argc, char* argv[]) {
	if (argc < 3)
	{
		printf("Please enter the input and output file names.\n");
		printf("Usage: %s <input file> <output file>\n", argv[0]);
		exit(1);
	}

	printf("\nUsing file: %s\n\n", argv[1]);

	// Read input wave file

	// Open file
	ifp = fopen(argv[1], "rb");
	if (ifp == NULL) 
	{
		printf("Error opening file\n");
		exit(1);
	}

	read_wav();
	fclose(ifp);
	// print_header();

	// Compression
	start = clock();
	compress();
	end = clock();
	printf("Compressed %u samples in %us\n", num_samples, (uint32_t)((end - start) / CLOCKS_PER_SEC));

	// Decompression
	start = clock();
	decompress();
	end = clock();
	printf("Decompressed %u samples in %us\n\n", num_samples, (uint32_t)((end - start) * CLOCKS_PER_SEC));
	
	// Write output wave file

	ofp = fopen(argv[2], "wb");
	if (ofp == NULL) 
	{
		printf("Error creating output file\n");
		exit(1);
	}

	write_wav();
	fclose(ofp);

	free(wave.samples);
	free(compressed_wave.samples);
	exit(0);
}