data cars;
	set sashelp.cars;
run;

proc print data = cars;
run;

/* creation of report for SUV*/

proc sql;
create table SUV_summary as
select type, origin, count(*) as num_units,
sum(msrp) as total_msrp,
sum(invoice) as total_invoice from cars
where UPPER(type) = 'SUV'
group by 1,2;
run;

proc print data = SUV_summary;
run;

/* Macro Script */
/* to create report for any car of choice, we need to parameterize the SQL query */
/* start macro with %macro <macro name>(params)
then at the end use %mend.
Whatever we want to parameterize, we can basically pass that var name in the param of the macro initilization and make sure the var name in the code starts with an & and end with a '.'*/
%macro car_summary_automation(car_type) ;
proc sql;
create table &car_type._summary as
select type, origin, count(*) as num_units,
sum(msrp) as total_msrp,
sum(invoice) as total_invoice from cars
where UPPER(type) = UPPER("&car_type.")
group by 1,2;
quit;


proc print data = &car_type._summary;
run;

%mend;
%car_summary_automation(Sedan);
%car_summary_automation(Suv);
%car_summary_automation(Sports);
%car_summary_automation(Truck);
%car_summary_automation(Hybrid);
%car_summary_automation(Wagon);

/* assign a macro variable */
/* These are global macros */
/* macro variable convert any datatype data into chars */
%let num1 = 10;
%let num2 = 20;
%let name = BOTD4TH;
/* print the macro vals in log */
%put &num1.;
%put &name.;

data sample;
	res = &num1. + &num2.;
run;

proc print data = sample;
run;

/* local marcro are defined inside a macro script */
%macro sample;
%let var1 = 10;
data sample_data;
	var1 = &var1. + 10;
run;
proc print data = sample_data;
run;
%mend;

%sample;

data all_cars_sum;
	set work.hybrid_summary work.sedan_summary work.sports_summary work.suv_summary work.truck_summary work.wagon_summary;
run;

%let num_unit = 94,10;
data sample;
	set all_cars_sum;
	where num_units in (&num_unit.);
run;


%macro unit_check(num_unit);
data sample;
	set all_cars_sum;
	where num_units in (&num_unit.);
run;
proc print data = sample;
quit;; run;
%mend;
%let num_unitz = 94;
%unit_check(&num_unitz.);



/* PROC SQL MACRO */
/* First storing all the values in one macro varaible */
proc sql noprint;
select num_units into: units SEPARATED  by ','
from work.sample;
quit;

%put &units.;

data testing;
	set all_cars_sum;
	where num_units in (&units.);
run;

/* call symput routine to assing a macro variable in data step*/

data _null_;
	call symput('units',94);
run;

data testing;
	set all_cars_sum;
	where num_units in (&units.);
run; 

proc print data = testing;
run;


/* if then do using macro */

%macro auto_rep(car_type);
%IF &car_type. = "SUV" %THEN %DO;
%put &car_type.;
proc sql;
create table car_summary as
select type, origin, count(*) as num_units,
sum(msrp) as total_msrp,
sum(invoice) as total_invoice from cars
where UPPER(type) = &car_type.
group by 1,2;
run;
%END;
%ELSE %DO;
proc sql;
create table car_summary as
select type, origin, count(*) as num_units,
avg(Horsepower) as avg_hp,
sum(invoice) as total_invoice from cars
where UPPER(type) not in (&car_type.)
group by 1,2;
run;
%END;
%mend;
%auto_rep("Hybrid");
/* %STR functions in SAS */
/* %STR(any thing's) helps us print with quotes, %STR(any sas code can be printed as well with ; it supports special chars and nemonics like ge, ne) */
/* also helps in trailing and leading space */

%let boom = %str(This is a good dog. I like it%'s name.);
%put &boom.;

%let code = %str(proc means; run;);
%put &code.;


/* %EVAL helps in performing logical and mathametical operation in macro variables */
%let a = 10;
%let b = 20;
%let c = %eval(&a. * &b.);
%put &c.; 

/* %SYSFUNC helps in using many SAS base function in macros */
%let name  = Bishwarup Biswas;
%let idx = %index(&name.,%str( )); /* white spaces are not determined directly do we neeed to use %str( ) */
%let lname = %sysfunc(substr(&name.,&idx.));
%let fname =%sysfunc(substr(&name.,1,1));
%let signature = %sysfunc(catx(.,&fname.,&lname.));
%put &signature.;


/* options to debug sas macro */
/* mprint mlogic symbolgen */
/* mprints translates the macro code to SAS code for debuggin */
/* print a parameterized macro with values inserted */
options mprint;
%macro check_freq(data,var, origin);
proc freq data = &data.;
	table &var.;
	where origin = &origin.;
run;
%mend;
%check_freq(sashelp.cars,type, "USA");

/* mlogic helps to see which part of the macro is getting resolved */
option mprint mlogic;
%macro auto_rep(car_type);
%IF &car_type. = "SUV" %THEN %DO;
proc sql;
create table car_summary as
select type, origin, count(*) as num_units,
sum(msrp) as total_msrp,
sum(invoice) as total_invoice from cars
where UPPER(type) = &car_type.
group by 1,2;
run;
%END;
%ELSE %DO;
proc sql;
create table car_summary as
select type, origin, count(*) as num_units,
avg(Horsepower) as avg_hp,
sum(invoice) as total_invoice from cars
where UPPER(type) not in (&car_type.)
group by 1,2;
run;
%END;
%mend;
%auto_rep("SUV");

/* symbolgen helps to see what the macro resolves to */

option symbolgen;
%macro auto_rep(car_type);
%IF &car_type. = "SUV" %THEN %DO;
proc sql;
create table car_summary as
select type, origin, count(*) as num_units,
sum(msrp) as total_msrp,
sum(invoice) as total_invoice from cars
where UPPER(type) = &car_type.
group by 1,2;
run;
%END;
%ELSE %DO;
proc sql;
create table car_summary as
select type, origin, count(*) as num_units,
avg(Horsepower) as avg_hp,
sum(invoice) as total_invoice from cars
where UPPER(type) not in (&car_type.)
group by 1,2;
run;
%END;
%mend;
%auto_rep("SUV");
/* if we are using any macro variable for comparions we should use double quotes */