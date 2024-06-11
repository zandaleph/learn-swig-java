#include <stdlib.h>
#include <stdio.h>

char* greet_swig(char* name, size_t name_len) {
    const size_t GREETING_LEN = 18;
    size_t result_len = GREETING_LEN + name_len;
    char* result = malloc(name_len + GREETING_LEN);
    snprintf(result, result_len, "Hello from swig, %.*s", name_len, name);
    return result;
}
