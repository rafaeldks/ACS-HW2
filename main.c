#include <stdio.h>
#include <string.h>

void revstr(char str[]) {
    int i, len = strlen(str), temp;
    for (i = 0; i < len / 2; i++) {
        temp = str[i];
        str[i] = str[len - i - 1];
        str[len - i - 1] = temp;
    }
}

void printChangedString(char text[]) {
    char word[50] = "";
    for (int i = 0; i < strlen(text); ++i) {
        if ((text[i] < 65) | (text[i] > 90 & text[i] < 97) | (text[i] > 122)) {
            revstr(word);
            printf(word);
            printf("%c", text[i]);
            word[0] = 0;
        } else {
            strncat(word, &text[i], 1);
        }
    }
    revstr(word);
    printf(word);
}

int main() {
    char text[100];
    gets(text);
    printChangedString(text);
    return 0;
}