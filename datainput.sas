/* Various Data input */
/* Use period or . for missing values */
data abc;
lenght name$10;
input name$ age;
cards;
Bishwarup 27
Rina .
Bikash 60
;
run;

data london;
infile "/home/u61606629/datasetlearnersas/londonoutcomes.csv" DSD MISSOVER FIRSTOBS=2;
length Crime_ID$100	Reported_by$100 Falls_within$100 Longitude$100 Latitude$100 Location$100 LSOA_code$100 LSOA_name$100 Outcome_type$100;
input Crime_ID$	Reported_by$ Falls_within$ Longitude$ Latitude$ Location$ LSOA_code$ LSOA_name$ Outcome_type$;
run;

/* custom formatting */
data icd;
input icd10codes$;
cards;
100
099
223
097
101
;
run;
proc print data = icd;
run;

/* creating a keyvalue pair */
proc format;
value $codedesc
'100' = 'Diabetes'
'099','097' = 'Lung Cancer'
'223' = 'BP'
;
run;

proc print data = icd;
format icd10codes $codedesc.;
run;

/* show both key and values */
data icd_1;
set icd;
ds_cd = put(icd10codes, $codesdesc.);
run;
proc print data = icd_1;
run;

/* put takes in numeric and convert to char var while input takes character and converts into numeric*/