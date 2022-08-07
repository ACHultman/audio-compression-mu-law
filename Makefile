unopt:
	gcc -o ./unoptimized/main.exe ./unoptimized/main.c ./unoptimized/io.c ./unoptimized/mulaw.c
	./unoptimized/main.exe ./unoptimized/test.wav ./unoptimized/decompressed.wav

unopt-prof:
	gcc -pg ./unoptimized/main.c ./unoptimized/io.c ./unoptimized/mulaw.c -o ./unoptimized/main.exe
	for number in ``seq 1 1000``; do ./unoptimized/main.exe ./unoptimized/test.wav ./unoptimized/decompressed.wav; done
	gprof ./unoptimized/main.exe gmon.out > unoptimized/gprof.log

unopt-asm:
	gcc -S ./unoptimized/main.c ./unoptimized/io.c ./unoptimized/mulaw.c

opt:
	gcc -O3 -o ./optimized/main.exe ./optimized/main.c ./optimized/io.c ./optimized/mulaw.c
	./optimized/main.exe ./optimized/test.wav ./optimized/decompressed.wav

opt-prof:
	gcc -pg ./optimized/main.c ./optimized/io.c ./optimized/mulaw.c -o ./optimized/main.exe
	for number in ``seq 1 1000``; do ./optimized/main.exe ./optimized/test.wav ./optimized/decompressed.wav; done
	gprof ./optimized/main.exe gmon.out > optimized/gprof.log

opt-asm:
	gcc -O3 -S ./optimized/main.c ./optimized/io.c ./optimized/mulaw.c

clean-prof:
	rm gmon.out