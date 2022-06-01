data house_price;
infile "/home/u61606629/datasetlearnersas/houseprice (2).txt";
input type$ amount tax;
run;

proc sort data = house_price out = house_price1;
by descending amount;
run;

data new_house_price;
infile "/home/u61606629/datasetlearnersas/newhomes (2).txt";
input type$ amount tax;
run;

proc sort data = new_house_price out = new_house_price1;
by descending amount ;
run;


/*proc sql;
select * from house_price
union
select * from new_house_price; */


DATA All_details;
MERGE house_price1 new_house_price1;
BY descending amount;
RUN;

/* set can also used to merge data but column names and datatypes has to be uniform */
DATA All_details;
set house_price1 new_house_price1(rename = (tax = tax));
RUN;

/* proc sort data = All_details out = All_details;
by descending amount;
run;*/


/* Select certain columns in dataset */
data new;
set all_details;
keep type tax;
run;

/* Drop certain columns */

data new;
set all_details;
drop type tax;
run;


/* Cleaning Data*/

data new;
set all_details;
rename tax = rate amount = final_price;
run;


/*  Giving label names to columns */
data new;
set new;
label rate = 'Rate of Tax' final_price = 'Amount to be paid', type = 'Type of Home';
run;

proc freq data = new;
table rate final_price type; /* frequency of occurance for each items in the columns*/
run;