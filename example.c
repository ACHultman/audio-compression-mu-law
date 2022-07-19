#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>
#include "example.h"

FILE *ptr;
char *filename;
struct WAVE_HEADER header;
struct WAVE_FORMAT_CHUNK fmt;
struct WAVE_DATA_CHUNK data_chunk; // temp
struct WAVE_DATA_CHUNK_COMPRESSED compressed_data; // temp
unsigned char buffer4[4];
unsigned char buffer2[2];

long num_samples;
long size_of_each_sample;

int main(){
    ptr = fopen("test.wav", "rb");
    if(ptr == NULL){
        printf("Error opening file\n");
        exit(1);
    }
    readWaveHeader(ptr);
}

int readWaveHeader(FILE *ptr){
    int read = 0;
    
    // RIFF
    read = fread(header.riff, sizeof(header.riff), 1, ptr);
    printf("(1-4): %s \n", header.riff);

    // SIZE
    read = fread(buffer4, sizeof(buffer4), 1, ptr);
    printf("%u %u %u %u\n", buffer4[0], buffer4[1], buffer4[2], buffer4[3]);
    
    // convert little endian to big endian 4 byte int
    header.overall_size  = buffer4[0] |
                        (buffer4[1]<<8) |
                        (buffer4[2]<<16) |
                        (buffer4[3]<<24);
    printf("(5-8) Overall size: bytes:%u, Kb:%u \n", header.overall_size, header.overall_size/1024);
    
    // WAVE
    read = fread(header.wave, sizeof(header.wave), 1, ptr);
    printf("(9-12) Wave marker: %s\n", header.wave);
    
    // fmt 
    read = fread(fmt.chunkType, sizeof(fmt.chunkType), 1, ptr);
    printf("(13-16) Fmt marker: %s\n", fmt.chunkType);
    
    read = fread(buffer4, sizeof(buffer4), 1, ptr);
    printf("%u %u %u %u\n", buffer4[0], buffer4[1], buffer4[2], buffer4[3]);

    // convert little endian to big endian 4 byte integer
    fmt.chunkSize = buffer4[0] |
                            (buffer4[1] << 8) |
                            (buffer4[2] << 16) |
                            (buffer4[3] << 24);
    printf("(17-20) Length of Fmt header: %u \n", fmt.chunkSize);
    
    read = fread(buffer2, sizeof(buffer2), 1, ptr); printf("%u %u \n", buffer2[0], buffer2[1]);
    fmt.audioFormat = buffer2[0] | (buffer2[1] << 8);

    char format_name[10] = "";
    if (fmt.audioFormat == 1)
        strcpy(format_name,"PCM");
    else if (fmt.audioFormat == 6)
        strcpy(format_name, "A-law");
    else if (fmt.audioFormat == 7)
        strcpy(format_name, "Mu-law");
    printf("(21-22) Format type: %u %s \n", fmt.audioFormat, format_name);
    
    // fmt channels
    read = fread(buffer2, sizeof(buffer2), 1, ptr);
    printf("%u %u \n", buffer2[0], buffer2[1]);
    fmt.numChannels = buffer2[0] | (buffer2[1] << 8);
    printf("(23-24) Channels: %u \n", fmt.numChannels);

    // fmt sample rate
    read = fread(buffer4, sizeof(buffer4), 1, ptr);
    printf("%u %u %u %u\n", buffer4[0], buffer4[1], buffer4[2], buffer4[3]);
    fmt.sampleRate = buffer4[0] |
                        (buffer4[1] << 8) |
                        (buffer4[2] << 16) |
                        (buffer4[3] << 24);
    printf("(25-28) Sample rate: %u\n", fmt.sampleRate);

    // fmt byterate
    read = fread(buffer4, sizeof(buffer4), 1, ptr);
    printf("%u %u %u %u\n", buffer4[0], buffer4[1], buffer4[2], buffer4[3]);
    fmt.byteRate  = buffer4[0] |
                        (buffer4[1] << 8) |
                        (buffer4[2] << 16) |
                        (buffer4[3] << 24);
    printf("(29-32) Byte Rate: %u , Bit Rate:%u\n", fmt.byteRate, fmt.byteRate*8);

    // block alignment
    read = fread(buffer2, sizeof(buffer2), 1, ptr);
    printf("%u %u \n", buffer2[0], buffer2[1]);
    fmt.blockAlign = buffer2[0] |
                    (buffer2[1] << 8);
    printf("(33-34) Block Alignment: %u \n", fmt.blockAlign);

    // bits per sample
    read = fread(buffer2, sizeof(buffer2), 1, ptr);
    printf("%u %u \n", buffer2[0], buffer2[1]);
    fmt.bitsPerSample = buffer2[0] |
                    (buffer2[1] << 8);
    printf("(35-36) Bits per sample: %u \n", fmt.bitsPerSample);

    // chunk header marker
    read = fread(data_chunk.chunkId, sizeof(data_chunk.chunkId), 1, ptr);
    printf("(37-40) Data Marker: %s \n", data_chunk.chunkId);

    // chunk size
    read = fread(buffer4, sizeof(buffer4), 1, ptr);
    printf("%u %u %u %u\n", buffer4[0], buffer4[1], buffer4[2], buffer4[3]);
    data_chunk.chunkSize = buffer4[0] |
                    (buffer4[1] << 8) |
                    (buffer4[2] << 16) |
                    (buffer4[3] << 24 );
    printf("(41-44) Size of data chunk: %u \n", data_chunk.chunkSize);

    // calculate no.of samples
    num_samples = (8 * data_chunk.chunkSize) / (fmt.numChannels * fmt.bitsPerSample);
    printf("Number of samples:%lu \n", num_samples);

    size_of_each_sample = (fmt.numChannels * fmt.bitsPerSample) / 8;
    printf("Size of each sample:%ld bytes\n", size_of_each_sample);

    // calculate duration of file
    float duration_in_seconds = (float) header.fileSize / fmt.byteRate;
    printf("Approx.Duration in seconds=%f\n", duration_in_seconds);

    data_chunk.sampleData = calloc(num_samples, size_of_each_sample);

    for (int i = 0; i < num_samples; i++) {
        fread(buffer4, size_of_each_sample, 1, fp);
        data_chunk.sampleData[i] = (buffer[0]) | (buffer[1] << 8);
    }
}

short signum ( short sample ) {
    if( sample < 0)
        return( 0); /* sign is ’0’ for negative samples */
    else
        return( 1); /* sign is ’1’ for positive samples */
}

unsigned short magnitude ( short sample ) {
    if( sample < 0) {
        sample = - sample ;
    }
    return( sample );
}


char codeword_compression ( unsigned short sample_magnitude, short sign ) {
    int chord, step;
    int codeword_tmp;

    if( sample_magnitude & (1 << 12)) {
        chord = 0 x7 ;
        step = ( sample_magnitude >> 8) & 0xF ;
        codeword_tmp = ( sign << 7) & ( chord << 4) & step ;
        return ( (char) codeword_tmp );
    }
    if( sample_magnitude & (1 << 11)) {
        chord = 0 x6 ;
        step = ( sample_magnitude >> 7) & 0xF ;
        codeword_tmp = ( sign << 7) & ( chord << 4) & step ;
        return ( (char) codeword_tmp );
    }
    if( sample_magnitude & (1 << 10)) {
        chord = 0 x5 ;
        step = ( sample_magnitude >> 6) & 0xF ;
        codeword_tmp = ( sign << 7) & ( chord << 4) & step ;
        return ( (char) codeword_tmp );
    }

    if( sample_magnitude & (1 << 9)) {
        chord = 0 x4 ;
        step = ( sample_magnitude >> 5) & 0xF ;
        codeword_tmp = ( sign << 7) & ( chord << 4) & step ;
        return ( (char) codeword_tmp );
    }
    if( sample_magnitude & (1 << 8)) {
        chord = 0 x3 ;
        step = ( sample_magnitude >> 4) & 0xF ;
        codeword_tmp = ( sign << 7) & ( chord << 4) & step ;
        return ( (char) codeword_tmp );
    }
    if( sample_magnitude & (1 << 7)) {
        chord = 0 x2 ;
        step = ( sample_magnitude >> 3) & 0xF ;
        codeword_tmp = ( sign << 7) & ( chord << 4) & step ;
        return ( (char) codeword_tmp );
    }
    if( sample_magnitude & (1 << 6)) {
        chord = 0 x1 ;
        step = ( sample_magnitude >> 2) & 0xF ;
        codeword_tmp = ( sign << 7) & ( chord << 4) & step ;
        return ( (char) codeword_tmp );
    }
    if( sample_magnitude & (1 << 5)) {
        chord = 0 x0 ;
        step = ( sample_magnitude >> 1) & 0xF ;
        codeword_tmp = ( sign << 7) & ( chord << 4) & step ;
        return ( (char) codeword_tmp );
    }
}

unsigned short magnitude_decode(char codeword) {
    int chord = (codeword & 0x70) >> 4;
    int step = codeword & 0x0F;
    int msb = 1, lsb = 1;
    int magnitude;
    
    if (chord == 0x7) {
        magnitude = (lsb << 7) | (step << 8) | (msb << 12);
    }
    else if (chord == 0x6) {
        magnitude = (lsb << 6) | (step << 7) | (msb << 11);
    }
    else if (chord == 0x5) {
        magnitude = (lsb << 5) | (step << 6) | (msb << 10);
    }
    else if (chord == 0x4) {
        magnitude = (lsb << 4) | (step << 5) | (msb << 9);
    }
    else if (chord == 0x3) {
        magnitude = (lsb << 3) | (step << 4) | (msb << 8);
    }
    else if (chord == 0x2) {
        magnitude = (lsb << 2) | (step << 3) | (msb << 7);
    }
    else if (chord == 0x1) {
        magnitude = (lsb << 1) | (step << 2) | (msb << 6);
    }
    else if (chord == 0x0) {
        magnitude = lsb | (step << 1) | (msb << 5);
    }

    return (unsigned short) magnitude;
}

void compressData () {
    // TODO add error checking
    compressed_data.sampleData = calloc(num_samples, size_of_each_sample);

    for (int i = 0; i < num_samples; i++) {
        // get sampple
        short sample = (data_chunk.sampleData[i] >> 2);
        // get sign
        short sign = signum(sample);
        // get magnitude
        unsigned short magninute = magnitude(sample) + 33;
        // gen codeword
        char codeword = codeword_compression(magninute, sign);
        // flip codeword
        codeword = ~codeword;
        // save
        compressed_data.sampleData[i] = codeword;
    }
}

void decompressData () {
    // TODO add error checking

    __uint8_t codeword;
    for (int i = 0; i < numSamples; i++) {
        codeword = ~(compressed_data.sampleData[i]);
        short sign = (codeword & 0x80) >> 7;
        unsigned short magnitude = (magnitude_decode(codeword) - 33);
        short sample = (short) (sign ? magnitude : -magnitude);
        wave.waveDataChunk.sampleData[i] = sample << 2;
    }
}