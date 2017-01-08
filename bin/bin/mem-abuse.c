#include <stdlib.h>
#include <stdio.h>
#include <errno.h>

#define KiB (1<<10)
#define MiB (1<<20)

int main(int argc, char *argv[]) {
    long size = 256*MiB;
    if (argc>1) {
        errno = 0;
        size = strtol(argv[1], NULL, 0);
        if (errno != 0) {
            perror("converting argument to number");
            exit(EXIT_FAILURE);
        }
    }
    printf("allocating %ld bytes\n", size);
    errno = 0;
    char *p = malloc(size);
    if (errno != 0) {
        perror("allocating memory");
        exit(EXIT_FAILURE);
    }
    for (long i=0; i<size; i+=KiB) {
        *(p+i)=1;
    }
    free(p);
    exit(EXIT_SUCCESS);
}
