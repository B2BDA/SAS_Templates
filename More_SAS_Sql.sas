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


/* custom sort */

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
select empid, fname, height from (select *, case when
fname = 'AA' then 1
when fname = 'BB' then 2
when fname = 'CC' then 3
when fname = 'DD' then 4
when fname = 'XX' then 0
else .
end as fnamesort
from info2)
order by fnamesort;
quit;

/* Dynamic value updation in SAS SQL */
proc sql;
update info2
set height = case
when fname = 'BB' then height + 10
when fname in ('XX','AA') then 
(case when height > 9 then height + 1
when height between 88 and 100 then height + 1
else height
end)
else height
end;
select * from info2;
quit;

