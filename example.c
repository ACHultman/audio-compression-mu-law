#include <stdio.h>
#include <string.h>
//#include <unistd.h>
#include <stdlib.h>
#include "example.h"
//#include "arm_neon.h"

FILE *ptr;
char *filename;
struct WAVE wave;
struct WAVE_DATA_CHUNK_COMPRESSED compressed_data;
unsigned char buffer4[4];
unsigned char buffer2[2];

void compressData();
void decompressData();

void writeWaveFile(char *);

long num_samples;
long size_of_each_sample;

int main( int argc, char *argv[] ) {
    filename = argv[1];
    ptr = fopen(filename, "rb");
    if(ptr == NULL){
        printf("Error opening file\n");
        exit(1);
    }

    readWaveHeader(ptr);
    compressData();
    decompressData();
    writeWaveFile("decompressed.wav");
}

int readWaveHeader(FILE *ptr){
    int read = 0;
    
    // RIFF
    read = fread(wave.waveHeader.riff, sizeof(wave.waveHeader.riff), 1, ptr);
    printf("(1-4): %s \n", wave.waveHeader.riff);

    // SIZE
    read = fread(buffer4, sizeof(buffer4), 1, ptr);
    printf("%u %u %u %u\n", buffer4[0], buffer4[1], buffer4[2], buffer4[3]);
    
    // convert little endian to big endian 4 byte int
    wave.waveHeader.fileSize  = buffer4[0] |
                        (buffer4[1]<<8) |
                        (buffer4[2]<<16) |
                        (buffer4[3]<<24);
    printf("(5-8) Overall size: bytes:%u, Kb:%u \n", wave.waveHeader.fileSize, wave.waveHeader.fileSize/1024);
    
    // WAVE
    read = fread(wave.waveHeader.wave, sizeof(wave.waveHeader.wave), 1, ptr);
    printf("(9-12) Wave marker: %s\n", wave.waveHeader.wave);
    
    // wave.waveFormatChunk 
    read = fread(wave.waveFormatChunk.chunkType, sizeof(wave.waveFormatChunk.chunkType), 1, ptr);
    printf("(13-16) wave.waveFormatChunk marker: %s\n", wave.waveFormatChunk.chunkType);
    
    read = fread(buffer4, sizeof(buffer4), 1, ptr);
    printf("%u %u %u %u\n", buffer4[0], buffer4[1], buffer4[2], buffer4[3]);

    // convert little endian to big endian 4 byte integer
    wave.waveFormatChunk.chunkSize = buffer4[0] |
                            (buffer4[1] << 8) |
                            (buffer4[2] << 16) |
                            (buffer4[3] << 24);
    printf("(17-20) Length of wave.waveFormatChunk wave.waveHeader: %u \n", wave.waveFormatChunk.chunkSize);
    
    read = fread(buffer2, sizeof(buffer2), 1, ptr); printf("%u %u \n", buffer2[0], buffer2[1]);
    wave.waveFormatChunk.audioFormat = buffer2[0] | (buffer2[1] << 8);

    char format_name[10] = "";
    if (wave.waveFormatChunk.audioFormat == 1)
        strcpy(format_name,"PCM");
    else if (wave.waveFormatChunk.audioFormat == 6)
        strcpy(format_name, "A-law");
    else if (wave.waveFormatChunk.audioFormat == 7)
        strcpy(format_name, "Mu-law");
    printf("(21-22) Format type: %u %s \n", wave.waveFormatChunk.audioFormat, format_name);
    
    // wave.waveFormatChunk channels
    read = fread(buffer2, sizeof(buffer2), 1, ptr);
    printf("%u %u \n", buffer2[0], buffer2[1]);
    wave.waveFormatChunk.numChannels = buffer2[0] | (buffer2[1] << 8);
    printf("(23-24) Channels: %u \n", wave.waveFormatChunk.numChannels);

    // wave.waveFormatChunk sample rate
    read = fread(buffer4, sizeof(buffer4), 1, ptr);
    printf("%u %u %u %u\n", buffer4[0], buffer4[1], buffer4[2], buffer4[3]);
    wave.waveFormatChunk.sampleRate = buffer4[0] |
                        (buffer4[1] << 8) |
                        (buffer4[2] << 16) |
                        (buffer4[3] << 24);
    printf("(25-28) Sample rate: %u\n", wave.waveFormatChunk.sampleRate);

    // wave.waveFormatChunk byterate
    read = fread(buffer4, sizeof(buffer4), 1, ptr);
    printf("%u %u %u %u\n", buffer4[0], buffer4[1], buffer4[2], buffer4[3]);
    wave.waveFormatChunk.byteRate  = buffer4[0] |
                        (buffer4[1] << 8) |
                        (buffer4[2] << 16) |
                        (buffer4[3] << 24);
    printf("(29-32) Byte Rate: %u , Bit Rate:%u\n", wave.waveFormatChunk.byteRate, wave.waveFormatChunk.byteRate*8);

    // block alignment
    read = fread(buffer2, sizeof(buffer2), 1, ptr);
    printf("%u %u \n", buffer2[0], buffer2[1]);
    wave.waveFormatChunk.blockAlign = buffer2[0] |
                    (buffer2[1] << 8);
    printf("(33-34) Block Alignment: %u \n", wave.waveFormatChunk.blockAlign);

    // bits per sample
    read = fread(buffer2, sizeof(buffer2), 1, ptr);
    printf("%u %u \n", buffer2[0], buffer2[1]);
    wave.waveFormatChunk.bitsPerSample = buffer2[0] |
                    (buffer2[1] << 8);
    printf("(35-36) Bits per sample: %u \n", wave.waveFormatChunk.bitsPerSample);

    // chunk wave.waveHeader marker
    read = fread(wave.waveDataChunk.chunkId, sizeof(wave.waveDataChunk.chunkId), 1, ptr);
    printf("(37-40) Data Marker: %s \n", wave.waveDataChunk.chunkId);

    // chunk size
    read = fread(buffer4, sizeof(buffer4), 1, ptr);
    printf("%u %u %u %u\n", buffer4[0], buffer4[1], buffer4[2], buffer4[3]);
    wave.waveDataChunk.chunkSize = buffer4[0] |
                    (buffer4[1] << 8) |
                    (buffer4[2] << 16) |
                    (buffer4[3] << 24 );
    printf("(41-44) Size of data chunk: %u \n", wave.waveDataChunk.chunkSize);

    // calculate no.of samples
    num_samples = (8 * wave.waveDataChunk.chunkSize) / (wave.waveFormatChunk.numChannels * wave.waveFormatChunk.bitsPerSample);
    printf("Number of samples:%lu \n", num_samples);

    size_of_each_sample = (wave.waveFormatChunk.numChannels * wave.waveFormatChunk.bitsPerSample) / 8;
    printf("Size of each sample:%ld bytes\n", size_of_each_sample);

    // calculate duration of file
    float duration_in_seconds = (float) wave.waveHeader.fileSize / wave.waveFormatChunk.byteRate;
    printf("Approx.Duration in seconds=%f\n", duration_in_seconds);

    wave.waveDataChunk.sampleData = calloc(num_samples, size_of_each_sample);

    // print all header and format chunk data
    printf("\n\n");
    printf("wave.waveHeader.riff: %s\n", wave.waveHeader.riff);
    printf("wave.waveHeader.fileSize: %u\n", wave.waveHeader.fileSize);
    printf("wave.waveHeader.waveId: %s\n", wave.waveHeader.wave);

    printf("wave.waveFormatChunk.chunkId: %s\n", wave.waveFormatChunk.chunkType);
    printf("wave.waveFormatChunk.chunkSize: %u\n", wave.waveFormatChunk.chunkSize);
    printf("wave.waveFormatChunk.audioFormat: %u\n", wave.waveFormatChunk.audioFormat);
    printf("wave.waveFormatChunk.numChannels: %u\n", wave.waveFormatChunk.numChannels);
    printf("wave.waveFormatChunk.sampleRate: %u\n", wave.waveFormatChunk.sampleRate);
    printf("wave.waveFormatChunk.byteRate: %u\n", wave.waveFormatChunk.byteRate);
    printf("wave.waveFormatChunk.blockAlign: %u\n", wave.waveFormatChunk.blockAlign);
    printf("wave.waveFormatChunk.bitsPerSample: %u\n", wave.waveFormatChunk.bitsPerSample);

    printf("\nwave.waveDataChunk.chunkId: %s\n", wave.waveDataChunk.chunkId);
    printf("wave.waveDataChunk.chunkSize: %u\n", wave.waveDataChunk.chunkSize);
    printf("wave.waveDataChunk.sampleData: %p\n\n", wave.waveDataChunk.sampleData);
    
    int i;
    for (i = 0; i < num_samples; i++) {
        fread(buffer4, size_of_each_sample, 1, ptr);
        wave.waveDataChunk.sampleData[i] = (buffer4[0]) | (buffer4[1] << 8);
    }
}

void convertIntToLittleEndian(__uint32_t chunk) {
    buffer4[0] =  chunk & 0x000000FF;
    buffer4[1] = (chunk & 0x0000FF00) >> 8;
    buffer4[2] = (chunk & 0x00FF0000) >> 16;
    buffer4[3] = (chunk & 0xFF000000) >> 24;
}

void convertShortToLittleEndian(__uint16_t chunk) {
    buffer2[0] =  chunk & 0x000000FF;
    buffer2[1] = (chunk & 0x0000FF00) >> 8;
}


void writeWaveFile(char *filename) {
    FILE *o_ptr;
    o_ptr = fopen(filename, "wb");
    if (o_ptr == NULL) {
        printf("Error opening file!\n");
        exit(1);
    }

    printf("\nWriting wave file...\n");
    fwrite(wave.waveHeader.riff, sizeof(wave.waveHeader.riff), 1, o_ptr);
    
    convertIntToLittleEndian(wave.waveHeader.fileSize); 
    fwrite(buffer4, sizeof(buffer4), 1, o_ptr);

    fwrite(wave.waveHeader.wave, sizeof(wave.waveHeader.wave), 1, o_ptr);

    printf("Writing format chunk\n");
    fwrite(wave.waveFormatChunk.chunkType, sizeof(wave.waveFormatChunk.chunkType), 1, o_ptr);

    printf("Writing format chunk size\n");
    convertIntToLittleEndian(wave.waveFormatChunk.chunkSize); 
    printf("%u %u %u %u\n", buffer4[0], buffer4[1], buffer4[2], buffer4[3]);
    fwrite(buffer4, sizeof(buffer4), 1, o_ptr);

    printf("Writing format chunk audio format\n");
    convertShortToLittleEndian(wave.waveFormatChunk.audioFormat);
    printf("%u %u\n", buffer2[0], buffer2[1]);
    fwrite(buffer2, sizeof(buffer2), 1, o_ptr);

    printf("Writing format chunk num channels\n");
    convertShortToLittleEndian(wave.waveFormatChunk.numChannels);
    printf("%u %u\n", buffer2[0], buffer2[1]); 
    fwrite(buffer2, sizeof(buffer2), 1, o_ptr);
    
    printf("Writing format chunk sample rate\n");
    convertIntToLittleEndian(wave.waveFormatChunk.sampleRate);
    printf("%u %u %u %u\n", buffer4[0], buffer4[1], buffer4[2], buffer4[3]); 
    fwrite(buffer4, sizeof(buffer4), 1, o_ptr);

    printf("Writing format chunk byte rate\n");
    convertIntToLittleEndian(wave.waveFormatChunk.byteRate);
    printf("%u %u %u %u\n", buffer4[0], buffer4[1], buffer4[2], buffer4[3]); 
    fwrite(buffer4, sizeof(buffer4), 1, o_ptr);

    printf("Writing format chunk block align\n");
    convertShortToLittleEndian(wave.waveFormatChunk.blockAlign);
    printf("%u %u\n", buffer2[0], buffer2[1]); 
    fwrite(buffer2, sizeof(buffer2), 1, o_ptr);

    printf("Writing format chunk bits per sample\n");
    convertShortToLittleEndian(wave.waveFormatChunk.bitsPerSample);
    printf("%u %u\n", buffer2[0], buffer2[1]); 
    fwrite(buffer2, sizeof(buffer2), 1, o_ptr);

    printf("Writing data chunk\n");

    printf("%s\n", wave.waveDataChunk.chunkId);
    fwrite(wave.waveDataChunk.chunkId, sizeof(wave.waveDataChunk.chunkId), 1, o_ptr);

    printf("Writing data chunk size\n");
    convertIntToLittleEndian(wave.waveDataChunk.chunkSize); 
    printf("%u %u %u %u\n", buffer4[0], buffer4[1], buffer4[2], buffer4[3]);
    fwrite(buffer4, sizeof(buffer4), 1, o_ptr);

    printf("\nWriting data...\n");
    printf("Num Samples: %lu\n", num_samples);

    int i;
    for(i = 0; i < num_samples; i++)
    {
        printf("%d\n", wave.waveDataChunk.sampleData[i]);
        convertShortToLittleEndian(wave.waveDataChunk.sampleData[i]);
        printf("Writing %hu\n", buffer2);
        fwrite(buffer2, size_of_each_sample, 1, o_ptr);
    }


    // fwrite(&wave.waveHeader, sizeof(wave.waveHeader), 1, o_ptr);
    // fwrite(&wave.waveFormatChunk, sizeof(wave.waveFormatChunk), 1, o_ptr);
    // fwrite(&wave.waveDataChunk, sizeof(wave.waveDataChunk), 1, o_ptr);
    // fwrite(wave.waveDataChunk.sampleData, sizeof(wave.waveDataChunk.sampleData), 1, o_ptr);
    fclose(o_ptr);
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
        chord = 0x7;
        step = ( sample_magnitude >> 8) & 0xF ;
        codeword_tmp = ( sign << 7) | ( chord << 4) | step ;
        return ( (char) codeword_tmp );
    }
    if( sample_magnitude & (1 << 11)) {
        chord = 0x6;
        step = ( sample_magnitude >> 7) & 0xF ;
        codeword_tmp = ( sign << 7) | ( chord << 4) | step ;
        return ( (char) codeword_tmp );
    }
    if( sample_magnitude & (1 << 10)) {
        chord = 0x5;
        step = ( sample_magnitude >> 6) & 0xF ;
        codeword_tmp = ( sign << 7) | ( chord << 4) | step ;
        return ( (char) codeword_tmp );
    }

    if( sample_magnitude & (1 << 9)) {
        chord = 0x4;
        step = ( sample_magnitude >> 5) & 0xF ;
        codeword_tmp = ( sign << 7) | ( chord << 4) | step ;
        return ( (char) codeword_tmp );
    }
    if( sample_magnitude & (1 << 8)) {
        chord = 0x3;
        step = ( sample_magnitude >> 4) & 0xF ;
        codeword_tmp = ( sign << 7) | ( chord << 4) | step ;
        return ( (char) codeword_tmp );
    }
    if( sample_magnitude & (1 << 7)) {
        chord = 0x2;
        step = ( sample_magnitude >> 3) & 0xF ;
        codeword_tmp = ( sign << 7) | ( chord << 4) | step ;
        return ( (char) codeword_tmp );
    }
    if( sample_magnitude & (1 << 6)) {
        chord = 0x1;
        step = ( sample_magnitude >> 2) & 0xF ;
        codeword_tmp = ( sign << 7) | ( chord << 4) | step ;
        return ( (char) codeword_tmp );
    }
    if( sample_magnitude & (1 << 5)) {
        chord = 0x0;
        step = ( sample_magnitude >> 1) & 0xF ;
        codeword_tmp = ( sign << 7) | ( chord << 4) | step ;
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

    printf("Compressing data...\n");
    
    int i;
    for ( i = 0; i < num_samples; i++) {
        // get sampple
        short sample = (wave.waveDataChunk.sampleData[i] >> 2);
        // get sign
        short sign = signum(sample);
        // get magnitude
        unsigned short magninute = magnitude(sample) + 33;
        // gen codeword
        char codeword = codeword_compression(magninute, sign);
        // flip codeword
        codeword = ~codeword;
        printf("Codeword: %hu\n", codeword);
        // save
        compressed_data.sampleData[i] = codeword;
    }
}

void decompressData () {
    // TODO add error checking

    printf("Decompressing data...\n");

    __uint8_t codeword;
    int i;
    for (i = 0; i < num_samples; i++) {
        //printf("%hu\n", compressed_data.sampleData[i]);
        codeword = ~(compressed_data.sampleData[i]);
        short sign = (codeword & 0x80) >> 7;
        //printf("%d\n", sign);
        unsigned short magnitude = (magnitude_decode(codeword) - 33);
        //printf("%d\n", magnitude);
        short sample = (short) (sign ? magnitude : -magnitude);
        printf("%d\n", sample << 2);
        wave.waveDataChunk.sampleData[i] = sample << 2;
    }
}