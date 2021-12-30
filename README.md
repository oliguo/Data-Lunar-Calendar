# Data-Lunar-Calendar
A chinese lunar data with MSSQL

# Note
 The SQLs is reference the blog, thanks for it: 
 ```
 https://www.cnblogs.com/accumulater/articles/6807248.html
 ```
 The Sample Data just includes 1999 to 2049.
 
 To get specify lunar date to run the SQL function: 
 ```sql
 SELECT dbo.fn_GetLunar('2021-12-30') Lunar;
 ```
 
 To get the lunar date of whole year to run the SQL procdure:
 ```sql
 EXEC proc_calendar 2021;
 ```
