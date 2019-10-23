%{
#include <stdio.h>
#include <string.h>
#include "../anasint/y.tab.h"

void yyerror(char *error);
%}

var ([a-zA-Z])([a-zA-Z]|[0-9\_])*

string "'".*"'"
                                                                    
numero [0-9]+([\.][0-9]+)?

tabulacao (" "|"\n"|"\t")+ 

comparacao >=|<=|==|!=|<|>

aritmetica [+|-|/|*|(|)|=]

caracter_especial ['|{|}|;|,]

logica ["AND"|"OR"|and|or]

comentario "#".*"#"

erro_var  (~|"?"|@|([0-1]+))([a-zA-Z])*

erro_geral . 

%%

{var} { 
    yylval.strval = strdup(yytext);
    return ID;
}

{string} { 
    yylval.strval = strdup(yytext);
    return STRING;
}

{numero} { 
    yylval.intval = atoi(yytext);
    return INT;
}

{aritmetica} { 
    yylval.strval = strdup(yytext);
    return OPERANDO;
}

{tabulacao} ; 
{comparacao}            { printf("Token: %s\n",yytext); }
{caracter_especial}     { printf("Token: %s\n",yytext); }
{logica}                { printf("Token: %s\n",yytext); }
{comentario}            { printf("Token: %s\n",yytext); }
{erro_var}              { printf("A cadeia %s nao faz parte da linguagem\n",yytext); }
{erro_geral}            { printf("A cadeia %s nao faz parte da linguagem\n",yytext); }

%%

int yywrap() {
    return 1;
}
