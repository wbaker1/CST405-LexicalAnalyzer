/* Code Produced by Wesley Baker and Cameron Verini */
%option noyywrap

%{
#include <stdio.h>
#include <string.h>

#define YY_DECL int yylex()

int words = 0;
int chars = 0;
int lines = 1;

%}
/* This is the set of definitions for tokens in the lexer */
/* Defines letters as uppercase and lowercase characters */
/* Matches digits as 0-9 */
/* Defines identifiers as a letter or combination of letters and digits */
/* Defines delimiters as space, tabs, or newlines */
/* Defines numbers as a single digit or combination of digits with decimals, exponent, or whether  the value is positive/negative. */
/* Defines white space as any combination of delimiters */

letter      [a-zA-Z]
digit       [0-9]
ID          {letter}({letter}|{digit})*
delim       [ \t\n]
NUMBER         {digit}+(\.{digit}+)?(E[+\-]?(digit)+)?
ws          {delim}+

/* Below is where we define what the lexer scans for with input source code, along with the token that is associated with each input scanned */
%%
"/*"    				{
							int c;
							while((c = input()) != 0) {
								if(c == '*') {
									if((c = input()) == '/')
										break;
									else
										unput(c);
								}
							}
						}
						
"int"	{words++; chars += strlen(yytext);
		 printf("%s : TYPE\n", yytext);
		}
		
"float"	{words++; chars += strlen(yytext);
		 printf("%s : TYPE\n", yytext);
		}	

"double" {words++; chars += strlen(yytext);
		 printf("%s : TYPE\n", yytext);
		}

"char"	{words++; chars += strlen(yytext);
		 printf("%s : TYPE\n", yytext);
		}

"string" {words++; chars += strlen(yytext);
		 printf("%s : TYPE\n", yytext);
		}		
				
"+"	{chars++;
		 printf("%s : OP_ADD\n", yytext);
		}


"-"	{chars++;
		 printf("%s : OP_SUBTRACT\n", yytext);
		}

"*"	{chars++;
		 printf("%s : OP_MULTIPLY\n", yytext);
		}

"/"	{chars++;
		 printf("%s : OP_DIVIDE\n", yytext);
		}


"%"	{chars++;
		 printf("%s : OP_MODULO\n", yytext);
		}


"<"	{chars++;
		 printf("%s : OP_LESS\n", yytext);
		}
		
"<=" {chars++;
		printf("%s : OP_LESSEQUAL\n", yytext);
	}
		
">"	{chars++;
		 printf("%s : OP_GREATER\n", yytext);
		}
		
">="	{chars++;
		 printf("%s : OP_GREATEREQUAL\n", yytext);
		}
		
"="		{chars++;
		 printf("%s : OP_ASSIGN\n", yytext);
		}
		
"=="	{chars++;
		 printf("%s : OP_EQUALTO\n", yytext);
		}
		
"!="	{chars++;
		 printf("%s : OP_NOTEQUAL\n", yytext);
		}
		
"!"		{chars++;
		 printf("%s : OP_NOT\n", yytext);
		}
		
"&&"	{chars++;
		 printf("%s : OP_AND\n", yytext);
		}

"||"	{chars++;
		 printf("%s : OP_OR\n", yytext);
		}

"("	{chars++;
		 printf("%s : LEFT_PAREN\n", yytext);
		}

")"	{chars++;
		 printf("%s : RIGHT_PAREN\n", yytext);
		}	

"{"	{chars++;
		 printf("%s : LEFT_BRACE\n", yytext);
		}	

"}"	{chars++;
		 printf("%s : RIGHT_BRACE\n", yytext);
		}

"["	{chars++;
		 printf("%s : LEFT_BRACKET\n", yytext);
		}			

"]"	{chars++;
		 printf("%s : RIGHT_BRACKET\n", yytext);
		}	
		
","		{chars++;
		 printf("%s : SEMICOLON\n", yytext);
		}

";"		{chars++;
		 printf("%s : SEMICOLON\n", yytext);
		}
		
"if"	{words++; 
		 chars += strlen(yytext);
		 printf("%s : KEYWORD_IF\n", yytext);
		}

"else"	{words++; 
		 chars += strlen(yytext);
		 printf("%s : KEYWORD_ELSE\n", yytext);
		}

"while"	{words++; 
		 chars += strlen(yytext);
		 printf("%s : KEYWORD_WHILE\n", yytext);
		}
		
"do"	{words++; 
		 chars += strlen(yytext);
		 printf("%s : KEYWORD_DO\n", yytext);
		}
		
"break"	{words++; 
		 chars += strlen(yytext);
		 printf("%s : KEYWORD_BREAK\n", yytext);
		}
		
"true"	{words++; 
		 chars += strlen(yytext);
		 printf("%s : KEYWORD_TRUE\n", yytext);
		}

"false"	{words++; 
		 chars += strlen(yytext);
		 printf("%s : KEYWORD_FALSE\n", yytext);
		}
		
"print"	{words++; 
		 chars += strlen(yytext);
		 printf("%s : KEYWORD_PRINT\n", yytext);
		}

"putc"	{words++; 
		 chars += strlen(yytext);
		 printf("%s : KEYWORD_PUTC\n", yytext);
		}
		
{ID}	{words++; chars += strlen(yytext);
		 printf("%s : IDENTIFIER\n",yytext);
		}
			
{NUMBER}	{words++; chars += strlen(yytext);
			  printf("%s : NUMBER\n",yytext);
			}
		
\n		{lines++; chars=0;}
[ \t]	{chars++;}
.		{chars++;
         printf("%s : Unrecognized symbol at line %d char %d\n", yytext,lines,chars);
		}
		
%%
int main(int argc, char**argv)
{
	#ifdef YYDEBUG
		yydebug = 1;
	#endif

	printf("Compiler started. \n\n");

	if (argc > 1){
	  if(!(yyin = fopen(argv[1], "r")))
          {
		perror(argv[1]);
		return(1);
	  }
	}
	yylex();
}