data dates;
	today = today();/* days past since Jan 1st, 1960*/
	datetime = datetime();
	time = time();
	datepart = datepart(datetime);
	sample_date = '15dec1995'd; /* always append a d at the end to indicate date */
	sample_datetime = '15dec1995:18:18:18'dt ;/* dt means date time */
	sample_time = '18:18:18't;
	extract_month = month(datepart(datetime));
	format today date11. datetime datetime20. time time. datepart date9. sample_date date9. sample_datetime datetime20. sample_time time.;
run;


/* date strings to dates */
/* when to use put and input - https://subaiwen.github.io/sas-put-input/#:~:text=PUT()%20converts%20character%20variable%20with%20a%20user%20defined%20format,informat%20to%20a%20numeric%20variable. */

data dates;
	sample_date = '15dec1995'; 
	sample_datetime = '15dec1995:18:18:18';
	sample_time = '18:18:18';
	date1 = input(sample_date, date9.);
	date0 = put(date1, date9.);
	date_t1 = input(sample_datetime, datetime20.);
	date_t0 = put(date_t1, datetime20.);
	time_t1 = input(sample_time, time.);
	time_t0 = put(time_t1, time.);
	mon_name = put(date1, $monname.);
	
run;

/* find difference between two dates */
/* https://documentation.sas.com/doc/en/vdmmlcdc/8.11/lefunctionsref/p0syn64amroombn14vrdzksh459w.htm */

data age;
	dob = '15dec1995'd;
	today = today();
	age_in_yrs = intck('year',dob,today);
	format dob date11. today date11.;
run;

/* add or sub interval from a date */

data age;
	dob = '15dec1995'd;
	age_in_yrsb = intnx('year',dob,27,'B');
	age_in_yrss = intnx('year',dob,27,'S');
	age_in_yrse = intnx('year',dob,27,'E');
	/* S = same day B = Begining of the year(Default) E = End of the year M = Middle of the year */
	format dob date11. age_in_yrsb date11. age_in_yrss date11. age_in_yrse date11.;
run;

/* find date diff and year diff */
/* datdif is also availbe */
data age;
	dob = '15dec1995'd;
	today = today();
	age_in_yrs = yrdif(dob,today,'act/act');
	age_in_yrs = yrdif(dob,today,'act/360');
	format dob date11. today date11.;
run;
