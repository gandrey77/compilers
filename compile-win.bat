@echo off
cd anasint/
win_bison parser.y
cd ../analex/
win_flex scanner.l
cd ..
gcc -o compiler analex/lex.yy.c anasint/parser.tab.c

set /p opt="<1> Aritmetica ou <2> Comparacao":
if "!opt!"=="1" (
  compiler.exe < tests/aritmetica.txt
) else (
  compiler.exe < tests/comparacao.txt
)