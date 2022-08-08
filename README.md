# Mu-Law Audio Compression
This program was written for partial fulfillment of the requirements for SENG 440 at University of Victoria.

## Target Machine
- Raspberry Pi 4 Model B
- Raspberry Pi OS (32-bit)

## Requirements
- gcc
- Arm Compiler Toolchain (arm-linux-gnueabihf)

## Usage
- Compile and run the program: `make <opt | unopt>`
- Compile to ASM: `make <opt | unopt>-gen-asm`
- Compile ASM: `make <opt | unopt>-asm`
- Profile with gprof: `make <opt | unopt>-prof`