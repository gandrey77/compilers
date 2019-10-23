%{
#include <stdio.h>
#include <string.h>

#ifdef WIN32
    #include "../anasint/parser.tab.h"
#else
    #include "../anasint/y.tab.h"
#endif
%}

/* Expressões regulares para as cadeias lidas. */
general ([a-zA-Z])([a-zA-Z]|[0-9\_])*

string "'".*"'"
                                                                    
number [0-9]+([\.][0-9]+)?

tabulacao [ \t\n]+

comparacao >=|<=|==|!=|<|>

aritmetica [+|-|/|*|(|)|=]

caracter_especial ['|{|}|;|,]

logica ["AND"|"OR"|and|or]

comentario "#".*"#"

error_general  (~|"?"|@|([0-1]+))([a-zA-Z])*

error . 

%%

{general} { return ID; }

{string} { return STRING; }

{number} { return NUMBER; }

{aritmetica} { return OPERATOR; }

{comparacao}            { printf("Token: %s\n",yytext); }
{caracter_especial}     { printf("Token: %s\n",yytext); }
{logica}                { printf("Token: %s\n",yytext); }
{comentario}            { printf("Token: %s\n",yytext); }
{error_general}              { printf("A cadeia %s nao faz parte da linguagem\n",yytext); }
{error}            { printf("A cadeia %s nao faz parte da linguagem\n",yytext); }
{tabulacao} ;

%%

int yywrap() {
    return 1;
}
