#!/bin/bash

# To build directly from the source directory:
# cp -r $RECIPE_DIR/../../../qca __qca__
# cd __qca__

# Ensure we are not using MacPorts, but the native OS X compilers
export PATH=$PREFIX/bin:/bin:/sbin:/usr/bin:/usr/sbin

# This is really important. Conda build sets the deployment target to 10.5 and
# this seems to be the main reason why the build environment is different in
# conda compared to compiling on the command line. Linking against libc++ does
# not work for old deployment targets.
export MACOSX_DEPLOYMENT_TARGET="10.8"

# Set PYLIB to either .so (Linux) or .dylib (OS X)
PYLIB="PYTHON_LIBRARY_NOT_FOUND"
for i in $PREFIX/lib/libpython${PY_VER}{.so,.dylib}; do
    if [ -f $i ]; then
        PYLIB=$i
    fi
done

# Which compiler we use depends on the platform
if [ "$OSX_ARCH" == "" ]; then
    # Linux
    export CXX="g++";
else
    # OS X
    export CXX="clang++";
fi

# Compile the C++ Python extension module
mkdir __Release__
cd __Release__
cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_INSTALL_RPATH=$LD_RUN_PATH \
    -DBOOST_ROOT:PATH=$PREFIX \
    -DPYTHON_INCLUDE_PATH:PATH=$PREFIX/include/python${PY_VER} \
    -DPYTHON_LIBRARY:FILEPATH=$PYLIB \
    ..
make

# Run C++ unit test suite
make buildtest
make check

cd ..

# Install the Python module
$PYTHON setup.py install

exit 0
