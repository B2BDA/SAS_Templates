data sample;
	phone= "+91 8017298764";
	ph = compress(phone,'+','s'); /* more examples here - https://documentation.sas.com/doc/en/pgmsascdc/v_006/lefunctionsref/n0fcshr0ir3h73n1b845c4aq58hz.htm */
	phone_isd_code = substr(phone, 1,3);
	phone_num = substr(phone,5);
	/* Trailing spaces are ignored in lenght but leading spaces are not ignored */
	code = "ABCD ";
	code_len = length(code);
	code0 = "  ABCD";
	code_len0 = length(code0);
run;

/* generate quality leads
drive acquisition
approval
onboarding
activation
account mngmt
reactivation
attrition
*/


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

/* using index */

data sample;
	set sasprg1.contacts;
	comma_pos = index(name, ',');
	first_name = substr(Name,comma_pos+1);
	last_name = substr(Name,1,comma_pos-1);
	full_name = catx(' ',title, first_name,last_name);
	full_add = catx(' ', address1, address2);
	drop comma_pos first_name last_name;
run;

proc print data = sample;
run;

/* compress function very useful functions for text handling */
/* extract only the street name from Add 1 */

data sample;
/*compress(field, what to remove, what to keep(optional)) */
/* https://sasexamplecode.com/how-to-efficiently-use-the-compress-function/ */.
/* ak - alphabet keep, a - alphabet, i - case insensitive, d - digit, dk - digit keep */ 
	set sasprg1.contacts;
	st_name = compress(address1,'','ak');
	b = compress(address1,'c32','i');
run;

proc print data = sample;
run;
