#!/bin/bash

# Create a build directory
mkdir build
cd build

# Run CMake
cmake ..

# Build all subfolders
make -j8

# Install all subfolders
make install
