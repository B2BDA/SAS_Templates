libname sasprg1 "/home/u61606629/sasuser.v94/SASPRG1";
run;

/* Reading existing SAS dataset */

data adw_emp;
	set sasprg1.adw_employees;
	where job_title contains 'Production' & salary > 3000;
run;

proc print data = adw_emp;
run;


/* Reading existing SAS dataset */

data adw_emp;
	set sasprg1.adw_employees;
	where job_title contains 'Production' 
		& hire_date <= '01jan2009'd;
run;

proc print data = adw_emp;
	format hire_date DDMMYYD.;
run;

/* summarize categorical data */

proc freq data = sasprg1.adw_employees;
	table hire_date;
	format hire_date year.;
run;

/* Creating new variables and subset variables in data step*/
data adw_emp;
	set sasprg1.adw_employees;
	where job_title contains 'Production' 
		& hire_date <= '01jan2009'd;
	bonus = salary + 10000;	
	keep First_Name Last_Name Job_Title Gender hire_date bonus;
	/* drop ;*/
run;
proc print data = adw_emp;
	* var hire_date salary bonus;
	format hire_date DDMMYYD. bonus dollar10. ;
run;


/* When creating a new variable in a datastep, we can not filter using the variable using where we need to use if statement*/
data adw_emp;
	set sasprg1.adw_employees;
	where job_title contains 'Production' 
		& hire_date <= '01jan2009'd;
	bonus = salary + 10000;	
	keep First_Name Last_Name Job_Title Gender hire_date salary bonus;
	if bonus >=3000;
	/* drop ;*/
run;
proc print data = adw_emp;
	* var hire_date salary bonus;
	format hire_date DDMMYYD. salary dollar10. bonus dollar10. ;
run;


/* */
ods trace on;
proc contents data = sasprg1.adw_employees varnum;
run;

ods trace off;

ods select Position;
proc contents data = sasprg1.adw_employees varnum;
run;

/* labels for variable names and permanent formats */
proc format;
	value $mfmap
		'M' = 'Male'
		'F' = "Female";
	run;
data adw_emp;
	length full_name $ 20;
	set sasprg1.adw_employees;
	where job_title contains 'Production' 
		& hire_date <= '01jan2009'd;
	bonus = salary + 10000;	
	full_name = first_name || last_name; /* concat two char variables */
	keep full_name Job_Title Gender hire_date salary bonus;
	if bonus >=3000;
	label hire_date = "DOJ";
	format full_name $20. hire_date DDMMYYD. salary dollar10. bonus dollar10. gender $mfmap.;
	/* drop ;*/
run;
proc print data = adw_emp label;
	* var hire_date salary bonus;
run;
/* Simple functions - sum */

libname sasprg1 "/home/u61606629/sasuser.v94/SASPRG1";
run;

data adw_emp_compensation;
	set sasprg1.adw_employees;
	bonus = 500;
	/*if salary = . then compensation = bonus;
	else compensation = salary + bonus;*/
	compensation = sum(bonus,salary);
	year_of_hire = year(hire_date);
	keep first_name last_name salary gender bonus compensation hire_date year_of_hire;
	format hire_date date11. salary dollar10. bonus dollar10. compensation dollar10. ;
run;

proc print data = adw_emp_compensation;
run;

proc freq data = adw_emp_compensation;
	where salary < 3000;
	table year_of_hire;
	/* table hire_date;
		format hire_date year.; */
run;

/* If then else statement */
data adw_emp_compensation;
	set sasprg1.adw_employees;
	if job_title = 'Production Technician - WC10' or job_title = 'Production Supervisor - WC10'
	then bonus = 1.0;
	else if job_title in ('Production Technician - WC20','Production Supervisor - WC20') then bonus = 1.5;
	else if job_title = 'Production Technician - WC30' then bonus = 2;
	else if job_title = 'Production Technician - WC40' then bonus = 2.5;
	else if job_title = 'Production Technician - WC45' then bonus = 3.0;
	else if job_title = 'Production Technician - WC50' then bonus = 3.5;
	else if job_title = 'Production Technician - WC60' then bonus = 4;
	else bonus = 0;
	compensation = sum(salary,bonus);
	keep job_title first_name last_name salary gender bonus compensation hire_date year_of_hire;
	format hire_date date11. salary dollar10. bonus dollar10. compensation dollar10. ;
run;

proc print data = adw_emp_compensation;
run;

/*If then Do and End Statement when executing more than on action in than statement*/
data adw_emp_compensation;
	set sasprg1.adw_employees;
	if job_title = 'Production Technician - WC10' or job_title = 'Production Supervisor - WC10'
	then do ;
			bonus = 1.5;
			dayoff = 3;
		end;
	else if job_title in ('Production Technician - WC20','Production Supervisor - WC20') then 
		do ;
			bonus = 1.5;
			dayoff = 1;
		end;
	else if job_title = 'Production Technician - WC30' then bonus = 2;
	else if job_title = 'Production Technician - WC40' then bonus = 2.5;
	else if job_title = 'Production Technician - WC45' then bonus = 3.0;
	else if job_title = 'Production Technician - WC50' then bonus = 3.5;
	else if job_title = 'Production Technician - WC60' then bonus = 4;
	else bonus = 0;
	compensation = sum(salary,bonus);
	keep job_title first_name last_name salary gender bonus compensation hire_date year_of_hire dayoff;
	format hire_date date11. salary dollar10. bonus dollar10. compensation dollar10. ;
run;

proc print data = adw_emp_compensation;
run;

/* summarize numeric and char data using proc freq, means and univariate */
proc freq data = sasprg1.adw_employees order = freq;
	table gender / missing /* nocum */;
	table marital_status;
run;

/* proc freq with format */
proc format;
	value sal_segment
		low -< 30000 = 'Seg1'
		30000 -< 50000 = 'Seg2'
		50000 - high = 'Seg3';
run;

/* proc print data = sasprg1.adw_employees;
	format salary sal_segment.;
run;
*/
proc freq data = sasprg1.adw_employees;
	table salary;
	format salary sal_segment.;
	table hire_date;
	format hire_date date11.;
run;

/* Contigency table */
/* Cross Tab */

/* 1st we need to sort the table using by statement */


proc sort data = sasprg1.adw_employees;
	by gender;
run;

/* proc freq with format */
proc format;
	value sal_segment
		low -< 30000 = 'Seg1'
		30000 -< 50000 = 'Seg2'
		50000 - high = 'Seg3';
run;
proc freq data = sasprg1.adw_employees order = freq;
	by gender;
	table gender / missing /* nocum */;
	table marital_status;
run;
/* another method */
proc format;
	value sal_segment
		low -< 30000 = 'Seg1'
		30000 -< 50000 = 'Seg2'
		50000 - high = 'Seg3';
run;
proc freq data = sasprg1.adw_employees order = freq;
	table gender * salary ;/* nocum /nocol /norow */
	format salary sal_segment.;
	table marital_status;
run;
 /* unpivoted */
proc format;
	value sal_segment
		low -< 30000 = 'Seg1'
		30000 -< 50000 = 'Seg2'
		50000 - high = 'Seg3';
run;
proc freq data = sasprg1.adw_employees order = freq;
	table gender * salary / list ;/* nocum /nocol /norow */
	format salary sal_segment.;
	table marital_status;
run;

/* summarize numeric data */
proc means data = sasprg1.adw_employees /* more statictical params are availbe here https://documentation.sas.com/doc/en/pgmsascdc/9.4_3.5/prochp/prochp_hpsummary_syntax03.htm;*/;
	var salary;
run;


/* combining with by statement - cross tab */
proc sort data = sasprg1.adw_employees;
	by gender;
run;
proc means data = sasprg1.adw_employees /* more statictical params are availbe here https://documentation.sas.com/doc/en/pgmsascdc/9.4_3.5/prochp/prochp_hpsummary_syntax03.htm;*/;
	by gender;
	var salary;
run;
/* unpivoted */
proc means data = sasprg1.adw_employees /*/nonobs*/ ;
	class gender marital_status /missing ;
	var salary;
	format gender $mfmap.;
run;

/* Univariate analysis */
/* statistical tests */

proc univariate data = sasprg1.adw_employees;
	var salary;
run;

