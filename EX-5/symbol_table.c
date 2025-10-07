#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

void main() {
    int x = 0, n, i = 0, j = 0;
    void *mypointer, *symbol_address[100];
    char ch, search_char, input_expr[100], symbol_list[100], c;

    printf("Input the expression ending with $ sign:\n");

    // Read characters until '$'
    while ((c = getchar()) != '$') {
        input_expr[i++] = c;
    }
    n = i - 1;

    // Display given expression
    printf("\nGiven Expression: ");
    for (i = 0; i <= n; i++) {
        printf("%c", input_expr[i]);
    }

    // Display symbol table
    printf("\n\nSymbol Table\n");
    printf("Symbol\tAddress\t\tType\n");

    while (j <= n) {
        c = input_expr[j];

        // If it's an alphabet, it's an identifier
        if (isalpha(c)) {
            mypointer = malloc(sizeof(char)); // allocate 1 byte
            symbol_address[x] = mypointer;
            symbol_list[x] = c;
            printf("%c\t%p\tidentifier\n", c, mypointer);
            x++;
        }

        // If it's an operator
        else if (c == '+' || c == '-' || c == '*' || c == '=') {
            mypointer = malloc(sizeof(char)); // allocate 1 byte
            symbol_address[x] = mypointer;
            symbol_list[x] = c;
            printf("%c\t%p\toperator\n", c, mypointer);
            x++;
        }

        j++;
    }
}
