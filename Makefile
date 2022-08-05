unopt:
	arm-linux-gcc -o main.exe ./unoptimized/main.c ./unoptimized/io.c ./unoptimized/mulaw.c
	lftp -c "open user4:q6coHjd7P@arm; mkdir adamh; put -c -O adamh main.exe; put -c -O adamh test.wav; chmod +x adamh/main.exe;"
	(sleep 1; echo user4; sleep 1; echo q6coHjd7P; sleep 1; echo ./adamh/main.exe adamh/test.wav adamh/decompressed.wav; sleep 30;) | telnet arm

unopt-asm:
	arm-linux-gcc -S ./unoptimized/main.c ./unoptimized/io.c ./unoptimized/mulaw.c

opt:
	arm-linux-gcc -o main.exe ./optimized/main.c ./optimized/io.c ./optimized/mulaw.c
	lftp -c "open user4:q6coHjd7P@arm; mkdir adamh; put -c -O adamh main.exe; put -c -O adamh test.wav; chmod +x adamh/main.exe;"
	(sleep 1; echo user4; sleep 1; echo q6coHjd7P; sleep 1; echo ./adamh/main.exe adamh/test.wav adamh/decompressed.wav; sleep 30;) | telnet arm

opt-asm:
	arm-linux-gcc -S ./optimized/main.c ./optimized/io.c ./optimized/mulaw.c

clean:
	(sleep 1; echo user4; sleep 1; echo q6coHjd7P; sleep 1; echo rm -rf adamh; sleep 1;) | telnet arm