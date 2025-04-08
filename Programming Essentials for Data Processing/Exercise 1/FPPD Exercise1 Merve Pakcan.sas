libname pg1 '/export/viya/homes/merve.pakcan@stud.acs.upb.ro/Courses/PG1V2/data';

%let dataset = pg1.np_species ;
%let category = Mammal;
%* %let category = Bird; /* Uncomment this line to analyze the Bird category */

data mammal;
	set &dataset;
	where Category = "&category";
	keep Species_ID Category Family Scientific_Name Common_Names Record_Status Occurrence Nativeness;
run;

proc freq data=mammal;
	tables Record_Status; 
run;
/* 90.63% of mammal species have a Record_Status of "Approved." */
/* 96.22% of Bird species have a Record_Status of "Approved". */