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
