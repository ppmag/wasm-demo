# wasm-demo
Collection of assorted WebAssembly test &amp; experiments

## Demo list

1. hello - Libsodium integration and hash test

----

## Install

## Linux
 
1. Install Docker and docker-compose
2. Clone repository and cd in it
3. Build & launch 
```shell
docker-compose build
docker-compose up
```

## Usage

Open in browser [http://127.0.0.1](http:/127.0.0.1) and navigate to required demo.
Please note, you can update source code in `./src`, and it will be recompiled on the fly inside the container.

**What is required to see updates is to refresh your browser page!**

Demo html page source with JS and Wasm files also are available in `./html` (updated dynamically!)
