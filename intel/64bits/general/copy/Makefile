P = copy
CC = gcc
CFLAGS = -g -Wall -O3

$(P): $(P).o
	ld -o $@ $@.o
$(P).o: $(P).asm
	yasm -f elf64 -g dwarf2 $*.asm

git:
	git add -u
	git commit -m "$m"
	git push --set-upstream formal master
