# Learning to SWIG (and some basic C along the way)

## Step 1: Let's create a C program

The simple hello world program in [hello.c] can be compiled using
`./make-hello.sh` to invoke the [make-hello.sh] shell script. This will
create a `a.out` file which can be invoked via `./a.out` to print the
familiar "Hello World!" output.

[hello.c](01-hello-world/hello.c)
[make-hello.sh](01-hello-world/make-hello.sh)

## Step 2: Let's create a two-file C program

This time we've got two source files ([two.c] and [two-lib.c]), a
header file to define the library interface [two-lib.h], and a new
build script [make-two.sh].  The header file is the interesting part
here - as we make libraries we'll need a way to share what methods (and
constants?) are available from the compiled code.

Build instructions:
- `./make-two.sh`
  - This creates `a.out`
- `./a.out`
  - This prints `Hello, multiple files`

## Step 3: Statically linked libraries

A library is a compiled chunk of code which can be included into a
larger project without having to be recompiled.  Libraries can also
be used in multiple projects without needing alteration, thus being
the foundation of code reuse.

For this example, we need instructions for two separate actions:
First, compiling and linking the library so that it can be used later.
Second, building an application which uses the library.

Library build instructions:
- Go to `threemsg` folder
- `./make-libthreemsg.sh`
  - This creates `libthreemsg.a` in the `lib` directory there.
  - Note the use of `ar` in the build script. This is similar to `tar`
    but nowadays is almost exclusively used for compiled libraries.

Binary build instructions
- Go to step folder
- `./make-three.sh`
  - This creates `a.out`
  - Notice that we have to tell it about both include folders `-I` and
    library folders `-L`, and that the `-l threemsg` doesn't include
    the `lib` prefix or `.a` suffix of the generated library file.
- `./a.out`
  - This prints `Hello, static library`

## Step 4: Dynamically linked libraries

A library can be linked statically, where it is copy-pasted into the
larger binary which is using it.  This is convenient for many reasons,
but can lead to very very large binaries, which have their own set of
problems.

Libraries can also be linked dynamically, where it is not compiled into
the binary. Instead, the library is loaded separately and code excection
can jump between the binary and the library.  This saves binary space
and memory, as multiple processes can share the same dynamically loaded
library.

For security reasons, binaries can't just request to load any old
dynamic library - they have to be in specific locations (generally ones
that require root access to modify).  On unix systems, this is
`LD_LIBRARY_PATH`, and on OS X, it is `DYLD_LIBRARY_PATH`.

Library build instructions:
- Go to `fourmsg` folder
- `./make-libfourmsg.sh`
  - This creates `libfourmsg.so` in the `lib` subfolder.
  - Notice `-fPIC` in the compiler flags.  This creates "Position
    Independent Code", which is required for dynamic libraries.
  - Also notice `-Wl,-install_name,libfourmsg.so`.  The [`-Wl` flag]
    has nothing to do with warnings, confusingly, and instead specifies
    arguments to pass to the linker.
  - The linker options are for telling the library what its name is,
    which is important for versioned libraries with the same API.  For
    linux, [this is `-soname`], but [on OS X it is `-install_name`]

[`-Wl` flag](https://gcc.gnu.org/onlinedocs/gcc/Link-Options.html#index-Wl)
[this is `-soname`](https://tldp.org/HOWTO/Program-Library-HOWTO/shared-libraries.html#AEN95)
[on OS X it is `-install_name`](https://stackoverflow.com/questions/4580789/ld-unknown-option-soname-on-os-x)

Binary build Instructions:
- Go to step folder
- `./make-four.sh`
  - Notice that we still need to specify the library at build time.
  - TODO triple check this doesn't create any static linking
- ``export DYLD_LIBRARY_PATH=`pwd`/fourmsg/lib``
- `./a.out`
  - This prints `Hello, dynammic library`
  - If you see the following error message, the `export` didn't work
  - `dyld[10005]: Library not loaded: libfourmsg.so`
  - Check your `DYLD_LIBRARY_PATH` is set correctly (or 
    `LD_LIBRARY_PATH` on linux)

## Step 5: Simple Swig

This step is a fair bit more complicated than the last, in part because
we need to bring in the Java AND Swig machinery to begin.

There's lots of ways to install a Java JDK.  I think I installed
IntelliJ IDEA and then used that to install a v21 JDK.  You just need
to ensure `javac` and `java` are on your path.

For swig, `brew install swig` works just fine.  Homebrew for life.

Build instructions:
- `./make-swig-example.sh`
  - First line sets `JHOME`, you might need to tweak this path.
  - `swig` command converts `hello-swig.i` into a bunch of files.
  - Then two compilation invocations of `gcc` for the sources.
    - `hello-swig.c` is our implementation
    - `hello-swig_wrap.c` is the `swig`-generated JNI interface
  - Then a final `gcc` to invoke the linker.
  - And because Java on OS X is weird, we have to create a file ending
    in `.jnilib` to be findable by `System.loadLibrary`
- Then run ``java -Djava.library.path=`pwd`/lib HelloSwigMain``
  - Output is `Hello from swig, JNI User`

If I ever come back to this, I might add some flags to make the output
files appear in subfolders to be a bit less messy.