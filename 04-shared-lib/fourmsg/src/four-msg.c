#include <stdio.h>

void get_four_message(char* buffer, int buf_size) {
    snprintf(buffer, buf_size, "Hello, dynammic library");
}