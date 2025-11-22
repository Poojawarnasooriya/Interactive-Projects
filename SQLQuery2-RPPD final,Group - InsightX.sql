

CREATE DATABASE LancashirePropertyDB;
GO
USE LancashirePropertyDB;



CREATE TABLE PricePaidData (
    TransactionID NVARCHAR(50),
    Price INT,
    TransferDate DATE,
    Postcode NVARCHAR(10),
    PropertyType CHAR(10),
    NewBuild CHAR(10),
    Tenure CHAR(10),
    PAON NVARCHAR(100),
    SAON NVARCHAR(100),
    Street NVARCHAR(100),
    Locality NVARCHAR(100),
    Town NVARCHAR(100),
    District NVARCHAR(100),
    County NVARCHAR(100),
    Category NVARCHAR(50),
    BuyerType CHAR(10)
);





------------Raw data table
CREATE TABLE RawPricePaidData (
    Col1 NVARCHAR(MAX),
    Col2 NVARCHAR(MAX),
    Col3 NVARCHAR(MAX),
    Col4 NVARCHAR(MAX),
    Col5 NVARCHAR(MAX),
    Col6 NVARCHAR(MAX),
    Col7 NVARCHAR(MAX),
    Col8 NVARCHAR(MAX),
    Col9 NVARCHAR(MAX),
    Col10 NVARCHAR(MAX),
    Col11 NVARCHAR(MAX),
    Col12 NVARCHAR(MAX),
    Col13 NVARCHAR(MAX),
    Col14 NVARCHAR(MAX),
    Col15 NVARCHAR(MAX),
    Col16 NVARCHAR(MAX)
);






----------------START AGAIN 1
TRUNCATE TABLE RawPricePaidData;


BULK INSERT RawPricePaidData
FROM 'C:\Users\ASUS\Desktop\STUDIES\Sem  02\SQL\ASSG\Datasets\pp-2020.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2,
    TABLOCK
);



SELECT COUNT(*) FROM RawPricePaidData;
SELECT TOP 10 * FROM RawPricePaidData;

------Cleaning 

ALTER TABLE PricePaidData
ALTER COLUMN Postcode NVARCHAR(20);



INSERT INTO PricePaidData (
    TransactionID, Price, TransferDate, Postcode, PropertyType, NewBuild, Tenure,
    PAON, SAON, Street, Locality, Town, District, County, Category, BuyerType
)
SELECT
    REPLACE(Col1, '"', ''),
    TRY_CAST(REPLACE(REPLACE(Col2, ',', ''), '£', '') AS BIGINT),
    TRY_CAST(REPLACE(Col3, '"', '') AS DATE),
    LEFT(REPLACE(Col4, '"', ''), 10),
    LEFT(REPLACE(Col5, '"', ''), 1),
    LEFT(REPLACE(Col6, '"', ''), 1),
    LEFT(REPLACE(Col7, '"', ''), 1),
    REPLACE(Col8, '"', ''),
    NULLIF(REPLACE(Col9, '"', ''), ''),
    REPLACE(Col10, '"', ''),
    REPLACE(Col11, '"', ''),
    REPLACE(Col12, '"', ''),
    REPLACE(Col13, '"', ''),
    REPLACE(Col14, '"', ''),
    LEFT(REPLACE(Col15, '"', ''), 1),
    LEFT(REPLACE(Col16, '"', ''), 1)
FROM RawPricePaidData
WHERE Col1 IS NOT NULL;



------Checking the PricePaidData for 2020 csv
SELECT COUNT(*) AS TotalRows FROM PricePaidData;

SELECT TOP 20 *
FROM PricePaidData
ORDER BY TransferDate;


SELECT DISTINCT PropertyType FROM PricePaidData;
SELECT DISTINCT BuyerType FROM PricePaidData;
SELECT DISTINCT Postcode FROM PricePaidData WHERE LEN(Postcode) > 10;


SELECT COUNT(*) AS MissingPrices
FROM PricePaidData
WHERE Price IS NULL;

SELECT COUNT(*) AS MissingDates
FROM PricePaidData
WHERE TransferDate IS NULL;





SELECT
  COUNT(*) AS TotalRows,
  COUNT(*) - COUNT(TransactionID) AS MissingTransactionID,
  COUNT(*) - COUNT(Price) AS MissingPrice,
  COUNT(*) - COUNT(TransferDate) AS MissingTransferDate,
  COUNT(*) - COUNT(Postcode) AS MissingPostcode,
  COUNT(*) - COUNT(PropertyType) AS MissingPropertyType,
  COUNT(*) - COUNT(Tenure) AS MissingTenure,
  COUNT(*) - COUNT(BuyerType) AS MissingBuyerType
FROM PricePaidData;


---------Importing 2021

TRUNCATE TABLE RawPricePaidData;


BULK INSERT RawPricePaidData
FROM 'C:\Users\ASUS\Desktop\STUDIES\Sem  02\SQL\ASSG\Datasets\pp-2021(1).csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2,
    TABLOCK
);







----------Cleaning 2021 csv
TRUNCATE TABLE RawPricePaidData;
TRUNCATE TABLE RawPricePaidData;





-------cleaning 2021 inside RPPD
SELECT TOP 10 Col1 FROM RawPricePaidData;


INSERT INTO PricePaidData (
    TransactionID, Price, TransferDate, Postcode, PropertyType, NewBuild, Tenure,
    PAON, SAON, Street, Locality, Town, District, County, Category, BuyerType
)
SELECT
    REPLACE(Col1, '"', ''),
    TRY_CAST(REPLACE(REPLACE(Col2, ',', ''), '£', '') AS BIGINT),
    TRY_CAST(REPLACE(Col3, '"', '') AS DATE),
    LEFT(REPLACE(Col4, '"', ''), 10),
    LEFT(REPLACE(Col5, '"', ''), 1),
    LEFT(REPLACE(Col6, '"', ''), 1),
    LEFT(REPLACE(Col7, '"', ''), 1),
    REPLACE(Col8, '"', ''),
    NULLIF(REPLACE(Col9, '"', ''), ''),
    REPLACE(Col10, '"', ''),
    REPLACE(Col11, '"', ''),
    REPLACE(Col12, '"', ''),
    REPLACE(Col13, '"', ''),
    REPLACE(Col14, '"', ''),
    LEFT(REPLACE(Col15, '"', ''), 1),
    LEFT(REPLACE(Col16, '"', ''), 1)
FROM RawPricePaidData
WHERE Col1 IS NOT NULL;












------Verify the Import
SELECT COUNT(*) AS Total2021Rows
FROM PricePaidData
WHERE YEAR(TransferDate) = 2021;


------validating 2021 cleaned

SELECT COUNT(*) AS Rows2021
FROM PricePaidData
WHERE YEAR(TransferDate) = 2021;

------Inspecting rows

SELECT TOP 20 *
FROM PricePaidData
WHERE YEAR(TransferDate) = 2021
ORDER BY TransferDate;


-------checking for columns which have NULL values
SELECT
  COUNT(*) AS TotalRows,
  COUNT(*) - COUNT(TransactionID) AS MissingTransactionID,
  COUNT(*) - COUNT(Price) AS MissingPrice,
  COUNT(*) - COUNT(TransferDate) AS MissingTransferDate,
  COUNT(*) - COUNT(Postcode) AS MissingPostcode,
  COUNT(*) - COUNT(PropertyType) AS MissingPropertyType,
  COUNT(*) - COUNT(Tenure) AS MissingTenure,
  COUNT(*) - COUNT(BuyerType) AS MissingBuyerType
FROM PricePaidData
WHERE YEAR(TransferDate) = 2021;




----------2022 Import



TRUNCATE TABLE RawPricePaidData;

BULK INSERT RawPricePaidData
FROM 'C:\Users\ASUS\Desktop\STUDIES\Sem  02\SQL\ASSG\Datasets\pp-2022(1).csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2,
    TABLOCK
);



SELECT COUNT(*) FROM RawPricePaidData;
SELECT TOP 10 * FROM RawPricePaidData;



-------Cleaning 2022

INSERT INTO PricePaidData (
    TransactionID, Price, TransferDate, Postcode, PropertyType, NewBuild, Tenure,
    PAON, SAON, Street, Locality, Town, District, County, Category, BuyerType
)
SELECT
    REPLACE(Col1, '"', ''),
    TRY_CAST(REPLACE(REPLACE(Col2, ',', ''), '£', '') AS BIGINT),
    TRY_CAST(REPLACE(Col3, '"', '') AS DATE),
    LEFT(REPLACE(Col4, '"', ''), 10),
    LEFT(REPLACE(Col5, '"', ''), 1),
    LEFT(REPLACE(Col6, '"', ''), 1),
    LEFT(REPLACE(Col7, '"', ''), 1),
    REPLACE(Col8, '"', ''),
    NULLIF(REPLACE(Col9, '"', ''), ''),
    REPLACE(Col10, '"', ''),
    REPLACE(Col11, '"', ''),
    REPLACE(Col12, '"', ''),
    REPLACE(Col13, '"', ''),
    REPLACE(Col14, '"', ''),
    LEFT(REPLACE(Col15, '"', ''), 1),
    LEFT(REPLACE(Col16, '"', ''), 1)
FROM RawPricePaidData
WHERE Col1 IS NOT NULL;


------Cheking for cleaned 


SELECT COUNT(*) AS Rows2022
FROM PricePaidData
WHERE YEAR(TransferDate) = 2022;

------Inspecting rows

SELECT TOP 20 *
FROM PricePaidData
WHERE YEAR(TransferDate) = 2022
ORDER BY TransferDate;



-------checking for columns which have NULL values
SELECT
  COUNT(*) AS TotalRows,
  COUNT(*) - COUNT(TransactionID) AS MissingTransactionID,
  COUNT(*) - COUNT(Price) AS MissingPrice,
  COUNT(*) - COUNT(TransferDate) AS MissingTransferDate,
  COUNT(*) - COUNT(Postcode) AS MissingPostcode,
  COUNT(*) - COUNT(PropertyType) AS MissingPropertyType,
  COUNT(*) - COUNT(Tenure) AS MissingTenure,
  COUNT(*) - COUNT(BuyerType) AS MissingBuyerType
FROM PricePaidData
WHERE YEAR(TransferDate) = 2022;

--------Importing raw 2023

TRUNCATE TABLE RawPricePaidData;

BULK INSERT RawPricePaidData
FROM 'C:\Users\ASUS\Desktop\STUDIES\Sem  02\SQL\ASSG\Datasets\pp-2023.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2,
    TABLOCK
);

----Cleaning

INSERT INTO PricePaidData (
    TransactionID, Price, TransferDate, Postcode, PropertyType, NewBuild, Tenure,
    PAON, SAON, Street, Locality, Town, District, County, Category, BuyerType
)
SELECT
    REPLACE(Col1, '"', ''),
    TRY_CAST(REPLACE(REPLACE(Col2, ',', ''), '£', '') AS BIGINT),
    TRY_CAST(REPLACE(Col3, '"', '') AS DATE),
    LEFT(REPLACE(Col4, '"', ''), 10),
    LEFT(REPLACE(Col5, '"', ''), 1),
    LEFT(REPLACE(Col6, '"', ''), 1),
    LEFT(REPLACE(Col7, '"', ''), 1),
    REPLACE(Col8, '"', ''),
    NULLIF(REPLACE(Col9, '"', ''), ''),
    REPLACE(Col10, '"', ''),
    REPLACE(Col11, '"', ''),
    REPLACE(Col12, '"', ''),
    REPLACE(Col13, '"', ''),
    REPLACE(Col14, '"', ''),
    LEFT(REPLACE(Col15, '"', ''), 1),
    LEFT(REPLACE(Col16, '"', ''), 1)
FROM RawPricePaidData
WHERE Col1 IS NOT NULL;


------Cheking for cleaned 


SELECT COUNT(*) AS Rows2023
FROM PricePaidData
WHERE YEAR(TransferDate) = 2023;

------Inspecting rows

SELECT TOP 20 *
FROM PricePaidData
WHERE YEAR(TransferDate) = 2023
ORDER BY TransferDate;



-------checking for columns which have NULL values
SELECT
  COUNT(*) AS TotalRows,
  COUNT(*) - COUNT(TransactionID) AS MissingTransactionID,
  COUNT(*) - COUNT(Price) AS MissingPrice,
  COUNT(*) - COUNT(TransferDate) AS MissingTransferDate,
  COUNT(*) - COUNT(Postcode) AS MissingPostcode,
  COUNT(*) - COUNT(PropertyType) AS MissingPropertyType,
  COUNT(*) - COUNT(Tenure) AS MissingTenure,
  COUNT(*) - COUNT(BuyerType) AS MissingBuyerType
FROM PricePaidData
WHERE YEAR(TransferDate) = 2023;

----Importing raw 2024
--cleaning staging table
TRUNCATE TABLE RawPricePaidData;


----Importing raw 2024

BULK INSERT RawPricePaidData
FROM 'C:\Users\ASUS\Desktop\STUDIES\Sem  02\SQL\ASSG\Datasets\pp-2024.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2,
    TABLOCK
);



----Cleaning

INSERT INTO PricePaidData (
    TransactionID, Price, TransferDate, Postcode, PropertyType, NewBuild, Tenure,
    PAON, SAON, Street, Locality, Town, District, County, Category, BuyerType
)
SELECT
    REPLACE(Col1, '"', ''),
    TRY_CAST(REPLACE(REPLACE(Col2, ',', ''), '£', '') AS BIGINT),
    TRY_CAST(REPLACE(Col3, '"', '') AS DATE),
    LEFT(REPLACE(Col4, '"', ''), 10),
    LEFT(REPLACE(Col5, '"', ''), 1),
    LEFT(REPLACE(Col6, '"', ''), 1),
    LEFT(REPLACE(Col7, '"', ''), 1),
    REPLACE(Col8, '"', ''),
    NULLIF(REPLACE(Col9, '"', ''), ''),
    REPLACE(Col10, '"', ''),
    REPLACE(Col11, '"', ''),
    REPLACE(Col12, '"', ''),
    REPLACE(Col13, '"', ''),
    REPLACE(Col14, '"', ''),
    LEFT(REPLACE(Col15, '"', ''), 1),
    LEFT(REPLACE(Col16, '"', ''), 1)
FROM RawPricePaidData
WHERE Col1 IS NOT NULL;


------Cheking for cleaned 


SELECT COUNT(*) AS Rows2024
FROM PricePaidData
WHERE YEAR(TransferDate) = 2024;

------cheking for columns that have nll values
SELECT
  COUNT(*) AS TotalRows,
  COUNT(*) - COUNT(TransactionID) AS MissingTransactionID,
  COUNT(*) - COUNT(Price) AS MissingPrice,
  COUNT(*) - COUNT(TransferDate) AS MissingTransferDate,
  COUNT(*) - COUNT(Postcode) AS MissingPostcode,
  COUNT(*) - COUNT(PropertyType) AS MissingPropertyType,
  COUNT(*) - COUNT(Tenure) AS MissingTenure,
  COUNT(*) - COUNT(BuyerType) AS MissingBuyerType
FROM PricePaidData
WHERE YEAR(TransferDate) = 2024;



-------Checking row count 
SELECT
  YEAR(TransferDate) AS [Year],
  COUNT(*) AS [RowCount]
FROM PricePaidData
WHERE TransferDate IS NOT NULL
GROUP BY YEAR(TransferDate)
ORDER BY [Year];


-----checking for null postal code values

SELECT
  YEAR(TransferDate) AS Year,
  COUNT(*) AS MissingPostcodes
FROM PricePaidData
WHERE Postcode IS NULL
GROUP BY YEAR(TransferDate)
ORDER BY Year;





----------------------Landcashire Property Analysis----------------------------



------------This isolates just the rows where County = 'Lancashire':

DROP VIEW IF EXISTS LancashirePricePaid;
GO


CREATE VIEW LancashirePricePaid AS
SELECT *
FROM PricePaidData
WHERE County = 'Lancashire';



DROP VIEW IF EXISTS LancashirePricePaid;

CREATE VIEW LancashirePricePaid AS
SELECT *
FROM PricePaidData
WHERE County = 'Lancashire';


------completed the data prep phase of Task 01-four years of property transactions
-- cleaned, imported, and filtered into a dedicated Lancashire view



-----Average price by District

CREATE PROCEDURE sp_AvgPriceByDistrict
AS
BEGIN
  SELECT District, AVG(Price) AS AvgPrice
  FROM LancashirePricePaid
  GROUP BY District
  ORDER BY AvgPrice DESC;
END;


EXEC sp_AvgPriceByDistrict;



SELECT District, AVG(Price) AS AvgPrice
FROM LancashirePricePaid
GROUP BY District
ORDER BY AvgPrice DESC;


-----Year by year breakdown

SELECT
  District,
  YEAR(TransferDate) AS [Year],
  AVG(Price) AS AvgPrice
FROM LancashirePricePaid
GROUP BY District, YEAR(TransferDate)
ORDER BY District, [Year];







-------Reusable view
CREATE VIEW LancashireAvgPriceByDistrict AS
SELECT District, AVG(Price) AS AvgPrice
FROM LancashirePricePaid
GROUP BY District;



CREATE VIEW LancashireAvgPriceByDistrictYearly AS
SELECT
  District,
  YEAR(TransferDate) AS [Year],
  AVG(Price) AS AvgPrice
FROM LancashirePricePaid
GROUP BY District, YEAR(TransferDate);


--------Property Type Distribution 

SELECT
  PropertyType,
  COUNT(*) AS SalesCount,
  ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS Percentage
FROM LancashirePricePaid
GROUP BY PropertyType
ORDER BY SalesCount DESC;


----------View for Power BI

CREATE VIEW LancashirePropertyTypeDistribution AS
SELECT
  PropertyType,
  COUNT(*) AS SalesCount,
  ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS Percentage
FROM LancashirePricePaid
GROUP BY PropertyType;


------Property Type Distribution by Year


SELECT
  YEAR(TransferDate) AS [Year],
  PropertyType,
  COUNT(*) AS SalesCount,
  ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY YEAR(TransferDate)), 2) AS Percentage
FROM LancashirePricePaid
GROUP BY YEAR(TransferDate), PropertyType
ORDER BY [Year], SalesCount DESC;



-----View for Power BI

CREATE VIEW LancashirePropertyTypeByYear AS
SELECT
  YEAR(TransferDate) AS [Year],
  PropertyType,
  COUNT(*) AS SalesCount,
  ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY YEAR(TransferDate)), 2) AS Percentage
FROM LancashirePricePaid
GROUP BY YEAR(TransferDate), PropertyType;



-----------Monthly Sales Trends for Lancashire


SELECT
  FORMAT(TransferDate, 'yyyy-MM') AS [Month],
  COUNT(*) AS SalesVolume
FROM LancashirePricePaid
GROUP BY FORMAT(TransferDate, 'yyyy-MM')
ORDER BY [Month];


--------View for power BI

CREATE VIEW LancashireMonthlySalesTrend AS
SELECT
  FORMAT(TransferDate, 'yyyy-MM') AS [Month],
  COUNT(*) AS SalesVolume
FROM LancashirePricePaid
GROUP BY FORMAT(TransferDate, 'yyyy-MM');

----------Monthly Sales Volume by District
SELECT
  FORMAT(TransferDate, 'yyyy-MM') AS [Month],
  District,
  COUNT(*) AS SalesVolume
FROM LancashirePricePaid
GROUP BY FORMAT(TransferDate, 'yyyy-MM'), District
ORDER BY [Month], District;


-----------------View for power BI

CREATE VIEW LancashireMonthlySalesByDistrict AS
SELECT
  FORMAT(TransferDate, 'yyyy-MM') AS [Month],
  District,
  COUNT(*) AS SalesVolume
FROM LancashirePricePaid
GROUP BY FORMAT(TransferDate, 'yyyy-MM'), District;



----------Top 10 Most Expensive Sales


SELECT TOP 10
  District,
  PropertyType,
  Price
FROM LancashirePricePaid
ORDER BY Price DESC;


WITH RankedSales AS (
  SELECT District, PropertyType, Price, Year,
         ROW_NUMBER() OVER (ORDER BY Price DESC) AS Rank
  FROM LancashirePricePaid
)
SELECT *
FROM RankedSales
WHERE Rank <= 10
---------View for Power BI


CREATE VIEW LancashireTop10ExpensiveSales AS
SELECT TOP 10
  District,
  PropertyType,
  Price
FROM LancashirePricePaid
ORDER BY Price DESC;



--------Top 10 Most Expensive Sales by Year


SELECT *
FROM (
  SELECT
    District,
    PropertyType,
    Price,
    YEAR(TransferDate) AS [Year],
    ROW_NUMBER() OVER (PARTITION BY YEAR(TransferDate) ORDER BY Price DESC) AS Rank
  FROM LancashirePricePaid
) AS RankedSales
WHERE Rank <= 10
ORDER BY [Year], Price DESC;


----------View for Power BI

CREATE VIEW LancashireTop10ExpensiveSalesByYear AS
SELECT *
FROM (
  SELECT
    District,
    PropertyType,
    Price,
    YEAR(TransferDate) AS [Year],
    ROW_NUMBER() OVER (PARTITION BY YEAR(TransferDate) ORDER BY Price DESC) AS Rank
  FROM LancashirePricePaid
) AS RankedSales
WHERE Rank <= 10;



----- Ensuring Clean Fields for Slicers

---- adding Year directly in SQL:


ALTER VIEW LancashirePricePaid AS
SELECT *,
       YEAR(TransferDate) AS [Year]
FROM PricePaidData
WHERE County = 'Lancashire';


--------This makes it easier to use Year as a slicer in Power BI without extra transformation.


------Creating a Lookup Table 


----a. Districts

CREATE VIEW DistrictLookup AS
SELECT DISTINCT District
FROM LancashirePricePaid
WHERE District IS NOT NULL;


----b. Property Types


CREATE VIEW PropertyTypeLookup AS
SELECT DISTINCT PropertyType
FROM LancashirePricePaid
WHERE PropertyType IS NOT NULL;


---c. Years

CREATE VIEW YearLookup AS
SELECT DISTINCT YEAR(TransferDate) AS [Year]
FROM LancashirePricePaid;





-----Testing Filter Logic


SELECT *
FROM LancashirePricePaid
WHERE District = 'Preston'
  AND PropertyType = 'Detached'
  AND YEAR(TransferDate) = 2023;


SELECT DISTINCT District FROM LancashirePricePaid WHERE YEAR(TransferDate) = 2023;

SELECT DISTINCT PropertyType
FROM LancashirePricePaid
WHERE District = 'Preston'
  AND YEAR(TransferDate) = 2023;


  SELECT DISTINCT PropertyType
FROM LancashirePricePaid
WHERE District = 'Preston';


SELECT *
FROM LancashirePricePaid
WHERE District = 'Preston'
  AND PropertyType = 'D'
  AND YEAR(TransferDate) = 2023;

----Good to go


---------decoded property type column for readability

CREATE VIEW LancashirePricePaidReadable AS
SELECT 
  TransactionID,
  Price,
  TransferDate,
  Postcode,
  PropertyType,
  CASE PropertyType
    WHEN 'D' THEN 'Detached'
    WHEN 'S' THEN 'Semi-Detached'
    WHEN 'T' THEN 'Terraced'
    WHEN 'F' THEN 'Flat'
    WHEN 'O' THEN 'Other'
    ELSE 'Unknown'
  END AS PropertyTypeFull,
  NewBuild,
  Tenure,
  PAON,
  SAON,
  Street,
  Locality,
  District,
  County,
  Category
FROM LancashirePricePaid;





