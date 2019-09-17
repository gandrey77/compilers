%{

#include<stdio.h>    

%}

string ([a-zA-Z])([a-zA-Z]|[0-9\_])* 
                                                                    
numero [0-9]+([\.][0-9]+)?

tabulacao (" "|"\n"|"\t")+ 

aritmetica1 >=|<=|==

aritmetica [+|-|/|%|*|(|)|=|<|>]

logica ["AND"|"OR"]

comentario "#".*"#"

erro_var  ([0-1]+)([a-zA-Z])* 

erro_geral . 

%%

{string} {printf("Token: %s \n", yytext);}
{numero} {printf("Token: %s\n",yytext);}
{tabulacao} ; 
{aritmetica} {printf("Token: %s\n",yytext);}
{aritmetica1} {printf("Token: %s\n",yytext);}
{logica} {printf("Token: %s\n",yytext);}
{comentario} {printf("Token: %s\n",yytext);}
{erro_var} {printf("A cadeia %s nao faz parte da linguagem\n",yytext);}
{erro_geral} {printf("A cadeia %s nao faz parte da linguagem\n",yytext);}

%%

int main(){
    yylex();

    return 0;
}
