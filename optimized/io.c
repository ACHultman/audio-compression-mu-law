#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include "main.h"

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
void convert_short_to_little_endian(unsigned char* buffer_2, uint16_t be_num) {
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
void convert_int_to_little_endian(unsigned char* buffer_4, uint32_t be_num) {
	buffer_4[0] = be_num & 0x000000FF;
	buffer_4[1] = (be_num & 0x0000FF00) >> 8;
	buffer_4[2] = (be_num & 0x00FF0000) >> 16;
	buffer_4[3] = (be_num & 0xFF000000) >> 24;
}