    CREATE PROC PROC_CALENDAR(@YEAR INT ) 
    AS 
    BEGIN 
    DECLARE @i INT; 
    DECLARE @START_DATE VARCHAR(20); 
    DECLARE @END_DATE VARCHAR(20); 
    DECLARE @DATE_COUNT INT; 
    SET @i=0; 
    --定义一年的开始日期，用CONCAT函数将年份和月份日期拼接起来 
    SET @START_DATE= CONCAT(@YEAR, '-01-01'); 
    --定义一年的结束日期 
    SET @END_DATE = CONCAT(@YEAR+1,'-01-01'); 
    --如果表已经存在要新建的日历，则先删除 
    DELETE FROM CALENDAR_INFO WHERE YEAR = @YEAR; 
    --计算开始到结束日期一共有多少天，DATEDIFF函数计算日期的间隔天数 
    SET @DATE_COUNT = DATEDIFF(DAY,@START_DATE,@END_DATE); 
     
    --建立循环，条件是@i小于一年的天数 
    WHILE @i < @DATE_COUNT 
    BEGIN  
    INSERT INTO CALENDAR_INFO (COUNTRY,CDR_CODE,DATE_NAME,LUNAR, 
    YEAR,MONTH,WEEK,DAY,CDR_DATE,CREATOR,CREATE_DATE,CREATE_INST) 
    SELECT 
    'CN', 
    'CN01', 
    --CONVERT函数将@START_DATE转换成指定的格式 
    CONVERT(NVARCHAR(10),@START_DATE,111) DATE_NAME, 
    --将公历日期转换为农历 
    dbo.fn_GetLunar(CONVERT(datetime,@start_date,101)) LUNAR, 
    --DATENAME获取@START_DATE的年份 
    CONVERT(NVARCHAR(10),DATENAME(YEAR, @START_DATE)) YEAR, 
    --DATENAME获取@START_DATE的月份 
    CONVERT(NVARCHAR(10),DATENAME(MONTH, @START_DATE)) MONTH, 
    --DATENAME获取@START_DATE的星期 
    CONVERT(NVARCHAR(10),DATENAME(WEEKDAY, @START_DATE)) WEEK, 
    --DATENAME获取@START_DATE的日期 
    CONVERT(NVARCHAR(10),DATENAME(DAY, @START_DATE)) DAY, 
    CONVERT(NVARCHAR(20),@START_DATE,120) CDR_DATE, 
    'cnblog', 
    GETDATE() CREATE_DATE, 
    'Lyven' 
    --插入完成后，对@i进行自加1处理 
    SET @i=@i+1; 
    --更新@START_DATE的值，在原来的基础上使用DATEADD函数增加一天 
    SET @START_DATE=CONVERT(CHAR(10),DATEADD(DAY, 1, @START_DATE),120); 
    END  
    END 