all:
	nasm -f elf32 primes.asm -o primes.o && ld -m elf_i386 -o primes primes.o -lc -dynamic-linker /lib/ld-linux.so.2 && rm primes.o
clean:
	rm -rf primes && rm -rf primes.o
