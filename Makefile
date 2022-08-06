unopt:
	gcc -o ./unoptimized/main.exe ./unoptimized/main.c ./unoptimized/io.c ./unoptimized/mulaw.c
	./unoptimized/main.exe ./unoptimized/test.wav ./unoptimized/decompressed.wav

unopt-perf:
	gcc -pg ./unoptimized/main.c ./unoptimized/io.c ./unoptimized/mulaw.c -o ./unoptimized/main.exe
	./unoptimized/main.exe ./unoptimized/test.wav ./unoptimized/decompressed.wav

unopt-asm:
	gcc -S ./unoptimized/main.c ./unoptimized/io.c ./unoptimized/mulaw.c

opt:
	gcc -O3 -o ./optimized/main.exe ./optimized/main.c ./optimized/io.c ./optimized/mulaw.c
	./optimized/main.exe ./optimized/test.wav ./optimized/decompressed.wav

opt-perf:
	gcc -pg ./optimized/main.c ./optimized/io.c ./optimized/mulaw.c -o ./optimized/main.exe
	./optimized/main.exe ./optimized/test.wav ./optimized/decompressed.wav

opt-asm:
	gcc -O3 -S ./optimized/main.c ./optimized/io.c ./optimized/mulaw.c