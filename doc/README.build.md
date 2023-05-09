# Building

The codec is supported on Linux, OSX and Windows platforms.  The build
configuration is managed using CMake.

> It is strongly advised to build the software in a separate build directory.

## Build scripts

Bash scripts can be use to build mpeg-pcc-dmetric project: build.sh to build solutions and
clear.sh to clean.

## Build manually

Standard CMake build commands can be used to build the software depending on the system you used.

### Linux

```console
   cmake ./source -B build/Release
   cmake --build build/Release --config Release
```

### OSX

```console
   cmake ./source -B build/Release
   cmake --build build/Release --config Release
```

As an alternative, the generated XCode project may be opened and built from
XCode itself.

### Windows

```console
   cmake ./source -B build/Release
   cmake --build build/Release --config Release
```

Open the generated visual studio solution to build it.
