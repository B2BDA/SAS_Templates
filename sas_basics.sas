/* library is a folder which consists of SAS data. work is a temp lib and any user defined lib like the below example is a perma lib */


libname sasprg0 "/home/u61606629/sasuser.v94/sasprg0";
run;

data sasprg0.test0;
	var = 1;
run;

/* Explore details of a dataset */
libname SASPRG1 "/home/u61606629/sasuser.v94/SASPRG1";
run;

proc contents data = SASPRG1.adw_employees varnum;
run;


/* if we need to print only specific table first we need to know the table/object name*/
ods trace on; /* output delivery system */

proc contents data = SASPRG1.adw_employees varnum;
run;

ods trace off;

ods select Position;
proc contents data = SASPRG1.adw_employees varnum;
run;

/* select all tables in the lib and get their info */

ods select Position;
proc contents data = SASPRG1._all_ varnum;
run;

/* Printing a dataset */

libname SASPRG1 "/home/u61606629/sasuser.v94/SASPRG1";
run;

proc print data = SASPRG1.adw_employees(obs = 10);
	var Employee_ID	National_ID_Number	First_Name	Middle_Name	Last_Name;
	sum salary;
run;

/*  Save a SAS SQL dataset to library */
proc sql;
Create table SASPRG1.adw_0 AS
(select * from SASPRG1.adw_employees);
quit;

/* Filter of SAS Dataset using where */

proc print data = SASPRG1.adw_employees(obs = 10);
	where salary > 8000;
	var Employee_ID	National_ID_Number	First_Name	Middle_Name	Last_Name;
	sum salary;
run;

proc print data = SASPRG1.adw_employees(obs = 10);
	where salary ~= 8000;
	var Employee_ID	National_ID_Number	First_Name	Middle_Name	Last_Name;
	sum salary;
run;

proc print data = SASPRG1.adw_employees;
	where salary between 10000 and 80000;
	var Employee_ID	National_ID_Number	First_Name	Middle_Name	Last_Name;
	sum salary;
run;


proc print data = SASPRG1.adw_employees;
	where salary is null;
	var Employee_ID	National_ID_Number	First_Name	Middle_Name	Last_Name;
	sum salary;
run;
/* sas format */
/* when ever we use $ that mean we are specifying char variable. */
/* $<format_name><width>.<num of decimal palce> */
libname sasprg1 "/home/u61606629/sasuser.v94/SASPRG1";
run;

proc print data = sasprg1.adw_employees;
	where salary > 8000;
	var Employee_ID	Salary National_ID_Number Hire_Date First_Name Middle_Name Last_Name;
	format salary dollar10.2 Hire_Date date11.;
run;

proc print data = sasprg1.adw_employees;
	where salary > 8000;
	var Employee_ID	Salary National_ID_Number Hire_Date First_Name Middle_Name Last_Name;
	format salary comma10.2 Hire_Date date11.;
run;

proc print data = sasprg1.adw_employees;
	where salary > 8000;
	var Employee_ID	Salary National_ID_Number Hire_Date First_Name Middle_Name Last_Name;
	format salary dollar10.2 Hire_Date yymmdd10.;
run;

/* subset for date */
/* '01JAN2009'd
'01jan60'd
'1jan60'd
'01Jan1960'd*/
proc print data = sasprg1.adw_employees;
	where Hire_Date > '01jan2009'd;
	var Employee_ID	Salary National_ID_Number Hire_Date First_Name Middle_Name Last_Name;
	format salary dollar10.2 Hire_Date yymmdd10.;
run;