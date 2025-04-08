/* Task 1 */
proc print data=sashelp.class noobs;
    var Name Sex Height;
    where Age > 13;
run;

/* Task 2 */
data work.class_with_categories;
    set sashelp.class;
    length Category $25; 
    if Age <= 13 then Category = "Young";
    else if Age > 13 then Category = "Teenager - Advanced Group";
run;

proc sort data=work.class_with_categories out=work.class_sorted;
    by Category Name;
run;

proc print data=work.class_sorted noobs;
run;

/*  Task 3 */
proc sql;
    create table work.class_joined as
    select 
        cls.Name,
        cls.Age,
        cls.Height,
        cls.Weight,
        clsf.Height as Predicted_Height,
        clsf.Weight as Predicted_Weight,
        cls.Height - clsf.Height as Height_Difference
    from 
        sashelp.class as cls
    inner join 
        sashelp.classfit as clsf
    on 
        cls.Name = clsf.Name
    order by 
        Height_Difference desc;
quit;

proc print data=work.class_joined noobs;
run;
