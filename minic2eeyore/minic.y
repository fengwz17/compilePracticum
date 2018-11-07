%{
#define YYPARSER /* distinguishes Yacc output from other code files */

#include "stdio.h"
#include "stdlib.h"
#include "globals.h"
//#include "util.h"

#define YYSTYPE string

void yyerror(const char *message);
extern FILE* yyin;

//static TreeNode * savedTree; /* stores syntax tree for later return */
static int yylex(void);
char tokenstr[100];
extern int lineno;

string cWord[] = {"getint", "putchar", "putint", "getchar"};
%}

%nonassoc LOWER_THAN_ELSE
%nonassoc ELSE

%token INT MAIN IF ELSE WHILE RETURN
%token ASSIGN
%token INTEGER IDENTIFIER
%left AND OR 
%left GT LT EQ UNEQ
%left PLUS MINUS 
%left MUL DIV MOD 
%right '='
%right NOT

%start Goal

%%

Goal:
      DefaDec Mainfunc
    ;

DefaDec:
      DefaDec VarDefn
    | DefaDec FuncDefn
    | DefaDec FuncDecl 
    |
    ;

VarDefn:
      Type Identifier ';' 
    | Type Identifier '[' Integer ']' ';' 
    ;

VarDecl:
      Type Identifier
    | Type Identifier '[' Integer ']'
    ;

FuncDefn:
      Type Identifier '(' Para ')' '{' Func '}'
    ;

FuncDecl:
      Type Identifier '(' Para ')' ';'
    ;

Mainfunc:
      INT MAIN '(' ')' '{' Func '}'
    ;

Type: 
      INT 
    ;

Para:
      VarDecl
    | Para ',' VarDecl
    | 
    ;

Func:
      Func FuncDecl
    | Func Statement
    |
    ;

Statement:
      '{' StatementList '}'
    | IF '(' Expression ')' Statement %prec LOWER_THAN_ELSE
    | IF '(' Expression ')' Statement ELSE Statement
    | WHILE '(' Expression ')' Statement
    | Identifier '=' Expression ';'
    | Identifier '[' Expression ']' '=' Expression ';'
    | VarDefn
    | RETURN Expression ';'
    ;

StatementList:
      StatementList Statement
    |
    ;

Expression:
      Expression PLUS Expression
    | Expression MINUS Expression
    | Expression MUL Expression
    | Expression DIV Expression
    | Expression MOD Expression
    | Expression AND Expression
    | Expression OR Expression
    | Expression EQ Expression
    | Expression LT Expression
    | Expression GT Expression
    | Expression UNEQ Expression
    | Identifier '[' Expression ']'
    | Integer
    | Identifier
    | NOT Expression
    | MINUS Expression
    | Identifier '(' IdentiList ')'
    | '(' Expression ')'  
    ;

IdentiList:
      Identifier
    | IdentiList ',' Identifier
    | 
    ;

Integer:
      INTEGER
    ;

Identifier:
      IDENTIFIER
    ;
%%

void yyerror(const char *message)
{ 
    extern int lineno;
    fprintf(stderr,"Syntax error at line %d: %s\n", lineno, message);
    //printToken(yychar,tokenStr);

    exit(1);
}

// yylex calls getToken to make Yacc/Bison output
 
static int yylex(void)
{ 
    return getToken(); 
}

// TreeNode * parse(void)
// { 
//     yyparse();
//     return savedTree;
// }

int main(int argc, char** argv)
{
    if(argc <= 1)
    {
      printf("error\n");
      return 1;
    }
    
    yyin = fopen(argv[1], "r");
    yyparse();
    return 0;
}
