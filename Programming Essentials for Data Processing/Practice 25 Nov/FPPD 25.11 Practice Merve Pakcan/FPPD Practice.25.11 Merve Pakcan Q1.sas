libname pg2 "/export/viya/homes/merve.pakcan@stud.acs.upb.ro/Courses/PG2V2/data";

/* Task 1 : Conditionally Creating Columns and Output Tables */
/* Creating CAMPING table with CampTotal for rows where CampTotal > 0 */
data camping;
	set pg2.np_2017;
	CampTotal=sum(CampingOther, CampingTent, CampingRV, CampingBackcountry); /* Calculating CampTotal by summing camping-related columns */
	if CampTotal > 0;
	format CampTotal comma12.; /* Applying comma format */
	keep ParkName Month DayVisits CampTotal;  /* Keeping specified columns */
run;

/* Creating LODGING table for rows where LodgingOther > 0 */ 
data lodging;
	set pg2.np_2017;
	where LodgingOther > 0;
	keep ParkName Month DayVisits LodgingOther; /* Keeping specified columns */
run;

/* Checking the row counts */
proc print data=camping n;
    title "Camping Table Row Count and Data";
run;
/* Camping table has 1374 rows */

proc print data=lodging n;
    title "Lodging Table Row Count and Data";
run;
/* Lodging table has 383 rows */
