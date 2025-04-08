libname pg1 "/export/viya/homes/merve.pakcan@stud.acs.upb.ro/Courses/PG1V2/data";

/* Task 1 - Analyzing Park Types by Region */
/* Part a: Frequency table of Type by Region */
title; 
footnote;
title "Park Types by Region"; /* Setting the report title */

/* Sorts rows by frequency w/ order=freq */
proc freq data=pg1.np_codelookup order=freq;
    tables Type*Region / nocol norow nocum; /* Hiding percentages and cumulative stats */
    where not (Type contains "Other"); /* Excluding rows where Type contains 'Other' */
run;

/* Part b */
/* According to results, top three park types: National Historic Site (76), National Monument (69), National Park (59) */

/* Part c: Updated analysis for top three park types */
title "Selected Park Types by Region"; /* Updated report title */

proc freq data=pg1.np_codelookup order=freq;
    tables Type*Region / crosslist nocol nocum 
                         plots=freqplot(groupby=row scale=percent orient=horizontal); 
    where Type in ("National Historic Site", "National Monument", "National Park"); 
run;

/* Part d */
/* Intermountain region has the highest row percent overall, leading in National Monument (49.28%) and National Park (30.51%). */

/* Task 2 - Analyzing Precipitation Data for National Parks */

/* Part a */
/* Cleaning the input dataset */
data filtered_weather;
    set pg1.np_westweather;
    /* Excluding rows with missing Year, zero or missing Precip, or missing Name */
    if Year ne . and Precip > 0 and Name ne ''; 
run;

/* Using PROC MEANS to calculate statistics */
proc means data=filtered_weather noprint;
    class Name Year; /* Group data by park Name and Year */
    var Precip; /* Analyzing precipitation amounts */
    /* Creating a raw output table with columns for RainDays (N) and TotalRain (SUM) */
    output out=rainstats_raw (drop=_type_ _freq_) 
           n=RainDays sum=TotalRain; 
run;

/* Cleaning the raw output dataset by filtering out invalid entries*/
data rainstats;
    set rainstats_raw;
    /* Removing rows where Year is missing, RainDays is zero, or Name is missing */
    if Year ne . and RainDays > 0 and Name ne ''; 
run;

/* Part b: Printing the final rainstats table */
title "Rain Statistics by Year and Park";

proc print data=rainstats label noobs;
    var Name Year RainDays TotalRain; /* Displaying columns in the correct order */
    label Name="Park Name"
          RainDays="Number of Days Raining"
          TotalRain="Total Rain Amount (inches)"; /* Added column labels */
run;

/* Part c */
/* Some rows had missing Year values in the output. */
/* To address this, rows with missing Year (Year = .) were removed in Step 1. */

/* Blank Name values were observed in some rows. */
/* These were filtered out in Step 1, and a second check was added in Step 3 
   to ensure all invalid rows were excluded. */

/* Rows with RainDays = 0 were included in the initial results. */
/* To ensure only meaningful statistics, rows where RainDays = 0 were removed in Step 3. */

/* The final rainstats table contains only valid Name, Year, and statistics. */






