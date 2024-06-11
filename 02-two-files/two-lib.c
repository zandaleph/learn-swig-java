#include <stdio.h>

void get_message(char* buffer, int buf_size) {
    snprintf(buffer, buf_size, "Hello, multiple files");
}