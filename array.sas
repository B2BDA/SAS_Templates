data test;
infile "/home/u61606629/datasetlearnersas/6var (2).txt";
input var1-var6;
run;

data recodearray;
set test;
array loop(6) var1-var6; /* anyname(num of cols) */
do i = 1 to 6;
if loop(i)>40 then loop(i)= .;
end;
run;

proc print data=recodearray;
var var1-var6; /* var is used for column selection */
run;

/* creation of new variables using array */
data test;
infile "/home/u61606629/datasetlearnersas/6var (2).txt";
input var_1-var_6;
run;
data neu;
set test;
array vari(6) var_1 - var_6;
array tax(6) tax_1 - tax_6;
do i = 1 to 6;
tax(i) = vari(i) * 0.05 + vari(i);
end;
run;
proc print data = neu;
var var_1 - var_6 tax_1-tax_6;
run;
