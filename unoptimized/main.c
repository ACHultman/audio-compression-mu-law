#include <stdint.h>
#include <time.h>
#include <stdio.h>
#include <stdlib.h>
#include "main.h"

// For timing
clock_t start;
clock_t end; 

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
	print_header();

	// Compression
	start = clock();
	printf("Starting compression, start_t = %ld\n", start);
	compress();
	end = clock();
	printf("Finished compression, end_t = %ld\n", end);
	printf("Compressed %u samples in %ld\n", num_samples, end - start);

	// Decompression
	start = clock();
	printf("Starting decompression, start_t = %ld\n", start);
	decompress();
	end = clock();
	printf("Finished decompression, end_t = %ld\n", end);
	printf("Decompressed in %ld\n", end - start);
	
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