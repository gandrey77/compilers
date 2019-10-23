%{
#include <stdio.h>
#include <string.h>

void yyerror(char *error);
int yylex(void);
%}

%defines "parser.tab.h"

/* Símbolo inicial. */
%start s

/* Tokens gerados pelo analisador léxico. */
%token ID
%token STRING
%token OPERATOR
%token NUMBER

%%

s:
  string | expression;

string:
  STRING { printf("String aceita"); } 
  | ;

expression:
  expression OPERATOR expression { printf("Expressao"); }
  | NUMBER { printf("Numero"); };

%%

void yyerror(char *error) {
  printf("Error: %s\n", error);
}

int main() {
  yyparse();

  return 0;
}
