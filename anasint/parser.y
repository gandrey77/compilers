%{
  #include <stdio.h>

  void yyerror(char *c);
  int yylex(void);
%}

%token INT SOMA EOL
%left SOMA

%%

PROGRAMA:
        PROGRAMA EXPRESSAO EOL;
        |

EXPRESSAO:
        EXPRESSAO SOMA EXPRESSAO {
          $$ = $1 + $3;
          printf("Expressao: %d + %d = %d\n", $1, $3, $1 + $3);
        }
        | INT {
          $$ = $1;
        } 

%%

void yyerror(char *c) {
  printf("Meu erro foi: %s\n", c);
}

int main() {
  yyparse();

  return 0;
}
