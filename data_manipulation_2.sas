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
