data large_dataset;
y = 1;
do i = 1 to 8000000;
x = i+1;
y = y+x;
z = y+4;
if mod(i,4) = 1 then txt = 'M';
if mod(i,4) = 2 then txt = 'N';
if mod(i,4) = 3 then txt = 'O';
if mod(i,4) = 0 then txt = 'P';
output;
end;
run;


proc sql;
create table noindex as 
select * from large_dataset where x in (792286,486273,237838);
quit;

proc datasets library=work;
modify large_datset;
index create x;
quit;

proc sql;
create table index as 
select * from large_dataset where x in (792286,486273,237838);
quit;
/* **************** */

data sales;
length PRODUCTLINE$ 100  PRODUCTCODE$ 100 CUSTOMERNAME$ 100 PHONE$ 100 ADDRESSLINE1$ 100 ADDRESSLINE2$ 100 CITY$ 100 STATE$ 100 POSTALCODE$ 100 COUNTRY$ 100 TERRITORY$ 100 CONTACTLASTNAME$ 100 CONTACTFIRSTNAME$ 100 DEALSIZE$ 100;
infile "/home/u61606629/datasetlearnersas/099 sales.csv" dsd missover firstobs=2;
input ORDERNUMBER QUANTITYORDERED PRICEEACH	ORDERLINENUMBER	SALES STATUS$ QTR_ID MONTH_ID YEAR_ID PRODUCTLINE$ MSRP	PRODUCTCODE$ CUSTOMERNAME$ PHONE$ ADDRESSLINE1$ ADDRESSLINE2$ CITY$ STATE$ POSTALCODE$ COUNTRY$ TERRITORY$ CONTACTLASTNAME$ CONTACTFIRSTNAME$ DEALSIZE$;
run;

proc freq data = sales(keep = CUSTOMERNAME);
run; /*  this is to check if customername is a good candidate for index. Check if the $% lie between 1 - 15%*/

/* creating simple index using proc sql*/
proc sql;
create /*unique*/ index CUSTOMERNAME on sales;
quit;

/*  creating composite index */
proc sql;
create index compindex on sales(CUSTOMERNAME, ADDRESSLINE1);
quit;

proc sql;
select * from sales order by CUSTOMERNAME,ADDRESSLINE1;
quit;

data crimes;
length Crime_ID $100 Reported_by $100 Falls_within $100 Longitude 8 Latitude 8 Location $100 LSOA_code $100 LSOA_name $100 Outcome_type $100;
infile "/home/u61606629/datasetlearnersas/londonoutcomes.csv" dsd missover firstobs=2;

input Crime_ID$ Reported_by$ Falls_within$ Longitude Latitude Location$ LSOA_code$ LSOA_name$ Outcome_type$;
run;

proc freq data = crimes(keep = LSOA_code;);
run;

proc sql;
create index LSOA_code on crimes;
quit;


proc sql;
select * from crimes order by LSOA_code;
quit;


/* update master dataset with new dataset */
data master;
length DateofHire $11;
infile "/home/u61606629/datasetlearnersas/106 master.csv" dsd missover firstobs=2;
input DateofHire$date11. EmpID$	Gender$	Salary$;
run;


data main;
length DateofHire $11;
infile "/home/u61606629/datasetlearnersas/106 transactions.csv" dsd missover firstobs=2;
input DateofHire$date11. EmpID$	Gender$	Salary$;
run;


proc sql;
create index EmpID on master;
quit;

proc sql;
create index EmpID on main;
quit;

data master;
update master main;
by EmpID;
run;

proc print data = master;
run;