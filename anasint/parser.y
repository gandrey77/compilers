%{
#include <stdio.h>
#include <string.h>

/* Protótipos de funções. */
void yyerror(char *error);
int yylex(void);
%}

%defines "parser.tab.h"

/* Símbolo inicial. */
%start start

/* Tokens gerados pelo analisador léxico. */
%token INIT
%token END
%token TYPE
%token COMMA
%token SEMICOLON
%token OPN_PARENTH
%token CLS_PARENTH
%token OPN_BRACKET
%token CLS_BRACKET
%token ID
%token OPERATOR
%token NUMBER
%token EQUAL
%token IF
%token ELSE
%token COMPARATOR
%token TEXT
%token COMMENT

/* Evita a ambiguidade da gramática de aritmética. */
%left OPERATOR

%%

start:
  INIT command END;

command:
  declaration 
  | expression 
  | allocation
  | conditional
  | comparison 
  | text 
  | comment;

declaration:
  TYPE ID continuation { printf("Declaracao de variaveis aceita"); };

continuation:
  COMMA ID continuation
  | SEMICOLON;

expression:
  expression OPERATOR expression { printf("Expressao aritmetica aceita"); }
  | NUMBER
  | ID;

allocation:
  ID EQUAL expression { printf("Atribuicao aceita"); };

conditional:
  IF comparison conditional { printf("Condicional aceita"); }
  | else_conditional;

else_conditional:
  ELSE conditional
  |;

comparison:
  OPN_PARENTH expression COMPARATOR expression CLS_PARENTH { printf("Comparacao aceita"); };

text:
  TEXT { printf("Texto aceito"); };

comment:
  COMMENT { printf("Comentario aceito"); };

%%

void yyerror(char *error) {
  printf("Error: %s\n", error);
}

int main() {
  yyparse();

  return 0;
}
