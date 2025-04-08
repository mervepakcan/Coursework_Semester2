/* Accessing Excel file with using PROC IMPORT METHOD */
proc import datafile="/export/viya/homes/merve.pakcan@stud.acs.upb.ro/casuser/sample_data_XLSX.xlsx"
dbms=xlsx
out=data_course replace;
sheet=Sheet1;
getnames=yes;
run;

proc print data=data_course;
run;

/* Accessing CSV file with using PROC IMPORT METHOD */
proc import datafile="/export/viya/homes/merve.pakcan@stud.acs.upb.ro/casuser/sample_data_CSV.csv"
dbms=csv
out=data_course_2 replace;
getnames=yes;
guessingrows=400 ;
run;

proc contents data=data_course_2;
run;

