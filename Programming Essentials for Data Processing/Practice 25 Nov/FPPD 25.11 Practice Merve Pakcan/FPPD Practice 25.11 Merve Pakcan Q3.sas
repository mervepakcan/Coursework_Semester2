libname pg2 "/export/viya/homes/merve.pakcan@stud.acs.upb.ro/Courses/PG2V2/data";

/* Task 3 : Producing Multiple Totals */
/* Creating the parkTypeTraffic table */
data parkTypeTraffic;
    set pg2.np_yearlytraffic;
    /* Reading only rows for National Monument and National Park */
    if ParkType in ('National Monument', 'National Park') then do;
        /* Creating new columns named MonumentTraffic and ParkTraffic */
        if ParkType = 'National Monument' then MonumentTraffic + Count;
        if ParkType = 'National Park' then ParkTraffic + Count;
    end;
    /* Formatting new columns for comma-separated values */
    format MonumentTraffic ParkTraffic comma10.;
run;

/* Creating a listing report with the specified title and column order */
title "Accumulating Traffic Totals for Park Types";
proc print data=parkTypeTraffic noobs;
    var ParkType ParkName Location Count MonumentTraffic ParkTraffic;
run;

/* The first row with a nonzero value for MonumentTraffic is row 51 */
/* The value of ParkTraffic in row 10 is 1,538,476 */