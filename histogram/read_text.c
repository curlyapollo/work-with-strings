#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

char* read_text(FILE* input)
{
    int size = 0, capacity = 1;
    char *text = malloc(capacity * sizeof(*text));
    char current;
    while ((current = fgetc(input)) != EOF) {
        if (size + 1 > capacity) {
            capacity *= 2;
            text = realloc(text, capacity * sizeof(*text));
        }
        text[size] = current;
        ++size;
    }
    if (size + 1 > capacity) {
        capacity *= 2;
        text = realloc(text, capacity * sizeof(*text));
    }
    text[size] = 0;
    return text;
}