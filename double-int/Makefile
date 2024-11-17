ASM=nasm
LD=ld
ASMFLAGS=-f elf64
LDFLAGS=-o
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
	$(LD) $(LDFLAGS) $(OUTPUT) $(OBJ) && rm -f $(OBJ)

    clean:
	rm -f $(OBJ) $(OUTPUT)
else
    # architecture is not x64, terminate
    all:
	@echo "Error: This program is intended for x64 architecture only."
	@exit 1
endif

.PHONY: all clean
