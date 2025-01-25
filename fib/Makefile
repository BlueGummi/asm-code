ASM=nasm
CC=gcc
ASMFLAGS=-f elf32 
CCFLAGS=-m32 -no-pie -z noexecstack 
SRC=fib.asm
OBJ=fib.o
OUTPUT=fib
MAKEFLAGS += --quiet

ARCH=$(shell uname -m)
ifeq ($(ARCH), x86_64)
    all: $(OUTPUT)

    $(OBJ): $(SRC)
	rm -f $(OUTPUT) && $(ASM) $(ASMFLAGS) $(SRC) -o $(OBJ)

    $(OUTPUT): $(OBJ)
	$(CC) -o $(OUTPUT) $(OBJ) $(CCFLAGS) && rm -f $(OBJ)
	@echo "Run ./fib"
    clean:
	rm -f $(OBJ) $(OUTPUT)
else
    all:
	@echo "Error: This program is intended for x64 architecture only."
	@exit 1
endif

.PHONY: all clean
