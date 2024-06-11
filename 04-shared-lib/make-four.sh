#!/bin/sh

gcc -I ./fourmsg/include -L ./fourmsg/lib -l fourmsg four.c 

# export DYLD_LIBRARY_PATH=`pwd`/fourmsg/lib