#include <stdio.h>

#include "three-msg.h"

int main(int argc, char* argv[]) {
    const int BUF_SIZE = 64;
    char buffer[BUF_SIZE];
    get_three_message(buffer, BUF_SIZE);
    printf("%.*s\n", BUF_SIZE, buffer);
    return 0;
}