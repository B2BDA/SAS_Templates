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