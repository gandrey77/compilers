%{
#include <stdio.h>
#include <string.h>
#ifdef  WIN32
  %defines "parser.tab.h"
#endif

/* Protótipos de funções. */
void yyerror(char *error);
int yylex(void);
%}


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
  | declaration 
  | expression 
  | allocation
  | loop
  | conditional
  | comparison 
  | text 
  | comment
  | print;
  

declaration:
  TYPE ID continuation command { printf("Declaracao de variaveis aceita\n"); }
  | TYPE ID EQUAL expression continuation command { printf("Declaracao diferenciada\n");};

continuation:
  COMMA ID continuation
  | ;

expression:
  expression OPERATOR expression  { printf("Expressao aritmetica aceita\n"); }
  | NUMBER {printf("Numero aceito\n");}
  | ID {printf("ID aceito\n");};
  

allocation:
  ID EQUAL expression command{ printf("Atribuicao aceita\n"); };

conditional:
  IF comparison block command { printf("if aceito\n"); }
  | else_conditional;

else_conditional:
  ELSE comparison block command { printf("Else aceito\n");}
  | ELSE block command { printf("Else sem parametro\n");};
  

loop:
  FOR for block { printf("For funcionando\n");} 
  | WHILE comparison block command {printf("while funcionando\n");};

for: 
  OPN_PARENTH allocation SEMICOLON allocation CLS_PARENTH;
  | OPN_PARENTH allocation SEMICOLON expression COMPARATOR expression CLS_PARENTH;
  
comparison:
  OPN_PARENTH expression COMPARATOR expression CLS_PARENTH { printf("Comparacao aceita\n"); };

text:
  TEXT { printf("Texto aceito\n"); };

comment:
  COMMENT { printf("Comentario aceito\n"); };
 
block: 
  OPN_BRACKET command CLS_BRACKET  {printf("Bloco criado\n");};


print: PRINT OPN_PARENTH TEXT CLS_PARENTH command {printf("Print sucesso\n");};

  
%%

void yyerror(char *error) {
  printf("Error: %s\n", error);
}

int main() {
  yyparse();

  return 0;
}
