/* convert numeric to char variable using put statement */
/* compress to delete spaces */
/* Informats is used to tell SAS how to read a variable whereas Formats is used to tell SAS how to display or write values of a variable.  */

data sample;
	a = 10;
	a_char = compress(put(a,$10.));
run;

proc print data = sample;
run;

ods select Variables;
proc contents data = sample;
run;

proc format;
	value $gender_map
		'1' = 'Male'
		'0' = 'Female';
run;

data sample;
	gen = '1';
	gen_ = put(gen,$gender_map.);
run;


data sample;
	today = today();
	today_ = put(today,date11.);
run;

/* convert char to numeric data - informat*/
/* $<informat><w>. */

data sample;
	money = '$20,000.35';
	money_ = input(money,dollar11.5);
run;


data sample;
	date = '01/01/2018';
	money_ = input(date,mmddyy10.);
run;

data sample;
	date = '01jan2018';
	money_ = input(date,date10.);
run;

%let path = /home/u61606629/sasuser.v94/SASPRG1/e1_delimited_file.txt;

proc import datafile= "&path"
	out = sample
	dbms = dlm
	replace;
	delimiter = '&';
	getnames = yes;
run;


%let path = /home/u61606629/sasuser.v94/SASPRG1/e4_csv_file.txt;

proc import datafile= "&path"
	out = sample
	dbms = dlm
	replace;
	delimiter = ',';
	getnames = No;
run;


%let path = /home/u61606629/sasuser.v94/SASPRG1/e5_excel_file.xlsx;

proc import datafile= "&path"
	out = sample
	dbms = xlsx
	replace;
	getnames = Yes;
	sheet = 'Sheet1';
run;


/* Data input using data step - column input - standard data */
%let path = /home/u61606629/sasuser.v94/SASPRG1;
run;

data sample;
	
	infile "&path./col_example5.txt";
	input id first_name $  last_name $ salary designation $;
run;

/* Data input using data step - formatted input - non - standard data */
/* informat is used to tell sas how to read the data while formats tell sas how to display the data*/
/* so we can choose to not use $ when displaying a numeric date in read date format */
%let path = /home/u61606629/sasuser.v94/SASPRG1;
run;

data sample;
	
	infile "&path./col_example5.txt";
	input id first_name $  last_name $ salary designation $;
	format salary dollar10.;
run;

/* using informat to tell sas how to read in the dates. Here dates are read in as numeric. Then using formats to tell SAS how to show them dates */

data sample;
	length id 8 first_name $ 10 last_name $ 10 salary 8 designation $ 100 hire_date 8 dob 8;
	infile cards;
	input id first_name $  last_name $ salary designation $ hire_date dob;
	informat hire_date date9. dob ddmmyy10.;
	format salary dollar10. hire_date date11. dob date11.;
	

cards;
123  Alice    White   100000  Account_Executive        10may2005    06/02/1993
456  Michael  Smith   150000  Chief_Executive_Officer  15jul2010    20/10/1980
768  Kim      Jones    80000  Business_Analyst         20dec2008    25/04/1990
;

	*format salary dollar10. hire_date date11. dob date11.;
run;
/* reading delimited files */
data sample;
	infile cards dlm = '&' dsd missover;
	length Region $ 10 State $ 10;
	input Region $ State $ Month $ Expenses Revenue;
	informat Month $mmyy7.;
	format Month $yymm10. Expenses dollar10. Revenue dollar10.;
	cards;
Southern&GA&JAN2001&2000&8000
Southern&GA&FEB2001&1200&6000
Southern&FL&FEB2001&8500&11000
Northern&NY&FEB2001&3000&4000
Northern&NY&MAR2001&6000&5000
Southern&FL&MAR2001&9800&13500
Northern&MA&MAR2001&1500&1000
;
run;

data sample;
	infile "/home/u61606629/sasuser.v94/SASPRG1/e4_csv_file.txt" dlm=',' dsd missover;
	length var1 $ 10 var2 $ 10 var3 $ 10 var4 8 var5-var7 8;
	input var1-var7;
	informat var5-var7 dollar10.;
	format var5-var7 dollar10.;
run;
