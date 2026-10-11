USE project_automobile_insurance;
SHOW TABLES;
DESCRIBE auto_table;
	SELECT *
	FROM auto_table
	LIMIT 10;
   SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'project_automobile_insurance'
AND TABLE_NAME = 'auto_table';
SELECT GROUP_CONCAT(
    COLUMN_NAME
    ORDER BY ORDINAL_POSITION
    SEPARATOR ', '
) AS All_Columns
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'project_automobile_insurance'
AND TABLE_NAME = 'auto_table';
SELECT 
    ORDINAL_POSITION,
    COLUMN_NAME,
    DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'project_automobile_insurance'
AND TABLE_NAME = 'auto_table'
ORDER BY ORDINAL_POSITION;
SELECT 
    ORDINAL_POSITION,
    COLUMN_NAME,
    DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'project_automobile_insurance'
AND TABLE_NAME = 'auto_table'
ORDER BY ORDINAL_POSITION
LIMIT 6 OFFSET 6;
SELECT COUNT(*) AS Total_Rows
FROM auto_table;
SELECT 
    Filing_Year,
    COUNT(*) AS Number_of_Records
FROM auto_table
GROUP BY Filing_Year
ORDER BY Filing_Year;
SELECT
    SUM(NAIC IS NULL) AS Missing_NAIC,
    SUM(Company_Name IS NULL) AS Missing_Company,
    SUM(Ratio IS NULL) AS Missing_Ratio,
    SUM(Upheld_Complaints IS NULL) AS Missing_Upheld,
    SUM(Question_of_Fact_Complaints IS NULL) AS Missing_Question_Fact,
    SUM(Not_Upheld_Complaints IS NULL) AS Missing_Not_Upheld,
    SUM(Total_Complaints IS NULL) AS Missing_Total_Complaints,
    SUM(Premiums_Written IS NULL) AS Missing_Premiums,
    SUM(Ranking IS NULL) AS Missing_Ranking,
    SUM(Filing_Year IS NULL) AS Missing_Year
FROM auto_table;
SELECT 
    COUNT(*) AS Total_Rows,
    COUNT(DISTINCT NAIC, Filing_Year) AS Unique_Company_Year
FROM auto_table;
	SELECT
		NAIC,
		Company_Name,
		Filing_Year,
		COUNT(*) AS Record_Count
	FROM auto_table
	GROUP BY
		NAIC,
		Company_Name,
		Filing_Year
	HAVING COUNT(*) > 1;
    SELECT *
FROM auto_table
WHERE NAIC = 34460
  AND Filing_Year = 2014;
  
  SELECT
    SUM(Upheld_Complaints) AS Total_Upheld,
    SUM(Question_of_Fact_Complaints) AS Total_Question_of_Fact,
    SUM(Not_Upheld_Complaints) AS Total_Not_Upheld,
    SUM(Total_Complaints) AS Total_Complaints,

    ROUND(SUM(Upheld_Complaints) / SUM(Total_Complaints) * 100, 2)
        AS Upheld_Percentage,

    ROUND(SUM(Question_of_Fact_Complaints) / SUM(Total_Complaints) * 100, 2)
        AS Question_of_Fact_Percentage,

    ROUND(SUM(Not_Upheld_Complaints) / SUM(Total_Complaints) * 100, 2)
        AS Not_Upheld_Percentage

FROM auto_table;

SELECT
    Filing_Year,
    SUM(Upheld_Complaints) AS Upheld_Complaints,
    SUM(Question_of_Fact_Complaints) AS Question_of_Fact_Complaints,
    SUM(Not_Upheld_Complaints) AS Not_Upheld_Complaints,
    SUM(Total_Complaints) AS Total_Complaints
FROM auto_table
GROUP BY Filing_Year
ORDER BY Filing_Year;

SELECT
    Filing_Year,
    SUM(Total_Complaints) AS Total_Complaints
FROM auto_table
GROUP BY Filing_Year
ORDER BY Total_Complaints DESC;

SELECT
    Company_Name,
    SUM(Total_Complaints) AS Total_Complaints,
    SUM(Upheld_Complaints) AS Total_Upheld,
    SUM(Question_of_Fact_Complaints) AS Total_Question_of_Fact,
    SUM(Not_Upheld_Complaints) AS Total_Not_Upheld,
    ROUND(AVG(Ratio), 4) AS Avg_Complaint_Ratio,
    ROUND(SUM(Premiums_Written), 2) AS Total_Premiums
FROM auto_table
GROUP BY Company_Name
ORDER BY Avg_Complaint_Ratio DESC; 

SELECT
    Company_Name,
    COUNT(*) AS Number_of_Records,
    MIN(Filing_Year) AS First_Year,
    MAX(Filing_Year) AS Last_Year,
    SUM(Total_Complaints) AS Total_Complaints,
    SUM(Upheld_Complaints) AS Total_Upheld,
    ROUND(AVG(Ratio), 4) AS Avg_Complaint_Ratio,
    ROUND(SUM(Premiums_Written), 2) AS Total_Premiums
FROM auto_table
GROUP BY Company_Name
HAVING COUNT(*) >= 3
ORDER BY Avg_Complaint_Ratio DESC;

SELECT
    Company_Name,
    COUNT(*) AS Number_of_Records,
    MIN(Filing_Year) AS First_Year,
    MAX(Filing_Year) AS Last_Year,
    SUM(Total_Complaints) AS Total_Complaints,
    SUM(Upheld_Complaints) AS Total_Upheld,
    ROUND(AVG(Ratio), 4) AS Avg_Complaint_Ratio,
    ROUND(SUM(Premiums_Written), 2) AS Total_Premiums
FROM auto_table
GROUP BY Company_Name
HAVING COUNT(*) >= 3
ORDER BY Avg_Complaint_Ratio DESC;

SELECT
    Filing_Year,
    ROUND(SUM(Premiums_Written), 2) AS Total_Premiums
FROM auto_table
GROUP BY Filing_Year
ORDER BY Filing_Year;

SELECT
    Filing_Year,
    ROUND(SUM(Premiums_Written), 2) AS Total_Premiums
FROM auto_table
GROUP BY Filing_Year
ORDER BY Filing_Year;

SELECT
    current_year.Filing_Year,
    ROUND(current_year.Total_Premiums, 2) AS Total_Premiums,
    ROUND(
        ((current_year.Total_Premiums - previous_year.Total_Premiums)
        / previous_year.Total_Premiums) * 100,
        2
    ) AS YoY_Change_Percentage
FROM
(
    SELECT
        Filing_Year,
        SUM(Premiums_Written) AS Total_Premiums
    FROM auto_table
    GROUP BY Filing_Year
) AS current_year

LEFT JOIN
(
    SELECT
        Filing_Year,
        SUM(Premiums_Written) AS Total_Premiums
    FROM auto_table
    GROUP BY Filing_Year
) AS previous_year

ON current_year.Filing_Year = previous_year.Filing_Year + 1

ORDER BY current_year.Filing_Year;

	SELECT
		Company_Name,
		ROUND(SUM(Premiums_Written), 2) AS Total_Premiums,
		SUM(Total_Complaints) AS Total_Complaints,
		SUM(Upheld_Complaints) AS Total_Upheld,
		ROUND(AVG(Ratio), 4) AS Avg_Complaint_Ratio
	FROM auto_table
	GROUP BY Company_Name
	HAVING COUNT(*) >= 3
	ORDER BY Total_Premiums DESC;
    
    SELECT
    Company_Name,
    COUNT(*) AS Number_of_Records,
    ROUND(SUM(Premiums_Written), 2) AS Total_Premiums,
    SUM(Total_Complaints) AS Total_Complaints,
    SUM(Upheld_Complaints) AS Total_Upheld,
    ROUND(AVG(Ratio), 4) AS Avg_Complaint_Ratio
FROM auto_table
GROUP BY Company_Name
HAVING COUNT(*) >= 3
ORDER BY Avg_Complaint_Ratio DESC
LIMIT 10;

SELECT *
FROM auto_table;

SELECT
    SUM(NAIC IS NULL) AS NAIC_NULLS,
    SUM(Company_Name IS NULL) AS Company_NULLS,
    SUM(Ratio IS NULL) AS Ratio_NULLS,
    SUM(Upheld_Complaints IS NULL) AS Upheld_NULLS,
    SUM(Question_of_Fact_Complaints IS NULL) AS Question_Fact_NULLS,
    SUM(Not_Upheld_Complaints IS NULL) AS Not_Upheld_NULLS,
    SUM(Total_Complaints IS NULL) AS Total_Complaints_NULLS,
    SUM(Premiums_Written IS NULL) AS Premiums_NULLS,
    SUM(Filing_Year IS NULL) AS Filing_Year_NULLS
FROM auto_table;



