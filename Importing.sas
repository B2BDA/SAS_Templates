*Importing a txt file ;

data salary;
infile "/home/u61606629/datasetlearnersas/salary (2).txt";
input year salary;
run;

*Importing a csv file ;
* DSD basically helps us in detecting missing values like 'a',,'b', here there is a missing value between a and b and also removes quotation marks around them;
* MISSOVER scans the data and see if there are missing values and records them;
* FIRSTOBS means skip the n rows from where the data starts. Since n-1 row must be column names;
* $ to indicate they are chars. SAS can detect numerical but not char unless $ is mentioned;
data weight_gain;
infile "/home/u61606629/datasetlearnersas/weightgain (2).csv" DSD missover FIRSTOBS=2;
input id source$ type$ weightgain;
run;

*Importing a xlsx file or dataset;
proc import out = salesdata datafile="/home/u61606629/datasetlearnersas/Sample-Sales-Data (3).xlsx" DBMS = XLSX;
run;

* More options;
proc import out = salesdata datafile="/home/u61606629/datasetlearnersas/Sample-Sales-Data (3).xlsx" DBMS = XLSX REPLACE;
SHEET = "Sheet1";
DElimiter = ',';
* 1st row as col names;
getnames = YES;
* If we feel that a column might have mixed datatypes we can use mixed = yes which tells SAS to read the column as string;
MIXED = YES;
* or we can use RANGE = "Sheet1";
run;
