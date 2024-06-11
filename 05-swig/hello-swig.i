%module hello_swig

%{
#include "hello-swig.h"
%}

%newobject greet_swig;
%apply (char *STRING, size_t LENGTH) { (char *name, size_t name_len) };
%inline %{
extern char* greet_swig(char* name, size_t name_len);
%}
