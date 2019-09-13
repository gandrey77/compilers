%%

([a-zA-Z])([a-zA-Z]|[0-9\_])* {                     
    printf("Token gerado: %s -nome de variavel\n", yytext);
}
                                                                    
[0-9]+ {                                             
    printf("Token gerado: %s -numero\n", yytext);
}

("#"[a-z]*"\n")|(" "|"\n"|"\t")+ ;

["+"|"-"|"/"|"*"|"("|")"|"."|"="|">"|"<"] {
    printf("Token gerado: %s -expressao aritmetica\n", yytext);
}
[";" | "," | "{" | "}" | "&&" | "||" | "'"] {
    printf("Token gerado: %s -caracter especial\n", yytext);
}

. {
    printf("A cadeia %s nao faz parte da linguagem\n",yytext);
}
%%

int main(){
    yylex();
    return (0);
}