%{
int lineCounter = 1;
%}

variable [a-z][A-Za-z_0-9]*
function_name [A-Z][A-Za-z_0-9]*
float [+-]?[0-9]*(\.)[0-9]+
integer [+-]?[0-9]+
newline [\n]
comment \#.*\#
array (\[([0-9]*)?\])+
print_string \".*\"

%%
START return(START);
FINISH return(FINISH);
input return(INPUT);
print return(PRINT);
{print_string} return(PRINTSTRING);
return return(RETURN);
Graph return(GRAPH);
def return(DEF);
if return(IF);
else return(ELSE);
while return(WHILE);
for return(FOR);
int return(INT_DECLARE);
float return(FLOAT_DECLARE);
char return(CHAR_DECLARE);
SHOWONMAP return(SHOWONMAP);
SEARCHLOCATION return(SEARCHLOCATION);
GETROADSPEED return(GETROADSPEED);
GETLOCATION return(GETLOCATION);
SHOWTARGET return(SHOWTARGET);
ADDROAD return(ADDROAD);
SHOWCROSSROADS return(SHOWCROSSROADS);
SHOWROADS return(SHOWROADS);
\, return(COMMA);
\; return(SEMICOLON);
\: return(COLON);
{integer} return(INT);
{float} return(FLOAT);
{comment} return(COMMENT);
{variable} return(VAR_NAME);
{function_name} return(FUNC_NAME);
{array} return(ARRAY);
\+ return(PLUS);
\- return(MINUS);
\* return(MULTIPLY);
\/ return(DIVIDE);
\( return(OPEN_PAR);
\) return(CLOSE_PAR);
\[ return(OPEN_SQR_BRC);
\] return(CLOSE_SQR_BRC);
\{ return(OPEN_CURLY_PAR);
\} return(CLOSE_CURLY_PAR);
\|\| return(OR);
\&\& return(AND);
\= return(ASSIGN);
\=\= return(EQUAL);
\!\= return(NOTEQUAL);
\<\= return(LESSOREQUAL);
\>\= return(GREATEROREQUAL);
\< return(LESSTHAN);
\> return(GREATERTHAN);
{newline} {lineCounter++;}
[ \r\t]+ ;
. return(INVALID);
%%

int yywrap() {
return 1;
}