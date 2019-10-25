#!/bin/bash

cd anasint/
bison -dy parser.y
cd ..
cd analex/
lex scanner.l
gcc -o compiler lex.yy.c ../anasint/y.tab.c -ll

clear >$(tty)

if [ $1 == 1 ];
then
    ./compiler < ../tests/programa.txt;     

elif [ $1 == 2 ];
then
   ./compiler < ../tests/erro_lex.txt;

elif [ $1 == 3 ];
then
   ./compiler < ../tests/erro_sint.txt;

fi
