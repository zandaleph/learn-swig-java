#!/bin/sh

gcc -c -fPIC src/four-msg.c -o obj/four-msg.o
gcc -shared -Wl,-install_name,libfourmsg.so -o lib/libfourmsg.so obj/four-msg.o 