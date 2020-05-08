P = copy
PLib = copy_lib
CC = gcc
CFLAGS = -g -Wall -O3
LDLIBS =
LDFLAGS =
AS = yasm
ASFLAGS = -f elf64 -g dwarf2

$(P): $(P).o
	ld -o $@ $@.o
## The next part is commented as i am now using the built-in recipes 
## to compile copy.o
# $(P).o: $(P).s
	# yasm -f elf64 -g dwarf2 $*.asm

## Will rely on built-ind recipes to get $(PLib).o
$(PLib): $(PLib).o
	$(CC) -o $@ $@.o  ## Do i need 

git:
	git add -u
	git commit -m "$m"
	git push --set-upstream formal master

.asm:

%:	%.asm
	$(AS) $(ASFLAGS) $^
