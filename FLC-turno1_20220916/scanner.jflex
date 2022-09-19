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

	boolean debug = false;

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

date = (2022\/09\/(([12][0-9])|(30)))|
		(2022\/11\/(([012][0-9])|(30)))|
		(2022\/1[02]\/(([012][0-9])|(3[01])))|
		(2023\/01\/(([012][0-9])|(3[01])))|
		(2023\/02\/(([01][0-9])|(2[0-8])))|
		(2023\/03\/(([0][0-9])|(1[0-5])))
hour = :((09:(1[1-9]|[2-5][0-9]))|(1[0-6]:[0-5][0-9])|(17:((0[0-9])|(1[0-3]))))
token3 = Z_{date}{hour}?


comment = "(+-".*"-+)"
quoted_string = \"[ a-zA-Z]+\"
real_num = ([1-9][0-9]*"."[0-9]+)|(0"."[0-9]+) 
int_num = [1-9][0-9]*

%%

{token1} { 
    if(debug)System.out.println("TOK1 " + yytext());
	return sym(sym.TOK1);
	}
{token2} {
    if(debug)System.out.println("TOK2 " + yytext());
	return sym(sym.TOK2);
	}
{token3} {
    if(debug)System.out.println("TOK3 " + yytext());
	return sym(sym.TOK3);
	}
"km" {
    if(debug)System.out.println("KM " + yytext());
    return sym(sym.KM);
	}
"kcal/km" {
    if(debug)System.out.println("kcal " + yytext());
    return sym(sym.KCAL);
	}
ROUTE {
    if(debug)System.out.println("ROUTE " + yytext());
    return sym(sym.ROUTE);
	}
ELEVATION {
    if(debug)System.out.println("ELEVATION " + yytext());
    return sym(sym.ELEV);
	}
m {
    if(debug)System.out.println("M " + yytext());
    return sym(sym.M);
	}



"====" {
    if(debug)System.out.println("SEP " + yytext());
	return sym(sym.SEP);
	}
";" {
    if(debug)System.out.println("S " + yytext());
	return sym(sym.S);
	}
"," {
    if(debug)System.out.println("C " + yytext());
	return sym(sym.C);
	}
":" {
    if(debug)System.out.println("DD " + yytext());
	return sym(sym.DD);
	}
{quoted_string} {
    if(debug)System.out.println("CITY " + yytext());
	return sym(sym.CITY, new String(yytext()));
	}
TO {
    if(debug)System.out.println("TO " + yytext());
	return sym(sym.TO, new String(yytext()));
	}
{real_num} {
	if(debug)System.out.println("REAL_NUM " + yytext());
	return sym(sym.REAL_NUM, new Double(yytext()));
}
{int_num} {
    if(debug)System.out.println("INT_NUM " + yytext());
    return sym(sym.INT_NUM, new Integer(yytext()));
	}
{comment} {;}



\r | \n | \r\n | " " | \t	{;}

.				{ System.out.println("Scanner Error: " + yytext()); }
