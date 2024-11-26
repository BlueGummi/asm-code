ASM=nasm
CC=gcc
ASMFLAGS=-f elf32 -g
CCFLAGS=-m32 -no-pie
SRC=main.asm
OBJ=main.o
OUTPUT=main

# check if we are x64 architecture
ARCH=$(shell uname -m)
ifeq ($(ARCH), x86_64)
    # architecture is correct, proceed with the build
    all: $(OUTPUT)

    $(OBJ): $(SRC)
	rm -f $(OUTPUT) && $(ASM) $(ASMFLAGS) $(SRC) -o $(OBJ)

    $(OUTPUT): $(OBJ)
	$(CC) -o $(OUTPUT) $(OBJ) $(CCFLAGS) && rm -f $(OBJ)

    clean:
	rm -f $(OBJ) $(OUTPUT)
else
    # architecture is not x64, terminate
    all:
	@echo "Error: This program is intended for x64 architecture only."
	@exit 1
endif

.PHONY: all clean
