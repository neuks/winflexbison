/********************************************************
 * ex1.ypp 
 ********************************************************/
%{
#include <stdio.h>
//-- Lexer prototype required by bison, aka getNextToken()
int yylex(); 
int yyerror(const char *p) { printf("Error!\n");; }
%}

//-- SYMBOL SEMANTIC VALUES -----------------------------
%union {
  int val; 
  char sym;
};
%token <val> NUM
%token <sym> OPA OPM LP RP STOP
%type  <val> exp term sfactor factor res

//-- GRAMMAR RULES ---------------------------------------
%%
run: res run | res    /* forces bison to process many stmts */

res: exp STOP         { printf("%d\n", $1); }

exp: exp OPA term     { $$ = ($2 == '+' ? $1 + $3 : $1 - $3); }
| term                { $$ = $1; }

term: term OPM factor { $$ = ($2 == '*' ? $1 * $3 : $1 / $3); }
| sfactor             { $$ = $1; }

sfactor: OPA factor   { $$ = ($1 == '+' ? $2 : -$2); }
| factor              { $$ = $1; }

factor: NUM           { $$ = $1; }
| LP exp RP           { $$ = $2; }

%%
//-- FUNCTION DEFINITIONS ---------------------------------
int main()
{
  yyparse();
  return 0;
}
