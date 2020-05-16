#!/bin/bash

# make emscripten related vars active
source /root/emsdk/emsdk_env.sh

OUT_DIR="/root/html/hello/"
I_DIR="/root/libsodium/libsodium-js/include"

mkdir -p ${OUT_DIR}
#emcc main.c -o ${OUT_DIR}index.html

emcc -I${I_DIR} -Os --llvm-lto 1  main.c "/root/libsodium/libsodium-js/lib/libsodium.a" -o ${OUT_DIR}index.html  -O3 -s WASM=1
