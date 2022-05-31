data house_price;
infile "/home/u61606629/datasetlearnersas/houseprice (2).txt";
input type$ amount tax;
run;

proc sort data = house_price out = house_price1;
by amount;
run;

data new_house_price;
infile "/home/u61606629/datasetlearnersas/newhomes (2).txt";
input type$ amount tax;
run;

proc sort data = new_house_price out = new_house_price1;
by amount ;
run;


/*proc sql;
select * from house_price
union
select * from new_house_price; */


DATA All_details;
MERGE house_price1 new_house_price1;
BY amount;
RUN;

proc sort data = All_details out = All_details;
by descending amount;
run;