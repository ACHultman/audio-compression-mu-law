#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>
#include "example.h"

FILE *ptr;
char *filename;
struct WAVE_HEADER header;
struct WAVE_FORMAT_CHUNK fmt;
struct WAVE_DATA_CHUNK first_data_chunk; // temp
unsigned char buffer4[4];
unsigned char buffer2[2];

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
    read = fread(first_data_chunk.chunkId, sizeof(first_data_chunk.chunkId), 1, ptr);
    printf("(37-40) Data Marker: %s \n", first_data_chunk.chunkId);

    // chunk size
    read = fread(buffer4, sizeof(buffer4), 1, ptr);
    printf("%u %u %u %u\n", buffer4[0], buffer4[1], buffer4[2], buffer4[3]);
    first_data_chunk.chunkSize = buffer4[0] |
                    (buffer4[1] << 8) |
                    (buffer4[2] << 16) |
                    (buffer4[3] << 24 );
    printf("(41-44) Size of data chunk: %u \n", first_data_chunk.chunkSize);

    // calculate no.of samples
    long num_samples = (8 * first_data_chunk.chunkSize) / (fmt.numChannels * fmt.bitsPerSample);
    printf("Number of samples:%lu \n", num_samples);

    long size_of_each_sample = (fmt.numChannels * fmt.bitsPerSample) / 8;
    printf("Size of each sample:%ld bytes\n", size_of_each_sample);

    // calculate duration of file
    float duration_in_seconds = (float) header.fileSize / fmt.byteRate;
    printf("Approx.Duration in seconds=%f\n", duration_in_seconds);
}

int signum ( int sample ) {
    if( sample < 0)
        return( 0); /* sign is ’0’ for negative samples */
    else
        return( 1); /* sign is ’1’ for positive samples */
}

int magnitude ( int sample ) {
    if( sample < 0) {
        sample = - sample ;
    }
    return( sample );
}


char codeword_compression ( unsigned int sample_magnitude, int sign ) {
    int chord, step;
    int codeword_tmp;

    if( sample_magnitude & (1 << 12)) {
        chord = 0 x7 ;
        step = ( sample_magnitude >> 8) & 0 xF ;
        codeword_tmp = ( sign << 7) & ( chord << 4) & step ;
        return ( (char) codeword_tmp );
    }
    if( sample_magnitude & (1 << 11)) {
        chord = 0 x6 ;
        step = ( sample_magnitude >> 7) & 0 xF ;
        codeword_tmp = ( sign << 7) & ( chord << 4) & step ;
        return ( (char) codeword_tmp );
    }
    if( sample_magnitude & (1 << 10)) {
        chord = 0 x5 ;
        step = ( sample_magnitude >> 6) & 0 xF ;
        codeword_tmp = ( sign << 7) & ( chord << 4) & step ;
        return ( (char) codeword_tmp );
    }

    if( sample_magnitude & (1 << 9)) {
        chord = 0 x4 ;
        step = ( sample_magnitude >> 5) & 0 xF ;
        codeword_tmp = ( sign << 7) & ( chord << 4) & step ;
        return ( (char) codeword_tmp );
    }
    if( sample_magnitude & (1 << 8)) {
        chord = 0 x3 ;
        step = ( sample_magnitude >> 4) & 0 xF ;
        codeword_tmp = ( sign << 7) & ( chord << 4) & step ;
        return ( (char) codeword_tmp );
    }
    if( sample_magnitude & (1 << 7)) {
        chord = 0 x2 ;
        step = ( sample_magnitude >> 3) & 0 xF ;
        codeword_tmp = ( sign << 7) & ( chord << 4) & step ;
        return ( (char) codeword_tmp );
    }
    if( sample_magnitude & (1 << 6)) {
        chord = 0 x1 ;
        step = ( sample_magnitude >> 2) & 0 xF ;
        codeword_tmp = ( sign << 7) & ( chord << 4) & step ;
        return ( (char) codeword_tmp );
    }
    if( sample_magnitude & (1 << 5)) {
        chord = 0 x0 ;
        step = ( sample_magnitude >> 1) & 0 xF ;
        codeword_tmp = ( sign << 7) & ( chord << 4) & step ;
        return ( (char) codeword_tmp );
    }
}