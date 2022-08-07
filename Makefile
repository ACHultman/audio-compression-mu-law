# ================================================================
# Unoptimized
# ================================================================

unopt:
	gcc -o ./unoptimized/main.exe ./unoptimized/main.c ./unoptimized/io.c ./unoptimized/mulaw.c
	./unoptimized/main.exe ./unoptimized/test.wav ./unoptimized/decompressed.wav

unopt-gen-asm:
	gcc -S ./unoptimized/main.c ./unoptimized/io.c ./unoptimized/mulaw.c
	mv main.s unoptimized/main.s
	mv io.s unoptimized/io.s
	mv mulaw.s unoptimized/mulaw.s

unopt-asm:
	gcc -o ./unoptimized/main.exe ./unoptimized/main.s ./unoptimized/io.s ./unoptimized/mulaw.s
	./unoptimized/main.exe ./unoptimized/test.wav ./unoptimized/decompressed.wav

unopt-prof:
	gcc -pg ./unoptimized/main.c ./unoptimized/io.c ./unoptimized/mulaw.c -o ./unoptimized/main.exe
	for number in ``seq 1 1000``; do ./unoptimized/main.exe ./unoptimized/test.wav ./unoptimized/decompressed.wav; done
	gprof ./unoptimized/main.exe gmon.out > unoptimized/gprof.log



# ================================================================
# Optimized
# ================================================================

opt:
	gcc -O3 -o ./optimized/main.exe ./optimized/main.c ./optimized/io.c ./optimized/mulaw.c
	./optimized/main.exe ./optimized/test.wav ./optimized/decompressed.wav

opt-gen-asm:
	gcc -O3 -lto -S ./optimized/main.c ./optimized/io.c ./optimized/mulaw.c
	mv main.s optimized/main.s
	mv io.s optimized/io.s
	mv mulaw.s optimized/mulaw.s

opt-asm:
	gcc -O3 -o ./optimized/main.exe ./optimized/main.s ./optimized/io.s ./optimized/mulaw.s
	./optimized/main.exe ./optimized/test.wav ./optimized/decompressed.wav

opt-prof:
	gcc -pg ./optimized/main.c ./optimized/io.c ./optimized/mulaw.c -o ./optimized/main.exe
	for number in ``seq 1 1000``; do ./optimized/main.exe ./optimized/test.wav ./optimized/decompressed.wav; done
	gprof ./optimized/main.exe gmon.out > optimized/gprof.log




# ================================================================

hwr-gen-asm:
	gcc -S ./hardware/main.c ./hardware/io.c ./hardware/mulaw.c
	mv main.s hardware/main.s
	mv io.s hardware/io.s
	mv mulaw.s hardware/mulaw.s

clean-prof:
	rm gmon.out