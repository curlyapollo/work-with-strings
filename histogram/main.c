#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <time.h>

const char *words[] = {"if", "else", "for", "int", "void"};
int cnt[] = {0, 0, 0, 0, 0};

extern char* read_text(FILE* input);
extern void analysis(const char* text);
extern void print(FILE* output);
extern char* random_read();
extern int64_t time_dif(struct timespec timeA, struct timespec timeB);

int main(int argc, char** argv)
{
    FILE *input, *output;
    struct timespec start;
    struct timespec end;
    int64_t elapsed_ns;
    input = fopen(argv[1], "r");
    output = fopen(argv[2], "w");
    char *text;
    if (argc == 4) {
        text = random_read();
    }
    else {
        text = read_text(input);
    }
    clock_gettime(CLOCK_MONOTONIC, &start);
    analysis(text);
    clock_gettime(CLOCK_MONOTONIC, &end);
    elapsed_ns = time_dif(end, start);
    print(output);
    printf("Elapsed: %ld ns\n", elapsed_ns);
    free(text);
    return 0;
}
