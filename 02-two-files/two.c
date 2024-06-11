#include <stdio.h>

#include "two-lib.h"

int main(int argc, char* argv[]) {
    const int BUF_SIZE = 64;
    char buffer[BUF_SIZE];
    get_message(buffer, BUF_SIZE);
    printf("%.*s\n", BUF_SIZE, buffer);
    return 0;
}