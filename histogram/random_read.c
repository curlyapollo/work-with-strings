#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

char* random_read() {
    srand(1);
    int n = rand() % 1500;
    char* text = malloc(n * sizeof(text));
    for (int i = 0; i < n; ++i) {
        text[i] = (char) (rand() % 128);
        printf("%c", text[i]);
    }
    return text;
}