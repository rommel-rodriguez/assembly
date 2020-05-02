P = copy
PLib = copy_lib
CC = gcc
CFLAGS = -g -Wall -O3
LDLIBS =
LDFLAGS =

$(P): $(P).o
	ld -o $@ $@.o
$(P).o: $(P).asm
	yasm -f elf64 -g dwarf2 $*.asm

$(PLib): $(PLib).o
	$(CC) -o $@ $@.o  ## Do i need 
$(PLib).o: $(PLib).asm
	yasm -f elf64 -g dwarf2 $*.asm

git:
	git add -u
	git commit -m "$m"
	git push --set-upstream formal master
