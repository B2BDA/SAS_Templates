/* length statement for bytes allocation */
data mydata;
lenght age 3 sex$6 bmi 8 children 3 smoker$3	region$15	charges 8;
infile "/home/u61606629/datasetlearnersas/insurance (1).csv" DSD MISSOVER FIRSTOBS=2;
input age sex$ bmi children	smoker$	region$	charges;
run;


/* creating a counting variable */
data students;
input gender scores;
cards;
1 48
1 45
2 50
2 42
1 41
2 51
1 52
1 43
2 52
;
run;

/* proc freq data = students;
label gender = 'Gender';
run; */

proc sort data = students;
by gender;
run;

data new_students;
set students;
count + 1;
by gender;
if first.gender then count = 1;run; /* first means check 1st observatoion */
