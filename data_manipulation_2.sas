/* Data Manipulation */
/* Output statement to write SAS dataset */
libname sasprg1 "/home/u61606629/sasuser.v94/SASPRG1";

data emp_smp;
	set sasprg1.adw_employees;
	where job_title contains 'Production Technician' and salary is not null;

	format salary dollar10.;
	year = 2018;
	output; /* prints obs in memory (PDV product data vector). If another output; is mentioned, again same row will be printed. Since PVD process one row at a time */
	year  = 2019;
	salary = (salary * 0.05) + salary;
	keep employee_id job_title salary year;
	output;
run;

proc print data = emp_smp;
run;

/* create multiple datasets using output statements */
libname sasprg1 "/home/u61606629/sasuser.v94/SASPRG1";

data male(keep = employee_id gender salary) female(keep =  employee_id gender salary) others (keep = employee_id gender salary);
	set sasprg1.adw_employees(firstobs=2 obs= 100); /* data will be read from the 2nd obs till 102 */
	if gender = 'M' then output male;
	else if gender = 'F' then output female;
	else output others;
	
run;

proc print data = male (obs = 5);
run;
proc print data = female;
run;
proc print data = others;
run;


libname sasprg1 "/home/u61606629/sasuser.v94/SASPRG1";

data male female others ;
	set sasprg1.adw_employees(firstobs=2 obs= 100 keep = employee_id gender salary job_title rename = (salary = salary_) where = (job_title contains 'Production Technician')); /* data will be read from the 2nd obs till 102 */
	if gender = 'M' then output male;
	else if gender = 'F' then output female;
	else output others;
	
run;

proc print data = male (obs = 5);
run;
proc print data = female;
run;
proc print data = others;
run;