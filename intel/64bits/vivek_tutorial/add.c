#include <stdio.h>
#include <stdlib.h>

int add(int x, int y){
    int z = 10;
    z = x + y;
    return z;
}

int main(int argc, char **argv){
    int a = atoi(argv[1]);
    int b = atoi(argv[2]);
    int c;
    char buffer[100];

    gets(buffer);
    puts(buffer);
    c = add(a,b);
    printf("The sum of %d + %d is %d",a,b,c);
    exit(0);
}
