#include <stdint.h>
#include <time.h>
#include <stdio.h>
#include <stdlib.h>
#include "main.h"

int main(int argc, char* argv[]) {
	if (argc < 3)
	{
		printf("Please enter the input and output file names.\n");
		printf("Usage: %s <input file> <output file>\n", argv[0]);
		exit(1);
	}

	FILE* ifp; // input file pointer
	FILE* ofp; // output file pointer
	uint32_t num_samples; // number of samples in the file
	uint16_t bytes_per_sample; // number of bytes per sample
	WAVE wave; // Wave structure - read from file
	COMPRESSED_WAVE compressed_wave; // Compressed wave structure - MuLaw compressed

	unsigned char buffer_2[2]; // buffer for 2 bytes - used for reading and writing
	unsigned char buffer_4[4]; // buffer for 4 bytes - used for reading and writing

	// Open file
	ifp = fopen(argv[1], "rb");
	if (ifp == NULL) 
	{
		printf("Error opening file\n");
		exit(1);
	}

	// RIFF chunk
	fread(wave.riff.riff, sizeof(wave.riff.riff), 1, ifp);

	// chunk size
	fread(buffer_4, sizeof(buffer_4), 1, ifp);
	wave.riff.chunk_size = convert_int_to_big_endian(buffer_4);

	// WAVE
	fread(wave.riff.format, sizeof(wave.riff.format), 1, ifp);

	// fmt chunk
	fread(wave.fmt.id, sizeof(wave.fmt.id), 1, ifp);

	// chunk size
	fread(buffer_4, sizeof(buffer_4), 1, ifp);
	wave.fmt.size = convert_int_to_big_endian(buffer_4);

	// compression code
	fread(buffer_2, sizeof(buffer_2), 1, ifp);
	wave.fmt.audio_format = convert_short_to_big_endian(buffer_2);

	// number of channels
	fread(buffer_2, sizeof(buffer_2), 1, ifp);
	wave.fmt.num_channels = convert_short_to_big_endian(buffer_2);

	// sample rate
	fread(buffer_4, sizeof(buffer_4), 1, ifp);
	wave.fmt.sample_rate = convert_int_to_big_endian(buffer_4);

	// bytes per second
	fread(buffer_4, sizeof(buffer_4), 1, ifp);
	wave.fmt.byte_rate = convert_int_to_big_endian(buffer_4);

	// block align
	fread(buffer_2, sizeof(buffer_2), 1, ifp);
	wave.fmt.block_align = convert_short_to_big_endian(buffer_2);

	// bits per sample
	fread(buffer_2, sizeof(buffer_2), 1, ifp);
	wave.fmt.bits_per_sample = convert_short_to_big_endian(buffer_2);

	// data chunk
	fread(wave.fmt.data_id, sizeof(wave.fmt.data_id), 1, ifp);

	// chunk size
	fread(buffer_4, sizeof(buffer_4), 1, ifp);
	wave.fmt.data_size = convert_int_to_big_endian(buffer_4);

	bytes_per_sample = (wave.fmt.bits_per_sample * wave.fmt.num_channels) / 8;

	num_samples = wave.fmt.data_size / (bytes_per_sample * wave.fmt.num_channels);

	wave.samples = calloc(num_samples, bytes_per_sample);
	if (wave.samples == NULL) 
	{
		printf("Could not allocate memory for samples.\n");
		exit(1);
	}

	// Read the samples - assume 16-bit little-endian
	int i;
	for (i = 0; i < num_samples; i++) 
	{
		fread(buffer_2, sizeof(buffer_2), 1, ifp);
		wave.samples[i] = (int16_t)convert_short_to_big_endian(buffer_2);
	}
	fclose(ifp);

	// Compression
	time_t start = clock();
	compressed_wave.samples = calloc(num_samples, sizeof(uint8_t));
	if (compressed_wave.samples == NULL) 
	{
		printf("Could not allocate memory for compressed samples.\n");
		exit(1);
	}

	int16_t pcm_sample; // 16-bit signed integer
	uint16_t pcm_mag; // 16-bit unsigned integer - magnitude of sample
	uint8_t pcm_sign; // 8-bit unsigned integer - sign of sample

	// OPTIMZATION: loop exit condition and decrement
	int j;
	for (j = num_samples; j != 0; j--) 
	{
		pcm_sample = (wave.samples[j] >> 2); // right shift by 2 to get rid of last 2 bits (only 1 sign bit, 13 magnitude bits are used)
		pcm_sign = pcm_sample & (1 << 15) ? 0 : 1; // OPTIMIZATION: replace helper function
		pcm_mag =  (pcm_sample < 0 ? (uint16_t)(-pcm_sample) : (uint16_t)pcm_sample) + 33; // OPTIMIZATION: replace helper function
		compressed_wave.samples[j] = ~(find_codeword(pcm_sign, pcm_mag)); // OPTIMIZATION: replace onto single line - compiler should do this for us
	}

	time_t end = clock();
	printf("Compressed %u samples in %.7fs\n", num_samples, (double)(end - start) / CLOCKS_PER_SEC);

	// Decompression
	start = clock();
	int16_t sample; // 16-bit signed integer
	uint16_t mag; // 16-bit unsigned integer - magnitude of sample
	uint8_t sign; // 8-bit unsigned integer - sign of sample
	uint8_t codeword; // 8-bit unsigned integer - MuLaw codeword for sample

	// OPTIMIZATION: loop exit condition + decrement instead of increment
	int k;
	for (k = num_samples; k != 0; k--) 
	{
		codeword = ~(compressed_wave.samples[k]); // OPTIMIZATION: collapse into single line
		sign = codeword & (1 << 7) ? 0 : 1; // OPTIMIZATION: replace helper function call with bitwise operation
		mag = compressed_magnitude(codeword) - 33; // OPTIMIZATION: collapse into single line
		wave.samples[k] = ((int16_t)(sign ? -mag : mag) << 2); // shift sample left by 2 to make it 16-bit
	}

	end = clock();

	printf("Decompressed in %.7fs\n", (double)(end - start) / CLOCKS_PER_SEC);
	
	// Write output wave file

	ofp = fopen(argv[2], "wb");
	if (ofp == NULL) 
	{
		printf("Error creating output file\n");
		exit(1);
	}
		
	// RIFF chunk
	fwrite(wave.riff.riff, sizeof(wave.riff.riff), 1, ofp);

	// chunk size
	convert_int_to_little_endian(buffer_4, wave.riff.chunk_size);
	fwrite(buffer_4, sizeof(buffer_4), 1, ofp);

	// WAVE
	fwrite(wave.riff.format, sizeof(wave.riff.format), 1, ofp);

	// fmt chunk
	fwrite(wave.fmt.id, sizeof(wave.fmt.id), 1, ofp);

	// chunk size
	convert_int_to_little_endian(buffer_4, wave.fmt.size);
	fwrite(buffer_4, sizeof(buffer_4), 1, ofp);

	// compression code
	convert_short_to_little_endian(buffer_2, wave.fmt.audio_format);
	fwrite(buffer_2, sizeof(buffer_2), 1, ofp);

	// number of channels
	convert_short_to_little_endian(buffer_2, wave.fmt.num_channels);
	fwrite(buffer_2, sizeof(buffer_2), 1, ofp);

	// sample rate
	convert_int_to_little_endian(buffer_4, wave.fmt.sample_rate);
	fwrite(buffer_4, sizeof(buffer_4), 1, ofp);

	// bytes per second
	convert_int_to_little_endian(buffer_4, wave.fmt.byte_rate);
	fwrite(buffer_4, sizeof(buffer_4), 1, ofp);

	// block align
	convert_short_to_little_endian(buffer_2, wave.fmt.block_align);
	fwrite(buffer_2, sizeof(buffer_2), 1, ofp);

	// bits per sample
	convert_short_to_little_endian(buffer_2, wave.fmt.bits_per_sample);
	fwrite(buffer_2, sizeof(buffer_2), 1, ofp);

	// data chunk
	fwrite(wave.fmt.data_id, sizeof(wave.fmt.data_id), 1, ofp);

	// chunk size
	convert_int_to_little_endian(buffer_4, wave.fmt.data_size);
	fwrite(buffer_4, sizeof(buffer_4), 1, ofp);

	// Write the samples - 16-bit little-endian
	int l;
	for (l = 0; l < num_samples; l++) 
	{
		convert_short_to_little_endian(buffer_2, (uint16_t)wave.samples[l]);
		fwrite(buffer_2, sizeof(buffer_2), 1, ofp);
	}
	fclose(ofp);

	free(wave.samples);
	free(compressed_wave.samples);
	exit(0);
}