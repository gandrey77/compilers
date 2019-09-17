%%

(" "|"\n"|"\t")+ ;

([a-zA-Z])([a-zA-Z]|[0-9\_])* {                     
    printf("Token gerado: %s\n", yytext);
}
                                                                    
[0-9]+ {                                             
    printf("Token gerado: %s\n", yytext);
}

["==" | "!=" | "<=" | ">=" | "&&" | "||"] {
    printf("Token gerado: %s\n", yytext);
}

[";" | "," | "{" | "}" | "=" | "'" | "`"] {
    printf("Token gerado: %s\n", yytext);
}

["+" | "-" | "/" | "*" | "(" | ")" | "." | "%"] {
    printf("Token gerado: %s\n", yytext);
}

([0-1]+)([a-zA-Z])* {
    printf("A cadeia '%s' nao faz parte da linguagem\n", yytext);
}

. {
    printf("A cadeia '%s' nao faz parte da linguagem\n", yytext);
}

%%

int main(){
    yylex();

    return 0;
}
