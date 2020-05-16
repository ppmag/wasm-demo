#!/bin/bash

# make emscripten related vars active
source /root/emsdk/emsdk_env.sh

OUT_DIR="/root/html/hello/"

mkdir -p ${OUT_DIR}
emcc main.c -o ${OUT_DIR}index.html