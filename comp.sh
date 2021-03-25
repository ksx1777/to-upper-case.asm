nasm -f elf32 main.asm
ld -s -o main main.o -m elf_i386
