data salary(keep = salary rename = salary = salaryemp);
infile "/home/u61606629/datasetlearnersas/salary (2).txt";
input year salary;
run;

/* obs means how many obs to show like .head() in python */
proc print data = salary(obs = 3);
run;

/*firstobs = n , n = the row number. So the dataset will be printed from nth row */
proc print data = salary(firstobs = 3 obs = 4);
run;


data salary;
infile "/home/u61606629/datasetlearnersas/salary.txt" DELIMITER=".";
input year salary;
run;


/* Make data instream SAS */
data sample;
input age gender$;
CARDS; /* or use datalines */
45 M
24 F
;
run;

/* Make data instream SAS using column definitions*/
data sample;
input age 1-2 gender$ 3-8; /* these numbers represents how many max characters each column varibles have*/
/* we know that in this data, age is two digit so we use index 1 till 2.
For the gender, female is a 6  letter word so index 3 to 8*/
CARDS; /* or use datalines */
45Male
24Female
;
run;

/* Dates */

data dates;
input company_name$ dob date11.;
cards;
HSBC 4 Mar 1985
TheMathCompany 15 Feb 1976
Twimbit 14 Jun 1975
QuickRide 5 Jan 1988
Amazon 15 Dec 1995
;
run;
PROC PRINT data = dates;
FORMAT dob date9.;
run;

/* Creating Variables */
data house_price;
infile "/home/u61606629/datasetlearnersas/houseprice (2).txt";
input room$ cost rate;
final_price = ROUND(cost * rate);
run;

data sales;
input name$ sales_1-sales_4;
total = sum(sales_1,sales_2,sales_3,sales_4);
cards;
AB 1 2 3 4
CB 3 4 5 3
;
run;

/* Automatic Variables */
data test;
input row val;
if _error_ = 1 then
put "** ERROR in row" _n_ "**";
cards;
1 1
2 n
3 2
;
run;

/* Filtering */
/* First we load data in SAS */
data house_price;
infile "/home/u61606629/datasetlearnersas/houseprice (2).txt";
input type$ price tax;
run;
proc print data = house_price;
run;
/* We then make SAS read the data using SET */
data filter;
set house_price;
if price < 200000;
run;

/* Conditonal Statement */
data sales;
input name$ sales_1-sales_4;
total = sum(sales_1,sales_2,sales_3,sales_4);
IF name = "CB" THEN total =999;
cards;
AB 1 2 3 4
CB 3 4 5 3
;
run;


data sales;
input name$ sales_1-sales_4;
total = sum(sales_1,sales_2,sales_3,sales_4);
fired = '';
IF name = "CB" and total > 30 THEN
fired = 'N';
ELSE fired = 'Y';
cards;
AB 1 2 3 4
CB 3 4 5 3
;
run;


data sales;
input name$ sales_1-sales_4;
total = sum(sales_1,sales_2,sales_3,sales_4);
peformance = '';
IF total <= 10 THEN peformance = 'l';
else if total >10 and total <99 then peformance = 'h';
else peformance = 'o';
cards;
AB 1 2 3 4
CB 3 4 5 3
DD 99 99 99 99 
;
run;

data sales;
input name$ sales_1-sales_4;
total = sum(sales_1,sales_2,sales_3,sales_4);
fired = '';
IF name = "CB" and total > 30 THEN 
DO;
fired = 'N';
end;
cards;
AB 1 2 3 4
CB 3 4 5 3
;
run;


/* looping in SAS */

data a;
do i = 1 to 5 by 0.5;
y = i*2;
output;
end;
run;

/* while executes as long as certain conditions hold true where as until executes only until a certain condition is met */
data a;
do i = 1 to 5 by 0.5 while(y<5);
y = i*2;
output;
end;
run;

data a;
do i = 1 to 5 by 0.5 until(y<5);
y = i*2;
output;
end;
run;

data a;
do i = 1,2,3,4;
y = i*2;
output;
end;
run;

data a;
input year;
cards;
4
3
6
3
9
;
run;

data b;
set a;
if year>5 then do;
month = year *12;
put year= month=;
end;
else yearsleft = year - 5;
run;

data b;
set a;
if year>5 then
month = year *12;
else yearsleft = year - 5;
run;

/* where clause */
data sales;
input name$ sales_1-sales_4;
total = sum(sales_1,sales_2,sales_3,sales_4);
cards;
AB 1 2 3 4
CB 3 4 5 3
;
run;

proc sql;
select * from sales where total>5;


proc print data = sales(where = (total>5));
run;

proc print data=sales;
where total > 11;
run;

/* sorting */
data house_price1;
set house_price;
run; 

proc print data=house_price1;
run;

proc sort data = house_price1 out = hp;
by descending tax;
run;
proc print data=hp;
run;