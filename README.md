# ABSTRACT
This repo contains some of the fun stuff that assembly has to offer. I basically use this repo to learn assembly and build some tools for fun.

## Assembler?
I have used `FASM` here, which is known for its minimal executable output, i really like it. It just does what you want no more no less, compared to others. I don't hate others but I love fasm more and I just know like the 1% of it and still its cool. I would love it to give it more time and make more things with it.

> You can download fasm from https://flatassembler.net/docs.php?article=manual and assemble above source files pretty easily. This won't work on windows though beacuse I have used linux system calls.

## Some Nice things.
1. The coolest thing has to be `neocat.asm`. This is my attempt in making the `cat` command found in most linux distros. Works the same way but is only `4.5KB` in size compared to the original `cat` which is more than a 100 KB. 
2. `linking_with_libc` explores how one can link assembly written in `FASM` to an external library (shared in this case)
3. `simple_serve` provides you with a simple webserver that serves 'Hello' at localhost:8080, its just a proof of concept, not super useful at anything
4. `_touch` contains some implementation of GNU libtool `touch` but this is the bare minimum version of this. but if you assemble it, its exactly 530 bytes compared to the whopping 80KB you will find in your usr/bin/touch

