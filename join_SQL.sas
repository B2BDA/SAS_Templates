data table;
lenght name$ 50 email$ 50;
input name$ email$;
cards;
Ryan ryan@gmail.com
Sammy sammy@fbi.us.com
Gigi gigi@nypd.com
;
run;

data table1;
lenght name$ 50;
input name$ salary;
cards;
Ryan 1000
Sammy 1000
Gigi .

;
run;


data table2;
lenght name$ 50;
input name$ dob$date11.;
dob = put(dob, date11.);
cards;
Ryan 15-12-1995
Sammy 15-12-1995
Gigi 15-12-1995

;
run;

proc sql;
select a.*, b.salary, c.dob from table a inner join table1 b on a.name = b.name
inner join table2 c on a.name = c.name
where b.salary is not null;
quit;





data statesstats;
  length state $ 25 ;
  input State Zone$ Unemp;
cards;
Alabama S 6.0 
Arizona S 6.4 
Arkansas S 5.3 
California W 8.6 
Colorado W 4.2 
Connecticut E 5.6 
Delaware E 4.9 
Florida S 6.6 
Georgia S 5.2 
Idaho N 5.6 
;
run;

data statesstats2;
  length state $ 25 ;
  input State Wage Crime Income;
cards;
Alabama 10.75 780 27196 
Arizona 11.17 715 31293 
Arkansas 9.65 593 25565 
California 12.44 1078 35331
Colorado 12.27 567 37833 
Connecticut 13.53 456 41097 
Delaware 13.90 686 35873
Florida 9.97 1206 29294
Georgia 10.35 723 31467
Idaho 11.88 282 31536 
;
run;

proc sql;
select a.*, b.wage, b.crime, b.income from statesstats a inner join statesstats2 b on a.state = b.state;
quit;