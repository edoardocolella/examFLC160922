/**************************
 Scanner
***************************/

import java_cup.runtime.*;

%%

%unicode
%cup
%line
%column

%{
	private Symbol sym(int type) {
		return new Symbol(type, yyline, yycolumn);
	}
	
	private Symbol sym(int type, Object value) {
		return new Symbol(type, yyline, yycolumn, value);
	}
	
%}




binNum = (101) | (110) | (111) | (1(0|1){3,5}) | (10110(0|1){2}) | (1010(0|1){3})|(100(0|1){4}) 
binNumSep = {binNum}("*"|"+")
token1 = X_({binNumSep}{3})|({binNumSep}{5})|({binNumSep}{15}})
string = [xyz]{6}([xyz]{2})*
stringSep = {string}("#"|"$")
token2 = Y_(({string}("#"|"$"){string})|{stringSep}{4}{string})
token3 = tok3


comment = "(+-".*"-+)"
quoted_string = \"[ a-zA-Z]+\"
prov = [A-Z]{2}
real_num = ([1-9][0-9]*"."[0-9]+)|(0"."[0-9]+) 
int_num = [1-9][0-9]*

%%

{token1} { 
    System.out.println("TOK1 " + yytext());
	//return sym(sym.TOK1);
	}
{token2} {
    System.out.println("TOK2 " + yytext());
	//return sym(sym.TOK2);
	}
{token3} {
    System.out.println("TOK3 " + yytext());
	//return sym(sym.TOK3);
	}
km		{
    System.out.println("KM " + yytext());
    //return sym(sym.KM);
	}
"kcal/km" {
    System.out.println("kcal " + yytext());
    //return sym(sym.KCAL);
	}
ROUTE {
    System.out.println("ROUTE " + yytext());
    //return sym(sym.ROUTE);
	}
ELEVATION {
    System.out.println("ELEVATION " + yytext());
    //return sym(sym.ELEVATION);
	}
m {
    System.out.println("M " + yytext());
    //return sym(sym.M);
	}



"====" {
    System.out.println("SEP " + yytext());
	//return sym(sym.SEP);
	}
";" {
    System.out.println("SC " + yytext());
	//return sym(sym.SC);
	}
"," {
    System.out.println("COMMA " + yytext());
	//return sym(sym.COMMA);
	}
":" {
    System.out.println("DD " + yytext());
	//return sym(sym.DD);
	}
{quoted_string} {
    System.out.println("CITY " + yytext());
	//return sym(sym.CITY, new String(yytext()));
	}
{prov} {
    System.out.println("PROV " + yytext());
	//return new sym(sym.PROV, new String(yytext()));
	}
{real_num} {
	System.out.println("REAL_NUM " + yytext());
	//return sym(sym.CITY, new String(yytext()));
}
{int_num} {
    System.out.println("INT_NUM " + yytext());
    //return sym(sym.INT_NUM);
	}
{comment} {;}



\r | \n | \r\n | " " | \t	{;}

.				{ System.out.println("Scanner Error: " + yytext()); }
