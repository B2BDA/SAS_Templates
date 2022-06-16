data sample;
	phone= "+91 8017298764";
	phone_isd_code = substr(phone, 1,3);
	phone_num = substr(phone,5);
	/* Trailing spaces are ignored in lenght but leading spaces are not ignored */
	code = "ABCD ";
	code_len = length(code);
	code0 = "  ABCD";
	code_len0 = length(code0);
run;



libname sasprg1 "/home/u61606629/sasuser.v94/SASPRG1";

data sample;
length org_id $ 5 ;
	set sasprg1.biz_list;
	org_id = substr(acct_code,1,length(acct_code)-1);
	if substr(acct_code,length(acct_code)) = '2'
		then output;
	
	
run;

proc print data = sample;
run;


data sample;
	set sasprg1.contacts;
	first_name = scan(Name,2,',');
	last_name = scan(Name,1,',');
	full_name = catx(' ',title, first_name,last_name);
	full_add = catx(' ', address1, address2);
	drop first_name last_name;

run;

proc print data = sample(obs = 10);
run;
