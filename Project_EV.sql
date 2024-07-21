CREATE DATABASE ev_data;
USE ev_data;

SELECT * FROM electric_vehicle;
CREATE TABLE electric_vehicle_c AS
SELECT * FROM electric_vehicle;


-- CHECKING DUPLICATES
SELECT COUNT(*) FROM (SELECT distinct * FROM electric_vehicle) AS DIS;
SELECT COUNT(*) FROM (SELECT * FROM electric_vehicle) AS DIS;
-- TOTAL ROWS 33907 AND TOTAL DISTINCT ROWS 33907 MEANS NO DUPLICATE ROWS

-- DROPPING  UNNECESSARY COLUMNS
ALTER TABLE electric_vehicle_c
DROP COLUMN `Base MSRP`,
DROP COLUMN `Vehicle Location`;

SELECT * FROM electric_vehicle_c;

-- DATA ANALYSIS

-- Number of EVs registered by model year.
SELECT `Model Year`,COUNT(`Model Year`) 
FROM electric_vehicle_c 
GROUP BY `Model Year` ORDER BY `Model Year` DESC;

-- Top 10 cities based on EV registrations
SELECT City,COUNT(City) AS Cars_Sold 
FROM electric_vehicle_c
GROUP BY City LIMIT 10;

-- Numbers of electric vehicle registered by categories
SELECT `Electric Vehicle Type`,COUNT(`Electric Vehicle Type`) AS Numbers_Of_Vehicle_Registered 
FROM electric_vehicle_c 
GROUP BY `Electric Vehicle Type`;

-- Top 10 EV Maker
SELECT Make AS Top_10_EV_Maker,COUNT(Make) AS Cars_Sold 
FROM electric_vehicle_c 
GROUP BY Make 
ORDER BY Cars_Sold DESC LIMIT 10;

-- Top Models In Every Make
SELECT evc.Make, evc.Model, evc.ModelCount
FROM (
    SELECT Make, Model, COUNT(*) AS ModelCount
    FROM electric_vehicle_c
    GROUP BY Make, Model
) evc
INNER JOIN (
    SELECT Make, MAX(ModelCount) AS MaxModelCount
    FROM (
        SELECT Make, Model, COUNT(*) AS ModelCount
        FROM electric_vehicle_c
        GROUP BY Make, Model
    ) temp
    GROUP BY Make
) max_counts
ON evc.Make = max_counts.Make AND evc.ModelCount = max_counts.MaxModelCount;

-- Average Range of every Models of all Make(Car Company)
SELECT Model, ROUND(AVG(`Electric Range`), 2) AS Avg_Range
FROM electric_vehicle_c
WHERE `Clean Alternative Fuel Vehicle (CAFV) Eligibility` = 'Clean Alternative Fuel Vehicle Eligible'
GROUP BY Model ORDER BY Avg_Range DESC;

-- Number of EVs Registered Every Year
SELECT `Model Year`,COUNT(Make) AS Total_Cars_Sold_in_Year 
FROM electric_vehicle_c 
GROUP BY `Model Year` ORDER BY `Model Year` ASC;

-- To check Numbers of Vehicles' Battery eligible,Not eligible or Not Researched for EVs
SELECT `Clean Alternative Fuel Vehicle (CAFV) Eligibility`,COUNT(`Clean Alternative Fuel Vehicle (CAFV) Eligibility`) AS Count_in_Category
FROM electric_vehicle_c 
GROUP BY `Clean Alternative Fuel Vehicle (CAFV) Eligibility`;

SELECT * FROM electric_vehicle_c;







