data sample;
	do i = 1,2,3;
		output;
	end;
run;


data sample;
	do i = 0 to 100 by 10;
		output;
	end;
run;

/* reverse order */
data sample;
	do i = 100 to 1 by -1;
		output;
	end;
run;

libname sasprg1 "/home/u61606629/sasuser.v94/SASPRG1";

data sample;
	
	set sasprg1.cdinvest;
	captial = 5000;
	do i = 1 to months;
		captial = captial  + (annualrate/12)*captial;
	end;
	drop i;
	format captial dollar11.5;
	
	
run;

proc print data = sample(obs = 10);
run;

/* do while loop */

data _null_; /*  no data set will be created */
	i = 0;
	do while(i<10);
		i = i+1;
		put i=; /* put is also used to print to log */
		
	end;
run;


data bank;
	capital = 5000;
	time = 1;
	do while(capital<=1000000);
		capital = capital + (capital*0.045);
		time = time + 1;
		put capital=;
	end;
	put capital= time=;
	
run;


data bank;
capital = 0;
time = 0;
	do until(capital>1000000);
		time = time  +1;
		capital= capital + 5000;
		capital = capital + (capital*0.045);
		put capital=;
		
	end;
	put capital= time=;
run;

data bank;
	capital = 0;
	do time = 1 to 30 while(capital<250000);
		capital = capital + 5000;
		capital = capital+(0.045*capital);
	end;
run;
		
		
data bank;
capital = 0;
	do year = 1 to 5;
		capital = capital + 5000;
		do qtr = 1 to 4;
			capital = capital + (capital * (0.045)/4);
		end;
		output;
	end;
run;

libname sasprg1 "/home/u61606629/sasuser.v94/SASPRG1";

data banks;
	set sasprg1.banks;
	capital = 0;
	do year = 1 to 5;
		capital = capital + 5000;
		do qtr = 1 to 4;
			capital = capital + (capital * rate/4);
		end;
	end;
run;
	