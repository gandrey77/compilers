@echo off
cd anasint/
win_bison parser.y
cd ../analex/
win_flex scanner.l
cd ..
gcc -o compiler analex/lex.yy.c anasint/parser.tab.c