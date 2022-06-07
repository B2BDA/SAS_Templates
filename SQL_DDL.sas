data info1;
input empid$ fname$ height;
cards;
01 AA 10
02 BB 11
03 CC 12
;
run;

data info2;
input empid$ weight;
cards;
01 66
02 68
03 .
04 .
;
run;


proc sql;
title 'Final Table';
create table info0 as
select a.fname, b.weight, a.height, a.empid  'Employee ID' format$6. from info1 a full join info2 b 
on a.empid = b.empid;
select * from info0;
quit;


proc sql;
alter table info0
add total_bmi num label = 'Total_BMI' format = dollar8.;

proc sql;
update info0
set total_bmi = weight * height;

proc sql;
select * from info0;
quit;

proc sql;
alter table info0
modify total_bmi label = 'Tot_BMI';

proc sql;
select * from info0;
quit;


proc sql;
update info0
set weight = 99, height = 99
where weight is missing and height is missing;

proc sql;
select * from info0;
quit;


/* Create a blank table of an existing table with same col names and dtypes*/
proc sql;
title 'Blank Table';
Create table final like info0;
quit;

proc sql;
insert into final
select * from info0;

proc sql;
select * from final;
quit;

/* Another way to insert new data into table*/

proc sql;
insert into final
set fname = 'XX',
weight = 100,
height = 100,
empid = '1202',
total_bmi = weight * height;
proc sql;
select * from final;
quit;

proc sql;
delete from final
where weight = 99;

proc sql;
select * from final;
quit;
