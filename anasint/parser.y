%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* Protótipos de funções. */
void yyerror(const char *error);
int yylex(void);
%}

//%defines "parser.tab.h"

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
%token WHILE
%token PRINT
%token COMPARATOR
%token TEXT
%token COMMENT
%token FOR

/* Evita a ambiguidade da gramática de aritmética. */
%left OPERATOR

%%

start:
  INIT command END;

command:
  declaration 
  | expression 
  | allocation
  | loop
  | conditional
  | comparison 
  | text 
  | comment
  | print
  |;  

declaration:
  TYPE ID continuation command { printf("Declaracao de variaveis aceita\n"); }
  | TYPE ID EQUAL expression continuation command { printf("Declaracao de variaveis aceita\n"); };

continuation:
  COMMA ID continuation
  | ;

expression:
  expression OPERATOR expression  { printf("Expressao aritmetica aceita\n"); }
  | OPN_PARENTH expression CLS_PARENTH { printf("Expressao aritmetica aceita\n"); }
  | NUMBER { printf("Numero aceito\n"); }
  | ID { printf("Variavel aceita\n"); };

allocation:
  ID EQUAL expression command { printf("Atribuicao aceita\n"); };

conditional:
  IF comparison block command { printf("Condicional (if) aceita\n"); }
  | else_conditional;

else_conditional:
  ELSE comparison block command { printf("Condicional (else parametrizado) aceita\n"); }
  | ELSE block command { printf("Condicional (else sem parametro) aceita\n"); };  

loop:
  FOR loop_for block { printf("Laço (for) aceito\n"); } 
  | WHILE comparison block command { printf("Laço (while) aceito\n"); };

loop_for: 
  OPN_PARENTH allocation SEMICOLON allocation CLS_PARENTH
  | OPN_PARENTH allocation SEMICOLON expression COMPARATOR expression CLS_PARENTH;
  
comparison:
  OPN_PARENTH expression COMPARATOR expression CLS_PARENTH { printf("Comparacao aceita\n"); };

text:
  TEXT { printf("Texto aceito\n"); };

comment:
  COMMENT { printf("Comentario aceito\n"); };
 
block: 
  OPN_BRACKET command CLS_BRACKET  { printf("Bloco aceito\n"); };


print: 
  PRINT OPN_PARENTH TEXT CLS_PARENTH command { printf("Print aceito\n"); };

  
%%

void yyerror(const char *error) {
  printf("Erro: %s\n", error);
  exit(1);
}

int main() {
  yyparse();

  return 0;
}
