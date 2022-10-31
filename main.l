%{
  #include<stdio.h>
  extern FILE *yyin;
  extern FILE *yyout;

%}
Var [a-zA-Z][0-9a-zA-Z_]*
Int [0-9]*
Char ['][a-zA-Z0-9][']
Float [0-9]*[.][0-9]*
String ["].*["]
logicaloperator ">>"|"<<"|">>=="|"<<=="|"!!=="|"===="
operation "++"|"--"|"**"|"//"|"%%"
io "++++"|"----"?


%%



"Begin"         {printf("Start_of_Program ");}
"Finish"        {printf("End_of_Program ");}
"intg"          {printf("Integer_type ");}
"flt"           {printf("Float_type ");}
"Charc"         {printf("Character_type ");}
"String"        {printf("String_type ");}
"++"            {printf("Add ");}
"--"            {printf("Substruct ");}
"**"            {printf("Multiply ");}
"//"            {printf("Divide ");}
"++++"          {printf("Increment");}
"----"          {{printf("Decrement");}}
";;"            {printf("End_of_Line ");}
"^^"            {printf("Exponent ");}
">>=="          {printf("Greater_than_or_equal ");}
"<<=="          {printf("Less_than_or_equal ");}
"===="          {printf("Equal ");}
"=="            {printf("Asign ");}
">>"            {printf("Greater_than ");}
"!!>>"          {printf("Not_greater_than ");}
"<<"            {printf("Less_than ");}
"!!<<"          {printf("Not_less_than ");}
"!!=="          {printf("Not_Equal ");}
"%%"            {printf("Remainder ");}
"write"         {printf("Print ");}
"root"          {printf("Root ");}
"prime"         {printf("Prime ");}
"ffor"          {printf("For_loop");}
"iif"           {printf("If_Condition");}
"eelse"         {printf("Else_Condition");}
"eelif"         {printf("Elseif_Condition");}
"wwhile"        {printf("While_Condition");}
"func"          {printf("User_defined_function");}

"("{Var}[=][=]{Int}";;"[ ]*{Var}{logicaloperator}({Int}|{Var})";;"[ ]*{Var}{io}")"   {printf("( initializationStatement; testExpression; updateStatement )");}


{Int}           {printf("Integer ");}
{Var}           {printf("Variable ");}
{Float}         {printf("Float ");}
{String}        {printf("String ");} 
{Char}           {printf("Character ");}

"intg"[ ]+{Var}[ ]*[=][=][ ]*{Int}[;][;]  {printf("Variable Declared: %s\n ",yytext);}
"String"[ ]+{Var}[ ]*[=][=][ ]*{String}[;][;]  {printf("String Declared: %s\n ",yytext);}
"Float"[ ]+{Var}[ ]*[=][=][ ]*{Float}[;][;]  {printf("Float Declared: %s\n ",yytext);}
"Charc"[ ]+{Var}[ ]*[=][=][ ]*{Char}[;][;]  {printf("Character Declared: %s\n ",yytext);}

{Var}[ ]*[=][=][ ]*({Int}|{Var})[ ]*{operation}[ ]*({Int}|{Var})[;][;]  {printf(" %s\n ",yytext);}

"////".*      {printf("Single Line Comment");}

"//**" {
    printf("Multiple_Line_Comment_Starts\n");
    char c;
    label:
        while(c = input() != '*');
    if(c = input() == '*') {
    if(c = input() == '/') {
      if(c = input() == '/') {
        printf("    Multiple_Line_Comment_Ends.\n");}
    }}
    else {
        goto label;
    }
}

"("({Var}|{Int})({logicaloperator}({Int}|{Var}))?")" {printf(" (Condition)\n");}
"  " {}
. {}
%%
int yywrap()
{
return 1;
}
int main()
{
yyin = freopen("input.txt","r",stdin);
yyout = freopen("output.txt","w",stdout);
yylex();
return 0;
}