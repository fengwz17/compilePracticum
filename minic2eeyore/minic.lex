%{
#include "globals.h"
//#include "util.h"
#include <string>
int lineno = 1;
/* lexeme of identifier or reserved word */
%}

digit       [0-9]
number      {digit}+
letter      [a-zA-Z]
identifier  {letter}({letter}|{digit})*
newline     \n
whitespace  [ \t]+

%%

"int"           {return INT;}
"main"          {return MAIN;}
"if"            {return IF;}
"else"          {return ELSE;}
"while"         {return WHILE;}
"return"        {return RETURN;}

"!"             {return NOT;}
"+"             {return PLUS;}
"-"             {return MINUS;}
"*"             {return MUL;}
"/"             {return DIV;}
"%"             {return MOD;}
"&&"            {return AND;}
"||"            {return OR;}
"<"             {return LT;}
">"             {return GT;}
"=="            {return EQ;}
"!="            {return UNEQ;}
"="             {return '=';}       
"["             {return '[';}
"]"             {return ']';}
"("             {return '(';}
")"             {return ')';}
"{"             {return '{';}
"}"             {return '}';}
";"             {return ';';}
","             {return ',';}
"//"[^\n]*      {}
"\n"            {lineno++;}

{number}        {return INTEGER;}
{identifier}    {return IDENTIFIER;}
{whitespace}    {/* skip whitespace */}

.               {cout << "unknown input ";}

%%

int yywrap(void){

    return 1; 
}

TokenType getToken(void){

    static int firstTime = TRUE;
    TokenType currentToken;

    currentToken = yylex();
    printf("%s\n", yytext);
    strncpy(tokenstr,yytext,MAXTOKENLEN);

    return currentToken;
}


