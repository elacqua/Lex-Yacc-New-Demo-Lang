%{
    #include<stdio.h>
%}

%token START FINISH SHOWONMAP SEARCHLOCATION GETROADSPEED GETLOCATION SHOWTARGET ADDROAD SHOWCROSSROADS SHOWROADS COMMA SEMICOLON COLON INT INT_DECLARE FLOAT FLOAT_DECLARE CHAR_DECLARE COMMENT VAR_NAME FUNC_NAME INPUT PRINT PRINTSTRING RETURN GRAPH DEF ARRAY PLUS MINUS MULTIPLY DIVIDE IF ELSE WHILE FOR OPEN_PAR CLOSE_PAR OPEN_SQR_BRC CLOSE_SQR_BRC OPEN_CURLY_PAR CLOSE_CURLY_PAR OR AND ASSIGN EQUAL NOTEQUAL LESSOREQUAL GREATEROREQUAL LESSTHAN GREATERTHAN INVALID

%%
program : START statements FINISH ;
statements : statement statements | statement ;

non_block_st : assign SEMICOLON | var_def SEMICOLON | return SEMICOLON | func_call SEMICOLON | print SEMICOLON | graph SEMICOLON
            | scan SEMICOLON | array_def SEMICOLON ;
block_st : if_stmt| while | for | func_dec ;
statement : non_block_st | block_st | COMMENT;


var_def : type VAR_NAME ;
graph : GRAPH FUNC_NAME OPEN_PAR parameters CLOSE_PAR;
array_def : type VAR_NAME ARRAY ;
type : INT_DECLARE | FLOAT_DECLARE | CHAR_DECLARE ;


return : RETURN rhs ;
print : PRINT rhs ;
scan : INPUT rhs ;

func_dec : type DEF FUNC_NAME OPEN_PAR parameters CLOSE_PAR body | built_in_funcs ;
built_in_funcs : show_on_map | search_location | get_road_speed | get_location | show_target | add_road | show_crossroads | show_roads;
show_on_map : SHOWONMAP OPEN_PAR var COMMA var CLOSE_PAR SEMICOLON;
search_location : SEARCHLOCATION OPEN_PAR ARRAY CLOSE_PAR SEMICOLON | SEARCHLOCATION OPEN_PAR VAR_NAME CLOSE_PAR SEMICOLON;
get_road_speed : GETROADSPEED OPEN_PAR GRAPH CLOSE_PAR SEMICOLON | GETROADSPEED OPEN_PAR VAR_NAME CLOSE_PAR SEMICOLON;
get_location : GETLOCATION OPEN_PAR ARRAY CLOSE_PAR SEMICOLON | GETLOCATION OPEN_PAR VAR_NAME CLOSE_PAR SEMICOLON;
show_target : SHOWTARGET OPEN_PAR ARRAY CLOSE_PAR SEMICOLON | SHOWTARGET OPEN_PAR VAR_NAME CLOSE_PAR SEMICOLON;
add_road : ADDROAD OPEN_PAR GRAPH COMMA ARRAY CLOSE_PAR SEMICOLON | ADDROAD OPEN_PAR VAR_NAME COMMA VAR_NAME CLOSE_PAR SEMICOLON;
show_crossroads : SHOWCROSSROADS OPEN_PAR GRAPH CLOSE_PAR SEMICOLON | SHOWCROSSROADS OPEN_PAR VAR_NAME CLOSE_PAR SEMICOLON;
show_roads : SHOWROADS OPEN_PAR GRAPH CLOSE_PAR SEMICOLON | SHOWROADS OPEN_PAR VAR_NAME CLOSE_PAR SEMICOLON;

func_call : FUNC_NAME OPEN_PAR parameters CLOSE_PAR ;
parameters : parameter COMMA parameters | parameter ;
parameter : var ;


if_stmt : matched | unmatched ;
matched : IF cond_expr COLON matched  ELSE COLON matched
     | body ;
unmatched : IF cond_expr COLON if_stmt
    | IF cond_expr COLON  matched ELSE COLON unmatched ;


while : WHILE cond_expr body ;
for : FOR OPEN_PAR assign SEMICOLON cond_expr SEMICOLON assign CLOSE_PAR body ;
body : OPEN_CURLY_PAR statements CLOSE_CURLY_PAR ;

assign : lhs ASSIGN rhs ;
lhs : var | var_def | array_def ;
rhs : cond_expr | OPEN_CURLY_PAR parameters CLOSE_CURLY_PAR ;
cond_expr : or ;
or : and | or OR and ;
and : eq | and AND eq ;
eq : cmp | eq EQUAL cmp | eq NOTEQUAL cmp ;
cmp : expr | cmp LESSTHAN expr |  cmp GREATERTHAN expr |  cmp LESSOREQUAL expr |  cmp GREATEROREQUAL expr ;
expr : expr PLUS expr2
      | expr MINUS expr2
      | expr2 ;
expr2 : expr2 MULTIPLY expr3
      | expr2 DIVIDE expr3
      | expr3 ;
expr3 : OPEN_PAR expr CLOSE_PAR
      | var ;
var : VAR_NAME | INT | FLOAT | func_call | PRINTSTRING ;

%%
#include "lex.yy.c"
extern int lineCounter;
int check = 0;
int yyerror(char *s)
{
    printf ("%s on line %d\n", s, lineCounter);
    check = 1;
}

int main(void)
{
    yyparse();
    if ( check == 0 )
    {
        printf ("Input program successfully executed.\n");
    }
}