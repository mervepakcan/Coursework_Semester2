libname pg1 "/export/viya/homes/merve.pakcan@stud.acs.upb.ro/Courses/PG1V2/data";

data np_summary2; 
    set pg1.np_summary; 
    ParkType = scan(ParkName, -1, ' '); /* Extracting the last word */
    keep Reg Type ParkName ParkType;   /* Keeping required columns */
run;

proc print data=np_summary2; 
run;

/* In row four, the value of ParkType is 'Preserve'. */