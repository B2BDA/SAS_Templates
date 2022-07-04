data cars;
	set sashelp.cars;
	avgmpg = mean(mpg_city, mpg_highway);
run;

proc means data = cars;
	var mpg_city mpg_highway;
	
	output out = mpg_means;
run;

proc print data = mpg_means;
run;

proc print data = cars;
	var  make model type avgmpg;
	where avgmpg>35;
run;

title "AVG MPG by Car Type";

proc means data = cars mean min max maxdec = 1;
	class type;
	var avgmpg;
run;

/*when we want to remove duplicates based on a particular column then all duplicate obs will be removed from the entre data set */
proc sort data = sashelp.cars nodupkey out = sample_cars ;
	by type;
run;

proc contents data = sample_cars;
run;

/*when we want to remove row duplicates */
proc sort data = sashelp.cars nodupkey out = sample_cars ;
	by _all_;
run;

proc contents data = sample_cars;
run;

/*https://communities.sas.com/t5/SAS-Programming/Difference-between-NOdup-and-NoDupkey/td-p/29490*/
proc sort data = sashelp.cars nodup out = sample_cars ;
	by type;
run;

proc contents data = sample_cars;
run;


/* Graphs in sas */
ods graphics on;
ods noproctitle;
title "Some Sample Report";
proc sort data = sashelp.cars out= cars;
	by type;
run;
proc freq data = cars order=freq;
	by type;
	table make / plots = freqplot(orient = horizontal scale = percent);
	label type = "Car Type" make = "Company";
run;

/* two way freq table  - crosstab */
proc freq data = cars order=freq;
	by type ;
	table make* origin / crosslist;
	label type = "Car Type" make = "Company";
run;

/* seperate mean tables - summary */
proc means data = cars;
	var msrp;
	class type make;
	ways 1 /*2 means combined table like cross list */;
run;

