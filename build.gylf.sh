#!/bin/bash

nasm -f elf -o ./gylf.o ./code/gylf.asm
ld -o gylf ./gylf.o
rm ./gylf.o
