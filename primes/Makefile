ASM=nasm
GCC=gcc
OBJ=primes.o
EXEC=primes
ASMFLAGS=-f elf32
GCCFLAGS=-m32 -no-pie

all: $(EXEC)

$(EXEC): $(OBJ)
	$(GCC) $(GCCFLAGS) -o $@ $^
	rm $(OBJ)

$(OBJ): primes.asm
	$(ASM) $(ASMFLAGS) $< -o $@

clean:
	rm -f $(EXEC) $(OBJ)

.PHONY: all clean
