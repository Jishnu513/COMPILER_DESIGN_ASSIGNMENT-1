%{
#include <stdio.h>
#include <stdlib.h>

// Function prototype
int yylex();
int yywrap();
%}

%%
"int"|"float"|"char"|"return"|"if"|"else"|"while"|"for"    { printf("Keyword: %s\n", yytext); }
[0-9]+                                                      { printf("Number: %s\n", yytext); }
[a-zA-Z_][a-zA-Z0-9_]*                                      { printf("Identifier: %s\n", yytext); }
"#include"[ \t]*"<"[a-zA-Z0-9.]+">"                         { printf("Header File: %s\n", yytext); }
"="|"+"|"-"|"*"|"/"                                         { printf("Operator: %s\n", yytext); }
";"                                                         { printf("Semicolon: %s\n", yytext); }
"("                                                         { printf("Left Parenthesis: %s\n", yytext); }
")"                                                         { printf("Right Parenthesis: %s\n", yytext); }
"{"                                                         { printf("Left Brace: %s\n", yytext); }
"}"                                                         { printf("Right Brace: %s\n", yytext); }
[ \t\n]+                                                    { /* Ignore whitespace */ }
.                                                           { printf("Unknown Token: %s\n", yytext); }
%%

int main(int argc, char *argv[]) {
    if (argc > 1) {
        FILE *fp = fopen(argv[1], "r");
        if (!fp) {
            printf("Cannot open file %s\n", argv[1]);
            exit(1);
        }
        yyin = fp;
    }
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}
