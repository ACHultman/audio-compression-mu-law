struct WAVE_HEADER {
    unsigned char   riff[4];
    __uint32_t      fileSize;
    unsigned char   wave[4];
};

struct WAVE_FORMAT_CHUNK {
    unsigned char   chunkType[4];   // fmt    
    __uint32_t      chunkSize;      // chunk size
    __uint8_t       audioFormat;    // audioFormat = 1 
    __uint16_t      numChannels;    // wChannels = 1 
    __uint32_t      sampleRate;     // dwSamplesPerSec = /* varies */ 
    __uint32_t      byteRate;       // sampleRate * blockAlign 
    __uint16_t      blockAlign;     // wChannels * (bitsPerSample / 8) 
    __uint16_t      bitsPerSample;
};

struct WAVE_DATA_CHUNK {
    unsigned char   chunkId[4];
    __uint32_t      chunkSize;
    short           *sampleData;        // sampleData = dwSamplesPerSec * wChannels 
};

struct WAVE {
    struct WAVE_HEADER          waveHeader;
    struct WAVE_FORMAT_CHUNK    waveFormatChunk;
    struct WAVE_DATA_CHUNK      waveDataChunk;
};

struct WAVE_DATA_CHUNK_COMPRESSED {
    unsigned char   chunkId[4];
    __uint32_t      chunkSize;
    __uint8_t       *sampleData;        // samplesPerSec * wChannels 
};

struct WAVE_COMPRESSED {
    struct WAVE_HEADER                  waveHeader;
    struct WAVE_FORMAT_CHUNK            waveFormatChunk;
    struct WAVE_DATA_CHUNK_COMPRESSED   waveDataChunkCompressed;
};