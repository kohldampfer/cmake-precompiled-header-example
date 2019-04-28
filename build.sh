#!/bin/bash

set -e

rm -vf CMakeCache.txt Makefile example1
rm -vf *.cmake *.gch *.o
rm -rvf CMakeFiles

cmake -G "Unix Makefiles" .
VERBOSE=1 make

