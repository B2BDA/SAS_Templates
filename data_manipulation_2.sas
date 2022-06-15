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

/* running aggregate varaibles */
data test;
	do i = 1 to 10;
		output;
	end;
run;

proc print data = test;
run;

data test1;
	set test;
		retain sum 0; /* retain value of a variable and initialize with zero*/
		sum = sum + i;
		output;
run;


libname sasprg1 "/home/u61606629/sasuser.v94/SASPRG1";
data sample;
	set sasprg1.aprsales;
	informat saledate date11;
	format saledate date11. saleamt dollar11. cum_saleamt dollar11.;
	retain cum_saleamt 0;
	cum_saleamt = cum_saleamt + saleamt;
run;

proc print data = sample;
run;

/* doing the same with sum function */

libname sasprg1 "/home/u61606629/sasuser.v94/SASPRG1";
data sample;
	set sasprg1.aprsales;
	informat saledate date11;
	format saledate date11. saleamt dollar11. cum_saleamt dollar11.;
	retain cum_saleamt;
	cum_saleamt = sum(cum_saleamt,saleamt);
run;

proc print data = sample;
run;


/* Partition by sum */
proc sort data = sasprg1.specialsals out = salsort;
	by dept;
run;

data sample;
	set salsort;
	by dept;
	put _all_; /* check the internal sas variables */
	/* first.var_name =1 means a group starts and last.var_name =1 means a group ends here */
	retain deptsal 0;
	if first.dept = 1 & last.dept = 0  then do;
	deptsal = salary; 
	*put deptsal = deptsal + salary;
	end;
	else if first.dept = 0 & last.dept = 0 then deptsal = deptsal + salary;
	else if first.dept = 0 & last.dept = 1 then deptsal = deptsal + salary;
	else deptsal = 0;
	
	*if last.dept = 1 then output;
	
run;

proc print data = sample;
run;
/* accumulating total with more than one group */

proc sort data = sasprg1.projsals out = sorted;
	by dept proj;
run;

data sample;
	set sorted;
	by dept proj;
	put _all_;
	retain depsal 0;
	retain projsal 0;
	/* fd = first.dept;
	ld = last.dept;
	fp = first.proj;
	lp = last.proj; */
	if first.dept = 1 & last.dept = 0  then do;
		depsal = salary;
		if first.proj = 1 & last.proj = 0 then
			projsal = salary;
		else if first.proj = 0 & last.proj = 0 then
			projsal = projsal + salary;
		else if first.proj = 0 & last.proj = 1 then
			projsal = projsal + salary;
		else projsal = salary;
		
	end;
	else if first.dept = 0 & last.dept = 0 then do;
		depsal = salary + depsal;
		if first.proj = 1 & last.proj = 0 then
			projsal = salary;
		else if first.proj = 0 & last.proj = 0 then
			projsal = projsal + salary;
		else if first.proj = 0 & last.proj = 1 then
			projsal = projsal + salary;
		else projsal = salary;
		end;
	else if first.dept = 0 & last.dept = 1 then do;
		depsal = salary + depsal;
		if first.proj = 1 & last.proj = 0 then
			projsal = salary;
		else if first.proj = 0 & last.proj = 0 then
			projsal = projsal + salary;
		else if first.proj = 0 & last.proj = 1 then
			projsal = projsal + salary;
		else projsal = salary;
		end;
	else depsal = salary;
	
run;

proc print data = sample;
run;
