%{
  #include <stdio.h>
  #include <string.h>

  void yyerror(char *error);
  int yylex(void);
%}

%union {
  char* strval;
  int intval;
}

/* Tokens gerados pelo analisador léxico. */
%token <strval> STRING
%token <strval> ID
%token <strval> OPERANDO
%token <intval> INT

%type <strval> string
%type <intval> expression

%left OPERANDO

%%

string:
  STRING { $$ = $1; };

expression:
  expression OPERANDO expression {
    $$ = $1 + $3;
    printf("Expressao: %d %s %d\n", $1, $2, $3);
  }
  | INT { $$ = $1; };

%%

void yyerror(char *error) {
  printf("Error: %s\n", error);
}

int main() {
  yyparse();

  return 0;
}
