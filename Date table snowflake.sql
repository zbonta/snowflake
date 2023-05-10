
--need counter = 32872   select datediff(day,to_date('01/01/1960'), to_date('12/31/2049'));

            
CREATE OR REPLACE TABLE PUBLIC.DATE AS  --PUBLIC.DATE IS SCHEMA.TABLE
    (
    SELECT
    CURRENT_DATE AS DATE,
    DATE_PART(DAY, CURRENT_DATE) AS DAY,
    DATE_PART(MONTH, CURRENT_DATE) AS MONTH,
    DATE_PART(YEAR, CURRENT_DATE) AS YEAR,
    CASE 
        WHEN DATE_PART(DAY,CURRENT_DATE) IN (11,12,13) THEN CAST(DATE_PART(DAY,CURRENT_DATE) AS VARCHAR(22)) || 'TH'
        WHEN RIGHT(DATE_PART(DAY,CURRENT_DATE),1) = 1 THEN CAST(DATE_PART(DAY,CURRENT_DATE) AS VARCHAR(22)) || 'ST'
        WHEN RIGHT(DATE_PART(DAY,CURRENT_DATE),1) = 2 THEN CAST(DATE_PART(DAY,CURRENT_DATE) AS VARCHAR(22)) || 'ND'
        WHEN RIGHT(DATE_PART(DAY,CURRENT_DATE),1) = 3 THEN CAST(DATE_PART(DAY,CURRENT_DATE) AS VARCHAR(22)) || 'RD'
        ELSE CAST(DATE_PART(DAY,CURRENT_DATE) AS VARCHAR(22)) || 'TH'
    END AS DAYSUFFIX,
    DATE_PART(DAYOFWEEK, CURRENT_DATE) AS DAYOFWEEK,
    DATE_PART(DAY, CURRENT_DATE) AS DAYOFMONTH,
    DAYNAME(CURRENT_DATE) AS DAYNAMEABBREV,
    CASE 
        WHEN DATE_PART(DAYOFWEEK, CURRENT_DATE) = 1 THEN 'MONDAY'
        WHEN DATE_PART(DAYOFWEEK, CURRENT_DATE) = 2 THEN 'TUESDAY'
        WHEN DATE_PART(DAYOFWEEK, CURRENT_DATE) = 3 THEN 'WEDNESDAY'
        WHEN DATE_PART(DAYOFWEEK, CURRENT_DATE) = 4 THEN 'THURSDAY'
        WHEN DATE_PART(DAYOFWEEK, CURRENT_DATE) = 5 THEN 'FRIDAY'
        WHEN DATE_PART(DAYOFWEEK, CURRENT_DATE) = 6 THEN 'SATURDAY'
        WHEN DATE_PART(DAYOFWEEK, CURRENT_DATE) = 7 THEN 'SUNDAY'
        END AS DAYNAME,
    CASE DATE_PART(DAYOFWEEK, CURRENT_DATE)
        WHEN 1 THEN 1
        WHEN 2 THEN 1
        WHEN 3 THEN 1
        WHEN 4 THEN 1
        WHEN 5 THEN 1
        WHEN 6 THEN 0
        WHEN 7 THEN 0
        END AS ISWEEKDAY,
    DATE_PART(DAYOFYEAR, CURRENT_DATE) AS DAYOFYEAR,
    WEEKOFYEAR(CURRENT_DATE) AS WEEKOFYEAR,
    DATE_PART(MONTH, CURRENT_DATE) AS MONTHOFYEAR,
    DATE_PART(QUARTER, CURRENT_DATE) AS QUARTEROFYEAR,
    MONTHNAME(CURRENT_DATE) AS MONTHNAMEABBREV,
    CASE
        WHEN DATE_PART(MONTH, CURRENT_DATE) = 4 THEN 'APRIL'
        WHEN DATE_PART(MONTH, CURRENT_DATE) = 5 THEN 'MAY'
        WHEN DATE_PART(MONTH, CURRENT_DATE) = 6 THEN 'JUNE'
        WHEN DATE_PART(MONTH, CURRENT_DATE) = 7 THEN 'JULY'
        WHEN DATE_PART(MONTH, CURRENT_DATE) = 8 THEN 'AUGUST'
        WHEN DATE_PART(MONTH, CURRENT_DATE) = 9 THEN 'SEPTEMBER'
        WHEN DATE_PART(MONTH, CURRENT_DATE) = 10 THEN 'OCTOBER'
        WHEN DATE_PART(MONTH, CURRENT_DATE) = 11 THEN 'NOVEMBER'
        WHEN DATE_PART(MONTH, CURRENT_DATE) = 12 THEN 'DECEMBER'
        WHEN DATE_PART(MONTH, CURRENT_DATE) = 1 THEN 'JANUARY'
        WHEN DATE_PART(MONTH, CURRENT_DATE) = 2 THEN 'FEBRUARY'
        WHEN DATE_PART(MONTH, CURRENT_DATE) = 3 THEN 'MARCH'
        ELSE 'ERR' END AS MONTHNAME,
    CASE DATE_PART(QUARTER, CURRENT_DATE)
        WHEN 1 THEN 'FIRST'
        WHEN 2 THEN 'SECOND'
        WHEN 3 THEN 'THIRD'
        WHEN 4 THEN 'FOURTH'
        END AS QUARTERNAME,
    CASE
        WHEN DATE_PART(MONTH, CURRENT_DATE) IN (1, 4, 7, 10) THEN 1
        WHEN DATE_PART(MONTH, CURRENT_DATE) IN (2, 5, 8, 11) THEN 2
        WHEN DATE_PART(MONTH, CURRENT_DATE) IN (3, 6, 9, 12) THEN 3
        END AS MONTHOFQUARTER,
    LAST_DAY(CURRENT_DATE, WEEK) AS LASTDAYOFWEEK,
    LAST_DAY(CURRENT_DATE, MONTH) AS LASTDAYOFMONTH,
    LAST_DAY(CURRENT_DATE, YEAR) AS LASTDAYOFYEAR,
    LAST_DAY(CURRENT_DATE, QUARTER) AS LASTDAYOFQUARTER,
    TO_DATE('01/01/'||YEAR(CURRENT_DATE)) AS FIRSTDAYOFYEAR,
    CURRENT_DATE AS TODAY,
    NULL AS ISFEDHOLIDAY,
    NULL AS HOLIDAYNAME,
    NULL AS ISJAVARAHOLIDAY
                );



declare 
counter :=0;
max_counter := 100; --max number of days. 10 years = 3,650 
sday date := current_date(); --starting day 1960/01/01 IS COMMON MAX COUNTER = 32,850 GOES UNTIL JAN 1 2050
begin
    for i in 1 to max_counter DO     
        insert into PUBLIC.DATE --SCHEMA.TABLE CREATED ABOVE
            SELECT
            $sday AS DATE,
            DATE_PART(DAY, $sday) AS DAY,
            DATE_PART(MONTH, $sday) AS MONTH,
            DATE_PART(YEAR, $sday) AS YEAR,
            CASE 
                WHEN DATE_PART(DAY,$sday) IN (11,12,13) THEN CAST(DATE_PART(DAY,$sday) AS VARCHAR(22)) || 'TH'
                WHEN RIGHT(DATE_PART(DAY,$sday),1) = 1 THEN CAST(DATE_PART(DAY,$sday) AS VARCHAR(22)) || 'ST'
                WHEN RIGHT(DATE_PART(DAY,$sday),1) = 2 THEN CAST(DATE_PART(DAY,$sday) AS VARCHAR(22)) || 'ND'
                WHEN RIGHT(DATE_PART(DAY,$sday),1) = 3 THEN CAST(DATE_PART(DAY,$sday) AS VARCHAR(22)) || 'RD'
                ELSE CAST(DATE_PART(DAY,$sday) AS VARCHAR(22)) || 'TH'
            END AS DAYSUFFIX,
            DATE_PART(DAYOFWEEK, $sday) AS DAYOFWEEK,
            DATE_PART(DAY, $sday) AS DAYOFMONTH,
            DAYNAME($sday) AS DAYNAMEABBREV,
            CASE 
                WHEN DATE_PART(DAYOFWEEK, $sday) = 1 THEN 'MONDAY'
                WHEN DATE_PART(DAYOFWEEK, $sday) = 2 THEN 'TUESDAY'
                WHEN DATE_PART(DAYOFWEEK, $sday) = 3 THEN 'WEDNESDAY'
                WHEN DATE_PART(DAYOFWEEK, $sday) = 4 THEN 'THURSDAY'
                WHEN DATE_PART(DAYOFWEEK, $sday) = 5 THEN 'FRIDAY'
                WHEN DATE_PART(DAYOFWEEK, $sday) = 6 THEN 'SATURDAY'
                WHEN DATE_PART(DAYOFWEEK, $sday) = 7 THEN 'SUNDAY'
                END AS DAYNAME,
            CASE DATE_PART(DAYOFWEEK, $sday)
                WHEN 1 THEN 1
                WHEN 2 THEN 1
                WHEN 3 THEN 1
                WHEN 4 THEN 1
                WHEN 5 THEN 1
                WHEN 6 THEN 0
                WHEN 7 THEN 0
                END AS ISWEEKDAY,
            DATE_PART(DAYOFYEAR, $sday) AS DAYOFYEAR,
            WEEKOFYEAR($sday) AS WEEKOFYEAR,
            DATE_PART(MONTH, $sday) AS MONTHOFYEAR,
            DATE_PART(QUARTER, $sday) AS QUARTEROFYEAR,
            MONTHNAME($sday) AS MONTHNAMEABBREV,
            CASE
                WHEN DATE_PART(MONTH, $sday) = 4 THEN 'APRIL'
                WHEN DATE_PART(MONTH, $sday) = 5 THEN 'MAY'
                WHEN DATE_PART(MONTH, $sday) = 6 THEN 'JUNE'
                WHEN DATE_PART(MONTH, $sday) = 7 THEN 'JULY'
                WHEN DATE_PART(MONTH, $sday) = 8 THEN 'AUGUST'
                WHEN DATE_PART(MONTH, $sday) = 9 THEN 'SEPTEMBER'
                WHEN DATE_PART(MONTH, $sday) = 10 THEN 'OCTOBER'
                WHEN DATE_PART(MONTH, $sday) = 11 THEN 'NOVEMBER'
                WHEN DATE_PART(MONTH, $sday) = 12 THEN 'DECEMBER'
                WHEN DATE_PART(MONTH, $sday) = 1 THEN 'JANUARY'
                WHEN DATE_PART(MONTH, $sday) = 2 THEN 'FEBRUARY'
                WHEN DATE_PART(MONTH, $sday) = 3 THEN 'MARCH'
                ELSE 'ERR' END AS MONTHNAME,
            CASE DATE_PART(QUARTER, $sday)
                WHEN 1 THEN 'FIRST'
                WHEN 2 THEN 'SECOND'
                WHEN 3 THEN 'THIRD'
                WHEN 4 THEN 'FOURTH'
                END AS QUARTERNAME,
            CASE
                WHEN DATE_PART(MONTH, $sday) IN (1, 4, 7, 10) THEN 1
                WHEN DATE_PART(MONTH, $sday) IN (2, 5, 8, 11) THEN 2
                WHEN DATE_PART(MONTH, $sday) IN (3, 6, 9, 12) THEN 3
                END AS MONTHOFQUARTER,
            LAST_DAY($sday, WEEK) AS LASsdayOFWEEK,
            LAST_DAY($sday, MONTH) AS LASsdayOFMONTH,
            LAST_DAY($sday, YEAR) AS LASsdayOFYEAR,
            LAST_DAY($sday, QUARTER) AS LASsdayOFQUARTER,
            TO_DATE('01/01/'||YEAR($sday)) AS FIRSsdayOFYEAR,
            $sday AS TODAY,
            NULL AS ISFEDHOLIDAY,
            NULL AS HOLIDAYNAME,
            NULL AS ISJAVARAHOLIDAY
            ;
            counter:=counter+1;
            sday:= sday+1;
        end for;
    return counter;
end;

--if run exactly as above, current date will be present twice. 

------------------------------------------------------------------

--add last day of year, week, month
alter table date add column LASTDAYOFYEAR date
;
update date set lastdayofyear = last_day("Calendar_Date", year)
;
alter table date ADD column DAYOFWEEK varchar(22)
;
alter table date add LASTDAYOFWEEK DATE, LASTDAYOFMONTH DATE                
;
UPDATE DATE SET LASTDAYOFWEEK = LAST_DAY("Calendar_Date", week)
;
UPDATE DATE SET LASTDAYOFMONTH = last_day("Calendar_Date", month)
;
--add federal holiday placeholder, holiday name, and iscompany holiday (company holidays aren't always the same)
ALTER TABLE DATE ADD ISFEDERALHOLIDAY BOOLEAN, ISCOMPANYHOLIDAY BOOLEAN, HOLIDAYNAME VARCHAR(50)
;
ALTER TABLE DATE ADD WEEKDAY BOOLEAN;        
;
UPDATE DATE SET WEEKDAY = FALSE where DAYOFWEEK IN ('SUNDAY', 'SATURDAY')
;
SELECT DISTINCT DAYOFWEEK FROM DATE 
;
-------------------------------------------
----------start holiday updates-----------

/* Juneteenth */
update date 
set holidayname = 'Juneteenth'
    where "Month_Name" = 'June'
    and "Day_of_Month" = '19'
    and "Year" > 2021

/* Memorial Day */
update date 
set holidayname = 'Memorial Day'
    where "Date_Id" IN
        (
        Select Max("Date_Id")
            from DATE
            where "Month_Name" = 'May'
            and "DAYOFWEEK" = 'Monday'
            group by "Year", "Month_Number"
        )

/* Mother's Day - Second Sunday of May */
    UPDATE date
        SET HolidayName = 'Mother''s Day'
    WHERE
        "Date_Id" in (
                        
                        Select "Date_Id" from (
                            --second sunday of may
                            select "Date_Id", 
                                "Month_Number", 
                                "DAYOFWEEK",
                                "Year",
                                Row_number() OVER(PARTITION BY "Year"order by "Date_Id") as weekdaynumber
                            from DATE
                                where "Month_Number" = 5 and "DAYOFWEEK" = 'Sunday' 
                                ORDER BY "Date_Id", "Year") ab
                                where "WEEKDAYNUMBER" = 2
                        )

/* Father's Day - Third Sunday of June */
UPDATE Date
    SET HolidayName = 'Father''s Day'
WHERE "Date_Id" in (
                            Select "Date_Id" from (
                            --third sunday of june
                            select "Date_Id", 
                                "Month_Number", 
                                "DAYOFWEEK",
                                "Year",
                                Row_number() OVER(PARTITION BY "Year"order by "Date_Id") as weekdaynumber
                            from DATE
                                where "Month_Number" = 6 and "DAYOFWEEK" = 'Sunday' 
                                ORDER BY "Date_Id", "Year") ab
                                where "WEEKDAYNUMBER" = 3

                    )


/* Columbus Day - Second MONDAY in October */
UPDATE Date
    SET HolidayName = 'Columbus Day'
WHERE "Date_Id" in (
                            Select "Date_Id" from (
                            --second monday of october
                            select "Date_Id", 
                                "Month_Number", 
                                "DAYOFWEEK",
                                "Year",
                                Row_number() OVER(PARTITION BY "Year"order by "Date_Id") as weekdaynumber
                            from DATE
                                where "Month_Number" = 10 and "DAYOFWEEK" = 'Monday' 
                                ORDER BY "Date_Id", "Year") ab
                                where "WEEKDAYNUMBER" = 2

                    )    
    
/* Thanksgiving Day - Fourth THURSDAY in November */
UPDATE Date
    SET HolidayName = 'Thanksgiving Day'
WHERE "Date_Id" in (
                            Select "Date_Id" from (
                            --second monday of october
                            select "Date_Id", 
                                "Month_Number", 
                                "DAYOFWEEK",
                                "Year",
                                Row_number() OVER(PARTITION BY "Year"order by "Date_Id") as weekdaynumber
                            from DATE
                                where "Month_Number" = 11 and "DAYOFWEEK" = 'Thursday' 
                                ORDER BY "Date_Id", "Year") ab
                                where "WEEKDAYNUMBER" = 4

                    )

/* Labor Day - First MONDAY in September */
UPDATE Date
    SET HolidayName = 'Labor Day'
WHERE "Date_Id" in (
                            Select "Date_Id" from (
                            --first monday of september
                            select "Date_Id", 
                                "Month_Number", 
                                "DAYOFWEEK",
                                "Year",
                                Row_number() OVER(PARTITION BY "Year"order by "Date_Id") as weekdaynumber
                            from DATE
                                where "Month_Number" = 9 and "DAYOFWEEK" = 'Monday' 
                                ORDER BY "Date_Id", "Year") ab
                                where "WEEKDAYNUMBER" = 1

                    )

/* President's Day - Third MONDAY in February */
UPDATE Date
    SET HolidayName = 'President''s Day'
    WHERE "Date_Id" in (
                            Select "Date_Id" from (
                            --third monday of february
                            select "Date_Id", 
                                "Month_Number", 
                                "DAYOFWEEK",
                                "Year",
                                Row_number() OVER(PARTITION BY "Year"order by "Date_Id") as weekdaynumber
                            from DATE
                                where "Month_Number" = 2 and "DAYOFWEEK" = 'Monday' 
                                ORDER BY "Date_Id", "Year") ab
                                where "WEEKDAYNUMBER" = 3

                        )
--federal holidays present
/*
federal holidays
    X New Year’s Day
    X Martin Luther King, Jr.
    X Washington’s Birthday (President's Day)
    X Memorial Day
    X Juneteenth National Independence Day
    X Independence Day
    X Labor Day
    X Columbus Day
    X Veterans Day
    X Thanksgiving Day
    X Christmas Day

*/
/* Mark federal holidays */
update date set ISFEDERALHOLIDAY = TRUE WHERE holidayname  in 
    (
           'New Year''s Day', 'Independance Day', 'Labor Day', 'President''s Day', 'Christmas Day', 'Thanksgiving Day'
           ,'Marin Luther Kind, Jr. Day', 'Juneteenth', 'Memorial Day', 'Veterans Day', 'Columbus Day'
    )
;
UPDATE DATE SET ISFEDERALHOLIDAY = FALSE WHERE ISFEDERALHOLIDAY IS NULL
;

