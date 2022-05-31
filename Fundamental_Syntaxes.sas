/* Data step is a primary method for creating and manipulating a data set 
It is simply a group of SAS language statements eg INPUT, INFILE, CARDS etc*/
/* Create Data Maually */
data personnel;
input age gender$;
datalines;
46 F
95 M
;
proc print personnel;
title "Bishwa's Report";
run;

/* Proc aka procedure steps is used to analyse and process datasets to produce statistical reports, charts and plots */
proc print data = mydata;
run;
