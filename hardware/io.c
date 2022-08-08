#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include "main.h"

FILE* ifp; // input file pointer
FILE* ofp; // output file pointer
uint32_t num_samples; // number of samples in the file
uint16_t bytes_per_sample; // number of bytes per sample
WAVE wave; // Wave structure - read from file
COMPRESSED_WAVE compressed_wave; // Compressed wave structure - MuLaw compressed

unsigned char buffer_2[2]; // buffer for 2 bytes - used for reading and writing
unsigned char buffer_4[4]; // buffer for 4 bytes - used for reading and writing

/**
 * @brief Converts a 16-bit little-endian number to a big-endian number
 * 
 * @param le_num 
 * @return uint16_t 
 */
uint16_t convert_short_to_big_endian(unsigned char* le_num) {
	uint16_t be_num = le_num[0] | (le_num[1] << 8);
	return be_num;
}

/**
 * @brief Converts a 16-bit big-endian number to a little-endian number
 * 
 * @param be_num 
 * @return void
 */
void convert_short_to_little_endian(uint16_t be_num) {
	buffer_2[0] = be_num & 0x00FF;
	buffer_2[1] = (be_num & 0xFF00) >> 8;
}

/**
 * @brief Converts a 32-bit little-endian number to a big-endian number
 * 
 * @param le_num 
 * @return uint32_t 
 */
uint32_t convert_int_to_big_endian(unsigned char* le_num) {
	uint32_t be_num = le_num[0] | (le_num[1] << 8) | (le_num[2] << 16) | (le_num[3] << 24);
	return be_num;
}

/**
 * @brief Converts a 32-bit unsigned int in big-endian form to an array of four bytes in little-endian form
 * 
 * @param be_num 
 * @return void
 */
void convert_int_to_little_endian(uint32_t be_num) {
	buffer_4[0] = be_num & 0x000000FF;
	buffer_4[1] = (be_num & 0x0000FF00) >> 8;
	buffer_4[2] = (be_num & 0x00FF0000) >> 16;
	buffer_4[3] = (be_num & 0xFF000000) >> 24;
}

/**
 * @brief Reads the wave input file and stores the data in the wave structure
 */
void read_wav() {

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
}

/**
 * @brief Writes the (raw->compressed->decompressed) wave to the output file
 */
void write_wav() {
	
	// RIFF chunk
	fwrite(wave.riff.riff, sizeof(wave.riff.riff), 1, ofp);

	// chunk size
	convert_int_to_little_endian(wave.riff.chunk_size);
	fwrite(buffer_4, sizeof(buffer_4), 1, ofp);

	// WAVE
	fwrite(wave.riff.format, sizeof(wave.riff.format), 1, ofp);

	// fmt chunk
	fwrite(wave.fmt.id, sizeof(wave.fmt.id), 1, ofp);

	// chunk size
	convert_int_to_little_endian(wave.fmt.size);
	fwrite(buffer_4, sizeof(buffer_4), 1, ofp);

	// compression code
	convert_short_to_little_endian(wave.fmt.audio_format);
	fwrite(buffer_2, sizeof(buffer_2), 1, ofp);

	// number of channels
	convert_short_to_little_endian(wave.fmt.num_channels);
	fwrite(buffer_2, sizeof(buffer_2), 1, ofp);

	// sample rate
	convert_int_to_little_endian(wave.fmt.sample_rate);
	fwrite(buffer_4, sizeof(buffer_4), 1, ofp);

	// bytes per second
	convert_int_to_little_endian(wave.fmt.byte_rate);
	fwrite(buffer_4, sizeof(buffer_4), 1, ofp);

	// block align
	convert_short_to_little_endian(wave.fmt.block_align);
	fwrite(buffer_2, sizeof(buffer_2), 1, ofp);

	// bits per sample
	convert_short_to_little_endian(wave.fmt.bits_per_sample);
	fwrite(buffer_2, sizeof(buffer_2), 1, ofp);

	// data chunk
	fwrite(wave.fmt.data_id, sizeof(wave.fmt.data_id), 1, ofp);

	// chunk size
	convert_int_to_little_endian(wave.fmt.data_size);
	fwrite(buffer_4, sizeof(buffer_4), 1, ofp);

	// Write the samples - 16-bit little-endian
	int i;
	for (i = 0; i < num_samples; i++) 
	{
		convert_short_to_little_endian((uint16_t)wave.samples[i]);
		fwrite(buffer_2, sizeof(buffer_2), 1, ofp);
	}
}

