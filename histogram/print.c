#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

extern char* words[];
extern int cnt[];

void print(FILE* output) {
    for (int i = 0; i < 5; ++i) {
        fprintf(output, "%s %d\n", words[i], cnt[i]);
    }
}
