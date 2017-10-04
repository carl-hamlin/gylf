#!/bin/bash

nasm -f elf -o ./gylf.o ./i
ld -s -m elf_i386 -o gylf ./gylf.o
rm ./gylf.o
mv ~/gylf/gylf ~/gylf.test.directory/gylf
