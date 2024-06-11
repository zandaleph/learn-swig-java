#include <stdio.h>

void get_three_message(char* buffer, int buf_size) {
    snprintf(buffer, buf_size, "Hello, static library");
}