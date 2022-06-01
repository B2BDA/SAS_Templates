data summing;
a = sum(1,2,3);
b = sum(a,a);
c = sum(b/a,a);
d = sum(of var1-var2);
run;

proc print data = summing;
run;

data sum_new;
input var1-var3;
cards;
1 1 1
2 2 2
;
run;

data new_sum1;
set sum_new;
f = sum(of var1-var3);
todays_date= today();
todays_date1 = put(todays_date, date11.);
run;

proc print data = new_sum1;
var var1-var3 todays_date1 ;
run;

/* Split chars using scan*/
data splitnames;
length name$ 100;
input name$ &;
prefix = scan(name, 1);
CARDS;
Mr. Bishwarup Biswas
Dr. Samik Rai Chowdhury
;
run;