data info1;
input empid$ fname$ height;
cards;
01 AA 10
02 BB 11
03 CC 12
;
run;

data info2;
input empid$ fname$ height;
cards;
01 AA 10
02 BB 11
03 CC 12
04 XX 99
05 DD 25
;
run;

proc sql;
select * from info2 
except
select * from info1 
quit;