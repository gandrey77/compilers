%{
#include <stdio.h>
#include <string.h>

#ifdef WIN32
    #include "../anasint/parser.tab.h"
#else
    #include "../anasint/y.tab.h"
#endif

void handleError(char *token);
%}

/* Expressões regulares para as cadeias lidas. */
init init

end end

types integer|string|double|float

comma ,

semicolon ;

open_parenthesis [(]

close_parenthesis [)]

open_bracket [{]

close_bracket [}]

if_decl if

else_decl else

loop while

for for

print print

general ([a-zA-Z])([a-zA-Z]|[0-9\_])*

text "'".*"'"
                                                                    
number [0-9]+([\.][0-9]+)*

arithmetic [+|-|/|*]

allocation <-|=

comparison >=|<=|==|!=|<|>

tabulation [" "|\n|\t]+ 

comment "#".*"#"

error_general (~|"?"|@|([0-1]+))([a-zA-Z])*

error . 

%%

{init} { return INIT; }

{end} { return END; }

{types} { return TYPE; }

{comma} { return COMMA; }

{semicolon} { return SEMICOLON; }

{open_parenthesis} { return OPN_PARENTH; }

{close_parenthesis} { return CLS_PARENTH; }

{open_bracket} { return OPN_BRACKET; }

{close_bracket} { return CLS_BRACKET; }

{if_decl} { return IF; }

{else_decl} { return ELSE; }

{for} {return FOR; }

{loop} { return WHILE; }

{print} { return PRINT; }

{text} { return TEXT; }

{number} { return NUMBER; }

{arithmetic} { return OPERATOR; }

{allocation} { return EQUAL; }

{comparison} { return COMPARATOR; }

{comment} { return COMMENT; }

{tabulation} ;  // Apenas ignora as tabulações.

{general} { return ID; }

{error_general} { handleError(yytext); }

{error} { handleError(yytext); }

%%

void handleError(char *token) {
    printf("Erro lexico: a cadeia %s nao faz parte da linguagem\n", token);

    exit(1);
}

int yywrap() {
    return 1;
}
