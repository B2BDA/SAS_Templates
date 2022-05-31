data salary(keep = salary rename = salary = salaryemp);
infile "/home/u61606629/datasetlearnersas/salary (2).txt";
input year salary;
run;

/* obs means how many obs to show like .head() in python */
proc print data = salary(obs = 3);
run;

/*firstobs = n , n = the row number. So the dataset will be printed from nth row */
proc print data = salary(firstobs = 3 obs = 4);
run;