#!/bin/sh

JHOME=`/usr/libexec/java_home`
# swig -java -package com.example hello-swig.i
swig -java hello-swig.i
gcc -c -fPIC -I "$JHOME/include" -I "$JHOME/include/darwin" hello-swig_wrap.c
gcc -c -fPIC hello-swig.c
gcc -shared -Wl,-install_name,libhello_swig.so hello-swig_wrap.o hello-swig.o -o lib/libhello_swig.so
ln -s lib/libhello_swig.so lib/libhello_swig.jnilib
javac hello_swig.java hwllo_swigJNI.java HelloSwigMain.java