#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>


extern const char *words[];
extern int cnt[];

void analysis(const char* text) {
    int l = 0, r = 0;
    while (text[l] != 0) {
        while (text[l] != 0 && !isalpha(text[l])) {
            ++l;
        }
        r = l;
        while (text[r] != 0 && isalpha(text[r])) {
            ++r;
        }
        if (r - l > 0) {
            for (int i = 0; i < 5; ++i) {
                if (r - l  == strlen(words[i])) {
                    int is_same = 1;
                    for (int j = l; j < r; ++j) {
                        if (text[j] != words[i][j - l]) {
                            is_same = 0;
                        }
                    }
                    if (is_same) {
                        ++cnt[i];
                    }
                }
            }
        }
        l = r;
    }
}