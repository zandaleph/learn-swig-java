#!/bin/sh

gcc -c src/three-msg.c -o obj/three-msg.o
ar rcs lib/libthreemsg.a obj/three-msg.o