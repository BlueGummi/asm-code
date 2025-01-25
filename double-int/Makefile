ASM=nasm
LD=ld
ASMFLAGS=-f elf64
LDFLAGS=-o
SRC=main.asm
OBJ=main.o
OUTPUT=main
MAKEFLAGS += --quiet

ARCH=$(shell uname -m)
ifeq ($(ARCH), x86_64)
    all: $(OUTPUT)

    $(OBJ): $(SRC)
	rm -f $(OUTPUT) && $(ASM) $(ASMFLAGS) $(SRC) -o $(OBJ)

    $(OUTPUT): $(OBJ)
	$(LD) $(LDFLAGS) $(OUTPUT) $(OBJ) && rm -f $(OBJ)
	@echo "Run ./main"

    clean:
	rm -f $(OBJ) $(OUTPUT)
else
    all:
	@echo "Error: This program is intended for x64 architecture only."
	@exit 1
endif

.PHONY: all clean
