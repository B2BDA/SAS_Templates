/* union datasets or concatenating dataset using set */
data cities_US;
input city $ 1-10 location 11 
	  country $ 13-20 population 21-23;
datalines;
New York  1 USA     8.5
Cary      1 USA     0.2
Chicago   1 USA     2.7
Boston    1 USA     0.7
;
run;

proc print;

data cities_Canada;
input city $ 1-10 location 11 
	  country $ 13-20 population 21-23;
datalines;
Vancouver 2 CANADA  0.7
Toronto   2 CANADA  2.8
Montreal  2 CANADA  1.7
;
run;

proc print;

data cities_Asia;
input city $ 1-10 location 11 
	  country $ 13-20 population 21-23;
datalines;
Hong Kong 3 ASIA    7.3
Tokyo     3 ASIA     14
Beijing   3 ASIA     22
Shanghai  3 ASIA     24
;
run;

proc print;


data big_d;
	set cities_US cities_Canada cities_Asia;
run;

proc print data = big_d;
run;


data cities_US;
input city $ 1-10 location 11 
	  country $ 13-20 population 21-23;
datalines;
New York  1 USA     8.5
Cary      1 USA     0.2
Chicago   1 USA     2.7
Boston    1 USA     0.7
;
run;

proc print;

data cities_Canada;
input city $ 1-10 location 11 
	  country $ 13-20 population 21-23;
datalines;
Vancouver 2 CANADA  0.7
Toronto   2 CANADA  2.8
Montreal  2 CANADA  1.7
;
run;

proc print;

data all_cities;
	set cities_US cities_Canada;
run;

proc print;

/***********/
data cities_US;
input city $ 1-10 location 11 
	  cntry $ 13-20 pop 21-23;
datalines;
New York  1 USA     8.5
Cary      1 USA     0.2
Chicago   1 USA     2.7
Boston    1 USA     0.7
;
run;


data cities_Canada;
input city $ 1-10 location 11 
	  country $ 13-20 population 21-23;
datalines;
Vancouver 2 CANADA  0.7
Toronto   2 CANADA  2.8
Montreal  2 CANADA  1.7
;
run;



data all_cities;
	set cities_US(rename = (cntry = country pop = population)) cities_Canada;
run;
proc print;

/* when data types are not same */
data cities_US;
input city $ 1-10 location 11 
	  country $ 13-20 population 21-23;
datalines;
New York  1 USA     8.5
Cary      1 USA     0.2
Chicago   1 USA     2.7
Boston    1 USA     0.7
;
run;

proc print;

data cities_Canada;
input city $ 1-10 location $ 11 
	  country $ 13-20 population 21-23;
datalines;
Vancouver 2 CANADA  0.7
Toronto   2 CANADA  2.8
Montreal  2 CANADA  1.7
;
run;

proc print;

data cities_Canada_2(drop = location_temp);
	set cities_Canada(rename  = (location = location_temp));
	location = input(location_temp,11.);
run;
/* difference between length and format - https://stackoverflow.com/questions/39611438/the-difference-between-format-and-length-in-sas#:~:text=Informat.,assigned%20to%20store%20variable%20information. */
data big_d;
	length country $ 11;
	set cities_US(in=in_US) cities_Canada_2(in=in_Can);
	if in_US = 1 then countrY = 'US';
	else Country = "canada";
run;

proc print data = big_d;
run;


/* Concatenate data using proc append */
proc append 
base = cities_Canada_2 
data = cities_US force;
run;
proc print;

/* Merge two data - join operation*/

data math;
input id name $ gender $;
datalines;
1  Anderson  M
2  Catalina  F
3  Diego     M
4  Giovany   M
5  Cristian  M
6  Leidy     F
7  Claudia   M
;
run;


data english;
input id name $ gender_mod $;
datalines;
2  Catalina F
4  Giovany  M
8  Dario    M
9  Kelly    F
5  Cristian M
10 Yimmy    M
;
run;



proc sort data = math out=math;
by id;
run;

proc sort data = english out=english;
by id;
run;

data inner left right full_outer only_right only_left not_common;
	merge math(in=in_ma) english(in=in_eng);
	by id;
	if in_ma = 1 & in_eng = 1 then output inner;
	if in_ma = 1 then output left;
	if in_eng = 1 then output right;
	if in_ma = 1 or in_eng = 1 then output full_outer;
	if not in_ma = 1 and in_eng = 1 then output only_right;
	if in_ma = 1 and not in_eng = 1 then output only_left;
	if not (in_ma = 1 and in_eng = 1 ) then output not_common;
	
	
	
run;

proc print data = inner;
run;
proc print data = left;
run;
proc print data = right;
run;
proc print data = full_outer;
run;
proc print data = only_right;
run;
proc print data = only_left;
run;
proc print data = not_common;
run;