/* Part 1 */
/* Creating "pg1" library to access the directory containing the SAS data files */
libname pg1 "/export/viya/homes/merve.pakcan@stud.acs.upb.ro/Courses/PG1V2/data";

/* Viewing the dataset in the library */
proc print data=pg1.np_largeparks;
run;

/* Sorting and removing duplicates in np_largeparks */
proc sort data=pg1.np_largeparks out=park_clean noduprecs dupout=park_dups;
    by _all_;
run;

/* Part 2 */
/* Creating a new table with extracted columns and calculated values */
data eu_occ_total;
    set pg1.eu_occ;
	/* Extract Year and Month from YearMon */
	/* The substr function extracts a specific part of a character */
	/* Mentioned in the question the YearMon column is character. The input function converts a character string to a numeric value. */
    Year = input(substr(YearMon, 1, 4), 4.);/* getting first 4 number */
    Month = input(substr(YearMon, 6, 2), 2.);
	/* The YearMon column has the format YYYYMmm (like 2017M09), so starting at the sixth character to get the two-digit month */

	/* Setting ReportDate as the first day of the reporting month */
    ReportDate = mdy(Month, 1, Year);
	
	/* Calculating total nights spent */
    Total = sum(Hotel, ShortStay, Camp);

    
    /* Format columns to improve readability */
    format Hotel comma12. ShortStay comma12. Camp comma12. Total comma12. ReportDate monyy7.;
    
    /* Keeping only the specified columns */
    keep Country Hotel ShortStay Camp ReportDate Total;
run;

/* Part 3 */
/* Conditionally divide rows into parks and monuments tables with using DATA step */
data parks monuments;
    set pg1.np_summary;
	where Type in ('NP', 'NM');

	/* Calculating total campers and format with commas */
    Campers = sum(TentCampers, RVCampers, BackcountryCampers, OtherCamping);
    format Campers comma12.;

	/* Setting the length of ParkType, normally it takes only first 4 character*/
    length ParkType $10;

    /* Using conditional processing to split data into parks and monuments tables */
    if Type = 'NP' then do;
        ParkType = 'Park';
        output parks;
    end;
    else if Type = 'NM' then do;
        ParkType = 'Monument';
        output monuments;
    end;
	
 	/* Keeping only specified columns in both output tables */
    keep Reg ParkName DayVisits OtherLodging Campers ParkType;
run;

