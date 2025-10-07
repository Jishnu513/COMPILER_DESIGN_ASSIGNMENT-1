%{
#include <stdio.h>
#include <ctype.h>

int yylex(void);
void yyerror(const char *s);
#define YYSTYPE double
%}

%token NUMBER

%left '+' '-'
%left '*' '/'
%right UMINUS

%%
lines:
      lines expr '\n'   { printf("Result: %g\n", $2); }
    | lines '\n'
    | /* empty */
    ;

expr:
      expr '+' expr     { $$ = $1 + $3; }
    | expr '-' expr     { $$ = $1 - $3; }
    | expr '*' expr     { $$ = $1 * $3; }
    | expr '/' expr     { 
                            if ($3 == 0) {
                                yyerror("Division by zero");
                                $$ = 0;
                            } else {
                                $$ = $1 / $3;
                            }
                         }
    | '(' expr ')'      { $$ = $2; }
    | '-' expr %prec UMINUS { $$ = -$2; }
    | NUMBER
    ;
%%

// Simple lexer
int yylex(void) {
    int c;

    // Skip whitespace
    while ((c = getchar()) == ' ' || c == '\t');

    // Handle numbers
    if (c == '.' || isdigit(c)) {
        ungetc(c, stdin);
        scanf("%lf", &yylval);
        return NUMBER;
    }

    return c;
}

// Error handling
void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int yywrap() {
    return 1;
}

int main() {
    printf("Enter expressions (CTRL+D to quit):\n");
    yyparse();
    return 0;
}

