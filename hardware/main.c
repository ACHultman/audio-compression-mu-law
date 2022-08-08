#include <stdint.h>
#include <time.h>
#include <stdio.h>
#include <stdlib.h>
#include "main.h"

time_t start, end; // For timing

int main(int argc, char* argv[]) {
	if (3 > argc) 
	{
		printf("Please enter the input and output file names.\n");
		printf("Usage: %s <input file> <output file>\n", argv[0]);
		exit(1);
	}

	// Read input wave file

	// Open file
	ifp = fopen(argv[1], "rb");
	if (NULL == ifp) 
	{
		printf("Error opening file\n");
		exit(1);
	}

	read_wav();
	fclose(ifp);

	compress();
	decompress();
	
	// Write output wave file
	ofp = fopen(argv[2], "wb");
	if (NULL == ofp) 
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