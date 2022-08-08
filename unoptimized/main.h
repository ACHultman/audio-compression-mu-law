// typedefs
typedef struct RIFF {
	unsigned char riff[4];		// "RIFF"
	uint32_t chunk_size;		// Total size of file
	unsigned char format[4];	// "WAVE"
} RIFF;

typedef struct FMT {
	unsigned char id[4];		// "fmt\0"
	uint32_t size;				// size of format chunk
	uint16_t audio_format;		// Format = 1 (PCM)
	uint16_t num_channels;		// Number of channels, 1 = Mono, 2 = Stereo
	uint32_t sample_rate;		// Sample rate (Hz)
	uint32_t byte_rate;			// (Sample Rate * BitsPerSample * Channels) / 8
	uint16_t block_align;		// (BitsPerSample * Channels) / 8 [1 = 8 bit mono, 2 = 8 bit stereo/16 bit mono, 4 = 16 bit stereo]
	uint16_t bits_per_sample;	// Bits per sample = 16
	unsigned char data_id[4];	// "data"
	uint32_t data_size;			// Length of the data
} FMT;

typedef struct WAVE {
	RIFF 		riff;
	FMT 		fmt;
	int16_t* 	samples;
} WAVE;

typedef struct COMPRESSED_WAVE {
	RIFF 		riff;
	FMT 		fmt;
	uint8_t* 	samples;
} COMPRESSED_WAVE;

// mulaw.c
uint8_t signum(int16_t sample);
uint16_t magnitude(int16_t sample);
uint8_t find_codeword(uint8_t sign, uint16_t mag);
uint8_t compressed_signum(uint8_t codeword);
uint16_t compressed_magnitude(uint8_t codeword);
void compress();
void decompress();

// io.c
uint16_t convert_short_to_big_endian(unsigned char* little_endian);
void convert_short_to_little_endian(uint16_t big_endian);
uint32_t convert_int_to_big_endian(unsigned char* little_endian);
void convert_int_to_little_endian(uint32_t big_endian);
void read_wav();
void write_wav();

// globals
extern FILE* ifp; // input file pointer
extern FILE* ofp; // output file pointer
extern uint32_t num_samples; // number of samples in the file
extern uint16_t bytes_per_sample; // number of bytes per sample
extern WAVE wave; // Wave structure - read from file
extern COMPRESSED_WAVE compressed_wave; // Compressed wave structure - MuLaw compressed