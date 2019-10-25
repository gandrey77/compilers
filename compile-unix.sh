#!/bin/bash

cd anasint/
bison -dy parser.y
cd ..
cd analex/
lex scanner.l
gcc -o compiler lex.yy.c ../anasint/y.tab.c -ll

if [ $1 == 1 ];
then
    ./compiler < ../tests/aritmetica.txt;     

elif [ $1 == 2 ];
then
   ./compiler < ../tests/comparacao.txt;
fi
