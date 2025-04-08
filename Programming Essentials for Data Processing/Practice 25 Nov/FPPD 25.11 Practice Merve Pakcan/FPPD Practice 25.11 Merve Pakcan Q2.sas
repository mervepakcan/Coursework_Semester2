libname pg2 "/export/viya/homes/merve.pakcan@stud.acs.upb.ro/Courses/PG2V2/data";
/* Task 2 : Producing a Running Total */
data work.traffic_running_total(keep=ParkName Location Count totTraffic);
    set pg2.np_yearlytraffic; /* Reading input dataset */
    retain totTraffic 0; /* Starting at zero */
    totTraffic + Count; /* Updating running total */
    format totTraffic comma12.; /* Formatting the running total with commas */
run;

/* Checking the results */
proc print data=work.traffic_running_total noobs;
run;

/* Output saved in WORK library due to no write access to PG2. */